# https://github.com/stympy/faker


require 'faker'
describe 'faker api' do
  it "generates a name" do
    Faker::Name.name.should match(/\w+\s\w+/)
  end
  it "generates a number" do
    Faker::Number.number(4).should match(/\d{4}/)
  end
end
