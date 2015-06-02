Meteor.startup ->
  return unless Stories.find().count() is 0

  console.log 'Initiating default stories'

  defaultStories = [
    {
      title: 'Long long time ago'
      body: """
        It all started with a story :smile:
      """
      category: 'should be category id'
      likes: 10
      created: (new Date()).toJSON()
      creator: 'should be user id'
    }

  ]

  defaultStories.forEach (story) ->
    Stories.insert story
