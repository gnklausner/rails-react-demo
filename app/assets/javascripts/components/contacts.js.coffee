@Contacts = React.createClass
  getInitialState: ->
    contacts: @props.data
    contacts_copy: @props.data
    sort_ascending_map:
      'first_name': true
      'last_name': true
      'email_address': true
      'phone_number': true
      'company_name': true

  getDefaultProps: ->
    contacts: []

  addContacts: (new_contacts)->
    contacts = React.addons.update(@state.contacts, { $push: new_contacts })
    @setState contacts: contacts

  deleteContact: (contact)->
    index = @state.contacts.indexOf contact
    contacts = React.addons.update(@state.contacts, { $splice: [[index, 1]] })
    @setState contacts: contacts

  sortContacts: (sort_attribute)->
    sort_multiplier = if @state.sort_ascending_map[sort_attribute] then 1 else -1
    contacts = @state.contacts.sort (a,b)->
      if a[sort_attribute] < b[sort_attribute]
        return -1 * sort_multiplier
      else if a[sort_attribute] > b[sort_attribute]
        return 1 * sort_multiplier
      else
        return 0
    @state.sort_ascending_map[sort_attribute] = !@state.sort_ascending_map[sort_attribute]
    @setState contacts: contacts

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
            React.DOM.th
              onClick:
                ()=> @sortContacts('first_name')
              className: 'selectable'
              'First Name'
            React.DOM.th
              onClick:
                ()=> @sortContacts('last_name')
              className: 'selectable'
              'Last Name'
            React.DOM.th
              onClick:
                ()=> @sortContacts('email_address')
              className: 'selectable'
              'Email Address'
            React.DOM.th
              onClick:
                ()=> @sortContacts('phone_number')
              className: 'selectable'
              'Phone Number'
            React.DOM.th
              onClick:
                ()=> @sortContacts('company_name')
              className: 'selectable'
              'Company Name'
            React.DOM.th null,
              'Delete'
        React.DOM.tbody null,
          for contact in @state.contacts
            React.createElement Contact,
              key: contact.id,
              contact: contact,
              handleDeleteContact: @deleteContact