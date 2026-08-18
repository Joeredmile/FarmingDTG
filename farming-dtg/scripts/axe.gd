extends Sprite2D

@onready var timer: Timer = $Timer
var axe_can_equip = true

func _input(event):
	if event.is_action_pressed("hold_axe") and axe_can_equip == true:
		if GlobalData.gun_equipped == false:
			visible = not visible
			timer.start()
			axe_can_equip = false
			GlobalData.axe_equipped = not GlobalData.axe_equipped
		else:
			pass

func _process(delta: float) -> void:
	if not visible:
		return
	else:
		look_at(get_global_mouse_position())


func _on_timer_timeout() -> void:
	axe_can_equip = true
