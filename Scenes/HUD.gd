extends CanvasLayer

var merchant_path = preload("res://Scenes/merchant.tscn")

func _ready():
	$Message/BlackGrad.size = get_viewport().get_visible_rect().size
	$Message/Message.size = get_viewport().get_visible_rect().size

func _process(delta):
	$Label.text = str(get_viewport().get_visible_rect().size)


func message(text, a):
	$Message.visible = true
	$Message/Message.text = text
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Message/BlackGrad, "modulate", Color(0, 0, 0, 0.8), 0.5)
	tween.tween_property($Message/Message, "modulate", Color(1, 1, 1, 1), 0.5)
	tween.chain().tween_property($Message/Message, "modulate", Color(1, 1, 1, 1), 0.5)
	await tween.finished
	if(a == "Wave"):
		message_end()
	elif(a == "Merchant"):
		var merchant = merchant_path.instantiate()
		add_child(merchant)
		
	elif(a == "Die"):
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func message_end():
	var tween = create_tween()
	tween.tween_property($Message/BlackGrad, "modulate", Color(0, 0, 0, 0), 0.5)
	tween.tween_property($Message/Message, "modulate", Color(1, 1, 1, 0), 0.5)

func _input(event):
	if event is InputEventScreenTouch:
		$Label2.text = str(event.position)
