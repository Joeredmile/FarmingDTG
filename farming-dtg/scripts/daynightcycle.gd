extends CanvasModulate

const NIGHT_COLOR = Color("#0b213fff")
const DAY_COLOR = Color("#ffffff")
const TIME_SCALE = 0.01

var time = 0
var time_scale := 1.0


func _process(delta: float) -> void:
	time += delta * TIME_SCALE
	color = DAY_COLOR.lerp(NIGHT_COLOR, abs(sin(time)))
	
	
	
	
