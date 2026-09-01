extends Control


@onready var land: Sprite2D = $land
@export var leek_scene: PackedScene = preload("res://scenes/leek.tscn")
@export var carrot_scene: PackedScene = preload("res://scenes/carrot.tscn")
@onready var label: Label = $Label
@onready var carrot_button: Button = $carrot_button
@onready var leek_button: Button = $leek_button
@onready var resettimer: Timer = $resettimer




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func reset_patch():
	GlobalData.planted = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalData.player_in_patch and Input.is_action_just_pressed("plant"):
		ui()


func ui():
	visible = true
 

func _on_carrot_button_pressed() -> void:
	plant_carrot()


func _on_leek_button_pressed() -> void:
	plant_leek()


func plant_leek():
	visible = false
	if GlobalData.planted:
		label.text = "Already planted here"
		$leek_button.hide()
		$resettimer.start()
		return
	var leek = leek_scene.instantiate()
	leek.position = self.global_position
	get_parent().add_child(leek)
	leek.land_ref = self
	GlobalData.planted = true
	GlobalData.leek_seeds -= 1
	label.text = "Planted a leek!"
	$resettimer.start()
	
	
#plants seed
func plant_carrot():
	visible = false
	if GlobalData.planted:
		label.text = "Already planted here"
		$leek_button.hide()
		$resettimer.start()
		return
	var carrot = carrot_scene.instantiate()
	carrot.position = self.global_position
	get_parent().add_child(carrot)
	carrot.land_ref = self
	GlobalData.planted = true
	GlobalData.carrot_seeds -= 1
	label.text = "Planted a carrot!"
	$resettimer.start()

func _on_resettimer_timeout() -> void:
	visible = false
	label.text = ""
