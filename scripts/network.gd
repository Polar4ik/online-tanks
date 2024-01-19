extends Node

@rpc("any_peer", "unreliable")
func synch_pos(id: int, new_pos: Vector3) -> void:
	var players = get_parent().find_child("Players").get_children()
	
	for i in players:
		if i.name == str(id):
			i.global_position = new_pos

@rpc("any_peer", "unreliable")
func synch_rot(id: int, new_rot: Vector3) -> void:
	var players = get_parent().find_child("Players").get_children()
	
	for i in players:
		if i.name == str(id):
			i.global_rotation = new_rot
