extends Control
class_name Shop

const CARROT_ITEM: InvItem = preload("res://inventory/items/carrot.tres")
@export var sell_plant: PackedScene = preload("res://scenes/sellplant.tscn")
@onready var h_box_container: HBoxContainer = $HBoxContainer
var player_ref: Node = null


func _ready() -> void:
	#creates sell cards
	for i in range(1):
		var sell_plant_instance = sell_plant.instantiate()
		h_box_container.add_child(sell_plant_instance)

func _on_button_pressed() -> void:
	sell_carrots()
	
#sells carots (I LOVE YOUTUBE)
func sell_carrots():
	if player_ref and player_ref.inv != null:
		var inv_ref: Inv = player_ref.inv
		if inv_ref:
			var want_to_sell: int = int(GlobalData.carrot_amount)
			if want_to_sell <= 0:
				print("No carrots to sell")
				return
			var removed: int = int(inv_ref.remove(CARROT_ITEM, want_to_sell))
			if removed > 0:
				GlobalData.coin_amount += removed *2
				GlobalData.carrot_amount -= removed
				print("Sold", removed, "carrots")
				print("Coins:", GlobalData.coin_amount)
			else:
				print("No carrots found in inventory")
