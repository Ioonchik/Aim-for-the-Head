extends Node

var product_tex = preload("res://Sprites/HUD/Upgrades/ShopProduct.svg")
var product_tex_press = preload("res://Sprites/HUD/Upgrades/ShopProduct_press.svg")

var bg_tween
var label_tween

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("label")
	
	for i in get_tree().get_nodes_in_group("button"):
		i.connect("button_down", button_down.bind(i.get_parent()))
		i.connect("button_up", button_up.bind(i.get_parent()))
	
	for i in get_tree().get_nodes_in_group("product_bttn"):
		i.connect("button_down", button_down.bind(i.get_node("Sprite2D")))
		i.connect("button_up", button_up.bind(i.get_node("Sprite2D")))
		i.connect("pressed", button_pressed.bind(i.get_node("Sprite2D")))
	
	for i in get_tree().get_nodes_in_group("buy"):
		i.connect("pressed", buy_button_pressed.bind(
			i.get_parent().get_parent().get_node(str(i.name)).get_node("Level"),
			i.get_parent().get_node("Price")))
	
	$FadeElements.size = get_viewport().get_visible_rect().size
	$Shop.visible = false
	$Shop.position = Vector2(get_viewport().get_visible_rect().size.x / 2, -1000)
	$PanelBG.visible = false
	$PanelBG.size = get_viewport().get_visible_rect().size
	
	for i in $Shop/Chosen.get_children():
		i.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Shop/Soul/Label.text = ": " + str(global.souls)


func button_down(bttn):
	bttn.scale = Vector2(0.85, 0.85)

func button_up(bttn):
	bttn.scale = Vector2(1, 1)

func _on_black_grad_button_pressed():
	$AnimationPlayer.stop()
	bg_tween = create_tween()
	bg_tween.tween_property($FadeElements, "modulate", Color(1, 1, 1, 0), 0.5)
	
	await bg_tween.finished
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


# Shop General
func _on_shop_button_pressed():
	shop()

func shop():
	$Shop.visible = true
	$Shop.position.y = -1000
	$PanelBG.visible = true
	var tween = create_tween().set_parallel()
	tween.tween_property($PanelBG, "color", Color(0, 0, 0, 0.3), 0.5)
	tween.tween_property($Shop, "position:y", 0, 0.5)

func _on_panel_bg_gui_input(event):
	if(event is InputEventScreenTouch):
		print("asd")
		if event.pressed:
			var tween = create_tween().set_parallel()
			tween.tween_property($PanelBG, "color", Color(0, 0, 0, 0.0), 0.5)
			tween.tween_property($Shop, "position:y", -1000, 0.5)
			await tween.finished
			$PanelBG.visible = false


# Shop buttons
# Product buttons
func _on_bow_button_pressed():
	$Shop/Chosen/Bow.visible = true


func button_pressed(spr):
	spr.texture = product_tex_press

func buy_button_pressed(level, price_label):
	if(global.souls >= global.bow_damage_price):
		global.souls -= global.bow_damage_price
		
		global.bow_damage_price = 50 * pow(1.5, global.bow_damage_level)
		price_label.text = str(global.bow_damage_price)
		level.get_child(global.bow_damage_level).visible = true
		
		
		global.bow_damage_level += 1





