Feature: To Validate AGET enpoint 
To validate the GET endpoint response

Background: Set up base URL
Given url 'http://localhost:9897'

Scenario: validate JSON using fuzzy matcher
Given path 'normal/webapi/all'
And header Accept = 'application/json'
When method get
Then status 200
And match response.[0].jobId == '#present'
And match response.[0].experience[1] == '#notnull'
And match response.[0].project[0].technology == '#array'
And match response.[0].project[0].projectName == '#ignore'
And match response[0].jobTitle == '#string'
And match response.[0].jobId == '#number'
#complex fuzzy matcher where _ is self variable.
And match response.[0].jobId == '#? _ >= 1'
#job title should be string and length should be greater than or equal to 1
And match response.[0].jobTitle == '#string? _.length >= 1'


