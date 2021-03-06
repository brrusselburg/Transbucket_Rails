$(document).ready(function() {
    $("#pin_sensation").rating({
        size: 'xs',
        step: 1,
        starCaptions: {
            1: "Very Poor",
            2: "Poor",
            3: "Ok",
            4: "Good",
            5: "Very Good"
        }
    });
    $("#pin_satisfaction").rating({
        size: 'xs',
        step: 1,
        starCaptions: {
            1: "Very Unsatisfied",
            2: "Unsatisfied",
            3: "Currently unsure",
            4: "Satisfied",
            5: "Very Satisfied"
        }
    });
});
