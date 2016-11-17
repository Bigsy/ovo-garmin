using Toybox.WatchUi as Ui;

using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class ovoView extends Ui.View {
    hidden var mMessage = "Press menu button";

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        var app = App.getApp();
        
        var password = app.getProperty("password_prop");
        var username = app.getProperty("username_prop");
       

        if(null==password)
        {
            password="Not set";
        }        
                
        View.onUpdate(dc);
        
        
        dc.setColor(Gfx.COLOR_BLACK, -1);
        //dc.clear();        
        
        //dc.drawText(3, 120, Gfx.FONT_SMALL, "Password: " + password, Gfx.TEXT_JUSTIFY_LEFT);
        //dc.drawText(3, 138, Gfx.FONT_SMALL, "Username: " + username, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(40, 120, Gfx.FONT_SMALL, "" + mMessage, Gfx.TEXT_JUSTIFY_LEFT);
        
        
        
        
    }

    function onHide() {
    }
    
    function onReceive(args) {
        if (args instanceof Lang.String) {
            mMessage = args;
        }
        else if (args instanceof Dictionary) {
            // Print the arguments duplicated and returned by httpbin.org
            var keys = args.keys();
            mMessage = "";
            for( var i = 0; i < keys.size(); i++ ) {
                mMessage += Lang.format("$1$: $2$\n", [keys[i], args[keys[i]]]);
            }
        }
        Ui.requestUpdate();
    }

}
