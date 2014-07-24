# https://github.com/stympy/faker


require 'faker'
describe 'faker api' do
  it "generates a name" do
    expect(Faker::Name.name).to match(/\w+\s\w+/)
  end
  it "generates a number" do
    expect(Faker::Number.number(4)).to match(/\d{4}/)
  end
end
