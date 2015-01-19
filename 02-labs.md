# CE881 Lab 2: Lights On!

## Introduction

In this lab we'll work through implementing a simple but fun puzzle
app.  The lab has the following aims:

-   To work reinforce the idea of separating the logical model of an App
    (which should ideally not utilise any Android-specific features)
    from the presentation / view and event handling.
-   To experiment with event handling, including **onClick** and
    **onTouch** events.
-   To refer to the Android API in order to utilise various features of
    it.
-   To put view components together in a Layout (we'll use a
    LinearLayout)
-   To use a Button component, including handling Button events

Thanks go to Yulia Bulgakova (a CE881 student from 2012/3) for bringing
this puzzle to my attention, and to [Alexei
Vernitski](http://www.essex.ac.uk/maths/staff/profile.aspx?ID=1275) for
designing the puzzle and providing a web-based implementation of it.  I
call it the LightsOn puzzle.  For background interest, also see the
[Chromanode puzzle](#Note%201).

The rules of the puzzle are simple:

-   The puzzle consists of a grid of n\*n "light-up" switches.
-   Each time you press a switch, that switch and all the ones
    horizontally and vertically in line with it flip state (i.e. on -\>
    off and off -\> on).
-   The aim is to switch on as many as possible.  For an n\*n grid the
    maximum number of on switches is (n\*n) -1 (this is assuming that it
    does not start with them all on). 
-   If this many switches are on then the puzzle is solved.
-   In one variation of the puzzle only on switches can be manually
    switched off (and off switches cannot be manually switched on)

An example game state displayed on a basic version of the App is shown
below.

![Lights On Basic](figures/LightsOnBasic.PNG)

## Design of Model

The model must be able to represent the state of each switch.  Since
each switch is either on or off, the model state could be represented by
a 2d array of boolean (i.e. boolean[][] grid).  In my implementation I
chose instead to use a 2d array of int (i.e. int[][] grid).  One simple
reason for this: flipping the state of a switch is just as easy, but now
it's possible to change the appearence of each square by using the
switch state as an index into an array that controls the drawing style.
(\* see note 1).

The class diagram for the model I implemented is given below.  We
already mentioned the grid field.  There's also a boolean variable
called **notStrict**.  If this is true then any light can be manually
flipped.  The int variable **n** conveniently stores the size of the **n
x n** grid.

![LightsModel Class Diagram](figures/LightsModelClassDiagram.PNG)

## Model Implementation

Now work through implementing the model.  Create a new Android project
by following a similar process as last week.  Now is also a good time to
start up an emulator!

The constructor takes the parameter **n** as an argument and creates the
grid, which together with the aforementioned instance variables gives
us:

![Instance vars and Constructor](img3.gif)

The **tryFlip** method takes the **i,j** location of the switch within
the grid and tries to flip it.  Note the use of the **try catch**
block.  This provides the easiest way to prevent illegal indexes causing
the app to stop with an error.  Note also the use of the logical OR
operator || to enforce the alternative game rules.

![trFlip method](img5.gif)

Testing the model will be important, and it's a good idea to do this
from plain Java rather than to always have to test within an Android
app.  For this purpose we have the following toString() method.  This
will allow us to check the state of the model after flipping a switch:

![toString method](img7.gif)

## Exercise One

Now implement the three remaining methods:

-   boolean isSwitchOn(int i, int j)
-   void flipLines(int i, int j)
-   boolean isSolved()

From the names and puzzle description you may be able to work out what
these methods should do: if not please discuss this with a lab
assistant.

Write a new class to test this and check the operation of the model. 
You can set the grid to be in various states.  This is a simple example,
which is sufficient for this lab:

![ModelTest](img9.gif)

Run this and check that the console output is what you expect: (note
that only the first two grids are shown - the above code prints out
four).

![ModelTest Output](imgB.gif)

Also check that when notStrict is false, flipping a switch in the off
state has no effect.

## LightsView

Having confirmed that the model works, it is now time to build the view
class.  I called this LightsView.

The first part of the implementation declares what it extends and
implements, and also the required static and instance variables:

![LightsView Declarations](img2.gif)

The size variable is used to store the size of each grid cell.  This is
calculated dynamically every time the grid is drawn, in order to be
robust to any changes in size of the LightsView component.

The other supporting variables and **setGeometry** method to calculate
them are here:

![setGeometry](imgF.gif)

We'll draw the view in several steps: create a **Paint** object and vary
only the colour for part we need to draw.  Then we'll draw the view
background and the grid background (the grid is a square on the possibly
rectangular overall LightsView.

Then we simply iterate over the set of grid cells, setting the
corresponding light color depending on the state of the grid there. 
Note: I have accessed the grid array directly from the LightsView class:
this is questionable practice (why?), and you may prefer to define a
**getSwitchState** method in the model class instead.

![onDraw method](img13.gif)

![drawTile](img15.gif)

The event handling methods are as follows:

When you have the system up and running experiment with returning true
from the **onTouch** method, and confirm that this breaks the
**onClick** event.

![Event Handling](img17.gif)

There are some remaining things that need to be done.  When creating the
View class the IDE may have prompted you to create constrcutors. These
are the constructors I have.  Note that one that takes a LightsModel as
an argument. 

![LightsView Constructors](img4.gif)

Since much of the setup (at least for now) is common to all constructors
I have defined a **setup** method to take care of all this.  This also
calls a **checkModel** method.  The rationale behind this is to ensure
that something still works even if the model was not setup as expected. 
This is a bit sloppy and is just a quick fix: you should also
investigate under what circumatances each constructor gets called, and
how to ensure in all cases that the model is set up correctly (e.g. has
the correct value of **n**).

![setup and checkModel methods](img14.gif)

Finally, we need to ensure that the main activity class invokes the
view.  The view could be setup in XML but for now I've done it directly
in Java: 

![MyActivity class](img16.gif)

## Exercise Two

You should now have a working LightsOn puzzle, but there is no
indication of when the puzzle is solved, and no facility to reset the
puzzle.

By reading up on the
[LinearLayout](http://developer.android.com/guide/topics/ui/layout/linear.html)
class and experimenting with XML layouts, create a new version of the
puzzle app with a status message (e.g. using a TextView) and a reset
button (I suggest using a Button).

Then try to hook up these view components to the main activity and the
LightsView in order for everything to work in a sensible fashion: you
can decide on the details of exactly how it works. 

Don't be too concerned if you don't get all this working within this
lab: we'll study more about how to hook up components to work with each
other next week.  Here are a couple of tips to get ytou started.

You can edit the XML to make button clicks trigger a method (by default
a method in the main activity.  For example, add the following Button
declaration within a LinearLayout:

![Button onClick](imgD1.gif)

 

Then you need to rewrite the main activity class to change the
**onCreate()** method and to add the **resetModel()** method.  The
onCreate method has now been changed to use the XML layout.

Note the use of **findViewById** in the resetModel method, and the fact
that we call **postInvalidate** on the LightsView in order to refresh
the view.

![onCreate and resetModel](imgB1.gif)

**Note:** in order to show the current score you should add a
**getScore()** method to the **LightsModel** class.

**Hint:** before implementing **getScore()** take a look at
**isSolved()**.  After implementing getScore you will probably want to
refactor the isSolved method!

Here is an example running.

![LightsOn Working](imgF.jpg)

 

##  Note 1

Thinking further ahead, one could also imagine a fiendish version of
the puzzle with tri-state switches: in fact, a generalised version of
the puzzle with this extension already exists (though the switches now
are on a graph rather than a grid: see
[Chromanode](http://www.cs.mun.ca/~davidc/chromanode/).

 

 


