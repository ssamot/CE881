# GPS and Threads

## Introduction

The aim of this lab is to gain experience with using a devices GPS
receiver to track a users movement over time.  We'll study a simple app
for location tracking, and look at how to:

-   Receive GPS updates
-   Write the current location to the screen
-   Update a file with location estimates
-   Convert the data to the XML-based KML format
-   Write a simple custom view for displaying a route
-   Handle a zoom gesture to zoom in on the route

There are also some exercises that deal with panning the view, and
also to calculate some statistics for the route.

Concluding the lab you will find an activity that controls multiple threads - you might want to use some of the code provided in your own multi-threading apps. 

## Sample Code

Sample code that illustrates all of the above can be found
[here](GPSTest.zip).  Note that the conversion from raw location sampled
data to KML is done via a separate application, but this could easily be
incorporated into the app.

## Receiving GPS Updates

The main part of this is to write a listener to handle the GPS events. 
In the code I've provided the listener does calls a method to do two
things each time it receives a GPS update: it updates the current
position by setting the text in a TextView, and it appends the data to a
file.

Note that the simulator does not produce GPS update events by default. One however can telnet to the emulator and provide the correct signals. You can find a script, developed by Davide Valeriani that will help you receive dummy GPS updates below.

~~~{.python}
import telnetlib as tn
import random
import time

t = tn.Telnet("127.0.0.1", 5554)

while True:
    random_long = random.random()*20
    random_lat = random.random()*20
    t.write("geo fix "+str(random_long)+" "+str(random_lat)+"\n")
    time.sleep(1)

~~~~ 

The GPS listening code was developed by adapting the example in the
[Location
Strategies](http://developer.android.com/guide/topics/location/strategies.html).

To listen for GPS events we need to:

-   Provide an implementation of the **LocationListener** interface
-   Get a reference to a **LocationManager**
-   Register the **LocationListener** with the **LocationManager**

The LocationListener interface is written as an anonynmous inner class
in the onCreate method of the main activity (which I've left with the
default name MyActivity).

This has to provide implementations of all the interface's methods, but
in this case the only one we need to handle is the onLocationChanged
event.  This provides a reference to a Location object, but we delegate
handling of that to the method **makeUseOfNewLocation**.

![LocationListener](LocationListener.PNG)

The onCreate method shows how to add the listener to this.  Note: we
also adda TextView to show the status of the GPS listening.  It may be a
few seconds until the first onLocationChanged events come through, so
it's good to provide some feedback to the user ("Waiting for Location")
prior to this.

![MyActivity onCreate](MyActivityOnCreate.PNG)

We now consider the impementation of the method to handle the location
updates: makeUseOfNewLocation:

![makeUseOfNewLocation](makeUseOfNewLocation.PNG)

Although the method is a bit long, it's actually rather simple: it
creates a string to write to the TextView and a string to write to a
file.  Having created the strings it then calls **text.setView** to
update the view and **logLocation** to write the file.

The logLocation method is very simple: it just writers a line of data to
a PrintWriter:

![logLocation](logLocation.PNG)

However, it relies on the writer already having been set up.  This is
opened in **onStart** and closed in **onStop**.

![onStop and onStart](onStopAndStart.PNG)

You'll see that this makes some calls to utility methods.  You can find
these in the sample code.

## Converting to KML

[KML (Keyhole Markup
Language)](http://en.wikipedia.org/wiki/Keyhole_Markup_Language)is an
XML-based open standard for describing geospatial data.  You can read
more about it by following the link above.

KML files are viewable in many different apps, including Google Earth. 
Try opening the [Sample KML](assets/SampleRoute.kml) File in Google
Earth (e.g. on a Mobile device or laptop / desktop).

Here I've just used the simplest possible format, converting the set of
locations sampled during a walk around campus into a set of Placemark
elements in KML.  KML has more appropriate elements for a route, so a
useful exercise would be to change the code to use a better KML element
type.

The KMLTest class contains the following two methods: the main method
and the getPlace method.  Note the use of the JDOM library for writing
out XML data.

The main method simple reads in the[raw data
file](assets/SampleRoute.txt) line by line, and sets up the document
root element and namespace.

![KMLTest main method](KMLMain.PNG)

The getPlace method creates a Placemark element for every location on
the route:

![KMLTest getPlace](KMLGetPlace.PNG)

Note that creating XML in this way is a bit verbose, but essentially
very straightforward.  Question: do you know any more elegant ways of
dynamically creating XML documents?

A raw data file and a sample KML file is provided with the project (see
the data directory).

A screenshot of viewing the sample KML file in Google Earth is shown
below.

![Route Segment in Google Earth](RouteSegmentInEarth.JPG)

## Displaying a Path

In this section we'll look at how to take a sequence of locations and
render them as a path or route on a custom view.  The relevant code is
mostly in the MapView class, and most of the work is done in the
**onDraw** method.  In order to simplify this there are two helper
classes.  One is called **MyPoint**, which just stores the latitude and
longitude of each location, together with an accuracy estimate.

![MyPoint](MyPoint.PNG)

There is also a class to model a path, called **MyPath**.  This provides
a convenient way to find the range of coordinates in a path (the min and
max of the latitudes and longitudes).  It also stores all the points in
a list, though of course we would not need a separate class just to do
that.  MyPath uses **StatSummary** objects ssx and ssy to find the range
of values.  StatSummary is a useful utility class that I wrote many
years ago and have used hundreds of times since.

![MyPath](MyPath.PNG)

 

We'll now break the **onDraw** method of **MapView** into two parts. 
First of all we'll look at the code to take the path and calculate its
size and centre in degrees, then work out how many pixels we should take
per degree.  The calculations should be straightforward but please ask
in case anything is unclear.

![onDrawPart1](onDrawPart1.PNG)

And now we create a **Path** called **cPath** object with which to draw
on the Canvas.  We use Path methods moveTo and lineTo to start and then
build up the path as we iterate over the points.  When we've constructed
a path we can then render it with a single call to **canvas.drawPath**. 
To calculate the pixel coordinates of each path we first subtract off
the centre and then multiply by the number of pixels per degree.  Note
the use of scaleFactor.  This controls the zoom.  Also note the
translation to the centre of the canvas.  I found it easier to envisage
with the origin set to the centre.

![onDrawPart2](onDrawPart2.PNG)

## Zoom Gesture

So far we've handled relatively low-level gestures such as touching and
clicking a view.  Android can also handle gestures at a higher level to
control panning and zooming plus a range of others.  For more on this
see the [Gestures
documentation](http://developer.android.com/training/gestures/index.html)
and the InteractiveChart.zip application (this is a bit complex, but the
zoom example below is fairly straightforward.

To handle pinch gestures to zoom in and out the main thing required is
to write a **ScaleListener**.  The code for this is very simple: it just
gets the scale factor from the ScaleGestureDetector (a built-in Android
class), restricts this to be within a sensible range and then
invalidates the view (this is an **inner class** of **MapView**).

![ScaleListener](ScaleListener.PNG)

In order to operate this must to be hooked up to the View, and the touch
events that come in to the view must be despatched to the ScaleListener.

This is achieved with the following:

![initMethod](initMethod.PNG)

![onTouchEvent](onTouchEvent.PNG)

This leads to the sample path being shown like this (zoomed in a bit)

![MapViewScreen](MapViewScreen.png)

## Exercises

1.  Write a method to calculate the distance covered on a path in
    metres.  How would you make it robust to GPS estimation errors?
2.  Modify the map view class to draw discs on the view whenever the
    accuracy error estimate exceeds 4 metres.
3.  Add code to handle panning of the view.
4.  Modify the KMLTest code in order to use a more sensible element type
    for modelling a route or path.  Test it with the supplied data.
5.  Currently the MapView always shows the same route, while the default
    activity records new routes.  Add the facility to select which route
    to view.

Finally, we gained some experience of handling location data at a low
level, but in many cases it would be far more sensible to leverage
existing apps for doing this.  In Android you have access to the Google
Maps API for this purpose: you can read more about this
[here](https://developers.google.com/maps/documentation/android/).  This
is very powerful, though more specialised than will be covered on this
course.

## Manifest File

The manifest file is shown here.  Note that the IDE has "prettied" up
some of the XML - can you see which parts are not the true XML?

Note the permissions necessary for this App: it needs to write to
external storage and to access GPS locations - these are the most
accurate form of location data and are specified by
ACCESS\_FINE\_LOCATION.

![ManifestFile](ManifestFile.PNG)

## Threads

This is an add-on to the previous lab and lecture. Create a new Activity using your IDE and incorporate the code found [here](ExecutorActivity.java). 
The activity starts a fixed number of threads (as many as your device supports) and manages them in the onStart and onPause method. Each thread simply calculates Fibonacci sequences. In order to see CPU loads, you need to enable "Show CPU Usage" on your phone or emulator (under settings/developer options).

Run the code, observe the CPU load going up and see the logging events coming up as the apps is destroyed/paused. See [http://developer.android.com/tools/debugging/debugging-devtools.html](http://developer.android.com/tools/debugging/debugging-devtools.html) for an explanation on what the bars mean. The three numbers represent the system load for the last one minute/last five minutes/last fifteen minutes. What will happen if you disable onPause()? 

