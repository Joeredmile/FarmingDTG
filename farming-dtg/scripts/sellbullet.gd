extends Control

@onready var timer: Timer = $Timer
@onready var log_label: Label = $Label
@onready var card_frame: TextureRect = $TextureRect
var hovering: bool = false

func _input(event: InputEvent) -> void:
	#Detects if mouse is hovering and clicks
	if event.is_action_pressed("left_click"):
		if event.pressed and hovering:
			#put my additional code here
			
			print("buy_bullets called. bullets:", GlobalData.bullet_amount, "Coins:", GlobalData.coin_amount)
			if int(GlobalData.coin_amount) <= 0:
				_set_log_text("Ur too brokie")
				$ResetTimer.start()
				return
			GlobalData.bullet_amount -= 1
			GlobalData.bullet_amount += 1
			_set_log_text("KACHING SUCKER")
			$ResetTimer.start()

func _process(_delta: float) -> void:
	if is_mouse_over_card():
		hovering = true
		card_frame.scale = Vector2(1.2, 1.2)
	else:
		hovering = false
		card_frame.scale = Vector2(1, 1)

func _set_log_text(text: String) -> void:
	if log_label:
		log_label.text = text
	else:
		call_deferred("_set_log_text", text)

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

func _on_reset_timer_timeout() -> void:
	log_label.text = ""
