---
title:  'Menus, Dialogs and Fragments'
subtitle: 'CE881: Mobile and Social Application Programming'
author: Simon Lucas \& Spyros Samothrakis
tags: [nothing, nothingness]
date: Febrary 03, 2015
theme: Warsaw
...


# Interesting Cultural Artefacts
## Theme: "Social apps"

* The social network (movie)

## Apps

* Facebook
* Twitter
* Pinterest
* OkCupid
* Instagram

Where's the value?

# Menus

## IDE Tips

* Ctrl+Shift+A
* Ctrl+B
* Ctrl+U
* Ctrl+J
\includegraphics[width = 0.6\textwidth, angle =180, trim=0cm 0cm 0cm 7cm, clip=true]{graphics/lec4/ideashirt.jpg}

\tiny http://stackoverflow.com/questions/294167/what-are-the-most-useful-intellij-idea-keyboard-shortcuts


## Progress Test
* Next week
* Sample progress test online
* 20 Questions
* 50 Minutes


## Types of Menu

* Options Menu
	* Will pop up when the menu “button” is pressed on an app
	* The location of the “button” will depend on the device: on modern nexus devices it appears as a column of dots in the ActionBar
* Popup Menu
	* Appears when an item within a view is clicked, where the item handles the relevant event
* Context Menu
	* Appears on items that handle a long-click event
	* Menus can be declared in XML or in Java 

## Menus: all about selection

* A menu presents one or more items for a user to select
* When the item is selected an action should be taken
* Menus are added to parent views
	* Write a method to handle the appropriate event
	* It is common for the same method to handle many menu item selections
	* Then use a switch statement to detect which item was selected



## Creating a Menu in XML

\includegraphics[width = 1.1\textwidth]{graphics/lec4/menuxml.png}


## Questions

android:id="@id/help" vs android:id="+@id/help"

## Then loading it in Java

* Override the onCreateOptionsMenu method
* Use a MenuInflater to build the menu
* Note: menu1 matches the name of the xml file (menu1.xml) in the folder res/menu/
\includegraphics[width = 1.1\textwidth]{graphics/lec4/onCreateMenu.png}

## Creating a Menu in Java

* Override the **onCreateOptionsMenu** method
* Add the menu item and assign the return value to a reference variable of type MenuItem
* Call methods of the MenuItem object to modify its appearance or where it appears


## Java Code

* In addition to adding a menu item labelled “Test” we also add an Icon to it
\includegraphics[width = 1.1\textwidth]{graphics/lec4/onCreateMenuJava.png}

## Frustrating Differences

* The exact appearance of a menu differs with version of Android OS (or variations in UI added by manufacturer)
* E.g. the above Java code running on S4 (above) versus on a Nexus 7 emulator (below)
\includegraphics[width = 0.5\textwidth]{graphics/lec4/menu1.png}\includegraphics[width = 0.5\textwidth]{graphics/lec4/menu2.png}

## Adding Custom Menu Icons
* Normal practice is to either:
	* Use Android Platform Icons
	* Add your own in the drawable folder
		* Ideally there should be separate versions for each resolution
		* The IDE may do this for you
* Somehow you need to do it automatically for your sanity
* But it’s also possible to draw your own at Runtime...


## Dynamic Menu Icon Creation

* When setting up the menu icon:
* setIcon() can take a Drawable (Drawable is an Abstract Class)
* So do this: 
 
	* **class MyIcon extends Drawable**
	* Then implement the draw(Canvas c) method
	* Doing this felt a bit "off" - it might be useful - and was an interesting exercise, but use with some caution

## Dialogs (1)
* Dialogs can be built very easily using the AlertDialog builder.
* The following code assumes this is being called from a method of an Activity 
	* (note the “this” object being passed to the AlertDialog.Builder(this)  constructor)
* The rest of the code:
* Sets the title and message strings
* Sets handlers for the onClick events for each button
* Shows the Dialog

## Dialogs (2)
\includegraphics[width = 0.8\textwidth]{graphics/lec4/dialogs.png}

## Custom Dialogs

* Main idea:
	* Your custom Dialog class will extend DialogFragment
	* Use the AlertDialog.Builder as before
	* Override the *onCreateDialog* method within the subclass
	* Then create a new instance of your class and call its show method to show it

## Example 

see: http://developer.android.com/guide/topics/ui/dialogs.html 
\includegraphics[width = 0.9\textwidth]{graphics/lec4/fire.png}

## Specifying a Custom Layout
* Within the builder we can call setView to set a custom view
* Can use Views specified in XML or created dynamically in Java
* This is equivalent to the setContentView we’ve used in the onCreate method of an Activity 
* The relevant line on the next slide (copied from the Android developer guide) is below
* Note that the code looks more complex than necessary due to method call chaining

~~~{.java}
public void onCreate(Bundle savedInstanceState)
{
	builder.setView(inflater.inflate(
	R.layout.dialog_signin, null)
}
~~~~

## Code
\includegraphics[width = 0.9\textwidth]{graphics/lec4/cview.png}

# Fragments

## Fragments
* Fragments offer a powerful way to compose Apps in a highly modular way
* Choice of Layout can easily depend on screen size
* Each Fragment has it’s own lifecycle, tied to its parent activity’s cycle
	* Composing an Activity from several fragments offers flexibility
	* The overhead is additional coding
	* These notes summarise the main points:
* See examples and lab exercise for more detail

## Fragments and Android API Versions

* Fragments have native support from API 11 (Honeycomb, 3.0) onwards
	* If compatibility with earlier versions is required then the Android Support Library must be used
	* This also leads to some differences in the code
	* Fragments always belong to an Activity
* i.e. an Activity hosts a Fragment
	* From API 11 onwards, any Activity can host a Fragment
	* With earlier APIs and the Support Library, a FragmentActivity is needed (or a sub-class of this)





## Example
http://developer.android.com/training/basics/fragments/fragment-ui.html

\includegraphics[width = 0.9\textwidth]{graphics/lec4/fragments1.png}

## Defining Fragment GUIs

* Like other layouts, can be done in XML or in Java code
* XML trick:
	* Define two layouts, one for small screen, one for tablet (large screen)
	* The one for the tablet must be in a directory with the “large” qualifier e.g. two layouts could be:
		* res/layout/news_articles.xml
		* res/layout-large/news_articles.xml
	* When the layout is inflated the correct one will be chosen
* Following shows FragmentBasics example on Nexus One and Nexus 7 emulators


## FragmentBasics Example
Note the different layouts

\columnsbegin
\column{.5\textwidth}

\includegraphics[width = 1.1\textwidth]{graphics/lec4/fragleft.png}
\column{.5\textwidth}

\includegraphics[width = 1.1\textwidth]{graphics/lec4/fragright.png}

\columnsend

## Fragments in Java Code
* When Fragments are added to XML layouts they cannot be removed in code
* Alternative: Fragments can be added or removed with the appropriate Java
	* This enables dynamic construction of GUIs
	* BUT NOTE: all additions and removals of Fragments MUST be done within a Fragment Transaction
	* Discussion: why is this so?


## Implementing Fragments

* Similar to defining an Activity
* Except main override for Activity is onCreate()
* For Fragment use:
	
~~~{.java}

	 onCreateView()
		// check the savedInstanceState
		// inflate the layout
	  onStart()
		// can now update view components
		// since layout is ready for use
		// perform any initialisation 
		// and restoration of state
~~~~

## Managing Fragments
* The host activity is responsible for:
* Creating, adding and removing fragments
* Note:
	* To be visible each Fragment must be added to a View
	* Within the Fragment code, Save any state by overriding onPause() or onSavedInstanceState()

## Programming with Fragments
* Note: communication between sibling fragments is not allowed
* Instead communicate via parent activity
* Also, see examples here:
	* \tiny http://developer.android.com/training/basics/fragments/fragment-ui.html
	* \tiny http://developer.android.com/training/animation/cardflip.html
* Discussion question: there is nothing to stop you trying this, but why do you think it is “not allowed”
* Do you need more than one activities in your app? Why not just stick to fragments?

## XML Fragments - loading

\tiny

~~~~{.xml}

<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="horizontal"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
    <fragment android:name="com.example.news.ArticleListFragment"
            android:id="@+id/list"
            android:layout_weight="1"
            android:layout_width="0dp"
            android:layout_height="match_parent" />
    <fragment android:name="com.example.news.ArticleReaderFragment"
            android:id="@+id/viewer"
            android:layout_weight="2"
            android:layout_width="0dp"
            android:layout_height="match_parent" />
</LinearLayout>

~~~~

## XML Fragments - loading

\tiny

~~~{.java}
public static class ExampleFragment extends Fragment {
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.example_fragment, container, false);
    }
}
~~~~

## Programmatically
\tiny

~~~{.java}


FragmentManager fragmentManager = getFragmentManager()
FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
ExampleFragment fragment = new ExampleFragment();
fragmentTransaction.add(R.id.fragment_container, fragment);
fragmentTransaction.commit();

~~~~

## Fragment Transactions

* Why transactions?


## Summary
* With these Menus and Dialogs you can build  sophisticated  custom-designed User Interfaces for your apps
* Practice these ideas in the lab
* Use fragments
* Fragments are recommended for building apps in a scalable and flexible way
* Especially good for coping with different screen sizes
* They are reusable modules that always belong to a parent (host) Activity
* But are responsible for managing some lifecycle callbacks to initialise, save, and restore their state