require 'rest_client'
# Post multipart form data
class Post
  URL = ENV['POST_URL']
  FILE_PATH = ENV['FILE_PATH']

  def initialize(value, filename)
    @value = value
    @filename = filename
  end

  def post
    success = true
    filepath = "#{FILE_PATH}/#{@filename}"
    begin
      RestClient.post(URL, file: File.new(filepath, 'rb'))
    rescue RestClient::ExceptionWithResponse => err
      puts err
      success = false
    end
    success
  end
end
