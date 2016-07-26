Feature: Posts Pagination
  Background:
    Given a number of posts already exist
  Scenario: user can navigate view the next page of posts
    Given that a user has visited the index page
    When they click the Next button
    Then they should be able to see the next 20 posts by default
  Scenario: user can navigate view the previous page of posts
    Given that a user has visited page 2 of the posts on the index page
    When they click the Previous button
    Then they should be able to see the previous 20 posts by default

