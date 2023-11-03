extends Area2D

signal died

var width = 1.0
var height = width/3

var health = 10
var alive = true
var can_be_hitten = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Shadow.scale = Vector2(width, height)
	$Shadow.position = Vector2(-7, 125)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func hit(dmg):
	health -= dmg
	modulate = Color8(255, 120, 130)
	if(health <= 0):
		health = 0
		die()
		return 0
	$RedTimer.start()
	get_parent().get_node("Camera").apply_shake(10)


func die():
	alive = false
	get_parent().get_node("Camera").apply_shake(50)
	$AnimationPlayer.play("die")
	await $AnimationPlayer.animation_finished
	hide()
	emit_signal("died")

func _on_red_timer_timeout():
	modulate = Color(1, 1, 1)
	can_be_hitten = true


func _on_area_entered(area):
	if(alive and can_be_hitten and area.get_parent() and area.get_parent().multiplier_to_damage):
		var dmg = ceil(5 * area.get_parent().multiplier_to_damage)
		hit(dmg)
		can_be_hitten = false


func _on_timer_timeout():
	$AnimatedSprite2D.animation = "luffy"
	$AnimatedSprite2D.offset.x = -18
