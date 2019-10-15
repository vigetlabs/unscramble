require 'minitest/autorun'

class UnscrambleTest < MiniTest::Test
  JUMBLES = {
    'ot'      => 'to',
    'hye'     => 'hey',
    'ebdt'    => 'debt',
    # note: these should pass too, but take longer to run
    # 'salos'   => 'lasso',
    # 'cluen'   => 'uncle',
    # 'fryrul'  => 'flurry'
  }

  JUMBLES.each do |input, output|
    define_method "test_#{input}_unscrambles_to_#{output}" do
      assert_equal output, `#{ENV["LANGUAGE_PATH"]}/unscramble #{input}`.strip
    end
  end
end
