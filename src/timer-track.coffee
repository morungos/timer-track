## Main class

class TimerTrack

  index: null

  queue: []

  events: {}

  add: (time, data) ->
    @queue.push {time: time, data: data}

  play: () ->
    console.log "Playing"
    @emit 'end'

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