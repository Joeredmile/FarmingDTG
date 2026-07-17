extends Control
class_name SellCard

@onready var card_frame: TextureRect = $TextureRect
var hovering: bool = false

func _process(_delta: float) -> void:
	if is_mouse_over_card():
		hovering = true
		card_frame.scale = Vector2(1.2, 1.2)
	else:
		hovering = false
		card_frame.scale = Vector2(1, 1)

#Detects if mouse is over card sprite
func is_mouse_over_card() -> bool:
	var mouse_pos: Vector2 = get_global_mouse_position()
	if not card_frame:
		return false
	var sprite_size: Vector2 = Vector2.ZERO
	if card_frame.texture:
		sprite_size = card_frame.texture.get_size()
	var sprite_rect = Rect2(card_frame.global_position, sprite_size)
	return sprite_rect.has_point(mouse_pos)
	

func _input(event: InputEvent) -> void:
	#Detects if mouse is hovering and clicks
	if event.is_action_pressed("left_click"):
		if event.pressed and hovering:
			#put my additional code here
			
			print("buy_carrots called. BEFORE -> Seeds:", GlobalData.carrot_seeds, "Coins:", GlobalData.coin_amount)
			if int(GlobalData.coin_amount) <= 0:
				print("Ur too brokie")
				return
			GlobalData.coin_amount -= 1
			GlobalData.carrot_seeds += 1
			print("buy_carrots finished. AFTER  -> Seeds:", GlobalData.carrot_seeds, "Coins:", GlobalData.coin_amount)

			
			
			
			
