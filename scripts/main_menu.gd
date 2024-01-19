extends Control

var adress := "localhost"
var port := 8080

var peer: ENetMultiplayerPeer

func _ready() -> void:
	multiplayer.peer_connected.connect(peer_connect)
	multiplayer.peer_disconnected.connect(peer_disconnect)
	multiplayer.connected_to_server.connect(connect_to_server)
	multiplayer.connection_failed.connect(connect_failed)

func peer_connect(id: int) -> void:
	print("Peer connect: ", id)

func peer_disconnect(id: int) -> void:
	NW.players.erase(id)
	print("Peer disconnect: ", id)

func connect_to_server() -> void:
	print("Connect to server")
	
	add_info.rpc(multiplayer.get_unique_id(), $NickEdit.text)

func connect_failed() -> void:
	print("Connect failed")


func _on_host_button_button_down() -> void:
	peer = ENetMultiplayerPeer.new()
	
	var error := peer.create_server(port)
	
	if error == OK:
		multiplayer.multiplayer_peer = peer
		set_multiplayer_authority(multiplayer.get_unique_id())
		#peer.host.compress()
		print("Server create, wait players")
		add_info(multiplayer.get_unique_id(), $NickEdit.text)
	else:
		printerr("Server creating error ", error)

func _on_join_button_button_down() -> void:
	peer = ENetMultiplayerPeer.new()
	
	var error = peer.create_client(adress, port)
	
	if error == OK:
		multiplayer.multiplayer_peer = peer
		print("Client created: ", multiplayer.get_unique_id())
	else:
		print("Client created error: ", error)


@rpc("any_peer")
func add_info(id: int, plr_name: String) -> void:
	if not NW.players.has(id):
		NW.players[id] = {
			"id": id,
			"name": plr_name
		}
	
	if multiplayer.is_server():
		for i in NW.players:
			add_info.rpc(i, NW.players[i].name)


func _on_start_button_button_down() -> void:
	start_game.rpc()

@rpc("any_peer", "call_local")
func start_game() -> void:
	var map := preload("res://world.tscn").instantiate()
	
	$"..".add_child(map)
	hide()
