extends Sprite2D
@onready var marker_2d: Marker2D = $Marker2D
const BULLET = preload("res://scenes/bullet.tscn")
@onready var timer: Timer = $"../timer"
@onready var bulletTimer: Timer = $bulletTimer
@onready var equiptimer: Timer = $Timer
var can_equip = true

func _input(event):
	if event.is_action_pressed("hold_gun") and can_equip == true:
		visible = not visible
		print("workings")
		equiptimer.start()
		can_equip = false
	
func _on_timer_timeout() -> void:
	can_equip = true
	

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
	
