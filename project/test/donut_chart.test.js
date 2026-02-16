const { TextEncoder, TextDecoder } = require('util');
global.TextEncoder = TextEncoder;
global.TextDecoder = TextDecoder;

const c3 = require('c3');

const { JSDOM } = require('jsdom');

// Mock the c3.generate function before importing the function to test
jest.mock('c3', () => ({
    generate: jest.fn(() => ({
        load: jest.fn()
    }))
}));

const { showDonutChart } = require('../app/assets/javascripts/donut_chart');

describe('showDonutChart', () => {
    let dom;

    beforeEach(() => {
        // Set up a DOM environment
        dom = new JSDOM(`
            <!DOCTYPE html>
            <html>
                <body>
                    <div id="donut-chart"></div>
                    <div id="trip-nav">
                        <a id="show-trip-details" class="nav-item">Show Trip Details</a>
                        <a id="show-expenses" class="nav-item">Show Expenses</a>
                    </div>
                </body>
            </html>
        `);
        global.document = dom.window.document;
        global.window = dom.window;
    });

    afterEach(() => {
        // Clean up the DOM environment
        dom.window.close();
        jest.clearAllMocks();
    });

    it('should generate a donut chart with the correct configuration', () => {
        const trip = [
            { id: 1, email: 'user1@example.com' },
            { id: 2, email: 'user2@example.com' }
        ];
        const user_owes_summary = {
            1: { total_spent: 100 },
            2: { total_spent: 200 }
        };

        showDonutChart(trip, user_owes_summary);

        expect(c3.generate).toHaveBeenCalledWith({
            bindto: '#donut-chart',
            data: {
                columns: [],
                type: "donut",
            },
            donut: {
                title: "$ Spent",
            },
            legend: {
                position: 'bottom'
            },
            size: {
                height: 650,
                width: 650
            },
            tooltip: {
                show: false
            }
        });

        const chartInstance = c3.generate.mock.results[0].value;
        expect(chartInstance.load).toHaveBeenCalledWith({
            columns: [
                ['user1@example.com', 100],
                ['user2@example.com', 200]
            ]
        });
    });

    it('should update the chart when the show-expenses button is clicked', () => {
        const trip = [
            { id: 1, email: 'user1@example.com' },
            { id: 2, email: 'user2@example.com' }
        ];
        const user_owes_summary = {
            1: { total_spent: 100 },
            2: { total_spent: 200 }
        };

        showDonutChart(trip, user_owes_summary);

        const chartInstance = c3.generate.mock.results[0].value;
        expect(chartInstance.load).toHaveBeenCalledWith({
            columns: [
                ['user1@example.com', 100],
                ['user2@example.com', 200]
            ]
        });
    });
});