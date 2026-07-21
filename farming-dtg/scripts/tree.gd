extends AnimatedSprite2D

var can_break = false
const axe = preload("uid://taqwdb4ywctk")


func _ready() -> void:
	pass

func _process(delta):
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" and GlobalData.axe_equipped == true:
		if Input.is_action_pressed("interact"):
			can_break = true
			break_tree()
		
func break_tree():
		if can_break == true:
			can_break = false
			print("Break_tree working")
			queue_free()
	
