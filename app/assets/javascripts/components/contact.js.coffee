@Contact = React.createClass
  handleDelete: (e)->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/contacts/#{ @props.contact.id }"
      dataType: 'JSON'
      success: ()=>
        @props.handleDeleteContact @props.contact

  format_phone_number: (phone_number)->
    phone_number_with_extension = phone_number.split('x')
    split_phone_number = phone_number_with_extension[0].split('-')
    [country_code, area_code, prefix, line_number] = split_phone_number
    displayed_country_code = if country_code == '1' then '' else "+1 "
    phone_number_with_extension[0] = "#{displayed_country_code}(#{area_code}) #{prefix}-#{line_number}"
    phone_number_with_extension.join(' ext.')

  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.contact.first_name
      React.DOM.td null, @props.contact.last_name
      React.DOM.td null, @props.contact.email_address
      React.DOM.td null, @format_phone_number(@props.contact.phone_number)
      React.DOM.td null, @props.contact.company_name
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'