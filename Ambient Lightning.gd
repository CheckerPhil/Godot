extends CanvasModulate

const NIGHT_COLOR = Color("#351e1e")
const DAY_COLOR = Color("#f6f0f0")
const TIME_SCALE = 0.05

var time = 0

func _process(delta:float) -> void:
	self.time += delta * TIME_SCALE
	self.color = NIGHT_COLOR.linear_interpolate(DAY_COLOR, abs(sin(time)))
