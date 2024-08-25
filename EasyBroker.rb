require 'httparty'

class EasyBrokerAPI
  # Access to HTTParty module
  include HTTParty
  base_uri 'https://api.stagingeb.com/v1'

  # Class attributes
  attr_accessor :header

  # Class constructor
  def initialize(api_key)
    # Set the API key
    @header = { "X-Authorization" => api_key }
  end

  # @brief Gets all the information inside the /properties 
  # directory
  def get_properties
    options = { headers: @header }
    self.class.get('/properties', options)
  end

  # @brief If request is successful, prints the title of 
  # every property otherwise, prints an error message,
  # along with the error code.
  def print_properties
    # Request properties
    request = get_properties
    
    # Verify whether the request was successful or not
    if request.success?
      properties = request['content']
      
      # Create an output file
      file = File.open("./outputs/req_output.txt", "w")
      
      # For each property, print their 'title' attribute
      properties.each do |property|
        # Insert the properties titles in the output file
        file.puts(property['title'])
      end 
      # Close the actual output file
      file.close()
      
      # Open again the output file, this time in read
      # mode
      file = File.open("./outputs/req_output.txt", "r")
      
      # Print the output file
      puts file.read()
      
      # Close the actual output file
      file.close()
    else
      # Create an output file
      file = File.open("./outputs/req_output.txt", "w")
      file.puts("Error while obtaining properties, code: #{request.code}") # Write the error message
      file.close() # Close the output file

      # Read the output file
      file = File.open("./outputs/req_output.txt", "r")
      puts file.read()  # Print the output
      file.close()  # Close file
    end
  end
end
