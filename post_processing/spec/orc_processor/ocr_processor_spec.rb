require 'ocr_processor/ocr_processor'

describe OcrProcessor do
  def test(input, out)
    op = OcrProcessor.new(input)

    expect(op.normalize).to eq(out)
  end

  it('normalize ocr') { test('SET 1,798.79 V1.53', 'SET 1,798.79 -1.53') }
  it('normalize ocr') { test('SET 1,798.79 A1.53', 'SET 1,798.79 +1.53') }
  it('normalize ocr') { test('SET 1,798.79 +153', 'SET 1,798.79 +1.53') }
  it('normalize ocr') { test('SET50 1,189.74 V0.92', 'SET50 1,189.74 -0.92') }
  it('normalize ocr') { test('SET50 1,001.96 A128', 'SET50 1,001.96 +1.28') }
end
