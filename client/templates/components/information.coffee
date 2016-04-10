price = 31.99
personCount = 10

Template.information.helpers
  price: -> price
  personCount: -> personCount
  pprice: -> (price / personCount).toFixed(2)