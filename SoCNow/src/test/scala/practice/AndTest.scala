package practice

import chisel3._
import org.scalatest._
import chiseltest._
import chisel3.experimental.BundleLiterals._
import chiseltest.experimental.TestOptionBuilder._
import chiseltest.internal.VerilatorBackendAnnotation

class AndTest extends FreeSpec with ChiselScalatestTester {

  "And Gate Test" in {
    test(new And()).withAnnotations(Seq(VerilatorBackendAnnotation)){ c =>
      c.io.a.poke(4.U)
      c.io.b.poke(5.U)
      c.clock.step(100)
      // c.io.output.expect(1.U)
    }
  }
}









// .withAnnotations(Seq(VerilatorBackendAnnotation)) 