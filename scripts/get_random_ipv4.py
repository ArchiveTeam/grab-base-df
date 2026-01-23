import errno
import ipaddress
import random
import socket


def main() -> int:
    for _ in range(500):
        random_ip = format(ipaddress.IPv4Address((127 << 24) | random.getrandbits(24)))
        for sock_type in (socket.SOCK_STREAM, socket.SOCK_DGRAM):
            with socket.socket(type=sock_type) as s:
                try:
                    s.bind((random_ip, 53))
                except OSError:
                    break
        else:
            print(random_ip)
            break
    else:
        raise Exception('Could not find usable random IP.')

if __name__ == '__main__':
    main()

