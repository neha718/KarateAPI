Feature: To test the GET endpoint of the application
  To test different GET endpoints with different data format supported by the application

  Background: Create and initialize the base URL
    Given url baseUrl + '/normal/webapi/all'

  Scenario: To test the GET endpoint with JSON data
    When method get
    Then status 200
    And print 'GET request successful'







