extends Control

class_name Shop

const CARROT_ITEM: InvItem = preload("res://inventory/items/carrot.tres")
@export var sell_bullet: PackedScene = preload("res://scenes/sellbullet.tscn")
@export var sell_plant: PackedScene = preload("res://scenes/sellplant.tscn")
@onready var h_box_container: HBoxContainer = $HBoxContainer
var player_ref: Node = null
@onready var log_label: Label = $Label

func _ready() -> void:
	#creates sell cards
	for i in range(1):
		var sell_plant_instance = sell_plant.instantiate()
		h_box_container.add_child(sell_plant_instance)
		
		var sell_bullet_instance = sell_bullet.instantiate()
		h_box_container.add_child(sell_bullet_instance)

func _on_button_pressed() -> void:
	sell_carrots()
	
#sells carots (I LOVE YOUTUBE)
func sell_carrots():
	if player_ref and player_ref.inv != null:
		var inv_ref: Inv = player_ref.inv
		if inv_ref:
			var want_to_sell: int = int(GlobalData.carrot_amount)
			if want_to_sell <= 0:
				log_label.text = "Come back when you have something..."
				$ResetTimer.start()
				return
			var removed: int = int(inv_ref.remove(CARROT_ITEM, want_to_sell))
			if removed > 0:
				GlobalData.coin_amount += removed *2
				GlobalData.carrot_amount -= removed
				log_label.text = "Sold %d carrots" % removed
				$ResetTimer.start()
				log_label.text = "%s\nCoins: %d" % [log_label.text, GlobalData.coin_amount]
				$ResetTimer.start()
			else:
				log_label.text = "No carrots found in inventory"
				$ResetTimer.start()

func _on_reset_timer_timeout() -> void:
	log_label.text = ""
