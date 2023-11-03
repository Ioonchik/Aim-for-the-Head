extends AnimatedSprite2D

var speed = randi_range(30, 70)

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = get_viewport_rect().size.x + 200
	position.y = 100
	frame = randi_range(0, 3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= speed * delta
	
	if(position.x <= -140):
		queue_free()
