# timer-track

JavaScript module which generates events from a schedule

## Why use this module?

Sometimes, you want a series of events to be generated according to 
a simple schedule, and then played. This is handy, for example, when
building a simple animation.

## How do I use this module?

```
var timer = new TimerTrack();
timer.addEvent(100, "Hello");
timer.addEvent(200, "world! ");
timer.addEvent(50, {name: "key", value: ["Any", "old", "data"]});
timer.on('timer', function(e) {
  console.log("Timer", e.value);
});
timer.on('end', function(e) {
  console.log("Done");
});
timer.play();
```

## License

Copyright (c) 2014. Stuart Watt.

Licensed under the MIT License.