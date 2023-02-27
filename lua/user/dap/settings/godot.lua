return {
  adapters = {
    godot = {
      type = "server",
      host = "127.0.0.1",
      port = "6006"
    }
  },
  configurations = {
    gdscript = {
      {
        type = "godot",
        request = "attach",
        name = "Launch scene",
        project = "${workspaceFolder}",
        launch_game_instance = false,
        launch_scene = false,
      }
    }
  }
}
