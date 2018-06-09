# frozen_string_literal: true

# server 'your_server_ip', port: your_port_num, roles: [:web, :app, :db], primary: true
server '10.0.104.151', port: 22, roles: %i[web app db], primary: true
