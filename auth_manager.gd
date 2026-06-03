extends Node

## AuthManager - керування авторизацією

signal login_success(token: String)
signal login_error(message: String)

var token: String = ""
var user_id: String = ""
var game_id: String = "game_1"

func _ready():
	_load_local_token()

## Guest вхід
func login_guest() -> void:
	var uuid = _generate_uuid()
	# TODO: відправити на сервер
	token = uuid
	user_id = uuid
	_save_token()
	login_success.emit(token)

## Google OAuth
func login_google(id_token: String) -> void:
	# TODO: верифікація через сервер
	pass

## Apple Sign In
func login_apple(identity_token: String) -> void:
	# TODO: верифікація через сервер
	pass

func is_authenticated() -> bool:
	return token != ""

func _save_token() -> void:
	var file = FileAccess.open("user://auth.token", FileAccess.WRITE)
	file.store_string(token)

func _load_local_token() -> void:
	if FileAccess.file_exists("user://auth.token"):
		var file = FileAccess.open("user://auth.token", FileAccess.READ)
		token = file.get_as_text()
		user_id = token

func _generate_uuid() -> String:
	# Простий UUID
	var rng = RandomNumberGenerator.new()
	var uuid = "%x-%x-%x-%x-%x" % [
		rng.randi(), rng.randi(), rng.randi(), rng.randi(), rng.randi()
	]
	return uuid
