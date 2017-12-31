extends Area2D

var active
var going_up

func _ready():
	active = true
	going_up = false
	$Tween.interpolate_property($Sprite, "position", $Sprite.position,\
			$Sprite.position + Vector2(0.0, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _on_Star_body_entered( body ):
	if active:
		get_node("/root/global").star_picked_up()
		$AnimationPlayer.play("fade_out")
		active = false

func _on_AnimationPlayer_animation_finished( name ):
	queue_free()

func _on_Tween_tween_completed( object, key ):
	if going_up:
		$Tween.interpolate_property($Sprite, "position", $Sprite.position,\
				$Sprite.position - Vector2(0.0, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
		going_up = false
	else:
		$Tween.interpolate_property($Sprite, "position", $Sprite.position,\
				$Sprite.position + Vector2(0.0, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
		going_up = true
	$Tween.start()
