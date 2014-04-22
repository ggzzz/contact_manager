require 'spec_helper'

describe EmailAddress do
	let(:email_address) {EmailAddress.new(address: 'abc@abc.com', person_id: 1)}

	it 'is valid' do
		expect(email_address).to be_valid
	end

	it {should validate_presence_of(:address)}
	it {should validate_presence_of(:person_id)}
end
