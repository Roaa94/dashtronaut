# Dashtronaut

[![HitCount](https://hits.dwyl.com/roaa94/flutter_puzzle_hack.svg?style=flat-square&show=unique)](http://hits.dwyl.com/roaa94/flutter_puzzle_hack)

## Slide Puzzle Game Built For The Flutter Puzzle Hack Challenge
---

# Tutorials

1. [App Architecture, Folder Structure, and Widget Tree](https://dashtronaut.app/tutorials/app-architecture)

![app-architecture](https://user-images.githubusercontent.com/50345358/159139398-98de01a9-6248-4998-ac1b-6c0940362217.png)

2. [Performance Improvements By Precaching Images and Warming Up SKSL Shaders](https://dashtronaut.app/tutorials/performance/)

3. [Creating and Animating the Background Stars Using CustomPainter](https://dashtronaut.app/tutorials/background-stars)

https://user-images.githubusercontent.com/50345358/158265025-5b66a0ca-6318-4b23-9e6a-1fda364ba11d.mp4

---

# Inside The App

![image](https://user-images.githubusercontent.com/50345358/161156238-e944054e-ca08-41ad-862b-cccff5852bfb.png)


## Inspiration

When the Flutter Puzzle Hack Hackathon was [announced](https://twitter.com/FlutterDev/status/1479184966927872000), I had
just got Covid and was in house quarantine. So in the midst of all the physical as well as psychological symptoms, most
importantly, feeling like my life has no meaning, this challenge came to the rescue. It gave me the opportunity to focus
all the energy I can summon to work on something I’m extremely passionate about. So I dove in and did nothing but
Flutter day and night for a couple of weeks to create my version of the slide puzzle.


I cherished the distraction and brainstormed lots and lots of ideas. I wanted so badly to challenge myself. I had been
working with Flutter for about 2.5 years and I felt confident that my skills and experience are up to the challenge.
Also, being passionate about and having some experience in graphic & UI design, I knew that I had the ability and
opportunity to create something cool visually and
programmatically! [(Ahm, unicorn developer speaking 🦄)](https://youtu.be/MIepaf7ks40?t=182)

---

## About Dashtronaut

**Dashtronaut** is a slide puzzle game set out in space with Dashtronaut, Dash the Astronaut, floating in space and
interacting with the user. Most of the basic puzzle functionality found in the example app is present in addition to
some user experience enhancements, interactivity, and design features including:

1. The ability to swipe the tiles and have them move in the direction of the swipe.
2. Giving the user the option to change the puzzle size to easier or more difficult sizes to solve than the default 4x4
   puzzle.
3. Tile animations created with Rive that run when a tile is moved to its correct place and when the puzzle is solved.
4. Persisting user progress including elapsed time, moves count and puzzle size even when the app is closed and
   reopened.
5. Showing the user a list of their last 10 scores in the app drawer.
6. Stopwatch that starts automatically on the first tile move.
7. Space-themed environment design around the puzzle with planets that animate into view along with the puzzle board on
   app launch as well as stars randomly laid out and animated using Flutter’s CustomPainter
8. Dashtronaut floats into view on app launch then floats in place. With phrase bubbles, tapping on her let’s her
   express herself in a fun way. She also motivates the user to solve the puzzle and she is amazed when they pick a
   difficult puzzle size!
9. Haptic feedback for multiple events like moving a tile to its correct place, solving the puzzle, and tapping on
   Dashtronaut
10. To optimize
    performance, [shader captured in the Skia Shader Language (SkSL)](https://docs.flutter.dev/perf/rendering/shader)
    was warmed up and cached and added to the builds of each platform to avoid animation jank on the first app run.
11. Responsiveness: The puzzle and its surrounding UI is responsive for all screen sizes. Most importantly, the puzzle
    board is laid out such that it is all in-view in landscape mode in small screens

---

## How Dashtronaut Was Built

I started by reading through the [example code](https://github.com/VGVentures/slide_puzzle) made by the awesome people
of **Very Good Ventures**. I learned a lot from it but ended up starting from scratch and only using the puzzle logic (
e.g. solvable puzzle algorithm), along with minor puzzle features here and there, from the example code. I wanted an
empty canvas to spread my ideas on and I wanted to make tweaks on the way the puzzle tiles were laid out and how they
interacted with user input.

After doing some planning and typing up some Todo’s in a text note that is growing in length until this very moment, I
dove into the development of my slide puzzle version by clearing out the code of the good old Flutter counter app that
comes with any new Flutter project and started coding from there.

In the couple of weeks I was quarantined and working only on my slide puzzle, I managed to finish only the basic puzzle
logic and layout. I achieved what I had in mind by adding the ability to swipe the tile in the target position direction
and have them animate to it. And I added keyboard and mouse support. At this point the puzzle was a skeleton! It looked
like this:

<img src="https://dashtronaut.app/images/skeleton-puzzle.png" alt="Puzzle Old State" width="70%" />

It even had the ability to do this:


<img src="https://user-images.githubusercontent.com/50345358/157831017-282fb274-f161-40e2-b69e-b55144c00ebe.gif" alt="Fun Puzzle" width="350px" />

Wouldn’t such a puzzle be much easier to solve!


---
Anyway, as soon as the puzzle was in a stable state and I got to the design part, I tested negative for Covid and had to
get back to real life and I wasn’t able to focus on the puzzle full-time. So in the remaining weeks before the deadline,
in between client projects and my full-time job responsibilities, I squeezed in some hours and was able to create the
designs and animations, come up with the Dashtronaut name, buy a domain to host the web app and the app landing page and
tutorials pages, which I also built as quickly as I could with pure Html, CSS & JavaScript, deploy the web app, submit
the app to the App Store (iOS & MacOS) and to the Google Play Store for Android, and finally, work on the demo video.

### Design Inspiration - Why Dashtronaut?

I liked the idea of presenting the image of the tiles floating in space, so I created the design accordingly. And
because this is a game, I wanted to add something fun and interactive to it, I wanted to add a character! And since the
puzzle is in space, it made sense to have an astronaut character. But what made even more sense, and what I’ve wanted to
do since the moment I saw the hackathon announcement, is bring Dash, the beloved and unbelievably cute Flutter & Dart
mascot, into the picture!

By grabbing a pen & paper and doing a quick sketch, Dashtronaut, Dash the Astronaut, was born!

<img src="https://dashtronaut.app/images/dash-sketch.png" alt="Dashtronaut Sketch before & after" />

--- 

## Educational Content

It felt selfish to me to enjoy the process of creating Dashtronaut that much and not share it! So I dedicated pages in
[Dashtronaut’s website](https://dashtronaut.app/tutorials/introduction) to articles explaining the app’s architecture as
well as individual tutorials detailing each feature in the app. And those tutorials will be updated and added to
regularly.

---

## What's next for Dashtronaut

With Flutter, there are absolutely no limits to what you can do. And Dashtronaut is nothing but a small portion of what
I wanted to do. But I’m proud of what I accomplished and will do my best to keep updating the app with features in the
future. Because it turned out to be an amazingly fun project rich with stuff to learn and teach.

