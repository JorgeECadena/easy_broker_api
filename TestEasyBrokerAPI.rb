require 'test/unit'
require_relative 'EasyBroker.rb'

# Unit testing for EasyBrokerAPI
class TestEasyBrokerAPI < Test::Unit::TestCase
  # Tests setup
  def setup
    @invalid_api = EasyBrokerAPI.new('invalid_api_key')
    @api = EasyBrokerAPI.new('l7u502p8v46ba3ppgvj5y2aad50lb9')
  end
  
  # Test 1: Error 401 when API key is invalid
  def test_invalid_api_key
    # Call the print properties method
    @invalid_api.print_properties

    # Read the @invalid_api and expected outputs
    real_output = File.read("./outputs/req_output.txt")
    expected_output = File.read("./tests/expected_api_key_error.txt")

    # Compare the contents
    assert_equal expected_output, real_output 
  end

  # Test 2: Print correctly all of the property titles
  # when request is valid
  def test_properties_titles
    # Call the print properties method
    @api.print_properties

    # Read the @api and expected outputs
    real_output = File.read("./outputs/req_output.txt")
    expected_output = File.read("./tests/expected_titles.txt")

    # Compare the contents
    assert_equal expected_output, real_output
  end
end
