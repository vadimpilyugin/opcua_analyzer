#! /usr/bin/env bash
ZEEK_PLUGIN_PATH=build/ zeek -r opc-ua-ap-method-wireshark-freeze.pcap opcua.zeek
