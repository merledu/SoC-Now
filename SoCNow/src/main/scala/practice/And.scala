package practice

import chisel3._

class And extends Module{
    val io = IO(new Bundle{
        val a = Input(UInt(32.W))
        val b = Input(UInt(32.W))
        val output = Output(UInt(32.W))
    })
    io.output := io.a & io.b
}