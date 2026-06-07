extends AnimatedSprite2D

@onready var timer: Timer = $Timer
var carrot_watered = false
var my_list = ["stage_3_a, stage_3_b"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("water"):
		carrot_watered = true
		timer.start()

func _on_timer_timeout():
	if carrot_watered:
		play("stage_2")
		timer.stop()
		carrot_watered = false

func _on_timer_2_timeout() -> void:
	if carrot_watered and animation == "stage_2":
		play(my_list.pick_random())# Picks a random animation from the list
		timer.stop()
		carrot_watered = false
	else:
		pass
