require 'spec_helper'

describe Company do
  let(:company) {Company.new(name: 'ABC')}
  it 'is valid' do
  	expect(company).to be_valid
  end

  it {should validate_presence_of :name}

  it 'has an array of phone numbers' do
  	expect(company.phone_numbers).to eq([])
  end

  it "responds with its phone numbers after they're created" do
 	  phone_number = company.phone_numbers.build(number: "333-4444")
  	expect(phone_number.number).to eq('333-4444')
  end

  it 'responds with its created email addresses' do
    company.email_addresses.build(address: 'me@example.com')
    expect(company.email_addresses.map(&:address)).to eq(['me@example.com'])
  end  
end
