extends Node2D

@onready var shopscene: Shop = $"../player/shopscene"
@onready var sellprompt: Label = $sellprompt
@export var shopscene_path: NodePath
@onready var timer: Timer = $Timer
@onready var shoptimer: Timer = $shoptimer

const CARROT_ITEM: InvItem = preload("res://inventory/items/carrot.tres")

var player_in_shop: bool = false
var player_ref: Node = null
var can_open_shop = true

func _ready() -> void:
	if shopscene_path != null and shopscene_path != NodePath(""):
		shopscene = get_node_or_null(shopscene_path) as Control
	if shopscene:
		shopscene.visible = false

func _on_shoparea_body_entered(body: Node) -> void:
	if body.name == "player":
		sellprompt.visible = true
		player_in_shop = true
		player_ref = body
		print("Player entered shop, player_ref set:", player_ref)

func _on_shoparea_body_exited(body: Node) -> void:
	if body.name == "player":
		sellprompt.visible = false
		player_in_shop = false
		player_ref = null
		print("Player left shop, player_ref cleared")

func _process(_delta: float) -> void:
	pass
		
		
#Toggle helpers
func _toggle_shop() -> void:
	if not shopscene:
		return
	if shopscene.visible:
		_close_shop()
		if shopscene.visible == false:
			print("not visible working")
	else:
		_open_shop()
		if shopscene.visible == true:
			print("visible working")

func _open_shop() -> void:
	shopscene.player_ref = player_ref
	shopscene.log_label.text = ""
	shopscene.visible = true
	sellprompt.visible = false

func _close_shop() -> void:
	shopscene.visible = false
	sellprompt.visible = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		if player_in_shop or shopscene.visible:
			if can_open_shop == true:
				_toggle_shop()
				shoptimer.start()
	


func _on_shoptimer_timeout() -> void:
	can_open_shop == !can_open_shop
