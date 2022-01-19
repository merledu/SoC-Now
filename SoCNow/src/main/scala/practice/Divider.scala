package practice

import chisel3._
import chisel3.util._

class Divider(n:Int) extends Module {
  val io = IO(new Bundle {
//    val fn = Input(UInt(2.W))
    val valid     = Input (UInt(1.W))
    val valid_o   = Output(UInt(1.W))
    val dividend  = Input (UInt(n.W))
    val divisor   = Input (UInt(n.W))
    val ready     = Output(UInt(1.W))
    val quotient  = Output(UInt(n.W))
    val remainder = Output(UInt(n.W))
  })

  // Use shorter variable names
  val dividend  = io.dividend 
  val divisor   = io.divisor  
  val valid     = io.valid
  // val quotient  = Wire(UInt (n.W))
  // val remainder = Wire(UInt (n.W))
  val r_ready    = RegInit(1.U(1.W))
  val r_counter  = RegInit(n.U(6.W))
  val r_dividend = RegInit(0.U(n.W))
  val r_quotient = RegInit(0.U(n.W))

  io.valid_o := 0.U

  // shift + substract
  when(valid === 1.U) {
    r_ready    := 0.U
    r_counter  := n.U
    r_dividend := dividend
    r_quotient := 0.U
  }.elsewhen(r_counter =/= 0.U){
    when(r_dividend >= (divisor<<(r_counter-1.U))){
      r_dividend    := r_dividend - (divisor<<(r_counter-1.U))
      r_quotient    := r_quotient + (1.U<<(r_counter-1.U))
    }.otherwise {r_ready := 1.U}
    r_counter  := r_counter - 1.U
    r_ready    := (r_counter === 1.U)
  }.otherwise{io.valid_o := 1.U}
  
  // remainder := r_dividend
  // quotient  := r_quotient

  // Output
  io.ready     := r_ready
  io.quotient  := r_quotient
  io.remainder := r_dividend
}