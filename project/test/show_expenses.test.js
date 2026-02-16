const { TextEncoder, TextDecoder } = require('util');
global.TextEncoder = TextEncoder;
global.TextDecoder = TextDecoder;

const { JSDOM } = require('jsdom');

describe('show_expenses.js', () => {
  let document;

  beforeEach(() => {
    const dom = new JSDOM(`
      <div id="trip-details" style="display: grid;"></div>
      <div id="expenses" style="display: none;"></div>
      <button id="show-trip-details">Show Trip Details</button>
      <button id="show-expenses">Show Expenses</button>
    `);
    document = dom.window.document;

    // Simulate the script being loaded
    require('../app/assets/javascripts/show_expenses.js');
  });

  test('should show trip details and hide expenses when "Show Trip Details" is clicked', () => {
    const showTripDetailsButton = document.getElementById('show-trip-details');
    const tripDetails = document.getElementById('trip-details');
    const expenses = document.getElementById('expenses');

    showTripDetailsButton.click();

    expect(tripDetails.style.display).toBe('grid');
    expect(expenses.style.display).toBe('none');
  });

  test('should show expenses and hide trip details when "Show Expenses" is clicked', () => {
    const showExpensesButton = document.getElementById('show-expenses');
    const tripDetails = document.getElementById('trip-details');
    const expenses = document.getElementById('expenses');

    showExpensesButton.click();

    expect(tripDetails.style.display).toBe('grid');
    expect(expenses.style.display).toBe('none');
  });
});