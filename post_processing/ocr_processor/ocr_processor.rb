#
class OcrProcessor
  def initialize(ocr)
    @ocr = ocr
  end

  def normalize
    res = @ocr.strip
    res = res.sub('V', '-')
    res = res.sub('A', '+')
    
    #get the last path
    arr = res.split
    if arr.length == 3
      arr[2] = normalize_last_part(arr[2])
    end

    res = arr.join(' ')
  end

  def normalize_last_part(num)
    unless num.include? '.'
      num = num.insert(-3, '.')
    end
    num
  end
end
