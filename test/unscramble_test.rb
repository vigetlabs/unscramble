require 'minitest/autorun'

class UnscrambleTest < MiniTest::Test
  JUMBLES = {
    'tmorcpue'  => ['computer'],
    'crootd'    => ['doctor'],
    'salos'     => ['lasso', 'ossal'],
    'gfroo'     => ['forgo'],
    'cluen'     => ['uncle'],
    'rubwor'    => ['burrow'],
    'ittcek'    => ['ticket'],
    'nitmyu'    => ['mutiny', 'munity'],
    'cuthh'     => ['hutch'],
    'rptiem'    => ['permit'],
    'fryrul'    => ['flurry']
  }

  JUMBLES.each do |input, allowed_values|
    define_method "test_#{input}_unscrambles_to_#{allowed_values.first}" do
      output  = `#{ENV["LANGUAGE_PATH"]}/unscramble #{input}`.strip
      message = "Expected '#{input}' to equal '#{allowed_values.first}' or another allowed value"

      assert(allowed_values.include?(output), message)
    end
  end
end
