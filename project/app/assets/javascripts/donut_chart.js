const c3 = require('c3');

function showDonutChart(trip, user_owes_summary) {
    let chart = c3.generate({
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

    function updateChart(trip) {
        let columns = [];
        if (!Array.isArray(trip)) {
            return;
        }
        trip.forEach(function(user) {
            let userSummary = user_owes_summary[user.id];
            if (userSummary && userSummary.total_spent > 0) {
                columns.push([user.email, userSummary.total_spent]);
            }
        });
        console.log('Columns:', columns);
        chart.load({
            columns: columns
        });
    }

    updateChart(trip);

    const showExpensesButton = document.getElementById("show-expenses");
    if (showExpensesButton) {
        showExpensesButton.addEventListener("click", function() {
            updateChart(trip);
        });
    }
}

module.exports = { showDonutChart };