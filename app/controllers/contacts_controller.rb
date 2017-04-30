require 'csv'    

class ContactsController < ApplicationController
  include ContactsHelper

  def index
    @contacts = Contact.all
  end

  def create
    uploaded_io = contacts_csv
    File.open(Rails.root.join('public', 'uploads', 'contacts.csv'), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    csv_text = File.read(Rails.root.join('public', 'uploads', 'contacts.csv'))
    conversion_map = {
      'First Name' => 'first_name', 
      'Last Name' => 'last_name', 
      'Email Address' => 'email_address', 
      'Phone Number' => 'phone_number', 
      'Company Name' => 'company_name'
    }
    csv = CSV.parse(csv_text, :headers => true, header_converters: lambda { |header| conversion_map[header] })
    contacts_array = []
    begin
      csv.each do |row|
        row['phone_number'] = normalize_phone_number(row['phone_number'])
        contacts_array.push Contact.new(row.to_hash)
      end

      Contact.transaction do
        contacts_array.each(&:save!)
      end
      render :json => contacts_array
    rescue ActiveRecord::RecordInvalid, ActiveRecord::UnknownAttributeError => error
      render text: "#{error}", status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    head :no_content
  end

  private
    def contacts_csv
      params.require(:contacts)
    end
end
