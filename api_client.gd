extends Node

## APIClient - HTTP запити до сервера

signal request_completed(data: Dictionary)
signal request_error(code: int, message: String)

var base_url: String = "http://localhost:8000/api/v1"
var auth_manager: Node

func _ready():
	# Чекаємо поки Core завантажиться
	await get_tree().process_frame
	auth_manager = get_node("/root/Core/AuthManager")

## GET запит
func get(endpoint: String) -> void:
	var headers = _build_headers()
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_response.bind(http))
	http.request(base_url + endpoint, headers)

## POST запит
func post(endpoint: String, data: Dictionary) -> void:
	var headers = _build_headers()
	headers.append("Content-Type: application/json")
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_response.bind(http))
	http.request(base_url + endpoint, headers, HTTPClient.METHOD_POST, JSON.stringify(data))

func _build_headers() -> PackedStringArray:
	var h = PackedStringArray()
	if auth_manager and auth_manager.token != "":
		h.append("Authorization: Bearer " + auth_manager.token)
	return h

func _on_response(result: int, code: int, headers: PackedStringArray, body: PackedByteArray, http: HTTPRequest) -> void:
	http.queue_free()
	
	if code >= 200 and code < 300:
		var json = JSON.parse_string(body.get_string_from_utf8())
		request_completed.emit(json if json else {})
	else:
		request_error.emit(code, "HTTP Error")
