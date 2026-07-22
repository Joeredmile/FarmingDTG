extends PointLight2D

@onready var canvas_modulate: CanvasModulate = get_node_or_null("level_1/CanvasModulate") as CanvasModulate
@onready var point_light_2d: PointLight2D = null

const NIGHT_COLOR = Color("#0b213fff")
const DAY_COLOR = Color("#ffffff")
const TIME_SCALE = 0.005

var light_visible = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if canvas_modulate == null:
		return
	visible = canvas_modulate.color.is_equal_approx(NIGHT_COLOR)

func lighton():
	if light_visible == true:
		visible = true
