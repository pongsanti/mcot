# t model
class T < Sequel::Model
  class << self
    def sel
      select(:rowid, :file, :ocr, :post)
    end

    def not_posted
      sel.where(post: 0).order(:rowid)
    end
  end
end