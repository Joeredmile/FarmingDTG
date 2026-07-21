extends Sprite2D


func _input(event):
	if event.is_action_pressed("hold_axe"):
		visible = not visible


func _process(delta: float) -> void:
	if not visible:
		return
	look_at(get_global_mouse_position())
