extends Sprite2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var interactions_label: Label = $doorway/door/interactionslabel
@onready var doorway: AnimatedSprite2D = $doorway
@onready var timer: Timer = $Timer

var can_enter = false
var house_scene = preload("res://scenes/insidehouse.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_enter == true:
		doorway.play
		timer.start()
		
func _on_door_body_entered(body: Node2D) -> void:
	if body.name == "player":
		interactions_label.text = "E to enter"
		can_enter = true


func _on_door_body_exited(body: Node2D) -> void:
	if body.name == "player":
		#interactions_label.text = ""
		can_enter = false


func _on_timer_timeout() -> void:
		get_tree().current_scene.get_node("campfire").visible = false
		can_enter = false
		interactions_label.text = ""

		GlobalData.outside_house_position = player.global_position
		player.z_index = 501
		var house = house_scene.instantiate()
		get_tree().current_scene.add_child(house)

		var spawn = house.get_node("PlayerSpawn")
		player.global_position = spawn.global_position
