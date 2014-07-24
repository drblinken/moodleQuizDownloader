# Encoding: utf-8
require 'asciify'
describe "using asciify" do
  it "converts umlaute" do
     map = Asciify::Mapping.new(:default)
    expect("ÄÖÜßäöü".asciify(map)).to eq("AeOeUessaeoeue")
  end
end
