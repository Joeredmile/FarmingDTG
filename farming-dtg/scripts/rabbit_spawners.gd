extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $timer
@export var rabbit: PackedScene = preload("res://scenes/rabbit.tscn")
@export var bullet: PackedScene = preload("res://scenes/bullet.tscn")
@export var player: NodePath = NodePath("layer")
@export var carrot: PackedScene = preload("res://scenes/carrot.tscn")
const NIGHT_COLOR = Color("#0b213fff")
var new_rabbit = null
@onready var canvas_modulate: CanvasModulate = $"../CanvasModulate"

#func _ready() -> void:
	#if not player:
	#	carrot = get_tree().get_root().find_node("carrot", true, false)


#func _physics_process(delta: float) -> void:
#	if player == null: return


func _on_timer_timeout() -> void:
	#spawn enemy
	var enemy = rabbit.instantiate()
	add_child(enemy)



#Color("#ffffff")
