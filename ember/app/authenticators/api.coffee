`import Base from 'simple-auth/authenticators/base'`
`import Ember from 'ember'`

Promise = Ember.RSVP.Promise

ApiAuthenticator = Base.extend
  restore: (data)->
    Promise.resolve(data)

  authenticate: (options)->
    new Promise( (resolve, reject)=>
      login = Ember.$.post(
        EmberENV.apiURL + '/api/v2/authenticate',
        {
          email: options["email"],
          password: options["password"]
        }
      )

      login.fail (error)=>
        if(error.status != 401)
          Ember.run =>
            @set("apiConnection.online", false)
        reject(error)
      login.done (data)-> resolve(data["session"])
    )

  invalidate: (data)->
    new Promise( (resolve, reject)->
      logout = Ember.$.post(EmberENV.apiURL + '/api/v2/invalidate')

      localforage.clear()
      logout.fail -> resolve()
      logout.done -> resolve()
    )

`export default ApiAuthenticator`