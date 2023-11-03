extends Area2D

var width = 1.5
var height = width/3

# Called when the node enters the scene tree for the first time.
func _ready():
	$Shadow.position = Vector2(0, 40)
	$Shadow.scale = Vector2(width, height)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
