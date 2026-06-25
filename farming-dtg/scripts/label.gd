extends Label



func _process(delta):
	text = "Coins: " + str(GlobalData.coin_amount)
