//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;


class WebRequestDelegate extends Ui.BehaviorDelegate {
    var notify;

    // Handle menu button press
    function onMenu() {
        makeRequest();
        return true;
    }

    function onSelect() {
        makeRequest();
        return true;
    }

    function makeRequest() {
        var app = App.getApp();
        
        var password = app.getProperty("password_prop");
        var username = app.getProperty("username_prop");
        notify.invoke("Executing\nRequest");

        Comm.makeWebRequest(
            "https://httpbin.org/get",
            {
                "password" => password,
                "username" => username
            },
            {
                "Content-Type" => Comm.REQUEST_CONTENT_TYPE_URL_ENCODED
            },
            method(:onReceive)
        );
    }

    // Set up the callback to the view
    function initialize(handler) {
        Ui.BehaviorDelegate.initialize();
        notify = handler;
    }

    // Receive the data from the web request
    function onReceive(responseCode, data) {
        if (responseCode == 200) {
            notify.invoke(data["args"]);
        } else {
            notify.invoke("Failed to load\nError: " + responseCode.toString());
        }
    }
}