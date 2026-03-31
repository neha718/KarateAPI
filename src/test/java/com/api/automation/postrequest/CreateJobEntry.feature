Feature: To create job entry in the application 
Use POST request to create job entry in the application and validate the response

Background:Create and initialize the base URL
Given url 'http://localhost:9897'

Scenario: To create  job entry in json format
Given path '/normal/webapi/add'
And request {"jobId":3,"jobTitle":"Software Engg - 3","jobDescription":"To develop andriod application","experience":["Google","Apple","Mobile Iron","PWC"],"project":[{"projectName":"Movie App","technology":["Kotlin","SQL Lite","Gradle"]}]}
And headers {Accept: 'application/json', Content-Type: 'application/json'}
When method post
Then status 201
And print response
And match response.jobTitle == 'Software Engg - 3'

Scenario: To create  job entry in xml format
Given path '/normal/webapi/add'
And request <item><jobId>4</jobId><jobTitle>Software Engg 4</jobTitle><jobDescription>To develop andriod application</jobDescription><experience><experience>Google</experience><experience>Apple</experience><experience>Marlabs</experience></experience><project><project><projectName>Movie App</projectName><technology><technology>Kotlin</technology><technology>SQL Lite</technology><technology>Gradle</technology></technology></project></project></item>
And headers {Accept: 'application/json', Content-Type: 'application/xml'}
When method post
Then status 201
And print response
And match response.jobId == 4