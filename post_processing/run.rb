require 'dotenv/load'
require 'logger'
LOG = Logger.new(STDOUT)

require_relative './load_path'

require 'db/db'
require 'ocr_processor/ocr_processor'
require 'ocr_processor/group_processor'
require 'post/post'

def logger
  LOG
end

def post(t)
  p = Post.new(t.normalized, t.file)
  p.post
end

def normalize(ocr)
  p = OcrProcessor.new(ocr)
  p.normalize
end

def update_flag(gid)
  T.gid_posted(gid)
end

def process_group(gid)
  ts = T.by_gid(gid).all
  g = GroupProcessor.new(ts)

  posted = ocr_process(g.process)
  logger.info("Post result: #{posted}")
  # update flag
  update_flag(gid) if posted
  logger.info('-----')
end

def ocr_process(t)
  logger.info("Processing #{t.file} with value #{t.ocr}")
  # process ocr
  t.normalized = normalize(t.ocr) unless t.normalized
  logger.info("Normalized value: #{t.normalized}")
  # post request
  post(t)
end

loop do
  T.gid_not_posted.all.each do |t|
    logger.info("Processing group #{t.gid}")
    process_group(t.gid)
  end
  sleep 5
end
