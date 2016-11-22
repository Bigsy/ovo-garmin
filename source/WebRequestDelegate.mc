//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.System;


class WebRequestDelegate extends Ui.BehaviorDelegate {
    var notify;

    // Handle menu button press
    function onMenu() {
        makeRequest1();
       // makeRequest();
        
        return true;
    }

    function onSelect() {
        makeRequest();
        makeRequest1();
        return true;
    }

    function makeRequest() {
        var app = App.getApp();
        
        var password = app.getProperty("password_prop");
        var username = app.getProperty("username_prop");
        notify.invoke("Executing\nRequest");
        
    	//const SERVER_URL = "https://my.ovoenergy.com";
 
        System.println(username +" "+password);

        Comm.makeWebRequest(
            "https://my.ovoenergy.com/api/auth/login",
            {
                "password" => password,
                "username" => username
            },
            {
                :method => Comm.HTTP_REQUEST_METHOD_POST,
        		:headers => {
        			"Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON
        		} 
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
                    System.println("login" + data);
            notify.invoke(data);
        } else {
                            System.println(data);
            notify.invoke("Failed to load\nError: " + responseCode.toString());
        }
    }
    
    
    function makeRequest1() {
        var app = App.getApp();
        
        var password = app.getProperty("password_prop");
        var username = app.getProperty("username_prop");
        notify.invoke("Executing\nRequest");
        
    	//const SERVER_URL = "https://my.ovoenergy.com";
 
        System.println(username +" "+password);

        Comm.makeWebRequest(
            "https://my.ovoenergy.com/api/auth/user",
            {},
            {
        		:headers => {
        			"Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON,
        			"Authorization" => "Y2JjMGMxOWMtOTFlZi00YzUxLWJiZWMtMjJmZDc0MWVlZWY5"
        		} 
            },
            method(:onReceive1)
        );
    }
    
        function onReceive1(responseCode, data) {
        if (responseCode == 200) {
                    System.println("user"+data);
            notify.invoke(data["args"]);
        } else {
                            System.println(data);
            notify.invoke("Failed to load\nError: " + responseCode.toString());
        }
    }
    
    
}