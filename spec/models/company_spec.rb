require 'spec_helper'

describe Company do
  let(:company) {Company.new(name: 'ABC')}
  it 'is valid' do
  	expect(company).to be_valid
  end

  it {should validate_presence_of :name}
end
