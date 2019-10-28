CREATE TABLE nodes (
   id SERIAL PRIMARY KEY,
   letter CHAR (1) NOT NULL,
   word VARCHAR (100),
   parent_node_id INTEGER
);

CREATE INDEX parent_node_index ON nodes (parent_node_id);

CREATE FUNCTION alphaSort (TEXT) RETURNS TEXT AS $$
  SELECT string_agg(c, '') as s
    FROM (
      SELECT unnest(regexp_split_to_array($1, '')) as c
        ORDER BY c
      )
    AS t;
$$ LANGUAGE SQL IMMUTABLE;

CREATE FUNCTION unscramble (VARCHAR) RETURNS VARCHAR AS $$
  DECLARE
    input ALIAS FOR $1;
    output VARCHAR = '';

    index INTEGER = 1;
    currentLetter VARCHAR;
    parentNodeId INTEGER;

  BEGIN
    -- Sort input thanks to magic function above
    SELECT alphaSort(input)
      INTO input;
    currentLetter = substring(input, index, 1);

    -- Loop through letters, descending down node tree
    WHILE char_length(currentLetter) = 1 LOOP
      IF parentNodeId IS NULL THEN
        SELECT id
          INTO parentNodeId
          FROM nodes
          WHERE letter = currentLetter
          AND parent_node_id IS NULL;
      ELSE
        SELECT id
          INTO parentNodeId
          FROM nodes
          WHERE letter = currentLetter
          AND parent_node_id = parentNodeId;
      END IF;

      index = index + 1;
      currentLetter = substring(input, index, 1);
    END LOOP;

    -- Find word based on last letter node found
    SELECT word
      INTO output
      FROM nodes
      WHERE id = parentNodeId;

    RETURN output;
  END;
  $$ LANGUAGE plpgsql;

CREATE FUNCTION findOrCreate (CHAR, INTEGER) RETURNS INTEGER AS $$
  DECLARE
    inputLetter ALIAS FOR $1;
    inputId     ALIAS FOR $2;

    outputId INTEGER;
  BEGIN
    IF inputId IS NULL THEN
      SELECT id
        INTO outputId
        FROM nodes
        WHERE
          letter = $1 AND
          parent_node_id IS NULL;
    ELSE
      SELECT id
        INTO outputId
        FROM nodes
        WHERE
          letter = $1 AND
          parent_node_id = $2;
    END IF;

    IF outputId IS NULL THEN
      INSERT INTO nodes (letter, parent_node_id)
        VALUES (inputLetter, inputId)
        RETURNING id INTO outputId;
    END IF;

    RETURN outputId;
  END;
  $$ LANGUAGE plpgsql;
