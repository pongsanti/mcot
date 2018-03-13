require 'dotenv/load'
require 'logger'
logger = Logger.new(STDOUT)

require_relative './load_path'

require 'db/db'
require 'ocr_processor/ocr_processor'
require 'post/post'

def post(t)
  p = Post.new(t.normalized, t.file)
  p.post
end

def normalize(ocr)
  p = OcrProcessor.new(ocr)
  p.normalize
end

def update_flag(t)
  t.post = true
  t.save
end

while true
  T.not_posted.all.each do |t|
    logger.info("Processing #{t.file} with value #{t.ocr}")
    # process ocr
    t.normalized = normalize(t.ocr) unless t.normalized
    logger.info("Normalized at #{t.normalized}")
    # post request
    result = post(t)
    logger.info("Post result: #{result}")
    # update flag
    update_flag(t) if result
    logger.info('-----')
  end
  sleep 5
end

