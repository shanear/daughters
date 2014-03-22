App.ContactIndexController = Ember.ObjectController.extend
  newConnection: { occurredAt: new Date(), note: "" }

  actions:
    addConnection: ()->
      return if !@get('newConnection.note')

      newConnection = @store.createRecord('connection',
        @get('newConnection'))
      newConnection.set('contact', @get('model'))

      newConnection.save().then =>
        @set('newConnection.occurredAt', new Date())
        @set('newConnection.note', "")

    changeImage: (url)->
      @set('model.pictureUrl', url)
