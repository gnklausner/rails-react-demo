describe ContactsHelper do
  describe '#NormalizePhoneNumber' do
    it 'normalizes phone numbers' do
      input_phone_numbers = [
        '1-207-643-1816',
        '1-207-643-1816 x555',
        '+1 (207) 643-1816',
        '207-643-1816',
        '(207) 643-1816',
        '(785)822-0500 x7524',
        '177.192.3362',
        '177.192.3362x1337',
      ]
      output_phone_numbers = [
        '1-207-643-1816',
        '1-207-643-1816x555',
        '1-207-643-1816',
        '1-207-643-1816',
        '1-207-643-1816',
        '1-785-822-0500x7524',
        '1-177-192-3362',
        '1-177-192-3362x1337',
      ]
      for i in (0..(input_phone_numbers.size-1))
        output = ContactsHelper.normalize_phone_number(input_phone_numbers[i])
        expect(output).to eq output_phone_numbers[i]
      end
    end
  end
end