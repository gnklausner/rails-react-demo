require 'rails_helper'

RSpec.describe ContactsController do
  describe '#Create' do
    let(:file) { fixture_file_upload('/data.csv', 'text/csv') }
    let(:broken_file) { fixture_file_upload('/broken.csv', 'text/csv') }
    
    it 'should upload contacts from a csv.' do
      expect {
        post :create, :contacts => file
      }.to change(Contact, :count).by 200
      expect(response.status).to eq 200
    end

    it 'should return a 422 from a broken csv.' do
      expect {
        post :create, :contacts => broken_file
      }.to change(Contact, :count).by 0
      expect(response.status).to eq 422
    end

    it 'should normalize phone numbers.' do
      if Contact.all.size < 200
        post :create, :contacts => file
        expect(response.status).to eq 200
      end
      
      Contact.all.each do |contact|
        normalized_phone_number = ContactsHelper.normalize_phone_number(contact.phone_number)
        expect(contact.phone_number).to eq normalized_phone_number
      end
    end
  end
end