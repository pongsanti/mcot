require 'dotenv/load'
require_relative './load_path'
require 'db/db'
require 'ocr_processor/ocr_processor'
require 'post/post'

def post(t)
  p = Post.new(t.ocr,'2018-03-13t20:24:10.jpg')
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
    puts t.values

    # process ocr
    normalized = normalize(t.ocr)
    
    # post request
    result = post(t)
    update_flag(t) if result
    # update flag
  end
  sleep 5
end

