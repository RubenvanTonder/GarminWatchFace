import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.Time.Gregorian;

class BasicWatchFaceView extends WatchUi.WatchFace {
    hidden var hrValue;

    function initialize() {
        WatchFace.initialize();
        hrValue=0.0f;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get the current time and format it correctly
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setText(timeString);

        // Get the current battery percentage and format it correctly
        var systemStat = System.getSystemStats();
        var batteryString = systemStat.battery.format("%d") + "%";
        var viewBattery = View.findDrawableById("Battery") as Text;
        viewBattery.setText(batteryString);

        var value = View.findDrawableById("heartRate") as Text;
        value.setText(hrValue.format("%.2f"));

        //Get Day of the week
        var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var dayOfWeek = View.findDrawableById("DayOfWeek") as Text;
        dayOfWeek.setText(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][date.day_of_week - 1]);
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    //Calculate the HR data to display in the field here
    function compute(info){
        if (info has :currentHeartRate){
            if (info.currentHeartRate != null){
                hrValue = info.currentHeartRate;
            }else{
                hrValue = 0f;
            }
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
