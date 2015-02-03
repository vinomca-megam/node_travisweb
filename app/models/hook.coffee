require 'models/model'

config = ENV.config

Model = Travis.Model

Hook = Model.extend
  name:        DS.attr()
  ownerName:   DS.attr()
  description: DS.attr()
  active:      DS.attr('boolean')
  admin:       DS.attr('boolean')
  private:     DS.attr('boolean')

  account: (->
    @get('slug').split('/')[0]
  ).property('slug')

  slug: (->
    "#{@get('ownerName')}/#{@get('name')}"
  ).property('ownerName', 'name')

  urlGithub: (->
    "#{config.source_endpoint}/#{@get('slug')}"
  ).property()

  urlGithubAdmin: (->
    "#{config.source_endpoint}/#{@get('slug')}/settings/hooks#travis_minibucket"
  ).property()

  toggle: ->
    return if @get('isSaving')
    @set 'active', !@get('active')
    @save()

Travis.Hook = Hook