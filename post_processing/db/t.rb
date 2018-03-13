# t model
class T < Sequel::Model
  set_primary_key :rowid

  class << self
    def sel
      select(:rowid, :file, :ocr, :normalized, :post)
    end

    def not_posted
      sel.where(post: 0).order(:rowid)
    end
  end
end