client {
  enabled = true
  network_interface = "{{ GetPrivateInterfaces | include \"name\" \"zt.*\" | sort \"-type,size,name,address\" | limit 1 | attr \"name\" }}"
}

plugin "docker" {
  config {
    allow_caps = ["net_bind_service"]

    volumes {
      enabled = true
    }
  }
}
