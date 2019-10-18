require 'minitest/autorun'

class UnscrambleTest < MiniTest::Test
  JUMBLES = {
    'tmorcpue'  => 'computer',
    'crootd'    => 'doctor',
    'salos'     => 'lasso',
    'gfroo'     => 'forgo',
    'cluen'     => 'uncle',
    'rubwor'    => 'burrow',
    'ittcek'    => 'ticket',
    'cuthh'     => 'hutch',
    'rptiem'    => 'permit',
    'fryrul'    => 'flurry',
    'ot'        => 'to',
    'hye'       => 'hey',
    'ebdt'      => 'debt'
  }

  JUMBLES.each do |input, output|
    define_method "test_#{input}_unscrambles_to_#{output}" do
      assert_equal output, `#{ENV["LANGUAGE_PATH"]}/unscramble #{input}`.strip
    end
  end
end
