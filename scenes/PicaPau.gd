extends Node2D

var hasHit : bool = false
#var sounds := [$wp1, $wp2, $wp3, $wp4]

func _process(delta):
	position.x -= 10.0
	if position.x < get_parent().get_node("Player").position.x - 3000:
		queue_free()
	for entity in $Wp.get_overlapping_bodies():
		if entity == get_parent().get_node("Player") && !hasHit:
			hasHit = true
			get_parent().get_node("Player").hunger -= 2
			$wp1.play()
			$toucan1.play()

