extends Node2D

@onready var timer: Timer = $timer
@export var rabbit: PackedScene = preload("res://scenes/rabbit.tscn")
@export var bullet: PackedScene = preload("res://scenes/bullet.tscn")
@export var player: NodePath = NodePath("layer")

const NIGHT_COLOR = Color("#0b213fff")
var new_rabbit = null
@onready var canvas_modulate: CanvasModulate = $"../CanvasModulate"

#JOE THIS IS PAST YOU PLEASE FIX THIS

func _ready() -> void:
	if not player:
		player = get_tree().get_root().find_node("Player", true, false)

func _process(delta: float) -> void:
	if canvas_modulate.color.is_equal_approx(NIGHT_COLOR):
		timer.start()


func _on_timer_timeout() -> void:
	#spawn enemy
	var enemy = rabbit.instantiate()
	add_child(enemy)



#Color("#ffffff")
