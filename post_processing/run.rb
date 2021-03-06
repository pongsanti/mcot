require 'dotenv/load'
require 'logger'
LOG = Logger.new(STDOUT)

require_relative './load_path'

require 'db/db'
DB.loggers << LOG

require 'ocr_processor/ocr_processor'
require 'ocr_processor/group_processor'
require 'post/post'
require 'file/file_op'

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

def update_flag(ts)
  ts.each do |t|
    t.post = 1
    t.save

    # delete other candidate files
    FileOp.new(t.file).delete unless t.normalized
  end
end

def process_group(gid)
  ts = T.by_gid(gid).all
  g = GroupProcessor.new(ts)

  posted = ocr_process(g.process)
  logger.info("Post result: #{posted}")
  # update flag
  update_flag(ts) if posted
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
  logger.info("waked up...")
  T.gid_not_posted_and_ready.all.each do |t|
    logger.info("Processing group #{t.gid}")
    process_group(t.gid)
  end
  sleep 5
end
