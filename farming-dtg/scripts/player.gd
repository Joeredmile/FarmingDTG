extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	process_movement()
	move_and_slide()
	
	#Get the input direction and handle the movement/deceleration.
func process_movement() -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * SPEED
	
	play_animation(direction)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		get_node("gun").shoot()

#animations
func play_animation(dir: Vector2) -> void:
	if dir.x > 0:
		animated_sprite_2d.play("right")
	if dir.x < 0:
		animated_sprite_2d.play("left")
	elif dir.y < 0:
		animated_sprite_2d.play("up")
	elif dir.y > 0:
		animated_sprite_2d.play("down")
