Meteor.methods
  updateTransport: (person, transport) ->
    if transport == 'Car'
      carCount = Person.find({ transport: 'Car' }).count()
      if carCount < 5
        if carCount == 4
          Transport.update { type: transport }, { $set: full: true }
        else
          Transport.update { type: transport }, { $set: full: false }
        Person.update { name: person }, { $set: transport: transport }
    else
      Person.update { name: person }, { $set: transport: transport }

  updateBullets: (person) ->
    Person.update { name: person }, ( $inc: bullets: 1 )

  updateDate: (name, timestamp) ->
    if timestamp == null
      Person.update { name: name }, { $unset: date: '' }
    else
      date = new Date(timestamp)
      day = date.getDate()
      month = date.getMonth()
      date = day + ' ' + months[month]
      Person.update { name: name }, { $set: date: date }

months = [
  'January'
  'Februari'
  'Maart'
  'April'
  'Mei'
  'Juni'
  'July'
  'Augustus'
  'September'
  'October'
  'November'
  'December'
]