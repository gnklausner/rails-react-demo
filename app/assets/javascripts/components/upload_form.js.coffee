@UploadForm = React.createClass
  getInitialState: ->
    csv: null
  uploadFile: (e) ->
    fd = new FormData
    fd.append 'contacts', @refs.csv.files[0]
    $.ajax
      url: '/contacts'
      data: fd
      processData: false
      contentType: false
      type: 'POST'
      success: (data) =>
        @props.handleNewContacts data
        @setState @getInitialState()
        return
    e.preventDefault()
    return
  handleChange: ->
    @setState "csv": @refs.csv.files[0]
  valid: ->
    @state.csv
  render: ->
    React.DOM.form
      ref: 'uploadForm'
      className: 'form-inline'
      encType: 'multipart/form-data'
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          ref: 'csv'
          type: 'file'
          name: 'csv'
          className: 'form-control'
          onChange: @handleChange
        React.DOM.button
          type: 'button'
          ref: 'button'
          className: 'btn btn-primary'
          disabled: !@valid()
          onClick: @uploadFile
          'Upload'

# Thanks to mike123 for uploader idea
# http://stackoverflow.com/questions/28750489/upload-file-component-with-reactjs