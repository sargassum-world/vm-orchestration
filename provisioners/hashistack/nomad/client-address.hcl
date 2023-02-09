client {
  network_interface = "{{ GetPrivateInterfaces | include \"name\" \"zt.*\" | sort \"-type,size,name,address\" | limit 1 | attr \"name\" }}"
}
