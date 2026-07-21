extends CharacterBody2D

var shoot_cooldown = true
var last_dir := Vector2.DOWN
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var last_direction
@onready var gun: Sprite2D = $gun
@onready var timer: Timer = $timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const Gun = preload("uid://doiuxyiy42dpv")
const GUN = preload("res://scenes/gun.tscn")
@export var inv: Inv

func _ready() -> void:
	set_process_unhandled_input(true)



func _physics_process(delta: float) -> void:
	process_movement()
	move_and_slide()
	
	#Get the input direction and handle the movement/deceleration.
func process_movement() -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * SPEED
	
	play_animation(direction)


#shooting gun and start timer for cooldown
func _input(event: InputEvent) -> void:
	if shoot_cooldown:
		if event.is_action_pressed("shoot"):
			get_node("gun").shoot()
			timer.start()
			shoot_cooldown = false
	
	
	
	
#animations
func play_animation(dir: Vector2) -> void:
	if dir != Vector2.ZERO:
		last_dir = dir
		
#water can
	if Input.is_action_pressed("water"):
		var d = dir if dir != Vector2.ZERO else last_dir
		if d.x > 0:
			animated_sprite_2d.play("right" if dir != Vector2.ZERO else "water_right")
		elif d.x < 0:
			animated_sprite_2d.play("left" if dir != Vector2.ZERO else "water_left")
		elif d.y < 0:
			animated_sprite_2d.play("up" if dir != Vector2.ZERO else "water_up")
		elif d.y > 0:
			animated_sprite_2d.play("down" if dir != Vector2.ZERO else "water_down")
			


	else:
		var d = dir if dir != Vector2.ZERO else last_dir
		if d.x > 0:
			animated_sprite_2d.play("right" if dir != Vector2.ZERO else "idle_right")
		elif d.x < 0:
			animated_sprite_2d.play("left" if dir != Vector2.ZERO else "idle_left")
		elif d.y < 0:
			animated_sprite_2d.play("up" if dir != Vector2.ZERO else "idle_up")
		elif d.y > 0:
			animated_sprite_2d.play("down" if dir != Vector2.ZERO else "idle_down")



#shooting cooldown
func _on_timer_timeout() -> void:
	shoot_cooldown = true

func collect(item):
	inv.insert(item)
