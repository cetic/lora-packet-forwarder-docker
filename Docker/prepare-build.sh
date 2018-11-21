#!/bin/sh -xe

apk add build-base git libftdi1-dev
ln -s /usr/include/libftdi1/ftdi.h /usr/include/ftdi.h
