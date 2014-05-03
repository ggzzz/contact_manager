require 'spec_helper'

describe PhoneNumber do
  let(:phone_number_for_person) {PhoneNumber.new(number: '329423478', contact_id: 1, contact_type: 'Person')}
  let(:phone_number_for_company) {PhoneNumber.new(number: '32942354358', contact_id: 2, contact_type: 'Company')}

  it 'is valid' do
  	expect(phone_number_for_person).to be_valid
  end

  it 'is invalid without a number' do
  	phone_number_for_person.number = nil
  	expect(phone_number_for_person).not_to be_valid
  end

  it 'must have a reference to person' do
  	phone_number_for_person.contact_id = nil
  	expect(phone_number_for_person).not_to be_valid
  end

  it 'is associated with a person' do
  	expect(phone_number_for_person).to respond_to(:contact)
  end

  it 'is associated with a company' do
    expect(phone_number_for_company).to respond_to(:contact)
  end
end
