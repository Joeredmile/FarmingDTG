extends Node2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var interactions_label: Label = $interactionslabel

var can_enter = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_enter == true:
		get_tree().current_scene.get_node("campfire").visible = true
		can_enter = false
		interactions_label.text = ""

		queue_free()

		player.global_position = GlobalData.outside_house_position


func _on_door_body_entered(body: Node2D) -> void:
	if body.name == "player":
		interactions_label.text = "E to leave"
		can_enter = true


func _on_door_body_exited(body: Node2D) -> void:
	if body.name == "player":
		interactions_label.text = ""
		can_enter = false
