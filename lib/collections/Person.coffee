@Person = new Mongo.Collection 'persons'

if Meteor.isServer
  Person.update { name: 'Hakan' }, { $set: name: 'Onbekend' }
  if Person.find().count() == 0
    persons = ['Robin', 'Vahid', 'Mike', 'Hakan', 'Peter', 'Dennis', 'Cherissa', 'Richard', 'Thomas', 'Jordy']

    persons.forEach (person) ->
      Person.insert { name: person, payed: false, bullets: 0 }
