module ContactsHelper
    def normalize_phone_number(phone_number)
      stripped_phone_number = phone_number.tr('+().\- ', '')
      split_phone_number = stripped_phone_number.split('x') # [phone_number, extension]
      if split_phone_number[0].length > 10
        split_phone_number[0].insert(-11, '-') # Split at the country code
      else
        split_phone_number[0] = '1-' + split_phone_number[0] # Add the country code, assuming US
      end
      split_phone_number[0].insert(-8, '-') # Split at area code
      split_phone_number[0].insert(-5, '-') # Split at prefix

      return split_phone_number.join('x') # Allow extension to be added onto end. Format: 1-222-333-4444x5555
    end

    module_function :normalize_phone_number
end
