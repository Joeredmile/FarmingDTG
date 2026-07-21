extends Sprite2D

@onready var timer: Timer = $Timer
var can_equip = true

func _input(event):
	if event.is_action_pressed("hold_axe") and can_equip == true:
		visible = not visible
		can_equip = false
		timer.start()

func _process(delta: float) -> void:
	if not visible:
		return
	look_at(get_global_mouse_position())


func _on_timer_timeout() -> void:
	can_equip = true
