extends Node2D

@onready var canvas_modulate: CanvasModulate = $"../CanvasModulate"
@onready var point_light_2d: PointLight2D = null

const NIGHT_COLOR = Color("#0b213fff")
const DAY_COLOR = Color("#ffffff")
const TIME_SCALE = 0.005

var light_visible = false

func _ready() -> void:
	not visible

func _process(delta: float) -> void:
	if canvas_modulate == null:
		return
	if canvas_modulate.color.is_equal_approx(NIGHT_COLOR):
		light_visible = true
		lighton()
	if canvas_modulate.color.is_equal_approx(DAY_COLOR):
		light_visible = false
		lightoff()

func lighton():
	if light_visible == true:
		visible = true
		
func lightoff():
	if light_visible == false:
		visible = false
	
