extends Sprite2D

@export var carrot_scene: PackedScene = preload("res://scenes/carrot.tscn")

var planted = false
var player_in_patch = false
var player_ref = null

#detects player
func _on_area_2d_body_entered(body):
	if body.name == "player":
		player_in_patch = true
		player_ref = body

#detects player
func _on_area_2d_body_exited(body):
	if body.name == "player":
		player_in_patch = false
		player_ref = null

#function for the input key
func _process(delta):
	if player_in_patch and Input.is_action_just_pressed("plant") and GlobalData.carrot_seeds > 0:
		plant_seed()

#resets land so plantable after harvested
func reset_patch():
	planted = false

#plants seed
func plant_seed():
	if planted:
		print("Already planted here")
		return
	var carrot = carrot_scene.instantiate()
	carrot.position = self.global_position
	get_parent().add_child(carrot)
	carrot.land_ref = self
	planted = true
	print("Planted a carrot! ", GlobalData.carrot_seeds ," remaining")
	GlobalData.carrot_seeds =- 1
	
