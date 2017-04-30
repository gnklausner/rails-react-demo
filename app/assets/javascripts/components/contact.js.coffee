@Contact = React.createClass
  handleDelete: (e)->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/contacts/#{ @props.contact.id }"
      dataType: 'JSON'
      success: ()=>
        @props.handleDeleteContact @props.contact
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.contact.first_name
      React.DOM.td null, @props.contact.last_name
      React.DOM.td null, @props.contact.email_address
      React.DOM.td null, @props.contact.phone_number
      React.DOM.td null, @props.contact.company_name
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'