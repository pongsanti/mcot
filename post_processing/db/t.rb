# t model
class T < Sequel::Model
  set_primary_key :rowid

  class << self
    def sel
      select(:rowid, :file, :ocr, :normalized, :post)
    end

    def gid_not_posted
      select(:gid).group(:gid).having(post: 0).order(:rowid)
    end

    def by_gid(gid)
      sel.where(gid: gid).order(:rowid)
    end

    def gid_posted(gid)
      where(gid: gid).update(post: true)
    end
  end
end