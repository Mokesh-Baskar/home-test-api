
Feature: Basic Api test
Background:
  * url 'http://localhost:3100/api'

Scenario: Fetching all the menu items
  Given path '/inventory'
  When method get
  Then status 200
  And assert response.length >= 9
  And match each response contains { "id": '#any', "name": '#any', "price": '#any', "image": '#any' }

Scenario: Fetch the item by id
  Given path '/api/inventory/filter'
  And param id = 3
  When method get
  Then status 200
  And match response contains { "id": '3', "price": '#string', "image": '#string',"name": 'Baked Rolls x 8' }

Scenario: Post a new item with new id
  Given path '/inventory/add'
  And request { "id": '10', "name" : 'Hawaiian', "image" : 'hawaiian.png', "price" : '$14' }
  When method post
  Then status 200

Scenario: try to add with exitsing id
  Given path '/inventory/add'
  And request { id: '10', name: 'Hawaiian', image: 'hawaiian.png', price: '$14' }
  When method post
  Then status 400

Scenario: Missing data validation
  Given path '/inventory/add'
  And request { name: '', image: 'noid.png', price: '$10' }
  When method post
  Then status 400
  And match response.message == 'Not all requirements are met'

Scenario: To verify newly added item is present
  Given path '/inventory'
  When method get
  Then status 200
  And match response contains { id: '10', name: 'Hawaiian', image: 'hawaiian.png', price: '$14' }