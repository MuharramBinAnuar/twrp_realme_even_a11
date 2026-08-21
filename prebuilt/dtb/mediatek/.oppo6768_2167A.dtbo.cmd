cmd_arch/arm64/boot/dts/mediatek/oppo6768_2167A.dtbo := mkdir -p arch/arm64/boot/dts/mediatek/ ; clang -E -Wp,-MD,arch/arm64/boot/dts/mediatek/.oppo6768_2167A.dtbo.d.pre.tmp -nostdinc -I../scripts/dtc/include-prefixes -I../arch/arm64/boot/dts -I../arch/arm64/boot/dts/include -I./include/ -Iarch/arm64/boot/dts -undef -D__DTS__ -x assembler-with-cpp -o arch/arm64/boot/dts/mediatek/.oppo6768_2167A.dtbo.dts.tmp ../arch/arm64/boot/dts/mediatek/oppo6768_2167A.dts ; dtc -@ -O dtb -o arch/arm64/boot/dts/mediatek/oppo6768_2167A.dtbo -b 0 -i../arch/arm64/boot/dts/mediatek/ -i../scripts/dtc/include-prefixes -q -Wno-unit_address_vs_reg -Wno-simple_bus_reg -Wno-unit_address_format -Wno-pci_bridge -Wno-pci_device_bus_num -Wno-pci_device_reg  -d arch/arm64/boot/dts/mediatek/.oppo6768_2167A.dtbo.d.dtc.tmp arch/arm64/boot/dts/mediatek/.oppo6768_2167A.dtbo.dts.tmp ; cat arch/arm64/boot/dts/mediatek/.oppo6768_2167A.dtbo.d.pre.tmp arch/arm64/boot/dts/mediatek/.oppo6768_2167A.dtbo.d.dtc.tmp > arch/arm64/boot/dts/mediatek/.oppo6768_2167A.dtbo.d

source_arch/arm64/boot/dts/mediatek/oppo6768_2167A.dtbo := ../arch/arm64/boot/dts/mediatek/oppo6768_2167A.dts

deps_arch/arm64/boot/dts/mediatek/oppo6768_2167A.dtbo := \
  ../scripts/dtc/include-prefixes/dt-bindings/interrupt-controller/irq.h \
  ../scripts/dtc/include-prefixes/dt-bindings/interrupt-controller/arm-gic.h \
  ../scripts/dtc/include-prefixes/dt-bindings/pinctrl/mt6768-pinfunc.h \
  ../scripts/dtc/include-prefixes/dt-bindings/pinctrl/mt65xx.h \
  ../arch/arm64/boot/dts/mediatek/bq2589x.dtsi \
  ../arch/arm64/boot/dts/mediatek/oppo6768_2167A/cust.dtsi \
  ../arch/arm64/boot/dts/mediatek/cust_mt6769_touch_720x1600.dtsi \
  ../arch/arm64/boot/dts/mediatek/cust_mt6769_camera_even.dtsi \
  ../arch/arm64/boot/dts/mediatek/cust_mt6768_touch_1080x2160.dtsi \
  ../arch/arm64/boot/dts/mediatek/sy6974.dtsi \

arch/arm64/boot/dts/mediatek/oppo6768_2167A.dtbo: $(deps_arch/arm64/boot/dts/mediatek/oppo6768_2167A.dtbo)

$(deps_arch/arm64/boot/dts/mediatek/oppo6768_2167A.dtbo):
