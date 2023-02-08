addresses {
  http = "0.0.0.0"
  rpc = "{{ GetPrivateInterfaces | include \"name\" \"zt.*\" | limit 1 | attr \"address\" | limit 1 }}"
  serf = "{{ GetPrivateInterfaces | include \"name\" \"zt.*\" | limit 1 | attr \"address\" | limit 1 }}"
}
