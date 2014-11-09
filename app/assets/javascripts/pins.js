$(document).ready(function() {
    $("#scope").multiselect({
        position: {
            my: 'bottom',
            at: 'center'
        },
        noneSelectedText: 'General Options'
    });

    $("#surgeon").multiselect({
        position: {
            my: 'bottom',
            at: 'center'
        },
        noneSelectedText: 'Select Surgeon(s)'
    });

    $("#procedure").multiselect({
        position: {
            my: 'bottom',
            at: 'center'
        },
        noneSelectedText: 'Select Procedure(s)'
    });
    $('.label-with-popover').popover();
});