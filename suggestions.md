# CE881: Assignment Suggestions


## Introduction

The suggested projects on this page are just a sample of what might be
appropriate for your CE881 assignment, and give an idea of what could be
expected, though you'll be developing your apps with a much smaller
budget of time and money, so your apps might not be quite as polished as
some of the highly popular ones listed below.  Some more are more
complex than others.  The complexity / ambition of the app will be taken
into account when marking, so simpler apps are expected to be more
polished than more complex ones.  Where links are given to existing
apps, these are intended for background information and inspiration: you
should not aim to simply replicate an existing app. 

Your chosen app should satisfy the following criteria:

-   Help demonstrate that you've achieved the learning outcomes of the
    course.  Therefore, it should involve a significant amount of
    Android programming: simply putting content into an existing app
    engine would not be acceptable.
-   Be a useful and interesting app
-   Run robustly: it should not crash
-   The software should be well designed and be easy to modify or extend
    where appropriate

Click on the examples below to read more about the apps.  Most of them
can be installed for free on Android, though HarborMaster is an iOS app.

## Interactive Audience App

These are also known as personal response systems (PRS), and are used on
TV's "Who Wants To Be a Millionnaire?" for the "ask the audience"
parts.  The main idea for this app is that a presenter can ask the
audience a question, and get an immediate response back.  This is often
a multiple-choice question, but may be more complex than that, and could
involve typing an answer or drawing a quick sketch for example.  Note:
some of this functionality can be provided simply via web pages that
work on mobile devices, but some of the more sophisticated parts may be
better served in a stand-alone app.  Background research for this
project should include an investigation of the pros and cons of the app
versus the web-page approach.  One advantage for the App might be
immediate communication between presenter and audience without going via
the web (not relying on the web may have advantages in terms of managing
the delivery of questions, and also in working in locations where good
wireless connections are unavailable).

## Arcade Shooter

There is a significant demand for retro-style arcade shooters such as
Asteroids.  The basic techniques for implementing one of these will be
covered on the course.  The one shown below is a free app called
AstroBlast.

[![AstroBlast](img1F.jpg)](https://play.google.com/store/apps/details?id=badger.ati.astroblast)

## Reaction Game

This example is a 2 (or 4) player reaction game where players compete to
analyse whether a particular fact is true, or to solve a puzzle in the
minimum time.

[![2 Player
Reactor](img1C.jpg)](https://play.google.com/store/apps/details?id=coolcherrytrees.games.reactor)

## Physics Based Game

These are games where a physics simulator provides a major part of the
game.  Examples include Angry Birds.  Note: writing a physics engine
would be beyond the scope of this course, but students can use
AndEngine: a physics and graphics engine for Android.  This provides the
necessary support for developing 2D physics-based games.

[![Angry Birds
Screenshots](img1E.jpg)](https://play.google.com/store/apps/details?id=com.rovio.angrybirds)

## Organisational Game

This involves scheduling or some other kind of low-level planning for
various purposes such as maximising some reward or averting a disaster. 
Classic example: Harbor Master on iOS, see also Harbor Captain on
Android.

[![Harbor
Master](img1A.jpg)](https://itunes.apple.com/en/app/harbor-master/id313014213?mt=8)

## Sports Tracker

These apps track you while you perform a sports activity and store data
for later retrieval and analysis.  They then offer features such as:

-   Plotting routes on a map
-   Estimating calories burned
-   Statistics on time spent, distance covered etc.

Example include Endomondo (though I've notice that the mapping and
distance covered can be extermely innaccurate when the GPS signal is
poor, and does not seem to apply any constraints or common sense to
distance estimates...)

[![Endonomdo Sports
Tracker](img1D.jpg)](https://play.google.com/store/apps/details?id=com.endomondo.android)

## Local Tourism App

This aims to provide visitors to a region with useful information on
local sites and services.  This App is sponsored by Tendring District
Council.  Some of this image may be fairly static such as information on
parks and beaches, while others may be more dynamic such as opening
times of shops and services, restaurant special offiers etc.  A sample
app for San Francisco can be found here to give an idea of what you
might offer:

[https://play.google.com/store/apps/details?id=com.tripadvisor.android.apps.cityguide.sanfrancisco&hl=en\
 ![San Francisco
App](img19.jpg)](https://play.google.com/store/apps/details?id=com.tripadvisor.android.apps.cityguide.sanfrancisco&hl=en)

## Social Apps

This is a very broad genre, and many games offer some kind of social
interaction such as notification of high scores.  For this type of app
though, the main emphasis is on the social interaction.

## Healthcare

Examples in this category include apps for elder-care and assisted
living.  These can monitor the activity of a user and provide reminders
for taking exercise and medicine for example.


## Research Apps
These are apps whose main purpose is not some commercial application, but exposing some 
research question. If you are interested in a Research Project talk to me, but 

* Voting
* Generative Art
* Recognition of food items/price comparison
* Location aware applications - 
* GVGA-AI / AI testing on a mobile phone 

### SPOT IT 
Research in decision making usually uses experiments to investigate different methods where participants have to take a decision from a range of possible answers (e.g., two for binary decisions). "Spot it" is an app that could help researchers in developing experiments for smartphones in an easy way, so that they can acquire data from a large range of participants. It is a game-style app where participants have to spot a target in a picture that is showed for a very limited period of time. After seeing the picture, the participant has to answer YES or NO by pressing a button.
The app should allow the researcher to configure the experiments (for example, through an "admin area" linked to a server), including:
a) upload the pictures that will be presented to the participants (i.e., stimuli). This might be done to a server and then the app synchronise to it when it starts by downloading all the pictures.
b) choose how many stimuli should be presented in an experiment, the target rate (i.e., the ratio number of stimuli with target / total number of stimuli), the duration of each stimulus (e.g., 250ms)
c) decide whether the sequence of the stimuli should be the same for all users or randomised
d) have a button to "enable" the experiment, so that users can start doing it on their smartphones
Every time a user does the experiment, the app should assign him/her a unique ID and make sure the same person doesn't do the experiment multiple times. It should also collect data such as the gender, the handedness and the age of the participant (e.g., by asking him/her). The results of the experiment (i.e., the answer of the user in each stimulus and the response time) should then be stored on a server and made available to the researcher to download (e.g., JSON protocol).

(Thanks to Davide Valeriani for this)

For a similar app see here: 

[Paradigm Experiments](http://www.paradigmexperiments.com/index.html)

