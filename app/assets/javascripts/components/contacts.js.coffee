@Contacts = React.createClass
  getInitialState: ->
    contacts: @props.data
  getDefaultProps: ->
    contacts: []
  addContacts: (new_contacts)->
    contacts = @state.contacts.slice()
    contacts = contacts.concat new_contacts
    @setState contacts: contacts
  deleteContact: (contact)->
    contacts = @state.contacts.slice()
    index = contacts.indexOf contact
    contacts.splice index, 1
    @replaceState contacts: contacts
  render: ->
    React.DOM.div
      className: 'contacts'
      React.DOM.h2
        className: 'title'
        'Contacts'
      React.createElement UploadForm, handleNewContacts: @addContacts
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'First Name'
            React.DOM.th null, 'Last Name'
            React.DOM.th null, 'Email'
            React.DOM.th null, 'Phone Number'
            React.DOM.th null, 'Company Name'
            React.DOM.th null, 'Delete'
        React.DOM.tbody null,
          for contact in @state.contacts
            React.createElement Contact,
              key: contact.id,
              contact: contact,
              handleDeleteContact: @deleteContact