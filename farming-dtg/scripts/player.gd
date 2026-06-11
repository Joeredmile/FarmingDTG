extends CharacterBody2D

var last_dir := Vector2.DOWN
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var last_direction
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
	if dir != Vector2.ZERO:
		last_dir = dir

	var d = dir if dir != Vector2.ZERO else last_dir
	
	if d.x > 0:
		animated_sprite_2d.play("right" if dir != Vector2.ZERO else "idle_right")
	elif d.x < 0:
		animated_sprite_2d.play("left" if dir != Vector2.ZERO else "idle_left")
	elif d.y < 0:
		animated_sprite_2d.play("up" if dir != Vector2.ZERO else "idle_up")
	elif d.y > 0:
		animated_sprite_2d.play("down" if dir != Vector2.ZERO else "idle_down")
	
	
func _unhandled_input(event):
	if event.is_action_pressed("hold_gun"):
		$ballsprite.visible = not $ballsprite.visible
	
