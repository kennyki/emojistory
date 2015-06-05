# https://github.com/englue/meteor-publish-composite#examples
Meteor.publishComposite 'stories', (query, options) ->
  return {

    find: ->
      return Stories.find query or {}, options or {}

    children: [
      {
        find: (story) ->
          # return just 1 record
          # but it needs a cursor
          # so we're using find instead of findOne
          return Users.find
            _id: story.creator
          ,
            limit: 1
      }
      {
        find: (story) ->
          return Categories.find
            _id: story.category
          ,
            limit: 1
      }
    ]

  }