extends Node3D

var player := preload("res://player.tscn")
var other_player := preload("res://other_player.tscn")

func _ready() -> void:
	create_player()
	create_other_players()

func create_player() -> void:
	var plr_inst := player.instantiate()
	
	var nick_name: String = NW.players[multiplayer.get_unique_id()].name
	
	plr_inst.name = str(multiplayer.get_unique_id())
	plr_inst.set_nick(nick_name)
	$Players.add_child(plr_inst)

func create_other_players() -> void:
	for i in multiplayer.get_peers():
		var oth_inst := other_player.instantiate()
		
		var nick_name: String = NW.players[i].name
		
		oth_inst.name = str(i)
		
		oth_inst.set_nick(nick_name)
		$Players.add_child(oth_inst)


