chai = require('chai')
should = chai.should()

TimerTrack = require('../src/timer-track')

describe 'TimerTrack', () ->

  timerTrack = null

  beforeEach () ->
    timerTrack = new TimerTrack()


  describe 'class', () ->

    it 'should instantiate correctly', (done) ->
      should.exist(timerTrack)
      done()