Template.registerHelper 'getUsername', (userId) ->
  Meteor.users.findOne(userId).username

Template.registerHelper 'getTransportPrice', (transport) ->
  if transport = Transport.findOne { type: transport }
    if transport.type == 'Car'
      persons = Person.find({ transport: transport.type }).count()
      return (transport.price / persons).toFixed(2)
    return transport.price