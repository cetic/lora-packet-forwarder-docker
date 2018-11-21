# LoRA Packet Forwarder

This git describes how to deploy a LoRA Packet Forwarder using Docker

## Installation

```
$ git clone https://github.com/cetic/lora-packet-forwarder-docker.git
$ sudo apt-get install docker docker-compose
```

## Build the image

The first step is to create the docker image
```
$ cd lora-packet-forwarder-docker/Docker
$ sudo docker build -t lora-packet-forwarder:latest .
```

## Configuration

In the "config/global_conf.json" JSON file, change this informatiion to connect your gateway with your LoRaServer:
- "gateway_ID"
- "server_address"
- "serv_port_up"
- "serv_port_down"
- (...)

```JSON
{
  ...
    "gateway_conf": {
        "gateway_ID": "AA555A0000000000",
        /* change with default server address/ports, or overwrite in local_conf.json */
        "server_address": "127.0.0.1",
        "serv_port_up": 1700,
        "serv_port_down": 1700,
        /* adjust the following parameters for your network */
        "keepalive_interval": 10,
        "stat_interval": 30,
        "push_timeout_ms": 100,
        /* forward only valid packets */
        "forward_crc_valid": true,
        "forward_crc_error": false,
        "forward_crc_disabled": false
    }
}
```

__Warning__ : keep the same `gateway_ID` in the 'local_conf.json' and 'global_conf.json'

## Run the container

### 1. Docker Compose

With the docker-compose tool, you don't need to change the USB interface (automatic research)

```
$ cd lora-packet-forwarder-docker
$ sudo docker-compose up -d
```
__Warning__ : If you work with your own DNS, add the docker DNS option to change the _nameserver_ in the container configuration : `dns - YOUR_DNS_IP_ADDR`

### 2. Docker

#### Get BUS & DEVICE interface

To run your packet forwarder container, you need to plug your antenna. Then, get the BUS and DEVICE number with the lsusd commande
```
$ lsusb
Bus 001 Device 002: ID 0403:6014 Future Technology Devices International, Ltd FT232H Single HS USB-UART/FIFO IC
```
In this example :
- BUS = 001
- DEVICE = 002

#### Docker RUN

To lauch the container replace :
- __AAAA__ <= BUS
- __BBBB__ <= DEVICE

```
$ cd lora-packet-forwarder-docker
$ sudo docker run -t --rm --device=/dev/bus/usb/AAAA/BBBB -v $(pwd)/config:/opt/pf-config lora-packet-forwarder
```
__Warning__ : If you work with your own DNS, add the docker DNS option to change the _nameserver_ in the container configuration : `--dns=YOUR_DNS_IP_ADDR`

## License

Todo

## Authors

* __Laurent Deru__ - mail : laurent.deru@cetic.be
* __Benjamin Bernaud__ - mail : benjamin.bernaud@cetic.be
