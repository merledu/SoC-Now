package practice

import chisel3._
import chisel3.util._

class extra extends Module{
    val io = IO(new Bundle{
        val in = Input(UInt(32.W))
        val out = Output(UInt(32.W))
    })
    io.out := io.in + 1.U
}

class Raw extends Module{
    val io = IO(new Bundle{
        val in = Input(UInt(32.W))
        val out = Output(UInt(32.W))
        val clk = Output(Bool())
        val clk1 = Output(Bool())
        val clk2 = Output(Bool())
        val clk3 = Output(Bool())
        val clk4 = Output(Bool())
        val clk5 = Output(Bool())
        val clk6 = Output(Bool())
        val clk7 = Output(Bool())
        val clk8 = Output(Bool())
        val clk9 = Output(Bool())
        val clk10 = Output(Bool())
        val clk11 = Output(Bool())
    })
    val extra = Module(new extra)
    extra.clock := clock
    extra.io.in := io.in
    io.out := extra.io.out


    def counter(max: UInt) = {
        val x = RegInit(0.asUInt(max.getWidth.W))
        x := Mux(x === max, 0.U, x + 1.U)
        x
    }
    def pulse(n: UInt) = counter(n - 1.U) === 0.U
    def toggle(p: Bool) = {
        val x = RegInit(false.B)
        x := Mux(p, !x, x)
        x
    }
    def clockGen(period: UInt) = toggle(pulse(period >> 1))

    io.clk := clockGen(0.U)
    io.clk1:= clockGen(1.U)
    io.clk2 := clockGen(2.U)
    io.clk3 := clockGen(3.U)
    io.clk4 := clockGen(4.U)
    io.clk5 := clockGen(5.U)
    io.clk6 := clockGen(6.U)
    io.clk7 := clockGen(7.U)
    io.clk8 := clockGen(8.U)
    io.clk9 := clockGen(9.U)
    io.clk10:= clockGen(10.U)
    io.clk11:= clockGen(11.U)
    
    

}
