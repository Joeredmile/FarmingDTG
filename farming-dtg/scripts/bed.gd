extends Sprite2D

@onready var sleep_label: Label = $SleepLabel
@onready var sleep_timer: Timer = $SleepTimer
@onready var sleep_screen: ColorRect = $"../SleepScreen"

var can_sleep = false

func _input(event):
	if can_sleep and event.is_action_pressed("interact"):
		sleep_label.text = "Sleeping..."
		sleep_screen.visible = true
		sleep_timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		sleep_label.text = "E to Sleep"
		can_sleep = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		sleep_label.text = ""
		can_sleep = false

func _on_sleep_timer_timeout() -> void:
	sleep_screen.visible = false
	sleep_label.text = ""

	for carrot in get_tree().get_nodes_in_group("carrot"):
		carrot.sleep_day()
