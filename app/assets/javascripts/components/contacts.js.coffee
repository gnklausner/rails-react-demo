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
    filter_map:
      'first_name': ''
      'last_name': ''
      'email_address': ''
      'phone_number': ''
      'company_name': ''

  getDefaultProps: ->
    contacts: []

  addContacts: (new_contacts)->
    contacts = React.addons.update(@state.contacts, { $push: new_contacts })
    contacts_copy = React.addons.update(@state.contacts_copy, { $push: new_contacts })
    @setState
      contacts: contacts
      contacts_copy: contacts_copy

  deleteContact: (contact)->
    index = @state.contacts.indexOf contact
    contacts = React.addons.update(@state.contacts, { $splice: [[index, 1]] })
    index_copy = @state.contacts_copy.indexOf contact
    contacts_copy = React.addons.update(@state.contacts_copy, { $splice: [[index_copy, 1]] })
    @setState
      contacts: contacts
      contacts_copy: contacts_copy

  sortContacts: (sort_attribute)->
    sort_multiplier = if @state.sort_ascending_map[sort_attribute] then 1 else -1
    compare_function = (a,b)->
      if a[sort_attribute] < b[sort_attribute]
        return -1 * sort_multiplier
      else if a[sort_attribute] > b[sort_attribute]
        return 1 * sort_multiplier
      else
        return 0
    contacts = @state.contacts.sort compare_function
    contacts_copy = @state.contacts_copy.sort compare_function
    @state.sort_ascending_map[sort_attribute] = !@state.sort_ascending_map[sort_attribute]
    @setState
      contacts: contacts
      contacts_copy: contacts_copy

  filterContacts: (filter_attribute, filter_string)->
    @state.filter_map[filter_attribute] = filter_string
    filtered_contacts = @state.contacts_copy
    for attribute, filter of @state.filter_map
      filtered_contacts = filtered_contacts
        .filter (contact) -> contact[attribute].toLowerCase().includes(filter.toLowerCase())
    @setState contacts: filtered_contacts

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
              React.DOM.input
                ref: 'first_name_filter'
                type: 'text'
                name: 'first_name_filter'
                className: 'form-control'
                onChange: (e)=>
                  @filterContacts('first_name', e.target.value)
                onClick: (e) -> e.stopPropagation()
            React.DOM.th
              onClick:
                ()=> @sortContacts('last_name')
              className: 'selectable'
              'Last Name'
              React.DOM.input
                ref: 'last_name_filter'
                type: 'text'
                name: 'last_name_filter'
                className: 'form-control'
                onChange: (e)=>
                  @filterContacts('last_name', e.target.value)
                onClick: (e) -> e.stopPropagation()
            React.DOM.th
              onClick:
                ()=> @sortContacts('email_address')
              className: 'selectable'
              'Email Address'
              React.DOM.input
                ref: 'email_address_filter'
                type: 'text'
                name: 'email_address_filter'
                className: 'form-control'
                onChange: (e)=>
                  @filterContacts('email_address', e.target.value)
                onClick: (e) -> e.stopPropagation()
            React.DOM.th
              onClick:
                ()=> @sortContacts('phone_number')
              className: 'selectable'
              'Phone Number'
              React.DOM.input
                ref: 'phone_number_filter'
                type: 'text'
                name: 'phone_number_filter'
                className: 'form-control'
                onChange: (e)=>
                  @filterContacts('phone_number', e.target.value)
                onClick: (e) -> e.stopPropagation()
            React.DOM.th
              onClick:
                ()=> @sortContacts('company_name')
              className: 'selectable'
              'Company Name'
              React.DOM.input
                ref: 'company_name_filter'
                type: 'text'
                name: 'company_name_filter'
                className: 'form-control'
                onChange: (e)=>
                  @filterContacts('company_name', e.target.value)
                onClick: (e) -> e.stopPropagation()
            React.DOM.th null,
              'Delete'
        React.DOM.tbody null,
          for contact in @state.contacts
            React.createElement Contact,
              key: contact.id,
              contact: contact,
              handleDeleteContact: @deleteContact