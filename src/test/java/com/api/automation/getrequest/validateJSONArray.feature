Feature: To Validate AGET enpoint 
To validate the GET endpoint response

Background: Set up base URL
Given url 'http://localhost:9897'

Scenario: To get the data in JSON format and validate JSON array
Given path 'normal/webapi/all'
And header Accept = 'application/json'
When method get
Then status 200
And match response.[0].jobId == 1
And match response.[0].experience[1] == 'Apple'
And match response.[0].project[0].technology[2] == 'Gradle'
And match response.[0].project[0].projectName == 'Movie App'
#validate size of the array
And match response.[0].experience == '#[3]'
#using wildcard to validate the value of the array
And match response.[0].experience[*] == ['Google', 'Apple', 'Mobile Iron']
#contains key word where order do not matter
And match response.[0].experience[*] contains ['Apple','Google']
And match response.[*].jobId contains 1
And match response[0].experience == '#[]'
#data type string , and length is more than 2
And match response[0].experience == '#[] #string? _.length > 2'




