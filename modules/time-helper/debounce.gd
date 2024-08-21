class_name Debounce
extends Node

var _timer: Timer
var _callback: Callable = _empty_func

func _init(node: Node, timeoutInMs: float):
  var _timeout = timeoutInMs / 1000

  _timer = Timer.new()
  _timer.wait_time = _timeout
  _timer.timeout.connect(_run_callback)
  self.add_child(_timer)

  node.add_child(self)

func call_function(fn: Callable):
  _callback = fn
  _restart_timer()

func _run_callback():
  _callback.call()
  _callback = _empty_func

func _restart_timer():
  if not _timer.is_stopped() or not _timer.is_paused():
   _timer.stop()
  _timer.start()

func _empty_func():
  pass
