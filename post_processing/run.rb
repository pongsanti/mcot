require 'dotenv/load'
require_relative './load_path'
require 'db/db'
require 'ocr_processor/ocr_processor'
require 'post/post'

def post(t)
  p = Post.new(t.normalized,'2018-03-13t21:19:18.jpg')
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
    # process ocr
    t.normalized = normalize(t.ocr) unless t.normalized
    puts t.values
    # post request
    result = post(t)
    # update flag
    update_flag(t) if result
  end
  sleep 5
end

