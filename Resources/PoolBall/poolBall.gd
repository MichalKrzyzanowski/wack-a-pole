extends Resource

class_name PoolBall

"""
type of ball, used to select color
"""
enum BallType
{
	WHITE = 0,
	YELLOW,
	RED,
	CUSTOM
}

@export var type := BallType.WHITE 

@export_category("Color")
@export var base := Color()
@export var shadow := Color()
@export var accent := Color()

"""
set color of the ball.
can be one of the preset colors by matching the ball type.
if ball type is custom, color is set to the three custom
colors: base, shadow, accent
"""
func setColor(material : ShaderMaterial) -> void:
	match type:
		BallType.WHITE:
			print("white")
			base = Color.WHITE
			shadow = Color.DIM_GRAY
			accent = Color.DIM_GRAY
		BallType.RED:
			print("red")
			base = Color.RED
			shadow = Color.DARK_RED
			accent = Color.WHITE
		BallType.YELLOW:
			print("yellow")
			base = Color.GOLD
			shadow = Color.GOLDENROD
			accent = Color.WHITE
			
	material.set_shader_parameter("base", base)
	material.set_shader_parameter("shadow", shadow)
	material.set_shader_parameter("accent", accent)

"""
ball type == comparison
"""
func checkType(ballType : BallType):
	return self.type == ballType
