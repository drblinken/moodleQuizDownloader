# Encoding: utf-8
require 'asciify'
describe "using asciify" do
  it "converts umlaute" do
     map = Asciify::Mapping.new(:default)
    "ÄÖÜßäöü".asciify(map).should == "AeOeUessaeoeue"
  end
end