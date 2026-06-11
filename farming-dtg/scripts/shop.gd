extends Node2D

@onready var sellprompt: Label = $sellprompt

var player_in_shop = false
#detects player
func _on_shoparea_body_entered(body):
	if body.name == "player":
		sellprompt.visible = true
		player_in_shop = true
#detects player
func _on_shoparea_body_exited(body):
	if body.name == "player":
		sellprompt.visible = false
		player_in_shop = false
#function
func _process(delta):
	if player_in_shop and Input.is_action_just_pressed("interact"):
		sell_carrots()
#sells carots using global
func sell_carrots():
	if GlobalData.carrot_amount > 0:
		GlobalData.coin_amount += GlobalData.carrot_amount
		print("Sold", GlobalData.carrot_amount, "carrots")
		print("Coins:", GlobalData.coin_amount)
		GlobalData.carrot_amount = 0
	else:
		print("No carrots to sell")
