hostip=$(grep nameserver /etc/resolv.conf|awk '{print $2}')
http_port=7890
socks5_port=7891
export https_proxy="https://${hostip}:${http_port}"
export http_proxy="http://${hostip}:${http_port}"
export all_proxy="socks5://${hostip}:${socks5_port}"
