client {
  # Note: we're unable to force Nomad to schedule ports onto the IPv6 addresses of this interface,
  # so currently the only way we could do that would be to not assign IPv4 addresses to VMs on the
  # ZeroTier network (which would break Google Chrome's ability to access web apps over the ZeroTier
  # network).
  # See https://github.com/hashicorp/nomad/issues/6412 and
  # https://bugs.chromium.org/p/chromium/issues/detail?id=530482#c38
  # (though https://bugs.chromium.org/p/chromium/issues/detail?id=530482#c52 suggests a workaround,
  # but ZeroTier clients would need to enable global routes to public IP addresses)
  network_interface = "{{ GetPrivateInterfaces | include \"name\" \"zt.*\" | sort \"-type,size,name,address\" | limit 1 | attr \"name\" }}"
}
