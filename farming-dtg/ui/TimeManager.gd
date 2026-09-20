extends Node

var date_time: DateTime = DateTime.new()

func _process(delta: float) -> void:
	date_time.increase_by_sec(delta)
