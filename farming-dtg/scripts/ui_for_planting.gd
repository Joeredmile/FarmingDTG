extends Control

var land: Node2D = null
@export var leek_scene: PackedScene = preload("res://scenes/leek.tscn")
@export var carrot_scene: PackedScene = preload("res://scenes/carrot.tscn")
@onready var label: Label = $Label
@onready var carrot_button: Button = $carrot_button
@onready var leek_button: Button = $leek_button
@onready var resettimer: Timer = $resettimer
var no_ui = false


func _ready() -> void:
	pass # Replace with function body.

func reset_patch():
	GlobalData.planted = false

func _process(delta):
	if GlobalData.player_in_patch and Input.is_action_just_pressed("plant"):
		#open UI only when its got a land reference and that specific land is not planted
		if land != null and not land.planted:
			if not visible:
				ui()

func ui():
	if land == null:
		#pushes an error to the console without stopping the game
		push_error("UI opened without a land reference")
		return
	visible = true
	#if the player has no seeds it says that then closes
	if GlobalData.carrot_seeds <= 0 and GlobalData.leek_seeds <= 0:
		label.text = "You have no seeds"
		$carrot_button.visible = false
		$leek_button.visible = false
		$resettimer.start()
		return
	if land.planted:
		label.text = "Already planted here"
	else:
		label.text = "Choose a seed"
	#show buttons to plant seed only when the player has at least one seed of that type
	$carrot_button.visible = (GlobalData.carrot_seeds > 0)
	$leek_button.visible   = (GlobalData.leek_seeds > 0)



func _on_carrot_button_pressed() -> void:
	plant_carrot()

func _on_leek_button_pressed() -> void:
	plant_leek()


func plant_leek():
	visible = false
	#check land exists before doing anything
	if land == null:
		push_error("plant_leek called but land is null")
		return
	#if this patch is already planted, tell player and update buttons then exit
	if land.planted:
		label.text = "Already planted here"
		$leek_button.visible   = (GlobalData.leek_seeds > 0)
		$carrot_button.visible = (GlobalData.carrot_seeds > 0)
		$resettimer.start()
		return
	#instantiate leek and ensure both leek and land are valid
	var leek = leek_scene.instantiate()
	if not is_instance_valid(leek) or not is_instance_valid(land):
		print("Cannot move leek. Land or leek has been freed/destroyed.")
		return
	#place leek at the land position and set its reference
	leek.global_position = land.global_position
	land.get_parent().add_child(leek)
	leek.land_ref = land
	#subtract one from leek seeds and mark patch planted and and update UI buttons
	GlobalData.leek_seeds -= 1
	land.planted = true
	$leek_button.visible   = (GlobalData.leek_seeds > 0)
	$carrot_button.visible = (GlobalData.carrot_seeds > 0)
	#inform player and start the UI reset timer
	label.text = "Planted a leek!"
	$resettimer.start()


func plant_carrot():
	visible = false
	#check land actually exists before doing anything
	if land == null:
		#logs an error message but dosent stop anything
		push_error("plant_carrot called but land is null")
		return
		#if this patch is already planted, tell player and update buttons then exit
	if land.planted:
		label.text = "Already planted here"
		$leek_button.visible   = (GlobalData.leek_seeds > 0)
		$carrot_button.visible = (GlobalData.carrot_seeds > 0)
		$resettimer.start()
		return
	#instantiate carrot and ensure both carrot and land are valid
	var carrot = carrot_scene.instantiate()
	if not is_instance_valid(carrot) or not is_instance_valid(land):
		print("Cannot move carrot. Land or carrot has been freed/destroyed.")
		return
	#place carrot at the land position and set its reference
	carrot.global_position = land.global_position
	land.get_parent().add_child(carrot)
	carrot.land_ref = land
	#subtract one from carrot seeds and mark patch planted and and update UI buttons
	GlobalData.carrot_seeds -= 1
	land.planted = true
	$leek_button.visible   = (GlobalData.leek_seeds > 0)
	$carrot_button.visible = (GlobalData.carrot_seeds > 0)
	#inform player and start the UI reset timer
	label.text = "Planted a carrot!"
	$resettimer.start()


func _on_resettimer_timeout() -> void:
	visible = false
	label.text = ""
	$leek_button.visible   = (GlobalData.leek_seeds > 0)
	$carrot_button.visible = (GlobalData.carrot_seeds > 0)
