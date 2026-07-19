extends Node2D

@onready var shopscene: Shop = $"../player/shopscene"
@onready var sellprompt: Label = $sellprompt
@export var shopscene_path: NodePath
@onready var timer: Timer = $Timer

const CARROT_ITEM: InvItem = preload("res://inventory/items/carrot.tres")

var player_in_shop: bool = false
var player_ref: Node = null

func _ready() -> void:
	if shopscene_path != null and shopscene_path != NodePath(""):
		shopscene = get_node_or_null(shopscene_path) as Control
	if shopscene:
		shopscene.visible = false
	else:
		push_warning("shopscene not found. Set shopscene_path in the Inspector to the UI instance in your main scene.")

func _on_shoparea_body_entered(body: Node) -> void:
	if body.is_in_group("player") or body.name == "player":
		sellprompt.visible = true
		player_in_shop = true
		player_ref = body
		print("Player entered shop, player_ref set:", player_ref)

func _on_shoparea_body_exited(body: Node) -> void:
	if body.is_in_group("player") or body.name == "player":
		sellprompt.visible = false
		player_in_shop = false
		player_ref = null
		print("Player left shop, player_ref cleared")
		#If UI is open and player walks away, close it
		if shopscene and shopscene.visible:
			_close_shop()

func _process(_delta: float) -> void:
	if player_in_shop and Input.is_action_just_pressed("interact"):
		_toggle_shop()

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
	#show mouse
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#var default_btn = shopscene.get_node_or_null("BuyButton")
	#if default_btn:
	#	default_btn.grab_focus()
	sellprompt.visible = false

func _close_shop() -> void:
	shopscene.visible = false
	#get rid of mouse
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#sellprompt.visible = player_in_shop
	
