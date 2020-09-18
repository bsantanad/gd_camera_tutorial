extends State

var player: Player
var skin: Mannequiny

# The same trick we used before, we wait until
# the Player node is ready, in order to take it's
# skin and himself.
func _ready() -> void:
	yield(owner, "ready")
	player = owner
	skin = player.skin 

