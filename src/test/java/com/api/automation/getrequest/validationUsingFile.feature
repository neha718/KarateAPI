Feature: To Validate AGET enpoint 
To validate the GET endpoint response

Background: Set up base URL
Given url 'http://localhost:9897'

Scenario: To eget the data in JSON format and validate from file
Given path 'normal/webapi/all'
And header Accept = 'application/json'
When method get
Then status 200
#create a variable to store the data from external file
* def actualResponse = read("../JsonResponse.json")
And match response == actualResponse
And print "response from the file is ==>", actualResponse

Scenario: To get the data in XML format and validate from XML file
Given path 'normal/webapi/all'
And header Accept = 'application/xml'
When method get
Then status 200
#create a variable to store the data from external file
* def actualResponse = read("../XMLResponse.xml")
And print "response from the xml file is ==>", actualResponse
And match response == actualResponse
