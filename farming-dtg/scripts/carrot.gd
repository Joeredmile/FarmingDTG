extends AnimatedSprite2D

@onready var timer: Timer = $Timer
var carrot_watered = false

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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
