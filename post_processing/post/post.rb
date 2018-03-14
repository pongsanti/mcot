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
    crop_filepath = String.new(filepath).insert(filepath.index('.'), '_c')

    begin
      RestClient.post(URL,
        article: { text: @value,
                   file: File.new(filepath, 'rb'),
                   crop_file: File.new(crop_filepath, 'rb') }
      )
    rescue StandardError => err
      puts err
      success = false
    end
    success
  end
end
