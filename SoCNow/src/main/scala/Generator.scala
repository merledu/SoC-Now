import chisel3._
//import buraq_mini.core.Core
import nucleusrv.components.Core
import caravan.bus.common.{AddressMap, BusDecoder, Switch1toN,Peripherals}

import caravan.bus.tilelink.{TLRequest, TLResponse, TilelinkConfig, TilelinkDevice, TilelinkError, TilelinkHost, TilelinkMaster, TilelinkSlave}
import caravan.bus.wishbone.{WBRequest, WBResponse, WishboneConfig, WishboneDevice, WishboneHost, WishboneMaster, WishboneSlave}
import caravan.bus.wishbone.{WishboneErr}
import chisel3.experimental.Analog
import chisel3.stage.ChiselStage
import jigsaw.fpga.boards.artyA7._
import jigsaw.rams.fpga.BlockRam
import jigsaw.peripherals.gpio._
import jigsaw.peripherals.spiflash._
import jigsaw.peripherals.UART._

class Generator(programFile: Option[String], GPIO:Boolean = true, UART:Boolean = true, SPI:Boolean = true, TL:Boolean = true, WB:Boolean = false) extends Module {
  val io = IO(new Bundle {
    val spi_cs_n = Output(Bool())
    val spi_sclk = Output(Bool())
    val spi_mosi = Output(Bool())
    val spi_miso = Input(Bool())

    val cio_uart_rx_i = Input(Bool())
    val cio_uart_tx_o = Output(Bool())
    val cio_uart_intr_tx_o = Output(Bool())

    val gpio_o = Output(UInt(8.W))
    val gpio_en_o = Output(UInt(8.W))
    val gpio_i = Input(UInt(8.W))
  })

  if (WB){
    val genWB = Module(new GeneratorWB(programFile = programFile, GPIO=GPIO, UART=UART, SPI=SPI))

    io.spi_cs_n := genWB.io.spi_cs_n
    io.spi_sclk := genWB.io.spi_sclk
    io.spi_mosi := genWB.io.spi_mosi
    genWB.io.spi_miso := io.spi_miso

    io.cio_uart_tx_o := genWB.io.cio_uart_tx_o
    io.cio_uart_intr_tx_o := genWB.io.cio_uart_intr_tx_o
    genWB.io.cio_uart_rx_i := io.cio_uart_rx_i 

    io.gpio_o := genWB.io.gpio_o
    io.gpio_en_o := genWB.io.gpio_en_o
    genWB.io.gpio_i := io.gpio_i

  }else{
    val genTL = Module(new GeneratorTL(programFile = programFile, GPIO=GPIO, UART=UART, SPI=SPI))

    io.spi_cs_n := genTL.io.spi_cs_n
    io.spi_sclk := genTL.io.spi_sclk
    io.spi_mosi := genTL.io.spi_mosi
    genTL.io.spi_miso := io.spi_miso

    io.cio_uart_tx_o := genTL.io.cio_uart_tx_o
    io.cio_uart_intr_tx_o := genTL.io.cio_uart_intr_tx_o
    genTL.io.cio_uart_rx_i := io.cio_uart_rx_i 

    io.gpio_o := genTL.io.gpio_o
    io.gpio_en_o := genTL.io.gpio_en_o
    genTL.io.gpio_i := io.gpio_i

  }

}


class GeneratorWB(programFile: Option[String], GPIO:Boolean = true, UART:Boolean = true, SPI:Boolean = true) extends Module {
  val io = IO(new Bundle {
    val spi_cs_n = Output(Bool())
    val spi_sclk = Output(Bool())
    val spi_mosi = Output(Bool())
    val spi_miso = Input(Bool())

    val cio_uart_rx_i = Input(Bool())
    val cio_uart_tx_o = Output(Bool())
    val cio_uart_intr_tx_o = Output(Bool())

    val gpio_o = Output(UInt(8.W))
    val gpio_en_o = Output(UInt(8.W))
    val gpio_i = Input(UInt(8.W))
  })

  io.spi_cs_n := DontCare
  io.spi_sclk := DontCare
  io.spi_mosi := DontCare

  io.cio_uart_tx_o := DontCare
  io.cio_uart_intr_tx_o := DontCare


  // implicit val config: TilelinkConfig = TilelinkConfig()
  implicit val config:WishboneConfig = WishboneConfig(32,32)

  val gen_imem_host = Module(new WishboneHost())
  val gen_imem_slave = Module(new WishboneDevice())
  val gen_dmem_host = Module(new WishboneHost())
  val gen_dmem_slave = Module(new WishboneDevice())


// GPIO
  val gpio = Module(new Gpio(new WBRequest(), new WBResponse()))
  val gen_gpio_slave = Module(new WishboneDevice())

  gen_gpio_slave.io.reqOut <> gpio.io.req
  gen_gpio_slave.io.rspIn <> gpio.io.rsp

  io.gpio_o := gpio.io.cio_gpio_o(7,0)
  io.gpio_en_o := gpio.io.cio_gpio_en_o(7,0)
  gpio.io.cio_gpio_i := io.gpio_i
//

var slaves = Seq(gen_dmem_slave, gen_gpio_slave)

if (SPI & UART){
  implicit val spiConfig = Config()
  val spi = Module(new Spi(new WBRequest(), new WBResponse()))

  val gen_spi_slave = Module(new WishboneDevice())
  val gen_uart_slave = Module(new WishboneDevice())

  gen_spi_slave.io.reqOut <> spi.io.req
  gen_spi_slave.io.rspIn <> spi.io.rsp

  io.spi_cs_n := spi.io.cs_n
  io.spi_sclk := spi.io.sclk
  io.spi_mosi := spi.io.mosi
  spi.io.miso := io.spi_miso

  val uart = Module(new uart(new WBRequest(), new WBResponse()))

  gen_uart_slave.io.reqOut <> uart.io.request
  gen_uart_slave.io.rspIn <> uart.io.response

  uart.io.cio_uart_rx_i := io.cio_uart_rx_i
  io.cio_uart_tx_o := uart.io.cio_uart_tx_o
  io.cio_uart_intr_tx_o := uart.io.cio_uart_intr_tx_o  

  slaves = Seq(gen_dmem_slave, gen_gpio_slave, gen_spi_slave, gen_uart_slave)
}else if(UART){
  val uart = Module(new uart(new WBRequest(), new WBResponse()))

  val gen_uart_slave = Module(new WishboneDevice())

  gen_uart_slave.io.reqOut <> uart.io.request
  gen_uart_slave.io.rspIn <> uart.io.response

  uart.io.cio_uart_rx_i := io.cio_uart_rx_i
  io.cio_uart_tx_o := uart.io.cio_uart_tx_o
  io.cio_uart_intr_tx_o := uart.io.cio_uart_intr_tx_o  

  slaves = Seq(gen_dmem_slave, gen_gpio_slave, gen_uart_slave)
}else if(SPI){
  implicit val spiConfig = Config()
  val spi = Module(new Spi(new WBRequest(), new WBResponse()))

   val gen_spi_slave = Module(new WishboneDevice())

  gen_spi_slave.io.reqOut <> spi.io.req
  gen_spi_slave.io.rspIn <> spi.io.rsp

  io.spi_cs_n := spi.io.cs_n
  io.spi_sclk := spi.io.sclk
  io.spi_mosi := spi.io.mosi
  spi.io.miso := io.spi_miso

  slaves = Seq(gen_dmem_slave, gen_gpio_slave, gen_spi_slave)
}

  val imem = Module(BlockRam.createNonMaskableRAM(programFile, bus=config, rows=1024))
  val dmem = Module(BlockRam.createMaskableRAM(bus=config, rows=1024))
  
  val wbErr = Module(new WishboneErr())
  val core = Module(new Core(new WBRequest, new WBResponse))


  val addresses = Seq("h40000000".U(32.W), "h40001000".U(32.W), "h40002000".U(32.W), "h40003000".U(32.W))
  val addressMap = new AddressMap

  for (i <- Peripherals.all.indices){
    addressMap.addDevice(Peripherals.all(i), addresses(i), "h00000FFF".U(32.W), slaves(i))
  }

  val devices = addressMap.getDevices

  val switch = Module(new Switch1toN(new WishboneMaster(), new WishboneSlave(), devices.size))

  // tl <-> Core (fetch)
  gen_imem_host.io.reqIn <> core.io.imemReq
  core.io.imemRsp <> gen_imem_host.io.rspOut
  gen_imem_slave.io.reqOut <> imem.io.req
  gen_imem_slave.io.rspIn <> imem.io.rsp

  // wb <-> wb (fetch)
  gen_imem_host.io.wbMasterTransmitter <> gen_imem_slave.io.wbMasterReceiver
  gen_imem_slave.io.wbSlaveTransmitter <> gen_imem_host.io.wbSlaveReceiver

  // wb <-> Core (memory)
  gen_dmem_host.io.reqIn <> core.io.dmemReq
  core.io.dmemRsp <> gen_dmem_host.io.rspOut
  gen_dmem_slave.io.reqOut <> dmem.io.req
  gen_dmem_slave.io.rspIn <> dmem.io.rsp


  // Switch connection
  switch.io.hostIn <> gen_dmem_host.io.wbMasterTransmitter
  switch.io.hostOut <> gen_dmem_host.io.wbSlaveReceiver
  for (i <- 0 until devices.size) {
    switch.io.devIn(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[WishboneDevice].io.wbSlaveTransmitter
    switch.io.devOut(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[WishboneDevice].io.wbMasterReceiver
  }
  switch.io.devIn(devices.size) <> wbErr.io.wbSlaveTransmitter
  switch.io.devOut(devices.size) <> wbErr.io.wbMasterReceiver
  // switch.io.devSel := BusDecoder.decode(gen_dmem_host.io.wbMasterTransmitter.bits.a_address, addressMap)
  switch.io.devSel := BusDecoder.decode(gen_dmem_host.io.wbMasterTransmitter.bits.adr, addressMap)

  // core.io.stall_core_i := false.B
  // core.io.irq_external_i := false.B

}

class GeneratorTL(programFile: Option[String], GPIO:Boolean = true, UART:Boolean = true, SPI:Boolean = true) extends Module {
  val io = IO(new Bundle {
    val spi_cs_n = Output(Bool())
    val spi_sclk = Output(Bool())
    val spi_mosi = Output(Bool())
    val spi_miso = Input(Bool())

    val cio_uart_rx_i = Input(Bool())
    val cio_uart_tx_o = Output(Bool())
    val cio_uart_intr_tx_o = Output(Bool())

    val gpio_o = Output(UInt(8.W))
    val gpio_en_o = Output(UInt(8.W))
    val gpio_i = Input(UInt(8.W))
  })

  io.spi_cs_n := DontCare
  io.spi_sclk := DontCare
  io.spi_mosi := DontCare

  io.cio_uart_tx_o := DontCare
  io.cio_uart_intr_tx_o := DontCare


  implicit val config: TilelinkConfig = TilelinkConfig()
  // implicit val config:WishboneConfig = WishboneConfig(32,32)

  val gen_imem_host = Module(new TilelinkHost())
  val gen_imem_slave = Module(new TilelinkDevice())
  val gen_dmem_host = Module(new TilelinkHost())
  val gen_dmem_slave = Module(new TilelinkDevice())


// GPIO
  val gpio = Module(new Gpio(new TLRequest(), new TLResponse()))
  val gen_gpio_slave = Module(new TilelinkDevice())

  gen_gpio_slave.io.reqOut <> gpio.io.req
  gen_gpio_slave.io.rspIn <> gpio.io.rsp

  io.gpio_o := gpio.io.cio_gpio_o(7,0)
  io.gpio_en_o := gpio.io.cio_gpio_en_o(7,0)
  gpio.io.cio_gpio_i := io.gpio_i
//

var slaves = Seq(gen_dmem_slave, gen_gpio_slave)

if (SPI & UART){
  implicit val spiConfig = Config()
  val spi = Module(new Spi(new TLRequest(), new TLResponse()))

  val gen_spi_slave = Module(new TilelinkDevice())
  val gen_uart_slave = Module(new TilelinkDevice())

  gen_spi_slave.io.reqOut <> spi.io.req
  gen_spi_slave.io.rspIn <> spi.io.rsp

  io.spi_cs_n := spi.io.cs_n
  io.spi_sclk := spi.io.sclk
  io.spi_mosi := spi.io.mosi
  spi.io.miso := io.spi_miso

  val uart = Module(new uart(new TLRequest(), new TLResponse()))

  gen_uart_slave.io.reqOut <> uart.io.request
  gen_uart_slave.io.rspIn <> uart.io.response

  uart.io.cio_uart_rx_i := io.cio_uart_rx_i
  io.cio_uart_tx_o := uart.io.cio_uart_tx_o
  io.cio_uart_intr_tx_o := uart.io.cio_uart_intr_tx_o  

  slaves = Seq(gen_dmem_slave, gen_gpio_slave, gen_spi_slave, gen_uart_slave)
}else if(UART){
  val uart = Module(new uart(new TLRequest(), new TLResponse()))

  val gen_uart_slave = Module(new TilelinkDevice())

  gen_uart_slave.io.reqOut <> uart.io.request
  gen_uart_slave.io.rspIn <> uart.io.response

  uart.io.cio_uart_rx_i := io.cio_uart_rx_i
  io.cio_uart_tx_o := uart.io.cio_uart_tx_o
  io.cio_uart_intr_tx_o := uart.io.cio_uart_intr_tx_o  

  slaves = Seq(gen_dmem_slave, gen_gpio_slave, gen_uart_slave)
}else if(SPI){
  implicit val spiConfig = Config()
  val spi = Module(new Spi(new TLRequest(), new TLResponse()))

   val gen_spi_slave = Module(new TilelinkDevice())

  gen_spi_slave.io.reqOut <> spi.io.req
  gen_spi_slave.io.rspIn <> spi.io.rsp

  io.spi_cs_n := spi.io.cs_n
  io.spi_sclk := spi.io.sclk
  io.spi_mosi := spi.io.mosi
  spi.io.miso := io.spi_miso

  slaves = Seq(gen_dmem_slave, gen_gpio_slave, gen_spi_slave)
}

  val imem = Module(BlockRam.createNonMaskableRAM(programFile, bus=config, rows=1024))
  val dmem = Module(BlockRam.createMaskableRAM(bus=config, rows=1024))
  
  val tlErr = Module(new TilelinkError())
  val core = Module(new Core(new TLRequest, new TLResponse))


  val addresses = Seq("h40000000".U(32.W), "h40001000".U(32.W), "h40002000".U(32.W), "h40003000".U(32.W))
  // val slaves = Seq(gen_dmem_slave, gen_gpio_slave, gen_spi_slave, gen_uart_slave)
  val addressMap = new AddressMap

  for (i <- Peripherals.all.indices){
    addressMap.addDevice(Peripherals.all(i), addresses(i), "h00000FFF".U(32.W), slaves(i))
  }

  val devices = addressMap.getDevices

  val switch = Module(new Switch1toN(new TilelinkMaster(), new TilelinkSlave(), devices.size))

  // tl <-> Core (fetch)
  gen_imem_host.io.reqIn <> core.io.imemReq
  core.io.imemRsp <> gen_imem_host.io.rspOut
  gen_imem_slave.io.reqOut <> imem.io.req
  gen_imem_slave.io.rspIn <> imem.io.rsp

  // wb <-> wb (fetch)
  gen_imem_host.io.tlMasterTransmitter <> gen_imem_slave.io.tlMasterReceiver
  gen_imem_slave.io.tlSlaveTransmitter <> gen_imem_host.io.tlSlaveReceiver

  // tl <-> Core (memory)
  gen_dmem_host.io.reqIn <> core.io.dmemReq
  core.io.dmemRsp <> gen_dmem_host.io.rspOut
  gen_dmem_slave.io.reqOut <> dmem.io.req
  gen_dmem_slave.io.rspIn <> dmem.io.rsp


  // Switch connection
  switch.io.hostIn <> gen_dmem_host.io.tlMasterTransmitter
  switch.io.hostOut <> gen_dmem_host.io.tlSlaveReceiver
  for (i <- 0 until devices.size) {
    switch.io.devIn(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[TilelinkDevice].io.tlSlaveTransmitter
    switch.io.devOut(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[TilelinkDevice].io.tlMasterReceiver
  }
  switch.io.devIn(devices.size) <> tlErr.io.tlSlaveTransmitter
  switch.io.devOut(devices.size) <> tlErr.io.tlMasterReceiver
  switch.io.devSel := BusDecoder.decode(gen_dmem_host.io.tlMasterTransmitter.bits.a_address, addressMap)
  // switch.io.devSel := BusDecoder.decode(gen_dmem_host.io.tlMasterTransmitter.bits.adr, addressMap)

  // core.io.stall_core_i := false.B
  // core.io.irq_external_i := false.B


}