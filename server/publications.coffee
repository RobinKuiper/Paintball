Meteor.publish 'persons', ->
  Person.find {}
Meteor.publish 'transports', ->
  Transport.find {}