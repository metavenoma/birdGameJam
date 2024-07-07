extends Area2D

var bird = preload("res://scenes/PicaPau.tscn")
var destroy : bool = false
var spawn : bool = false
var defensors : int

func _process(delta):
	if self.has_overlapping_bodies():
		if 		get_parent().get_parent().get_parent().get_node("Player").hunger < 10:
			get_parent().get_parent().get_parent().get_node("Player").hunger += 3
		if not spawn:	
			defensors = randi_range(4, 8)
			spawn = true
		else:
			defensors = 0
		for enemy in defensors:
			var instance = bird.instantiate()
			instance.position.x = get_parent().get_parent().get_parent().get_node("Player").position.x + 2040 + randf_range(0, 512)
			var playerY = get_parent().get_parent().get_parent().get_node("Player").position.y
			if playerY - 128 < 56:
				instance.position.y = randf_range(56, 312)
			elif playerY + 128 > 1024:
				instance.position.y = randf_range(768, 1024)
			else:
				instance.position.y = randf_range(playerY - 128, playerY + 128)
			get_parent().get_parent().get_parent().add_child(instance)
		destroy = true
		$"../Sprite2D".hide()
		$"../Crack".play()
	if not $"../Crack".is_playing() && destroy:
		get_parent().queue_free()
