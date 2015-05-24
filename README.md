# timer-track

JavaScript module which generates events from a schedule

## Why use this module?

Sometimes, you want a series of events to be generated according to 
a simple schedule, and then played. This is handy, for example, when
building a simple animation. You can set a bunch of actions with 
timings, and then start them running with a simple listener. 

## How do I use this module?

It's designed to work with both node.js and browsers, so use it as
you see fit. No need for jQuery or any other dependencies.

```
var timer = new TimerTrack();
timer.add(100, "Hello");
timer.add(200, "world! ");
timer.add(50, {name: "key", value: ["Any", "old", "data"]});
timer.on('timer', function(e) {
  console.log("Timer", e.data);
});
timer.on('end', function(e) {
  console.log("Done");
});
timer.play();
```

## Methods

#### add(time, data)

Adds a new time point to the timer track. The data is passed out as 
the `data` property of the timer event, but isn't used by this module.

Data can also be a function, in which case it is called with no
arguments an its value passed to the event. This is useful for deferring
data generation.

#### play()

Starts the track playing. It will emit timer events for each time 
point, and then an end event to finish.

#### clear()

Clears the track of all registered time points.

## Events

#### timer

Emitted for each time point, with an `index` property corresponding to
the sequential count of time points, and a `data` property containing the
original time point value.

#### end

Emitted at the end of playing the time track. 

## License

Copyright (c) 2015. Stuart Watt.

Licensed under the BSD License.