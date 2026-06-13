extends Node2D

@onready var sellprompt: Label = $sellprompt
const CARROT_ITEM: InvItem = preload("res://inventory/items/carrot.tres")
var player_in_shop: bool = false
var player_ref: Node = null

#detects player
func _on_shoparea_body_entered(body):
	if body.name == "player":
		sellprompt.visible = true
		player_in_shop = true
		player_ref = body
		print("Player entered shop, player_ref set:", player_ref)

#detects player
func _on_shoparea_body_exited(body):
	if body.name == "player":
		sellprompt.visible = false
		player_in_shop = false
		player_ref = null
		print("Player left shop, player_ref cleared")


#function
func _process(delta):
	if player_in_shop and Input.is_action_just_pressed("interact"):
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
				GlobalData.coin_amount += removed
				GlobalData.carrot_amount -= removed
				print("Sold", removed, "carrots")
				print("Coins:", GlobalData.coin_amount)
			else:
				print("No carrots found in inventory")
				pass
	else:
		if GlobalData.carrot_amount > 0:
			GlobalData.coin_amount += GlobalData.carrot_amount
			print("Sold", GlobalData.carrot_amount, "carrots")
			print("Coins:", GlobalData.coin_amount)
			GlobalData.carrot_amount = 0
		else:
			print("No carrots to sell")

	#fall back if my new sell code dosent work
 	
