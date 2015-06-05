# NOTE: assign to @ to make it available to others
@Stories = new Mongo.Collection 'stories'

Stories.allow(
  insert: (userId, story) ->
    # must be logged in 
    return userId
  update: (userId, story, fields, modifier) ->
    # can only update own story
    return userId is story.creator
  remove: (userId, story) ->
    # can only delete own story
    return userId is story.creator
)

SimpleSchema.messages
  invalidCategory: 'Invalid category [value]'

StorySchema = new SimpleSchema
  title:
    type: String
    min: 20
    max: 200
  body:
    type: String
    min: 100
  category:
    type: String
    custom: ->
      category = Categories.find @value
      return 'invalidCategory' unless category
  stars:
    type: Number
    min: 0
    defaultValue: 0
  created:
    type: Date
    denyUpdate: true
    autoValue: ->
      if @isInsert
        return new Date()
      else if @isUpsert
        return {
          $setOnInsert: new Date()
        }
      else
        return this.unset()
  modified:
    type: Date
    optional: true
    denyInsert: true
    autoValue: ->
      return new Date() if @isUpdate
  creator:
    type: String
    denyUpdate: true
    autoValue: ->
      if @isInsert
        return @userId
      else if @isUpsert
        return {
          $setOnInsert: @userId
        }
      else
        return this.unset()

Stories.attachSchema StorySchema