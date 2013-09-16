$(document).ready(function () {

    //If a link is click with the data-track attribute call this code.
    $("a[data-track]").click(function () {

        //Get the track label which is stored in the data-track attribute.
        var trackLabel = $(this).data("track");

        //Track the event with the track label.
        _gaq.push(['_trackEvent', 'Download', trackLabel, $(this).attr("href")]);

    });

});