#!/system/bin/sh
# USB init script for TWRP recovery

# Set USB controller
echo peripheral > /sys/class/udc/$(getprop sys.usb.controller)/device/../mode 2>/dev/null

# USB gadget setup
if [ -d /config/usb_gadget/g1 ]; then
    echo 0x2717 > /config/usb_gadget/g1/idVendor
    echo 0xFF48 > /config/usb_gadget/g1/idProduct
fi

exit 0
