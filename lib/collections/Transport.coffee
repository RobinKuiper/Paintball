@Transport = new Mongo.Collection 'transports'

if Meteor.isServer
  if Transport.find().count() == 0
    transports = [
      { type: 'Car', price: '8.50', seats: 5, full: false }
      { type: 'OV', price: '14.20' }
      { type: 'OV Student', price: '0' }
      ( type: 'Fiets/Lopens', price: '0' )
    ]

    transports.forEach (transport) ->
      Transport.insert transport
