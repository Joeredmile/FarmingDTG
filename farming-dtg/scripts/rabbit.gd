extends CharacterBody2D
class_name Enemy

@onready var player: CharacterBody2D = $"../player"
const SPEED = 100.0

func _physics_process(delta: float) -> void:
	#where is the player
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "bullet":
		queue_free()
