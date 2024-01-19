extends Node

@export var MAX_HP := 3
var hp = 3

func _ready() -> void:
	hp = MAX_HP

func give_damage(damage: int) -> void:
	hp -= damage
	hp = clampi(hp, 0, MAX_HP)
	
	if hp == 0:
		die() #СМЭРТЬ

func die() -> void:
	hp = MAX_HP
	$"..".global_position = Vector3.ZERO
