extends CharacterBody2D
class_name Enemy

@onready var carrot: AnimatedSprite2D = $".."
const DEAD_COLOR = Color("#000000")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"../player"
var SPEED = 100.0
@onready var timer: Timer = $Timer
@onready var canvas_modulate: CanvasModulate = $CanvasModulate


func _physics_process(delta: float) -> void:
	#where is the player
	var direction = (carrot.global_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()
	if direction.x != 0:
		$AnimatedSprite2D.flip_h = (direction.x < 0)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "bullet":
			canvas_modulate.color = DEAD_COLOR
			animated_sprite_2d.play("dead")
			animated_sprite_2d.rotate(-71)
			SPEED = 0
			timer.start()


			#canvas_modulate.color = Color.WHITE
			#var tween = create_tween()
			#tween.tween_property(canvas_modulate, "color", Color.BLACK, 3)


func _on_timer_timeout() -> void:
	queue_free()
