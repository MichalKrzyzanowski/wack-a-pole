shader_type canvas_item;

uniform vec4 oldBase : source_color;
uniform vec4 oldShadow : source_color;
uniform vec4 oldAccent : source_color;

uniform vec4 base : source_color;
uniform vec4 shadow : source_color;
uniform vec4 accent : source_color;


void fragment()
{
	vec4 color = texture(TEXTURE, UV);
	
	if (color == oldBase) COLOR = base;
	else if (color == oldShadow) COLOR = shadow;
	else if (color == oldAccent) COLOR = accent;
	else COLOR = color;
}