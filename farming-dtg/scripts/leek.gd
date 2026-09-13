extends AnimatedSprite2D



var land_ref = null
@onready var waterprompt: Label = $waterprompt
@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2
@onready var timer_3: Timer = $Timer3
var player = null
var player_in_area = false
var leek_watered = false
var stage_4_variants = ["stage_4_a"]

@export var item: InvItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	#this is so i can only water the plant if im in its area
func _on_watering_body_entered(body: Node2D) -> void:
	if body.name == "player":
		waterprompt.text = "Press F to water."
		player_in_area = true
		waterprompt.visible = true
		player = body
		
		
func _on_watering_body_exited(body: Node2D) -> void:
	if body.name == "player":
		waterprompt.text = ""
		player_in_area = false
		waterprompt.visible = false


	#making it so i can water the plants
func _process(delta: float) -> void:
	if animation == "stage_1" and player_in_area:
		if Input.is_action_just_pressed("water"):
			waterprompt.visible = true
			waterprompt.text = "Watered!"
			leek_watered = true
			timer.start()
	if animation == "stage_2" and player_in_area:
		if Input.is_action_just_pressed("water"):
			waterprompt.visible = true
			waterprompt.text = "Watered!"
			leek_watered = true
			timer_2.start()
	if animation == "stage_3" and player_in_area:
		if Input.is_action_just_pressed("water"):
			waterprompt.visible = true
			waterprompt.text = "Watered!"
			leek_watered = true
			timer_3.start()
		else:
			pass

	if player_in_area and Input.is_action_just_pressed("interact"):
		if animation == "stage_4_a":
			player.collect(item)
			GlobalData.leek_amount += 1
			print(GlobalData.leek_amount)
			land_ref.reset_patch()
			queue_free()


	#watering logic for the carrots
func _on_timer_timeout():
	if leek_watered:
		play("stage_2")
		timer.stop()
		leek_watered = false


func _on_timer_2_timeout():
	if leek_watered and animation == "stage_2":
		play("stage_3")
		timer_2.stop()
		leek_watered = false
	else:
		pass


func _on_timer_3_timeout() -> void:
	if leek_watered and animation == "stage_3":
		play("stage_4_a")
		timer_3.stop()
		leek_watered = false
		GlobalData.leek_final_stage = true
	else:
		pass


func _on_text_timer_timeout() -> void:
	waterprompt.visible = false
	
	
	
	
	
	
