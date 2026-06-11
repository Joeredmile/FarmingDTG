extends CharacterBody2D

var target_position: Vector2
@export var speed : int = 700
var despawn_time = 1

func _ready() -> void:
	despawn()
	
func _physics_process(delta: float) -> void:
	velocity = target_position * speed
	move_and_slide()
	
func despawn() -> void:
	await get_tree().create_timer(despawn_time).timeout
	queue_free()
