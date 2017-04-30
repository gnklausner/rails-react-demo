@Contacts = React.createClass
  getInitialState: ->
    contacts: @props.data
  getDefaultProps: ->
    contacts: []
  render: ->
    React.DOM.div
      className: 'contacts'
      React.DOM.h2
        className: 'title'
        'Contacts'
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'First Name'
            React.DOM.th null, 'Last Name'
            React.DOM.th null, 'Email'
            React.DOM.th null, 'Phone Number'
            React.DOM.th null, 'Company Name'
        React.DOM.tbody null,
          for contact in @state.contacts
            React.createElement Contact, key: contact.id, contact: contact