extends Node2D

var field_path = preload("res://Scenes/bg/field.tscn")
var mountain_path = preload("res://Scenes/bg/mountain.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
#	$Sun.position = Vector2(1150, -50)
#	$Sun.size.x = get_viewport_rect().size.x-1100
	
	$Moon/PointLight2D.enabled = false
	$Moon.size.x = get_viewport_rect().size.x
	$Moon.position = Vector2(get_viewport_rect().position.x, -$Moon.size.y - 1000)
#	$DarkRect.size = get_viewport_rect().size
#	$DarkRect.position.x = get_viewport_rect().position.x - 100
	
	
	spawn_lands(3)
	spawn_mountains(3)
	spawn_forest(3)


func next_wave():
	spawn_lands(1)
	spawn_mountains(1)
	spawn_forest(1)


func spawn_lands(count):
	for i in range(count):
		var land = field_path.instantiate()
		if($Lands.get_child_count() > 0):
			land.position.x = $Lands.get_child(-1).position.x+1280
		else:
			land.position.x = -1280
		land.position.y = 0
		land.frame = randi_range(0, 3)
		land.flip_h = randi_range(0, 1)
		$Lands.add_child(land)

func spawn_mountains(count):
	for i in range(count):
		var mountain = mountain_path.instantiate()
		if($Mountains.get_child_count() > 0):
			mountain.position.x = randi_range($Mountains.get_child(-1).position.x+900, $Mountains.get_child(-1).position.x+1280)
		else:
			mountain.position.x = randi_range(0, 1000)
		mountain.position.y = randi_range(400, 450)
		mountain.frame = randi_range(0, 2)
		mountain.flip_h = randi_range(0, 1)
		$Mountains.add_child(mountain)

func spawn_forest(count):
	for i in range(count):
		var forest = mountain_path.instantiate()
		forest.animation = "forest"
		if($Forest.get_child_count() > 0):
			forest.position.x = randi_range($Forest.get_child(-1).position.x+1000, $Forest.get_child(-1).position.x+1280)
		else:
			forest.position.x = randi_range(0, 1280)
		
		forest.position.y = randi_range(430, 500)
		forest.frame = randi_range(0, 2)
		forest.flip_h = randi_range(0, 1)
		$Forest.add_child(forest)
		#print(forest.position)



func day_night():
	var sun_tween = create_tween()
	sun_tween.tween_property($Sun, "position", get_viewport_rect().get_center(), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	sun_tween.tween_property($Sun, "position", get_viewport_rect().get_center() + Vector2(0, 200), 1)

	var dark_tween = create_tween()
	$Moon/PointLight2D.enabled = true
	dark_tween.tween_property($Moon, "position:y", get_viewport_rect().position.y+30, 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
