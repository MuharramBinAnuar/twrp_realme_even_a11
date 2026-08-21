cmd_arch/arm64/boot/dts/mediatek/mt6768.dtb := mkdir -p arch/arm64/boot/dts/mediatek/ ; clang -E -Wp,-MD,arch/arm64/boot/dts/mediatek/.mt6768.dtb.d.pre.tmp -nostdinc -I../scripts/dtc/include-prefixes -I../arch/arm64/boot/dts -I../arch/arm64/boot/dts/include -I./include/ -Iarch/arm64/boot/dts -undef -D__DTS__ -x assembler-with-cpp -o arch/arm64/boot/dts/mediatek/.mt6768.dtb.dts.tmp ../arch/arm64/boot/dts/mediatek/mt6768.dts ; dtc -@ -O dtb -o arch/arm64/boot/dts/mediatek/mt6768.dtb -b 0 -i../arch/arm64/boot/dts/mediatek/ -i../scripts/dtc/include-prefixes -q -Wno-unit_address_vs_reg -Wno-simple_bus_reg -Wno-unit_address_format -Wno-pci_bridge -Wno-pci_device_bus_num -Wno-pci_device_reg  -d arch/arm64/boot/dts/mediatek/.mt6768.dtb.d.dtc.tmp arch/arm64/boot/dts/mediatek/.mt6768.dtb.dts.tmp ; cat arch/arm64/boot/dts/mediatek/.mt6768.dtb.d.pre.tmp arch/arm64/boot/dts/mediatek/.mt6768.dtb.d.dtc.tmp > arch/arm64/boot/dts/mediatek/.mt6768.dtb.d

source_arch/arm64/boot/dts/mediatek/mt6768.dtb := ../arch/arm64/boot/dts/mediatek/mt6768.dts

deps_arch/arm64/boot/dts/mediatek/mt6768.dtb := \
    $(wildcard include/config/mtk/gmo/ram/optimize.h) \
    $(wildcard include/config/mtk/met/mem/alloc.h) \
    $(wildcard include/config/microtrust/tee/support.h) \
    $(wildcard include/config/mtk/sec/video/path/support.h) \
    $(wildcard include/config/mtk/cam/security/support.h) \
    $(wildcard include/config/mtk/iommu/v2.h) \
    $(wildcard include/config/mtk/m4u.h) \
    $(wildcard include/config/mtk/gauge/version.h) \
    $(wildcard include/config/base.h) \
    $(wildcard include/config/tcpc/rt1711h.h) \
    $(wildcard include/config/mtk/enable/geniezone.h) \
    $(wildcard include/config/snd/sia81xx/pa.h) \
  ../scripts/dtc/include-prefixes/dt-bindings/interrupt-controller/arm-gic.h \
  ../scripts/dtc/include-prefixes/dt-bindings/interrupt-controller/irq.h \
  ../scripts/dtc/include-prefixes/dt-bindings/mmc/mt6768-msdc.h \
  ../scripts/dtc/include-prefixes/dt-bindings/memory/mt6768-larb-port.h \
  ../scripts/dtc/include-prefixes/dt-bindings/pinctrl/mt6768-pinfunc.h \
  ../scripts/dtc/include-prefixes/dt-bindings/pinctrl/mt65xx.h \
  ../scripts/dtc/include-prefixes/dt-bindings/gce/mt6768-gce.h \
    $(wildcard include/config/dirty.h) \
  ../scripts/dtc/include-prefixes/dt-bindings/clock/mt6768-clk.h \
  ../scripts/dtc/include-prefixes/dt-bindings/iio/mt635x-auxadc.h \
  ../scripts/dtc/include-prefixes/dt-bindings/mfd/mt6358-irq.h \
  ../arch/arm64/boot/dts/mediatek/bat_setting/mt6768_battery_prop.dtsi \
  ../arch/arm64/boot/dts/mediatek/bat_setting/mt6769_atl_battery_table_ext.dtsi \
  ../arch/arm64/boot/dts/mediatek/bat_setting/mt6769_sdi_battery_table_ext.dtsi \
  ../arch/arm64/boot/dts/mediatek/bat_setting/mt6769_atl_6000mah_battery_table_ext.dtsi \
  ../arch/arm64/boot/dts/mediatek/bat_setting/mt6769_sdi_6000mah_battery_table_ext.dtsi \
  ../arch/arm64/boot/dts/mediatek/mt6358.dtsi \
  ../arch/arm64/boot/dts/mediatek/cust_mt6768_msdc.dtsi \
    $(wildcard include/config/fpga/early/porting.h) \
  ../arch/arm64/boot/dts/mediatek/mt6370.dtsi \
  ../arch/arm64/boot/dts/mediatek/mt6370_pd.dtsi \
    $(wildcard include/config/oplus/charger/mtk6771.h) \
  ../arch/arm64/boot/dts/mediatek/tcpc_config_6769.dtsi \
  ../arch/arm64/boot/dts/mediatek/trusty.dtsi \
  ../arch/arm64/boot/dts/mediatek/mt6768-sia81xx.dtsi \

arch/arm64/boot/dts/mediatek/mt6768.dtb: $(deps_arch/arm64/boot/dts/mediatek/mt6768.dtb)

$(deps_arch/arm64/boot/dts/mediatek/mt6768.dtb):
