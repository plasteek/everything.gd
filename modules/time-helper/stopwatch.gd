class_name StopWatch
extends RefCounted

var timers := {}

func start(tag: String):
  timers[tag] = Time.get_ticks_msec()

func stop(tag: String) -> float:
  if not tag in timers:
   push_error("No timer named %s" % tag)

  var start_time = timers[tag]
  var current_time = Time.get_ticks_msec()
  var elapsed = current_time - start_time

  timers[tag] = null
  return elapsed
