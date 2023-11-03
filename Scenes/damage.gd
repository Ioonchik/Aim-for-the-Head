extends Label

var speed = randi_range(500, 600)

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	rotation_degrees = randi_range(-50, 50)
	var s = randf_range(0.9, 1.2)
	scale = Vector2(s, s)
	
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 1)
	await tween.finished
	queue_free()


func _physics_process(delta):
	position.y -= speed*delta
