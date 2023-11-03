extends RigidBody2D

var health = 10
var speed = 0
var soul = 5
var multiplier_to_hit = 1
var multiplier_to_damage = 1

var hited = false
var dying = false

#var dmg_particle_path = preload("res://Scenes/damage_particle.tscn")
var dmg_particle_path = preload("res://Scenes/damage.tscn")

func shadow(w:float, pos):
	$Shadow.position = pos
	$Shadow.scale = Vector2(w, w/3)

func _process(delta):
	$HealthBar.value = health


func _on_body_area_body_entered(body):
	hit(5, body)

func _on_head_area_body_entered(body):
	hit(9, body)

func _on_legs_area_body_entered(body):
	hit(3, body)

func hit(dmg: int, body):
	if(not hited):
		get_parent().get_parent().get_parent().get_node("Camera").apply_shake(dmg)
		dmg = ceil(dmg * multiplier_to_hit * pow(1.5, global.bow_damage_level-1))
		hited = true
		global.dmg = dmg
		health -= dmg
#
#		var dmg_particle = dmg_particle_path.instantiate()
#		dmg_particle.get_node("Particle").emitting = true
#		dmg_particle.global_position = body.global_position
#		get_parent().get_parent().get_node("DmgParticle").add_child(dmg_particle)
#		get_parent().get_parent().get_node("Label").text = str(dmg_particle.position)
		var dmg_particle = dmg_particle_path.instantiate()
		dmg_particle.text = str(dmg)
		dmg_particle.global_position = body.global_position
		get_parent().add_child(dmg_particle)
		
		body.queue_free()
		if(health <= 0):
			die()
			global.session_kills += 1
		
		hited = false
		modulate = Color8(255, 120, 130, 255)
		$RedTimer.start()

func die():
	dying = true
	health = 0
	speed = 0
	
	var area2DNodes = ["Skeleton2D/BodyBone/BodyArea", "Skeleton2D/BodyBone/HeadBone/HeadArea", "Skeleton2D/LegsArea"]
	
	for area2D in area2DNodes:
		get_node_or_null(area2D).queue_free()
	
	global.score_gain(1, soul)
	global.wave_kills += 1
	
	$SoulParticles.position = $Skeleton2D.position
	$SoulParticles.emitting = true
	
	$AnimationPlayer.play("die")
	var fade_tween = create_tween()
	fade_tween.tween_property(self, "modulate", Color(1, 1, 1, 0.2), 1.5)
	await fade_tween.finished
	hide()
	await get_tree().create_timer(0.5).timeout
	queue_free()

func _on_red_timer_timeout():
	modulate = Color(1, 1, 1, 1)
