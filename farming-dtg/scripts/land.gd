extends Sprite2D

@export var carrot_scene: PackedScene = preload("res://scenes/carrot.tscn")
@onready var interactions_label: Label = $interactionslabel
@onready var resettimer: Timer = $resettimer


var player_ref = null
var planted: bool = false

#detects player
func _on_area_2d_body_entered(body):
	if body.name == "player":
		if not planted:
			interactions_label.text = "E to plant"
		else:
			interactions_label.text = ""
		GlobalData.player_in_patch = true
		player_ref = body
		if body.has_node("UIForPlanting"):
			body.get_node("UIForPlanting").land = self

#detects player
func _on_area_2d_body_exited(body):
	if body.name == "player":
		interactions_label.text = ""
		GlobalData.player_in_patch = false
		if body.has_node("UIForPlanting"):
			body.get_node("UIForPlanting").land = null
		player_ref = null

#function for the input key
func _process(delta):
	pass


#resets land so plantable after harvested
func reset_patch():
	planted = false
	interactions_label.text = "E to plant"
