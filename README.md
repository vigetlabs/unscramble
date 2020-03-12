Unscramble
========

We're gonna write a program that can unscramble a word. Inspired by the "Jumble" puzzle in the newspaper, the program should accept a single, scrambled word and return a matching entry from the English dictionary.

    > ./unscramble cofer
    force
    > ./unscramble sasewe
    seesaw
    
Basic guidelines:

1. A scrambled or jumbled word has only one valid answer.
2. Use the contents of `/usr/share/dict/words` as a dictionary.

Bonus points:

1. Make it fast (try testing longer words, for example).
2. Complete the exercise using a programming language that is new to you.

To start:

1. Clone this repository.
2. Create a directory based on the name of your implementation language (e.g. `languages/C`)
3. Create a simple `Rakefile` that has, at a minimum, a `build` task within your language's namespace (e.g. `C:build`).  You should check the environment and fail fast if dependencies aren't met.
4. Create your implementation and run `rake` from the project root.

### Example Rakefile

```ruby
namespace :C do
  task :check do
    `which cc`
    raise "Please ensure that you have a valid C compiler" unless $?.success?
  end

  task :build => :check do
    path = File.dirname(__FILE__)
    `cd #{path}; make unscramble`
  end
end
```

