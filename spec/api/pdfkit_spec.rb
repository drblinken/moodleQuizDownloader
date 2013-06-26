#
# rspec to test usage of pdfkit in this script
#
# installation
# gem 'pdfkit'
# brew install wkhtmltopdf
# don't just install the gem, this didn't work as described in
# https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF
# https://github.com/pdfkit/pdfkit/wiki/
# http://code.google.com/p/wkhtmltopdf/
# https://github.com/pdfkit/pdfkit
require 'pdfkit'
describe 'pdfkit api' do
  it "should convert a html page to pdf" do
     html = '<body>Hallu</body>'
     kit = PDFKit.new(html)
#     >> k.to_file('simple.pdf')
     pdf = kit.to_pdf
     pdf.should match /^%PDF-/
   end
end