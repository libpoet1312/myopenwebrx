#/bin/bash

number0=$(lsusb | awk '/RTL2838/ {print $2}')
number1=$(lsusb | awk '/RTL2838/ {print $4}')

if [ -z "$number0" ] || [ -z "$number1" ]
then
      echo "Device not found\n"
      exit(-1)
fi

path=$number0/${number1%?}

echo "Found rtl-sdr on bus $path"

sed -i "s+rtlsdrpath+/dev/bus/usb/$path+g" docker-compose.yml

docker compose up -d