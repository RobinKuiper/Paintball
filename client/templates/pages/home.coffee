price = 31.99
bulletprice = 15
personCount = new ReactiveVar 0
transport = new ReactiveVar()
datePickActivePerson = ''

Template.home.rendered = ->
  Meteor.setTimeout ->
    $('.datePicker').pickadate
      disable: [
        true
        { from: new Date(), to: [2016, 8, 18] }
      ]
      onSet: (result) ->
        Meteor.call 'updateDate', datePickActivePerson, result.select
  , 2000

Template.home.helpers
  unknown: (name) -> return if name == 'Onbekend' then 'red' else ''
  totalPrice: (person) ->
    person = Person.findOne { name: person }
    bullets = if isEven(person.bullets) then bulletprice else 0
    transportPrice = if !transport = Transport.findOne { type: person.transport } then 0 else
      if person.transport != 'Car' then parseInt(transport.price) else
        carCount = Person.find({ transport: 'Car' }).count()
        transport.price/carCount
    ((price/personCount.get())+bullets+transportPrice).toFixed(2)
  price: -> price
  personCount: -> personCount.get()
  persons: ->
    persons = Person.find {}
    personCount.set persons.count()
    return persons
  pprice: -> (price / personCount.get()).toFixed(2)
  transports: -> Transport.find {}
  setSelected: (person) ->
    $('.dropdown').dropdown()
    transport = Person.findOne({ name: person }).transport
    $('#'+person).dropdown('set selected', transport)
    return transport
  setChecked: (person) ->
    $('.toggle.checkbox').checkbox()
    if(p = Person.findOne { name: person })
      if isEven(p.bullets)
        $('#'+person+'Bullets').checkbox('set checked')


Template.home.events
  'click .datePicker': (e) ->
    datePickActivePerson = $(e.target).attr('id')
    console.log datePickActivePerson

  'click .dropdown .item': (e) ->
    transport = $(e.target).html()
    person = $(e.target).closest('tr').attr('id')

    Meteor.call 'updateTransport', person, transport
  'click .toggle.checkbox': (e) ->
    person = $(e.target).closest('tr').attr('id')
    Meteor.call 'updateBullets', person

isEven = (n) ->
  return n % 2 == 0