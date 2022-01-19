package practice

import chisel3._
import org.scalatest._
import chiseltest._

class FSMTests extends FreeSpec with ChiselScalatestTester {

  "FSM Test" in {
    test(new FSM()){ c =>
      c.io.in.poke(1.B)
    //   c.clock.step(2)
    //   c.io.in.poke(0.B)
      c.clock.step(5)
      // c.io.output.expect(1.U)
    }
  }
}


