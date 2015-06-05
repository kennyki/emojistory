# adapted from http://stackoverflow.com/a/19392085/940030
Meteor.publish 'userData', (userId) ->
  return unless userId or @userId
  # we need more fields than the default
  return Users.find userId or @userId,
    fields:
      emails: 1
      profile: 1
      starred: 1
      stories: 1