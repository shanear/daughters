`import Ember from 'ember'`

EventsEditController = Ember.ObjectController.extend
  isSaving: false
  programs: []
  errors: []
  selectedProgram: null
  newProgram: null
  newProgramName: ""

  programOptions: Ember.computed.sort 'programs', (a, b)->
    return 1 if(a.get('isNew') && !b.get('isNew'))
    return -1 if(b.get('isNew') && !a.get('isNew'))
    return 0

  saveProgram: ->
    @set('program', @get('selectedProgram'))

    if @get('selectedProgram.isNew')
      @set('selectedProgram.name', @get('newProgramName'))
      @get('selectedProgram').save()
    else
      Ember.RSVP.resolve()

  saveDisabled: Ember.computed 'model.isValid', 'selectedProgram', 'newProgramName', ->
    !@get('model.isValid') || (@get('selectedProgram.isNew') && !@get('newProgramName'))

  actions:
    saveEvent: ->
      @set('isSaving', true)

      saveEvent = @saveProgram().then => @get('model').save()
      saveEvent.then => @transitionToRoute('event', @get('model'))
      saveEvent.catch =>
        @set('isSaving', false)
        @set('errors', ["Something went wrong on the server, please try again later."])


`export default EventsEditController`

