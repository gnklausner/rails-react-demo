@Contact = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.contact.first_name
      React.DOM.td null, @props.contact.last_name
      React.DOM.td null, @props.contact.email_address
      React.DOM.td null, @props.contact.phone_number
      React.DOM.td null, @props.contact.company_name