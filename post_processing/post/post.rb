require 'rest_client'
require 'file/file_op'
# Post multipart form data
class Post
  URL = ENV['POST_URL']
  
  def initialize(value, filename)
    @value = value
    @file_op = FileOp.new(filename)
  end

  def post
    success = true

    begin
      RestClient.post(URL,
        article: { text: @value,
                   file: File.new(@file_op.path, 'rb'),
                   crop_file: File.new(@file_op.crop_path, 'rb') }
      )
    rescue StandardError => err
      puts err
      success = false
    end
    success
  end
end
