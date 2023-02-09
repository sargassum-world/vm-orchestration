client {
  enabled = true
}

plugin "docker" {
  config {
    allow_caps = ["net_bind_service"]

    volumes {
      enabled = true
    }
  }
}
