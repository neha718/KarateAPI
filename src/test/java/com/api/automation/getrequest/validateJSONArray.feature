Feature: To Validate GET endpoint
  To validate the GET endpoint response

  Background: Set up base URL
    Given url baseUrl

  Scenario: To get the data in JSON format and validate JSON array
    Given path 'normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response.[0].jobId == 1
    And match response.[0].experience[1] == 'Apple'
    And match response.[0].project[0].technology[2] == 'Gradle'
    And match response.[0].project[0].projectName == 'Movie App'
    
    # Validate size of the array
    And match response.[0].experience == '#[3]'
    
    # Using wildcard to validate the value of the array
    And match response.[0].experience[*] == ['Google', 'Apple', 'Mobile Iron']
    
    # Contains keyword where order does not matter
    And match response.[0].experience[*] contains ['Apple', 'Google']
    And match response.[*].jobId contains 1
    And match response[0].experience == '#[]'
    
    # Data type string, and length is more than 2
    And match response[0].experience == '#[] #string? _.length > 2'




