Feature: To execute the javascript function

Background:Create and initialize the base URL
Given url 'http://localhost:9897'

Scenario: Execute java script function with and without parameter.
* def getIntValue = function() {return 10;}
Then print "funaction value is: ", getIntValue()
* def getRandomValue = function() {return Math.floor((100)*Math.random());}
Then print "random value is: ", getRandomValue()
* def getStringValue = function(arg) {return "Hello" + arg;}
Then print "string value==>", getStringValue(" Karate")


Scenario: To create  job entry in json format with embedded expression
Given path '/normal/webapi/add'
* def getJobId = function() {return Math.floor((100)*Math.random());}
#embedded exp should be in single quotes for json.
And request {"jobId":'#(getJobId())',"jobTitle":"Software Engg - 3","jobDescription":"To develop andriod application","experience":["Google","Apple","Mobile Iron","PWC"],"project":[{"projectName":"Movie App","technology":["Kotlin","SQL Lite","Gradle"]}]}
And headers {Accept: 'application/json', Content-Type: 'application/json'}
When method post
Then status 201
And print response
And match response.jobTitle == 'Software Engg - 3'

Scenario: To create  job entry in xml format with embedded expression
Given path '/normal/webapi/add'
* def getJobId = function() {return Math.floor((100)*Math.random());}
* def jobId = getJobId()
#embedded exp not should be in single quotes for json.
And request <item><jobId>#(jobId)</jobId><jobTitle>Software Engg 4</jobTitle><jobDescription>To develop andriod application</jobDescription><experience><experience>Google</experience><experience>Apple</experience><experience>Marlabs</experience></experience><project><project><projectName>Movie App</projectName><technology><technology>Kotlin</technology><technology>SQL Lite</technology><technology>Gradle</technology></technology></project></project></item>
And headers {Accept: 'application/json', Content-Type: 'application/xml'}
When method post
Then status 201
And print response
And match response.jobId == '#(jobId)'