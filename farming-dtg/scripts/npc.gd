extends CharacterBody2D

@onready var dialog_label: Label = $DialogLabel
@onready var resettimer: Timer = $resettimer
var chat_variants = ["I've missed you so much grandson!",
 "Press E to interact!", "I for inventory!", "so excited your here boy!"]

const speed = 40

var dir = Vector2.RIGHT
var start_pos

var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

var current_state = IDLE

func _ready():
	randomize()
	start_pos = position

func _process(delta):
	if current_state == IDLE or current_state == NEW_DIR:
		$AnimatedSprite2D.play("idle")
	elif current_state == MOVE and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("walk_w")
		if dir.x == 1:
			$AnimatedSprite2D.play("walk_e")
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_n")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk_s")
	if Input.is_action_just_pressed("interact") and player_in_chat_zone == true:
		_chat()

	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)

func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
	if !is_chatting:
		position += dir * speed * delta

func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player = body
		player_in_chat_zone = true
		is_chatting = true

func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_in_chat_zone = false
		is_chatting = false

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
	$Timer.start()

func _chat():
	dialog_label.text = chat_variants.pick_random()
	$resettimer.start()
	
	

func _on_resettimer_timeout() -> void:
	dialog_label.text = ""
