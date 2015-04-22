# issue ss2014
# cmap table of format 10 not implemented

require 'mechanize'
require 'pdfkit'

PDFKit.configure do |config|
#  config.wkhtmltopdf = '/path/to/wkhtmltopdf'
#  config.default_options = {
#    :page_size => 'Legal',
#    :print_media_type => true
#  }
#  # Use only if your external hostname is unavailable on the server.
#  config.root_url = "http://localhost"
  config.verbose = true
end

describe 'exploring cmap table of format 10 not implemented' do
  before :context do
    @html_dir = File.join(File.dirname(__FILE__),'testfiles')
    @agent = Mechanize.new
  end
  it "works with i3" do
     page = @agent.get("file:///#{@html_dir}/notworkingimagesremoved.html")
     #page = @agent.get("file:///#{@html_dir}/working.html")
     kit = PDFKit.new(page.body)
#     >> k.to_file('simple.pdf')
     pdf = kit.to_pdf
#     kit.to_file('simple.pdf')
     expect(pdf).to match /^%PDF-/
   end
#   it "doesn't work with i2" do
#pending
#     page = @agent.get("file:///#{@html_dir}/notworking.html")
#     kit = PDFKit.new(page.body)
##     >> k.to_file('simple.pdf')
#     pdf = kit.to_pdf
#     expect(pdf).to match /^%PDF-/
#   end
end


#<img src="https://moodle.htw-berlin.de/pluginfile.php/95775/question/questiontext/26332/2/51804/images_Complexity-curves.png">
