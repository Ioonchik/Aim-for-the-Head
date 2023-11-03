extends Node2D

var product_positions = [355, 545, 735, 925] #368

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Next/NextButton.connect("button_down", button_down.bind($Next))
	$Next/NextButton.connect("button_up", button_up.bind($Next))
	
	var pos_x = get_viewport().get_visible_rect().size.x - 1280
	position = Vector2(pos_x, -600)
	
	product_positions.shuffle()
	for i in $Products.get_children():
		i.position = Vector2(product_positions[0], 368)
		i.get_node("Button").connect("button_down", button_down.bind(i))
		i.get_node("Button").connect("button_up", button_up.bind(i))
		i.get_node("Button").connect("pressed", purchase.bind(i))
	
	var create_tween = create_tween()
	create_tween.tween_property(self, "position", Vector2(pos_x, 50), 0.3)
	create_tween.tween_property(self, "position", Vector2(pos_x, 0), 0.05)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$SoulText.text = ": " + str(global.souls)

func button_down(prod):
	prod.scale = Vector2(0.8, 0.8)

func button_up(prod):
	prod.scale = Vector2(1, 1)

func purchase(prod):
	if(prod.name == '1'):
		if(global.souls >= 20):
			global.souls -= 20
			global.bullets += 5
			if(global.bullets > global.max_bullets):
				global.bullets = global.max_bullets


func _on_next_button_pressed():
	var next_tween = create_tween()
	next_tween.tween_property(self, "position", Vector2(-50, 0), 0.05)
	next_tween.tween_property(self, "position", Vector2(1100, 0), 0.3)
	get_parent().message_end()
	await next_tween.finished
	get_parent().get_parent().get_node("Spawner").wave_start()
	get_parent().get_parent().get_node("Spawner").merchant_wave = randi_range(3, 6)
	get_parent().get_parent().get_node("Weapon").can_shoot = true
	queue_free()
