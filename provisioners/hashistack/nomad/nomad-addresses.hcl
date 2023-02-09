addresses {
  http = "::"
  rpc = "{{ GetPrivateInterfaces | include \"name\" \"zt.*\" | sort \"-type,size,name,address\" | limit 1 | attr \"address\" }}"
  serf = "{{ GetPrivateInterfaces | include \"name\" \"zt.*\" | sort \"-type,size,name,address\" | limit 1 | attr \"address\" }}"
}

advertise {
  http = "{{ GetPrivateInterfaces | include \"name\" \"zt.*\" | sort \"-type,size,name,address\" | limit 1 | attr \"address\" }}"
  rpc = "{{ GetPrivateInterfaces | include \"name\" \"zt.*\" | sort \"-type,size,name,address\" | limit 1 | attr \"address\" }}"
  serf = "{{ GetPrivateInterfaces | include \"name\" \"zt.*\" | sort \"-type,size,name,address\" | limit 1 | attr \"address\" }}"
}
