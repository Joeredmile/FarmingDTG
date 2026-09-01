extends Sprite2D

@export var carrot_scene: PackedScene = preload("res://scenes/carrot.tscn")
@onready var interactions_label: Label = $interactionslabel
@onready var resettimer: Timer = $resettimer


var player_ref = null

#detects player
func _on_area_2d_body_entered(body):
	if body.name == "player":
		interactions_label.text = "E to plant"
		GlobalData.player_in_patch = true
		player_ref = body

#detects player
func _on_area_2d_body_exited(body):
	if body.name == "player":
		interactions_label.text = ""
		GlobalData.player_in_patch = false
		player_ref = null

#function for the input key
func _process(delta):
	pass
 

#and GlobalData.carrot_seeds > 0:
#resets land so plantable after harvested
func reset_patch():
	GlobalData.planted = false

#plants seed
