sudo ip tuntap add mode tap tapqemu && \
sudo ip addr add 192.168.50.1/24 dev tapqemu && \
sudo ip link set tapqemu up

