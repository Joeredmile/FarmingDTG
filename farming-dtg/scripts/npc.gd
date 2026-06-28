extends CharacterBody2D

@onready var dialog_box = get_tree().get_first_node_in_group("dialog")

const speed = 40

var dialog_lines = [
	"Hello there!",
	"Nice weather today.",
	"Be careful out there.",
    "I’ve been walking around all day."
]

var dialog_index = 0



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
	if player_in_chat_zone and Input.is_action_just_pressed("ui_accept"):
		dialog_index = (dialog_index + 1) % dialog_lines.size()
		show_dialog()
	
	if current_state == IDLE or current_state == NEW_DIR:
		$AnimatedSprite2D.play("idle")
	elif current_state == 2 and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("walk_w")
		if dir.x == 1:
			$AnimatedSprite2D.play("walk_e")
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_n")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk_s")
	
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
	if is_chatting == false:
		position += dir * speed * delta


func show_dialog():
	if dialog_box:
		dialog_box.get_node("DialogLabel").text = dialog_lines[dialog_index]
		dialog_box.visible = true
	else:
		print("DialogBox not found in group 'dialog'")

func hide_dialog():
	if dialog_box:
		dialog_box.visible = false

func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	if body.name == ("player"):
		player = body
		player_in_chat_zone = true
		is_chatting = true
		show_dialog()
		

func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body.name == ("player"):
		player_in_chat_zone = false
		hide_dialog()


func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
	$Timer.start()
