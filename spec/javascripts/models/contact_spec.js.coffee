describe 'App.Contact', ->
  beforeEach ->
    @store = App.__container__.lookup('store:main')
    Ember.run =>
      @contact = @store.createRecord("Contact")

  describe 'lastSeen', ->
    describe 'with no connections', ->
      it 'is equal to createdAt', ->
        Ember.run =>
          expect(@contact.get("lastSeen"))
            .toBe(@contact.get("createdAt"))

    describe 'with connections', ->
      it 'is equal to latest connection', ->
        Ember.run =>
          connection_date = new Date(2014, 9, 6)

          @store.createRecord('connection', {
            date: new Date(2014, 9, 5 , 23), contact: @contact })
          @store.createRecord('connection',
              { date: connection_date, contact: @contact } )

          expect(@contact.get("lastSeen"))
            .toBe(connection_date)

  describe 'sortedConnections', ->
    it 'returns connections in date order (newest first)', ->
        Ember.run =>
          connection_date = new Date(2014, 9, 6)

          newer = @store.createRecord('connection', {
            date: new Date(2014, 9, 6, 23), contact: @contact })
          older = @store.createRecord('connection', {
            date: new Date(2014, 9, 5, 23), contact: @contact })
          oldest = @store.createRecord('connection', {
            date: new Date(2014, 9, 3, 23), contact: @contact })

          expect(@contact.get("sortedConnections")[0])
            .toBe(newer)
          expect(@contact.get("sortedConnections")[2])
            .toBe(oldest)


  describe 'isValid', ->
    it 'returns true if the contact\'s name has characters', ->
      Ember.run =>
        @contact.set('name', 'a valid name')
        expect(@contact.isValid()).toBeTruthy()

    it 'returns false if the contact\'s name is an empty string', ->
      Ember.run =>
        @contact.set('name', '')
        expect(@contact.isValid()).toBeFalsy()

    it 'returns false if the contact\'s name consists of whitespace', ->
      Ember.run =>
        @contact.set('name', '    ')
        expect(@contact.isValid()).toBeFalsy()

    it 'returns false if the contact\'s name is undefined', ->
      Ember.run =>
        @contact.set('name', undefined)
        expect(@contact.isValid()).toBeFalsy()
