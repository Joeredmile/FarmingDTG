extends Control

@onready var days_label: Label = $DayControl/days
@onready var hours_label: Label = $ClockBG/ClockControl/hours
@onready var minutes_label: Label = $ClockBG/ClockControl/minutes



func _on_time_system_updated(date_time: DateTime) -> void:
	days_label.text = str(date_time.days)
	hours_label.text = str(date_time.hours)
	minutes_label.text = str(date_time.minutes)

func add_leading_zero(label: Label, value: int) -> void:
	if value
