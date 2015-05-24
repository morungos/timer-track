## Main class

class TimerTrack

  index: null

  queue: []

  events: {}

  constructor: () ->
    @queue = []
    @events = {}

  add: (time, data) ->
    @queue.push {time: time, data: data}

  playEventRecord = {}

  playEvent = (self) ->

    if self.index == null
      if self.queue.length > 0
        timeout = self.queue[0].time
        self.index = 0
        setTimeout playEvent, timeout, self
      else
        self.emit 'end', {}
      return

    playEventRecord.index = self.index
    data = self.queue[self.index].data
    if typeof data == 'function'
      data = data()
    playEventRecord.data = data
    self.emit 'timer', playEventRecord

    self.index++

    if self.index < self.queue.length
      timeout = self.queue[self.index].time
      setTimeout playEvent, timeout, self

    else
      self.index = null
      self.emit 'end', {}


  play: () ->
    self = @
    if self.index != null
      throw new Error("Can't play while still playing")
      
    self.index = null
    playEvent(self)


  clear: () ->
    @queue = []


  emit: (event, args...) ->
    return false unless @events[event]
    listener args... for listener in @events[event]
    return true

 
  addListener: (event, listener) ->
    @emit 'newListener', event, listener
    (@events[event]?=[]).push listener
    return @

 
  on: (evt, handler) =>
    @addListener(evt, handler)


## Export the class

module.exports = TimerTrack