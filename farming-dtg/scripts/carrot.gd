extends AnimatedSprite2D

@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2
@onready var timer_3: Timer = $Timer3



var carrot_watered = false
var stage_3_variants = ["stage_3_a", "stage_3_b", "stage_3_c"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	
	
func _process(delta: float) -> void:
	if animation == "stage_1":
		if Input.is_action_just_pressed("water"):
			carrot_watered = true
			timer.start()
	if animation == "stage_2":
		if Input.is_action_just_pressed("water"):
			carrot_watered = true
			timer_2.start()
		else:
			pass

	
		
	
func _on_timer_timeout():
	if carrot_watered:
		play("stage_2")
		timer.stop()
		carrot_watered = false

func _on_timer_2_timeout():
	if carrot_watered and animation == "stage_2":
		play(stage_3_variants.pick_random())# Picks a random animation from the list
		timer_2.stop()
		carrot_watered = false
	else:
		pass


func _on_area_2d_body_entered(body: Node2D):
	if animation == "stage_3_a" or animation == "stage_3_b" or animation == "stage_3_c":
		Global.carrot_amount += 1
		print(Global.carrot_amount)
		queue_free()		
		
	else:
		pass
	
