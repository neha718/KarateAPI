Feature: variable creation

#<Gherkin keyword> <def> <variable_name> = <value>
# * <def> <variable_name> = <value>
Background: Create variable using def keyword
* def app_name = 'Karate Framework new'
* def page_code_time = 10


Scenario: create a variable using def keyword
#for repeating value
#storing data from external file
#pass data to another scenario 

Given def var_int = 10
And def var_string = 'Karate Framework'
Then print "integer variable value is: ", var_int
And print "string variable value is: ", var_string
#define vaiable without using gherkin keyword
* def new_int_var = var_int + 20
And print "new integer variable value is: ", new_int_var
And print "background variable value is: ", app_name

Scenario: Access the varable
* def var_string = 'Karate Framework2'
Given print "Accessing the variable from another scenario: ", var_string
And print "background variable value is: ", page_code_time
