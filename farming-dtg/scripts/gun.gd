extends Sprite2D
@onready var marker_2d: Marker2D = $Marker2D
const BULLET = preload("res://scenes/bullet.tscn")
@onready var timer: Timer = $"../timer"
@onready var bulletTimer: Timer = $bulletTimer
@onready var equiptimer: Timer = $Timer

func _ready() -> void:
	visible = false
	GlobalData.gun_equipped = false

func _input(event):
	if event.is_action_pressed("hold_gun") and GlobalData.gun_can_equip == true:
		if GlobalData.axe_equipped == false:
			visible = not visible
			if visible:
				GlobalData.gun_equipped = true
			if not visible:
				GlobalData.gun_equipped = false
			equiptimer.start()
			GlobalData.gun_can_equip = false
			print(GlobalData.gun_equipped)
		else:
			pass

	
func _on_timer_timeout() -> void:
	GlobalData.gun_can_equip = true
	

	

func _process(delta: float) -> void:
	if not visible:
		return
	look_at(get_global_mouse_position())

func shoot() -> void:
	if not visible:
		return
	if GlobalData.bullet_amount > 0:
		#bulletTimer.start()
		GlobalData.bullet_amount -= 1
		var new_bullet = BULLET.instantiate()
		new_bullet.position = marker_2d.global_position
		new_bullet.target_position = (get_global_mouse_position() - marker_2d.global_position).normalized()
		GlobalData.get_tree().current_scene.add_child(new_bullet)
	
