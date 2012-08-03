
default["memcached"] = {}

default["memcached"]["service_name"] = "memcached"

default["memcached"]["user"] = "memcached"
default["memcached"]["port"] = "11211"
default["memcached"]["listen_ip"] = "127.0.0.1" # use 0.0.0.0 to listen on all interfaces
default["memcached"]["pidfile"] = "/var/run/memcached.pid"
default["memcached"]["memory"] = "1024"
default["memcached"]["max_connections"] = "1024"
default["memcached"]["users"] = []
