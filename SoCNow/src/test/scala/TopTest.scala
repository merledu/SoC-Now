// import chisel3._
// import org.scalatest._
// import chiseltest._
// import chiseltest.ChiselScalatestTester
// import chiseltest.internal.VerilatorBackendAnnotation
// import chiseltest.experimental.TestOptionBuilder._
// import org.scalatest.FreeSpec

// class TopTest extends FreeSpec with ChiselScalatestTester {
//   def getFile: Option[String] = {
//     if (scalaTestContext.value.get.configMap.contains("memFile")) {
//       Some(scalaTestContext.value.get.configMap("memFile").toString)
//     } else {
//       None
//     }
//   }
//   "should just work" in {
//     val programFile = getFile
//     test(new Top(programFile)) {c =>
//       c.clock.setTimeout(0)
//       // var count = 1
//       // while(count != 1000) {
//       //   //
//       //   // c.io.req.bits.addrRequest.poke(8.U)
//       //   // c.io.req.bits.isWrite.poke(0.B)
//       //   // c.io.req.valid.poke(1.B)
//       //   // c.io.rsp.ready.poke(1.B)
//       //   //
//       //     val mosi = c.io.spi_mosi.peek()
//       //     c.io.spi_miso.poke(mosi)
//       //     c.clock.step(1)
//       //     count += 1
//       // }
//       c.clock.step(1)
//     }
//   }
// }