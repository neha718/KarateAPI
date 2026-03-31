Feature: To create job entry in the application 
Use POST request to create job entry in the application and validate the response

Background:Create and initialize the base URL
Given url 'http://localhost:9897'

Scenario: To create  job entry in json format
Given path '/normal/webapi/add'
* def body = read('datapackage/JobEntry.json')
And request body
And headers {Accept: 'application/json', Content-Type: 'application/json'}
When method post
Then status 201
And print response
And match response.jobTitle == 'Software Engg - 19'

Scenario: To create  job entry in xml format
Given path '/normal/webapi/add'
* def body = read('datapackage/JobEntry.xml')
And request  body
And headers {Accept: 'application/xml', Content-Type: 'application/xml'}
When method post
Then status 201
And print response
And match response/Job/jobId == '20'