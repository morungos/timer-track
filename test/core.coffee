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


  describe 'initial queue', () ->

    it 'should be empty', (done) ->
      should.exist(timerTrack.queue)
      timerTrack.queue.should.be.instanceof(Array).and.have.lengthOf(0)
      done()


  describe 'add', () ->

    it 'should add a single event', (done) ->
      timerTrack.add(0, "Immediate")
      done()


  describe 'play', () ->

    it 'should play correctly', (done) ->
      timerTrack.on 'end', (e) -> done()
      timerTrack.add(0, "Immediate")
      timerTrack.play()
