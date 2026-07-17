extends CharacterBody2D

@onready var timer: Timer = $Timer
var target_position: Vector2
@export var speed : int = 1000
var despawn_time = 1
var collisions = false
func _ready() -> void:
	despawn()
	
func _physics_process(delta: float) -> void:
	velocity = target_position * speed
	move_and_slide()
	
func despawn() -> void:
	await get_tree().create_timer(despawn_time).timeout
	queue_free()


#func _on_timer_timeout() -> void:
	#collisions = true


#func _on_detection_body_entered(body: Node2D) -> void:
	#if collisions == true:
		#queue_free()
