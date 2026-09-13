extends Sprite2D

@onready var timer: Timer = $Timer
var axe_can_equip = true

func _ready() -> void:
	visible = false
	GlobalData.axe_equipped = false
	
	
func _input(event):
	if event.is_action_pressed("hold_axe") and axe_can_equip == true:
		if GlobalData.gun_equipped == false:
			visible = not visible
			if visible:
				GlobalData.axe_equipped = true
			if not visible:
				GlobalData.axe_equipped = false
			timer.start()
			axe_can_equip = false
			print(GlobalData.axe_equipped)
		else:
			pass

func _process(delta: float) -> void:
	if not visible:
		return
	look_at(get_global_mouse_position())


func _on_timer_timeout() -> void:
	axe_can_equip = true
