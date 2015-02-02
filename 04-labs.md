## Introduction

This is the final lab covering the LightsOn puzzle.  The aim is to study
some further Android topics, and then build these into an improved
version of LightsOn.

The main topics to be covered are:

-   Menus
-   Custom Dialogs

We'll also pay some attention to how to randomise the puzzle with some
care.

Fragments are
briefly covered in the the lectures and online [here](http://developer.android.com/guide/components/fragments.html).

## Menus

In the previous lab we added an "About" menu to the app.  Now by
referring to the Menus, Dialogs and Fragments lecture notes or the
Android developer resources add at another menu item called Options, and
create specific icons for your menu items, and also experiment with
adding them to the ActionBar.

The [MenusAndDialogs.zip](MenusAndDialogs.zip) project contains the code
discussed in the lecture, including the experiemtal dynamic icon
generation code.

## Custom Dialogs

**Exercise:**

By  referring to the
[Dialogs](http://developer.android.com/guide/topics/ui/dialogs.html)
documentation (or the lecture notes) create an OptionsDialog that enables the
user to select the size of the n x n grid, and also the number of steps
that a randomised puzzle will be away from the goal.

The code provided below offers a partial solution to this.  From the
Menus part you should already have an "options" item added to the
options menu.  In the **onOptionsItemSelected** event handling method
add the following code to handle the selection of the "options" item
(define a static variable for this called **optionsItem**).

![OptionsMenu](OptionsMenu.PNG)

We then need to create the CustomDialogFragment class, and example of
which is shown below.  This will follow on from the examples provided in
the the
[Dialogs](http://developer.android.com/guide/topics/ui/dialogs.html)
documentation.  Note the following:

-   This is a simple example that uses a single number picker
-   It relies on some static variables having been defined in the parent
    Activity class such as **nGridMax** (CustomDialogFragment is defined
    as an inner class within the main Activity class (e.g.
    LightsActivity)
-   Being an inner class gives it convenient access to the instance
    variables and methods of the Activity
-   An instance variable of the Activity called **nGrid** has been
    defined to select the grid size
-   **nGrid** is used to provide a default value to the number picker
-   To keep the example self contained and simple I've created the
    custom view (in fact, the NumberPicker) in the Java code
-   The call to builder.**setView** is the one that sets the custom view
-   In both negative and positive button options the value of nGrid is
    retained, but only in the positive option called "New Game" is the
    new game initiated immediately

![CustomDialogFragment](CustomDialogFragment.PNG)

Interestingly, the default behaviour of this is rather annoying:: it
pops up a keyboard as illustrated below.  This could be useful
sometimes, but for selecting numbers from such a small range is just
ridiculous.

![With Keyboard](WithKeyboard.png)

**Fixing this:** by doing a web search work out how to disable the
keyboard, and arrive at the more satisfactory behaviour shown below:

![Without Keyboard](WithoutKeyboard.png)

To finish off this part you can either add more to a single custom
dialog, or alternatively add another item to the options menu to pop a
different custom dialog to enable selection of the number of steps to
goal.

## Randomising the Puzzle

In this section we return to some model logic that is independent of
Android.

Suppose you start the puzzle in the solved state with all the lights
on.  How will you guarantee to put the puzzle in a state which is *n*
steps away from the solution? 

Actually, this is a potentially difficult problem as *n* gets large. 
However, for small n there are probably some simple tricks you can use
to avoid obvious errors.  An obviously erroneous algorithm would be:

    repeat n times
      pick a grid square at random and flip the lights for that square

Question: why is that erroneous?  (think how it could go horribly wrong
even for *n*=2)

Note: you should also add a Randomise button to your app to invoke the
randomise function.

## Game State

Finally, you may want to add some game state management.  This is
distinct from the lifecycle state of the app, but can be useful in
managing the app while it is in the resumed state.  For example, if the
user wishes to change the grid size, you might disallow this during the
middle of a game (or at least warn that this will destroy the current
game).

## Solutions

Parts of this lab have been a bit open-ended - so we'll be very
interested to see the solutions you develop!  A solution that
demostrates the key concepts will be circulated some time after the lab.

 

