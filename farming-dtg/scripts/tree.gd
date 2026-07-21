extends AnimatedSprite2D

var player = null
var can_break = false
const axe = preload("uid://taqwdb4ywctk")
var inside_tree_area2d = false
@export var item: InvItem

func _ready() -> void:
	pass

func _process(delta):
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player = body
		inside_tree_area2d = true
		if GlobalData.axe_equipped == true:
			can_break = true

func _input(event):
	if Input.is_action_pressed("interact"):
		if can_break == true and inside_tree_area2d == true:
			break_tree()
		
func break_tree():
		if can_break == true and inside_tree_area2d == true:
			player.collect(item)
			GlobalData.wood_amount += 1
			print("Wood: ", GlobalData.wood_amount)
			queue_free()
		else:
			pass
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	inside_tree_area2d = false
	can_break = false
	player = null
