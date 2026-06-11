extends Node
@onready var level_1 = $"../level_1"
@onready var player: CharacterBody2D = get_node("/root/level_1/player")

var carrot_amount = 0
var coin_amount = 0
