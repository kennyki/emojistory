Meteor.startup ->
  return unless Categories.find().count() is 0

  console.log 'Initiating default categories'

  defaultCategories = [
    {
      title: 'Adventure'
      description: """
        An adventure story is about a protagonist who journeys to epic or distant places to accomplish something.
      """
    }
    {
      title: 'Comedy'
      description: """
        Comedy is a story that tells about a series of funny or comical events, intended to make the audience laugh.
      """
    }
    {
      title: 'Crime'
      description: """
        A crime story is about a crime that is being committed or was committed. It can also be an account of a criminal's life.
      """
    }
    {
      title: 'Fantasy'
      description: """
        A fantasy story is about magic or supernatural forces.
      """
    }
    {
      title: 'Historical'
      description: """
        A story about a real person or event taken place in the real world.
      """
    }
    {
      title: 'Historical fiction'
      description: """
        In literature, historical fiction is a text depicted as based on real historical figures, and actual events, which are woven together with fictitious elements.
      """
    }
    {
      title: 'Horror'
      description: """
        A horror story is told to deliberately scare or frighten the audience, through suspense, violence or shock.
      """
    }
    {
      title: 'Mystery'
      description: """
        Although normally associated with the crime genre, mystery fiction is considered a completely different genre in certain circumstances where the focus is on supernatural mystery (even if no crime is involved).
      """
    }
    {
      title: 'Philosophical'
      description: """
        Story in which a significant proportion of the work is devoted to a discussion of the sort of questions normally addressed in discursive philosophy.
      """
    }
    {
      title: 'Political'
      description: """
        Political fiction is a subgenre of fiction that deals with political affairs. Political fiction has often used narrative to provide commentary on political events, systems and theories.
      """
    }
    {
      title: 'Romance'
      description: """
        Traditionally, a romance story involves chivalry, adventure and love.
      """
    }
    {
      title: 'Science fiction'
      description: """
        Science fiction is similar to fantasy, except stories in this genre use scientific understanding to explain the universe that it takes place in.
      """
    }
    {
      title: 'Slice of Life'
      description: """
        A Slice of Life is a story that might have no plot, but represents a portion of (everyday) life.
      """
    }

  ]

  defaultCategories.forEach (category) ->
    Categories.insert category
