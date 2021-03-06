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
      timerTrack.add(0, "Empty")
      done()


  describe 'play', () ->


    it 'should play correctly with no items', (done) ->

      timerCalled = false

      timerTrack.on 'end', (e) -> 
        should.exist(timerCalled)
        timerCalled.should.be.false
        done()

      timerTrack.on 'timer', (e) -> 
        timerCalled = true

      timerTrack.play()


    it 'should play correctly with three notifications', (done) ->

      data = []

      timerTrack.on 'end', (e) -> 
        data.should.be.instanceof(Array).and.have.lengthOf(3)
        data[0].should.equal("First")
        data[1].should.equal("Second")
        data[2].should.equal("Third")
        done()

      timerTrack.on 'timer', (e) -> 
        data.push e.data

      timerTrack.add(0, "First")
      timerTrack.add(50, "Second")
      timerTrack.add(100, "Third")
      timerTrack.play()


    it 'should play correctly after clearing', (done) ->

      timerCalled = false

      timerTrack.on 'end', (e) -> 
        should.exist(timerCalled)
        timerCalled.should.be.false
        done()

      timerTrack.on 'timer', (e) -> 
        timerCalled = true

      timerTrack.add(0, "First")
      timerTrack.clear()
      timerTrack.play()


    it 'should throw an error when called if still playing', (done) ->

      errorSignalled = false

      timerTrack.on 'end', (e) -> 
        should.exist(errorSignalled)
        errorSignalled.should.be.true
        done()

      timerTrack.on 'timer', (e) -> 
        try
          timerTrack.play()
        catch e
          errorSignalled = true
        
      timerTrack.add(50, "First")
      timerTrack.play()


    it 'should successfully play a second time', (done) ->

      playCount = 0

      timerTrack.on 'end', (e) -> 
        if playCount == 2
          done()
        else
          playCount++
          timerTrack.play()

      timerTrack.add(10, "First")
      timerTrack.play()


    it 'should play correctly with function notifications', (done) ->

      data = []

      timerTrack.on 'end', (e) -> 
        data.should.be.instanceof(Array).and.have.lengthOf(2)
        data[0].should.equal("First")
        data[1].should.equal("Second")
        done()

      timerTrack.on 'timer', (e) -> 
        data.push e.data

      timerTrack.add 0, () -> "First"
      timerTrack.add 10, () -> "Second"
      timerTrack.play()


