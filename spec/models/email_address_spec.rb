require 'spec_helper'

describe EmailAddress do
	let(:email_address_for_person) {EmailAddress.new(address: 'abc@abc.com', contact_id: 1, contact_type: 'Person')}
	let(:email_address_for_company) {EmailAddress.new(address: 'afsef@abc.com', contact_id: 2, contact_type: 'Company')}

	it 'is valid' do
		expect(email_address_for_person).to be_valid
	end

	it {should validate_presence_of(:address)}
	it {should validate_presence_of(:contact_id)}
	it {should validate_presence_of(:contact_type)}
	
	it 'is associated with a person' do
  		expect(email_address_for_person).to respond_to(:contact)
  	end

  	it 'is associated with a company' do
    	expect(email_address_for_company).to respond_to(:contact)
	end
end
