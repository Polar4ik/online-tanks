extends Node


@onready var networking_node := $"../../..".get_child(0)

#func _on_player_change_pos() -> void:
	#networking_node.get_child(0).synch_pos.rpc(multiplayer.get_unique_id(), $"..".global_position)
#
#func _on_player_change_rotation() -> void:
	#networking_node.synch_rot.rpc(multiplayer.get_unique_id(), $"..".global_rotation)


func synch_postion() -> void:
	networking_node.synch_pos.rpc(multiplayer.get_unique_id(), $"..".global_position)

func sync_rotation() -> void:
	networking_node.synch_rot.rpc(multiplayer.get_unique_id(), $"..".global_rotation)

func _on_update_time_timeout() -> void:
	synch_postion()
	sync_rotation()
