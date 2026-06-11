extends Sprite2D
@onready var marker_2d: Marker2D = $Marker2D
const BULLET = preload("res://scenes/bullet.tscn")
@onready var timer: Timer = $Timer

func _input(event):
	if event.is_action_pressed("hold_gun"):
		visible = not visible


func _process(delta: float) -> void:
	if not visible:
		return
	look_at(get_global_mouse_position())
	
func shoot() -> void:
	if not visible:
		return
	
	var new_bullet = BULLET.instantiate()
	new_bullet.position = marker_2d.global_position
	new_bullet.target_position = (get_global_mouse_position() - marker_2d.global_position).normalized()
	GlobalData.level_1.add_child(new_bullet)


func _on_timer_timeout() -> void:
	pass # Replace with function body.
