(function(f){if(typeof exports==="object"&&typeof module!=="undefined"){module.exports=f()}else if(typeof define==="function"&&define.amd){define([],f)}else{var g;if(typeof window!=="undefined"){g=window}else if(typeof global!=="undefined"){g=global}else if(typeof self!=="undefined"){g=self}else{g=this}g.TimerTrack = f()}})(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var TimerTrack,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  slice = [].slice;

TimerTrack = (function() {
  var playEvent, playEventRecord;

  TimerTrack.prototype.index = null;

  TimerTrack.prototype.queue = [];

  TimerTrack.prototype.events = {};

  function TimerTrack() {
    this.on = bind(this.on, this);
    this.queue = [];
    this.events = {};
  }

  TimerTrack.prototype.add = function(time, data) {
    return this.queue.push({
      time: time,
      data: data
    });
  };

  playEventRecord = {};

  playEvent = function(self) {
    var timeout;
    if (self.index === null) {
      if (self.queue.length > 0) {
        timeout = self.queue[0].time;
        self.index = 0;
        setTimeout(playEvent, timeout, self);
      } else {
        self.emit('end', {});
      }
      return;
    }
    playEventRecord.index = self.index;
    playEventRecord.data = self.queue[self.index].data;
    self.emit('timer', playEventRecord);
    self.index++;
    if (self.index < self.queue.length) {
      timeout = self.queue[self.index].time;
      return setTimeout(playEvent, timeout, self);
    } else {
      self.index = null;
      return self.emit('end', {});
    }
  };

  TimerTrack.prototype.play = function() {
    var self;
    self = this;
    if (self.index !== null) {
      throw new Error("Can't play while still playing");
    }
    self.index = null;
    return playEvent(self);
  };

  TimerTrack.prototype.clear = function() {
    return this.queue = [];
  };

  TimerTrack.prototype.emit = function() {
    var args, event, i, len, listener, ref;
    event = arguments[0], args = 2 <= arguments.length ? slice.call(arguments, 1) : [];
    if (!this.events[event]) {
      return false;
    }
    ref = this.events[event];
    for (i = 0, len = ref.length; i < len; i++) {
      listener = ref[i];
      listener.apply(null, args);
    }
    return true;
  };

  TimerTrack.prototype.addListener = function(event, listener) {
    var base;
    this.emit('newListener', event, listener);
    ((base = this.events)[event] != null ? base[event] : base[event] = []).push(listener);
    return this;
  };

  TimerTrack.prototype.on = function(evt, handler) {
    return this.addListener(evt, handler);
  };

  return TimerTrack;

})();

module.exports = TimerTrack;


},{}]},{},[1])(1)
});


//# sourceMappingURL=timer-track.js.map