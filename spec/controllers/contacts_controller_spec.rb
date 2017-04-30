require 'rails_helper'

RSpec.describe ContactsController do
  describe '#create' do
    let(:file) { fixture_file_upload('/data.csv', 'text/csv') }
    let(:broken_file) { fixture_file_upload('/broken.csv', 'text/csv') }
    
    it 'should upload contacts from a csv.' do
      expect(Contact.all.size).to eq 0
      post :create, :contacts => { :csv => file }
      expect(response.status).to eq 200
      expect(Contact.all.size).to eq 200
    end

    it 'should return a 422 from a broken csv.' do
      contact_count = Contact.all.size
      post :create, :contacts => { :csv => broken_file }
      expect(Contact.all.size).to eq contact_count
      expect(response.status).to eq 422
    end

    it 'should normalize phone numbers.' do
      if Contact.all.size < 200
        post :create, :contacts => { :csv => file }
        expect(response.status).to eq 200
      end
      
      Contact.all.each do |contact|
        normalized_phone_number = ContactsHelper.normalize_phone_number(contact.phone_number)
        expect(contact.phone_number).to eq normalized_phone_number
      end
    end
  end
end