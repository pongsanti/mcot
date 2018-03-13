require 'ocr_processor/ocr_processor'

describe OcrProcessor do
  it 'normalize ocr' do
    op = OcrProcessor.new('SET 1,798.79 V1.53')

    expect(op.normalize).to eq('SET 1,798.79 -1.53')
  end
end
