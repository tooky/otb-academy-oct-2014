Feature: Scanning an item in a basket

  Scenario: Cashier scans an item with a barcode
    Given a known item
    When the cashier scans the item
    Then the item should be added to the total

  Scenario: Cashier scans an item that we don't sell
    Given an unknown item
    When the cashier scans the item
    Then the cashier should be notified that the item is not recognised
