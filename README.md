# timer-track

JavaScript module which generates events from a schedule

## Why use this module?

Sometimes, you want a series of events to be generated according to 
a simple schedule, and then played. This is handy, for example, when
building a simple animation.

## How do I use this module?

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

## License

Copyright (c) 2015. Stuart Watt.

Licensed under the BSD License.