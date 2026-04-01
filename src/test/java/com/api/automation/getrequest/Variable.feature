Feature: Variable creation

  # <Gherkin keyword> <def> <variable_name> = <value>
  # * <def> <variable_name> = <value>

  Background: Create variable using def keyword
    * def app_name = 'Karate Framework'
    * def page_load_time = 10

  Scenario: Create a variable using def keyword
    # For repeating value
    # Storing data from external file
    # Pass data to another scenario
    
    Given def var_int = 10
    And def var_string = 'Karate Framework'
    Then print "Integer variable value is: ", var_int
    And print "String variable value is: ", var_string
    
    # Define variable without using gherkin keyword
    * def new_int_var = var_int + 20
    And print "New integer variable value is: ", new_int_var
    And print "Background variable value is: ", app_name

  Scenario: Access the variable
    * def var_string = 'Karate Framework v2'
    Given print "Accessing the variable from another scenario: ", var_string
    And print "Background variable value is: ", page_load_time
