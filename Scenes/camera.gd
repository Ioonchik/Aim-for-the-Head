extends Camera2D

@export var randomStrength = 30.0
@export var shakeFade = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength = 0.0

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		
		offset = randomOfsset()

func apply_shake(strength = randomStrength):
	shake_strength = strength


func randomOfsset():
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))


