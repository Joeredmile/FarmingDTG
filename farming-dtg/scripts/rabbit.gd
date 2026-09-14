extends CharacterBody2D

class_name Enemy

const DEAD_COLOR = Color("#000000")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var plant: AnimatedSprite2D = get_tree().get_first_node_in_group("plant")
@onready var timer: Timer = $Timer
@onready var canvas_modulate: CanvasModulate = $CanvasModulate

var is_roaming = true
var dir = Vector2.RIGHT
var start_pos
const speed = 20
var SPEED = 20.0
enum {
	IDLE,
	NEW_DIR,
	MOVE
}





var current_state = IDLE

func _ready():
	randomize()
	start_pos = position
	
func _process(delta: float) -> void:
	if plant != null:
		var direction = (plant.global_position - global_position).normalized()
		velocity = direction * SPEED
		print("working")
		move_and_slide()
		if direction.x != 0:
			$AnimatedSprite2D.flip_h = (direction.x < 0)
			
	if plant == null:
		if current_state == IDLE or current_state == NEW_DIR:
			$AnimatedSprite2D.play("dead")
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

		if is_roaming:
			match current_state:
				IDLE:
					pass
				NEW_DIR:
					dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
				MOVE:
					move(delta)

			
			

func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
		position += dir * speed * delta


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "bullet":
			SPEED = 0
			canvas_modulate.color = DEAD_COLOR
			animated_sprite_2d.play("dead")
			animated_sprite_2d.rotate(-71)
			SPEED = 0
			timer.start()

func _on_timer_timeout() -> void:
	pass
	#queue_free()


func _on_timer_2_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
	$Timer.start()


func _on_detectplayer_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * SPEED
		print("player working")
		move_and_slide()
		if direction.x != 0:
			$AnimatedSprite2D.flip_h = (direction.x < 0)
