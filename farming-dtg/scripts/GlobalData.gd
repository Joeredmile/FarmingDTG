extends Node
@onready var level_1 = $"../level_1"
@onready var player: CharacterBody2D = get_node("/root/level_1/player")
@onready var bullet_timer: Timer = $bulletTimer

var carrot_amount = 0
var coin_amount = 0
var collisons = false
var carrot_seeds = 1
var bullet_amount = 5
var axe_equipped = true
var wood_amount = 0
var gun_equipped = false
var gun_can_equip = true
var axe_can_equip = true
var leek_seeds = 0
var leek_amount = 0
var player_in_patch = false
var planted = false
var carrot_final_stage = false
var leek_final_stage = false
