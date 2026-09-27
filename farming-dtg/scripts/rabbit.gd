extends CharacterBody2D

class_name Enemy

const dead_color = Color("#000000")

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2
@onready var canvas_modulate: CanvasModulate = $CanvasModulate

var can_chase = false
var is_roaming = true
var dir = Vector2.RIGHT
var start_pos
var speed = 20.0

enum {
	IDLE,
	NEW_DIR,
	MOVE,
	CHASE
}



var current_state = IDLE

func _ready():
	randomize()
	start_pos = position
	
func _process(delta: float) -> void:
	#if theres a carrot it will find it and run towards it
	if GlobalData.carrots_placed != []:
		var carrot_chase = GlobalData.carrots_placed[0]
		var direction = (carrot_chase.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		if direction.x != 0:
			$AnimatedSprite2D.flip_h = (direction.x < 0)
			
	
			
	else:
		#idle
		if current_state == IDLE or current_state == NEW_DIR:
			$AnimatedSprite2D.play("dead")
			#move animations
		elif current_state == MOVE:
			if dir.x == -1:
				$AnimatedSprite2D.play("move")
				$AnimatedSprite2D.flip_h
			if dir.x == 1:
				$AnimatedSprite2D.play("move")
			if dir.y == -1:
				$AnimatedSprite2D.play("move")
				$AnimatedSprite2D.flip_h
			if dir.y == 1:
				$AnimatedSprite2D.play("move")
		#roaming part for when its just chilling on the map and theres no carrot placed, or player nearby
		if is_roaming:
			match current_state:
				IDLE:
					pass
				NEW_DIR:
					dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
				MOVE:
					move(delta)
		#if player gets close enough it will chase player until its gone
		if current_state == CHASE:
			if can_chase == true:
				var direction = (player.global_position - global_position).normalized()
				velocity = direction * speed
				move_and_slide()
				if direction.x != 0:
					$AnimatedSprite2D.flip_h = (direction.x < 0)
			
			
#choose new state
func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
		position += dir * speed * delta

#dying function
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "bullet":
		speed = 0
		canvas_modulate.color = dead_color
		animated_sprite_2d.play("dead")
		animated_sprite_2d.rotate(-50)
		speed = 0
		$Timer.start()
	

func _on_timer_timeout() -> void:
	queue_free()

#calling choose() func
func _on_timer_2_timeout() -> void:
	$Timer2.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
	$Timer2.start()


func _on_detectplayer_body_entered(body: Node2D) -> void:
	if body.name == "player":
		can_chase = true
		current_state = CHASE


func _on_detectplayer_body_exited(body: Node2D) -> void:
	if body.name == "player":
		can_chase = false
		current_state = IDLE
	
