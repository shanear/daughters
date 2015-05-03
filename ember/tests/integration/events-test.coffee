`import Ember from "ember"`
`import startApp from '../helpers/start-app'`
`import PretendApi from '../helpers/pretend-api'`

module "Events page integration test",
  setup: ->
    @app = startApp()
    authenticateSession()

  teardown: ->
    Ember.run(@app, @app.destroy)

test "Navigation link takes you to the Events page", ->
  visit("/")
  click("#events-link")
  andThen ->
    equal(currentURL(), "/events",
      "Events tab directs to events page")

test "Add event from events page", ->
  visit("/events")
  click("#add-event")
  andThen ->
    equal(currentURL(), "/events/new",
      "Add event button directs to new event form")