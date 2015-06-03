###
# Configure accounts-related stuff
###
Accounts.ui.config
  requestPermissions: {}
  extraSignupFields: [
    {
      # will be saved into user.profile and use for display
      fieldName: 'name'
      fieldLabel: 'Name'
      inputType: 'text'
      visible: true
      validate: (value, throwError) ->
        valid = value and value.length > 1

        throwError 'Enter your name' unless valid

        return valid
    }
  ]

###
# Defaults
###
accountsUIBootstrap3.setCustomSignupOptions = ->
  return {
    starred: []
    stories: []
  }
