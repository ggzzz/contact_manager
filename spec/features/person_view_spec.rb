require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the person view', type: :feature do
	describe 'phone number' do 
		let(:person) {Person.create(first_name: 'John', last_name: 'Doe')}	

		before(:each) do
			person.phone_numbers.create(number: "555-1234")
			person.phone_numbers.create(number: "555-5678")
			visit person_path(person)
		end

		it 'shows the phone numbers' do
			person.phone_numbers.each do |phone|
				expect(page).to have_content(phone.number)
			end
		end

		it 'has a link to add a new phone number' do
			expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
		end

		it 'has links to edit phone numbers' do
			person.phone_numbers.each do |phone|
				expect(page).to have_link('Edit', href: edit_phone_number_path(phone))
			end
		end

		it 'has links to delete the phone numbers' do
			person.phone_numbers.each do |phone|
				expect(page).to have_link('Destroy', href: phone_number_path(phone))
			end
		end	

		it 'adds a new phone number' do
			page.click_link('Add phone number')
			page.fill_in('Number', with: '555-8888')
			page.click_button('Create Phone number')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('555-8888')
		end

		it 'edits a phone number' do
			phone = person.phone_numbers.first
			old_number = phone.number

			first(:link, 'Edit').click
			page.fill_in('Number', with: '555-9191')
			page.click_button('Update Phone number')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('555-9191')
			expect(page).to_not have_content(old_number)
		end

		it 'destroy a phone number' do
			phone = person.phone_numbers.first
			old_number = phone.number

			first(:link, 'Destroy').click
			expect(current_path).to eq(person_path(person))
			expect(page).not_to have_content(old_number)
		end
	end

	describe 'email address' do 
		let(:person) {Person.create(first_name: 'bob', last_name: 'john')}

		before(:each) do
			person.email_addresses.create(address: "joj@abc.com")
			person.email_addresses.create(address: "joej@abc.com")
			visit person_path(person)
		end

		it 'shows the email addresses' do
			person.email_addresses.each do |email_address|
				expect(page).to have_selector('li', text: email_address.address)
			end
		end

		it 'has an add email address link' do
			expect(page).to have_link('Add email address', href: new_email_address_path(person_id: person.id))
		end

		it 'has links to edit email addresses' do
			person.email_addresses.each do |email_address|
				expect(page).to have_link('Edit', href: edit_email_address_path(email_address))
			end
		end

		it 'has links to delete the phone numbers' do
			person.email_addresses.each do |email_address|
				expect(page).to have_link('Destroy', href: email_address_path(email_address))
			end
		end		

		it 'adds a new email address' do
			page.click_link('Add email address')
			page.fill_in('Address', with: 'wjefojwe@abc.com')
			page.click_button('Create Email address')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('wjefojwe@abc.com')
		end

		it 'edits a email address' do
			email_address = person.email_addresses.first
			old_address = email_address.address

			first(:link, 'Edit').click
			page.fill_in('Address', with: 'jwoefj@abc.com')
			page.click_button('Update Email address')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('jwoefj@abc.com')
			expect(page).to_not have_content(old_address)
		end

		it 'destroy a phone number' do
			email_address = person.email_addresses.first
			old_address = email_address.address

			first(:link, 'Destroy').click
			expect(current_path).to eq(person_path(person))
			expect(page).not_to have_content(old_address)
		end
	end
end