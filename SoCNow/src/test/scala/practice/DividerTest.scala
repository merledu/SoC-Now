package practice

import chisel3._
import org.scalatest._
import chiseltest._
import chisel3.experimental.BundleLiterals._
import chiseltest.experimental.TestOptionBuilder._
import chiseltest.internal.VerilatorBackendAnnotation


class DividerTest extends FreeSpec with ChiselScalatestTester {

  "Divider Gate Test" in {
    test(new Divider(32)).withAnnotations(Seq(VerilatorBackendAnnotation)) { c =>
      c.io.valid.poke(1.B)
      c.io.dividend.poke(11.U)
      c.io.divisor.poke(2.U)
      c.clock.step(1)
      c.io.valid.poke(0.B)
      c.clock.step(100)
    //   c.io.output.expect(25.S)
    }
  }
}
