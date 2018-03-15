# file operation class
class FileOp
  FILE_PATH = ENV['FILE_PATH']

  def initialize(filename)
    @filename = filename
  end

  def path
    "#{FILE_PATH}/#{@filename}"
  end

  def crop_path
    String.new(path).insert(path.index('.'), '_c')
  end

  def delete
    File.delete(path)
    File.delete(crop_path)
  rescue StandardError => err
    puts err
    false
  end
end
