// import chisel3._
// //import buraq_mini.core.Core
// import nucleusrv.components.Core
// import caravan.bus.common.{AddressMap, BusDecoder, Switch1toN,Peripherals}

// import caravan.bus.tilelink.{TLRequest, TLResponse, TilelinkConfig, TilelinkDevice, TilelinkError, TilelinkHost, TilelinkMaster, TilelinkSlave}
// import caravan.bus.wishbone.{WBRequest, WBResponse, WishboneConfig, WishboneDevice, WishboneHost, WishboneMaster, WishboneSlave}
// import caravan.bus.wishbone.{WishboneErr}
// import chisel3.experimental.Analog
// import chisel3.stage.ChiselStage
// import jigsaw.fpga.boards.artyA7._
// import jigsaw.rams.fpga.BlockRam
// import jigsaw.peripherals.gpio._
// import jigsaw.peripherals.spiflash._
// import jigsaw.peripherals.UART._

// // class Picofoxy(programFile: Option[String]) extends Module {
// //   val io = IO(new Bundle {
// //     val gpio_io = Vec(16, Analog(1.W))
// //   })

// //   val top = Module(new Top(programFile))
// //   val pll = Module(new PLL_8MHz())

// //   pll.io.clk_in1 := clock
// //   top.clock := pll.io.clk_out1

// //   val gpioInputWires = Wire(Vec(16, Bool()))
// //   val gpioOutputWires = Wire(Vec(16, Bool()))
// //   val gpioEnableWires = Wire(Vec(16, Bool()))

// //   val gpioPads = TriStateBuffer(quantity=16)
// //   val triStateBufferWires = for {
// //     ((((a,b),c),d),e) <- gpioPads zip gpioInputWires zip gpioOutputWires zip gpioEnableWires zip io.gpio_io
// //   } yield (a,b,c,d,e)

// //   triStateBufferWires map { case(buf: IOBUF, in: Bool, out: Bool, en: Bool, io: Analog) => {
// //     buf.io.connect(in, out, io, en)
// //   }}

// //   top.io.gpio_i := gpioInputWires.asUInt()
// //   gpioOutputWires := top.io.gpio_o.asBools()
// //   gpioEnableWires := top.io.gpio_en_o.asBools()

// // }


// // class Top(programFile: Option[String]) extends Module {
// //   val io = IO(new Bundle {
// //     val gpio_o = Output(UInt(16.W))
// //     val gpio_en_o = Output(UInt(16.W))
// //     val gpio_i = Input(UInt(16.W))
// //     //val gpio_intr_o = Output(UInt(32.W))
// //   })

// //   implicit val config: TilelinkConfig = TilelinkConfig()
// //   val tl_imem_host = Module(new TilelinkHost())
// //   val tl_imem_slave = Module(new TilelinkDevice())
// //   val tl_dmem_host = Module(new TilelinkHost())
// //   val tl_dmem_slave = Module(new TilelinkDevice())
// //   val tl_gpio_slave = Module(new TilelinkDevice())
// //   val imem = Module(BlockRam.createNonMaskableRAM(programFile, bus=config, rows=1024))
// //   val dmem = Module(BlockRam.createMaskableRAM(bus=config, rows=1024))
// //   val gpio = Module(new Gpio(new TLRequest(), new TLResponse()))
// //   val tlErr = Module(new TilelinkError())
// //   val core = Module(new Core(new TLRequest, new TLResponse))



// //   val addressMap = new AddressMap
// //   addressMap.addDevice(Peripherals.DCCM, "h40000000".U(32.W), "h00000FFF".U(32.W), tl_dmem_slave)
// //   addressMap.addDevice(Peripherals.GPIO, "h40001000".U(32.W), "h00000FFF".U(32.W), tl_gpio_slave)
// //   val devices = addressMap.getDevices

// //   val switch = Module(new Switch1toN(new TilelinkMaster(), new TilelinkSlave(), devices.size))

// //   // tl <-> Core (fetch)
// //   tl_imem_host.io.reqIn <> core.io.imemReq
// //   core.io.imemRsp <> tl_imem_host.io.rspOut
// //   tl_imem_slave.io.reqOut <> imem.io.req
// //   tl_imem_slave.io.rspIn <> imem.io.rsp

// //   // tl <-> tl (fetch)
// //   tl_imem_host.io.tlMasterTransmitter <> tl_imem_slave.io.tlMasterReceiver
// //   tl_imem_slave.io.tlSlaveTransmitter <> tl_imem_host.io.tlSlaveReceiver

// //   // tl <-> Core (memory)
// //   tl_dmem_host.io.reqIn <> core.io.dmemReq
// //   core.io.dmemRsp <> tl_dmem_host.io.rspOut
// //   tl_dmem_slave.io.reqOut <> dmem.io.req
// //   tl_dmem_slave.io.rspIn <> dmem.io.rsp


// //   // Switch connection
// //   switch.io.hostIn <> tl_dmem_host.io.tlMasterTransmitter
// //   switch.io.hostOut <> tl_dmem_host.io.tlSlaveReceiver
// //   for (i <- 0 until devices.size) {
// //     switch.io.devIn(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[TilelinkDevice].io.tlSlaveTransmitter
// //     switch.io.devOut(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[TilelinkDevice].io.tlMasterReceiver
// //   }
// //   switch.io.devIn(devices.size) <> tlErr.io.tlSlaveTransmitter
// //   switch.io.devOut(devices.size) <> tlErr.io.tlMasterReceiver
// //   switch.io.devSel := BusDecoder.decode(tl_dmem_host.io.tlMasterTransmitter.bits.a_address, addressMap)


// //   tl_gpio_slave.io.reqOut <> gpio.io.req
// //   tl_gpio_slave.io.rspIn <> gpio.io.rsp

// //   io.gpio_o := gpio.io.cio_gpio_o(15,0)
// //   io.gpio_en_o := gpio.io.cio_gpio_en_o(15,0)
// //   gpio.io.cio_gpio_i := io.gpio_i

// //   core.io.stall_core_i := false.B
// //   core.io.irq_external_i := false.B


// // }

// //  Dont move
// // class Picofoxy(programFile: Option[String]) extends Module {
// //   val io = IO(new Bundle {
// //     // val gpio_io = Vec(4, Analog(1.W))
// //     val cio_spi_cs_n = Output(Bool())
// //     val cio_spi_sclk = Output(Bool())
// //     val cio_spi_mosi = Output(Bool())
// //     val cio_spi_miso = Input(Bool())
// //   })

// //   val top = Module(new Top(programFile))
// //   val pll = Module(new PLL_8MHz())

// //   pll.io.clk_in1 := clock
// //   top.clock := pll.io.clk_out1

// //   io.cio_spi_cs_n := top.io.spi_cs_n
// //   io.cio_spi_sclk := top.io.spi_sclk
// //   io.cio_spi_mosi := top.io.spi_mosi
// //   top.io.spi_miso := io.cio_spi_miso
// // }






// // class Top(programFile: Option[String]) extends Module {
// //   val io = IO(new Bundle {
// //     val spi_cs_n = Output(Bool())
// //     val spi_sclk = Output(Bool())
// //     val spi_mosi = Output(Bool())
// //     val spi_miso = Input(Bool())
// //   })

// //   implicit val config: TilelinkConfig = TilelinkConfig()
// //   val tl_imem_host = Module(new TilelinkHost())
// //   val tl_imem_slave = Module(new TilelinkDevice())
// //   val tl_dmem_host = Module(new TilelinkHost())
// //   val tl_dmem_slave = Module(new TilelinkDevice())
// //   val tl_spi_slave = Module(new TilelinkDevice())
// //   val imem = Module(BlockRam.createNonMaskableRAM(programFile, bus=config, rows=1024))
// //   val dmem = Module(BlockRam.createMaskableRAM(bus=config, rows=1024))
// //   // val gpio = Module(new Gpio(new TLRequest(), new TLResponse()))
// //   implicit val spiConfig = Config()
// //   val spi = Module(new Spi(new TLRequest(), new TLResponse()))

// //   val tlErr = Module(new TilelinkError())
// //   val core = Module(new Core(new TLRequest, new TLResponse))



// //   val addressMap = new AddressMap
// //   addressMap.addDevice(Peripherals.DCCM, "h40000000".U(32.W), "h00000FFF".U(32.W), tl_dmem_slave)
// //   addressMap.addDevice(Peripherals.GPIO, "h40001000".U(32.W), "h00000FFF".U(32.W), tl_spi_slave)
// //   val devices = addressMap.getDevices

// //   val switch = Module(new Switch1toN(new TilelinkMaster(), new TilelinkSlave(), devices.size))

// //   // tl <-> Core (fetch)
// //   tl_imem_host.io.reqIn <> core.io.imemReq
// //   core.io.imemRsp <> tl_imem_host.io.rspOut
// //   tl_imem_slave.io.reqOut <> imem.io.req
// //   tl_imem_slave.io.rspIn <> imem.io.rsp

// //   // tl <-> tl (fetch)
// //   tl_imem_host.io.tlMasterTransmitter <> tl_imem_slave.io.tlMasterReceiver
// //   tl_imem_slave.io.tlSlaveTransmitter <> tl_imem_host.io.tlSlaveReceiver

// //   // tl <-> Core (memory)
// //   tl_dmem_host.io.reqIn <> core.io.dmemReq
// //   core.io.dmemRsp <> tl_dmem_host.io.rspOut
// //   tl_dmem_slave.io.reqOut <> dmem.io.req
// //   tl_dmem_slave.io.rspIn <> dmem.io.rsp


// //   // Switch connection
// //   switch.io.hostIn <> tl_dmem_host.io.tlMasterTransmitter
// //   switch.io.hostOut <> tl_dmem_host.io.tlSlaveReceiver
// //   for (i <- 0 until devices.size) {
// //     switch.io.devIn(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[TilelinkDevice].io.tlSlaveTransmitter
// //     switch.io.devOut(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[TilelinkDevice].io.tlMasterReceiver
// //   }
// //   switch.io.devIn(devices.size) <> tlErr.io.tlSlaveTransmitter
// //   switch.io.devOut(devices.size) <> tlErr.io.tlMasterReceiver
// //   switch.io.devSel := BusDecoder.decode(tl_dmem_host.io.tlMasterTransmitter.bits.a_address, addressMap)


// //   tl_spi_slave.io.reqOut <> spi.io.req
// //   tl_spi_slave.io.rspIn <> spi.io.rsp

// //   io.spi_cs_n := spi.io.cs_n
// //   io.spi_sclk := spi.io.sclk
// //   io.spi_mosi := spi.io.mosi
// //   spi.io.miso := io.spi_miso

// //   // core.io.stall_core_i := false.B
// //   // core.io.irq_external_i := false.B


// // } 
// //  Dont move

// // **************** SPI TOP **********************

// // class Picofoxy(programFile: Option[String]) extends Module {
// //   val io = IO(new Bundle {
// //     // val gpio_io = Vec(4, Analog(1.W))
// //     val cio_spi_cs_n = Output(Bool())
// //     val cio_spi_sclk = Output(Bool())
// //     val cio_spi_mosi = Output(Bool())
// //     val cio_spi_miso = Input(Bool())

// //     val cio_uart_rx_i = Input(Bool())
// //     val cio_uart_tx_o = Output(Bool())
// //     val cio_uart_intr_tx_o = Output(Bool())
    
// //     val gpio_io = Vec(4, Analog(1.W))
// //   })

// //   val top = Module(new Top(programFile))
// //   val pll = Module(new PLL_8MHz())

// //   pll.io.clk_in1 := clock
// //   top.clock := pll.io.clk_out1

// //   // GPIO
// //   val gpioInputWires = Wire(Vec(4, Bool()))
// //   val gpioOutputWires = Wire(Vec(4, Bool()))
// //   val gpioEnableWires = Wire(Vec(4, Bool()))

// //   val gpioPads = TriStateBuffer(quantity=4)
// //   val triStateBufferWires = for {
// //     ((((a,b),c),d),e) <- gpioPads zip gpioInputWires zip gpioOutputWires zip gpioEnableWires zip io.gpio_io
// //   } yield (a,b,c,d,e)

// //   triStateBufferWires map { case(buf: IOBUF, in: Bool, out: Bool, en: Bool, io: Analog) => {
// //     buf.io.connect(in, out, io, en)
// //   }}

// //   top.io.gpio_i := gpioInputWires.asUInt()
// //   gpioOutputWires := top.io.gpio_o.asBools()
// //   gpioEnableWires := top.io.gpio_en_o.asBools()


// //   // UART
// //   top.io.cio_uart_rx_i := io.cio_uart_rx_i
// //   io.cio_uart_tx_o := top.io.cio_uart_tx_o
// //   io.cio_uart_intr_tx_o := top.io.cio_uart_intr_tx_o  

// //   // SPI-FLASH
// //   io.cio_spi_cs_n := top.io.spi_cs_n
// //   io.cio_spi_sclk := top.io.spi_sclk
// //   io.cio_spi_mosi := top.io.spi_mosi
// //   top.io.spi_miso := io.cio_spi_miso
// //   // top.io.spi_miso := top.io.spi_mosi
// // }





// // Wishbone with all peripherals
// class Top(programFile: Option[String], UART:Boolean = false) extends Module {
//   val io = IO(new Bundle {
//     val spi_cs_n = Output(Bool())
//     val spi_sclk = Output(Bool())
//     val spi_mosi = Output(Bool())
//     val spi_miso = Input(Bool())

//     val cio_uart_rx_i = Input(Bool())
//     val cio_uart_tx_o = Output(Bool())
//     val cio_uart_intr_tx_o = Output(Bool())

//     val gpio_o = Output(UInt(8.W))
//     val gpio_en_o = Output(UInt(8.W))
//     val gpio_i = Input(UInt(8.W))
//   })

//   // implicit val config: TilelinkConfig = TilelinkConfig()
//   implicit val config:WishboneConfig = WishboneConfig(32,32)
//   val wb_imem_host = Module(new WishboneHost())
//   val wb_imem_slave = Module(new WishboneDevice())
//   val wb_dmem_host = Module(new WishboneHost())
//   val wb_dmem_slave = Module(new WishboneDevice())
//   val wb_spi_slave = Module(new WishboneDevice())
//   val wb_uart_slave = Module(new WishboneDevice())
//   val wb_gpio_slave = Module(new WishboneDevice())
//   val imem = Module(BlockRam.createNonMaskableRAM(programFile, bus=config, rows=1024))
//   val dmem = Module(BlockRam.createMaskableRAM(bus=config, rows=1024))
//   val gpio = Module(new Gpio(new WBRequest(), new WBResponse()))
//   implicit val spiConfig = Config()
//   val spi = Module(new Spi(new WBRequest(), new WBResponse()))
//   val uart = Module(new uart(new WBRequest(), new WBResponse()))

//   val wbErr = Module(new WishboneErr())
//   val core = Module(new Core(new WBRequest, new WBResponse))



//   val addressMap = new AddressMap
//   addressMap.addDevice(Peripherals.DCCM, "h40000000".U(32.W), "h00000FFF".U(32.W), wb_dmem_slave)
//   addressMap.addDevice(Peripherals.SPI, "h40001000".U(32.W), "h00000FFF".U(32.W), wb_spi_slave)
//   addressMap.addDevice(Peripherals.UART, "h40002000".U(32.W), "h00000FFF".U(32.W), wb_uart_slave)
//   addressMap.addDevice(Peripherals.GPIO, "h40003000".U(32.W), "h00000FFF".U(32.W), wb_gpio_slave)
//   val devices = addressMap.getDevices

//   val switch = Module(new Switch1toN(new WishboneMaster(), new WishboneSlave(), devices.size))

//   // tl <-> Core (fetch)
//   wb_imem_host.io.reqIn <> core.io.imemReq
//   core.io.imemRsp <> wb_imem_host.io.rspOut
//   wb_imem_slave.io.reqOut <> imem.io.req
//   wb_imem_slave.io.rspIn <> imem.io.rsp

//   // wb <-> wb (fetch)
//   wb_imem_host.io.wbMasterTransmitter <> wb_imem_slave.io.wbMasterReceiver
//   wb_imem_slave.io.wbSlaveTransmitter <> wb_imem_host.io.wbSlaveReceiver

//   // wb <-> Core (memory)
//   wb_dmem_host.io.reqIn <> core.io.dmemReq
//   core.io.dmemRsp <> wb_dmem_host.io.rspOut
//   wb_dmem_slave.io.reqOut <> dmem.io.req
//   wb_dmem_slave.io.rspIn <> dmem.io.rsp


//   // Switch connection
//   switch.io.hostIn <> wb_dmem_host.io.wbMasterTransmitter
//   switch.io.hostOut <> wb_dmem_host.io.wbSlaveReceiver
//   for (i <- 0 until devices.size) {
//     switch.io.devIn(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[WishboneDevice].io.wbSlaveTransmitter
//     switch.io.devOut(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[WishboneDevice].io.wbMasterReceiver
//   }
//   switch.io.devIn(devices.size) <> wbErr.io.wbSlaveTransmitter
//   switch.io.devOut(devices.size) <> wbErr.io.wbMasterReceiver
//   // switch.io.devSel := BusDecoder.decode(wb_dmem_host.io.wbMasterTransmitter.bits.a_address, addressMap)
//   switch.io.devSel := BusDecoder.decode(wb_dmem_host.io.wbMasterTransmitter.bits.adr, addressMap)


//   wb_spi_slave.io.reqOut <> spi.io.req
//   wb_spi_slave.io.rspIn <> spi.io.rsp

//   wb_uart_slave.io.reqOut <> uart.io.request
//   wb_uart_slave.io.rspIn <> uart.io.response

//   uart.io.cio_uart_rx_i := io.cio_uart_rx_i
//   io.cio_uart_tx_o := uart.io.cio_uart_tx_o
//   io.cio_uart_intr_tx_o := uart.io.cio_uart_intr_tx_o  


//   io.spi_cs_n := spi.io.cs_n
//   io.spi_sclk := spi.io.sclk
//   io.spi_mosi := spi.io.mosi
//   spi.io.miso := io.spi_miso
//   // val wire = RegInit(spi.io.miso)
//   // spi.io.miso := wire

//   wb_gpio_slave.io.reqOut <> gpio.io.req
//   wb_gpio_slave.io.rspIn <> gpio.io.rsp

//   io.gpio_o := gpio.io.cio_gpio_o(7,0)
//   io.gpio_en_o := gpio.io.cio_gpio_en_o(7,0)
//   gpio.io.cio_gpio_i := io.gpio_i

//   // core.io.stall_core_i := false.B
//   // core.io.irq_external_i := false.B


// }

// // Tilelink with all peripherals
// // class Top(programFile: Option[String]) extends Module {
// //   val io = IO(new Bundle {
// //     val spi_cs_n = Output(Bool())
// //     val spi_sclk = Output(Bool())
// //     val spi_mosi = Output(Bool())
// //     val spi_miso = Input(Bool())

// //     val cio_uart_rx_i = Input(Bool())
// //     val cio_uart_tx_o = Output(Bool())
// //     val cio_uart_intr_tx_o = Output(Bool())

// //     val gpio_o = Output(UInt(4.W))
// //     val gpio_en_o = Output(UInt(4.W))
// //     val gpio_i = Input(UInt(4.W))
// //   })

// //   implicit val config: TilelinkConfig = TilelinkConfig()
// //   // implicit val config:WishboneConfig = WishboneConfig(32,32)
// //   val tl_imem_host = Module(new TilelinkHost())
// //   val tl_imem_slave = Module(new TilelinkDevice())
// //   val tl_dmem_host = Module(new TilelinkHost())
// //   val tl_dmem_slave = Module(new TilelinkDevice())
// //   val tl_spi_slave = Module(new TilelinkDevice())
// //   val tl_uart_slave = Module(new TilelinkDevice())
// //   val tl_gpio_slave = Module(new TilelinkDevice())
// //   val imem = Module(BlockRam.createNonMaskableRAM(programFile, bus=config, rows=1024))
// //   val dmem = Module(BlockRam.createMaskableRAM(bus=config, rows=1024))
// //   val gpio = Module(new Gpio(new TLRequest(), new TLResponse()))
// //   implicit val spiConfig = Config()
// //   val spi = Module(new Spi(new TLRequest(), new TLResponse()))
// //   val uart = Module(new uart(new TLRequest(), new TLResponse()))

// //   val tlErr = Module(new TilelinkError())
// //   val core = Module(new Core(new TLRequest, new TLResponse, None))



// //   val addressMap = new AddressMap
// //   addressMap.addDevice(Peripherals.DCCM, "h40000000".U(32.W), "h00000FFF".U(32.W), tl_dmem_slave)
// //   addressMap.addDevice(Peripherals.SPI, "h40001000".U(32.W), "h00000FFF".U(32.W), tl_spi_slave)
// //   addressMap.addDevice(Peripherals.UART, "h40002000".U(32.W), "h00000FFF".U(32.W), tl_uart_slave)
// //   addressMap.addDevice(Peripherals.GPIO, "h40003000".U(32.W), "h00000FFF".U(32.W), tl_gpio_slave)
// //   val devices = addressMap.getDevices

// //   val switch = Module(new Switch1toN(new TilelinkMaster(), new TilelinkSlave(), devices.size))

// //   // tl <-> Core (fetch)
// //   tl_imem_host.io.reqIn <> core.io.imemReq
// //   core.io.imemRsp <> tl_imem_host.io.rspOut
// //   tl_imem_slave.io.reqOut <> imem.io.req
// //   tl_imem_slave.io.rspIn <> imem.io.rsp

// //   // tl <-> tl (fetch)
// //   tl_imem_host.io.tlMasterTransmitter <> tl_imem_slave.io.tlMasterReceiver
// //   tl_imem_slave.io.tlSlaveTransmitter <> tl_imem_host.io.tlSlaveReceiver

// //   // tl <-> Core (memory)
// //   tl_dmem_host.io.reqIn <> core.io.dmemReq
// //   core.io.dmemRsp <> tl_dmem_host.io.rspOut
// //   tl_dmem_slave.io.reqOut <> dmem.io.req
// //   tl_dmem_slave.io.rspIn <> dmem.io.rsp


// //   // Switch connection
// //   switch.io.hostIn <> tl_dmem_host.io.tlMasterTransmitter
// //   switch.io.hostOut <> tl_dmem_host.io.tlSlaveReceiver
// //   for (i <- 0 until devices.size) {
// //     switch.io.devIn(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[TilelinkDevice].io.tlSlaveTransmitter
// //     switch.io.devOut(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[TilelinkDevice].io.tlMasterReceiver
// //   }
// //   switch.io.devIn(devices.size) <> tlErr.io.tlSlaveTransmitter
// //   switch.io.devOut(devices.size) <> tlErr.io.tlMasterReceiver
// //   switch.io.devSel := BusDecoder.decode(tl_dmem_host.io.tlMasterTransmitter.bits.a_address, addressMap)
// //   // switch.io.devSel := BusDecoder.decode(wb_dmem_host.io.wbMasterTransmitter.bits.adr, addressMap)


// //   tl_spi_slave.io.reqOut <> spi.io.req
// //   tl_spi_slave.io.rspIn <> spi.io.rsp

// //   tl_uart_slave.io.reqOut <> uart.io.request
// //   tl_uart_slave.io.rspIn <> uart.io.response

// //   uart.io.cio_uart_rx_i := io.cio_uart_rx_i
// //   io.cio_uart_tx_o := uart.io.cio_uart_tx_o
// //   io.cio_uart_intr_tx_o := uart.io.cio_uart_intr_tx_o  


// //   io.spi_cs_n := spi.io.cs_n
// //   io.spi_sclk := spi.io.sclk
// //   io.spi_mosi := spi.io.mosi
// //   spi.io.miso := io.spi_miso
// //   // val wire = RegInit(spi.io.miso)
// //   // spi.io.miso := wire

// //   tl_gpio_slave.io.reqOut <> gpio.io.req
// //   tl_gpio_slave.io.rspIn <> gpio.io.rsp

// //   io.gpio_o := gpio.io.cio_gpio_o(3,0)
// //   io.gpio_en_o := gpio.io.cio_gpio_en_o(3,0)
// //   gpio.io.cio_gpio_i := io.gpio_i

// //   // core.io.stall_core_i := false.B
// //   // core.io.irq_external_i := false.B


// // }
// // ***************/

// // object PicofoxyDriver extends App {
// //   (new ChiselStage).emitVerilog(new Picofoxy(None))
// // }