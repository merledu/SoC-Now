module WishboneHost(
  input         clock,
  input         reset,
  input         io_wbMasterTransmitter_ready,
  output        io_wbMasterTransmitter_valid,
  output        io_wbMasterTransmitter_bits_cyc,
  output        io_wbMasterTransmitter_bits_stb,
  output        io_wbMasterTransmitter_bits_we,
  output [31:0] io_wbMasterTransmitter_bits_adr,
  output [31:0] io_wbMasterTransmitter_bits_dat,
  output [3:0]  io_wbMasterTransmitter_bits_sel,
  output        io_wbSlaveReceiver_ready,
  input         io_wbSlaveReceiver_bits_ack,
  input  [31:0] io_wbSlaveReceiver_bits_dat,
  input         io_wbSlaveReceiver_bits_err,
  output        io_reqIn_ready,
  input         io_reqIn_valid,
  input  [31:0] io_reqIn_bits_addrRequest,
  input  [31:0] io_reqIn_bits_dataRequest,
  input  [3:0]  io_reqIn_bits_activeByteLane,
  input         io_reqIn_bits_isWrite,
  output        io_rspOut_valid,
  output [31:0] io_rspOut_bits_dataResponse
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg  startWBTransaction; // @[WishboneHost.scala 39:35]
  reg [31:0] dataReg; // @[WishboneHost.scala 41:24]
  reg  respReg; // @[WishboneHost.scala 42:24]
  reg  stbReg; // @[WishboneHost.scala 46:23]
  reg  cycReg; // @[WishboneHost.scala 47:23]
  reg  weReg; // @[WishboneHost.scala 48:22]
  reg [31:0] datReg; // @[WishboneHost.scala 49:23]
  reg [31:0] adrReg; // @[WishboneHost.scala 50:23]
  reg [3:0] selReg; // @[WishboneHost.scala 51:23]
  reg  stateReg; // @[WishboneHost.scala 56:25]
  reg  readyReg; // @[WishboneHost.scala 62:25]
  wire  _T_2 = io_reqIn_valid & io_wbMasterTransmitter_ready; // @[WishboneHost.scala 18:37]
  wire  _GEN_0 = _T_2 ? 1'h0 : readyReg; // @[WishboneHost.scala 63:14 WishboneHost.scala 64:14 WishboneHost.scala 62:25]
  wire  _GEN_1 = stateReg | _GEN_0; // @[WishboneHost.scala 66:33 WishboneHost.scala 67:14]
  wire  _GEN_2 = io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | startWBTransaction; // @[WishboneHost.scala 85:92 WishboneHost.scala 86:26 WishboneHost.scala 39:35]
  wire  _GEN_3 = io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | stbReg; // @[WishboneHost.scala 85:92 WishboneHost.scala 87:14 WishboneHost.scala 46:23]
  wire  _GEN_4 = io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | cycReg; // @[WishboneHost.scala 85:92 WishboneHost.scala 88:14 WishboneHost.scala 47:23]
  wire  _GEN_9 = ~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | _GEN_2; // @[WishboneHost.scala 77:86 WishboneHost.scala 78:26]
  wire  _GEN_10 = ~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | _GEN_3; // @[WishboneHost.scala 77:86 WishboneHost.scala 79:14]
  wire  _GEN_11 = ~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | _GEN_4; // @[WishboneHost.scala 77:86 WishboneHost.scala 80:14]
  wire  _GEN_23 = io_wbSlaveReceiver_bits_err & ~io_wbSlaveReceiver_bits_ack | respReg; // @[WishboneHost.scala 112:78 WishboneHost.scala 114:15 WishboneHost.scala 42:24]
  wire  _GEN_27 = io_wbSlaveReceiver_bits_ack & ~io_wbSlaveReceiver_bits_err | _GEN_23; // @[WishboneHost.scala 106:71 WishboneHost.scala 108:15]
  assign io_wbMasterTransmitter_valid = io_wbMasterTransmitter_bits_stb; // @[WishboneHost.scala 23:32]
  assign io_wbMasterTransmitter_bits_cyc = ~startWBTransaction ? 1'h0 : cycReg; // @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 96:37]
  assign io_wbMasterTransmitter_bits_stb = ~startWBTransaction ? 1'h0 : stbReg; // @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 95:37]
  assign io_wbMasterTransmitter_bits_we = ~startWBTransaction ? 1'h0 : weReg; // @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 97:36]
  assign io_wbMasterTransmitter_bits_adr = ~startWBTransaction ? 32'h0 : adrReg; // @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 98:37]
  assign io_wbMasterTransmitter_bits_dat = ~startWBTransaction ? 32'h0 : datReg; // @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 99:37]
  assign io_wbMasterTransmitter_bits_sel = ~startWBTransaction ? 4'h0 : selReg; // @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 100:37]
  assign io_wbSlaveReceiver_ready = 1'h1; // @[WishboneHost.scala 26:28]
  assign io_reqIn_ready = readyReg; // @[WishboneHost.scala 76:20]
  assign io_rspOut_valid = respReg; // @[WishboneHost.scala 128:21]
  assign io_rspOut_bits_dataResponse = dataReg; // @[WishboneHost.scala 129:33]
  always @(posedge clock) begin
    if (reset) begin // @[WishboneHost.scala 39:35]
      startWBTransaction <= 1'h0; // @[WishboneHost.scala 39:35]
    end else if (io_wbSlaveReceiver_bits_ack & ~io_wbSlaveReceiver_bits_err) begin // @[WishboneHost.scala 106:71]
      startWBTransaction <= 1'h0; // @[WishboneHost.scala 111:26]
    end else if (io_wbSlaveReceiver_bits_err & ~io_wbSlaveReceiver_bits_ack) begin // @[WishboneHost.scala 112:78]
      startWBTransaction <= 1'h0; // @[WishboneHost.scala 116:26]
    end else begin
      startWBTransaction <= _GEN_9;
    end
    if (reset) begin // @[WishboneHost.scala 41:24]
      dataReg <= 32'h0; // @[WishboneHost.scala 41:24]
    end else if (io_wbSlaveReceiver_bits_ack & ~io_wbSlaveReceiver_bits_err) begin // @[WishboneHost.scala 106:71]
      dataReg <= io_wbSlaveReceiver_bits_dat; // @[WishboneHost.scala 107:15]
    end else if (io_wbSlaveReceiver_bits_err & ~io_wbSlaveReceiver_bits_ack) begin // @[WishboneHost.scala 112:78]
      dataReg <= io_wbSlaveReceiver_bits_dat; // @[WishboneHost.scala 113:15]
    end
    if (reset) begin // @[WishboneHost.scala 42:24]
      respReg <= 1'h0; // @[WishboneHost.scala 42:24]
    end else if (~stateReg) begin // @[WishboneHost.scala 119:29]
      respReg <= _GEN_27;
    end else if (stateReg) begin // @[WishboneHost.scala 121:42]
      respReg <= 1'h0; // @[WishboneHost.scala 122:15]
    end else begin
      respReg <= _GEN_27;
    end
    if (reset) begin // @[WishboneHost.scala 46:23]
      stbReg <= 1'h0; // @[WishboneHost.scala 46:23]
    end else begin
      stbReg <= _GEN_10;
    end
    if (reset) begin // @[WishboneHost.scala 47:23]
      cycReg <= 1'h0; // @[WishboneHost.scala 47:23]
    end else begin
      cycReg <= _GEN_11;
    end
    if (reset) begin // @[WishboneHost.scala 48:22]
      weReg <= 1'h0; // @[WishboneHost.scala 48:22]
    end else if (~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 77:86]
      weReg <= io_reqIn_bits_isWrite; // @[WishboneHost.scala 81:13]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 85:92]
      weReg <= io_reqIn_bits_isWrite; // @[WishboneHost.scala 89:13]
    end
    if (reset) begin // @[WishboneHost.scala 49:23]
      datReg <= 32'h0; // @[WishboneHost.scala 49:23]
    end else if (~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 77:86]
      datReg <= 32'h0; // @[WishboneHost.scala 83:14]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 85:92]
      datReg <= io_reqIn_bits_dataRequest; // @[WishboneHost.scala 91:14]
    end
    if (reset) begin // @[WishboneHost.scala 50:23]
      adrReg <= 32'h0; // @[WishboneHost.scala 50:23]
    end else if (~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 77:86]
      adrReg <= io_reqIn_bits_addrRequest; // @[WishboneHost.scala 82:14]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 85:92]
      adrReg <= io_reqIn_bits_addrRequest; // @[WishboneHost.scala 90:14]
    end
    if (reset) begin // @[WishboneHost.scala 51:23]
      selReg <= 4'h0; // @[WishboneHost.scala 51:23]
    end else if (~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 77:86]
      selReg <= io_reqIn_bits_activeByteLane; // @[WishboneHost.scala 84:14]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 85:92]
      selReg <= io_reqIn_bits_activeByteLane; // @[WishboneHost.scala 92:14]
    end
    if (reset) begin // @[WishboneHost.scala 56:25]
      stateReg <= 1'h0; // @[WishboneHost.scala 56:25]
    end else if (~stateReg) begin // @[WishboneHost.scala 119:29]
      stateReg <= io_wbSlaveReceiver_bits_ack | io_wbSlaveReceiver_bits_err; // @[WishboneHost.scala 120:16]
    end else if (stateReg) begin // @[WishboneHost.scala 121:42]
      stateReg <= 1'h0; // @[WishboneHost.scala 123:16]
    end
    readyReg <= reset | _GEN_1; // @[WishboneHost.scala 62:25 WishboneHost.scala 62:25]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  startWBTransaction = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  respReg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  stbReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  cycReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  weReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  datReg = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  adrReg = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  selReg = _RAND_8[3:0];
  _RAND_9 = {1{`RANDOM}};
  stateReg = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  readyReg = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module WishboneDevice(
  input         io_wbSlaveTransmitter_ready,
  output        io_wbSlaveTransmitter_bits_ack,
  output [31:0] io_wbSlaveTransmitter_bits_dat,
  output        io_wbSlaveTransmitter_bits_err,
  output        io_wbMasterReceiver_ready,
  input         io_wbMasterReceiver_valid,
  input         io_wbMasterReceiver_bits_cyc,
  input         io_wbMasterReceiver_bits_stb,
  input         io_wbMasterReceiver_bits_we,
  input  [31:0] io_wbMasterReceiver_bits_adr,
  input  [31:0] io_wbMasterReceiver_bits_dat,
  input  [3:0]  io_wbMasterReceiver_bits_sel,
  output        io_reqOut_valid,
  output [31:0] io_reqOut_bits_addrRequest,
  output [31:0] io_reqOut_bits_dataRequest,
  output [3:0]  io_reqOut_bits_activeByteLane,
  output        io_reqOut_bits_isWrite,
  input         io_rspIn_valid,
  input  [31:0] io_rspIn_bits_dataResponse,
  input         io_rspIn_bits_error
);
  wire  _T_1 = io_wbMasterReceiver_valid & io_wbMasterReceiver_bits_cyc & io_wbMasterReceiver_bits_stb; // @[WishboneDevice.scala 16:80]
  wire  _T_4 = io_rspIn_valid & ~io_rspIn_bits_error; // @[WishboneDevice.scala 36:27]
  wire  _T_5 = io_rspIn_valid & io_rspIn_bits_error; // @[WishboneDevice.scala 42:34]
  wire  _GEN_5 = io_rspIn_valid & ~io_rspIn_bits_error ? 1'h0 : _T_5; // @[WishboneDevice.scala 36:52 WishboneDevice.scala 40:40]
  wire  _GEN_18 = ~io_wbMasterReceiver_bits_we ? _T_4 : _T_4; // @[WishboneDevice.scala 26:40]
  wire  _GEN_19 = ~io_wbMasterReceiver_bits_we ? _GEN_5 : _GEN_5; // @[WishboneDevice.scala 26:40]
  assign io_wbSlaveTransmitter_bits_ack = _T_1 & _GEN_18; // @[WishboneDevice.scala 25:16 WishboneDevice.scala 88:9]
  assign io_wbSlaveTransmitter_bits_dat = io_rspIn_bits_dataResponse; // @[WishboneDevice.scala 36:52 WishboneDevice.scala 41:40]
  assign io_wbSlaveTransmitter_bits_err = _T_1 & _GEN_19; // @[WishboneDevice.scala 25:16 WishboneDevice.scala 89:36]
  assign io_wbMasterReceiver_ready = 1'h1; // @[WishboneDevice.scala 19:29]
  assign io_reqOut_valid = io_wbMasterReceiver_valid & io_wbMasterReceiver_bits_cyc & io_wbMasterReceiver_bits_stb; // @[WishboneDevice.scala 16:80]
  assign io_reqOut_bits_addrRequest = io_wbMasterReceiver_bits_adr; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 32:34 WishboneDevice.scala 56:34]
  assign io_reqOut_bits_dataRequest = io_wbMasterReceiver_bits_dat; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 57:34]
  assign io_reqOut_bits_activeByteLane = io_wbMasterReceiver_bits_sel; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 34:37 WishboneDevice.scala 58:37]
  assign io_reqOut_bits_isWrite = ~io_wbMasterReceiver_bits_we ? 1'h0 : io_wbMasterReceiver_bits_we; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 35:30 WishboneDevice.scala 59:30]
endmodule
module BlockRamWithoutMasking(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse,
  output        io_rsp_bits_error
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:1023]; // @[BlockRam.scala 87:24]
initial begin 
 $readmemh("/home/talha/NucleusSoC/picofoxy/fpga/program.mem", mem); 
 end
  wire [31:0] mem_io_rsp_bits_dataResponse_MPORT_data; // @[BlockRam.scala 87:24]
  wire [9:0] mem_io_rsp_bits_dataResponse_MPORT_addr; // @[BlockRam.scala 87:24]
  wire [31:0] mem_MPORT_data; // @[BlockRam.scala 87:24]
  wire [9:0] mem_MPORT_addr; // @[BlockRam.scala 87:24]
  wire  mem_MPORT_mask; // @[BlockRam.scala 87:24]
  wire  mem_MPORT_en; // @[BlockRam.scala 87:24]
  reg  mem_io_rsp_bits_dataResponse_MPORT_en_pipe_0;
  reg [9:0] mem_io_rsp_bits_dataResponse_MPORT_addr_pipe_0;
  reg  validReg; // @[BlockRam.scala 72:25]
  reg  errReg; // @[BlockRam.scala 73:23]
  wire  _addrMisaligned_T = io_req_ready & io_req_valid; // @[Decoupled.scala 40:37]
  wire  addrMisaligned = _addrMisaligned_T & |io_req_bits_addrRequest[1:0]; // @[BlockRam.scala 80:24]
  wire [31:0] _addrOutOfBounds_T_1 = io_req_bits_addrRequest / 3'h4; // @[BlockRam.scala 81:65]
  wire  addrOutOfBounds = _addrMisaligned_T & _addrOutOfBounds_T_1 >= 32'h3ff; // @[BlockRam.scala 81:25]
  wire  _T_1 = ~io_req_bits_isWrite; // @[BlockRam.scala 93:25]
  wire  _T_2 = _addrMisaligned_T & ~io_req_bits_isWrite; // @[BlockRam.scala 93:22]
  wire  _T_4 = _addrMisaligned_T & io_req_bits_isWrite; // @[BlockRam.scala 97:29]
  wire  _GEN_9 = _addrMisaligned_T & ~io_req_bits_isWrite | _T_4; // @[BlockRam.scala 93:47 BlockRam.scala 96:14]
  assign mem_io_rsp_bits_dataResponse_MPORT_addr = mem_io_rsp_bits_dataResponse_MPORT_addr_pipe_0;
  assign mem_io_rsp_bits_dataResponse_MPORT_data = mem[mem_io_rsp_bits_dataResponse_MPORT_addr]; // @[BlockRam.scala 87:24]
  assign mem_MPORT_data = io_req_bits_dataRequest;
  assign mem_MPORT_addr = _addrOutOfBounds_T_1[9:0];
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = _T_2 ? 1'h0 : _T_4;
  assign io_req_ready = 1'h1; // @[BlockRam.scala 78:16]
  assign io_rsp_valid = validReg; // @[BlockRam.scala 75:16]
  assign io_rsp_bits_dataResponse = mem_io_rsp_bits_dataResponse_MPORT_data; // @[BlockRam.scala 93:47 BlockRam.scala 95:30]
  assign io_rsp_bits_error = errReg; // @[BlockRam.scala 76:21]
  always @(posedge clock) begin
    if(mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[BlockRam.scala 87:24]
    end
    mem_io_rsp_bits_dataResponse_MPORT_en_pipe_0 <= _addrMisaligned_T & _T_1;
    if (_addrMisaligned_T & _T_1) begin
      mem_io_rsp_bits_dataResponse_MPORT_addr_pipe_0 <= _addrOutOfBounds_T_1[9:0];
    end
    if (reset) begin // @[BlockRam.scala 72:25]
      validReg <= 1'h0; // @[BlockRam.scala 72:25]
    end else begin
      validReg <= _GEN_9;
    end
    if (reset) begin // @[BlockRam.scala 73:23]
      errReg <= 1'h0; // @[BlockRam.scala 73:23]
    end else begin
      errReg <= addrMisaligned | addrOutOfBounds; // @[BlockRam.scala 83:10]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_io_rsp_bits_dataResponse_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_io_rsp_bits_dataResponse_MPORT_addr_pipe_0 = _RAND_2[9:0];
  _RAND_3 = {1{`RANDOM}};
  validReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  errReg = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BlockRamWithMasking(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input  [3:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem_0 [0:1023]; // @[BlockRam.scala 148:24]
  wire [7:0] mem_0_MPORT_data; // @[BlockRam.scala 148:24]
  wire [9:0] mem_0_MPORT_addr; // @[BlockRam.scala 148:24]
  wire [7:0] mem_0_MPORT_1_data; // @[BlockRam.scala 148:24]
  wire [9:0] mem_0_MPORT_1_addr; // @[BlockRam.scala 148:24]
  wire  mem_0_MPORT_1_mask; // @[BlockRam.scala 148:24]
  wire  mem_0_MPORT_1_en; // @[BlockRam.scala 148:24]
  reg  mem_0_MPORT_en_pipe_0;
  reg [9:0] mem_0_MPORT_addr_pipe_0;
  reg [7:0] mem_1 [0:1023]; // @[BlockRam.scala 148:24]
  wire [7:0] mem_1_MPORT_data; // @[BlockRam.scala 148:24]
  wire [9:0] mem_1_MPORT_addr; // @[BlockRam.scala 148:24]
  wire [7:0] mem_1_MPORT_1_data; // @[BlockRam.scala 148:24]
  wire [9:0] mem_1_MPORT_1_addr; // @[BlockRam.scala 148:24]
  wire  mem_1_MPORT_1_mask; // @[BlockRam.scala 148:24]
  wire  mem_1_MPORT_1_en; // @[BlockRam.scala 148:24]
  reg  mem_1_MPORT_en_pipe_0;
  reg [9:0] mem_1_MPORT_addr_pipe_0;
  reg [7:0] mem_2 [0:1023]; // @[BlockRam.scala 148:24]
  wire [7:0] mem_2_MPORT_data; // @[BlockRam.scala 148:24]
  wire [9:0] mem_2_MPORT_addr; // @[BlockRam.scala 148:24]
  wire [7:0] mem_2_MPORT_1_data; // @[BlockRam.scala 148:24]
  wire [9:0] mem_2_MPORT_1_addr; // @[BlockRam.scala 148:24]
  wire  mem_2_MPORT_1_mask; // @[BlockRam.scala 148:24]
  wire  mem_2_MPORT_1_en; // @[BlockRam.scala 148:24]
  reg  mem_2_MPORT_en_pipe_0;
  reg [9:0] mem_2_MPORT_addr_pipe_0;
  reg [7:0] mem_3 [0:1023]; // @[BlockRam.scala 148:24]
  wire [7:0] mem_3_MPORT_data; // @[BlockRam.scala 148:24]
  wire [9:0] mem_3_MPORT_addr; // @[BlockRam.scala 148:24]
  wire [7:0] mem_3_MPORT_1_data; // @[BlockRam.scala 148:24]
  wire [9:0] mem_3_MPORT_1_addr; // @[BlockRam.scala 148:24]
  wire  mem_3_MPORT_1_mask; // @[BlockRam.scala 148:24]
  wire  mem_3_MPORT_1_en; // @[BlockRam.scala 148:24]
  reg  mem_3_MPORT_en_pipe_0;
  reg [9:0] mem_3_MPORT_addr_pipe_0;
  wire  byteLane_0 = io_req_bits_activeByteLane[0]; // @[BlockRam.scala 133:52]
  wire  byteLane_1 = io_req_bits_activeByteLane[1]; // @[BlockRam.scala 133:52]
  wire  byteLane_2 = io_req_bits_activeByteLane[2]; // @[BlockRam.scala 133:52]
  wire  byteLane_3 = io_req_bits_activeByteLane[3]; // @[BlockRam.scala 133:52]
  reg  validReg; // @[BlockRam.scala 141:25]
  wire  _T = io_req_ready & io_req_valid; // @[Decoupled.scala 40:37]
  wire  _T_1 = ~io_req_bits_isWrite; // @[BlockRam.scala 150:25]
  wire  _T_2 = _T & ~io_req_bits_isWrite; // @[BlockRam.scala 150:22]
  wire [31:0] _T_3 = io_req_bits_addrRequest / 3'h4; // @[BlockRam.scala 152:46]
  wire  _T_6 = _T & io_req_bits_isWrite; // @[BlockRam.scala 155:29]
  wire [7:0] rdata_0 = mem_0_MPORT_data; // @[BlockRam.scala 150:47 BlockRam.scala 152:11]
  wire [7:0] rdata_1 = mem_1_MPORT_data; // @[BlockRam.scala 150:47 BlockRam.scala 152:11]
  wire [7:0] rdata_2 = mem_2_MPORT_data; // @[BlockRam.scala 150:47 BlockRam.scala 152:11]
  wire [7:0] rdata_3 = mem_3_MPORT_data; // @[BlockRam.scala 150:47 BlockRam.scala 152:11]
  wire  _GEN_27 = _T & ~io_req_bits_isWrite | _T_6; // @[BlockRam.scala 150:47 BlockRam.scala 153:14]
  wire [7:0] data_0 = byteLane_0 ? rdata_0 : 8'h0; // @[BlockRam.scala 170:8]
  wire [7:0] data_1 = byteLane_1 ? rdata_1 : 8'h0; // @[BlockRam.scala 170:8]
  wire [7:0] data_2 = byteLane_2 ? rdata_2 : 8'h0; // @[BlockRam.scala 170:8]
  wire [7:0] data_3 = byteLane_3 ? rdata_3 : 8'h0; // @[BlockRam.scala 170:8]
  wire [15:0] io_rsp_bits_dataResponse_lo = {data_1,data_0}; // @[Cat.scala 30:58]
  wire [15:0] io_rsp_bits_dataResponse_hi = {data_3,data_2}; // @[Cat.scala 30:58]
  assign mem_0_MPORT_addr = mem_0_MPORT_addr_pipe_0;
  assign mem_0_MPORT_data = mem_0[mem_0_MPORT_addr]; // @[BlockRam.scala 148:24]
  assign mem_0_MPORT_1_data = io_req_bits_dataRequest[7:0];
  assign mem_0_MPORT_1_addr = _T_3[9:0];
  assign mem_0_MPORT_1_mask = io_req_bits_activeByteLane[0];
  assign mem_0_MPORT_1_en = _T_2 ? 1'h0 : _T_6;
  assign mem_1_MPORT_addr = mem_1_MPORT_addr_pipe_0;
  assign mem_1_MPORT_data = mem_1[mem_1_MPORT_addr]; // @[BlockRam.scala 148:24]
  assign mem_1_MPORT_1_data = io_req_bits_dataRequest[15:8];
  assign mem_1_MPORT_1_addr = _T_3[9:0];
  assign mem_1_MPORT_1_mask = io_req_bits_activeByteLane[1];
  assign mem_1_MPORT_1_en = _T_2 ? 1'h0 : _T_6;
  assign mem_2_MPORT_addr = mem_2_MPORT_addr_pipe_0;
  assign mem_2_MPORT_data = mem_2[mem_2_MPORT_addr]; // @[BlockRam.scala 148:24]
  assign mem_2_MPORT_1_data = io_req_bits_dataRequest[23:16];
  assign mem_2_MPORT_1_addr = _T_3[9:0];
  assign mem_2_MPORT_1_mask = io_req_bits_activeByteLane[2];
  assign mem_2_MPORT_1_en = _T_2 ? 1'h0 : _T_6;
  assign mem_3_MPORT_addr = mem_3_MPORT_addr_pipe_0;
  assign mem_3_MPORT_data = mem_3[mem_3_MPORT_addr]; // @[BlockRam.scala 148:24]
  assign mem_3_MPORT_1_data = io_req_bits_dataRequest[31:24];
  assign mem_3_MPORT_1_addr = _T_3[9:0];
  assign mem_3_MPORT_1_mask = io_req_bits_activeByteLane[3];
  assign mem_3_MPORT_1_en = _T_2 ? 1'h0 : _T_6;
  assign io_req_ready = 1'h1; // @[BlockRam.scala 146:16]
  assign io_rsp_valid = validReg; // @[BlockRam.scala 143:16]
  assign io_rsp_bits_dataResponse = {io_rsp_bits_dataResponse_hi,io_rsp_bits_dataResponse_lo}; // @[Cat.scala 30:58]
  always @(posedge clock) begin
    if(mem_0_MPORT_1_en & mem_0_MPORT_1_mask) begin
      mem_0[mem_0_MPORT_1_addr] <= mem_0_MPORT_1_data; // @[BlockRam.scala 148:24]
    end
    mem_0_MPORT_en_pipe_0 <= _T & _T_1;
    if (_T & _T_1) begin
      mem_0_MPORT_addr_pipe_0 <= _T_3[9:0];
    end
    if(mem_1_MPORT_1_en & mem_1_MPORT_1_mask) begin
      mem_1[mem_1_MPORT_1_addr] <= mem_1_MPORT_1_data; // @[BlockRam.scala 148:24]
    end
    mem_1_MPORT_en_pipe_0 <= _T & _T_1;
    if (_T & _T_1) begin
      mem_1_MPORT_addr_pipe_0 <= _T_3[9:0];
    end
    if(mem_2_MPORT_1_en & mem_2_MPORT_1_mask) begin
      mem_2[mem_2_MPORT_1_addr] <= mem_2_MPORT_1_data; // @[BlockRam.scala 148:24]
    end
    mem_2_MPORT_en_pipe_0 <= _T & _T_1;
    if (_T & _T_1) begin
      mem_2_MPORT_addr_pipe_0 <= _T_3[9:0];
    end
    if(mem_3_MPORT_1_en & mem_3_MPORT_1_mask) begin
      mem_3[mem_3_MPORT_1_addr] <= mem_3_MPORT_1_data; // @[BlockRam.scala 148:24]
    end
    mem_3_MPORT_en_pipe_0 <= _T & _T_1;
    if (_T & _T_1) begin
      mem_3_MPORT_addr_pipe_0 <= _T_3[9:0];
    end
    if (reset) begin // @[BlockRam.scala 141:25]
      validReg <= 1'h0; // @[BlockRam.scala 141:25]
    end else begin
      validReg <= _GEN_27;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_0[initvar] = _RAND_0[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_1[initvar] = _RAND_3[7:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_2[initvar] = _RAND_6[7:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_3[initvar] = _RAND_9[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_0_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_0_MPORT_addr_pipe_0 = _RAND_2[9:0];
  _RAND_4 = {1{`RANDOM}};
  mem_1_MPORT_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  mem_1_MPORT_addr_pipe_0 = _RAND_5[9:0];
  _RAND_7 = {1{`RANDOM}};
  mem_2_MPORT_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  mem_2_MPORT_addr_pipe_0 = _RAND_8[9:0];
  _RAND_10 = {1{`RANDOM}};
  mem_3_MPORT_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  mem_3_MPORT_addr_pipe_0 = _RAND_11[9:0];
  _RAND_12 = {1{`RANDOM}};
  validReg = _RAND_12[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SubReg(
  input         clock,
  input         reset,
  input         io_we,
  input  [31:0] io_wd,
  input         io_de,
  input  [31:0] io_d,
  output [31:0] io_q,
  output [31:0] io_qs
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] q_reg; // @[SubReg.scala 24:22]
  wire  wr_en = io_we | io_de; // @[SubReg.scala 33:20]
  wire [31:0] _wr_data_T = io_de ? io_d : q_reg; // @[SubReg.scala 34:19]
  wire [31:0] _wr_data_T_1 = ~io_wd; // @[SubReg.scala 34:53]
  wire [31:0] _wr_data_T_3 = io_we ? _wr_data_T_1 : 32'hffffffff; // @[SubReg.scala 34:45]
  wire [31:0] wr_data = _wr_data_T & _wr_data_T_3; // @[SubReg.scala 34:40]
  assign io_q = q_reg; // @[SubReg.scala 52:8]
  assign io_qs = q_reg; // @[SubReg.scala 51:9]
  always @(posedge clock) begin
    if (reset) begin // @[SubReg.scala 24:22]
      q_reg <= 32'h0; // @[SubReg.scala 24:22]
    end else if (wr_en) begin // @[SubReg.scala 47:15]
      q_reg <= wr_data; // @[SubReg.scala 48:11]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  q_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SubReg_1(
  input         clock,
  input         reset,
  input         io_we,
  input  [31:0] io_wd,
  output [31:0] io_q,
  output [31:0] io_qs
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] q_reg; // @[SubReg.scala 24:22]
  assign io_q = q_reg; // @[SubReg.scala 52:8]
  assign io_qs = q_reg; // @[SubReg.scala 51:9]
  always @(posedge clock) begin
    if (reset) begin // @[SubReg.scala 24:22]
      q_reg <= 32'h0; // @[SubReg.scala 24:22]
    end else if (io_we) begin // @[SubReg.scala 47:15]
      if (io_we) begin // @[SubReg.scala 28:19]
        q_reg <= io_wd;
      end else begin
        q_reg <= 32'h0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  q_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SubRegExt(
  input         io_we,
  input  [31:0] io_wd,
  input  [31:0] io_d,
  output        io_qe,
  output [31:0] io_q,
  output [31:0] io_qs
);
  assign io_qe = io_we; // @[SubRegExt.scala 25:9]
  assign io_q = io_wd; // @[SubRegExt.scala 24:8]
  assign io_qs = io_d; // @[SubRegExt.scala 23:9]
endmodule
module SubReg_2(
  input         clock,
  input         reset,
  input  [31:0] io_d,
  output [31:0] io_qs
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] q_reg; // @[SubReg.scala 24:22]
  assign io_qs = q_reg; // @[SubReg.scala 51:9]
  always @(posedge clock) begin
    if (reset) begin // @[SubReg.scala 24:22]
      q_reg <= 32'h0; // @[SubReg.scala 24:22]
    end else begin
      q_reg <= io_d;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  q_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SubRegExt_2(
  input         io_we,
  input  [15:0] io_wd,
  input  [15:0] io_d,
  output        io_qe,
  output [15:0] io_q,
  output [15:0] io_qs
);
  assign io_qe = io_we; // @[SubRegExt.scala 25:9]
  assign io_q = io_wd; // @[SubRegExt.scala 24:8]
  assign io_qs = io_d; // @[SubRegExt.scala 23:9]
endmodule
module GpioRegTop(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input  [3:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse,
  output        io_rsp_bits_error,
  output [31:0] io_reg2hw_intr_state_q,
  output [31:0] io_reg2hw_intr_test_q,
  output        io_reg2hw_intr_test_qe,
  output [31:0] io_reg2hw_direct_out_q,
  output        io_reg2hw_direct_out_qe,
  output [15:0] io_reg2hw_masked_out_lower_data_q,
  output        io_reg2hw_masked_out_lower_data_qe,
  output [15:0] io_reg2hw_masked_out_lower_mask_q,
  output [15:0] io_reg2hw_masked_out_upper_data_q,
  output        io_reg2hw_masked_out_upper_data_qe,
  output [15:0] io_reg2hw_masked_out_upper_mask_q,
  output [31:0] io_reg2hw_direct_oe_q,
  output        io_reg2hw_direct_oe_qe,
  output [15:0] io_reg2hw_masked_oe_lower_data_q,
  output        io_reg2hw_masked_oe_lower_data_qe,
  output [15:0] io_reg2hw_masked_oe_lower_mask_q,
  output [15:0] io_reg2hw_masked_oe_upper_data_q,
  output        io_reg2hw_masked_oe_upper_data_qe,
  output [15:0] io_reg2hw_masked_oe_upper_mask_q,
  output [31:0] io_reg2hw_intr_ctrl_en_rising_q,
  output [31:0] io_reg2hw_intr_ctrl_en_falling_q,
  output [31:0] io_reg2hw_intr_ctrl_en_lvlHigh_q,
  output [31:0] io_reg2hw_intr_ctrl_en_lvlLow_q,
  input  [31:0] io_hw2reg_intr_state_d,
  input         io_hw2reg_intr_state_de,
  input  [31:0] io_hw2reg_data_in_d,
  input  [31:0] io_hw2reg_direct_out_d,
  input  [15:0] io_hw2reg_masked_out_lower_data_d,
  input  [15:0] io_hw2reg_masked_out_upper_data_d,
  input  [31:0] io_hw2reg_direct_oe_d,
  input  [15:0] io_hw2reg_masked_oe_lower_data_d,
  input  [15:0] io_hw2reg_masked_oe_upper_data_d
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  intr_state_reg_clock; // @[GpioRegTop.scala 95:30]
  wire  intr_state_reg_reset; // @[GpioRegTop.scala 95:30]
  wire  intr_state_reg_io_we; // @[GpioRegTop.scala 95:30]
  wire [31:0] intr_state_reg_io_wd; // @[GpioRegTop.scala 95:30]
  wire  intr_state_reg_io_de; // @[GpioRegTop.scala 95:30]
  wire [31:0] intr_state_reg_io_d; // @[GpioRegTop.scala 95:30]
  wire [31:0] intr_state_reg_io_q; // @[GpioRegTop.scala 95:30]
  wire [31:0] intr_state_reg_io_qs; // @[GpioRegTop.scala 95:30]
  wire  intr_enable_reg_clock; // @[GpioRegTop.scala 110:31]
  wire  intr_enable_reg_reset; // @[GpioRegTop.scala 110:31]
  wire  intr_enable_reg_io_we; // @[GpioRegTop.scala 110:31]
  wire [31:0] intr_enable_reg_io_wd; // @[GpioRegTop.scala 110:31]
  wire [31:0] intr_enable_reg_io_q; // @[GpioRegTop.scala 110:31]
  wire [31:0] intr_enable_reg_io_qs; // @[GpioRegTop.scala 110:31]
  wire  intr_test_reg_io_we; // @[GpioRegTop.scala 119:29]
  wire [31:0] intr_test_reg_io_wd; // @[GpioRegTop.scala 119:29]
  wire [31:0] intr_test_reg_io_d; // @[GpioRegTop.scala 119:29]
  wire  intr_test_reg_io_qe; // @[GpioRegTop.scala 119:29]
  wire [31:0] intr_test_reg_io_q; // @[GpioRegTop.scala 119:29]
  wire [31:0] intr_test_reg_io_qs; // @[GpioRegTop.scala 119:29]
  wire  data_in_reg_clock; // @[GpioRegTop.scala 128:27]
  wire  data_in_reg_reset; // @[GpioRegTop.scala 128:27]
  wire [31:0] data_in_reg_io_d; // @[GpioRegTop.scala 128:27]
  wire [31:0] data_in_reg_io_qs; // @[GpioRegTop.scala 128:27]
  wire  direct_out_reg_io_we; // @[GpioRegTop.scala 136:30]
  wire [31:0] direct_out_reg_io_wd; // @[GpioRegTop.scala 136:30]
  wire [31:0] direct_out_reg_io_d; // @[GpioRegTop.scala 136:30]
  wire  direct_out_reg_io_qe; // @[GpioRegTop.scala 136:30]
  wire [31:0] direct_out_reg_io_q; // @[GpioRegTop.scala 136:30]
  wire [31:0] direct_out_reg_io_qs; // @[GpioRegTop.scala 136:30]
  wire  masked_out_lower_data_reg_io_we; // @[GpioRegTop.scala 147:41]
  wire [15:0] masked_out_lower_data_reg_io_wd; // @[GpioRegTop.scala 147:41]
  wire [15:0] masked_out_lower_data_reg_io_d; // @[GpioRegTop.scala 147:41]
  wire  masked_out_lower_data_reg_io_qe; // @[GpioRegTop.scala 147:41]
  wire [15:0] masked_out_lower_data_reg_io_q; // @[GpioRegTop.scala 147:41]
  wire [15:0] masked_out_lower_data_reg_io_qs; // @[GpioRegTop.scala 147:41]
  wire  masked_out_lower_mask_reg_io_we; // @[GpioRegTop.scala 158:41]
  wire [15:0] masked_out_lower_mask_reg_io_wd; // @[GpioRegTop.scala 158:41]
  wire [15:0] masked_out_lower_mask_reg_io_d; // @[GpioRegTop.scala 158:41]
  wire  masked_out_lower_mask_reg_io_qe; // @[GpioRegTop.scala 158:41]
  wire [15:0] masked_out_lower_mask_reg_io_q; // @[GpioRegTop.scala 158:41]
  wire [15:0] masked_out_lower_mask_reg_io_qs; // @[GpioRegTop.scala 158:41]
  wire  masked_out_upper_data_reg_io_we; // @[GpioRegTop.scala 168:41]
  wire [15:0] masked_out_upper_data_reg_io_wd; // @[GpioRegTop.scala 168:41]
  wire [15:0] masked_out_upper_data_reg_io_d; // @[GpioRegTop.scala 168:41]
  wire  masked_out_upper_data_reg_io_qe; // @[GpioRegTop.scala 168:41]
  wire [15:0] masked_out_upper_data_reg_io_q; // @[GpioRegTop.scala 168:41]
  wire [15:0] masked_out_upper_data_reg_io_qs; // @[GpioRegTop.scala 168:41]
  wire  masked_out_upper_mask_reg_io_we; // @[GpioRegTop.scala 179:41]
  wire [15:0] masked_out_upper_mask_reg_io_wd; // @[GpioRegTop.scala 179:41]
  wire [15:0] masked_out_upper_mask_reg_io_d; // @[GpioRegTop.scala 179:41]
  wire  masked_out_upper_mask_reg_io_qe; // @[GpioRegTop.scala 179:41]
  wire [15:0] masked_out_upper_mask_reg_io_q; // @[GpioRegTop.scala 179:41]
  wire [15:0] masked_out_upper_mask_reg_io_qs; // @[GpioRegTop.scala 179:41]
  wire  direct_oe_reg_io_we; // @[GpioRegTop.scala 188:29]
  wire [31:0] direct_oe_reg_io_wd; // @[GpioRegTop.scala 188:29]
  wire [31:0] direct_oe_reg_io_d; // @[GpioRegTop.scala 188:29]
  wire  direct_oe_reg_io_qe; // @[GpioRegTop.scala 188:29]
  wire [31:0] direct_oe_reg_io_q; // @[GpioRegTop.scala 188:29]
  wire [31:0] direct_oe_reg_io_qs; // @[GpioRegTop.scala 188:29]
  wire  masked_oe_lower_data_reg_io_we; // @[GpioRegTop.scala 199:40]
  wire [15:0] masked_oe_lower_data_reg_io_wd; // @[GpioRegTop.scala 199:40]
  wire [15:0] masked_oe_lower_data_reg_io_d; // @[GpioRegTop.scala 199:40]
  wire  masked_oe_lower_data_reg_io_qe; // @[GpioRegTop.scala 199:40]
  wire [15:0] masked_oe_lower_data_reg_io_q; // @[GpioRegTop.scala 199:40]
  wire [15:0] masked_oe_lower_data_reg_io_qs; // @[GpioRegTop.scala 199:40]
  wire  masked_oe_lower_mask_reg_io_we; // @[GpioRegTop.scala 210:40]
  wire [15:0] masked_oe_lower_mask_reg_io_wd; // @[GpioRegTop.scala 210:40]
  wire [15:0] masked_oe_lower_mask_reg_io_d; // @[GpioRegTop.scala 210:40]
  wire  masked_oe_lower_mask_reg_io_qe; // @[GpioRegTop.scala 210:40]
  wire [15:0] masked_oe_lower_mask_reg_io_q; // @[GpioRegTop.scala 210:40]
  wire [15:0] masked_oe_lower_mask_reg_io_qs; // @[GpioRegTop.scala 210:40]
  wire  masked_oe_upper_data_reg_io_we; // @[GpioRegTop.scala 221:40]
  wire [15:0] masked_oe_upper_data_reg_io_wd; // @[GpioRegTop.scala 221:40]
  wire [15:0] masked_oe_upper_data_reg_io_d; // @[GpioRegTop.scala 221:40]
  wire  masked_oe_upper_data_reg_io_qe; // @[GpioRegTop.scala 221:40]
  wire [15:0] masked_oe_upper_data_reg_io_q; // @[GpioRegTop.scala 221:40]
  wire [15:0] masked_oe_upper_data_reg_io_qs; // @[GpioRegTop.scala 221:40]
  wire  masked_oe_upper_mask_reg_io_we; // @[GpioRegTop.scala 232:40]
  wire [15:0] masked_oe_upper_mask_reg_io_wd; // @[GpioRegTop.scala 232:40]
  wire [15:0] masked_oe_upper_mask_reg_io_d; // @[GpioRegTop.scala 232:40]
  wire  masked_oe_upper_mask_reg_io_qe; // @[GpioRegTop.scala 232:40]
  wire [15:0] masked_oe_upper_mask_reg_io_q; // @[GpioRegTop.scala 232:40]
  wire [15:0] masked_oe_upper_mask_reg_io_qs; // @[GpioRegTop.scala 232:40]
  wire  intr_ctrl_en_rising_reg_clock; // @[GpioRegTop.scala 242:39]
  wire  intr_ctrl_en_rising_reg_reset; // @[GpioRegTop.scala 242:39]
  wire  intr_ctrl_en_rising_reg_io_we; // @[GpioRegTop.scala 242:39]
  wire [31:0] intr_ctrl_en_rising_reg_io_wd; // @[GpioRegTop.scala 242:39]
  wire [31:0] intr_ctrl_en_rising_reg_io_q; // @[GpioRegTop.scala 242:39]
  wire [31:0] intr_ctrl_en_rising_reg_io_qs; // @[GpioRegTop.scala 242:39]
  wire  intr_ctrl_en_falling_reg_clock; // @[GpioRegTop.scala 251:40]
  wire  intr_ctrl_en_falling_reg_reset; // @[GpioRegTop.scala 251:40]
  wire  intr_ctrl_en_falling_reg_io_we; // @[GpioRegTop.scala 251:40]
  wire [31:0] intr_ctrl_en_falling_reg_io_wd; // @[GpioRegTop.scala 251:40]
  wire [31:0] intr_ctrl_en_falling_reg_io_q; // @[GpioRegTop.scala 251:40]
  wire [31:0] intr_ctrl_en_falling_reg_io_qs; // @[GpioRegTop.scala 251:40]
  wire  intr_ctrl_en_lvlhigh_reg_clock; // @[GpioRegTop.scala 260:40]
  wire  intr_ctrl_en_lvlhigh_reg_reset; // @[GpioRegTop.scala 260:40]
  wire  intr_ctrl_en_lvlhigh_reg_io_we; // @[GpioRegTop.scala 260:40]
  wire [31:0] intr_ctrl_en_lvlhigh_reg_io_wd; // @[GpioRegTop.scala 260:40]
  wire [31:0] intr_ctrl_en_lvlhigh_reg_io_q; // @[GpioRegTop.scala 260:40]
  wire [31:0] intr_ctrl_en_lvlhigh_reg_io_qs; // @[GpioRegTop.scala 260:40]
  wire  intr_ctrl_en_lvllow_reg_clock; // @[GpioRegTop.scala 269:39]
  wire  intr_ctrl_en_lvllow_reg_reset; // @[GpioRegTop.scala 269:39]
  wire  intr_ctrl_en_lvllow_reg_io_we; // @[GpioRegTop.scala 269:39]
  wire [31:0] intr_ctrl_en_lvllow_reg_io_wd; // @[GpioRegTop.scala 269:39]
  wire [31:0] intr_ctrl_en_lvllow_reg_io_q; // @[GpioRegTop.scala 269:39]
  wire [31:0] intr_ctrl_en_lvllow_reg_io_qs; // @[GpioRegTop.scala 269:39]
  wire  _reg_we_T = io_req_ready & io_req_valid; // @[Decoupled.scala 40:37]
  wire  reg_we = _reg_we_T & io_req_bits_isWrite; // @[GpioRegTop.scala 33:16]
  wire  reg_re = _reg_we_T & ~io_req_bits_isWrite; // @[GpioRegTop.scala 34:16]
  reg  io_rsp_valid_REG; // @[GpioRegTop.scala 39:26]
  wire [5:0] reg_addr = io_req_bits_addrRequest[5:0]; // @[GpioRegTop.scala 26:22 GpioRegTop.scala 36:12]
  wire  addr_hit_0 = reg_addr == 6'h0; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_1 = reg_addr == 6'h4; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_2 = reg_addr == 6'h8; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_3 = reg_addr == 6'hc; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_4 = reg_addr == 6'h10; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_5 = reg_addr == 6'h14; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_6 = reg_addr == 6'h18; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_7 = reg_addr == 6'h1c; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_8 = reg_addr == 6'h20; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_9 = reg_addr == 6'h24; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_10 = reg_addr == 6'h28; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_11 = reg_addr == 6'h2c; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_12 = reg_addr == 6'h30; // @[GpioRegTop.scala 279:29]
  wire  addr_hit_13 = reg_addr == 6'h34; // @[GpioRegTop.scala 279:29]
  wire  addr_miss = (reg_re | reg_we) & ~(addr_hit_0 | addr_hit_1 | addr_hit_2 | addr_hit_3 | addr_hit_4 | addr_hit_5 |
    addr_hit_6 | addr_hit_7 | addr_hit_8 | addr_hit_9 | addr_hit_10 | addr_hit_11 | addr_hit_12 | addr_hit_13); // @[GpioRegTop.scala 282:19]
  wire  _T = addr_hit_0 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_3 = addr_hit_0 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_4 = addr_hit_1 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_7 = addr_hit_1 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_8 = addr_hit_2 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_11 = addr_hit_2 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_15 = addr_hit_3 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_16 = addr_hit_4 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_19 = addr_hit_4 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_20 = addr_hit_5 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_23 = addr_hit_5 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_24 = addr_hit_6 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_27 = addr_hit_6 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_28 = addr_hit_7 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_31 = addr_hit_7 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_32 = addr_hit_8 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_35 = addr_hit_8 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_36 = addr_hit_9 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_39 = addr_hit_9 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_40 = addr_hit_10 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_43 = addr_hit_10 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_44 = addr_hit_11 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_47 = addr_hit_11 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_48 = addr_hit_12 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_51 = addr_hit_12 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  _T_52 = addr_hit_13 & reg_we; // @[GpioRegTop.scala 291:8]
  wire  _T_55 = addr_hit_13 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 291:18]
  wire  wr_err = _T_3 | (_T_7 | (_T_11 | (_T_15 | (_T_19 | (_T_23 | (_T_27 | (_T_31 | (_T_35 | (_T_39 | (_T_43 | (_T_47
     | (_T_51 | _T_55)))))))))))); // @[Mux.scala 98:16]
  wire  _intr_state_we_T_1 = ~wr_err; // @[GpioRegTop.scala 298:43]
  wire [15:0] masked_out_lower_data_qs = masked_out_lower_data_reg_io_qs; // @[GpioRegTop.scala 63:90 GpioRegTop.scala 154:28]
  wire [31:0] _reg_rdata_next_T = {16'h0,masked_out_lower_data_qs}; // @[Cat.scala 30:58]
  wire [15:0] masked_out_upper_data_qs = masked_out_upper_data_reg_io_qs; // @[GpioRegTop.scala 66:90 GpioRegTop.scala 175:28]
  wire [31:0] _reg_rdata_next_T_1 = {16'h0,masked_out_upper_data_qs}; // @[Cat.scala 30:58]
  wire [15:0] masked_oe_lower_mask_qs = masked_oe_lower_mask_reg_io_qs; // @[GpioRegTop.scala 73:112 GpioRegTop.scala 217:27]
  wire [15:0] masked_oe_lower_data_qs = masked_oe_lower_data_reg_io_qs; // @[GpioRegTop.scala 73:112 GpioRegTop.scala 206:27]
  wire [31:0] _reg_rdata_next_T_2 = {masked_oe_lower_mask_qs,masked_oe_lower_data_qs}; // @[Cat.scala 30:58]
  wire [15:0] masked_oe_upper_mask_qs = masked_oe_upper_mask_reg_io_qs; // @[GpioRegTop.scala 76:112 GpioRegTop.scala 239:27]
  wire [15:0] masked_oe_upper_data_qs = masked_oe_upper_data_reg_io_qs; // @[GpioRegTop.scala 76:112 GpioRegTop.scala 228:27]
  wire [31:0] _reg_rdata_next_T_3 = {masked_oe_upper_mask_qs,masked_oe_upper_data_qs}; // @[Cat.scala 30:58]
  wire [31:0] intr_ctrl_en_lvllow_qs = intr_ctrl_en_lvllow_reg_io_qs; // @[GpioRegTop.scala 88:60 GpioRegTop.scala 275:26]
  wire [31:0] _GEN_0 = addr_hit_13 ? intr_ctrl_en_lvllow_qs : 32'hffffffff; // @[GpioRegTop.scala 384:28 GpioRegTop.scala 385:20 GpioRegTop.scala 387:20]
  wire [31:0] intr_ctrl_en_lvlhigh_qs = intr_ctrl_en_lvlhigh_reg_io_qs; // @[GpioRegTop.scala 85:62 GpioRegTop.scala 266:27]
  wire [31:0] _GEN_1 = addr_hit_12 ? intr_ctrl_en_lvlhigh_qs : _GEN_0; // @[GpioRegTop.scala 382:28 GpioRegTop.scala 383:20]
  wire [31:0] intr_ctrl_en_falling_qs = intr_ctrl_en_falling_reg_io_qs; // @[GpioRegTop.scala 82:62 GpioRegTop.scala 257:27]
  wire [31:0] _GEN_2 = addr_hit_11 ? intr_ctrl_en_falling_qs : _GEN_1; // @[GpioRegTop.scala 380:28 GpioRegTop.scala 381:20]
  wire [31:0] intr_ctrl_en_rising_qs = intr_ctrl_en_rising_reg_io_qs; // @[GpioRegTop.scala 79:60 GpioRegTop.scala 248:26]
  wire [31:0] _GEN_3 = addr_hit_10 ? intr_ctrl_en_rising_qs : _GEN_2; // @[GpioRegTop.scala 378:28 GpioRegTop.scala 379:20]
  wire [31:0] _GEN_4 = addr_hit_9 ? _reg_rdata_next_T_3 : _GEN_3; // @[GpioRegTop.scala 376:27 GpioRegTop.scala 377:20]
  wire [31:0] _GEN_5 = addr_hit_8 ? _reg_rdata_next_T_2 : _GEN_4; // @[GpioRegTop.scala 374:27 GpioRegTop.scala 375:20]
  wire [31:0] direct_oe_qs = direct_oe_reg_io_qs; // @[GpioRegTop.scala 69:26 GpioRegTop.scala 195:16]
  wire [31:0] _GEN_6 = addr_hit_7 ? direct_oe_qs : _GEN_5; // @[GpioRegTop.scala 372:27 GpioRegTop.scala 373:20]
  wire [31:0] _GEN_7 = addr_hit_6 ? _reg_rdata_next_T_1 : _GEN_6; // @[GpioRegTop.scala 370:27 GpioRegTop.scala 371:20]
  wire [31:0] _GEN_8 = addr_hit_5 ? _reg_rdata_next_T : _GEN_7; // @[GpioRegTop.scala 368:27 GpioRegTop.scala 369:20]
  wire [31:0] direct_out_qs = direct_out_reg_io_qs; // @[GpioRegTop.scala 60:42 GpioRegTop.scala 143:17]
  wire [31:0] _GEN_9 = addr_hit_4 ? direct_out_qs : _GEN_8; // @[GpioRegTop.scala 366:27 GpioRegTop.scala 367:20]
  wire [31:0] data_in_qs = data_in_reg_io_qs; // @[GpioRegTop.scala 58:24 GpioRegTop.scala 133:14]
  wire [31:0] _GEN_10 = addr_hit_3 ? data_in_qs : _GEN_9; // @[GpioRegTop.scala 364:27 GpioRegTop.scala 365:20]
  wire [31:0] _GEN_11 = addr_hit_2 ? 32'h0 : _GEN_10; // @[GpioRegTop.scala 362:27 GpioRegTop.scala 363:20]
  wire [31:0] intr_enable_qs = intr_enable_reg_io_qs; // @[GpioRegTop.scala 52:44 GpioRegTop.scala 116:18]
  wire [31:0] _GEN_12 = addr_hit_1 ? intr_enable_qs : _GEN_11; // @[GpioRegTop.scala 360:27 GpioRegTop.scala 361:20]
  wire [31:0] intr_state_qs = intr_state_reg_io_qs; // @[GpioRegTop.scala 49:42 GpioRegTop.scala 107:17]
  SubReg intr_state_reg ( // @[GpioRegTop.scala 95:30]
    .clock(intr_state_reg_clock),
    .reset(intr_state_reg_reset),
    .io_we(intr_state_reg_io_we),
    .io_wd(intr_state_reg_io_wd),
    .io_de(intr_state_reg_io_de),
    .io_d(intr_state_reg_io_d),
    .io_q(intr_state_reg_io_q),
    .io_qs(intr_state_reg_io_qs)
  );
  SubReg_1 intr_enable_reg ( // @[GpioRegTop.scala 110:31]
    .clock(intr_enable_reg_clock),
    .reset(intr_enable_reg_reset),
    .io_we(intr_enable_reg_io_we),
    .io_wd(intr_enable_reg_io_wd),
    .io_q(intr_enable_reg_io_q),
    .io_qs(intr_enable_reg_io_qs)
  );
  SubRegExt intr_test_reg ( // @[GpioRegTop.scala 119:29]
    .io_we(intr_test_reg_io_we),
    .io_wd(intr_test_reg_io_wd),
    .io_d(intr_test_reg_io_d),
    .io_qe(intr_test_reg_io_qe),
    .io_q(intr_test_reg_io_q),
    .io_qs(intr_test_reg_io_qs)
  );
  SubReg_2 data_in_reg ( // @[GpioRegTop.scala 128:27]
    .clock(data_in_reg_clock),
    .reset(data_in_reg_reset),
    .io_d(data_in_reg_io_d),
    .io_qs(data_in_reg_io_qs)
  );
  SubRegExt direct_out_reg ( // @[GpioRegTop.scala 136:30]
    .io_we(direct_out_reg_io_we),
    .io_wd(direct_out_reg_io_wd),
    .io_d(direct_out_reg_io_d),
    .io_qe(direct_out_reg_io_qe),
    .io_q(direct_out_reg_io_q),
    .io_qs(direct_out_reg_io_qs)
  );
  SubRegExt_2 masked_out_lower_data_reg ( // @[GpioRegTop.scala 147:41]
    .io_we(masked_out_lower_data_reg_io_we),
    .io_wd(masked_out_lower_data_reg_io_wd),
    .io_d(masked_out_lower_data_reg_io_d),
    .io_qe(masked_out_lower_data_reg_io_qe),
    .io_q(masked_out_lower_data_reg_io_q),
    .io_qs(masked_out_lower_data_reg_io_qs)
  );
  SubRegExt_2 masked_out_lower_mask_reg ( // @[GpioRegTop.scala 158:41]
    .io_we(masked_out_lower_mask_reg_io_we),
    .io_wd(masked_out_lower_mask_reg_io_wd),
    .io_d(masked_out_lower_mask_reg_io_d),
    .io_qe(masked_out_lower_mask_reg_io_qe),
    .io_q(masked_out_lower_mask_reg_io_q),
    .io_qs(masked_out_lower_mask_reg_io_qs)
  );
  SubRegExt_2 masked_out_upper_data_reg ( // @[GpioRegTop.scala 168:41]
    .io_we(masked_out_upper_data_reg_io_we),
    .io_wd(masked_out_upper_data_reg_io_wd),
    .io_d(masked_out_upper_data_reg_io_d),
    .io_qe(masked_out_upper_data_reg_io_qe),
    .io_q(masked_out_upper_data_reg_io_q),
    .io_qs(masked_out_upper_data_reg_io_qs)
  );
  SubRegExt_2 masked_out_upper_mask_reg ( // @[GpioRegTop.scala 179:41]
    .io_we(masked_out_upper_mask_reg_io_we),
    .io_wd(masked_out_upper_mask_reg_io_wd),
    .io_d(masked_out_upper_mask_reg_io_d),
    .io_qe(masked_out_upper_mask_reg_io_qe),
    .io_q(masked_out_upper_mask_reg_io_q),
    .io_qs(masked_out_upper_mask_reg_io_qs)
  );
  SubRegExt direct_oe_reg ( // @[GpioRegTop.scala 188:29]
    .io_we(direct_oe_reg_io_we),
    .io_wd(direct_oe_reg_io_wd),
    .io_d(direct_oe_reg_io_d),
    .io_qe(direct_oe_reg_io_qe),
    .io_q(direct_oe_reg_io_q),
    .io_qs(direct_oe_reg_io_qs)
  );
  SubRegExt_2 masked_oe_lower_data_reg ( // @[GpioRegTop.scala 199:40]
    .io_we(masked_oe_lower_data_reg_io_we),
    .io_wd(masked_oe_lower_data_reg_io_wd),
    .io_d(masked_oe_lower_data_reg_io_d),
    .io_qe(masked_oe_lower_data_reg_io_qe),
    .io_q(masked_oe_lower_data_reg_io_q),
    .io_qs(masked_oe_lower_data_reg_io_qs)
  );
  SubRegExt_2 masked_oe_lower_mask_reg ( // @[GpioRegTop.scala 210:40]
    .io_we(masked_oe_lower_mask_reg_io_we),
    .io_wd(masked_oe_lower_mask_reg_io_wd),
    .io_d(masked_oe_lower_mask_reg_io_d),
    .io_qe(masked_oe_lower_mask_reg_io_qe),
    .io_q(masked_oe_lower_mask_reg_io_q),
    .io_qs(masked_oe_lower_mask_reg_io_qs)
  );
  SubRegExt_2 masked_oe_upper_data_reg ( // @[GpioRegTop.scala 221:40]
    .io_we(masked_oe_upper_data_reg_io_we),
    .io_wd(masked_oe_upper_data_reg_io_wd),
    .io_d(masked_oe_upper_data_reg_io_d),
    .io_qe(masked_oe_upper_data_reg_io_qe),
    .io_q(masked_oe_upper_data_reg_io_q),
    .io_qs(masked_oe_upper_data_reg_io_qs)
  );
  SubRegExt_2 masked_oe_upper_mask_reg ( // @[GpioRegTop.scala 232:40]
    .io_we(masked_oe_upper_mask_reg_io_we),
    .io_wd(masked_oe_upper_mask_reg_io_wd),
    .io_d(masked_oe_upper_mask_reg_io_d),
    .io_qe(masked_oe_upper_mask_reg_io_qe),
    .io_q(masked_oe_upper_mask_reg_io_q),
    .io_qs(masked_oe_upper_mask_reg_io_qs)
  );
  SubReg_1 intr_ctrl_en_rising_reg ( // @[GpioRegTop.scala 242:39]
    .clock(intr_ctrl_en_rising_reg_clock),
    .reset(intr_ctrl_en_rising_reg_reset),
    .io_we(intr_ctrl_en_rising_reg_io_we),
    .io_wd(intr_ctrl_en_rising_reg_io_wd),
    .io_q(intr_ctrl_en_rising_reg_io_q),
    .io_qs(intr_ctrl_en_rising_reg_io_qs)
  );
  SubReg_1 intr_ctrl_en_falling_reg ( // @[GpioRegTop.scala 251:40]
    .clock(intr_ctrl_en_falling_reg_clock),
    .reset(intr_ctrl_en_falling_reg_reset),
    .io_we(intr_ctrl_en_falling_reg_io_we),
    .io_wd(intr_ctrl_en_falling_reg_io_wd),
    .io_q(intr_ctrl_en_falling_reg_io_q),
    .io_qs(intr_ctrl_en_falling_reg_io_qs)
  );
  SubReg_1 intr_ctrl_en_lvlhigh_reg ( // @[GpioRegTop.scala 260:40]
    .clock(intr_ctrl_en_lvlhigh_reg_clock),
    .reset(intr_ctrl_en_lvlhigh_reg_reset),
    .io_we(intr_ctrl_en_lvlhigh_reg_io_we),
    .io_wd(intr_ctrl_en_lvlhigh_reg_io_wd),
    .io_q(intr_ctrl_en_lvlhigh_reg_io_q),
    .io_qs(intr_ctrl_en_lvlhigh_reg_io_qs)
  );
  SubReg_1 intr_ctrl_en_lvllow_reg ( // @[GpioRegTop.scala 269:39]
    .clock(intr_ctrl_en_lvllow_reg_clock),
    .reset(intr_ctrl_en_lvllow_reg_reset),
    .io_we(intr_ctrl_en_lvllow_reg_io_we),
    .io_wd(intr_ctrl_en_lvllow_reg_io_wd),
    .io_q(intr_ctrl_en_lvllow_reg_io_q),
    .io_qs(intr_ctrl_en_lvllow_reg_io_qs)
  );
  assign io_req_ready = 1'h1; // @[GpioRegTop.scala 18:16]
  assign io_rsp_valid = io_rsp_valid_REG; // @[GpioRegTop.scala 39:16]
  assign io_rsp_bits_dataResponse = addr_hit_0 ? intr_state_qs : _GEN_12; // @[GpioRegTop.scala 358:21 GpioRegTop.scala 359:20]
  assign io_rsp_bits_error = addr_miss | wr_err; // @[GpioRegTop.scala 45:26]
  assign io_reg2hw_intr_state_q = intr_state_reg_io_q; // @[GpioRegTop.scala 105:26]
  assign io_reg2hw_intr_test_q = intr_test_reg_io_q; // @[GpioRegTop.scala 125:25]
  assign io_reg2hw_intr_test_qe = intr_test_reg_io_qe; // @[GpioRegTop.scala 124:26]
  assign io_reg2hw_direct_out_q = direct_out_reg_io_q; // @[GpioRegTop.scala 142:26]
  assign io_reg2hw_direct_out_qe = direct_out_reg_io_qe; // @[GpioRegTop.scala 141:27]
  assign io_reg2hw_masked_out_lower_data_q = masked_out_lower_data_reg_io_q; // @[GpioRegTop.scala 153:37]
  assign io_reg2hw_masked_out_lower_data_qe = masked_out_lower_data_reg_io_qe; // @[GpioRegTop.scala 152:38]
  assign io_reg2hw_masked_out_lower_mask_q = masked_out_lower_mask_reg_io_q; // @[GpioRegTop.scala 164:37]
  assign io_reg2hw_masked_out_upper_data_q = masked_out_upper_data_reg_io_q; // @[GpioRegTop.scala 174:37]
  assign io_reg2hw_masked_out_upper_data_qe = masked_out_upper_data_reg_io_qe; // @[GpioRegTop.scala 173:38]
  assign io_reg2hw_masked_out_upper_mask_q = masked_out_upper_mask_reg_io_q; // @[GpioRegTop.scala 185:37]
  assign io_reg2hw_direct_oe_q = direct_oe_reg_io_q; // @[GpioRegTop.scala 194:25]
  assign io_reg2hw_direct_oe_qe = direct_oe_reg_io_qe; // @[GpioRegTop.scala 193:26]
  assign io_reg2hw_masked_oe_lower_data_q = masked_oe_lower_data_reg_io_q; // @[GpioRegTop.scala 205:36]
  assign io_reg2hw_masked_oe_lower_data_qe = masked_oe_lower_data_reg_io_qe; // @[GpioRegTop.scala 204:37]
  assign io_reg2hw_masked_oe_lower_mask_q = masked_oe_lower_mask_reg_io_q; // @[GpioRegTop.scala 216:36]
  assign io_reg2hw_masked_oe_upper_data_q = masked_oe_upper_data_reg_io_q; // @[GpioRegTop.scala 227:36]
  assign io_reg2hw_masked_oe_upper_data_qe = masked_oe_upper_data_reg_io_qe; // @[GpioRegTop.scala 226:37]
  assign io_reg2hw_masked_oe_upper_mask_q = masked_oe_upper_mask_reg_io_q; // @[GpioRegTop.scala 238:36]
  assign io_reg2hw_intr_ctrl_en_rising_q = intr_ctrl_en_rising_reg_io_q; // @[GpioRegTop.scala 247:35]
  assign io_reg2hw_intr_ctrl_en_falling_q = intr_ctrl_en_falling_reg_io_q; // @[GpioRegTop.scala 256:36]
  assign io_reg2hw_intr_ctrl_en_lvlHigh_q = intr_ctrl_en_lvlhigh_reg_io_q; // @[GpioRegTop.scala 265:36]
  assign io_reg2hw_intr_ctrl_en_lvlLow_q = intr_ctrl_en_lvllow_reg_io_q; // @[GpioRegTop.scala 274:35]
  assign intr_state_reg_clock = clock;
  assign intr_state_reg_reset = reset;
  assign intr_state_reg_io_we = _T & ~wr_err; // @[GpioRegTop.scala 298:41]
  assign intr_state_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_state_reg_io_de = io_hw2reg_intr_state_de; // @[GpioRegTop.scala 101:24]
  assign intr_state_reg_io_d = io_hw2reg_intr_state_d; // @[GpioRegTop.scala 103:23]
  assign intr_enable_reg_clock = clock;
  assign intr_enable_reg_reset = reset;
  assign intr_enable_reg_io_we = _T_4 & _intr_state_we_T_1; // @[GpioRegTop.scala 301:42]
  assign intr_enable_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_test_reg_io_we = _T_8 & _intr_state_we_T_1; // @[GpioRegTop.scala 304:40]
  assign intr_test_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_test_reg_io_d = 32'h0; // @[GpioRegTop.scala 123:22]
  assign data_in_reg_clock = clock;
  assign data_in_reg_reset = reset;
  assign data_in_reg_io_d = io_hw2reg_data_in_d; // @[GpioRegTop.scala 132:20]
  assign direct_out_reg_io_we = _T_16 & _intr_state_we_T_1; // @[GpioRegTop.scala 307:41]
  assign direct_out_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign direct_out_reg_io_d = io_hw2reg_direct_out_d; // @[GpioRegTop.scala 140:23]
  assign masked_out_lower_data_reg_io_we = _T_20 & _intr_state_we_T_1; // @[GpioRegTop.scala 311:52]
  assign masked_out_lower_data_reg_io_wd = io_req_bits_dataRequest[15:0]; // @[GpioRegTop.scala 312:40]
  assign masked_out_lower_data_reg_io_d = io_hw2reg_masked_out_lower_data_d; // @[GpioRegTop.scala 151:34]
  assign masked_out_lower_mask_reg_io_we = _T_20 & _intr_state_we_T_1; // @[GpioRegTop.scala 315:52]
  assign masked_out_lower_mask_reg_io_wd = io_req_bits_dataRequest[31:16]; // @[GpioRegTop.scala 316:40]
  assign masked_out_lower_mask_reg_io_d = 16'h0; // @[GpioRegTop.scala 162:34]
  assign masked_out_upper_data_reg_io_we = _T_24 & _intr_state_we_T_1; // @[GpioRegTop.scala 318:52]
  assign masked_out_upper_data_reg_io_wd = io_req_bits_dataRequest[15:0]; // @[GpioRegTop.scala 319:40]
  assign masked_out_upper_data_reg_io_d = io_hw2reg_masked_out_upper_data_d; // @[GpioRegTop.scala 172:34]
  assign masked_out_upper_mask_reg_io_we = _T_24 & _intr_state_we_T_1; // @[GpioRegTop.scala 322:52]
  assign masked_out_upper_mask_reg_io_wd = io_req_bits_dataRequest[31:16]; // @[GpioRegTop.scala 323:40]
  assign masked_out_upper_mask_reg_io_d = 16'h0; // @[GpioRegTop.scala 183:34]
  assign direct_oe_reg_io_we = _T_28 & _intr_state_we_T_1; // @[GpioRegTop.scala 325:40]
  assign direct_oe_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign direct_oe_reg_io_d = io_hw2reg_direct_oe_d; // @[GpioRegTop.scala 192:22]
  assign masked_oe_lower_data_reg_io_we = _T_32 & _intr_state_we_T_1; // @[GpioRegTop.scala 329:51]
  assign masked_oe_lower_data_reg_io_wd = io_req_bits_dataRequest[15:0]; // @[GpioRegTop.scala 330:39]
  assign masked_oe_lower_data_reg_io_d = io_hw2reg_masked_oe_lower_data_d; // @[GpioRegTop.scala 203:33]
  assign masked_oe_lower_mask_reg_io_we = _T_32 & _intr_state_we_T_1; // @[GpioRegTop.scala 333:51]
  assign masked_oe_lower_mask_reg_io_wd = io_req_bits_dataRequest[31:16]; // @[GpioRegTop.scala 334:39]
  assign masked_oe_lower_mask_reg_io_d = 16'h0; // @[GpioRegTop.scala 214:33]
  assign masked_oe_upper_data_reg_io_we = _T_36 & _intr_state_we_T_1; // @[GpioRegTop.scala 337:51]
  assign masked_oe_upper_data_reg_io_wd = io_req_bits_dataRequest[15:0]; // @[GpioRegTop.scala 338:39]
  assign masked_oe_upper_data_reg_io_d = io_hw2reg_masked_oe_upper_data_d; // @[GpioRegTop.scala 225:33]
  assign masked_oe_upper_mask_reg_io_we = _T_36 & _intr_state_we_T_1; // @[GpioRegTop.scala 341:51]
  assign masked_oe_upper_mask_reg_io_wd = io_req_bits_dataRequest[31:16]; // @[GpioRegTop.scala 342:39]
  assign masked_oe_upper_mask_reg_io_d = 16'h0; // @[GpioRegTop.scala 236:33]
  assign intr_ctrl_en_rising_reg_clock = clock;
  assign intr_ctrl_en_rising_reg_reset = reset;
  assign intr_ctrl_en_rising_reg_io_we = _T_40 & _intr_state_we_T_1; // @[GpioRegTop.scala 345:51]
  assign intr_ctrl_en_rising_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_ctrl_en_falling_reg_clock = clock;
  assign intr_ctrl_en_falling_reg_reset = reset;
  assign intr_ctrl_en_falling_reg_io_we = _T_44 & _intr_state_we_T_1; // @[GpioRegTop.scala 348:52]
  assign intr_ctrl_en_falling_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_ctrl_en_lvlhigh_reg_clock = clock;
  assign intr_ctrl_en_lvlhigh_reg_reset = reset;
  assign intr_ctrl_en_lvlhigh_reg_io_we = _T_48 & _intr_state_we_T_1; // @[GpioRegTop.scala 351:52]
  assign intr_ctrl_en_lvlhigh_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_ctrl_en_lvllow_reg_clock = clock;
  assign intr_ctrl_en_lvllow_reg_reset = reset;
  assign intr_ctrl_en_lvllow_reg_io_we = _T_52 & _intr_state_we_T_1; // @[GpioRegTop.scala 354:51]
  assign intr_ctrl_en_lvllow_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  always @(posedge clock) begin
    io_rsp_valid_REG <= reg_we | reg_re; // @[GpioRegTop.scala 39:38]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_rsp_valid_REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IntrHardware(
  input  [31:0] io_event_intr_i,
  input  [31:0] io_reg2hw_intr_test_q_i,
  input         io_reg2hw_intr_test_qe_i,
  input  [31:0] io_reg2hw_intr_state_q_i,
  output        io_hw2reg_intr_state_de_o,
  output [31:0] io_hw2reg_intr_state_d_o
);
  wire [31:0] _new_event_T_1 = io_reg2hw_intr_test_qe_i ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _new_event_T_2 = _new_event_T_1 & io_reg2hw_intr_test_q_i; // @[IntrHardware.scala 25:54]
  wire [31:0] new_event = _new_event_T_2 | io_event_intr_i; // @[IntrHardware.scala 25:80]
  assign io_hw2reg_intr_state_de_o = |new_event; // @[IntrHardware.scala 26:45]
  assign io_hw2reg_intr_state_d_o = new_event | io_reg2hw_intr_state_q_i; // @[IntrHardware.scala 27:41]
endmodule
module Gpio(
  input         clock,
  input         reset,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input  [3:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse,
  output        io_rsp_bits_error,
  input  [31:0] io_cio_gpio_i,
  output [31:0] io_cio_gpio_o,
  output [31:0] io_cio_gpio_en_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  gpioRegTop_clock; // @[Gpio.scala 23:26]
  wire  gpioRegTop_reset; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_req_ready; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_req_valid; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_req_bits_addrRequest; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_req_bits_dataRequest; // @[Gpio.scala 23:26]
  wire [3:0] gpioRegTop_io_req_bits_activeByteLane; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_req_bits_isWrite; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_rsp_valid; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_rsp_bits_dataResponse; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_rsp_bits_error; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_state_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_test_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_intr_test_qe; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_direct_out_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_direct_out_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_out_lower_data_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_masked_out_lower_data_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_out_lower_mask_q; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_out_upper_data_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_masked_out_upper_data_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_out_upper_mask_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_direct_oe_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_direct_oe_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_oe_lower_data_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_masked_oe_lower_data_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_oe_lower_mask_q; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_oe_upper_data_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_masked_oe_upper_data_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_oe_upper_mask_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_ctrl_en_rising_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_ctrl_en_falling_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_ctrl_en_lvlHigh_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_ctrl_en_lvlLow_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_hw2reg_intr_state_d; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_hw2reg_intr_state_de; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_hw2reg_data_in_d; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_hw2reg_direct_out_d; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_hw2reg_masked_out_lower_data_d; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_hw2reg_masked_out_upper_data_d; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_hw2reg_direct_oe_d; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_hw2reg_masked_oe_lower_data_d; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_hw2reg_masked_oe_upper_data_d; // @[Gpio.scala 23:26]
  wire [31:0] intr_hw_io_event_intr_i; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_reg2hw_intr_test_q_i; // @[Gpio.scala 115:23]
  wire  intr_hw_io_reg2hw_intr_test_qe_i; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_reg2hw_intr_state_q_i; // @[Gpio.scala 115:23]
  wire  intr_hw_io_hw2reg_intr_state_de_o; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_hw2reg_intr_state_d_o; // @[Gpio.scala 115:23]
  reg [31:0] cio_gpio_q; // @[Gpio.scala 31:27]
  reg [31:0] cio_gpio_en_q; // @[Gpio.scala 32:30]
  reg [31:0] data_in_q; // @[Gpio.scala 33:26]
  wire [15:0] hw2reg_masked_out_upper_data_d = cio_gpio_q[31:16]; // @[Gpio.scala 48:47]
  wire [15:0] hw2reg_masked_out_lower_data_d = cio_gpio_q[15:0]; // @[Gpio.scala 50:47]
  wire [15:0] reg2hw_masked_out_upper_data_q = gpioRegTop_io_reg2hw_masked_out_upper_data_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] reg2hw_masked_out_upper_mask_q = gpioRegTop_io_reg2hw_masked_out_upper_mask_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] _cio_gpio_q_T = reg2hw_masked_out_upper_data_q & reg2hw_masked_out_upper_mask_q; // @[Gpio.scala 57:39]
  wire [15:0] _cio_gpio_q_T_1 = ~reg2hw_masked_out_upper_mask_q; // @[Gpio.scala 58:10]
  wire [15:0] _cio_gpio_q_T_3 = _cio_gpio_q_T_1 & hw2reg_masked_out_upper_data_d; // @[Gpio.scala 58:42]
  wire [15:0] cio_gpio_q_hi = _cio_gpio_q_T | _cio_gpio_q_T_3; // @[Gpio.scala 57:73]
  wire [31:0] _cio_gpio_q_T_4 = {cio_gpio_q_hi,16'h0}; // @[Cat.scala 30:58]
  wire [15:0] reg2hw_masked_out_lower_data_q = gpioRegTop_io_reg2hw_masked_out_lower_data_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] reg2hw_masked_out_lower_mask_q = gpioRegTop_io_reg2hw_masked_out_lower_mask_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] _cio_gpio_q_T_5 = reg2hw_masked_out_lower_data_q & reg2hw_masked_out_lower_mask_q; // @[Gpio.scala 67:66]
  wire [15:0] _cio_gpio_q_T_6 = ~reg2hw_masked_out_lower_mask_q; // @[Gpio.scala 68:8]
  wire [15:0] _cio_gpio_q_T_8 = _cio_gpio_q_T_6 & hw2reg_masked_out_lower_data_d; // @[Gpio.scala 68:40]
  wire [15:0] cio_gpio_q_lo = _cio_gpio_q_T_5 | _cio_gpio_q_T_8; // @[Gpio.scala 67:100]
  wire [31:0] _cio_gpio_q_T_9 = {16'h0,cio_gpio_q_lo}; // @[Cat.scala 30:58]
  wire  reg2hw_masked_out_lower_data_qe = gpioRegTop_io_reg2hw_masked_out_lower_data_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire  reg2hw_masked_out_upper_data_qe = gpioRegTop_io_reg2hw_masked_out_upper_data_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire  reg2hw_direct_out_qe = gpioRegTop_io_reg2hw_direct_out_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] reg2hw_direct_out_q = gpioRegTop_io_reg2hw_direct_out_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] hw2reg_masked_oe_upper_data_d = cio_gpio_en_q[31:16]; // @[Gpio.scala 73:49]
  wire [15:0] hw2reg_masked_oe_lower_data_d = cio_gpio_en_q[15:0]; // @[Gpio.scala 75:49]
  wire [15:0] reg2hw_masked_oe_upper_data_q = gpioRegTop_io_reg2hw_masked_oe_upper_data_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] reg2hw_masked_oe_upper_mask_q = gpioRegTop_io_reg2hw_masked_oe_upper_mask_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] _cio_gpio_en_q_T = reg2hw_masked_oe_upper_data_q & reg2hw_masked_oe_upper_mask_q; // @[Gpio.scala 81:57]
  wire [15:0] _cio_gpio_en_q_T_1 = ~reg2hw_masked_oe_upper_mask_q; // @[Gpio.scala 82:8]
  wire [15:0] _cio_gpio_en_q_T_3 = _cio_gpio_en_q_T_1 & hw2reg_masked_oe_upper_data_d; // @[Gpio.scala 82:39]
  wire [15:0] cio_gpio_en_q_hi = _cio_gpio_en_q_T | _cio_gpio_en_q_T_3; // @[Gpio.scala 81:90]
  wire [31:0] _cio_gpio_en_q_T_4 = {cio_gpio_en_q_hi,16'h0}; // @[Cat.scala 30:58]
  wire [15:0] reg2hw_masked_oe_lower_data_q = gpioRegTop_io_reg2hw_masked_oe_lower_data_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] reg2hw_masked_oe_lower_mask_q = gpioRegTop_io_reg2hw_masked_oe_lower_mask_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] _cio_gpio_en_q_T_5 = reg2hw_masked_oe_lower_data_q & reg2hw_masked_oe_lower_mask_q; // @[Gpio.scala 84:68]
  wire [15:0] _cio_gpio_en_q_T_6 = ~reg2hw_masked_oe_lower_mask_q; // @[Gpio.scala 85:8]
  wire [15:0] _cio_gpio_en_q_T_8 = _cio_gpio_en_q_T_6 & hw2reg_masked_oe_lower_data_d; // @[Gpio.scala 85:39]
  wire [15:0] cio_gpio_en_q_lo = _cio_gpio_en_q_T_5 | _cio_gpio_en_q_T_8; // @[Gpio.scala 84:101]
  wire [31:0] _cio_gpio_en_q_T_9 = {16'h0,cio_gpio_en_q_lo}; // @[Cat.scala 30:58]
  wire  reg2hw_masked_oe_lower_data_qe = gpioRegTop_io_reg2hw_masked_oe_lower_data_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire  reg2hw_masked_oe_upper_data_qe = gpioRegTop_io_reg2hw_masked_oe_upper_data_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire  reg2hw_direct_oe_qe = gpioRegTop_io_reg2hw_direct_oe_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] reg2hw_direct_oe_q = gpioRegTop_io_reg2hw_direct_oe_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] _event_intr_rise_T = ~data_in_q; // @[Gpio.scala 95:23]
  wire [31:0] _event_intr_rise_T_1 = _event_intr_rise_T & io_cio_gpio_i; // @[Gpio.scala 95:34]
  wire [31:0] reg2hw_intr_ctrl_en_rising_q = gpioRegTop_io_reg2hw_intr_ctrl_en_rising_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] event_intr_rise = _event_intr_rise_T_1 & reg2hw_intr_ctrl_en_rising_q; // @[Gpio.scala 95:47]
  wire [31:0] _event_intr_fall_T = ~io_cio_gpio_i; // @[Gpio.scala 99:35]
  wire [31:0] _event_intr_fall_T_1 = data_in_q & _event_intr_fall_T; // @[Gpio.scala 99:33]
  wire [31:0] reg2hw_intr_ctrl_en_falling_q = gpioRegTop_io_reg2hw_intr_ctrl_en_falling_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] event_intr_fall = _event_intr_fall_T_1 & reg2hw_intr_ctrl_en_falling_q; // @[Gpio.scala 99:47]
  wire [31:0] reg2hw_intr_ctrl_en_lvlHigh_q = gpioRegTop_io_reg2hw_intr_ctrl_en_lvlHigh_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] event_intr_acthigh = io_cio_gpio_i & reg2hw_intr_ctrl_en_lvlHigh_q; // @[Gpio.scala 105:35]
  wire [31:0] reg2hw_intr_ctrl_en_lvlLow_q = gpioRegTop_io_reg2hw_intr_ctrl_en_lvlLow_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] event_intr_actlow = _event_intr_fall_T & reg2hw_intr_ctrl_en_lvlLow_q; // @[Gpio.scala 111:35]
  wire [31:0] _event_intr_combined_T = event_intr_rise | event_intr_fall; // @[Gpio.scala 113:42]
  wire [31:0] _event_intr_combined_T_1 = _event_intr_combined_T | event_intr_acthigh; // @[Gpio.scala 113:60]
  GpioRegTop gpioRegTop ( // @[Gpio.scala 23:26]
    .clock(gpioRegTop_clock),
    .reset(gpioRegTop_reset),
    .io_req_ready(gpioRegTop_io_req_ready),
    .io_req_valid(gpioRegTop_io_req_valid),
    .io_req_bits_addrRequest(gpioRegTop_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(gpioRegTop_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(gpioRegTop_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(gpioRegTop_io_req_bits_isWrite),
    .io_rsp_valid(gpioRegTop_io_rsp_valid),
    .io_rsp_bits_dataResponse(gpioRegTop_io_rsp_bits_dataResponse),
    .io_rsp_bits_error(gpioRegTop_io_rsp_bits_error),
    .io_reg2hw_intr_state_q(gpioRegTop_io_reg2hw_intr_state_q),
    .io_reg2hw_intr_test_q(gpioRegTop_io_reg2hw_intr_test_q),
    .io_reg2hw_intr_test_qe(gpioRegTop_io_reg2hw_intr_test_qe),
    .io_reg2hw_direct_out_q(gpioRegTop_io_reg2hw_direct_out_q),
    .io_reg2hw_direct_out_qe(gpioRegTop_io_reg2hw_direct_out_qe),
    .io_reg2hw_masked_out_lower_data_q(gpioRegTop_io_reg2hw_masked_out_lower_data_q),
    .io_reg2hw_masked_out_lower_data_qe(gpioRegTop_io_reg2hw_masked_out_lower_data_qe),
    .io_reg2hw_masked_out_lower_mask_q(gpioRegTop_io_reg2hw_masked_out_lower_mask_q),
    .io_reg2hw_masked_out_upper_data_q(gpioRegTop_io_reg2hw_masked_out_upper_data_q),
    .io_reg2hw_masked_out_upper_data_qe(gpioRegTop_io_reg2hw_masked_out_upper_data_qe),
    .io_reg2hw_masked_out_upper_mask_q(gpioRegTop_io_reg2hw_masked_out_upper_mask_q),
    .io_reg2hw_direct_oe_q(gpioRegTop_io_reg2hw_direct_oe_q),
    .io_reg2hw_direct_oe_qe(gpioRegTop_io_reg2hw_direct_oe_qe),
    .io_reg2hw_masked_oe_lower_data_q(gpioRegTop_io_reg2hw_masked_oe_lower_data_q),
    .io_reg2hw_masked_oe_lower_data_qe(gpioRegTop_io_reg2hw_masked_oe_lower_data_qe),
    .io_reg2hw_masked_oe_lower_mask_q(gpioRegTop_io_reg2hw_masked_oe_lower_mask_q),
    .io_reg2hw_masked_oe_upper_data_q(gpioRegTop_io_reg2hw_masked_oe_upper_data_q),
    .io_reg2hw_masked_oe_upper_data_qe(gpioRegTop_io_reg2hw_masked_oe_upper_data_qe),
    .io_reg2hw_masked_oe_upper_mask_q(gpioRegTop_io_reg2hw_masked_oe_upper_mask_q),
    .io_reg2hw_intr_ctrl_en_rising_q(gpioRegTop_io_reg2hw_intr_ctrl_en_rising_q),
    .io_reg2hw_intr_ctrl_en_falling_q(gpioRegTop_io_reg2hw_intr_ctrl_en_falling_q),
    .io_reg2hw_intr_ctrl_en_lvlHigh_q(gpioRegTop_io_reg2hw_intr_ctrl_en_lvlHigh_q),
    .io_reg2hw_intr_ctrl_en_lvlLow_q(gpioRegTop_io_reg2hw_intr_ctrl_en_lvlLow_q),
    .io_hw2reg_intr_state_d(gpioRegTop_io_hw2reg_intr_state_d),
    .io_hw2reg_intr_state_de(gpioRegTop_io_hw2reg_intr_state_de),
    .io_hw2reg_data_in_d(gpioRegTop_io_hw2reg_data_in_d),
    .io_hw2reg_direct_out_d(gpioRegTop_io_hw2reg_direct_out_d),
    .io_hw2reg_masked_out_lower_data_d(gpioRegTop_io_hw2reg_masked_out_lower_data_d),
    .io_hw2reg_masked_out_upper_data_d(gpioRegTop_io_hw2reg_masked_out_upper_data_d),
    .io_hw2reg_direct_oe_d(gpioRegTop_io_hw2reg_direct_oe_d),
    .io_hw2reg_masked_oe_lower_data_d(gpioRegTop_io_hw2reg_masked_oe_lower_data_d),
    .io_hw2reg_masked_oe_upper_data_d(gpioRegTop_io_hw2reg_masked_oe_upper_data_d)
  );
  IntrHardware intr_hw ( // @[Gpio.scala 115:23]
    .io_event_intr_i(intr_hw_io_event_intr_i),
    .io_reg2hw_intr_test_q_i(intr_hw_io_reg2hw_intr_test_q_i),
    .io_reg2hw_intr_test_qe_i(intr_hw_io_reg2hw_intr_test_qe_i),
    .io_reg2hw_intr_state_q_i(intr_hw_io_reg2hw_intr_state_q_i),
    .io_hw2reg_intr_state_de_o(intr_hw_io_hw2reg_intr_state_de_o),
    .io_hw2reg_intr_state_d_o(intr_hw_io_hw2reg_intr_state_d_o)
  );
  assign io_rsp_valid = gpioRegTop_io_rsp_valid; // @[Gpio.scala 26:10]
  assign io_rsp_bits_dataResponse = gpioRegTop_io_rsp_bits_dataResponse; // @[Gpio.scala 26:10]
  assign io_rsp_bits_error = gpioRegTop_io_rsp_bits_error; // @[Gpio.scala 26:10]
  assign io_cio_gpio_o = cio_gpio_q; // @[Gpio.scala 44:17]
  assign io_cio_gpio_en_o = cio_gpio_en_q; // @[Gpio.scala 45:20]
  assign gpioRegTop_clock = clock;
  assign gpioRegTop_reset = reset;
  assign gpioRegTop_io_req_valid = io_req_valid; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_req_bits_addrRequest = io_req_bits_addrRequest; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_req_bits_dataRequest = io_req_bits_dataRequest; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_req_bits_activeByteLane = io_req_bits_activeByteLane; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_req_bits_isWrite = io_req_bits_isWrite; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_hw2reg_intr_state_d = intr_hw_io_hw2reg_intr_state_d_o; // @[Gpio.scala 21:20 Gpio.scala 122:23]
  assign gpioRegTop_io_hw2reg_intr_state_de = intr_hw_io_hw2reg_intr_state_de_o; // @[Gpio.scala 21:20 Gpio.scala 121:24]
  assign gpioRegTop_io_hw2reg_data_in_d = io_cio_gpio_i; // @[Gpio.scala 35:23 Gpio.scala 36:13]
  assign gpioRegTop_io_hw2reg_direct_out_d = cio_gpio_q; // @[Gpio.scala 21:20 Gpio.scala 47:23]
  assign gpioRegTop_io_hw2reg_masked_out_lower_data_d = cio_gpio_q[15:0]; // @[Gpio.scala 50:47]
  assign gpioRegTop_io_hw2reg_masked_out_upper_data_d = cio_gpio_q[31:16]; // @[Gpio.scala 48:47]
  assign gpioRegTop_io_hw2reg_direct_oe_d = cio_gpio_en_q; // @[Gpio.scala 21:20 Gpio.scala 72:22]
  assign gpioRegTop_io_hw2reg_masked_oe_lower_data_d = cio_gpio_en_q[15:0]; // @[Gpio.scala 75:49]
  assign gpioRegTop_io_hw2reg_masked_oe_upper_data_d = cio_gpio_en_q[31:16]; // @[Gpio.scala 73:49]
  assign intr_hw_io_event_intr_i = _event_intr_combined_T_1 | event_intr_actlow; // @[Gpio.scala 113:81]
  assign intr_hw_io_reg2hw_intr_test_q_i = gpioRegTop_io_reg2hw_intr_test_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  assign intr_hw_io_reg2hw_intr_test_qe_i = gpioRegTop_io_reg2hw_intr_test_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  assign intr_hw_io_reg2hw_intr_state_q_i = gpioRegTop_io_reg2hw_intr_state_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  always @(posedge clock) begin
    if (reset) begin // @[Gpio.scala 31:27]
      cio_gpio_q <= 32'h0; // @[Gpio.scala 31:27]
    end else if (reg2hw_direct_out_qe) begin // @[Gpio.scala 53:30]
      cio_gpio_q <= reg2hw_direct_out_q; // @[Gpio.scala 54:16]
    end else if (reg2hw_masked_out_upper_data_qe) begin // @[Gpio.scala 55:48]
      cio_gpio_q <= _cio_gpio_q_T_4; // @[Gpio.scala 56:16]
    end else if (reg2hw_masked_out_lower_data_qe) begin // @[Gpio.scala 66:48]
      cio_gpio_q <= _cio_gpio_q_T_9; // @[Gpio.scala 67:16]
    end
    if (reset) begin // @[Gpio.scala 32:30]
      cio_gpio_en_q <= 32'h0; // @[Gpio.scala 32:30]
    end else if (reg2hw_direct_oe_qe) begin // @[Gpio.scala 78:29]
      cio_gpio_en_q <= reg2hw_direct_oe_q; // @[Gpio.scala 79:19]
    end else if (reg2hw_masked_oe_upper_data_qe) begin // @[Gpio.scala 80:47]
      cio_gpio_en_q <= _cio_gpio_en_q_T_4; // @[Gpio.scala 81:19]
    end else if (reg2hw_masked_oe_lower_data_qe) begin // @[Gpio.scala 83:47]
      cio_gpio_en_q <= _cio_gpio_en_q_T_9; // @[Gpio.scala 84:19]
    end
    if (reset) begin // @[Gpio.scala 33:26]
      data_in_q <= 32'h0; // @[Gpio.scala 33:26]
    end else begin
      data_in_q <= io_cio_gpio_i; // @[Gpio.scala 37:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cio_gpio_q = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  cio_gpio_en_q = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  data_in_q = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Protocol(
  input         clock,
  input         reset,
  input         io_miso,
  output        io_mosi,
  output        io_ss,
  output        io_sck,
  input         io_data_in_valid,
  input  [31:0] io_data_in_bits,
  output        io_data_out_valid,
  output [31:0] io_data_out_bits,
  input         io_CPOL
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  state; // @[Protocol.scala 29:24]
  reg [31:0] miso_dataReg; // @[Protocol.scala 31:31]
  reg [6:0] count; // @[Protocol.scala 32:24]
  reg [63:0] dataReg; // @[Protocol.scala 33:26]
  wire  _io_sck_T_2 = io_CPOL ? ~clock : clock; // @[Protocol.scala 36:38]
  wire  _T = ~state; // @[Conditional.scala 37:30]
  wire [63:0] _dataReg_T = {io_data_in_bits,32'h0}; // @[Cat.scala 30:58]
  wire [63:0] _GEN_0 = io_data_in_valid ? _dataReg_T : dataReg; // @[Protocol.scala 50:59 Protocol.scala 51:25 Protocol.scala 33:26]
  wire  _GEN_1 = io_data_in_valid | state; // @[Protocol.scala 50:59 Protocol.scala 52:23 Protocol.scala 29:24]
  wire  _T_2 = count == 7'h40; // @[Protocol.scala 61:25]
  wire [64:0] _dataReg_T_1 = {dataReg, 1'h0}; // @[Protocol.scala 69:36]
  wire [6:0] _count_T_1 = count + 7'h1; // @[Protocol.scala 70:32]
  wire  _GEN_5 = count == 7'h40 ? 1'h0 : dataReg[63]; // @[Protocol.scala 61:48 Protocol.scala 44:13 Protocol.scala 68:25]
  wire [64:0] _GEN_6 = count == 7'h40 ? {{1'd0}, dataReg} : _dataReg_T_1; // @[Protocol.scala 61:48 Protocol.scala 33:26 Protocol.scala 69:25]
  wire  _GEN_8 = state ? _T_2 : 1'h1; // @[Conditional.scala 39:67 Protocol.scala 43:11]
  wire  _GEN_11 = state & _GEN_5; // @[Conditional.scala 39:67 Protocol.scala 44:13]
  wire [64:0] _GEN_12 = state ? _GEN_6 : {{1'd0}, dataReg}; // @[Conditional.scala 39:67 Protocol.scala 33:26]
  wire [64:0] _GEN_14 = _T ? {{1'd0}, _GEN_0} : _GEN_12; // @[Conditional.scala 40:58]
  wire  _GEN_16 = _T | _GEN_8; // @[Conditional.scala 40:58 Protocol.scala 43:11]
  reg [6:0] count1; // @[Protocol.scala 76:25]
  wire  _T_4 = count1 == 7'h40; // @[Protocol.scala 80:26]
  wire [32:0] _miso_dataReg_T = {miso_dataReg, 1'h0}; // @[Protocol.scala 85:46]
  wire [32:0] _GEN_28 = {{32'd0}, io_miso}; // @[Protocol.scala 85:51]
  wire [32:0] _miso_dataReg_T_1 = _miso_dataReg_T | _GEN_28; // @[Protocol.scala 85:51]
  wire [6:0] _count1_T_1 = count1 + 7'h1; // @[Protocol.scala 86:34]
  wire [31:0] _GEN_19 = count1 == 7'h40 ? miso_dataReg : 32'h0; // @[Protocol.scala 80:73 Protocol.scala 81:34 Protocol.scala 42:22]
  wire [32:0] _GEN_22 = count1 == 7'h40 ? {{1'd0}, miso_dataReg} : _miso_dataReg_T_1; // @[Protocol.scala 80:73 Protocol.scala 31:31 Protocol.scala 85:30]
  wire [32:0] _GEN_27 = state ? _GEN_22 : {{1'd0}, miso_dataReg}; // @[Conditional.scala 40:58 Protocol.scala 31:31]
  assign io_mosi = _T ? 1'h0 : _GEN_11; // @[Conditional.scala 40:58 Protocol.scala 44:13]
  assign io_ss = state ? 1'h0 : _GEN_16; // @[Conditional.scala 40:58 Protocol.scala 79:19]
  assign io_sck = state & _io_sck_T_2; // @[Protocol.scala 36:18]
  assign io_data_out_valid = state & _T_4; // @[Conditional.scala 40:58 Protocol.scala 41:23]
  assign io_data_out_bits = state ? _GEN_19 : 32'h0; // @[Conditional.scala 40:58 Protocol.scala 42:22]
  always @(posedge clock) begin
    if (reset) begin // @[Protocol.scala 29:24]
      state <= 1'h0; // @[Protocol.scala 29:24]
    end else if (_T) begin // @[Conditional.scala 40:58]
      state <= _GEN_1;
    end else if (state) begin // @[Conditional.scala 39:67]
      if (count == 7'h40) begin // @[Protocol.scala 61:48]
        state <= 1'h0; // @[Protocol.scala 64:23]
      end
    end
    if (reset) begin // @[Protocol.scala 31:31]
      miso_dataReg <= 32'h0; // @[Protocol.scala 31:31]
    end else begin
      miso_dataReg <= _GEN_27[31:0];
    end
    if (reset) begin // @[Protocol.scala 32:24]
      count <= 7'h0; // @[Protocol.scala 32:24]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (state) begin // @[Conditional.scala 39:67]
        if (count == 7'h40) begin // @[Protocol.scala 61:48]
          count <= 7'h0; // @[Protocol.scala 65:23]
        end else begin
          count <= _count_T_1; // @[Protocol.scala 70:23]
        end
      end
    end
    if (reset) begin // @[Protocol.scala 33:26]
      dataReg <= 64'h0; // @[Protocol.scala 33:26]
    end else begin
      dataReg <= _GEN_14[63:0];
    end
    if (reset) begin // @[Protocol.scala 76:25]
      count1 <= 7'h0; // @[Protocol.scala 76:25]
    end else if (state) begin // @[Conditional.scala 40:58]
      if (count1 == 7'h40) begin // @[Protocol.scala 80:73]
        count1 <= 7'h0; // @[Protocol.scala 83:24]
      end else begin
        count1 <= _count1_T_1; // @[Protocol.scala 86:24]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  miso_dataReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  count = _RAND_2[6:0];
  _RAND_3 = {2{`RANDOM}};
  dataReg = _RAND_3[63:0];
  _RAND_4 = {1{`RANDOM}};
  count1 = _RAND_4[6:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Spi(
  input         clock,
  input         reset,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input  [3:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse,
  output        io_rsp_bits_error,
  output        io_cs_n,
  output        io_sclk,
  output        io_mosi,
  input         io_miso
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
`endif // RANDOMIZE_REG_INIT
  wire  spiProtocol_clock; // @[Spi.scala 127:29]
  wire  spiProtocol_reset; // @[Spi.scala 127:29]
  wire  spiProtocol_io_miso; // @[Spi.scala 127:29]
  wire  spiProtocol_io_mosi; // @[Spi.scala 127:29]
  wire  spiProtocol_io_ss; // @[Spi.scala 127:29]
  wire  spiProtocol_io_sck; // @[Spi.scala 127:29]
  wire  spiProtocol_io_data_in_valid; // @[Spi.scala 127:29]
  wire [31:0] spiProtocol_io_data_in_bits; // @[Spi.scala 127:29]
  wire  spiProtocol_io_data_out_valid; // @[Spi.scala 127:29]
  wire [31:0] spiProtocol_io_data_out_bits; // @[Spi.scala 127:29]
  wire  spiProtocol_io_CPOL; // @[Spi.scala 127:29]
  reg [31:0] ControlReg; // @[Spi.scala 29:29]
  reg [31:0] TxDataReg; // @[Spi.scala 30:31]
  reg  TxDataValidReg; // @[Spi.scala 31:33]
  reg [31:0] RxDataReg; // @[Spi.scala 32:31]
  wire [7:0] maskedData_0 = io_req_bits_activeByteLane[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] maskedData_1 = io_req_bits_activeByteLane[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] maskedData_2 = io_req_bits_activeByteLane[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] maskedData_3 = io_req_bits_activeByteLane[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire  _T_13 = io_req_bits_addrRequest[3:0] == 4'h0; // @[Spi.scala 42:40]
  wire [31:0] _ControlReg_T = {maskedData_3,maskedData_2,maskedData_1,maskedData_0}; // @[Spi.scala 43:78]
  wire [31:0] _ControlReg_T_1 = io_req_bits_dataRequest & _ControlReg_T; // @[Spi.scala 43:65]
  reg [31:0] io_rsp_bits_dataResponse_REG; // @[Spi.scala 45:44]
  reg  io_rsp_valid_REG; // @[Spi.scala 46:32]
  wire  _T_18 = ~io_req_bits_isWrite; // @[Spi.scala 52:75]
  reg [31:0] io_rsp_bits_dataResponse_REG_1; // @[Spi.scala 53:44]
  reg  io_rsp_valid_REG_1; // @[Spi.scala 54:32]
  wire  _T_21 = io_req_bits_addrRequest[3:0] == 4'h4; // @[Spi.scala 60:44]
  wire [23:0] TxDataReg_lo_1 = _ControlReg_T_1[23:0]; // @[Spi.scala 62:107]
  wire [25:0] _TxDataReg_T_2 = {2'h3,TxDataReg_lo_1}; // @[Cat.scala 30:58]
  wire [25:0] _TxDataReg_T_3 = io_req_valid ? _TxDataReg_T_2 : 26'h0; // @[Spi.scala 62:29]
  wire [26:0] _TxDataReg_T_5 = io_req_valid ? 27'h6000000 : 27'h0; // @[Spi.scala 66:29]
  wire [25:0] _TxDataReg_T_8 = {2'h2,TxDataReg_lo_1}; // @[Cat.scala 30:58]
  wire [25:0] _TxDataReg_T_9 = io_req_valid ? _TxDataReg_T_8 : 26'h0; // @[Spi.scala 70:29]
  wire [31:0] _TxDataReg_T_12 = io_req_valid ? _ControlReg_T_1 : 32'h0; // @[Spi.scala 74:29]
  wire [26:0] _TxDataReg_T_14 = io_req_valid ? 27'h4000000 : 27'h0; // @[Spi.scala 78:29]
  wire [31:0] _GEN_0 = ControlReg[4:2] == 3'h4 ? {{5'd0}, _TxDataReg_T_14} : TxDataReg; // @[Spi.scala 77:43 Spi.scala 78:23 Spi.scala 30:31]
  wire  _GEN_1 = ControlReg[4:2] == 3'h4 ? io_req_valid : TxDataValidReg; // @[Spi.scala 77:43 Spi.scala 79:28 Spi.scala 31:33]
  wire [31:0] _GEN_2 = ControlReg[4:2] == 3'h3 ? _TxDataReg_T_12 : _GEN_0; // @[Spi.scala 73:43 Spi.scala 74:23]
  wire  _GEN_3 = ControlReg[4:2] == 3'h3 ? io_req_valid : _GEN_1; // @[Spi.scala 73:43 Spi.scala 75:28]
  wire [31:0] _GEN_4 = ControlReg[4:2] == 3'h2 ? {{6'd0}, _TxDataReg_T_9} : _GEN_2; // @[Spi.scala 69:43 Spi.scala 70:23]
  wire  _GEN_5 = ControlReg[4:2] == 3'h2 ? io_req_valid : _GEN_3; // @[Spi.scala 69:43 Spi.scala 71:28]
  wire [31:0] _GEN_6 = ControlReg[4:2] == 3'h1 ? {{5'd0}, _TxDataReg_T_5} : _GEN_4; // @[Spi.scala 65:43 Spi.scala 66:23]
  wire  _GEN_7 = ControlReg[4:2] == 3'h1 ? io_req_valid : _GEN_5; // @[Spi.scala 65:43 Spi.scala 67:28]
  wire [31:0] _GEN_8 = ControlReg[4:2] == 3'h0 ? {{6'd0}, _TxDataReg_T_3} : _GEN_6; // @[Spi.scala 61:38 Spi.scala 62:23]
  wire  _GEN_9 = ControlReg[4:2] == 3'h0 ? io_req_valid : _GEN_7; // @[Spi.scala 61:38 Spi.scala 63:28]
  reg [31:0] io_rsp_bits_dataResponse_REG_2; // @[Spi.scala 83:44]
  reg  io_rsp_valid_REG_2; // @[Spi.scala 84:32]
  reg [31:0] io_rsp_bits_dataResponse_REG_3; // @[Spi.scala 90:44]
  reg  io_rsp_valid_REG_3; // @[Spi.scala 91:32]
  wire  _T_39 = io_req_bits_addrRequest[3:0] == 4'h8; // @[Spi.scala 96:44]
  reg [31:0] io_rsp_bits_dataResponse_REG_4; // @[Spi.scala 97:44]
  reg [31:0] io_rsp_bits_dataResponse_REG_5; // @[Spi.scala 108:44]
  wire [31:0] _GEN_10 = io_req_bits_addrRequest[3:0] == 4'h8 & _T_18 ? io_rsp_bits_dataResponse_REG_4 :
    io_rsp_bits_dataResponse_REG_5; // @[Spi.scala 96:83 Spi.scala 97:34 Spi.scala 108:34]
  wire [31:0] _GEN_12 = _T_21 & _T_18 ? io_rsp_bits_dataResponse_REG_3 : _GEN_10; // @[Spi.scala 89:83 Spi.scala 90:34]
  wire  _GEN_13 = _T_21 & _T_18 ? io_rsp_valid_REG_3 : 1'h1; // @[Spi.scala 89:83 Spi.scala 91:22]
  wire [31:0] _GEN_16 = io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite ? io_rsp_bits_dataResponse_REG_2 :
    _GEN_12; // @[Spi.scala 60:83 Spi.scala 83:34]
  wire  _GEN_17 = io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite ? io_rsp_valid_REG_2 : _GEN_13; // @[Spi.scala 60:83 Spi.scala 84:22]
  wire [31:0] _GEN_18 = _T_13 & ~io_req_bits_isWrite ? io_rsp_bits_dataResponse_REG_1 : _GEN_16; // @[Spi.scala 52:83 Spi.scala 53:34]
  wire  _GEN_19 = _T_13 & ~io_req_bits_isWrite ? io_rsp_valid_REG_1 : _GEN_17; // @[Spi.scala 52:83 Spi.scala 54:22]
  wire [25:0] _spiProtocol_clock_T_3 = ControlReg[31:6] - 26'h1; // @[Spi.scala 117:36]
  reg [25:0] spiProtocol_clock_x; // @[Spi.scala 113:24]
  wire [25:0] _spiProtocol_clock_x_T_2 = spiProtocol_clock_x + 26'h1; // @[Spi.scala 114:36]
  wire  _spiProtocol_clock_T_4 = spiProtocol_clock_x == 26'h0; // @[Spi.scala 117:43]
  reg  spiProtocol_clock_x_1; // @[Spi.scala 119:24]
  wire  addr_miss = ~(_T_13 | _T_21 | _T_39); // @[Spi.scala 161:18]
  reg  io_rsp_bits_error_REG; // @[Spi.scala 162:78]
  reg  io_rsp_bits_error_REG_1; // @[Spi.scala 163:44]
  Protocol spiProtocol ( // @[Spi.scala 127:29]
    .clock(spiProtocol_clock),
    .reset(spiProtocol_reset),
    .io_miso(spiProtocol_io_miso),
    .io_mosi(spiProtocol_io_mosi),
    .io_ss(spiProtocol_io_ss),
    .io_sck(spiProtocol_io_sck),
    .io_data_in_valid(spiProtocol_io_data_in_valid),
    .io_data_in_bits(spiProtocol_io_data_in_bits),
    .io_data_out_valid(spiProtocol_io_data_out_valid),
    .io_data_out_bits(spiProtocol_io_data_out_bits),
    .io_CPOL(spiProtocol_io_CPOL)
  );
  assign io_rsp_valid = io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite ? io_rsp_valid_REG : _GEN_19; // @[Spi.scala 42:79 Spi.scala 46:22]
  assign io_rsp_bits_dataResponse = io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite ?
    io_rsp_bits_dataResponse_REG : _GEN_18; // @[Spi.scala 42:79 Spi.scala 45:34]
  assign io_rsp_bits_error = _T_39 & io_req_bits_isWrite ? io_rsp_bits_error_REG : io_rsp_bits_error_REG_1; // @[Spi.scala 162:49 Spi.scala 162:68 Spi.scala 163:34]
  assign io_cs_n = spiProtocol_io_ss; // @[Spi.scala 136:121]
  assign io_sclk = spiProtocol_io_sck; // @[Spi.scala 136:121]
  assign io_mosi = spiProtocol_io_mosi; // @[Spi.scala 136:121]
  assign spiProtocol_clock = spiProtocol_clock_x_1; // @[Spi.scala 129:53]
  assign spiProtocol_reset = reset;
  assign spiProtocol_io_miso = io_miso; // @[Spi.scala 134:25]
  assign spiProtocol_io_data_in_valid = TxDataValidReg; // @[Spi.scala 131:34]
  assign spiProtocol_io_data_in_bits = TxDataReg; // @[Spi.scala 130:34]
  assign spiProtocol_io_CPOL = ControlReg[1]; // @[Spi.scala 132:38]
  always @(posedge clock) begin
    if (reset) begin // @[Spi.scala 29:29]
      ControlReg <= 32'h60; // @[Spi.scala 29:29]
    end else if (io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite) begin // @[Spi.scala 42:79]
      if (io_req_valid) begin // @[Spi.scala 43:26]
        ControlReg <= _ControlReg_T_1;
      end
    end
    if (reset) begin // @[Spi.scala 30:31]
      TxDataReg <= 32'h0; // @[Spi.scala 30:31]
    end else if (!(io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite)) begin // @[Spi.scala 42:79]
      if (!(_T_13 & ~io_req_bits_isWrite)) begin // @[Spi.scala 52:83]
        if (io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite) begin // @[Spi.scala 60:83]
          TxDataReg <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[Spi.scala 31:33]
      TxDataValidReg <= 1'h0; // @[Spi.scala 31:33]
    end else if (!(io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite)) begin // @[Spi.scala 42:79]
      if (!(_T_13 & ~io_req_bits_isWrite)) begin // @[Spi.scala 52:83]
        if (io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite) begin // @[Spi.scala 60:83]
          TxDataValidReg <= _GEN_9;
        end
      end
    end
    if (reset) begin // @[Spi.scala 32:31]
      RxDataReg <= 32'h0; // @[Spi.scala 32:31]
    end else if (spiProtocol_io_data_out_valid) begin // @[Spi.scala 137:40]
      RxDataReg <= spiProtocol_io_data_out_bits; // @[Spi.scala 138:19]
    end
    io_rsp_bits_dataResponse_REG <= io_req_bits_dataRequest; // @[Spi.scala 45:48]
    io_rsp_valid_REG <= io_req_valid; // @[Spi.scala 46:32]
    io_rsp_bits_dataResponse_REG_1 <= ControlReg; // @[Spi.scala 53:48]
    io_rsp_valid_REG_1 <= io_req_valid; // @[Spi.scala 54:36]
    io_rsp_bits_dataResponse_REG_2 <= io_req_bits_addrRequest; // @[Spi.scala 83:48]
    io_rsp_valid_REG_2 <= io_req_valid; // @[Spi.scala 84:32]
    io_rsp_bits_dataResponse_REG_3 <= TxDataReg; // @[Spi.scala 90:48]
    io_rsp_valid_REG_3 <= io_req_valid; // @[Spi.scala 91:32]
    io_rsp_bits_dataResponse_REG_4 <= RxDataReg; // @[Spi.scala 97:48]
    io_rsp_bits_dataResponse_REG_5 <= io_req_bits_addrRequest; // @[Spi.scala 108:44]
    if (reset) begin // @[Spi.scala 113:24]
      spiProtocol_clock_x <= 26'h0; // @[Spi.scala 113:24]
    end else if (spiProtocol_clock_x == _spiProtocol_clock_T_3) begin // @[Spi.scala 114:17]
      spiProtocol_clock_x <= 26'h0;
    end else begin
      spiProtocol_clock_x <= _spiProtocol_clock_x_T_2;
    end
    if (reset) begin // @[Spi.scala 119:24]
      spiProtocol_clock_x_1 <= 1'h0; // @[Spi.scala 119:24]
    end else if (_spiProtocol_clock_T_4) begin // @[Spi.scala 120:17]
      spiProtocol_clock_x_1 <= ~spiProtocol_clock_x_1;
    end
    io_rsp_bits_error_REG <= io_req_valid; // @[Spi.scala 162:78]
    io_rsp_bits_error_REG_1 <= io_req_valid & addr_miss; // @[Spi.scala 163:58]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ControlReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  TxDataReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  TxDataValidReg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  RxDataReg = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  io_rsp_valid_REG = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_1 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  io_rsp_valid_REG_1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_2 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  io_rsp_valid_REG_2 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_3 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  io_rsp_valid_REG_3 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_4 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_5 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  spiProtocol_clock_x = _RAND_14[25:0];
  _RAND_15 = {1{`RANDOM}};
  spiProtocol_clock_x_1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  io_rsp_bits_error_REG = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  io_rsp_bits_error_REG_1 = _RAND_17[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module uartTX(
  input         clock,
  input         reset,
  input         io_tx_en,
  input  [7:0]  io_i_TX_Byte,
  input  [15:0] io_CLKS_PER_BIT,
  output        io_o_TX_Serial,
  output        io_o_TX_Done
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] r_SM_Main; // @[uartTX.scala 23:28]
  reg [15:0] r_Clock_Count; // @[uartTX.scala 24:32]
  reg [2:0] r_Bit_Index; // @[uartTX.scala 25:30]
  reg [7:0] r_TX_Data; // @[uartTX.scala 26:28]
  reg  r_TX_Done; // @[uartTX.scala 27:28]
  wire  _T = 3'h0 == r_SM_Main; // @[Conditional.scala 37:30]
  wire  _T_2 = 3'h1 == r_SM_Main; // @[Conditional.scala 37:30]
  wire [15:0] _T_4 = io_CLKS_PER_BIT - 16'h1; // @[uartTX.scala 51:49]
  wire  _T_5 = r_Clock_Count < _T_4; // @[uartTX.scala 51:32]
  wire [15:0] _r_Clock_Count_T_1 = r_Clock_Count + 16'h1; // @[uartTX.scala 52:48]
  wire [15:0] _GEN_2 = r_Clock_Count < _T_4 ? _r_Clock_Count_T_1 : 16'h0; // @[uartTX.scala 51:54 uartTX.scala 52:31 uartTX.scala 55:31]
  wire  _T_6 = 3'h2 == r_SM_Main; // @[Conditional.scala 37:30]
  wire [7:0] _io_o_TX_Serial_T = r_TX_Data >> r_Bit_Index; // @[uartTX.scala 61:40]
  wire [2:0] _r_Bit_Index_T_1 = r_Bit_Index + 3'h1; // @[uartTX.scala 69:48]
  wire [2:0] _GEN_4 = r_Bit_Index < 3'h7 ? _r_Bit_Index_T_1 : 3'h0; // @[uartTX.scala 68:40 uartTX.scala 69:33 uartTX.scala 72:33]
  wire [2:0] _GEN_5 = r_Bit_Index < 3'h7 ? 3'h2 : 3'h3; // @[uartTX.scala 68:40 uartTX.scala 70:31 uartTX.scala 73:31]
  wire [2:0] _GEN_7 = _T_5 ? 3'h2 : _GEN_5; // @[uartTX.scala 63:56 uartTX.scala 65:27]
  wire [2:0] _GEN_8 = _T_5 ? r_Bit_Index : _GEN_4; // @[uartTX.scala 63:56 uartTX.scala 25:30]
  wire  _T_11 = 3'h3 == r_SM_Main; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_10 = _T_5 ? 3'h3 : 3'h4; // @[uartTX.scala 83:56 uartTX.scala 85:27 uartTX.scala 89:27]
  wire  _GEN_11 = _T_5 ? r_TX_Done : 1'h1; // @[uartTX.scala 83:56 uartTX.scala 27:28 uartTX.scala 87:27]
  wire  _T_15 = 3'h4 == r_SM_Main; // @[Conditional.scala 37:30]
  wire  _GEN_13 = _T_15 | r_TX_Done; // @[Conditional.scala 39:67 uartTX.scala 96:23 uartTX.scala 27:28]
  wire [2:0] _GEN_14 = _T_15 ? 3'h0 : r_SM_Main; // @[Conditional.scala 39:67 uartTX.scala 97:23 uartTX.scala 23:28]
  wire [15:0] _GEN_16 = _T_11 ? _GEN_2 : r_Clock_Count; // @[Conditional.scala 39:67 uartTX.scala 24:32]
  wire [2:0] _GEN_17 = _T_11 ? _GEN_10 : _GEN_14; // @[Conditional.scala 39:67]
  wire  _GEN_18 = _T_11 ? _GEN_11 : _GEN_13; // @[Conditional.scala 39:67]
  wire  _GEN_19 = _T_6 ? _io_o_TX_Serial_T[0] : 1'h1; // @[Conditional.scala 39:67 uartTX.scala 61:28]
  wire  _GEN_24 = _T_2 ? 1'h0 : _GEN_19; // @[Conditional.scala 39:67 uartTX.scala 49:28]
  assign io_o_TX_Serial = _T | _GEN_24; // @[Conditional.scala 40:58 uartTX.scala 35:28]
  assign io_o_TX_Done = r_TX_Done; // @[uartTX.scala 103:18]
  always @(posedge clock) begin
    if (reset) begin // @[uartTX.scala 23:28]
      r_SM_Main <= 3'h0; // @[uartTX.scala 23:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_tx_en) begin // @[uartTX.scala 40:35]
        r_SM_Main <= 3'h1; // @[uartTX.scala 42:27]
      end else begin
        r_SM_Main <= 3'h0; // @[uartTX.scala 44:27]
      end
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      if (r_Clock_Count < _T_4) begin // @[uartTX.scala 51:54]
        r_SM_Main <= 3'h1; // @[uartTX.scala 53:27]
      end else begin
        r_SM_Main <= 3'h2; // @[uartTX.scala 56:27]
      end
    end else if (_T_6) begin // @[Conditional.scala 39:67]
      r_SM_Main <= _GEN_7;
    end else begin
      r_SM_Main <= _GEN_17;
    end
    if (reset) begin // @[uartTX.scala 24:32]
      r_Clock_Count <= 16'h0; // @[uartTX.scala 24:32]
    end else if (_T) begin // @[Conditional.scala 40:58]
      r_Clock_Count <= 16'h0; // @[uartTX.scala 37:27]
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      r_Clock_Count <= _GEN_2;
    end else if (_T_6) begin // @[Conditional.scala 39:67]
      r_Clock_Count <= _GEN_2;
    end else begin
      r_Clock_Count <= _GEN_16;
    end
    if (reset) begin // @[uartTX.scala 25:30]
      r_Bit_Index <= 3'h0; // @[uartTX.scala 25:30]
    end else if (_T) begin // @[Conditional.scala 40:58]
      r_Bit_Index <= 3'h0; // @[uartTX.scala 38:25]
    end else if (!(_T_2)) begin // @[Conditional.scala 39:67]
      if (_T_6) begin // @[Conditional.scala 39:67]
        r_Bit_Index <= _GEN_8;
      end
    end
    if (reset) begin // @[uartTX.scala 26:28]
      r_TX_Data <= 8'h0; // @[uartTX.scala 26:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_tx_en) begin // @[uartTX.scala 40:35]
        r_TX_Data <= io_i_TX_Byte; // @[uartTX.scala 41:27]
      end
    end
    if (reset) begin // @[uartTX.scala 27:28]
      r_TX_Done <= 1'h0; // @[uartTX.scala 27:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      r_TX_Done <= 1'h0; // @[uartTX.scala 36:23]
    end else if (!(_T_2)) begin // @[Conditional.scala 39:67]
      if (!(_T_6)) begin // @[Conditional.scala 39:67]
        r_TX_Done <= _GEN_18;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  r_SM_Main = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  r_Clock_Count = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  r_Bit_Index = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  r_TX_Data = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  r_TX_Done = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module uartRX(
  input         clock,
  input         reset,
  input         io_i_Rx_Serial,
  input  [15:0] io_CLKS_PER_BIT,
  output        io_o_Rx_DV,
  output [7:0]  io_o_Rx_Byte
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[uartRX.scala 18:32]
  reg  rxReg; // @[uartRX.scala 18:24]
  reg [7:0] shiftReg; // @[uartRX.scala 19:27]
  reg [2:0] r_SM_Main; // @[uartRX.scala 21:28]
  reg [15:0] r_Clock_Count; // @[uartRX.scala 22:32]
  reg [2:0] r_Bit_Index; // @[uartRX.scala 23:30]
  reg  r_Rx_DV; // @[uartRX.scala 24:26]
  wire  _T = 3'h0 == r_SM_Main; // @[Conditional.scala 37:30]
  wire  _T_1 = ~io_i_Rx_Serial; // @[uartRX.scala 33:33]
  wire  _T_2 = 3'h1 == r_SM_Main; // @[Conditional.scala 37:30]
  wire [15:0] _T_4 = io_CLKS_PER_BIT - 16'h1; // @[uartRX.scala 41:52]
  wire [15:0] _T_5 = _T_4 / 2'h2; // @[uartRX.scala 41:57]
  wire [15:0] _GEN_1 = _T_1 ? 16'h0 : r_Clock_Count; // @[uartRX.scala 42:45 uartRX.scala 43:35 uartRX.scala 22:32]
  wire [2:0] _GEN_2 = _T_1 ? 3'h2 : 3'h0; // @[uartRX.scala 42:45 uartRX.scala 44:31 uartRX.scala 46:31]
  wire [15:0] _r_Clock_Count_T_1 = r_Clock_Count + 16'h1; // @[uartRX.scala 49:48]
  wire  _T_8 = 3'h2 == r_SM_Main; // @[Conditional.scala 37:30]
  wire  _T_11 = r_Clock_Count < _T_4; // @[uartRX.scala 55:32]
  wire [6:0] shiftReg_lo = shiftReg[7:1]; // @[uartRX.scala 60:49]
  wire [7:0] _shiftReg_T = {rxReg,shiftReg_lo}; // @[Cat.scala 30:58]
  wire [2:0] _r_Bit_Index_T_1 = r_Bit_Index + 3'h1; // @[uartRX.scala 63:48]
  wire [2:0] _GEN_5 = r_Bit_Index < 3'h7 ? _r_Bit_Index_T_1 : 3'h0; // @[uartRX.scala 62:40 uartRX.scala 63:33 uartRX.scala 66:33]
  wire [2:0] _GEN_6 = r_Bit_Index < 3'h7 ? 3'h2 : 3'h3; // @[uartRX.scala 62:40 uartRX.scala 64:31 uartRX.scala 67:31]
  wire [15:0] _GEN_7 = r_Clock_Count < _T_4 ? _r_Clock_Count_T_1 : 16'h0; // @[uartRX.scala 55:56 uartRX.scala 56:31 uartRX.scala 59:31]
  wire [2:0] _GEN_8 = r_Clock_Count < _T_4 ? 3'h2 : _GEN_6; // @[uartRX.scala 55:56 uartRX.scala 57:27]
  wire [7:0] _GEN_9 = r_Clock_Count < _T_4 ? shiftReg : _shiftReg_T; // @[uartRX.scala 55:56 uartRX.scala 19:27 uartRX.scala 60:26]
  wire [2:0] _GEN_10 = r_Clock_Count < _T_4 ? r_Bit_Index : _GEN_5; // @[uartRX.scala 55:56 uartRX.scala 23:30]
  wire  _T_13 = 3'h3 == r_SM_Main; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_12 = _T_11 ? 3'h3 : 3'h4; // @[uartRX.scala 74:56 uartRX.scala 76:27 uartRX.scala 80:27]
  wire  _GEN_13 = _T_11 ? r_Rx_DV : 1'h1; // @[uartRX.scala 74:56 uartRX.scala 24:26 uartRX.scala 78:25]
  wire  _T_17 = 3'h4 == r_SM_Main; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_14 = _T_17 ? 3'h0 : r_SM_Main; // @[Conditional.scala 39:67 uartRX.scala 85:23 uartRX.scala 21:28]
  wire  _GEN_15 = _T_17 ? 1'h0 : r_Rx_DV; // @[Conditional.scala 39:67 uartRX.scala 86:21 uartRX.scala 24:26]
  wire [15:0] _GEN_16 = _T_13 ? _GEN_7 : r_Clock_Count; // @[Conditional.scala 39:67 uartRX.scala 22:32]
  wire [2:0] _GEN_17 = _T_13 ? _GEN_12 : _GEN_14; // @[Conditional.scala 39:67]
  wire  _GEN_18 = _T_13 ? _GEN_13 : _GEN_15; // @[Conditional.scala 39:67]
  assign io_o_Rx_DV = r_Rx_DV; // @[uartRX.scala 90:16]
  assign io_o_Rx_Byte = shiftReg; // @[uartRX.scala 91:18]
  always @(posedge clock) begin
    rxReg_REG <= reset | io_i_Rx_Serial; // @[uartRX.scala 18:32 uartRX.scala 18:32 uartRX.scala 18:32]
    rxReg <= reset | rxReg_REG; // @[uartRX.scala 18:24 uartRX.scala 18:24 uartRX.scala 18:24]
    if (reset) begin // @[uartRX.scala 19:27]
      shiftReg <= 8'h0; // @[uartRX.scala 19:27]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_2)) begin // @[Conditional.scala 39:67]
        if (_T_8) begin // @[Conditional.scala 39:67]
          shiftReg <= _GEN_9;
        end
      end
    end
    if (reset) begin // @[uartRX.scala 21:28]
      r_SM_Main <= 3'h0; // @[uartRX.scala 21:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (~io_i_Rx_Serial) begin // @[uartRX.scala 33:41]
        r_SM_Main <= 3'h1; // @[uartRX.scala 34:27]
      end else begin
        r_SM_Main <= 3'h0; // @[uartRX.scala 36:27]
      end
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      if (r_Clock_Count == _T_5) begin // @[uartRX.scala 41:62]
        r_SM_Main <= _GEN_2;
      end else begin
        r_SM_Main <= 3'h1; // @[uartRX.scala 50:27]
      end
    end else if (_T_8) begin // @[Conditional.scala 39:67]
      r_SM_Main <= _GEN_8;
    end else begin
      r_SM_Main <= _GEN_17;
    end
    if (reset) begin // @[uartRX.scala 22:32]
      r_Clock_Count <= 16'h0; // @[uartRX.scala 22:32]
    end else if (_T) begin // @[Conditional.scala 40:58]
      r_Clock_Count <= 16'h0; // @[uartRX.scala 29:27]
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      if (r_Clock_Count == _T_5) begin // @[uartRX.scala 41:62]
        r_Clock_Count <= _GEN_1;
      end else begin
        r_Clock_Count <= _r_Clock_Count_T_1; // @[uartRX.scala 49:31]
      end
    end else if (_T_8) begin // @[Conditional.scala 39:67]
      r_Clock_Count <= _GEN_7;
    end else begin
      r_Clock_Count <= _GEN_16;
    end
    if (reset) begin // @[uartRX.scala 23:30]
      r_Bit_Index <= 3'h0; // @[uartRX.scala 23:30]
    end else if (_T) begin // @[Conditional.scala 40:58]
      r_Bit_Index <= 3'h0; // @[uartRX.scala 30:25]
    end else if (!(_T_2)) begin // @[Conditional.scala 39:67]
      if (_T_8) begin // @[Conditional.scala 39:67]
        r_Bit_Index <= _GEN_10;
      end
    end
    if (reset) begin // @[uartRX.scala 24:26]
      r_Rx_DV <= 1'h0; // @[uartRX.scala 24:26]
    end else if (_T) begin // @[Conditional.scala 40:58]
      r_Rx_DV <= 1'h0; // @[uartRX.scala 28:21]
    end else if (!(_T_2)) begin // @[Conditional.scala 39:67]
      if (!(_T_8)) begin // @[Conditional.scala 39:67]
        r_Rx_DV <= _GEN_18;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rxReg_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rxReg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  shiftReg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  r_SM_Main = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  r_Clock_Count = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  r_Bit_Index = _RAND_5[2:0];
  _RAND_6 = {1{`RANDOM}};
  r_Rx_DV = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module UartTOP(
  input         clock,
  input         reset,
  input         io_ren,
  input         io_we,
  input  [31:0] io_wdata,
  input  [7:0]  io_addr,
  input         io_rx_i,
  output [31:0] io_rdata,
  output        io_tx_o,
  output        io_intr_tx
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  wire  uart_tx_clock; // @[UartTOP.scala 162:25]
  wire  uart_tx_reset; // @[UartTOP.scala 162:25]
  wire  uart_tx_io_tx_en; // @[UartTOP.scala 162:25]
  wire [7:0] uart_tx_io_i_TX_Byte; // @[UartTOP.scala 162:25]
  wire [15:0] uart_tx_io_CLKS_PER_BIT; // @[UartTOP.scala 162:25]
  wire  uart_tx_io_o_TX_Serial; // @[UartTOP.scala 162:25]
  wire  uart_tx_io_o_TX_Done; // @[UartTOP.scala 162:25]
  wire  uart_rx_clock; // @[UartTOP.scala 163:25]
  wire  uart_rx_reset; // @[UartTOP.scala 163:25]
  wire  uart_rx_io_i_Rx_Serial; // @[UartTOP.scala 163:25]
  wire [15:0] uart_rx_io_CLKS_PER_BIT; // @[UartTOP.scala 163:25]
  wire  uart_rx_io_o_Rx_DV; // @[UartTOP.scala 163:25]
  wire [7:0] uart_rx_io_o_Rx_Byte; // @[UartTOP.scala 163:25]
  reg [15:0] control; // @[UartTOP.scala 131:26]
  reg [7:0] tx; // @[UartTOP.scala 132:21]
  reg [7:0] rx; // @[UartTOP.scala 133:21]
  reg [7:0] rx_reg; // @[UartTOP.scala 134:25]
  reg  rx_en; // @[UartTOP.scala 135:24]
  reg  tx_en; // @[UartTOP.scala 136:24]
  reg  rx_status; // @[UartTOP.scala 137:28]
  reg  rx_clr; // @[UartTOP.scala 138:25]
  reg  rx_done; // @[UartTOP.scala 139:26]
  wire  _GEN_0 = io_addr == 8'h18 & io_wdata[0]; // @[UartTOP.scala 150:38 UartTOP.scala 151:20 UartTOP.scala 157:20]
  wire [15:0] _GEN_1 = io_addr == 8'h18 ? control : 16'h0; // @[UartTOP.scala 150:38 UartTOP.scala 131:26 UartTOP.scala 153:21]
  wire [7:0] _GEN_2 = io_addr == 8'h18 ? tx : 8'h0; // @[UartTOP.scala 150:38 UartTOP.scala 132:21 UartTOP.scala 154:16]
  wire  _GEN_3 = io_addr == 8'h18 & rx_en; // @[UartTOP.scala 150:38 UartTOP.scala 135:24 UartTOP.scala 155:19]
  wire  _GEN_4 = io_addr == 8'h18 & tx_en; // @[UartTOP.scala 150:38 UartTOP.scala 136:24 UartTOP.scala 156:19]
  wire  _GEN_5 = io_addr == 8'h10 ? io_wdata[0] : _GEN_4; // @[UartTOP.scala 148:38 UartTOP.scala 149:19]
  wire  _GEN_6 = io_addr == 8'h10 ? rx_clr : _GEN_0; // @[UartTOP.scala 148:38 UartTOP.scala 138:25]
  wire [15:0] _GEN_7 = io_addr == 8'h10 ? control : _GEN_1; // @[UartTOP.scala 148:38 UartTOP.scala 131:26]
  wire [7:0] _GEN_8 = io_addr == 8'h10 ? tx : _GEN_2; // @[UartTOP.scala 148:38 UartTOP.scala 132:21]
  wire  _GEN_9 = io_addr == 8'h10 ? rx_en : _GEN_3; // @[UartTOP.scala 148:38 UartTOP.scala 135:24]
  wire  _GEN_10 = io_addr == 8'hc ? io_wdata[0] : _GEN_9; // @[UartTOP.scala 146:38 UartTOP.scala 147:19]
  wire  _GEN_11 = io_addr == 8'hc ? tx_en : _GEN_5; // @[UartTOP.scala 146:38 UartTOP.scala 136:24]
  wire  _GEN_12 = io_addr == 8'hc ? rx_clr : _GEN_6; // @[UartTOP.scala 146:38 UartTOP.scala 138:25]
  wire [15:0] _GEN_13 = io_addr == 8'hc ? control : _GEN_7; // @[UartTOP.scala 146:38 UartTOP.scala 131:26]
  wire [7:0] _GEN_14 = io_addr == 8'hc ? tx : _GEN_8; // @[UartTOP.scala 146:38 UartTOP.scala 132:21]
  wire [7:0] _GEN_15 = io_addr == 8'h4 ? io_wdata[7:0] : _GEN_14; // @[UartTOP.scala 144:40 UartTOP.scala 145:16]
  wire  _GEN_18 = io_addr == 8'h4 ? rx_clr : _GEN_12; // @[UartTOP.scala 144:40 UartTOP.scala 138:25]
  wire  _GEN_24 = io_addr == 8'h0 ? rx_clr : _GEN_18; // @[UartTOP.scala 142:36 UartTOP.scala 138:25]
  wire  _GEN_29 = ~io_ren & io_we ? _GEN_24 : rx_clr; // @[UartTOP.scala 141:29 UartTOP.scala 138:25]
  wire  _GEN_32 = ~rx_clr ? 1'h0 : rx_status; // @[UartTOP.scala 190:26 UartTOP.scala 191:19 UartTOP.scala 137:28]
  wire  _GEN_34 = rx_done | _GEN_32; // @[UartTOP.scala 187:18 UartTOP.scala 189:19]
  wire [7:0] _io_rdata_T_2 = io_addr == 8'h8 ? rx_reg : 8'h0; // @[UartTOP.scala 194:55]
  wire [7:0] _io_rdata_T_3 = io_addr == 8'h14 ? {{7'd0}, rx_status} : _io_rdata_T_2; // @[UartTOP.scala 194:20]
  uartTX uart_tx ( // @[UartTOP.scala 162:25]
    .clock(uart_tx_clock),
    .reset(uart_tx_reset),
    .io_tx_en(uart_tx_io_tx_en),
    .io_i_TX_Byte(uart_tx_io_i_TX_Byte),
    .io_CLKS_PER_BIT(uart_tx_io_CLKS_PER_BIT),
    .io_o_TX_Serial(uart_tx_io_o_TX_Serial),
    .io_o_TX_Done(uart_tx_io_o_TX_Done)
  );
  uartRX uart_rx ( // @[UartTOP.scala 163:25]
    .clock(uart_rx_clock),
    .reset(uart_rx_reset),
    .io_i_Rx_Serial(uart_rx_io_i_Rx_Serial),
    .io_CLKS_PER_BIT(uart_rx_io_CLKS_PER_BIT),
    .io_o_Rx_DV(uart_rx_io_o_Rx_DV),
    .io_o_Rx_Byte(uart_rx_io_o_Rx_Byte)
  );
  assign io_rdata = {{24'd0}, _io_rdata_T_3}; // @[UartTOP.scala 194:20]
  assign io_tx_o = uart_tx_io_o_TX_Serial; // @[UartTOP.scala 172:13]
  assign io_intr_tx = uart_tx_io_o_TX_Done; // @[UartTOP.scala 173:16]
  assign uart_tx_clock = clock;
  assign uart_tx_reset = reset;
  assign uart_tx_io_tx_en = tx_en; // @[UartTOP.scala 165:22]
  assign uart_tx_io_i_TX_Byte = tx; // @[UartTOP.scala 169:26]
  assign uart_tx_io_CLKS_PER_BIT = control; // @[UartTOP.scala 170:29]
  assign uart_rx_clock = clock;
  assign uart_rx_reset = reset;
  assign uart_rx_io_i_Rx_Serial = rx_en ? io_rx_i : 1'h1; // @[UartTOP.scala 176:16 UartTOP.scala 177:32 UartTOP.scala 179:32]
  assign uart_rx_io_CLKS_PER_BIT = control; // @[UartTOP.scala 181:29]
  always @(posedge clock) begin
    if (reset) begin // @[UartTOP.scala 131:26]
      control <= 16'h0; // @[UartTOP.scala 131:26]
    end else if (~io_ren & io_we) begin // @[UartTOP.scala 141:29]
      if (io_addr == 8'h0) begin // @[UartTOP.scala 142:36]
        control <= io_wdata[15:0]; // @[UartTOP.scala 143:21]
      end else if (!(io_addr == 8'h4)) begin // @[UartTOP.scala 144:40]
        control <= _GEN_13;
      end
    end
    if (reset) begin // @[UartTOP.scala 132:21]
      tx <= 8'h0; // @[UartTOP.scala 132:21]
    end else if (uart_rx_io_o_Rx_DV) begin // @[UartTOP.scala 166:29]
      tx <= uart_rx_io_o_Rx_Byte; // @[UartTOP.scala 167:12]
    end else if (~io_ren & io_we) begin // @[UartTOP.scala 141:29]
      if (!(io_addr == 8'h0)) begin // @[UartTOP.scala 142:36]
        tx <= _GEN_15;
      end
    end
    if (reset) begin // @[UartTOP.scala 133:21]
      rx <= 8'h0; // @[UartTOP.scala 133:21]
    end else begin
      rx <= uart_rx_io_o_Rx_Byte; // @[UartTOP.scala 184:8]
    end
    if (reset) begin // @[UartTOP.scala 134:25]
      rx_reg <= 8'h0; // @[UartTOP.scala 134:25]
    end else if (rx_done) begin // @[UartTOP.scala 187:18]
      rx_reg <= rx; // @[UartTOP.scala 188:16]
    end
    if (reset) begin // @[UartTOP.scala 135:24]
      rx_en <= 1'h0; // @[UartTOP.scala 135:24]
    end else if (~io_ren & io_we) begin // @[UartTOP.scala 141:29]
      if (!(io_addr == 8'h0)) begin // @[UartTOP.scala 142:36]
        if (!(io_addr == 8'h4)) begin // @[UartTOP.scala 144:40]
          rx_en <= _GEN_10;
        end
      end
    end
    if (reset) begin // @[UartTOP.scala 136:24]
      tx_en <= 1'h0; // @[UartTOP.scala 136:24]
    end else if (~io_ren & io_we) begin // @[UartTOP.scala 141:29]
      if (!(io_addr == 8'h0)) begin // @[UartTOP.scala 142:36]
        if (!(io_addr == 8'h4)) begin // @[UartTOP.scala 144:40]
          tx_en <= _GEN_11;
        end
      end
    end
    if (reset) begin // @[UartTOP.scala 137:28]
      rx_status <= 1'h0; // @[UartTOP.scala 137:28]
    end else begin
      rx_status <= _GEN_34;
    end
    rx_clr <= reset | _GEN_29; // @[UartTOP.scala 138:25 UartTOP.scala 138:25]
    if (reset) begin // @[UartTOP.scala 139:26]
      rx_done <= 1'h0; // @[UartTOP.scala 139:26]
    end else begin
      rx_done <= uart_rx_io_o_Rx_DV; // @[UartTOP.scala 183:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  control = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  tx = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  rx = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  rx_reg = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  rx_en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  tx_en = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  rx_status = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  rx_clr = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  rx_done = _RAND_8[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module uart(
  input         clock,
  input         reset,
  output        io_request_ready,
  input         io_request_valid,
  input  [31:0] io_request_bits_addrRequest,
  input  [31:0] io_request_bits_dataRequest,
  input         io_request_bits_isWrite,
  output        io_response_valid,
  output [31:0] io_response_bits_dataResponse,
  output        io_response_bits_error,
  input         io_cio_uart_rx_i,
  output        io_cio_uart_tx_o,
  output        io_cio_uart_intr_tx_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  uart_top_clock; // @[uart.scala 57:31]
  wire  uart_top_reset; // @[uart.scala 57:31]
  wire  uart_top_io_ren; // @[uart.scala 57:31]
  wire  uart_top_io_we; // @[uart.scala 57:31]
  wire [31:0] uart_top_io_wdata; // @[uart.scala 57:31]
  wire [7:0] uart_top_io_addr; // @[uart.scala 57:31]
  wire  uart_top_io_rx_i; // @[uart.scala 57:31]
  wire [31:0] uart_top_io_rdata; // @[uart.scala 57:31]
  wire  uart_top_io_tx_o; // @[uart.scala 57:31]
  wire  uart_top_io_intr_tx; // @[uart.scala 57:31]
  wire  _write_register_T = io_request_ready & io_request_valid; // @[Decoupled.scala 40:37]
  wire  write_register = _write_register_T & io_request_bits_isWrite; // @[uart.scala 64:26]
  wire  read_register = _write_register_T & ~io_request_bits_isWrite; // @[uart.scala 65:25]
  reg [31:0] io_response_bits_dataResponse_REG; // @[uart.scala 73:45]
  reg  io_response_valid_REG; // @[uart.scala 74:33]
  reg  io_response_bits_error_REG; // @[uart.scala 75:38]
  UartTOP uart_top ( // @[uart.scala 57:31]
    .clock(uart_top_clock),
    .reset(uart_top_reset),
    .io_ren(uart_top_io_ren),
    .io_we(uart_top_io_we),
    .io_wdata(uart_top_io_wdata),
    .io_addr(uart_top_io_addr),
    .io_rx_i(uart_top_io_rx_i),
    .io_rdata(uart_top_io_rdata),
    .io_tx_o(uart_top_io_tx_o),
    .io_intr_tx(uart_top_io_intr_tx)
  );
  assign io_request_ready = 1'h1; // @[uart.scala 19:22]
  assign io_response_valid = io_response_valid_REG; // @[uart.scala 74:23]
  assign io_response_bits_dataResponse = io_response_bits_dataResponse_REG; // @[uart.scala 73:35]
  assign io_response_bits_error = io_response_bits_error_REG; // @[uart.scala 75:28]
  assign io_cio_uart_tx_o = uart_top_io_tx_o; // @[uart.scala 78:22]
  assign io_cio_uart_intr_tx_o = uart_top_io_intr_tx; // @[uart.scala 77:27]
  assign uart_top_clock = clock;
  assign uart_top_reset = reset;
  assign uart_top_io_ren = _write_register_T & ~io_request_bits_isWrite; // @[uart.scala 65:25]
  assign uart_top_io_we = _write_register_T & io_request_bits_isWrite; // @[uart.scala 64:26]
  assign uart_top_io_wdata = io_request_bits_dataRequest; // @[uart.scala 61:24 uart.scala 66:14]
  assign uart_top_io_addr = io_request_bits_addrRequest[7:0]; // @[uart.scala 67:44]
  assign uart_top_io_rx_i = io_cio_uart_rx_i; // @[uart.scala 79:22]
  always @(posedge clock) begin
    io_response_bits_dataResponse_REG <= uart_top_io_rdata; // @[uart.scala 73:49]
    io_response_valid_REG <= write_register | read_register; // @[uart.scala 74:53]
    io_response_bits_error_REG <= uart_top_io_intr_tx; // @[uart.scala 75:42]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_response_bits_dataResponse_REG = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  io_response_valid_REG = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  io_response_bits_error_REG = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module WishboneErr(
  input         clock,
  input         reset,
  output [31:0] io_wbSlaveTransmitter_bits_dat,
  output        io_wbSlaveTransmitter_bits_err,
  input         io_wbMasterReceiver_valid,
  input         io_wbMasterReceiver_bits_cyc,
  input         io_wbMasterReceiver_bits_stb
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] dataReg; // @[WishboneErr.scala 15:24]
  reg  errReg; // @[WishboneErr.scala 16:23]
  wire  _T_1 = io_wbMasterReceiver_valid & io_wbMasterReceiver_bits_cyc & io_wbMasterReceiver_bits_stb; // @[WishboneErr.scala 12:80]
  assign io_wbSlaveTransmitter_bits_dat = dataReg; // @[WishboneErr.scala 44:34]
  assign io_wbSlaveTransmitter_bits_err = errReg; // @[WishboneErr.scala 45:35]
  always @(posedge clock) begin
    if (reset) begin // @[WishboneErr.scala 15:24]
      dataReg <= 32'h0; // @[WishboneErr.scala 15:24]
    end else if (_T_1) begin // @[WishboneErr.scala 21:16]
      dataReg <= 32'hffffffff;
    end else begin
      dataReg <= 32'h0; // @[WishboneErr.scala 37:13]
    end
    if (reset) begin // @[WishboneErr.scala 16:23]
      errReg <= 1'h0; // @[WishboneErr.scala 16:23]
    end else begin
      errReg <= _T_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  dataReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  errReg = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ID_EX(
  input         clock,
  input         reset,
  input  [31:0] io_pc_in,
  input  [31:0] io_pc4_in,
  input  [4:0]  io_rs1_sel_in,
  input  [4:0]  io_rs2_sel_in,
  input  [31:0] io_rs1_in,
  input  [31:0] io_rs2_in,
  input  [31:0] io_imm,
  input  [4:0]  io_rd_sel_in,
  input  [2:0]  io_func3_in,
  input  [6:0]  io_func7_in,
  input         io_ctrl_MemWr_in,
  input         io_ctrl_MemRd_in,
  input         io_ctrl_CsrWen_in,
  input         io_ctrl_RegWr_in,
  input         io_ctrl_MemToReg_in,
  input  [3:0]  io_ctrl_AluOp_in,
  input  [1:0]  io_ctrl_OpA_sel_in,
  input         io_ctrl_OpB_sel_in,
  input  [6:0]  io_inst_op_in,
  input  [31:0] io_csr_data_i,
  input         io_stall,
  output [31:0] io_pc_out,
  output [31:0] io_pc4_out,
  output [31:0] io_rs1_out,
  output [31:0] io_rs2_out,
  output [31:0] io_imm_out,
  output [2:0]  io_func3_out,
  output [6:0]  io_func7_out,
  output [6:0]  io_inst_op_out,
  output [4:0]  io_rd_sel_out,
  output [4:0]  io_rs1_sel_out,
  output [4:0]  io_rs2_sel_out,
  output        io_ctrl_MemWr_out,
  output        io_ctrl_MemRd_out,
  output        io_ctrl_RegWr_out,
  output        io_ctrl_CsrWen_out,
  output        io_ctrl_MemToReg_out,
  output [3:0]  io_ctrl_AluOp_out,
  output [1:0]  io_ctrl_OpA_sel_out,
  output        io_ctrl_OpB_sel_out,
  output [31:0] io_csr_data_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pc_reg; // @[ID_EX.scala 59:25]
  reg [31:0] pc4_reg; // @[ID_EX.scala 60:26]
  reg [31:0] rs1_reg; // @[ID_EX.scala 61:26]
  reg [31:0] rs2_reg; // @[ID_EX.scala 62:26]
  reg [31:0] imm_reg; // @[ID_EX.scala 63:26]
  reg [4:0] rd_sel_reg; // @[ID_EX.scala 64:29]
  reg [4:0] rs1_sel_reg; // @[ID_EX.scala 65:30]
  reg [4:0] rs2_sel_reg; // @[ID_EX.scala 66:30]
  reg [2:0] func3_reg; // @[ID_EX.scala 67:28]
  reg [6:0] func7_reg; // @[ID_EX.scala 68:28]
  reg [6:0] inst_op_reg; // @[ID_EX.scala 69:30]
  reg [31:0] csr_data_reg; // @[ID_EX.scala 71:31]
  reg  ctrl_MemWr_reg; // @[ID_EX.scala 73:33]
  reg  ctrl_MemRd_reg; // @[ID_EX.scala 74:33]
  reg  ctrl_RegWr_reg; // @[ID_EX.scala 76:33]
  reg  ctrl_CsrWen_reg; // @[ID_EX.scala 77:34]
  reg  ctrl_MemToReg_reg; // @[ID_EX.scala 78:36]
  reg [3:0] ctrl_AluOp_reg; // @[ID_EX.scala 79:33]
  reg [1:0] ctrl_OpA_sel_reg; // @[ID_EX.scala 80:35]
  reg  ctrl_OpB_sel_reg; // @[ID_EX.scala 81:35]
  assign io_pc_out = pc_reg; // @[ID_EX.scala 85:28 ID_EX.scala 113:19 ID_EX.scala 140:19]
  assign io_pc4_out = pc4_reg; // @[ID_EX.scala 85:28 ID_EX.scala 114:20 ID_EX.scala 141:20]
  assign io_rs1_out = rs1_reg; // @[ID_EX.scala 85:28 ID_EX.scala 115:20 ID_EX.scala 142:20]
  assign io_rs2_out = rs2_reg; // @[ID_EX.scala 85:28 ID_EX.scala 116:20 ID_EX.scala 143:20]
  assign io_imm_out = imm_reg; // @[ID_EX.scala 85:28 ID_EX.scala 118:20 ID_EX.scala 145:20]
  assign io_func3_out = func3_reg; // @[ID_EX.scala 85:28 ID_EX.scala 122:22 ID_EX.scala 149:22]
  assign io_func7_out = func7_reg; // @[ID_EX.scala 85:28 ID_EX.scala 123:22 ID_EX.scala 150:22]
  assign io_inst_op_out = inst_op_reg; // @[ID_EX.scala 85:28 ID_EX.scala 124:24 ID_EX.scala 151:24]
  assign io_rd_sel_out = rd_sel_reg; // @[ID_EX.scala 85:28 ID_EX.scala 119:23 ID_EX.scala 146:23]
  assign io_rs1_sel_out = rs1_sel_reg; // @[ID_EX.scala 85:28 ID_EX.scala 120:24 ID_EX.scala 147:24]
  assign io_rs2_sel_out = rs2_sel_reg; // @[ID_EX.scala 85:28 ID_EX.scala 121:24 ID_EX.scala 148:24]
  assign io_ctrl_MemWr_out = ctrl_MemWr_reg; // @[ID_EX.scala 85:28 ID_EX.scala 126:27 ID_EX.scala 154:27]
  assign io_ctrl_MemRd_out = ctrl_MemRd_reg; // @[ID_EX.scala 85:28 ID_EX.scala 127:27 ID_EX.scala 155:27]
  assign io_ctrl_RegWr_out = ctrl_RegWr_reg; // @[ID_EX.scala 85:28 ID_EX.scala 129:27 ID_EX.scala 157:27]
  assign io_ctrl_CsrWen_out = ctrl_CsrWen_reg; // @[ID_EX.scala 85:28 ID_EX.scala 130:28 ID_EX.scala 158:28]
  assign io_ctrl_MemToReg_out = ctrl_MemToReg_reg; // @[ID_EX.scala 85:28 ID_EX.scala 131:30 ID_EX.scala 159:30]
  assign io_ctrl_AluOp_out = ctrl_AluOp_reg; // @[ID_EX.scala 85:28 ID_EX.scala 132:27 ID_EX.scala 160:27]
  assign io_ctrl_OpA_sel_out = ctrl_OpA_sel_reg; // @[ID_EX.scala 85:28 ID_EX.scala 133:29 ID_EX.scala 161:29]
  assign io_ctrl_OpB_sel_out = ctrl_OpB_sel_reg; // @[ID_EX.scala 85:28 ID_EX.scala 134:29 ID_EX.scala 162:29]
  assign io_csr_data_o = csr_data_reg; // @[ID_EX.scala 85:28 ID_EX.scala 117:23 ID_EX.scala 144:23]
  always @(posedge clock) begin
    if (reset) begin // @[ID_EX.scala 59:25]
      pc_reg <= 32'sh0; // @[ID_EX.scala 59:25]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      pc_reg <= io_pc_in; // @[ID_EX.scala 86:16]
    end
    if (reset) begin // @[ID_EX.scala 60:26]
      pc4_reg <= 32'sh0; // @[ID_EX.scala 60:26]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      pc4_reg <= io_pc4_in; // @[ID_EX.scala 87:17]
    end
    if (reset) begin // @[ID_EX.scala 61:26]
      rs1_reg <= 32'sh0; // @[ID_EX.scala 61:26]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      rs1_reg <= io_rs1_in; // @[ID_EX.scala 88:17]
    end
    if (reset) begin // @[ID_EX.scala 62:26]
      rs2_reg <= 32'sh0; // @[ID_EX.scala 62:26]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      rs2_reg <= io_rs2_in; // @[ID_EX.scala 89:17]
    end
    if (reset) begin // @[ID_EX.scala 63:26]
      imm_reg <= 32'sh0; // @[ID_EX.scala 63:26]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      imm_reg <= io_imm; // @[ID_EX.scala 90:17]
    end
    if (reset) begin // @[ID_EX.scala 64:29]
      rd_sel_reg <= 5'h0; // @[ID_EX.scala 64:29]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      rd_sel_reg <= io_rd_sel_in; // @[ID_EX.scala 92:20]
    end
    if (reset) begin // @[ID_EX.scala 65:30]
      rs1_sel_reg <= 5'h0; // @[ID_EX.scala 65:30]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      rs1_sel_reg <= io_rs1_sel_in; // @[ID_EX.scala 93:21]
    end
    if (reset) begin // @[ID_EX.scala 66:30]
      rs2_sel_reg <= 5'h0; // @[ID_EX.scala 66:30]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      rs2_sel_reg <= io_rs2_sel_in; // @[ID_EX.scala 94:21]
    end
    if (reset) begin // @[ID_EX.scala 67:28]
      func3_reg <= 3'h0; // @[ID_EX.scala 67:28]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      func3_reg <= io_func3_in; // @[ID_EX.scala 95:19]
    end
    if (reset) begin // @[ID_EX.scala 68:28]
      func7_reg <= 7'h0; // @[ID_EX.scala 68:28]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      func7_reg <= io_func7_in; // @[ID_EX.scala 96:19]
    end
    if (reset) begin // @[ID_EX.scala 69:30]
      inst_op_reg <= 7'h0; // @[ID_EX.scala 69:30]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      inst_op_reg <= io_inst_op_in; // @[ID_EX.scala 97:21]
    end
    if (reset) begin // @[ID_EX.scala 71:31]
      csr_data_reg <= 32'h0; // @[ID_EX.scala 71:31]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      csr_data_reg <= io_csr_data_i; // @[ID_EX.scala 91:22]
    end
    if (reset) begin // @[ID_EX.scala 73:33]
      ctrl_MemWr_reg <= 1'h0; // @[ID_EX.scala 73:33]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      ctrl_MemWr_reg <= io_ctrl_MemWr_in; // @[ID_EX.scala 99:24]
    end
    if (reset) begin // @[ID_EX.scala 74:33]
      ctrl_MemRd_reg <= 1'h0; // @[ID_EX.scala 74:33]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      ctrl_MemRd_reg <= io_ctrl_MemRd_in; // @[ID_EX.scala 100:24]
    end
    if (reset) begin // @[ID_EX.scala 76:33]
      ctrl_RegWr_reg <= 1'h0; // @[ID_EX.scala 76:33]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      ctrl_RegWr_reg <= io_ctrl_RegWr_in; // @[ID_EX.scala 102:24]
    end
    if (reset) begin // @[ID_EX.scala 77:34]
      ctrl_CsrWen_reg <= 1'h0; // @[ID_EX.scala 77:34]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      ctrl_CsrWen_reg <= io_ctrl_CsrWen_in; // @[ID_EX.scala 103:25]
    end
    if (reset) begin // @[ID_EX.scala 78:36]
      ctrl_MemToReg_reg <= 1'h0; // @[ID_EX.scala 78:36]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      ctrl_MemToReg_reg <= io_ctrl_MemToReg_in; // @[ID_EX.scala 104:27]
    end
    if (reset) begin // @[ID_EX.scala 79:33]
      ctrl_AluOp_reg <= 4'h0; // @[ID_EX.scala 79:33]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      ctrl_AluOp_reg <= io_ctrl_AluOp_in; // @[ID_EX.scala 105:24]
    end
    if (reset) begin // @[ID_EX.scala 80:35]
      ctrl_OpA_sel_reg <= 2'h0; // @[ID_EX.scala 80:35]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      ctrl_OpA_sel_reg <= io_ctrl_OpA_sel_in; // @[ID_EX.scala 106:26]
    end
    if (reset) begin // @[ID_EX.scala 81:35]
      ctrl_OpB_sel_reg <= 1'h0; // @[ID_EX.scala 81:35]
    end else if (~io_stall) begin // @[ID_EX.scala 85:28]
      ctrl_OpB_sel_reg <= io_ctrl_OpB_sel_in; // @[ID_EX.scala 107:26]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pc_reg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  pc4_reg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  rs1_reg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  rs2_reg = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  imm_reg = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  rd_sel_reg = _RAND_5[4:0];
  _RAND_6 = {1{`RANDOM}};
  rs1_sel_reg = _RAND_6[4:0];
  _RAND_7 = {1{`RANDOM}};
  rs2_sel_reg = _RAND_7[4:0];
  _RAND_8 = {1{`RANDOM}};
  func3_reg = _RAND_8[2:0];
  _RAND_9 = {1{`RANDOM}};
  func7_reg = _RAND_9[6:0];
  _RAND_10 = {1{`RANDOM}};
  inst_op_reg = _RAND_10[6:0];
  _RAND_11 = {1{`RANDOM}};
  csr_data_reg = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  ctrl_MemWr_reg = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  ctrl_MemRd_reg = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  ctrl_RegWr_reg = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  ctrl_CsrWen_reg = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  ctrl_MemToReg_reg = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  ctrl_AluOp_reg = _RAND_17[3:0];
  _RAND_18 = {1{`RANDOM}};
  ctrl_OpA_sel_reg = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  ctrl_OpB_sel_reg = _RAND_19[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module EX_MEM(
  input         clock,
  input         reset,
  input         io_ctrl_MemWr_in,
  input         io_ctrl_MemRd_in,
  input         io_ctrl_RegWr_in,
  input         io_ctrl_CsrWen_in,
  input         io_ctrl_MemToReg_in,
  input  [31:0] io_rs2_in,
  input  [4:0]  io_rd_sel_in,
  input  [31:0] io_alu_in,
  input  [2:0]  io_EX_MEM_func3,
  input  [31:0] io_csr_data_i,
  input         io_stall,
  output        io_ctrl_MemWr_out,
  output        io_ctrl_MemRd_out,
  output        io_ctrl_RegWr_out,
  output        io_ctrl_CsrWen_out,
  output        io_ctrl_MemToReg_out,
  output [31:0] io_rs2_out,
  output [4:0]  io_rd_sel_out,
  output [31:0] io_alu_output,
  output [2:0]  io_EX_MEM_func3_out,
  output [31:0] io_csr_data_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  reg  reg_memWr; // @[EX_MEM.scala 37:32]
  reg  reg_memRd; // @[EX_MEM.scala 38:32]
  reg  reg_regWr; // @[EX_MEM.scala 39:32]
  reg  reg_csrWen; // @[EX_MEM.scala 40:33]
  reg  reg_memToReg; // @[EX_MEM.scala 41:35]
  reg [31:0] reg_rs2; // @[EX_MEM.scala 42:30]
  reg [4:0] reg_rd_sel; // @[EX_MEM.scala 43:33]
  reg [31:0] reg_alu_output; // @[EX_MEM.scala 45:37]
  reg [2:0] reg_func3; // @[EX_MEM.scala 46:37]
  reg [31:0] reg_csr_data; // @[EX_MEM.scala 49:35]
  assign io_ctrl_MemWr_out = reg_memWr; // @[EX_MEM.scala 82:23]
  assign io_ctrl_MemRd_out = reg_memRd; // @[EX_MEM.scala 83:23]
  assign io_ctrl_RegWr_out = reg_regWr; // @[EX_MEM.scala 84:23]
  assign io_ctrl_CsrWen_out = reg_csrWen; // @[EX_MEM.scala 85:24]
  assign io_ctrl_MemToReg_out = reg_memToReg; // @[EX_MEM.scala 86:26]
  assign io_rs2_out = reg_rs2; // @[EX_MEM.scala 87:16]
  assign io_rd_sel_out = reg_rd_sel; // @[EX_MEM.scala 88:19]
  assign io_alu_output = reg_alu_output; // @[EX_MEM.scala 90:19]
  assign io_EX_MEM_func3_out = reg_func3; // @[EX_MEM.scala 91:25]
  assign io_csr_data_o = reg_csr_data; // @[EX_MEM.scala 94:19]
  always @(posedge clock) begin
    if (reset) begin // @[EX_MEM.scala 37:32]
      reg_memWr <= 1'h0; // @[EX_MEM.scala 37:32]
    end else if (~io_stall) begin // @[EX_MEM.scala 51:28]
      reg_memWr <= io_ctrl_MemWr_in; // @[EX_MEM.scala 52:19]
    end
    if (reset) begin // @[EX_MEM.scala 38:32]
      reg_memRd <= 1'h0; // @[EX_MEM.scala 38:32]
    end else if (~io_stall) begin // @[EX_MEM.scala 51:28]
      reg_memRd <= io_ctrl_MemRd_in; // @[EX_MEM.scala 53:19]
    end
    if (reset) begin // @[EX_MEM.scala 39:32]
      reg_regWr <= 1'h0; // @[EX_MEM.scala 39:32]
    end else if (~io_stall) begin // @[EX_MEM.scala 51:28]
      reg_regWr <= io_ctrl_RegWr_in; // @[EX_MEM.scala 54:19]
    end
    if (reset) begin // @[EX_MEM.scala 40:33]
      reg_csrWen <= 1'h0; // @[EX_MEM.scala 40:33]
    end else if (~io_stall) begin // @[EX_MEM.scala 51:28]
      reg_csrWen <= io_ctrl_CsrWen_in; // @[EX_MEM.scala 55:20]
    end
    if (reset) begin // @[EX_MEM.scala 41:35]
      reg_memToReg <= 1'h0; // @[EX_MEM.scala 41:35]
    end else if (~io_stall) begin // @[EX_MEM.scala 51:28]
      reg_memToReg <= io_ctrl_MemToReg_in; // @[EX_MEM.scala 56:22]
    end
    if (reset) begin // @[EX_MEM.scala 42:30]
      reg_rs2 <= 32'sh0; // @[EX_MEM.scala 42:30]
    end else if (~io_stall) begin // @[EX_MEM.scala 51:28]
      reg_rs2 <= io_rs2_in; // @[EX_MEM.scala 57:17]
    end
    if (reset) begin // @[EX_MEM.scala 43:33]
      reg_rd_sel <= 5'h0; // @[EX_MEM.scala 43:33]
    end else if (~io_stall) begin // @[EX_MEM.scala 51:28]
      reg_rd_sel <= io_rd_sel_in; // @[EX_MEM.scala 58:20]
    end
    if (reset) begin // @[EX_MEM.scala 45:37]
      reg_alu_output <= 32'sh0; // @[EX_MEM.scala 45:37]
    end else if (~io_stall) begin // @[EX_MEM.scala 51:28]
      reg_alu_output <= io_alu_in; // @[EX_MEM.scala 60:24]
    end
    if (reset) begin // @[EX_MEM.scala 46:37]
      reg_func3 <= 3'h0; // @[EX_MEM.scala 46:37]
    end else if (~io_stall) begin // @[EX_MEM.scala 51:28]
      reg_func3 <= io_EX_MEM_func3; // @[EX_MEM.scala 61:24]
    end
    if (reset) begin // @[EX_MEM.scala 49:35]
      reg_csr_data <= 32'h0; // @[EX_MEM.scala 49:35]
    end else if (~io_stall) begin // @[EX_MEM.scala 51:28]
      reg_csr_data <= io_csr_data_i; // @[EX_MEM.scala 64:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_memWr = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  reg_memRd = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  reg_regWr = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  reg_csrWen = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  reg_memToReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  reg_rs2 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  reg_rd_sel = _RAND_6[4:0];
  _RAND_7 = {1{`RANDOM}};
  reg_alu_output = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  reg_func3 = _RAND_8[2:0];
  _RAND_9 = {1{`RANDOM}};
  reg_csr_data = _RAND_9[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MEM_WB(
  input         clock,
  input         reset,
  input         io_ctrl_RegWr_in,
  input         io_ctrl_CsrWen_in,
  input         io_ctrl_MemToReg_in,
  input  [4:0]  io_rd_sel_in,
  input         io_ctrl_MemRd_in,
  input  [31:0] io_dmem_data_in,
  input  [31:0] io_alu_in,
  input  [31:0] io_csr_data_in,
  input         io_stall,
  output        io_ctrl_RegWr_out,
  output        io_ctrl_CsrWen_out,
  output        io_ctrl_MemToReg_out,
  output        io_ctrl_MemRd_out,
  output [4:0]  io_rd_sel_out,
  output [31:0] io_dmem_data_out,
  output [31:0] io_alu_output,
  output [31:0] io_csr_data_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg  reg_regWr; // @[MEM_WB.scala 32:28]
  reg  reg_csrWen; // @[MEM_WB.scala 34:29]
  reg  reg_memToReg; // @[MEM_WB.scala 36:31]
  reg  reg_memRd; // @[MEM_WB.scala 38:28]
  reg [4:0] reg_rdSel; // @[MEM_WB.scala 40:28]
  reg [31:0] reg_dataMem_data; // @[MEM_WB.scala 42:35]
  reg [31:0] reg_alu_output; // @[MEM_WB.scala 44:33]
  reg [31:0] reg_csr_data; // @[MEM_WB.scala 50:31]
  assign io_ctrl_RegWr_out = reg_regWr; // @[MEM_WB.scala 52:28 MEM_WB.scala 65:27 MEM_WB.scala 76:27]
  assign io_ctrl_CsrWen_out = reg_csrWen; // @[MEM_WB.scala 52:28 MEM_WB.scala 66:28 MEM_WB.scala 77:28]
  assign io_ctrl_MemToReg_out = reg_memToReg; // @[MEM_WB.scala 52:28 MEM_WB.scala 64:30 MEM_WB.scala 75:30]
  assign io_ctrl_MemRd_out = reg_memRd; // @[MEM_WB.scala 52:28 MEM_WB.scala 67:27 MEM_WB.scala 78:27]
  assign io_rd_sel_out = reg_rdSel; // @[MEM_WB.scala 52:28 MEM_WB.scala 68:23 MEM_WB.scala 79:23]
  assign io_dmem_data_out = reg_dataMem_data; // @[MEM_WB.scala 52:28 MEM_WB.scala 69:26 MEM_WB.scala 80:26]
  assign io_alu_output = reg_alu_output; // @[MEM_WB.scala 52:28 MEM_WB.scala 70:23 MEM_WB.scala 81:23]
  assign io_csr_data_out = reg_csr_data; // @[MEM_WB.scala 52:28 MEM_WB.scala 73:25 MEM_WB.scala 84:25]
  always @(posedge clock) begin
    if (reset) begin // @[MEM_WB.scala 32:28]
      reg_regWr <= 1'h0; // @[MEM_WB.scala 32:28]
    end else if (~io_stall) begin // @[MEM_WB.scala 52:28]
      reg_regWr <= io_ctrl_RegWr_in; // @[MEM_WB.scala 53:19]
    end
    if (reset) begin // @[MEM_WB.scala 34:29]
      reg_csrWen <= 1'h0; // @[MEM_WB.scala 34:29]
    end else if (~io_stall) begin // @[MEM_WB.scala 52:28]
      reg_csrWen <= io_ctrl_CsrWen_in; // @[MEM_WB.scala 54:20]
    end
    if (reset) begin // @[MEM_WB.scala 36:31]
      reg_memToReg <= 1'h0; // @[MEM_WB.scala 36:31]
    end else if (~io_stall) begin // @[MEM_WB.scala 52:28]
      reg_memToReg <= io_ctrl_MemToReg_in; // @[MEM_WB.scala 55:22]
    end
    if (reset) begin // @[MEM_WB.scala 38:28]
      reg_memRd <= 1'h0; // @[MEM_WB.scala 38:28]
    end else if (~io_stall) begin // @[MEM_WB.scala 52:28]
      reg_memRd <= io_ctrl_MemRd_in; // @[MEM_WB.scala 56:19]
    end
    if (reset) begin // @[MEM_WB.scala 40:28]
      reg_rdSel <= 5'h0; // @[MEM_WB.scala 40:28]
    end else if (~io_stall) begin // @[MEM_WB.scala 52:28]
      reg_rdSel <= io_rd_sel_in; // @[MEM_WB.scala 57:19]
    end
    if (reset) begin // @[MEM_WB.scala 42:35]
      reg_dataMem_data <= 32'sh0; // @[MEM_WB.scala 42:35]
    end else if (~io_stall) begin // @[MEM_WB.scala 52:28]
      reg_dataMem_data <= io_dmem_data_in; // @[MEM_WB.scala 58:26]
    end
    if (reset) begin // @[MEM_WB.scala 44:33]
      reg_alu_output <= 32'sh0; // @[MEM_WB.scala 44:33]
    end else if (~io_stall) begin // @[MEM_WB.scala 52:28]
      reg_alu_output <= io_alu_in; // @[MEM_WB.scala 59:24]
    end
    if (reset) begin // @[MEM_WB.scala 50:31]
      reg_csr_data <= 32'h0; // @[MEM_WB.scala 50:31]
    end else if (~io_stall) begin // @[MEM_WB.scala 52:28]
      reg_csr_data <= io_csr_data_in; // @[MEM_WB.scala 62:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_regWr = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  reg_csrWen = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  reg_memToReg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  reg_memRd = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  reg_rdSel = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  reg_dataMem_data = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  reg_alu_output = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  reg_csr_data = _RAND_7[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Pc(
  input         clock,
  input         reset,
  input  [31:0] io_in,
  output [31:0] io_out,
  output [31:0] io_pc4,
  input         io_halt
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_; // @[Pc.scala 13:22]
  wire [31:0] _T_2 = $signed(reg_) + 32'sh4; // @[Pc.scala 15:37]
  assign io_out = reg_; // @[Pc.scala 16:12]
  assign io_pc4 = io_halt ? $signed(reg_) : $signed(_T_2); // @[Pc.scala 15:18]
  always @(posedge clock) begin
    if (reset) begin // @[Pc.scala 13:22]
      reg_ <= -32'sh4; // @[Pc.scala 13:22]
    end else begin
      reg_ <= io_in; // @[Pc.scala 14:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Fetch(
  input         clock,
  input         reset,
  input         io_coreInstrReq_ready,
  output        io_coreInstrReq_valid,
  output [31:0] io_coreInstrReq_bits_addrRequest,
  input         io_coreInstrRsp_valid,
  input  [31:0] io_coreInstrRsp_bits_dataResponse,
  input         io_csrRegFile_irq_pending_i,
  input         io_csrRegFile_csr_mstatus_mie_i,
  input  [31:0] io_csrRegFile_csr_mtvec_i,
  output        io_csrRegFile_csr_save_cause_o,
  output        io_csrRegFile_csr_save_if_o,
  output [31:0] io_csrRegFile_csr_if_pc_o,
  output [5:0]  io_csrRegFile_exc_cause_o,
  input  [31:0] io_csrRegFile_csr_mepc_i,
  input  [31:0] io_decode_sb_imm_i,
  input  [31:0] io_decode_uj_imm_i,
  input  [31:0] io_decode_jalr_imm_i,
  input  [1:0]  io_decode_ctrl_next_pc_sel_i,
  input         io_decode_ctrl_out_branch_i,
  input         io_decode_branchLogic_output_i,
  input  [31:0] io_decode_hazardDetection_pc_i,
  input  [31:0] io_decode_hazardDetection_inst_i,
  input  [31:0] io_decode_hazardDetection_current_pc_i,
  input         io_decode_hazardDetection_pc_forward_i,
  input         io_decode_hazardDetection_inst_forward_i,
  input         io_decode_mret_inst_i,
  input         io_core_stall_i,
  output [31:0] io_decode_if_id_pc_o,
  output [31:0] io_decode_if_id_pc4_o,
  output [31:0] io_decode_if_id_inst_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  pc_clock; // @[Fetch.scala 70:18]
  wire  pc_reset; // @[Fetch.scala 70:18]
  wire [31:0] pc_io_in; // @[Fetch.scala 70:18]
  wire [31:0] pc_io_out; // @[Fetch.scala 70:18]
  wire [31:0] pc_io_pc4; // @[Fetch.scala 70:18]
  wire  pc_io_halt; // @[Fetch.scala 70:18]
  reg [31:0] if_id_pc_reg; // @[Fetch.scala 78:25]
  reg [31:0] if_id_pc4_reg; // @[Fetch.scala 79:26]
  reg [31:0] if_id_inst_reg; // @[Fetch.scala 80:31]
  wire  handle_irq = io_csrRegFile_irq_pending_i & io_csrRegFile_csr_mstatus_mie_i; // @[Fetch.scala 83:48]
  wire [31:0] instr = io_coreInstrRsp_valid ? io_coreInstrRsp_bits_dataResponse : 32'h13; // @[Fetch.scala 105:18]
  wire  _T_13 = ~io_core_stall_i; // @[Fetch.scala 107:8]
  wire  _T_15 = ~io_core_stall_i & ~handle_irq; // @[Fetch.scala 107:25]
  wire [31:0] _T_18 = $signed(pc_io_out) + 32'sh4; // @[Fetch.scala 111:32]
  wire [31:0] _GEN_0 = ~io_core_stall_i & ~handle_irq ? $signed(pc_io_out) : $signed(if_id_pc_reg); // @[Fetch.scala 107:38 Fetch.scala 109:18 Fetch.scala 78:25]
  wire [31:0] _GEN_1 = ~io_core_stall_i & ~handle_irq ? $signed(_T_18) : $signed(if_id_pc4_reg); // @[Fetch.scala 107:38 Fetch.scala 111:19 Fetch.scala 79:26]
  wire [31:0] _GEN_2 = io_decode_hazardDetection_inst_forward_i ? io_decode_hazardDetection_inst_i : instr; // @[Fetch.scala 115:60 Fetch.scala 116:22 Fetch.scala 125:22]
  wire [31:0] _GEN_3 = io_decode_hazardDetection_inst_forward_i ? $signed(io_decode_hazardDetection_current_pc_i) :
    $signed(_GEN_0); // @[Fetch.scala 115:60 Fetch.scala 117:20]
  wire [31:0] _GEN_4 = _T_15 ? _GEN_2 : if_id_inst_reg; // @[Fetch.scala 114:38 Fetch.scala 80:31]
  wire [31:0] _GEN_5 = _T_15 ? $signed(_GEN_3) : $signed(_GEN_0); // @[Fetch.scala 114:38]
  wire  _T_27 = io_decode_ctrl_next_pc_sel_i == 2'h1; // @[Fetch.scala 143:41]
  wire [31:0] _GEN_6 = io_decode_branchLogic_output_i & io_decode_ctrl_out_branch_i ? $signed(io_decode_sb_imm_i) :
    $signed(pc_io_pc4); // @[Fetch.scala 144:93 Fetch.scala 145:20 Fetch.scala 150:20]
  wire [31:0] _GEN_9 = io_decode_branchLogic_output_i & io_decode_ctrl_out_branch_i ? 32'h13 : _GEN_4; // @[Fetch.scala 144:93 Fetch.scala 148:26]
  wire  _T_31 = io_decode_ctrl_next_pc_sel_i == 2'h2; // @[Fetch.scala 152:47]
  wire  _T_32 = io_decode_ctrl_next_pc_sel_i == 2'h3; // @[Fetch.scala 157:47]
  wire [31:0] _GEN_10 = io_decode_mret_inst_i ? $signed(io_csrRegFile_csr_mepc_i) : $signed(pc_io_pc4); // @[Fetch.scala 162:41 Fetch.scala 163:18 Fetch.scala 168:18]
  wire [31:0] _GEN_11 = io_decode_mret_inst_i ? $signed(32'sh0) : $signed(_GEN_5); // @[Fetch.scala 162:41 Fetch.scala 164:22]
  wire [31:0] _GEN_12 = io_decode_mret_inst_i ? $signed(32'sh0) : $signed(_GEN_1); // @[Fetch.scala 162:41 Fetch.scala 165:23]
  wire [31:0] _GEN_13 = io_decode_mret_inst_i ? 32'h13 : _GEN_4; // @[Fetch.scala 162:41 Fetch.scala 166:24]
  wire [31:0] _GEN_14 = io_decode_ctrl_next_pc_sel_i == 2'h3 ? $signed(io_decode_jalr_imm_i) : $signed(_GEN_10); // @[Fetch.scala 157:60 Fetch.scala 158:18]
  wire [31:0] _GEN_15 = io_decode_ctrl_next_pc_sel_i == 2'h3 ? $signed(32'sh0) : $signed(_GEN_11); // @[Fetch.scala 157:60 Fetch.scala 159:22]
  wire [31:0] _GEN_16 = io_decode_ctrl_next_pc_sel_i == 2'h3 ? $signed(32'sh0) : $signed(_GEN_12); // @[Fetch.scala 157:60 Fetch.scala 160:23]
  wire [31:0] _GEN_17 = io_decode_ctrl_next_pc_sel_i == 2'h3 ? 32'h13 : _GEN_13; // @[Fetch.scala 157:60 Fetch.scala 161:24]
  wire [31:0] _GEN_18 = io_decode_ctrl_next_pc_sel_i == 2'h2 ? $signed(io_decode_uj_imm_i) : $signed(_GEN_14); // @[Fetch.scala 152:60 Fetch.scala 153:18]
  wire [31:0] _GEN_21 = io_decode_ctrl_next_pc_sel_i == 2'h2 ? 32'h13 : _GEN_17; // @[Fetch.scala 152:60 Fetch.scala 156:24]
  wire [31:0] _GEN_22 = io_decode_ctrl_next_pc_sel_i == 2'h1 ? $signed(_GEN_6) : $signed(_GEN_18); // @[Fetch.scala 143:54]
  wire [31:0] _GEN_26 = io_decode_hazardDetection_pc_forward_i ? $signed(io_decode_hazardDetection_pc_i) : $signed(
    _GEN_22); // @[Fetch.scala 140:58 Fetch.scala 141:16]
  wire  _T_35 = _T_13 & handle_irq; // @[Fetch.scala 171:31]
  wire [23:0] hi_hi = io_csrRegFile_csr_mtvec_i[31:8]; // @[Fetch.scala 172:46]
  wire [31:0] _T_37 = {hi_hi,1'h0,7'h2c}; // @[Fetch.scala 172:123]
  wire [31:0] _T_45 = _T_32 ? io_decode_jalr_imm_i : pc_io_out; // @[Fetch.scala 180:12]
  wire [31:0] _T_46 = _T_31 ? io_decode_uj_imm_i : _T_45; // @[Fetch.scala 179:10]
  wire [31:0] _T_47 = _T_27 ? io_decode_sb_imm_i : _T_46; // @[Fetch.scala 178:37]
  wire [31:0] _GEN_30 = _T_13 & handle_irq ? $signed(_T_37) : $signed(pc_io_out); // @[Fetch.scala 171:43 Fetch.scala 172:14 Fetch.scala 185:16]
  wire [31:0] _GEN_33 = _T_13 & handle_irq ? _T_47 : 32'h0; // @[Fetch.scala 171:43 Fetch.scala 178:31 Fetch.scala 74:29]
  wire [5:0] _GEN_34 = _T_13 & handle_irq ? 6'h2b : 6'h0; // @[Fetch.scala 171:43 Fetch.scala 182:31 Fetch.scala 95:29]
  Pc pc ( // @[Fetch.scala 70:18]
    .clock(pc_clock),
    .reset(pc_reset),
    .io_in(pc_io_in),
    .io_out(pc_io_out),
    .io_pc4(pc_io_pc4),
    .io_halt(pc_io_halt)
  );
  assign io_coreInstrReq_valid = io_coreInstrReq_ready; // @[Fetch.scala 100:31]
  assign io_coreInstrReq_bits_addrRequest = {{18'd0}, pc_io_in[13:0]}; // @[Fetch.scala 97:47]
  assign io_csrRegFile_csr_save_cause_o = _T_15 ? 1'h0 : _T_35; // @[Fetch.scala 139:38 Fetch.scala 93:31]
  assign io_csrRegFile_csr_save_if_o = _T_15 ? 1'h0 : _T_35; // @[Fetch.scala 139:38 Fetch.scala 93:31]
  assign io_csrRegFile_csr_if_pc_o = _T_15 ? 32'h0 : _GEN_33; // @[Fetch.scala 139:38 Fetch.scala 74:29]
  assign io_csrRegFile_exc_cause_o = _T_15 ? 6'h0 : _GEN_34; // @[Fetch.scala 139:38 Fetch.scala 95:29]
  assign io_decode_if_id_pc_o = if_id_pc_reg; // @[Fetch.scala 189:24]
  assign io_decode_if_id_pc4_o = if_id_pc4_reg; // @[Fetch.scala 190:25]
  assign io_decode_if_id_inst_o = if_id_inst_reg; // @[Fetch.scala 191:26]
  assign pc_clock = clock;
  assign pc_reset = reset;
  assign pc_io_in = _T_15 ? $signed(_GEN_26) : $signed(_GEN_30); // @[Fetch.scala 139:38]
  assign pc_io_halt = io_coreInstrReq_ready ? 1'h0 : 1'h1; // @[Fetch.scala 102:20]
  always @(posedge clock) begin
    if (_T_15) begin // @[Fetch.scala 139:38]
      if (io_decode_hazardDetection_pc_forward_i) begin // @[Fetch.scala 140:58]
        if_id_pc_reg <= _GEN_5;
      end else if (io_decode_ctrl_next_pc_sel_i == 2'h1) begin // @[Fetch.scala 143:54]
        if (io_decode_branchLogic_output_i & io_decode_ctrl_out_branch_i) begin // @[Fetch.scala 144:93]
          if_id_pc_reg <= 32'sh0; // @[Fetch.scala 146:24]
        end else begin
          if_id_pc_reg <= _GEN_5;
        end
      end else if (io_decode_ctrl_next_pc_sel_i == 2'h2) begin // @[Fetch.scala 152:60]
        if_id_pc_reg <= 32'sh0; // @[Fetch.scala 154:22]
      end else begin
        if_id_pc_reg <= _GEN_15;
      end
    end else begin
      if_id_pc_reg <= _GEN_5;
    end
    if (_T_15) begin // @[Fetch.scala 139:38]
      if (io_decode_hazardDetection_pc_forward_i) begin // @[Fetch.scala 140:58]
        if_id_pc4_reg <= _GEN_1;
      end else if (io_decode_ctrl_next_pc_sel_i == 2'h1) begin // @[Fetch.scala 143:54]
        if (io_decode_branchLogic_output_i & io_decode_ctrl_out_branch_i) begin // @[Fetch.scala 144:93]
          if_id_pc4_reg <= 32'sh0; // @[Fetch.scala 147:25]
        end else begin
          if_id_pc4_reg <= _GEN_1;
        end
      end else if (io_decode_ctrl_next_pc_sel_i == 2'h2) begin // @[Fetch.scala 152:60]
        if_id_pc4_reg <= 32'sh0; // @[Fetch.scala 155:23]
      end else begin
        if_id_pc4_reg <= _GEN_16;
      end
    end else begin
      if_id_pc4_reg <= _GEN_1;
    end
    if (reset) begin // @[Fetch.scala 80:31]
      if_id_inst_reg <= 32'h13; // @[Fetch.scala 80:31]
    end else if (_T_15) begin // @[Fetch.scala 139:38]
      if (io_decode_hazardDetection_pc_forward_i) begin // @[Fetch.scala 140:58]
        if_id_inst_reg <= _GEN_4;
      end else if (io_decode_ctrl_next_pc_sel_i == 2'h1) begin // @[Fetch.scala 143:54]
        if_id_inst_reg <= _GEN_9;
      end else begin
        if_id_inst_reg <= _GEN_21;
      end
    end else if (_T_13 & handle_irq) begin // @[Fetch.scala 171:43]
      if_id_inst_reg <= 32'h13; // @[Fetch.scala 173:20]
    end else begin
      if_id_inst_reg <= _GEN_4;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  if_id_pc_reg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  if_id_pc4_reg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  if_id_inst_reg = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module HazardDetection(
  input  [31:0] io_IF_ID_INST,
  input         io_ID_EX_MEMREAD,
  input  [4:0]  io_ID_EX_REGRD,
  input  [31:0] io_pc_in,
  input  [31:0] io_current_pc,
  input         io_IF_ID_MEMREAD,
  output        io_inst_forward,
  output        io_pc_forward,
  output        io_ctrl_forward,
  output [31:0] io_inst_out,
  output [31:0] io_pc_out,
  output [31:0] io_current_pc_out
);
  wire [4:0] rs1_sel = io_IF_ID_INST[19:15]; // @[HazardDetection.scala 20:30]
  wire [4:0] rs2_sel = io_IF_ID_INST[24:20]; // @[HazardDetection.scala 21:30]
  wire  _T_2 = io_ID_EX_REGRD == rs1_sel; // @[HazardDetection.scala 24:59]
  wire  _T_3 = io_ID_EX_MEMREAD & io_ID_EX_REGRD == rs1_sel; // @[HazardDetection.scala 24:40]
  wire  _T_8 = io_ID_EX_MEMREAD & (_T_2 | io_ID_EX_REGRD == rs2_sel); // @[HazardDetection.scala 35:38]
  assign io_inst_forward = io_IF_ID_MEMREAD ? _T_3 : _T_8; // @[HazardDetection.scala 23:3]
  assign io_pc_forward = io_IF_ID_MEMREAD ? _T_3 : _T_8; // @[HazardDetection.scala 23:3]
  assign io_ctrl_forward = io_IF_ID_MEMREAD ? _T_3 : _T_8; // @[HazardDetection.scala 23:3]
  assign io_inst_out = io_IF_ID_INST; // @[HazardDetection.scala 23:3]
  assign io_pc_out = io_pc_in; // @[HazardDetection.scala 23:3]
  assign io_current_pc_out = io_current_pc; // @[HazardDetection.scala 23:3]
endmodule
module InstructionTypeDecode(
  input  [2:0] io_func3,
  input  [6:0] io_func7,
  input  [6:0] io_opcode,
  output       io_r_type,
  output       io_load_type,
  output       io_s_type,
  output       io_sb_type,
  output       io_i_type,
  output       io_jalr_type,
  output       io_jal_type,
  output       io_lui_type,
  output       io_Auipc,
  output       io_multiply,
  output       io_csr_imm_type,
  output       io_csr_type,
  output [1:0] io_csr_op
);
  wire  _T = io_opcode == 7'h33; // @[InstructionTypeDecode.scala 27:20]
  wire  _T_1 = io_func7 == 7'h1; // @[InstructionTypeDecode.scala 29:23]
  wire  _GEN_1 = _T_1 ? 1'h0 : 1'h1; // @[InstructionTypeDecode.scala 30:9 InstructionTypeDecode.scala 32:23 InstructionTypeDecode.scala 36:21]
  wire  _T_2 = io_opcode == 7'h3; // @[InstructionTypeDecode.scala 39:25]
  wire  _T_3 = io_opcode == 7'h23; // @[InstructionTypeDecode.scala 41:27]
  wire  _T_4 = io_opcode == 7'h63; // @[InstructionTypeDecode.scala 43:27]
  wire  _T_5 = io_opcode == 7'h13; // @[InstructionTypeDecode.scala 45:27]
  wire  _T_6 = io_opcode == 7'h67; // @[InstructionTypeDecode.scala 47:27]
  wire  _T_7 = io_opcode == 7'h6f; // @[InstructionTypeDecode.scala 49:27]
  wire  _T_8 = io_opcode == 7'h37; // @[InstructionTypeDecode.scala 51:27]
  wire  _T_9 = io_opcode == 7'h17; // @[InstructionTypeDecode.scala 54:26]
  wire  _T_10 = io_opcode == 7'h73; // @[InstructionTypeDecode.scala 56:27]
  wire  _T_18 = _T_10 & io_func3 == 3'h3; // @[InstructionTypeDecode.scala 62:44]
  wire  _T_27 = _T_10 & io_func3 == 3'h7; // @[InstructionTypeDecode.scala 71:44]
  wire [1:0] _GEN_3 = _T_10 & io_func3 == 3'h7 ? 2'h3 : 2'h0; // @[InstructionTypeDecode.scala 71:70 InstructionTypeDecode.scala 73:19 InstructionTypeDecode.scala 94:19]
  wire  _GEN_5 = _T_10 & io_func3 == 3'h6 | _T_27; // @[InstructionTypeDecode.scala 68:70 InstructionTypeDecode.scala 69:25]
  wire [1:0] _GEN_6 = _T_10 & io_func3 == 3'h6 ? 2'h2 : _GEN_3; // @[InstructionTypeDecode.scala 68:70 InstructionTypeDecode.scala 70:19]
  wire  _GEN_8 = _T_10 & io_func3 == 3'h5 | _GEN_5; // @[InstructionTypeDecode.scala 65:70 InstructionTypeDecode.scala 66:25]
  wire [1:0] _GEN_9 = _T_10 & io_func3 == 3'h5 ? 2'h1 : _GEN_6; // @[InstructionTypeDecode.scala 65:70 InstructionTypeDecode.scala 67:19]
  wire [1:0] _GEN_12 = _T_10 & io_func3 == 3'h3 ? 2'h3 : _GEN_9; // @[InstructionTypeDecode.scala 62:70 InstructionTypeDecode.scala 64:19]
  wire  _GEN_13 = _T_10 & io_func3 == 3'h3 ? 1'h0 : _GEN_8; // @[InstructionTypeDecode.scala 62:70 InstructionTypeDecode.scala 93:25]
  wire  _GEN_15 = _T_10 & io_func3 == 3'h2 | _T_18; // @[InstructionTypeDecode.scala 59:70 InstructionTypeDecode.scala 60:21]
  wire [1:0] _GEN_16 = _T_10 & io_func3 == 3'h2 ? 2'h2 : _GEN_12; // @[InstructionTypeDecode.scala 59:70 InstructionTypeDecode.scala 61:19]
  wire  _GEN_17 = _T_10 & io_func3 == 3'h2 ? 1'h0 : _GEN_13; // @[InstructionTypeDecode.scala 59:70 InstructionTypeDecode.scala 93:25]
  wire  _GEN_19 = io_opcode == 7'h73 & io_func3 == 3'h1 | _GEN_15; // @[InstructionTypeDecode.scala 56:70 InstructionTypeDecode.scala 57:21]
  wire [1:0] _GEN_20 = io_opcode == 7'h73 & io_func3 == 3'h1 ? 2'h1 : _GEN_16; // @[InstructionTypeDecode.scala 56:70 InstructionTypeDecode.scala 58:19]
  wire  _GEN_21 = io_opcode == 7'h73 & io_func3 == 3'h1 ? 1'h0 : _GEN_17; // @[InstructionTypeDecode.scala 56:70 InstructionTypeDecode.scala 93:25]
  wire  _GEN_24 = io_opcode == 7'h17 ? 1'h0 : _GEN_19; // @[InstructionTypeDecode.scala 54:44 InstructionTypeDecode.scala 92:21]
  wire [1:0] _GEN_25 = io_opcode == 7'h17 ? 2'h0 : _GEN_20; // @[InstructionTypeDecode.scala 54:44 InstructionTypeDecode.scala 94:19]
  wire  _GEN_26 = io_opcode == 7'h17 ? 1'h0 : _GEN_21; // @[InstructionTypeDecode.scala 54:44 InstructionTypeDecode.scala 93:25]
  wire  _GEN_29 = io_opcode == 7'h37 ? 1'h0 : _T_9; // @[InstructionTypeDecode.scala 51:45 InstructionTypeDecode.scala 90:21]
  wire  _GEN_30 = io_opcode == 7'h37 ? 1'h0 : _GEN_24; // @[InstructionTypeDecode.scala 51:45 InstructionTypeDecode.scala 92:21]
  wire [1:0] _GEN_31 = io_opcode == 7'h37 ? 2'h0 : _GEN_25; // @[InstructionTypeDecode.scala 51:45 InstructionTypeDecode.scala 94:19]
  wire  _GEN_32 = io_opcode == 7'h37 ? 1'h0 : _GEN_26; // @[InstructionTypeDecode.scala 51:45 InstructionTypeDecode.scala 93:25]
  wire  _GEN_35 = io_opcode == 7'h6f ? 1'h0 : _T_8; // @[InstructionTypeDecode.scala 49:45 InstructionTypeDecode.scala 89:21]
  wire  _GEN_36 = io_opcode == 7'h6f ? 1'h0 : _GEN_29; // @[InstructionTypeDecode.scala 49:45 InstructionTypeDecode.scala 90:21]
  wire  _GEN_37 = io_opcode == 7'h6f ? 1'h0 : _GEN_30; // @[InstructionTypeDecode.scala 49:45 InstructionTypeDecode.scala 92:21]
  wire [1:0] _GEN_38 = io_opcode == 7'h6f ? 2'h0 : _GEN_31; // @[InstructionTypeDecode.scala 49:45 InstructionTypeDecode.scala 94:19]
  wire  _GEN_39 = io_opcode == 7'h6f ? 1'h0 : _GEN_32; // @[InstructionTypeDecode.scala 49:45 InstructionTypeDecode.scala 93:25]
  wire  _GEN_42 = io_opcode == 7'h67 ? 1'h0 : _T_7; // @[InstructionTypeDecode.scala 47:45 InstructionTypeDecode.scala 88:21]
  wire  _GEN_43 = io_opcode == 7'h67 ? 1'h0 : _GEN_35; // @[InstructionTypeDecode.scala 47:45 InstructionTypeDecode.scala 89:21]
  wire  _GEN_44 = io_opcode == 7'h67 ? 1'h0 : _GEN_36; // @[InstructionTypeDecode.scala 47:45 InstructionTypeDecode.scala 90:21]
  wire  _GEN_45 = io_opcode == 7'h67 ? 1'h0 : _GEN_37; // @[InstructionTypeDecode.scala 47:45 InstructionTypeDecode.scala 92:21]
  wire [1:0] _GEN_46 = io_opcode == 7'h67 ? 2'h0 : _GEN_38; // @[InstructionTypeDecode.scala 47:45 InstructionTypeDecode.scala 94:19]
  wire  _GEN_47 = io_opcode == 7'h67 ? 1'h0 : _GEN_39; // @[InstructionTypeDecode.scala 47:45 InstructionTypeDecode.scala 93:25]
  wire  _GEN_50 = io_opcode == 7'h13 ? 1'h0 : _T_6; // @[InstructionTypeDecode.scala 45:45 InstructionTypeDecode.scala 87:22]
  wire  _GEN_51 = io_opcode == 7'h13 ? 1'h0 : _GEN_42; // @[InstructionTypeDecode.scala 45:45 InstructionTypeDecode.scala 88:21]
  wire  _GEN_52 = io_opcode == 7'h13 ? 1'h0 : _GEN_43; // @[InstructionTypeDecode.scala 45:45 InstructionTypeDecode.scala 89:21]
  wire  _GEN_53 = io_opcode == 7'h13 ? 1'h0 : _GEN_44; // @[InstructionTypeDecode.scala 45:45 InstructionTypeDecode.scala 90:21]
  wire  _GEN_54 = io_opcode == 7'h13 ? 1'h0 : _GEN_45; // @[InstructionTypeDecode.scala 45:45 InstructionTypeDecode.scala 92:21]
  wire [1:0] _GEN_55 = io_opcode == 7'h13 ? 2'h0 : _GEN_46; // @[InstructionTypeDecode.scala 45:45 InstructionTypeDecode.scala 94:19]
  wire  _GEN_56 = io_opcode == 7'h13 ? 1'h0 : _GEN_47; // @[InstructionTypeDecode.scala 45:45 InstructionTypeDecode.scala 93:25]
  wire  _GEN_59 = io_opcode == 7'h63 ? 1'h0 : _T_5; // @[InstructionTypeDecode.scala 43:45 InstructionTypeDecode.scala 86:19]
  wire  _GEN_60 = io_opcode == 7'h63 ? 1'h0 : _GEN_50; // @[InstructionTypeDecode.scala 43:45 InstructionTypeDecode.scala 87:22]
  wire  _GEN_61 = io_opcode == 7'h63 ? 1'h0 : _GEN_51; // @[InstructionTypeDecode.scala 43:45 InstructionTypeDecode.scala 88:21]
  wire  _GEN_62 = io_opcode == 7'h63 ? 1'h0 : _GEN_52; // @[InstructionTypeDecode.scala 43:45 InstructionTypeDecode.scala 89:21]
  wire  _GEN_63 = io_opcode == 7'h63 ? 1'h0 : _GEN_53; // @[InstructionTypeDecode.scala 43:45 InstructionTypeDecode.scala 90:21]
  wire  _GEN_64 = io_opcode == 7'h63 ? 1'h0 : _GEN_54; // @[InstructionTypeDecode.scala 43:45 InstructionTypeDecode.scala 92:21]
  wire [1:0] _GEN_65 = io_opcode == 7'h63 ? 2'h0 : _GEN_55; // @[InstructionTypeDecode.scala 43:45 InstructionTypeDecode.scala 94:19]
  wire  _GEN_66 = io_opcode == 7'h63 ? 1'h0 : _GEN_56; // @[InstructionTypeDecode.scala 43:45 InstructionTypeDecode.scala 93:25]
  wire  _GEN_69 = io_opcode == 7'h23 ? 1'h0 : _T_4; // @[InstructionTypeDecode.scala 41:45 InstructionTypeDecode.scala 85:20]
  wire  _GEN_70 = io_opcode == 7'h23 ? 1'h0 : _GEN_59; // @[InstructionTypeDecode.scala 41:45 InstructionTypeDecode.scala 86:19]
  wire  _GEN_71 = io_opcode == 7'h23 ? 1'h0 : _GEN_60; // @[InstructionTypeDecode.scala 41:45 InstructionTypeDecode.scala 87:22]
  wire  _GEN_72 = io_opcode == 7'h23 ? 1'h0 : _GEN_61; // @[InstructionTypeDecode.scala 41:45 InstructionTypeDecode.scala 88:21]
  wire  _GEN_73 = io_opcode == 7'h23 ? 1'h0 : _GEN_62; // @[InstructionTypeDecode.scala 41:45 InstructionTypeDecode.scala 89:21]
  wire  _GEN_74 = io_opcode == 7'h23 ? 1'h0 : _GEN_63; // @[InstructionTypeDecode.scala 41:45 InstructionTypeDecode.scala 90:21]
  wire  _GEN_75 = io_opcode == 7'h23 ? 1'h0 : _GEN_64; // @[InstructionTypeDecode.scala 41:45 InstructionTypeDecode.scala 92:21]
  wire [1:0] _GEN_76 = io_opcode == 7'h23 ? 2'h0 : _GEN_65; // @[InstructionTypeDecode.scala 41:45 InstructionTypeDecode.scala 94:19]
  wire  _GEN_77 = io_opcode == 7'h23 ? 1'h0 : _GEN_66; // @[InstructionTypeDecode.scala 41:45 InstructionTypeDecode.scala 93:25]
  wire  _GEN_80 = io_opcode == 7'h3 ? 1'h0 : _T_3; // @[InstructionTypeDecode.scala 39:43 InstructionTypeDecode.scala 84:19]
  wire  _GEN_81 = io_opcode == 7'h3 ? 1'h0 : _GEN_69; // @[InstructionTypeDecode.scala 39:43 InstructionTypeDecode.scala 85:20]
  wire  _GEN_82 = io_opcode == 7'h3 ? 1'h0 : _GEN_70; // @[InstructionTypeDecode.scala 39:43 InstructionTypeDecode.scala 86:19]
  wire  _GEN_83 = io_opcode == 7'h3 ? 1'h0 : _GEN_71; // @[InstructionTypeDecode.scala 39:43 InstructionTypeDecode.scala 87:22]
  wire  _GEN_84 = io_opcode == 7'h3 ? 1'h0 : _GEN_72; // @[InstructionTypeDecode.scala 39:43 InstructionTypeDecode.scala 88:21]
  wire  _GEN_85 = io_opcode == 7'h3 ? 1'h0 : _GEN_73; // @[InstructionTypeDecode.scala 39:43 InstructionTypeDecode.scala 89:21]
  wire  _GEN_86 = io_opcode == 7'h3 ? 1'h0 : _GEN_74; // @[InstructionTypeDecode.scala 39:43 InstructionTypeDecode.scala 90:21]
  wire  _GEN_87 = io_opcode == 7'h3 ? 1'h0 : _GEN_75; // @[InstructionTypeDecode.scala 39:43 InstructionTypeDecode.scala 92:21]
  wire [1:0] _GEN_88 = io_opcode == 7'h3 ? 2'h0 : _GEN_76; // @[InstructionTypeDecode.scala 39:43 InstructionTypeDecode.scala 94:19]
  wire  _GEN_89 = io_opcode == 7'h3 ? 1'h0 : _GEN_77; // @[InstructionTypeDecode.scala 39:43 InstructionTypeDecode.scala 93:25]
  assign io_r_type = _T & _GEN_1; // @[InstructionTypeDecode.scala 28:5]
  assign io_load_type = _T ? 1'h0 : _T_2; // @[InstructionTypeDecode.scala 28:5 InstructionTypeDecode.scala 83:22]
  assign io_s_type = _T ? 1'h0 : _GEN_80; // @[InstructionTypeDecode.scala 28:5 InstructionTypeDecode.scala 84:19]
  assign io_sb_type = _T ? 1'h0 : _GEN_81; // @[InstructionTypeDecode.scala 28:5 InstructionTypeDecode.scala 85:20]
  assign io_i_type = _T ? 1'h0 : _GEN_82; // @[InstructionTypeDecode.scala 28:5 InstructionTypeDecode.scala 86:19]
  assign io_jalr_type = _T ? 1'h0 : _GEN_83; // @[InstructionTypeDecode.scala 28:5 InstructionTypeDecode.scala 87:22]
  assign io_jal_type = _T ? 1'h0 : _GEN_84; // @[InstructionTypeDecode.scala 28:5 InstructionTypeDecode.scala 88:21]
  assign io_lui_type = _T ? 1'h0 : _GEN_85; // @[InstructionTypeDecode.scala 28:5 InstructionTypeDecode.scala 89:21]
  assign io_Auipc = _T ? 1'h0 : _GEN_86; // @[InstructionTypeDecode.scala 28:5 InstructionTypeDecode.scala 90:21]
  assign io_multiply = _T & _T_1; // @[InstructionTypeDecode.scala 28:5]
  assign io_csr_imm_type = _T ? 1'h0 : _GEN_89; // @[InstructionTypeDecode.scala 28:5 InstructionTypeDecode.scala 93:25]
  assign io_csr_type = _T ? 1'h0 : _GEN_87; // @[InstructionTypeDecode.scala 28:5 InstructionTypeDecode.scala 92:21]
  assign io_csr_op = _T ? 2'h0 : _GEN_88; // @[InstructionTypeDecode.scala 28:5 InstructionTypeDecode.scala 94:19]
endmodule
module ControlDecode(
  input        io_in_r_type,
  input        io_in_load_type,
  input        io_in_s_type,
  input        io_in_sb_type,
  input        io_in_i_type,
  input        io_in_jalr_type,
  input        io_in_jal_type,
  input        io_in_lui_type,
  input        io_in_csr_type,
  input        io_in_csr_imm_type,
  input        io_Auipc,
  input        io_multiply,
  output       io_memWrite,
  output       io_memRead,
  output       io_branch,
  output       io_regWrite,
  output       io_csr_wen,
  output       io_memToReg,
  output [3:0] io_aluOperation,
  output [1:0] io_operand_a_sel,
  output       io_operand_b_sel,
  output [1:0] io_extend_sel,
  output [1:0] io_next_pc_sel
);
  wire [4:0] _GEN_2 = io_in_csr_imm_type ? 5'h8 : 5'h1c; // @[ControlDecode.scala 169:45 ControlDecode.scala 176:25 ControlDecode.scala 193:25]
  wire  _GEN_4 = io_in_csr_type | io_in_csr_imm_type; // @[ControlDecode.scala 157:41 ControlDecode.scala 161:21]
  wire [4:0] _GEN_5 = io_in_csr_type ? 5'h8 : _GEN_2; // @[ControlDecode.scala 157:41 ControlDecode.scala 164:25]
  wire  _GEN_7 = io_multiply | _GEN_4; // @[ControlDecode.scala 145:36 ControlDecode.scala 149:21]
  wire [4:0] _GEN_8 = io_multiply ? 5'h9 : _GEN_5; // @[ControlDecode.scala 145:36 ControlDecode.scala 151:25]
  wire  _GEN_9 = io_multiply ? 1'h0 : _GEN_4; // @[ControlDecode.scala 145:36 ControlDecode.scala 153:26]
  wire  _GEN_11 = io_Auipc | _GEN_7; // @[ControlDecode.scala 133:5 ControlDecode.scala 137:21]
  wire [4:0] _GEN_12 = io_Auipc ? 5'h7 : _GEN_8; // @[ControlDecode.scala 133:5 ControlDecode.scala 139:25]
  wire  _GEN_14 = io_Auipc | _GEN_9; // @[ControlDecode.scala 133:5 ControlDecode.scala 141:26]
  wire [1:0] _GEN_15 = io_Auipc ? 2'h2 : 2'h0; // @[ControlDecode.scala 133:5 ControlDecode.scala 142:23]
  wire  _GEN_16 = io_Auipc ? 1'h0 : _GEN_9; // @[ControlDecode.scala 133:5 ControlDecode.scala 198:20]
  wire  _GEN_18 = io_in_lui_type | _GEN_11; // @[ControlDecode.scala 120:5 ControlDecode.scala 124:21]
  wire [4:0] _GEN_19 = io_in_lui_type ? 5'h6 : _GEN_12; // @[ControlDecode.scala 120:5 ControlDecode.scala 126:25]
  wire [1:0] _GEN_20 = io_in_lui_type ? 2'h3 : {{1'd0}, io_Auipc}; // @[ControlDecode.scala 120:5 ControlDecode.scala 127:26]
  wire  _GEN_21 = io_in_lui_type | _GEN_14; // @[ControlDecode.scala 120:5 ControlDecode.scala 128:26]
  wire [1:0] _GEN_22 = io_in_lui_type ? 2'h2 : _GEN_15; // @[ControlDecode.scala 120:5 ControlDecode.scala 129:23]
  wire  _GEN_23 = io_in_lui_type ? 1'h0 : _GEN_16; // @[ControlDecode.scala 120:5 ControlDecode.scala 198:20]
  wire  _GEN_25 = io_in_jal_type | _GEN_18; // @[ControlDecode.scala 107:41 ControlDecode.scala 111:21]
  wire [4:0] _GEN_26 = io_in_jal_type ? 5'h3 : _GEN_19; // @[ControlDecode.scala 107:41 ControlDecode.scala 113:25]
  wire [1:0] _GEN_27 = io_in_jal_type ? 2'h2 : _GEN_20; // @[ControlDecode.scala 107:41 ControlDecode.scala 114:26]
  wire  _GEN_28 = io_in_jal_type ? 1'h0 : _GEN_21; // @[ControlDecode.scala 107:41 ControlDecode.scala 115:26]
  wire [1:0] _GEN_29 = io_in_jal_type ? 2'h0 : _GEN_22; // @[ControlDecode.scala 107:41 ControlDecode.scala 116:23]
  wire [1:0] _GEN_30 = io_in_jal_type ? 2'h2 : 2'h0; // @[ControlDecode.scala 107:41 ControlDecode.scala 117:24]
  wire  _GEN_31 = io_in_jal_type ? 1'h0 : _GEN_23; // @[ControlDecode.scala 107:41 ControlDecode.scala 198:20]
  wire  _GEN_33 = io_in_jalr_type | _GEN_25; // @[ControlDecode.scala 96:42 ControlDecode.scala 100:21]
  wire [4:0] _GEN_34 = io_in_jalr_type ? 5'h3 : _GEN_26; // @[ControlDecode.scala 96:42 ControlDecode.scala 102:25]
  wire [1:0] _GEN_35 = io_in_jalr_type ? 2'h2 : _GEN_27; // @[ControlDecode.scala 96:42 ControlDecode.scala 103:26]
  wire  _GEN_36 = io_in_jalr_type ? 1'h0 : _GEN_28; // @[ControlDecode.scala 96:42 ControlDecode.scala 104:26]
  wire [1:0] _GEN_37 = io_in_jalr_type ? 2'h0 : _GEN_29; // @[ControlDecode.scala 96:42 ControlDecode.scala 105:23]
  wire [1:0] _GEN_38 = io_in_jalr_type ? 2'h3 : _GEN_30; // @[ControlDecode.scala 96:42 ControlDecode.scala 106:24]
  wire  _GEN_39 = io_in_jalr_type ? 1'h0 : _GEN_31; // @[ControlDecode.scala 96:42 ControlDecode.scala 198:20]
  wire  _GEN_41 = io_in_i_type | _GEN_33; // @[ControlDecode.scala 85:39 ControlDecode.scala 89:21]
  wire [4:0] _GEN_42 = io_in_i_type ? 5'h1 : _GEN_34; // @[ControlDecode.scala 85:39 ControlDecode.scala 91:25]
  wire [1:0] _GEN_43 = io_in_i_type ? 2'h0 : _GEN_35; // @[ControlDecode.scala 85:39 ControlDecode.scala 92:26]
  wire  _GEN_44 = io_in_i_type | _GEN_36; // @[ControlDecode.scala 85:39 ControlDecode.scala 93:26]
  wire [1:0] _GEN_45 = io_in_i_type ? 2'h0 : _GEN_37; // @[ControlDecode.scala 85:39 ControlDecode.scala 94:23]
  wire [1:0] _GEN_46 = io_in_i_type ? 2'h0 : _GEN_38; // @[ControlDecode.scala 85:39 ControlDecode.scala 95:24]
  wire  _GEN_47 = io_in_i_type ? 1'h0 : _GEN_39; // @[ControlDecode.scala 85:39 ControlDecode.scala 198:20]
  wire  _GEN_50 = io_in_sb_type ? 1'h0 : _GEN_41; // @[ControlDecode.scala 74:40 ControlDecode.scala 78:21]
  wire [4:0] _GEN_51 = io_in_sb_type ? 5'h2 : _GEN_42; // @[ControlDecode.scala 74:40 ControlDecode.scala 80:25]
  wire [1:0] _GEN_52 = io_in_sb_type ? 2'h0 : _GEN_43; // @[ControlDecode.scala 74:40 ControlDecode.scala 81:26]
  wire  _GEN_53 = io_in_sb_type ? 1'h0 : _GEN_44; // @[ControlDecode.scala 74:40 ControlDecode.scala 82:26]
  wire [1:0] _GEN_54 = io_in_sb_type ? 2'h0 : _GEN_45; // @[ControlDecode.scala 74:40 ControlDecode.scala 83:23]
  wire [1:0] _GEN_55 = io_in_sb_type ? 2'h1 : _GEN_46; // @[ControlDecode.scala 74:40 ControlDecode.scala 84:24]
  wire  _GEN_56 = io_in_sb_type ? 1'h0 : _GEN_47; // @[ControlDecode.scala 74:40 ControlDecode.scala 198:20]
  wire  _GEN_59 = io_in_s_type ? 1'h0 : io_in_sb_type; // @[ControlDecode.scala 62:39 ControlDecode.scala 66:19]
  wire  _GEN_60 = io_in_s_type ? 1'h0 : _GEN_50; // @[ControlDecode.scala 62:39 ControlDecode.scala 67:21]
  wire [4:0] _GEN_61 = io_in_s_type ? 5'h5 : _GEN_51; // @[ControlDecode.scala 62:39 ControlDecode.scala 69:25]
  wire [1:0] _GEN_62 = io_in_s_type ? 2'h0 : _GEN_52; // @[ControlDecode.scala 62:39 ControlDecode.scala 70:26]
  wire  _GEN_63 = io_in_s_type | _GEN_53; // @[ControlDecode.scala 62:39 ControlDecode.scala 71:26]
  wire [1:0] _GEN_64 = io_in_s_type ? 2'h1 : _GEN_54; // @[ControlDecode.scala 62:39 ControlDecode.scala 72:23]
  wire [1:0] _GEN_65 = io_in_s_type ? 2'h0 : _GEN_55; // @[ControlDecode.scala 62:39 ControlDecode.scala 73:24]
  wire  _GEN_66 = io_in_s_type ? 1'h0 : _GEN_56; // @[ControlDecode.scala 62:39 ControlDecode.scala 198:20]
  wire  _GEN_67 = io_in_load_type ? 1'h0 : io_in_s_type; // @[ControlDecode.scala 50:40 ControlDecode.scala 52:21]
  wire  _GEN_69 = io_in_load_type ? 1'h0 : _GEN_59; // @[ControlDecode.scala 50:40 ControlDecode.scala 54:19]
  wire  _GEN_70 = io_in_load_type | _GEN_60; // @[ControlDecode.scala 50:40 ControlDecode.scala 55:21]
  wire [4:0] _GEN_71 = io_in_load_type ? 5'h4 : _GEN_61; // @[ControlDecode.scala 50:40 ControlDecode.scala 57:25]
  wire [1:0] _GEN_72 = io_in_load_type ? 2'h0 : _GEN_62; // @[ControlDecode.scala 50:40 ControlDecode.scala 58:26]
  wire  _GEN_73 = io_in_load_type | _GEN_63; // @[ControlDecode.scala 50:40 ControlDecode.scala 59:26]
  wire [1:0] _GEN_74 = io_in_load_type ? 2'h0 : _GEN_64; // @[ControlDecode.scala 50:40 ControlDecode.scala 60:23]
  wire [1:0] _GEN_75 = io_in_load_type ? 2'h0 : _GEN_65; // @[ControlDecode.scala 50:40 ControlDecode.scala 61:24]
  wire  _GEN_76 = io_in_load_type ? 1'h0 : _GEN_66; // @[ControlDecode.scala 50:40 ControlDecode.scala 198:20]
  wire [4:0] _GEN_81 = io_in_r_type ? 5'h0 : _GEN_71; // @[ControlDecode.scala 37:32 ControlDecode.scala 43:25]
  assign io_memWrite = io_in_r_type ? 1'h0 : _GEN_67; // @[ControlDecode.scala 37:32 ControlDecode.scala 38:21]
  assign io_memRead = io_in_r_type ? 1'h0 : io_in_load_type; // @[ControlDecode.scala 37:32 ControlDecode.scala 39:21]
  assign io_branch = io_in_r_type ? 1'h0 : _GEN_69; // @[ControlDecode.scala 37:32 ControlDecode.scala 40:19]
  assign io_regWrite = io_in_r_type | _GEN_70; // @[ControlDecode.scala 37:32 ControlDecode.scala 41:21]
  assign io_csr_wen = io_in_r_type ? 1'h0 : _GEN_76; // @[ControlDecode.scala 37:32 ControlDecode.scala 198:20]
  assign io_memToReg = io_in_r_type ? 1'h0 : io_in_load_type; // @[ControlDecode.scala 37:32 ControlDecode.scala 39:21]
  assign io_aluOperation = _GEN_81[3:0];
  assign io_operand_a_sel = io_in_r_type ? 2'h0 : _GEN_72; // @[ControlDecode.scala 37:32 ControlDecode.scala 44:26]
  assign io_operand_b_sel = io_in_r_type ? 1'h0 : _GEN_73; // @[ControlDecode.scala 37:32 ControlDecode.scala 45:26]
  assign io_extend_sel = io_in_r_type ? 2'h0 : _GEN_74; // @[ControlDecode.scala 37:32 ControlDecode.scala 46:23]
  assign io_next_pc_sel = io_in_r_type ? 2'h0 : _GEN_75; // @[ControlDecode.scala 37:32 ControlDecode.scala 47:24]
endmodule
module Control(
  input  [6:0] io_in_opcode,
  input  [6:0] io_func7,
  input  [2:0] io_func3,
  output       io_out_memWrite,
  output       io_out_branch,
  output       io_out_memRead,
  output       io_out_regWrite,
  output       io_csr_we_o,
  output       io_csr_imm_type,
  output [1:0] io_csr_op_o,
  output       io_out_memToReg,
  output [3:0] io_out_aluOp,
  output [1:0] io_out_operand_a_sel,
  output       io_out_operand_b_sel,
  output [1:0] io_out_extend_sel,
  output [1:0] io_out_next_pc_sel
);
  wire [2:0] instruction_type_decode_io_func3; // @[Control.scala 26:41]
  wire [6:0] instruction_type_decode_io_func7; // @[Control.scala 26:41]
  wire [6:0] instruction_type_decode_io_opcode; // @[Control.scala 26:41]
  wire  instruction_type_decode_io_r_type; // @[Control.scala 26:41]
  wire  instruction_type_decode_io_load_type; // @[Control.scala 26:41]
  wire  instruction_type_decode_io_s_type; // @[Control.scala 26:41]
  wire  instruction_type_decode_io_sb_type; // @[Control.scala 26:41]
  wire  instruction_type_decode_io_i_type; // @[Control.scala 26:41]
  wire  instruction_type_decode_io_jalr_type; // @[Control.scala 26:41]
  wire  instruction_type_decode_io_jal_type; // @[Control.scala 26:41]
  wire  instruction_type_decode_io_lui_type; // @[Control.scala 26:41]
  wire  instruction_type_decode_io_Auipc; // @[Control.scala 26:41]
  wire  instruction_type_decode_io_multiply; // @[Control.scala 26:41]
  wire  instruction_type_decode_io_csr_imm_type; // @[Control.scala 26:41]
  wire  instruction_type_decode_io_csr_type; // @[Control.scala 26:41]
  wire [1:0] instruction_type_decode_io_csr_op; // @[Control.scala 26:41]
  wire  control_decode_io_in_r_type; // @[Control.scala 27:32]
  wire  control_decode_io_in_load_type; // @[Control.scala 27:32]
  wire  control_decode_io_in_s_type; // @[Control.scala 27:32]
  wire  control_decode_io_in_sb_type; // @[Control.scala 27:32]
  wire  control_decode_io_in_i_type; // @[Control.scala 27:32]
  wire  control_decode_io_in_jalr_type; // @[Control.scala 27:32]
  wire  control_decode_io_in_jal_type; // @[Control.scala 27:32]
  wire  control_decode_io_in_lui_type; // @[Control.scala 27:32]
  wire  control_decode_io_in_csr_type; // @[Control.scala 27:32]
  wire  control_decode_io_in_csr_imm_type; // @[Control.scala 27:32]
  wire  control_decode_io_Auipc; // @[Control.scala 27:32]
  wire  control_decode_io_multiply; // @[Control.scala 27:32]
  wire  control_decode_io_memWrite; // @[Control.scala 27:32]
  wire  control_decode_io_memRead; // @[Control.scala 27:32]
  wire  control_decode_io_branch; // @[Control.scala 27:32]
  wire  control_decode_io_regWrite; // @[Control.scala 27:32]
  wire  control_decode_io_csr_wen; // @[Control.scala 27:32]
  wire  control_decode_io_memToReg; // @[Control.scala 27:32]
  wire [3:0] control_decode_io_aluOperation; // @[Control.scala 27:32]
  wire [1:0] control_decode_io_operand_a_sel; // @[Control.scala 27:32]
  wire  control_decode_io_operand_b_sel; // @[Control.scala 27:32]
  wire [1:0] control_decode_io_extend_sel; // @[Control.scala 27:32]
  wire [1:0] control_decode_io_next_pc_sel; // @[Control.scala 27:32]
  InstructionTypeDecode instruction_type_decode ( // @[Control.scala 26:41]
    .io_func3(instruction_type_decode_io_func3),
    .io_func7(instruction_type_decode_io_func7),
    .io_opcode(instruction_type_decode_io_opcode),
    .io_r_type(instruction_type_decode_io_r_type),
    .io_load_type(instruction_type_decode_io_load_type),
    .io_s_type(instruction_type_decode_io_s_type),
    .io_sb_type(instruction_type_decode_io_sb_type),
    .io_i_type(instruction_type_decode_io_i_type),
    .io_jalr_type(instruction_type_decode_io_jalr_type),
    .io_jal_type(instruction_type_decode_io_jal_type),
    .io_lui_type(instruction_type_decode_io_lui_type),
    .io_Auipc(instruction_type_decode_io_Auipc),
    .io_multiply(instruction_type_decode_io_multiply),
    .io_csr_imm_type(instruction_type_decode_io_csr_imm_type),
    .io_csr_type(instruction_type_decode_io_csr_type),
    .io_csr_op(instruction_type_decode_io_csr_op)
  );
  ControlDecode control_decode ( // @[Control.scala 27:32]
    .io_in_r_type(control_decode_io_in_r_type),
    .io_in_load_type(control_decode_io_in_load_type),
    .io_in_s_type(control_decode_io_in_s_type),
    .io_in_sb_type(control_decode_io_in_sb_type),
    .io_in_i_type(control_decode_io_in_i_type),
    .io_in_jalr_type(control_decode_io_in_jalr_type),
    .io_in_jal_type(control_decode_io_in_jal_type),
    .io_in_lui_type(control_decode_io_in_lui_type),
    .io_in_csr_type(control_decode_io_in_csr_type),
    .io_in_csr_imm_type(control_decode_io_in_csr_imm_type),
    .io_Auipc(control_decode_io_Auipc),
    .io_multiply(control_decode_io_multiply),
    .io_memWrite(control_decode_io_memWrite),
    .io_memRead(control_decode_io_memRead),
    .io_branch(control_decode_io_branch),
    .io_regWrite(control_decode_io_regWrite),
    .io_csr_wen(control_decode_io_csr_wen),
    .io_memToReg(control_decode_io_memToReg),
    .io_aluOperation(control_decode_io_aluOperation),
    .io_operand_a_sel(control_decode_io_operand_a_sel),
    .io_operand_b_sel(control_decode_io_operand_b_sel),
    .io_extend_sel(control_decode_io_extend_sel),
    .io_next_pc_sel(control_decode_io_next_pc_sel)
  );
  assign io_out_memWrite = control_decode_io_memWrite; // @[Control.scala 43:21]
  assign io_out_branch = control_decode_io_branch; // @[Control.scala 44:19]
  assign io_out_memRead = control_decode_io_memRead; // @[Control.scala 45:20]
  assign io_out_regWrite = control_decode_io_regWrite; // @[Control.scala 46:21]
  assign io_csr_we_o = control_decode_io_csr_wen; // @[Control.scala 47:17]
  assign io_csr_imm_type = instruction_type_decode_io_csr_imm_type; // @[Control.scala 57:21]
  assign io_csr_op_o = instruction_type_decode_io_csr_op; // @[Control.scala 56:17]
  assign io_out_memToReg = control_decode_io_memToReg; // @[Control.scala 48:21]
  assign io_out_aluOp = control_decode_io_aluOperation; // @[Control.scala 49:18]
  assign io_out_operand_a_sel = control_decode_io_operand_a_sel; // @[Control.scala 50:26]
  assign io_out_operand_b_sel = control_decode_io_operand_b_sel; // @[Control.scala 51:26]
  assign io_out_extend_sel = control_decode_io_extend_sel; // @[Control.scala 52:23]
  assign io_out_next_pc_sel = control_decode_io_next_pc_sel; // @[Control.scala 53:24]
  assign instruction_type_decode_io_func3 = io_func3; // @[Control.scala 29:39]
  assign instruction_type_decode_io_func7 = io_func7; // @[Control.scala 58:38]
  assign instruction_type_decode_io_opcode = io_in_opcode; // @[Control.scala 28:39]
  assign control_decode_io_in_r_type = instruction_type_decode_io_r_type; // @[Control.scala 30:33]
  assign control_decode_io_in_load_type = instruction_type_decode_io_load_type; // @[Control.scala 31:36]
  assign control_decode_io_in_s_type = instruction_type_decode_io_s_type; // @[Control.scala 32:33]
  assign control_decode_io_in_sb_type = instruction_type_decode_io_sb_type; // @[Control.scala 33:34]
  assign control_decode_io_in_i_type = instruction_type_decode_io_i_type; // @[Control.scala 34:33]
  assign control_decode_io_in_jalr_type = instruction_type_decode_io_jalr_type; // @[Control.scala 35:36]
  assign control_decode_io_in_jal_type = instruction_type_decode_io_jal_type; // @[Control.scala 36:35]
  assign control_decode_io_in_lui_type = instruction_type_decode_io_lui_type; // @[Control.scala 37:35]
  assign control_decode_io_in_csr_type = instruction_type_decode_io_csr_type; // @[Control.scala 40:35]
  assign control_decode_io_in_csr_imm_type = instruction_type_decode_io_csr_imm_type; // @[Control.scala 41:39]
  assign control_decode_io_Auipc = instruction_type_decode_io_Auipc; // @[Control.scala 38:35]
  assign control_decode_io_multiply = instruction_type_decode_io_multiply; // @[Control.scala 39:35]
endmodule
module DecodeForwardUnit(
  input  [4:0] io_ID_EX_REGRD,
  input        io_ID_EX_MEMRD,
  input  [4:0] io_EX_MEM_REGRD,
  input        io_EX_MEM_MEMRD,
  input  [4:0] io_MEM_WB_REGRD,
  input        io_MEM_WB_MEMRD,
  input        io_execute_regwrite,
  input        io_mem_regwrite,
  input        io_wb_regwrite,
  input  [4:0] io_rs1_sel,
  input  [4:0] io_rs2_sel,
  input        io_ctrl_branch,
  output [3:0] io_forward_rs1,
  output [3:0] io_forward_rs2
);
  wire  _T_1 = io_ID_EX_REGRD != 5'h0; // @[DecodeForwardUnit.scala 29:27]
  wire  _T_2 = ~io_ID_EX_MEMRD; // @[DecodeForwardUnit.scala 29:60]
  wire  _T_3 = io_ID_EX_REGRD != 5'h0 & ~io_ID_EX_MEMRD; // @[DecodeForwardUnit.scala 29:42]
  wire  _T_4 = io_ID_EX_REGRD == io_rs1_sel; // @[DecodeForwardUnit.scala 29:87]
  wire  _T_5 = io_ID_EX_REGRD != 5'h0 & ~io_ID_EX_MEMRD & io_ID_EX_REGRD == io_rs1_sel; // @[DecodeForwardUnit.scala 29:68]
  wire  _T_6 = io_ID_EX_REGRD == io_rs2_sel; // @[DecodeForwardUnit.scala 29:122]
  wire  _T_17 = _T_3 & _T_6; // @[DecodeForwardUnit.scala 34:75]
  wire  _GEN_2 = _T_5 ? 1'h0 : _T_17; // @[DecodeForwardUnit.scala 32:111 DecodeForwardUnit.scala 24:20]
  wire  _GEN_3 = io_ID_EX_REGRD != 5'h0 & ~io_ID_EX_MEMRD & io_ID_EX_REGRD == io_rs1_sel & io_ID_EX_REGRD == io_rs2_sel
     | io_ID_EX_REGRD != 5'h0 & ~io_ID_EX_MEMRD & io_ID_EX_REGRD == io_rs1_sel; // @[DecodeForwardUnit.scala 29:139 DecodeForwardUnit.scala 30:24]
  wire  _GEN_4 = io_ID_EX_REGRD != 5'h0 & ~io_ID_EX_MEMRD & io_ID_EX_REGRD == io_rs1_sel & io_ID_EX_REGRD == io_rs2_sel
     | _GEN_2; // @[DecodeForwardUnit.scala 29:139 DecodeForwardUnit.scala 31:24]
  wire  _T_18 = io_EX_MEM_REGRD != 5'h0; // @[DecodeForwardUnit.scala 39:28]
  wire  _T_19 = ~io_EX_MEM_MEMRD; // @[DecodeForwardUnit.scala 39:62]
  wire  _T_20 = io_EX_MEM_REGRD != 5'h0 & ~io_EX_MEM_MEMRD; // @[DecodeForwardUnit.scala 39:43]
  wire  _T_23 = _T_1 & _T_4; // @[DecodeForwardUnit.scala 40:43]
  wire  _T_26 = ~(_T_1 & _T_4 & _T_6); // @[DecodeForwardUnit.scala 40:9]
  wire  _T_27 = io_EX_MEM_REGRD != 5'h0 & ~io_EX_MEM_MEMRD & _T_26; // @[DecodeForwardUnit.scala 39:70]
  wire  _T_28 = io_EX_MEM_REGRD == io_rs1_sel; // @[DecodeForwardUnit.scala 41:26]
  wire  _T_29 = _T_27 & _T_28; // @[DecodeForwardUnit.scala 40:114]
  wire  _T_30 = io_EX_MEM_REGRD == io_rs2_sel; // @[DecodeForwardUnit.scala 41:62]
  wire  _T_38 = ~(_T_1 & _T_6); // @[DecodeForwardUnit.scala 47:9]
  wire  _T_39 = _T_20 & _T_38; // @[DecodeForwardUnit.scala 46:77]
  wire  _T_41 = _T_39 & _T_30; // @[DecodeForwardUnit.scala 47:79]
  wire  _T_48 = ~_T_23; // @[DecodeForwardUnit.scala 53:9]
  wire  _T_49 = _T_20 & _T_48; // @[DecodeForwardUnit.scala 52:77]
  wire  _T_51 = _T_49 & _T_28; // @[DecodeForwardUnit.scala 53:79]
  wire  _T_54 = _T_18 & io_EX_MEM_MEMRD; // @[DecodeForwardUnit.scala 58:50]
  wire  _T_61 = _T_18 & io_EX_MEM_MEMRD & _T_26; // @[DecodeForwardUnit.scala 58:77]
  wire  _T_63 = _T_61 & _T_28; // @[DecodeForwardUnit.scala 59:114]
  wire  _T_73 = _T_54 & _T_38; // @[DecodeForwardUnit.scala 65:77]
  wire  _T_75 = _T_73 & _T_30; // @[DecodeForwardUnit.scala 66:79]
  wire  _T_85 = io_ctrl_branch & _T_18 & io_EX_MEM_MEMRD & _T_48; // @[DecodeForwardUnit.scala 71:103]
  wire  _T_87 = _T_85 & _T_28; // @[DecodeForwardUnit.scala 72:79]
  wire [2:0] _GEN_5 = _T_87 ? 3'h4 : {{2'd0}, _GEN_3}; // @[DecodeForwardUnit.scala 73:43 DecodeForwardUnit.scala 75:24]
  wire [2:0] _GEN_6 = _T_75 ? 3'h4 : {{2'd0}, _GEN_4}; // @[DecodeForwardUnit.scala 67:43 DecodeForwardUnit.scala 69:24]
  wire [2:0] _GEN_7 = _T_75 ? {{2'd0}, _GEN_3} : _GEN_5; // @[DecodeForwardUnit.scala 67:43]
  wire [2:0] _GEN_8 = _T_63 & _T_30 ? 3'h4 : _GEN_7; // @[DecodeForwardUnit.scala 60:79 DecodeForwardUnit.scala 62:24]
  wire [2:0] _GEN_9 = _T_63 & _T_30 ? 3'h4 : _GEN_6; // @[DecodeForwardUnit.scala 60:79 DecodeForwardUnit.scala 63:24]
  wire [2:0] _GEN_10 = _T_51 ? 3'h2 : _GEN_8; // @[DecodeForwardUnit.scala 54:43 DecodeForwardUnit.scala 56:24]
  wire [2:0] _GEN_11 = _T_51 ? {{2'd0}, _GEN_4} : _GEN_9; // @[DecodeForwardUnit.scala 54:43]
  wire [2:0] _GEN_12 = _T_41 ? 3'h2 : _GEN_11; // @[DecodeForwardUnit.scala 48:43 DecodeForwardUnit.scala 50:24]
  wire [2:0] _GEN_13 = _T_41 ? {{2'd0}, _GEN_3} : _GEN_10; // @[DecodeForwardUnit.scala 48:43]
  wire [2:0] _GEN_14 = _T_29 & io_EX_MEM_REGRD == io_rs2_sel ? 3'h2 : _GEN_13; // @[DecodeForwardUnit.scala 41:79 DecodeForwardUnit.scala 43:24]
  wire [2:0] _GEN_15 = _T_29 & io_EX_MEM_REGRD == io_rs2_sel ? 3'h2 : _GEN_12; // @[DecodeForwardUnit.scala 41:79 DecodeForwardUnit.scala 44:24]
  wire  _T_88 = io_MEM_WB_REGRD != 5'h0; // @[DecodeForwardUnit.scala 80:28]
  wire  _T_89 = ~io_MEM_WB_MEMRD; // @[DecodeForwardUnit.scala 80:62]
  wire  _T_90 = io_MEM_WB_REGRD != 5'h0 & ~io_MEM_WB_MEMRD; // @[DecodeForwardUnit.scala 80:43]
  wire  _T_97 = io_MEM_WB_REGRD != 5'h0 & ~io_MEM_WB_MEMRD & _T_26; // @[DecodeForwardUnit.scala 80:70]
  wire  _T_100 = _T_18 & _T_28; // @[DecodeForwardUnit.scala 84:44]
  wire  _T_103 = ~(_T_18 & _T_28 & _T_30); // @[DecodeForwardUnit.scala 84:9]
  wire  _T_104 = _T_97 & _T_103; // @[DecodeForwardUnit.scala 82:114]
  wire  _T_105 = io_MEM_WB_REGRD == io_rs1_sel; // @[DecodeForwardUnit.scala 85:26]
  wire  _T_106 = _T_104 & _T_105; // @[DecodeForwardUnit.scala 84:117]
  wire  _T_107 = io_MEM_WB_REGRD == io_rs2_sel; // @[DecodeForwardUnit.scala 85:62]
  wire  _T_116 = _T_90 & _T_38; // @[DecodeForwardUnit.scala 91:77]
  wire  _T_120 = ~(_T_18 & _T_30); // @[DecodeForwardUnit.scala 95:11]
  wire  _T_121 = _T_116 & _T_120; // @[DecodeForwardUnit.scala 93:81]
  wire  _T_123 = _T_121 & _T_107; // @[DecodeForwardUnit.scala 95:83]
  wire  _T_131 = _T_90 & _T_48; // @[DecodeForwardUnit.scala 101:77]
  wire  _T_135 = ~_T_100; // @[DecodeForwardUnit.scala 105:11]
  wire  _T_136 = _T_131 & _T_135; // @[DecodeForwardUnit.scala 103:81]
  wire  _T_138 = _T_136 & _T_105; // @[DecodeForwardUnit.scala 105:83]
  wire  _T_141 = _T_88 & io_MEM_WB_MEMRD; // @[DecodeForwardUnit.scala 110:52]
  wire  _T_148 = _T_88 & io_MEM_WB_MEMRD & _T_26; // @[DecodeForwardUnit.scala 110:79]
  wire  _T_155 = _T_148 & _T_103; // @[DecodeForwardUnit.scala 112:114]
  wire  _T_157 = _T_155 & _T_105; // @[DecodeForwardUnit.scala 114:117]
  wire  _T_167 = _T_141 & _T_38; // @[DecodeForwardUnit.scala 121:77]
  wire  _T_172 = _T_167 & _T_120; // @[DecodeForwardUnit.scala 123:81]
  wire  _T_174 = _T_172 & _T_107; // @[DecodeForwardUnit.scala 125:83]
  wire  _T_182 = _T_141 & _T_48; // @[DecodeForwardUnit.scala 131:77]
  wire  _T_187 = _T_182 & _T_135; // @[DecodeForwardUnit.scala 133:81]
  wire  _T_189 = _T_187 & _T_105; // @[DecodeForwardUnit.scala 135:82]
  wire [2:0] _GEN_16 = _T_189 ? 3'h5 : _GEN_14; // @[DecodeForwardUnit.scala 136:45 DecodeForwardUnit.scala 138:26]
  wire [2:0] _GEN_17 = _T_174 ? 3'h5 : _GEN_15; // @[DecodeForwardUnit.scala 126:45 DecodeForwardUnit.scala 128:26]
  wire [2:0] _GEN_18 = _T_174 ? _GEN_14 : _GEN_16; // @[DecodeForwardUnit.scala 126:45]
  wire [2:0] _GEN_19 = _T_157 & _T_107 ? 3'h5 : _GEN_18; // @[DecodeForwardUnit.scala 115:79 DecodeForwardUnit.scala 117:24]
  wire [2:0] _GEN_20 = _T_157 & _T_107 ? 3'h5 : _GEN_17; // @[DecodeForwardUnit.scala 115:79 DecodeForwardUnit.scala 118:24]
  wire [2:0] _GEN_21 = _T_138 ? 3'h3 : _GEN_19; // @[DecodeForwardUnit.scala 106:45 DecodeForwardUnit.scala 108:26]
  wire [2:0] _GEN_22 = _T_138 ? _GEN_15 : _GEN_20; // @[DecodeForwardUnit.scala 106:45]
  wire [2:0] _GEN_23 = _T_123 ? 3'h3 : _GEN_22; // @[DecodeForwardUnit.scala 96:45 DecodeForwardUnit.scala 98:26]
  wire [2:0] _GEN_24 = _T_123 ? _GEN_14 : _GEN_21; // @[DecodeForwardUnit.scala 96:45]
  wire [2:0] _GEN_25 = _T_106 & io_MEM_WB_REGRD == io_rs2_sel ? 3'h3 : _GEN_24; // @[DecodeForwardUnit.scala 85:79 DecodeForwardUnit.scala 87:24]
  wire [2:0] _GEN_26 = _T_106 & io_MEM_WB_REGRD == io_rs2_sel ? 3'h3 : _GEN_23; // @[DecodeForwardUnit.scala 85:79 DecodeForwardUnit.scala 88:24]
  wire [2:0] _GEN_27 = io_execute_regwrite & _T_1 & _T_2 & _T_4 ? 3'h6 : 3'h0; // @[DecodeForwardUnit.scala 146:136 DecodeForwardUnit.scala 147:26 DecodeForwardUnit.scala 23:20]
  wire  _T_200 = io_mem_regwrite & _T_18; // @[DecodeForwardUnit.scala 151:38]
  wire  _T_207 = io_mem_regwrite & _T_18 & _T_19 & _T_48; // @[DecodeForwardUnit.scala 151:99]
  wire  _T_209 = _T_207 & _T_28; // @[DecodeForwardUnit.scala 152:81]
  wire  _T_219 = _T_200 & io_EX_MEM_MEMRD & _T_48; // @[DecodeForwardUnit.scala 158:106]
  wire  _T_221 = _T_219 & _T_28; // @[DecodeForwardUnit.scala 159:83]
  wire [3:0] _GEN_28 = _T_221 ? 4'h9 : {{1'd0}, _GEN_27}; // @[DecodeForwardUnit.scala 160:47 DecodeForwardUnit.scala 162:28]
  wire [3:0] _GEN_29 = _T_209 ? 4'h7 : _GEN_28; // @[DecodeForwardUnit.scala 153:45 DecodeForwardUnit.scala 155:26]
  wire  _T_224 = io_wb_regwrite & _T_88; // @[DecodeForwardUnit.scala 168:37]
  wire  _T_231 = io_wb_regwrite & _T_88 & _T_89 & _T_48; // @[DecodeForwardUnit.scala 168:98]
  wire  _T_236 = _T_231 & _T_135; // @[DecodeForwardUnit.scala 170:81]
  wire  _T_238 = _T_236 & _T_105; // @[DecodeForwardUnit.scala 172:83]
  wire  _T_248 = _T_224 & io_MEM_WB_MEMRD & _T_48; // @[DecodeForwardUnit.scala 178:106]
  wire  _T_253 = _T_248 & _T_135; // @[DecodeForwardUnit.scala 180:81]
  wire  _T_255 = _T_253 & _T_105; // @[DecodeForwardUnit.scala 182:83]
  wire [3:0] _GEN_30 = _T_255 ? 4'ha : _GEN_29; // @[DecodeForwardUnit.scala 183:45 DecodeForwardUnit.scala 185:26]
  wire [3:0] _GEN_31 = _T_238 ? 4'h8 : _GEN_30; // @[DecodeForwardUnit.scala 173:45 DecodeForwardUnit.scala 175:26]
  wire [3:0] _GEN_32 = ~io_ctrl_branch ? _GEN_31 : 4'h0; // @[DecodeForwardUnit.scala 144:41 DecodeForwardUnit.scala 23:20]
  wire [2:0] _GEN_34 = io_ctrl_branch ? _GEN_26 : 3'h0; // @[DecodeForwardUnit.scala 27:34 DecodeForwardUnit.scala 24:20]
  assign io_forward_rs1 = io_ctrl_branch ? {{1'd0}, _GEN_25} : _GEN_32; // @[DecodeForwardUnit.scala 27:34]
  assign io_forward_rs2 = {{1'd0}, _GEN_34}; // @[DecodeForwardUnit.scala 27:34 DecodeForwardUnit.scala 24:20]
endmodule
module BranchLogic(
  input  [31:0] io_in_rs1,
  input  [31:0] io_in_rs2,
  input  [2:0]  io_in_func3,
  output        io_output
);
  wire  _T_1 = $signed(io_in_rs1) == $signed(io_in_rs2); // @[BranchLogic.scala 15:20]
  wire  _T_3 = $signed(io_in_rs1) != $signed(io_in_rs2); // @[BranchLogic.scala 22:20]
  wire  _T_5 = $signed(io_in_rs1) < $signed(io_in_rs2); // @[BranchLogic.scala 29:20]
  wire  _T_7 = $signed(io_in_rs1) >= $signed(io_in_rs2); // @[BranchLogic.scala 36:20]
  wire  _T_11 = io_in_rs1 < io_in_rs2; // @[BranchLogic.scala 43:27]
  wire  _T_15 = io_in_rs1 >= io_in_rs2; // @[BranchLogic.scala 50:27]
  wire  _GEN_6 = io_in_func3 == 3'h7 & _T_15; // @[BranchLogic.scala 48:41 BranchLogic.scala 56:15]
  wire  _GEN_7 = io_in_func3 == 3'h6 ? _T_11 : _GEN_6; // @[BranchLogic.scala 41:41]
  wire  _GEN_8 = io_in_func3 == 3'h5 ? _T_7 : _GEN_7; // @[BranchLogic.scala 34:41]
  wire  _GEN_9 = io_in_func3 == 3'h4 ? _T_5 : _GEN_8; // @[BranchLogic.scala 27:41]
  wire  _GEN_10 = io_in_func3 == 3'h1 ? _T_3 : _GEN_9; // @[BranchLogic.scala 20:41]
  assign io_output = io_in_func3 == 3'h0 ? _T_1 : _GEN_10; // @[BranchLogic.scala 13:34]
endmodule
module RegisterFile(
  input         clock,
  input         reset,
  input         io_regWrite,
  input  [4:0]  io_rd_sel,
  input  [4:0]  io_rs1_sel,
  input  [4:0]  io_rs2_sel,
  input  [31:0] io_writeData,
  output [31:0] io_rs1,
  output [31:0] io_rs2
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] registers_0; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_1; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_2; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_3; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_4; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_5; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_6; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_7; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_8; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_9; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_10; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_11; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_12; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_13; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_14; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_15; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_16; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_17; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_18; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_19; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_20; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_21; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_22; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_23; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_24; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_25; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_26; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_27; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_28; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_29; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_30; // @[RegisterFile.scala 20:28]
  reg [31:0] registers_31; // @[RegisterFile.scala 20:28]
  wire [31:0] _GEN_1 = 5'h1 == io_rs1_sel ? $signed(registers_1) : $signed(registers_0); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_2 = 5'h2 == io_rs1_sel ? $signed(registers_2) : $signed(_GEN_1); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_3 = 5'h3 == io_rs1_sel ? $signed(registers_3) : $signed(_GEN_2); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_4 = 5'h4 == io_rs1_sel ? $signed(registers_4) : $signed(_GEN_3); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_5 = 5'h5 == io_rs1_sel ? $signed(registers_5) : $signed(_GEN_4); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_6 = 5'h6 == io_rs1_sel ? $signed(registers_6) : $signed(_GEN_5); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_7 = 5'h7 == io_rs1_sel ? $signed(registers_7) : $signed(_GEN_6); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_8 = 5'h8 == io_rs1_sel ? $signed(registers_8) : $signed(_GEN_7); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_9 = 5'h9 == io_rs1_sel ? $signed(registers_9) : $signed(_GEN_8); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_10 = 5'ha == io_rs1_sel ? $signed(registers_10) : $signed(_GEN_9); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_11 = 5'hb == io_rs1_sel ? $signed(registers_11) : $signed(_GEN_10); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_12 = 5'hc == io_rs1_sel ? $signed(registers_12) : $signed(_GEN_11); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_13 = 5'hd == io_rs1_sel ? $signed(registers_13) : $signed(_GEN_12); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_14 = 5'he == io_rs1_sel ? $signed(registers_14) : $signed(_GEN_13); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_15 = 5'hf == io_rs1_sel ? $signed(registers_15) : $signed(_GEN_14); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_16 = 5'h10 == io_rs1_sel ? $signed(registers_16) : $signed(_GEN_15); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_17 = 5'h11 == io_rs1_sel ? $signed(registers_17) : $signed(_GEN_16); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_18 = 5'h12 == io_rs1_sel ? $signed(registers_18) : $signed(_GEN_17); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_19 = 5'h13 == io_rs1_sel ? $signed(registers_19) : $signed(_GEN_18); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_20 = 5'h14 == io_rs1_sel ? $signed(registers_20) : $signed(_GEN_19); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_21 = 5'h15 == io_rs1_sel ? $signed(registers_21) : $signed(_GEN_20); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_22 = 5'h16 == io_rs1_sel ? $signed(registers_22) : $signed(_GEN_21); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_23 = 5'h17 == io_rs1_sel ? $signed(registers_23) : $signed(_GEN_22); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_24 = 5'h18 == io_rs1_sel ? $signed(registers_24) : $signed(_GEN_23); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_25 = 5'h19 == io_rs1_sel ? $signed(registers_25) : $signed(_GEN_24); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_26 = 5'h1a == io_rs1_sel ? $signed(registers_26) : $signed(_GEN_25); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_27 = 5'h1b == io_rs1_sel ? $signed(registers_27) : $signed(_GEN_26); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_28 = 5'h1c == io_rs1_sel ? $signed(registers_28) : $signed(_GEN_27); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_29 = 5'h1d == io_rs1_sel ? $signed(registers_29) : $signed(_GEN_28); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_30 = 5'h1e == io_rs1_sel ? $signed(registers_30) : $signed(_GEN_29); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  wire [31:0] _GEN_33 = 5'h1 == io_rs2_sel ? $signed(registers_1) : $signed(registers_0); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_34 = 5'h2 == io_rs2_sel ? $signed(registers_2) : $signed(_GEN_33); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_35 = 5'h3 == io_rs2_sel ? $signed(registers_3) : $signed(_GEN_34); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_36 = 5'h4 == io_rs2_sel ? $signed(registers_4) : $signed(_GEN_35); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_37 = 5'h5 == io_rs2_sel ? $signed(registers_5) : $signed(_GEN_36); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_38 = 5'h6 == io_rs2_sel ? $signed(registers_6) : $signed(_GEN_37); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_39 = 5'h7 == io_rs2_sel ? $signed(registers_7) : $signed(_GEN_38); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_40 = 5'h8 == io_rs2_sel ? $signed(registers_8) : $signed(_GEN_39); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_41 = 5'h9 == io_rs2_sel ? $signed(registers_9) : $signed(_GEN_40); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_42 = 5'ha == io_rs2_sel ? $signed(registers_10) : $signed(_GEN_41); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_43 = 5'hb == io_rs2_sel ? $signed(registers_11) : $signed(_GEN_42); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_44 = 5'hc == io_rs2_sel ? $signed(registers_12) : $signed(_GEN_43); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_45 = 5'hd == io_rs2_sel ? $signed(registers_13) : $signed(_GEN_44); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_46 = 5'he == io_rs2_sel ? $signed(registers_14) : $signed(_GEN_45); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_47 = 5'hf == io_rs2_sel ? $signed(registers_15) : $signed(_GEN_46); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_48 = 5'h10 == io_rs2_sel ? $signed(registers_16) : $signed(_GEN_47); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_49 = 5'h11 == io_rs2_sel ? $signed(registers_17) : $signed(_GEN_48); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_50 = 5'h12 == io_rs2_sel ? $signed(registers_18) : $signed(_GEN_49); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_51 = 5'h13 == io_rs2_sel ? $signed(registers_19) : $signed(_GEN_50); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_52 = 5'h14 == io_rs2_sel ? $signed(registers_20) : $signed(_GEN_51); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_53 = 5'h15 == io_rs2_sel ? $signed(registers_21) : $signed(_GEN_52); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_54 = 5'h16 == io_rs2_sel ? $signed(registers_22) : $signed(_GEN_53); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_55 = 5'h17 == io_rs2_sel ? $signed(registers_23) : $signed(_GEN_54); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_56 = 5'h18 == io_rs2_sel ? $signed(registers_24) : $signed(_GEN_55); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_57 = 5'h19 == io_rs2_sel ? $signed(registers_25) : $signed(_GEN_56); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_58 = 5'h1a == io_rs2_sel ? $signed(registers_26) : $signed(_GEN_57); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_59 = 5'h1b == io_rs2_sel ? $signed(registers_27) : $signed(_GEN_58); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_60 = 5'h1c == io_rs2_sel ? $signed(registers_28) : $signed(_GEN_59); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_61 = 5'h1d == io_rs2_sel ? $signed(registers_29) : $signed(_GEN_60); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  wire [31:0] _GEN_62 = 5'h1e == io_rs2_sel ? $signed(registers_30) : $signed(_GEN_61); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  assign io_rs1 = 5'h1f == io_rs1_sel ? $signed(registers_31) : $signed(_GEN_30); // @[RegisterFile.scala 25:12 RegisterFile.scala 25:12]
  assign io_rs2 = 5'h1f == io_rs2_sel ? $signed(registers_31) : $signed(_GEN_62); // @[RegisterFile.scala 26:12 RegisterFile.scala 26:12]
  always @(posedge clock) begin
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_0 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        registers_0 <= 32'sh0;
      end else if (5'h0 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_0 <= io_writeData; // @[RegisterFile.scala 31:34]
      end else begin
        registers_0 <= 32'sh0; // @[RegisterFile.scala 24:18]
      end
    end else begin
      registers_0 <= 32'sh0; // @[RegisterFile.scala 24:18]
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_1 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h1 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_1 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h1 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_1 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_2 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h2 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_2 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h2 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_2 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_3 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h3 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_3 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h3 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_3 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_4 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h4 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_4 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h4 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_4 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_5 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h5 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_5 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h5 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_5 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_6 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h6 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_6 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h6 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_6 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_7 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h7 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_7 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h7 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_7 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_8 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h8 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_8 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h8 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_8 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_9 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h9 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_9 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h9 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_9 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_10 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'ha == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_10 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'ha == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_10 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_11 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'hb == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_11 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'hb == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_11 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_12 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'hc == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_12 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'hc == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_12 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_13 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'hd == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_13 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'hd == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_13 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_14 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'he == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_14 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'he == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_14 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_15 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'hf == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_15 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'hf == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_15 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_16 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h10 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_16 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h10 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_16 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_17 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h11 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_17 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h11 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_17 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_18 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h12 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_18 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h12 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_18 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_19 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h13 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_19 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h13 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_19 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_20 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h14 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_20 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h14 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_20 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_21 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h15 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_21 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h15 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_21 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_22 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h16 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_22 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h16 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_22 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_23 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h17 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_23 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h17 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_23 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_24 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h18 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_24 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h18 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_24 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_25 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h19 == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_25 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h19 == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_25 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_26 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h1a == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_26 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h1a == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_26 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_27 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h1b == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_27 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h1b == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_27 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_28 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h1c == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_28 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h1c == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_28 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_29 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h1d == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_29 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h1d == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_29 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_30 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h1e == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_30 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h1e == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_30 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
    if (reset) begin // @[RegisterFile.scala 20:28]
      registers_31 <= 32'sh0; // @[RegisterFile.scala 20:28]
    end else if (io_regWrite) begin // @[RegisterFile.scala 27:55]
      if (io_rd_sel == 5'h0) begin // @[RegisterFile.scala 28:40]
        if (5'h1f == io_rd_sel) begin // @[RegisterFile.scala 29:34]
          registers_31 <= 32'sh0; // @[RegisterFile.scala 29:34]
        end
      end else if (5'h1f == io_rd_sel) begin // @[RegisterFile.scala 31:34]
        registers_31 <= io_writeData; // @[RegisterFile.scala 31:34]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  registers_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  registers_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  registers_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  registers_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  registers_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  registers_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  registers_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  registers_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  registers_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  registers_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  registers_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  registers_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  registers_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  registers_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  registers_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  registers_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  registers_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  registers_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  registers_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  registers_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  registers_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  registers_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  registers_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  registers_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  registers_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  registers_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  registers_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  registers_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  registers_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  registers_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  registers_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  registers_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ImmediateGeneration(
  input  [31:0] io_instruction,
  input  [31:0] io_pc,
  output [31:0] io_s_imm,
  output [31:0] io_sb_imm,
  output [31:0] io_u_imm,
  output [31:0] io_uj_imm,
  output [31:0] io_i_imm
);
  wire [4:0] s_lower_half = io_instruction[11:7]; // @[ImmediateGeneration.scala 19:38]
  wire [6:0] s_upper_half = io_instruction[31:25]; // @[ImmediateGeneration.scala 20:38]
  wire [11:0] s_imm_12 = {s_upper_half,s_lower_half}; // @[Cat.scala 30:58]
  wire [19:0] hi = s_imm_12[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [3:0] sb_lower_half = io_instruction[11:8]; // @[ImmediateGeneration.scala 28:39]
  wire [5:0] sb_upper_half = io_instruction[30:25]; // @[ImmediateGeneration.scala 29:39]
  wire  sb_11thbit = io_instruction[7]; // @[ImmediateGeneration.scala 30:36]
  wire  sb_12thbit = io_instruction[31]; // @[ImmediateGeneration.scala 31:36]
  wire [12:0] sb_imm_13 = {sb_12thbit,sb_11thbit,sb_upper_half,sb_lower_half,1'h0}; // @[Cat.scala 30:58]
  wire [18:0] hi_2 = sb_imm_13[12] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 72:12]
  wire [31:0] sb_imm_32 = {hi_2,sb_12thbit,sb_11thbit,sb_upper_half,sb_lower_half,1'h0}; // @[ImmediateGeneration.scala 33:61]
  wire [19:0] u_imm_20 = io_instruction[31:12]; // @[ImmediateGeneration.scala 39:34]
  wire [11:0] hi_3 = u_imm_20[19] ? 12'hfff : 12'h0; // @[Bitwise.scala 72:12]
  wire [31:0] u_imm_32 = {hi_3,u_imm_20}; // @[Cat.scala 30:58]
  wire [43:0] _GEN_0 = {u_imm_32, 12'h0}; // @[ImmediateGeneration.scala 42:37]
  wire [46:0] _T_11 = {{3'd0}, _GEN_0}; // @[ImmediateGeneration.scala 43:34]
  wire [9:0] uj_lower_half = io_instruction[30:21]; // @[ImmediateGeneration.scala 48:39]
  wire  uj_11thbit = io_instruction[20]; // @[ImmediateGeneration.scala 49:36]
  wire [7:0] uj_upper_half = io_instruction[19:12]; // @[ImmediateGeneration.scala 50:39]
  wire [20:0] uj_imm_21 = {sb_12thbit,uj_upper_half,uj_11thbit,uj_lower_half,1'h0}; // @[Cat.scala 30:58]
  wire [10:0] hi_5 = uj_imm_21[20] ? 11'h7ff : 11'h0; // @[Bitwise.scala 72:12]
  wire [31:0] uj_imm_32 = {hi_5,sb_12thbit,uj_upper_half,uj_11thbit,uj_lower_half,1'h0}; // @[ImmediateGeneration.scala 53:61]
  wire [11:0] i_imm_12 = io_instruction[31:20]; // @[ImmediateGeneration.scala 59:34]
  wire [19:0] hi_6 = i_imm_12[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  assign io_s_imm = {hi,s_upper_half,s_lower_half}; // @[ImmediateGeneration.scala 23:26]
  assign io_sb_imm = $signed(sb_imm_32) + $signed(io_pc); // @[ImmediateGeneration.scala 34:28]
  assign io_u_imm = _T_11[31:0]; // @[ImmediateGeneration.scala 43:14]
  assign io_uj_imm = $signed(uj_imm_32) + $signed(io_pc); // @[ImmediateGeneration.scala 54:28]
  assign io_i_imm = {hi_6,i_imm_12}; // @[ImmediateGeneration.scala 61:26]
endmodule
module StructuralDetector(
  input  [4:0] io_rs1_sel,
  input  [4:0] io_rs2_sel,
  input        io_MEM_WB_regWr,
  input  [4:0] io_MEM_WB_REGRD,
  input  [6:0] io_inst_op_in,
  output       io_fwd_rs1,
  output       io_fwd_rs2
);
  wire  _T_2 = io_MEM_WB_regWr & io_MEM_WB_REGRD != 5'h0; // @[StructuralDetector.scala 27:32]
  wire  _T_5 = io_inst_op_in != 7'h37; // @[StructuralDetector.scala 27:118]
  assign io_fwd_rs1 = io_MEM_WB_regWr & io_MEM_WB_REGRD != 5'h0 & io_MEM_WB_REGRD == io_rs1_sel & io_inst_op_in != 7'h37
    ; // @[StructuralDetector.scala 27:101]
  assign io_fwd_rs2 = _T_2 & io_MEM_WB_REGRD == io_rs2_sel & _T_5; // @[StructuralDetector.scala 33:101]
endmodule
module Jalr(
  input  [31:0] io_input_a,
  input  [31:0] io_input_b,
  output [31:0] io_output
);
  wire [31:0] sum = $signed(io_input_a) + $signed(io_input_b); // @[Jalr.scala 12:26]
  wire [32:0] _GEN_0 = {{1{sum[31]}},sum}; // @[Jalr.scala 13:22]
  wire [32:0] _T_3 = $signed(_GEN_0) & 33'shfffffffe; // @[Jalr.scala 13:22]
  assign io_output = _T_3[31:0]; // @[Jalr.scala 13:15]
endmodule
module CsrPrimitive(
  input        clock,
  input        reset,
  input  [5:0] io_i_wrdata,
  input        io_i_wr_en,
  output [5:0] io_o_rd_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] rdata_q; // @[CsrPrimitive.scala 13:24]
  assign io_o_rd_data = rdata_q; // @[CsrPrimitive.scala 18:16]
  always @(posedge clock) begin
    if (reset) begin // @[CsrPrimitive.scala 13:24]
      rdata_q <= 6'hd; // @[CsrPrimitive.scala 13:24]
    end else if (io_i_wr_en) begin // @[CsrPrimitive.scala 15:3]
      rdata_q <= io_i_wrdata; // @[CsrPrimitive.scala 16:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rdata_q = _RAND_0[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CsrPrimitive_1(
  input         clock,
  input         reset,
  input  [31:0] io_i_wrdata,
  input         io_i_wr_en,
  output [31:0] io_o_rd_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] rdata_q; // @[CsrPrimitive.scala 13:24]
  assign io_o_rd_data = rdata_q; // @[CsrPrimitive.scala 18:16]
  always @(posedge clock) begin
    if (reset) begin // @[CsrPrimitive.scala 13:24]
      rdata_q <= 32'h0; // @[CsrPrimitive.scala 13:24]
    end else if (io_i_wr_en) begin // @[CsrPrimitive.scala 15:3]
      rdata_q <= io_i_wrdata; // @[CsrPrimitive.scala 16:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rdata_q = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CsrPrimitive_2(
  input        clock,
  input        reset,
  input  [2:0] io_i_wrdata,
  input        io_i_wr_en,
  output [2:0] io_o_rd_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] rdata_q; // @[CsrPrimitive.scala 13:24]
  assign io_o_rd_data = rdata_q; // @[CsrPrimitive.scala 18:16]
  always @(posedge clock) begin
    if (reset) begin // @[CsrPrimitive.scala 13:24]
      rdata_q <= 3'h4; // @[CsrPrimitive.scala 13:24]
    end else if (io_i_wr_en) begin // @[CsrPrimitive.scala 15:3]
      rdata_q <= io_i_wrdata; // @[CsrPrimitive.scala 16:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rdata_q = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CsrPrimitive_4(
  input        clock,
  input        reset,
  input  [5:0] io_i_wrdata,
  input        io_i_wr_en,
  output [5:0] io_o_rd_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] rdata_q; // @[CsrPrimitive.scala 13:24]
  assign io_o_rd_data = rdata_q; // @[CsrPrimitive.scala 18:16]
  always @(posedge clock) begin
    if (reset) begin // @[CsrPrimitive.scala 13:24]
      rdata_q <= 6'h0; // @[CsrPrimitive.scala 13:24]
    end else if (io_i_wr_en) begin // @[CsrPrimitive.scala 15:3]
      rdata_q <= io_i_wrdata; // @[CsrPrimitive.scala 16:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rdata_q = _RAND_0[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CsrPrimitive_6(
  input         clock,
  input         reset,
  input  [31:0] io_i_wrdata,
  input         io_i_wr_en,
  output [31:0] io_o_rd_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] rdata_q; // @[CsrPrimitive.scala 13:24]
  assign io_o_rd_data = rdata_q; // @[CsrPrimitive.scala 18:16]
  always @(posedge clock) begin
    if (reset) begin // @[CsrPrimitive.scala 13:24]
      rdata_q <= 32'h1; // @[CsrPrimitive.scala 13:24]
    end else if (io_i_wr_en) begin // @[CsrPrimitive.scala 15:3]
      rdata_q <= io_i_wrdata; // @[CsrPrimitive.scala 16:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rdata_q = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CsrPrimitive_7(
  input         clock,
  input         reset,
  input  [27:0] io_i_wrdata,
  input         io_i_wr_en,
  output [27:0] io_o_rd_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [27:0] rdata_q; // @[CsrPrimitive.scala 13:24]
  assign io_o_rd_data = rdata_q; // @[CsrPrimitive.scala 18:16]
  always @(posedge clock) begin
    if (reset) begin // @[CsrPrimitive.scala 13:24]
      rdata_q <= 28'h0; // @[CsrPrimitive.scala 13:24]
    end else if (io_i_wr_en) begin // @[CsrPrimitive.scala 15:3]
      rdata_q <= io_i_wrdata; // @[CsrPrimitive.scala 16:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rdata_q = _RAND_0[27:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BrqCounter(
  input         clock,
  input         reset,
  input         io_i_counter_inc,
  input         io_i_counterh_we,
  input         io_i_counter_we,
  input  [31:0] io_i_counter_val,
  output [63:0] io_o_counter_val
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  we = io_i_counter_we | io_i_counterh_we; // @[BrqCounter.scala 27:35]
  reg [63:0] counter_q; // @[BrqCounter.scala 57:26]
  wire [31:0] counter_msb = io_i_counterh_we ? io_i_counter_val : counter_q[63:32]; // @[BrqCounter.scala 34:3 BrqCounter.scala 35:17 BrqCounter.scala 30:16]
  wire [31:0] counter_lsb = io_i_counterh_we ? counter_q[31:0] : io_i_counter_val; // @[BrqCounter.scala 34:3 BrqCounter.scala 36:18 BrqCounter.scala 31:16]
  wire [63:0] counter_load = {counter_msb,counter_lsb}; // @[Cat.scala 30:58]
  wire [63:0] counter_upd = counter_q + 64'h1; // @[BrqCounter.scala 41:47]
  assign io_o_counter_val = counter_q; // @[BrqCounter.scala 16:21 BrqCounter.scala 72:13]
  always @(posedge clock) begin
    if (reset) begin // @[BrqCounter.scala 57:26]
      counter_q <= 64'h0; // @[BrqCounter.scala 57:26]
    end else if (we) begin // @[BrqCounter.scala 45:3]
      counter_q <= counter_load; // @[BrqCounter.scala 46:15]
    end else if (io_i_counter_inc) begin // @[BrqCounter.scala 49:5]
      counter_q <= counter_upd; // @[BrqCounter.scala 50:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  counter_q = _RAND_0[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BrqCounter_2(
  input         clock,
  input         reset,
  input         io_i_counter_inc,
  input         io_i_counterh_we,
  input         io_i_counter_we,
  input  [31:0] io_i_counter_val,
  output [63:0] io_o_counter_val
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  we = io_i_counter_we | io_i_counterh_we; // @[BrqCounter.scala 27:35]
  reg [39:0] counter_q; // @[BrqCounter.scala 57:26]
  wire [79:0] _T_1 = {40'h0,counter_q}; // @[Cat.scala 30:58]
  wire [63:0] counter = _T_1[63:0]; // @[BrqCounter.scala 16:21 BrqCounter.scala 28:16]
  wire [31:0] counter_msb = io_i_counterh_we ? io_i_counter_val : counter[63:32]; // @[BrqCounter.scala 34:3 BrqCounter.scala 35:17 BrqCounter.scala 30:16]
  wire [31:0] counter_lsb = io_i_counterh_we ? counter[31:0] : io_i_counter_val; // @[BrqCounter.scala 34:3 BrqCounter.scala 36:18 BrqCounter.scala 31:16]
  wire [63:0] counter_load = {counter_msb,counter_lsb}; // @[Cat.scala 30:58]
  wire [39:0] counter_upd = counter[39:0] + 40'h1; // @[BrqCounter.scala 41:47]
  assign io_o_counter_val = _T_1[63:0]; // @[BrqCounter.scala 16:21 BrqCounter.scala 28:16]
  always @(posedge clock) begin
    if (reset) begin // @[BrqCounter.scala 57:26]
      counter_q <= 40'h0; // @[BrqCounter.scala 57:26]
    end else if (we) begin // @[BrqCounter.scala 45:3]
      counter_q <= counter_load[39:0]; // @[BrqCounter.scala 46:15]
    end else if (io_i_counter_inc) begin // @[BrqCounter.scala 49:5]
      counter_q <= counter_upd; // @[BrqCounter.scala 50:17]
    end else begin
      counter_q <= counter[39:0]; // @[BrqCounter.scala 54:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  counter_q = _RAND_0[39:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CsrRegisterFile(
  input         clock,
  input         reset,
  output [31:0] io_o_csr_mtvec,
  input         io_i_csr_access,
  input  [11:0] io_i_csr_addr,
  input  [31:0] io_i_csr_wdata,
  input  [1:0]  io_i_csr_op,
  input         io_i_csr_op_en,
  output [31:0] io_o_csr_rdata,
  output        io_o_irq_pending,
  output [2:0]  io_o_irqs,
  output        io_o_csr_mstatus_mie,
  output [31:0] io_o_csr_mepc,
  input  [31:0] io_i_pc_if,
  input         io_i_csr_save_if,
  input         io_i_csr_restore_mret,
  input         io_i_csr_save_cause,
  input  [5:0]  io_i_csr_mcause,
  output        io_o_illegal_csr_insn
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [63:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [63:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [63:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [63:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
  reg [63:0] _RAND_32;
  reg [63:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
`endif // RANDOMIZE_REG_INIT
  wire  PRIM_MSTATUS_clock; // @[CsrRegisterFile.scala 647:28]
  wire  PRIM_MSTATUS_reset; // @[CsrRegisterFile.scala 647:28]
  wire [5:0] PRIM_MSTATUS_io_i_wrdata; // @[CsrRegisterFile.scala 647:28]
  wire  PRIM_MSTATUS_io_i_wr_en; // @[CsrRegisterFile.scala 647:28]
  wire [5:0] PRIM_MSTATUS_io_o_rd_data; // @[CsrRegisterFile.scala 647:28]
  wire  PRIM_MEPC_clock; // @[CsrRegisterFile.scala 653:25]
  wire  PRIM_MEPC_reset; // @[CsrRegisterFile.scala 653:25]
  wire [31:0] PRIM_MEPC_io_i_wrdata; // @[CsrRegisterFile.scala 653:25]
  wire  PRIM_MEPC_io_i_wr_en; // @[CsrRegisterFile.scala 653:25]
  wire [31:0] PRIM_MEPC_io_o_rd_data; // @[CsrRegisterFile.scala 653:25]
  wire  PRIM_MIE_clock; // @[CsrRegisterFile.scala 664:24]
  wire  PRIM_MIE_reset; // @[CsrRegisterFile.scala 664:24]
  wire [2:0] PRIM_MIE_io_i_wrdata; // @[CsrRegisterFile.scala 664:24]
  wire  PRIM_MIE_io_i_wr_en; // @[CsrRegisterFile.scala 664:24]
  wire [2:0] PRIM_MIE_io_o_rd_data; // @[CsrRegisterFile.scala 664:24]
  wire  PRIM_MSCRATCH_clock; // @[CsrRegisterFile.scala 671:29]
  wire  PRIM_MSCRATCH_reset; // @[CsrRegisterFile.scala 671:29]
  wire [31:0] PRIM_MSCRATCH_io_i_wrdata; // @[CsrRegisterFile.scala 671:29]
  wire  PRIM_MSCRATCH_io_i_wr_en; // @[CsrRegisterFile.scala 671:29]
  wire [31:0] PRIM_MSCRATCH_io_o_rd_data; // @[CsrRegisterFile.scala 671:29]
  wire  PRIM_MCAUSE_clock; // @[CsrRegisterFile.scala 678:27]
  wire  PRIM_MCAUSE_reset; // @[CsrRegisterFile.scala 678:27]
  wire [5:0] PRIM_MCAUSE_io_i_wrdata; // @[CsrRegisterFile.scala 678:27]
  wire  PRIM_MCAUSE_io_i_wr_en; // @[CsrRegisterFile.scala 678:27]
  wire [5:0] PRIM_MCAUSE_io_o_rd_data; // @[CsrRegisterFile.scala 678:27]
  wire  PRIM_MTVAL_clock; // @[CsrRegisterFile.scala 684:26]
  wire  PRIM_MTVAL_reset; // @[CsrRegisterFile.scala 684:26]
  wire [31:0] PRIM_MTVAL_io_i_wrdata; // @[CsrRegisterFile.scala 684:26]
  wire  PRIM_MTVAL_io_i_wr_en; // @[CsrRegisterFile.scala 684:26]
  wire [31:0] PRIM_MTVAL_io_o_rd_data; // @[CsrRegisterFile.scala 684:26]
  wire  PRIM_MTVEC_clock; // @[CsrRegisterFile.scala 691:26]
  wire  PRIM_MTVEC_reset; // @[CsrRegisterFile.scala 691:26]
  wire [31:0] PRIM_MTVEC_io_i_wrdata; // @[CsrRegisterFile.scala 691:26]
  wire  PRIM_MTVEC_io_i_wr_en; // @[CsrRegisterFile.scala 691:26]
  wire [31:0] PRIM_MTVEC_io_o_rd_data; // @[CsrRegisterFile.scala 691:26]
  wire  PRIM_DCSR_clock; // @[CsrRegisterFile.scala 701:25]
  wire  PRIM_DCSR_reset; // @[CsrRegisterFile.scala 701:25]
  wire [27:0] PRIM_DCSR_io_i_wrdata; // @[CsrRegisterFile.scala 701:25]
  wire  PRIM_DCSR_io_i_wr_en; // @[CsrRegisterFile.scala 701:25]
  wire [27:0] PRIM_DCSR_io_o_rd_data; // @[CsrRegisterFile.scala 701:25]
  wire  PRIM_DEPC_clock; // @[CsrRegisterFile.scala 708:25]
  wire  PRIM_DEPC_reset; // @[CsrRegisterFile.scala 708:25]
  wire [31:0] PRIM_DEPC_io_i_wrdata; // @[CsrRegisterFile.scala 708:25]
  wire  PRIM_DEPC_io_i_wr_en; // @[CsrRegisterFile.scala 708:25]
  wire [31:0] PRIM_DEPC_io_o_rd_data; // @[CsrRegisterFile.scala 708:25]
  wire  PRIM_DSCRATCH0_clock; // @[CsrRegisterFile.scala 714:30]
  wire  PRIM_DSCRATCH0_reset; // @[CsrRegisterFile.scala 714:30]
  wire [31:0] PRIM_DSCRATCH0_io_i_wrdata; // @[CsrRegisterFile.scala 714:30]
  wire  PRIM_DSCRATCH0_io_i_wr_en; // @[CsrRegisterFile.scala 714:30]
  wire [31:0] PRIM_DSCRATCH0_io_o_rd_data; // @[CsrRegisterFile.scala 714:30]
  wire  PRIM_DSCRATCH1_clock; // @[CsrRegisterFile.scala 721:30]
  wire  PRIM_DSCRATCH1_reset; // @[CsrRegisterFile.scala 721:30]
  wire [31:0] PRIM_DSCRATCH1_io_i_wrdata; // @[CsrRegisterFile.scala 721:30]
  wire  PRIM_DSCRATCH1_io_i_wr_en; // @[CsrRegisterFile.scala 721:30]
  wire [31:0] PRIM_DSCRATCH1_io_o_rd_data; // @[CsrRegisterFile.scala 721:30]
  wire  COUNT_MCYCLE_clock; // @[CsrRegisterFile.scala 777:28]
  wire  COUNT_MCYCLE_reset; // @[CsrRegisterFile.scala 777:28]
  wire  COUNT_MCYCLE_io_i_counter_inc; // @[CsrRegisterFile.scala 777:28]
  wire  COUNT_MCYCLE_io_i_counterh_we; // @[CsrRegisterFile.scala 777:28]
  wire  COUNT_MCYCLE_io_i_counter_we; // @[CsrRegisterFile.scala 777:28]
  wire [31:0] COUNT_MCYCLE_io_i_counter_val; // @[CsrRegisterFile.scala 777:28]
  wire [63:0] COUNT_MCYCLE_io_o_counter_val; // @[CsrRegisterFile.scala 777:28]
  wire  COUNT_MINSTRET_clock; // @[CsrRegisterFile.scala 785:30]
  wire  COUNT_MINSTRET_reset; // @[CsrRegisterFile.scala 785:30]
  wire  COUNT_MINSTRET_io_i_counter_inc; // @[CsrRegisterFile.scala 785:30]
  wire  COUNT_MINSTRET_io_i_counterh_we; // @[CsrRegisterFile.scala 785:30]
  wire  COUNT_MINSTRET_io_i_counter_we; // @[CsrRegisterFile.scala 785:30]
  wire [31:0] COUNT_MINSTRET_io_i_counter_val; // @[CsrRegisterFile.scala 785:30]
  wire [63:0] COUNT_MINSTRET_io_o_counter_val; // @[CsrRegisterFile.scala 785:30]
  wire  BrqCounter_clock; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_reset; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_io_i_counter_inc; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_io_i_counterh_we; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_io_i_counter_we; // @[CsrRegisterFile.scala 797:26]
  wire [31:0] BrqCounter_io_i_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire [63:0] BrqCounter_io_o_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_1_clock; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_1_reset; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_1_io_i_counter_inc; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_1_io_i_counterh_we; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_1_io_i_counter_we; // @[CsrRegisterFile.scala 797:26]
  wire [31:0] BrqCounter_1_io_i_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire [63:0] BrqCounter_1_io_o_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_2_clock; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_2_reset; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_2_io_i_counter_inc; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_2_io_i_counterh_we; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_2_io_i_counter_we; // @[CsrRegisterFile.scala 797:26]
  wire [31:0] BrqCounter_2_io_i_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire [63:0] BrqCounter_2_io_o_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_3_clock; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_3_reset; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_3_io_i_counter_inc; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_3_io_i_counterh_we; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_3_io_i_counter_we; // @[CsrRegisterFile.scala 797:26]
  wire [31:0] BrqCounter_3_io_i_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire [63:0] BrqCounter_3_io_o_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_4_clock; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_4_reset; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_4_io_i_counter_inc; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_4_io_i_counterh_we; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_4_io_i_counter_we; // @[CsrRegisterFile.scala 797:26]
  wire [31:0] BrqCounter_4_io_i_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire [63:0] BrqCounter_4_io_o_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_5_clock; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_5_reset; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_5_io_i_counter_inc; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_5_io_i_counterh_we; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_5_io_i_counter_we; // @[CsrRegisterFile.scala 797:26]
  wire [31:0] BrqCounter_5_io_i_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire [63:0] BrqCounter_5_io_o_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_6_clock; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_6_reset; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_6_io_i_counter_inc; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_6_io_i_counterh_we; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_6_io_i_counter_we; // @[CsrRegisterFile.scala 797:26]
  wire [31:0] BrqCounter_6_io_i_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire [63:0] BrqCounter_6_io_o_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_7_clock; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_7_reset; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_7_io_i_counter_inc; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_7_io_i_counterh_we; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_7_io_i_counter_we; // @[CsrRegisterFile.scala 797:26]
  wire [31:0] BrqCounter_7_io_i_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire [63:0] BrqCounter_7_io_o_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_8_clock; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_8_reset; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_8_io_i_counter_inc; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_8_io_i_counterh_we; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_8_io_i_counter_we; // @[CsrRegisterFile.scala 797:26]
  wire [31:0] BrqCounter_8_io_i_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire [63:0] BrqCounter_8_io_o_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_9_clock; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_9_reset; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_9_io_i_counter_inc; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_9_io_i_counterh_we; // @[CsrRegisterFile.scala 797:26]
  wire  BrqCounter_9_io_i_counter_we; // @[CsrRegisterFile.scala 797:26]
  wire [31:0] BrqCounter_9_io_i_counter_val; // @[CsrRegisterFile.scala 797:26]
  wire [63:0] BrqCounter_9_io_o_counter_val; // @[CsrRegisterFile.scala 797:26]
  reg [1:0] priv_lvl_q; // @[CsrRegisterFile.scala 100:27]
  reg [12:0] mcountinhibit_q; // @[CsrRegisterFile.scala 133:49]
  reg [63:0] mhpmcounter_0; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_1; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_2; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_3; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_4; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_5; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_6; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_7; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_8; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_9; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_10; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_11; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_12; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_13; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_14; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_15; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_16; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_17; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_18; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_19; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_20; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_21; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_22; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_23; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_24; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_25; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_26; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_27; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_28; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_29; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_30; // @[CsrRegisterFile.scala 137:49]
  reg [63:0] mhpmcounter_31; // @[CsrRegisterFile.scala 137:49]
  reg [31:0] mhpmevent_0; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_1; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_2; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_3; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_4; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_5; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_6; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_7; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_8; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_9; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_10; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_11; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_12; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_13; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_14; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_15; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_16; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_17; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_18; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_19; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_20; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_21; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_22; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_23; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_24; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_25; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_26; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_27; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_28; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_29; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_30; // @[CsrRegisterFile.scala 142:49]
  reg [31:0] mhpmevent_31; // @[CsrRegisterFile.scala 142:49]
  wire  illegal_csr_priv = io_i_csr_addr[9:8] > priv_lvl_q; // @[CsrRegisterFile.scala 201:43]
  wire  _T_458 = io_i_csr_op == 2'h1; // @[CsrRegisterFile.scala 618:47]
  wire  _T_459 = io_i_csr_op == 2'h2; // @[CsrRegisterFile.scala 618:89]
  wire  _T_461 = io_i_csr_op == 2'h3; // @[CsrRegisterFile.scala 618:129]
  wire  csr_wreq = io_i_csr_op_en & (io_i_csr_op == 2'h1 | io_i_csr_op == 2'h2 | io_i_csr_op == 2'h3); // @[CsrRegisterFile.scala 618:31]
  wire  illegal_csr_write = io_i_csr_addr[11:10] == 2'h3 & csr_wreq; // @[CsrRegisterFile.scala 203:60]
  wire  _T_34 = io_i_csr_addr == 12'hf14; // @[CsrRegisterFile.scala 218:22]
  wire  _T_35 = io_i_csr_addr == 12'h300; // @[CsrRegisterFile.scala 223:29]
  wire  _T_37 = io_i_csr_addr == 12'h301; // @[CsrRegisterFile.scala 231:29]
  wire  _T_38 = io_i_csr_addr == 12'h304; // @[CsrRegisterFile.scala 236:29]
  wire  _T_40 = io_i_csr_addr == 12'h340; // @[CsrRegisterFile.scala 244:29]
  wire  _T_41 = io_i_csr_addr == 12'h305; // @[CsrRegisterFile.scala 250:29]
  wire  _T_42 = io_i_csr_addr == 12'h341; // @[CsrRegisterFile.scala 259:29]
  wire  _T_43 = io_i_csr_addr == 12'h342; // @[CsrRegisterFile.scala 265:29]
  wire  _T_45 = io_i_csr_addr == 12'h343; // @[CsrRegisterFile.scala 272:29]
  wire  _T_46 = io_i_csr_addr == 12'h344; // @[CsrRegisterFile.scala 277:29]
  wire  _T_48 = io_i_csr_addr == 12'h7b0; // @[CsrRegisterFile.scala 285:29]
  wire  _T_50 = 1'h1; // @[CsrRegisterFile.scala 288:24]
  wire  _T_51 = io_i_csr_addr == 12'h7b1; // @[CsrRegisterFile.scala 290:29]
  wire  _T_53 = io_i_csr_addr == 12'h7b2; // @[CsrRegisterFile.scala 295:29]
  wire  _T_54 = io_i_csr_addr == 12'h7b3; // @[CsrRegisterFile.scala 299:29]
  wire  _T_56 = io_i_csr_addr == 12'h320; // @[CsrRegisterFile.scala 305:29]
  wire  _T_64 = io_i_csr_addr == 12'h327; // @[CsrRegisterFile.scala 311:22]
  wire  _T_65 = io_i_csr_addr == 12'h323 | io_i_csr_addr == 12'h324 | io_i_csr_addr == 12'h325 | io_i_csr_addr == 12'h326
     | _T_64; // @[CsrRegisterFile.scala 310:201]
  wire  _T_72 = io_i_csr_addr == 12'h32b; // @[CsrRegisterFile.scala 312:22]
  wire  _T_73 = _T_65 | io_i_csr_addr == 12'h328 | io_i_csr_addr == 12'h329 | io_i_csr_addr == 12'h32a | _T_72; // @[CsrRegisterFile.scala 311:193]
  wire  _T_80 = io_i_csr_addr == 12'h32f; // @[CsrRegisterFile.scala 313:22]
  wire  _T_81 = _T_73 | io_i_csr_addr == 12'h32c | io_i_csr_addr == 12'h32d | io_i_csr_addr == 12'h32e | _T_80; // @[CsrRegisterFile.scala 312:193]
  wire  _T_88 = io_i_csr_addr == 12'h333; // @[CsrRegisterFile.scala 314:22]
  wire  _T_89 = _T_81 | io_i_csr_addr == 12'h330 | io_i_csr_addr == 12'h331 | io_i_csr_addr == 12'h332 | _T_88; // @[CsrRegisterFile.scala 313:193]
  wire  _T_96 = io_i_csr_addr == 12'h337; // @[CsrRegisterFile.scala 315:22]
  wire  _T_97 = _T_89 | io_i_csr_addr == 12'h334 | io_i_csr_addr == 12'h335 | io_i_csr_addr == 12'h336 | _T_96; // @[CsrRegisterFile.scala 314:193]
  wire  _T_104 = io_i_csr_addr == 12'h33b; // @[CsrRegisterFile.scala 316:22]
  wire  _T_105 = _T_97 | io_i_csr_addr == 12'h338 | io_i_csr_addr == 12'h339 | io_i_csr_addr == 12'h33a | _T_104; // @[CsrRegisterFile.scala 315:193]
  wire  _T_112 = io_i_csr_addr == 12'h33f; // @[CsrRegisterFile.scala 317:22]
  wire  _T_113 = _T_105 | io_i_csr_addr == 12'h33c | io_i_csr_addr == 12'h33d | io_i_csr_addr == 12'h33e | _T_112; // @[CsrRegisterFile.scala 316:193]
  wire  _T_121 = io_i_csr_addr == 12'hb05; // @[CsrRegisterFile.scala 322:22]
  wire  _T_122 = io_i_csr_addr == 12'hb00 | io_i_csr_addr == 12'hb02 | io_i_csr_addr == 12'hb03 | io_i_csr_addr == 12'hb04
     | _T_121; // @[CsrRegisterFile.scala 321:209]
  wire  _T_129 = io_i_csr_addr == 12'hb09; // @[CsrRegisterFile.scala 323:22]
  wire  _T_130 = _T_122 | io_i_csr_addr == 12'hb06 | io_i_csr_addr == 12'hb07 | io_i_csr_addr == 12'hb08 | _T_129; // @[CsrRegisterFile.scala 322:201]
  wire  _T_137 = io_i_csr_addr == 12'hb0d; // @[CsrRegisterFile.scala 324:22]
  wire  _T_138 = _T_130 | io_i_csr_addr == 12'hb0a | io_i_csr_addr == 12'hb0b | io_i_csr_addr == 12'hb0c | _T_137; // @[CsrRegisterFile.scala 323:201]
  wire  _T_145 = io_i_csr_addr == 12'hb11; // @[CsrRegisterFile.scala 325:22]
  wire  _T_146 = _T_138 | io_i_csr_addr == 12'hb0e | io_i_csr_addr == 12'hb0f | io_i_csr_addr == 12'hb10 | _T_145; // @[CsrRegisterFile.scala 324:201]
  wire  _T_153 = io_i_csr_addr == 12'hb15; // @[CsrRegisterFile.scala 326:22]
  wire  _T_154 = _T_146 | io_i_csr_addr == 12'hb12 | io_i_csr_addr == 12'hb13 | io_i_csr_addr == 12'hb14 | _T_153; // @[CsrRegisterFile.scala 325:201]
  wire  _T_161 = io_i_csr_addr == 12'hb19; // @[CsrRegisterFile.scala 327:22]
  wire  _T_162 = _T_154 | io_i_csr_addr == 12'hb16 | io_i_csr_addr == 12'hb17 | io_i_csr_addr == 12'hb18 | _T_161; // @[CsrRegisterFile.scala 326:201]
  wire  _T_169 = io_i_csr_addr == 12'hb1d; // @[CsrRegisterFile.scala 328:22]
  wire  _T_170 = _T_162 | io_i_csr_addr == 12'hb1a | io_i_csr_addr == 12'hb1b | io_i_csr_addr == 12'hb1c | _T_169; // @[CsrRegisterFile.scala 327:201]
  wire  _T_174 = _T_170 | io_i_csr_addr == 12'hb1e | io_i_csr_addr == 12'hb1f; // @[CsrRegisterFile.scala 328:103]
  wire  _T_183 = io_i_csr_addr == 12'hb85; // @[CsrRegisterFile.scala 335:22]
  wire  _T_184 = io_i_csr_addr == 12'hb80 | io_i_csr_addr == 12'hb82 | io_i_csr_addr == 12'hb83 | io_i_csr_addr == 12'hb84
     | _T_183; // @[CsrRegisterFile.scala 334:213]
  wire  _T_191 = io_i_csr_addr == 12'hb89; // @[CsrRegisterFile.scala 336:22]
  wire  _T_192 = _T_184 | io_i_csr_addr == 12'hb86 | io_i_csr_addr == 12'hb87 | io_i_csr_addr == 12'hb88 | _T_191; // @[CsrRegisterFile.scala 335:205]
  wire  _T_199 = io_i_csr_addr == 12'hb8d; // @[CsrRegisterFile.scala 337:22]
  wire  _T_200 = _T_192 | io_i_csr_addr == 12'hb8a | io_i_csr_addr == 12'hb8b | io_i_csr_addr == 12'hb8c | _T_199; // @[CsrRegisterFile.scala 336:205]
  wire  _T_207 = io_i_csr_addr == 12'hb91; // @[CsrRegisterFile.scala 338:22]
  wire  _T_208 = _T_200 | io_i_csr_addr == 12'hb8e | io_i_csr_addr == 12'hb8f | io_i_csr_addr == 12'hb90 | _T_207; // @[CsrRegisterFile.scala 337:205]
  wire  _T_215 = io_i_csr_addr == 12'hb95; // @[CsrRegisterFile.scala 339:22]
  wire  _T_216 = _T_208 | io_i_csr_addr == 12'hb92 | io_i_csr_addr == 12'hb93 | io_i_csr_addr == 12'hb94 | _T_215; // @[CsrRegisterFile.scala 338:205]
  wire  _T_223 = io_i_csr_addr == 12'hb99; // @[CsrRegisterFile.scala 340:22]
  wire  _T_224 = _T_216 | io_i_csr_addr == 12'hb96 | io_i_csr_addr == 12'hb97 | io_i_csr_addr == 12'hb98 | _T_223; // @[CsrRegisterFile.scala 339:205]
  wire  _T_231 = io_i_csr_addr == 12'hb9d; // @[CsrRegisterFile.scala 341:22]
  wire  _T_232 = _T_224 | io_i_csr_addr == 12'hb9a | io_i_csr_addr == 12'hb9b | io_i_csr_addr == 12'hb9c | _T_231; // @[CsrRegisterFile.scala 340:205]
  wire  _T_236 = _T_232 | io_i_csr_addr == 12'hb9e | io_i_csr_addr == 12'hb9f; // @[CsrRegisterFile.scala 341:105]
  wire  _T_238 = io_i_csr_addr == 12'h7a0; // @[CsrRegisterFile.scala 348:29]
  wire  _T_240 = io_i_csr_addr == 12'h7a1; // @[CsrRegisterFile.scala 353:29]
  wire  _T_242 = io_i_csr_addr == 12'h7a2; // @[CsrRegisterFile.scala 358:29]
  wire  _T_244 = io_i_csr_addr == 12'h7a3; // @[CsrRegisterFile.scala 363:29]
  wire  _T_246 = io_i_csr_addr == 12'h7a8; // @[CsrRegisterFile.scala 368:29]
  wire  _GEN_67 = _T_246 ? 1'h0 : 1'h1; // @[CsrRegisterFile.scala 369:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_69 = _T_244 | _GEN_67; // @[CsrRegisterFile.scala 364:5 CsrRegisterFile.scala 366:21]
  wire  _GEN_71 = _T_242 | _GEN_69; // @[CsrRegisterFile.scala 359:5 CsrRegisterFile.scala 361:21]
  wire  _GEN_73 = _T_240 | _GEN_71; // @[CsrRegisterFile.scala 354:5 CsrRegisterFile.scala 356:21]
  wire  _GEN_75 = _T_238 | _GEN_73; // @[CsrRegisterFile.scala 349:5 CsrRegisterFile.scala 351:21]
  wire  _GEN_77 = _T_236 ? 1'h0 : _GEN_75; // @[CsrRegisterFile.scala 342:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_79 = _T_174 ? 1'h0 : _GEN_77; // @[CsrRegisterFile.scala 329:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_81 = _T_113 ? 1'h0 : _GEN_79; // @[CsrRegisterFile.scala 318:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_83 = _T_56 ? 1'h0 : _GEN_81; // @[CsrRegisterFile.scala 306:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_85 = _T_54 | _GEN_83; // @[CsrRegisterFile.scala 300:5 CsrRegisterFile.scala 302:21]
  wire  _GEN_87 = _T_53 ? 1'h0 : _GEN_85; // @[CsrRegisterFile.scala 296:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_89 = _T_51 | _GEN_87; // @[CsrRegisterFile.scala 291:5 CsrRegisterFile.scala 293:21]
  wire  _GEN_91 = _T_48 | _GEN_89; // @[CsrRegisterFile.scala 286:5 CsrRegisterFile.scala 288:21]
  wire  _GEN_93 = _T_46 ? 1'h0 : _GEN_91; // @[CsrRegisterFile.scala 278:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_95 = _T_45 ? 1'h0 : _GEN_93; // @[CsrRegisterFile.scala 273:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_97 = _T_43 ? 1'h0 : _GEN_95; // @[CsrRegisterFile.scala 266:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_99 = _T_42 ? 1'h0 : _GEN_97; // @[CsrRegisterFile.scala 260:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_101 = _T_41 ? 1'h0 : _GEN_99; // @[CsrRegisterFile.scala 251:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_103 = _T_40 ? 1'h0 : _GEN_101; // @[CsrRegisterFile.scala 245:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_105 = _T_38 ? 1'h0 : _GEN_103; // @[CsrRegisterFile.scala 237:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_107 = _T_37 ? 1'h0 : _GEN_105; // @[CsrRegisterFile.scala 232:5 CsrRegisterFile.scala 215:17]
  wire  _GEN_109 = _T_35 ? 1'h0 : _GEN_107; // @[CsrRegisterFile.scala 224:5 CsrRegisterFile.scala 215:17]
  wire  illegal_csr = _T_34 ? 1'h0 : _GEN_109; // @[CsrRegisterFile.scala 219:3 CsrRegisterFile.scala 215:17]
  wire [5:0] _WIRE_15 = PRIM_MSTATUS_io_o_rd_data;
  wire  mstatus_q_mie = _WIRE_15[0]; // @[CsrRegisterFile.scala 650:56]
  wire  mstatus_q_mpie = _WIRE_15[1]; // @[CsrRegisterFile.scala 650:56]
  wire [10:0] lo = {3'h0,_WIRE_15[1],3'h0,_WIRE_15[0],3'h0}; // @[Cat.scala 30:58]
  wire  mstatus_q_mprv = _WIRE_15[4]; // @[CsrRegisterFile.scala 650:56]
  wire [1:0] mstatus_q_mpp = _WIRE_15[3:2]; // @[CsrRegisterFile.scala 650:56]
  wire  mstatus_q_tw = _WIRE_15[5]; // @[CsrRegisterFile.scala 650:56]
  wire [31:0] _T_36 = {10'h0,_WIRE_15[5],3'h0,_WIRE_15[4],4'h0,_WIRE_15[3:2],lo}; // @[Cat.scala 30:58]
  wire [2:0] _WIRE_17 = PRIM_MIE_io_o_rd_data;
  wire  mie_q_irq_software = _WIRE_17[0]; // @[CsrRegisterFile.scala 667:43]
  wire  mie_q_irq_timer = _WIRE_17[1]; // @[CsrRegisterFile.scala 667:43]
  wire  mie_q_irq_external = _WIRE_17[2]; // @[CsrRegisterFile.scala 667:43]
  wire [31:0] _T_39 = {20'h0,_WIRE_17[2],3'h0,_WIRE_17[1],3'h0,_WIRE_17[0],3'h0}; // @[Cat.scala 30:58]
  wire [5:0] mcause_q = PRIM_MCAUSE_io_o_rd_data; // @[CsrRegisterFile.scala 113:46 CsrRegisterFile.scala 681:28]
  wire  hi_hi_2 = mcause_q[5]; // @[CsrRegisterFile.scala 270:36]
  wire [4:0] lo_2 = mcause_q[4:0]; // @[CsrRegisterFile.scala 270:63]
  wire [31:0] _T_44 = {hi_hi_2,26'h0,lo_2}; // @[Cat.scala 30:58]
  wire  mip_irq_software = 1'h0;
  wire  mip_irq_timer = 1'h0;
  wire  mip_irq_external = 1'h0;
  wire [31:0] _T_47 = {20'h0,mip_irq_software,3'h0,mip_irq_software,3'h0,mip_irq_software,3'h0}; // @[Cat.scala 30:58]
  wire [27:0] _WIRE_19 = PRIM_DCSR_io_o_rd_data;
  wire  dcsr_q_nmip = _WIRE_19[2]; // @[CsrRegisterFile.scala 704:60]
  wire  dcsr_q_step = _WIRE_19[1]; // @[CsrRegisterFile.scala 704:60]
  wire  dcsr_q_prv = _WIRE_19[0]; // @[CsrRegisterFile.scala 704:60]
  wire  dcsr_q_zero0 = _WIRE_19[4]; // @[CsrRegisterFile.scala 704:60]
  wire  dcsr_q_mprven = _WIRE_19[3]; // @[CsrRegisterFile.scala 704:60]
  wire  dcsr_q_stoptime = _WIRE_19[6]; // @[CsrRegisterFile.scala 704:60]
  wire  dcsr_q_cause = _WIRE_19[5]; // @[CsrRegisterFile.scala 704:60]
  wire [6:0] lo_4 = {_WIRE_19[6],_WIRE_19[5],_WIRE_19[4],_WIRE_19[3],_WIRE_19[2],_WIRE_19[1],_WIRE_19[0]}; // @[CsrRegisterFile.scala 287:31]
  wire  dcsr_q_ebreaks = _WIRE_19[9]; // @[CsrRegisterFile.scala 704:60]
  wire  dcsr_q_stepie = _WIRE_19[8]; // @[CsrRegisterFile.scala 704:60]
  wire  dcsr_q_stopcount = _WIRE_19[7]; // @[CsrRegisterFile.scala 704:60]
  wire  dcsr_q_ebreakm = _WIRE_19[11]; // @[CsrRegisterFile.scala 704:60]
  wire  dcsr_q_zero1 = _WIRE_19[10]; // @[CsrRegisterFile.scala 704:60]
  wire [3:0] dcsr_q_xdebugver = _WIRE_19[27:24]; // @[CsrRegisterFile.scala 704:60]
  wire [11:0] dcsr_q_zero2 = _WIRE_19[23:12]; // @[CsrRegisterFile.scala 704:60]
  wire [27:0] _T_49 = {_WIRE_19[27:24],_WIRE_19[23:12],_WIRE_19[11],_WIRE_19[10],_WIRE_19[9],_WIRE_19[8],_WIRE_19[7],
    lo_4}; // @[CsrRegisterFile.scala 287:31]
  wire [4:0] mhpmcounter_idx = io_i_csr_addr[4:0]; // @[CsrRegisterFile.scala 175:30]
  wire [31:0] _GEN_1 = 5'h1 == mhpmcounter_idx ? mhpmevent_1 : mhpmevent_0; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_2 = 5'h2 == mhpmcounter_idx ? mhpmevent_2 : _GEN_1; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_3 = 5'h3 == mhpmcounter_idx ? mhpmevent_3 : _GEN_2; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_4 = 5'h4 == mhpmcounter_idx ? mhpmevent_4 : _GEN_3; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_5 = 5'h5 == mhpmcounter_idx ? mhpmevent_5 : _GEN_4; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_6 = 5'h6 == mhpmcounter_idx ? mhpmevent_6 : _GEN_5; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_7 = 5'h7 == mhpmcounter_idx ? mhpmevent_7 : _GEN_6; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_8 = 5'h8 == mhpmcounter_idx ? mhpmevent_8 : _GEN_7; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_9 = 5'h9 == mhpmcounter_idx ? mhpmevent_9 : _GEN_8; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_10 = 5'ha == mhpmcounter_idx ? mhpmevent_10 : _GEN_9; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_11 = 5'hb == mhpmcounter_idx ? mhpmevent_11 : _GEN_10; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_12 = 5'hc == mhpmcounter_idx ? mhpmevent_12 : _GEN_11; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_13 = 5'hd == mhpmcounter_idx ? mhpmevent_13 : _GEN_12; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_14 = 5'he == mhpmcounter_idx ? mhpmevent_14 : _GEN_13; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_15 = 5'hf == mhpmcounter_idx ? mhpmevent_15 : _GEN_14; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_16 = 5'h10 == mhpmcounter_idx ? mhpmevent_16 : _GEN_15; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_17 = 5'h11 == mhpmcounter_idx ? mhpmevent_17 : _GEN_16; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_18 = 5'h12 == mhpmcounter_idx ? mhpmevent_18 : _GEN_17; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_19 = 5'h13 == mhpmcounter_idx ? mhpmevent_19 : _GEN_18; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_20 = 5'h14 == mhpmcounter_idx ? mhpmevent_20 : _GEN_19; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_21 = 5'h15 == mhpmcounter_idx ? mhpmevent_21 : _GEN_20; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_22 = 5'h16 == mhpmcounter_idx ? mhpmevent_22 : _GEN_21; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_23 = 5'h17 == mhpmcounter_idx ? mhpmevent_23 : _GEN_22; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_24 = 5'h18 == mhpmcounter_idx ? mhpmevent_24 : _GEN_23; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_25 = 5'h19 == mhpmcounter_idx ? mhpmevent_25 : _GEN_24; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_26 = 5'h1a == mhpmcounter_idx ? mhpmevent_26 : _GEN_25; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_27 = 5'h1b == mhpmcounter_idx ? mhpmevent_27 : _GEN_26; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_28 = 5'h1c == mhpmcounter_idx ? mhpmevent_28 : _GEN_27; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_29 = 5'h1d == mhpmcounter_idx ? mhpmevent_29 : _GEN_28; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_30 = 5'h1e == mhpmcounter_idx ? mhpmevent_30 : _GEN_29; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [31:0] _GEN_31 = 5'h1f == mhpmcounter_idx ? mhpmevent_31 : _GEN_30; // @[CsrRegisterFile.scala 319:21 CsrRegisterFile.scala 319:21]
  wire [63:0] _GEN_33 = 5'h1 == mhpmcounter_idx ? mhpmcounter_1 : mhpmcounter_0; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_34 = 5'h2 == mhpmcounter_idx ? mhpmcounter_2 : _GEN_33; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_35 = 5'h3 == mhpmcounter_idx ? mhpmcounter_3 : _GEN_34; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_36 = 5'h4 == mhpmcounter_idx ? mhpmcounter_4 : _GEN_35; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_37 = 5'h5 == mhpmcounter_idx ? mhpmcounter_5 : _GEN_36; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_38 = 5'h6 == mhpmcounter_idx ? mhpmcounter_6 : _GEN_37; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_39 = 5'h7 == mhpmcounter_idx ? mhpmcounter_7 : _GEN_38; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_40 = 5'h8 == mhpmcounter_idx ? mhpmcounter_8 : _GEN_39; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_41 = 5'h9 == mhpmcounter_idx ? mhpmcounter_9 : _GEN_40; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_42 = 5'ha == mhpmcounter_idx ? mhpmcounter_10 : _GEN_41; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_43 = 5'hb == mhpmcounter_idx ? mhpmcounter_11 : _GEN_42; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_44 = 5'hc == mhpmcounter_idx ? mhpmcounter_12 : _GEN_43; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_45 = 5'hd == mhpmcounter_idx ? mhpmcounter_13 : _GEN_44; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_46 = 5'he == mhpmcounter_idx ? mhpmcounter_14 : _GEN_45; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_47 = 5'hf == mhpmcounter_idx ? mhpmcounter_15 : _GEN_46; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_48 = 5'h10 == mhpmcounter_idx ? mhpmcounter_16 : _GEN_47; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_49 = 5'h11 == mhpmcounter_idx ? mhpmcounter_17 : _GEN_48; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_50 = 5'h12 == mhpmcounter_idx ? mhpmcounter_18 : _GEN_49; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_51 = 5'h13 == mhpmcounter_idx ? mhpmcounter_19 : _GEN_50; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_52 = 5'h14 == mhpmcounter_idx ? mhpmcounter_20 : _GEN_51; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_53 = 5'h15 == mhpmcounter_idx ? mhpmcounter_21 : _GEN_52; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_54 = 5'h16 == mhpmcounter_idx ? mhpmcounter_22 : _GEN_53; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_55 = 5'h17 == mhpmcounter_idx ? mhpmcounter_23 : _GEN_54; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_56 = 5'h18 == mhpmcounter_idx ? mhpmcounter_24 : _GEN_55; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_57 = 5'h19 == mhpmcounter_idx ? mhpmcounter_25 : _GEN_56; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_58 = 5'h1a == mhpmcounter_idx ? mhpmcounter_26 : _GEN_57; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_59 = 5'h1b == mhpmcounter_idx ? mhpmcounter_27 : _GEN_58; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_60 = 5'h1c == mhpmcounter_idx ? mhpmcounter_28 : _GEN_59; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_61 = 5'h1d == mhpmcounter_idx ? mhpmcounter_29 : _GEN_60; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_62 = 5'h1e == mhpmcounter_idx ? mhpmcounter_30 : _GEN_61; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [63:0] _GEN_63 = 5'h1f == mhpmcounter_idx ? mhpmcounter_31 : _GEN_62; // @[CsrRegisterFile.scala 331:11 CsrRegisterFile.scala 331:11]
  wire [31:0] tmatch_value_rdata = 32'h0; // @[CsrRegisterFile.scala 149:36 CsrRegisterFile.scala 894:26]
  wire [31:0] _GEN_76 = _T_236 ? _GEN_63[63:32] : 32'h0; // @[CsrRegisterFile.scala 342:5 CsrRegisterFile.scala 345:21]
  wire [31:0] _GEN_78 = _T_174 ? _GEN_63[31:0] : _GEN_76; // @[CsrRegisterFile.scala 329:5 CsrRegisterFile.scala 332:21]
  wire [31:0] _GEN_80 = _T_113 ? _GEN_31 : _GEN_78; // @[CsrRegisterFile.scala 318:5 CsrRegisterFile.scala 319:21]
  wire [31:0] mcountinhibit = {19'h1,mcountinhibit_q}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_82 = _T_56 ? mcountinhibit : _GEN_80; // @[CsrRegisterFile.scala 306:5 CsrRegisterFile.scala 308:21]
  wire [31:0] dscratch1_q = PRIM_DSCRATCH1_io_o_rd_data; // @[CsrRegisterFile.scala 125:46 CsrRegisterFile.scala 724:31]
  wire [31:0] _GEN_84 = _T_54 ? dscratch1_q : _GEN_82; // @[CsrRegisterFile.scala 300:5 CsrRegisterFile.scala 301:21]
  wire [31:0] dscratch0_q = PRIM_DSCRATCH0_io_o_rd_data; // @[CsrRegisterFile.scala 124:46 CsrRegisterFile.scala 717:31]
  wire [31:0] _GEN_86 = _T_53 ? dscratch0_q : _GEN_84; // @[CsrRegisterFile.scala 296:5 CsrRegisterFile.scala 297:21]
  wire [31:0] depc_q = PRIM_DEPC_io_o_rd_data; // @[CsrRegisterFile.scala 122:46 CsrRegisterFile.scala 711:26]
  wire [31:0] _GEN_88 = _T_51 ? depc_q : _GEN_86; // @[CsrRegisterFile.scala 291:5 CsrRegisterFile.scala 292:21]
  wire [31:0] _GEN_90 = _T_48 ? {{4'd0}, _T_49} : _GEN_88; // @[CsrRegisterFile.scala 286:5 CsrRegisterFile.scala 287:21]
  wire [31:0] _GEN_92 = _T_46 ? _T_47 : _GEN_90; // @[CsrRegisterFile.scala 278:5 CsrRegisterFile.scala 280:21]
  wire [31:0] mtval_q = PRIM_MTVAL_io_o_rd_data; // @[CsrRegisterFile.scala 115:46 CsrRegisterFile.scala 687:27]
  wire [31:0] _GEN_94 = _T_45 ? mtval_q : _GEN_92; // @[CsrRegisterFile.scala 273:5 CsrRegisterFile.scala 275:21]
  wire [31:0] _GEN_96 = _T_43 ? _T_44 : _GEN_94; // @[CsrRegisterFile.scala 266:5 CsrRegisterFile.scala 270:21]
  wire [31:0] mepc_q = PRIM_MEPC_io_o_rd_data; // @[CsrRegisterFile.scala 110:46 CsrRegisterFile.scala 656:26]
  wire [31:0] _GEN_98 = _T_42 ? mepc_q : _GEN_96; // @[CsrRegisterFile.scala 260:5 CsrRegisterFile.scala 263:21]
  wire [31:0] mtvec_q = PRIM_MTVEC_io_o_rd_data; // @[CsrRegisterFile.scala 117:46 CsrRegisterFile.scala 694:27]
  wire [31:0] _GEN_100 = _T_41 ? mtvec_q : _GEN_98; // @[CsrRegisterFile.scala 251:5 CsrRegisterFile.scala 257:21]
  wire [31:0] mscratch_q = PRIM_MSCRATCH_io_o_rd_data; // @[CsrRegisterFile.scala 108:46 CsrRegisterFile.scala 674:30]
  wire [31:0] _GEN_102 = _T_40 ? mscratch_q : _GEN_100; // @[CsrRegisterFile.scala 245:5 CsrRegisterFile.scala 248:21]
  wire [31:0] _GEN_104 = _T_38 ? _T_39 : _GEN_102; // @[CsrRegisterFile.scala 237:5 CsrRegisterFile.scala 239:21]
  wire [31:0] _GEN_106 = _T_37 ? 32'h40001100 : _GEN_104; // @[CsrRegisterFile.scala 232:5 CsrRegisterFile.scala 234:21]
  wire [31:0] _GEN_108 = _T_35 ? _T_36 : _GEN_106; // @[CsrRegisterFile.scala 224:5 CsrRegisterFile.scala 226:21]
  wire  csr_we_int = csr_wreq & ~io_o_illegal_csr_insn; // @[CsrRegisterFile.scala 393:26]
  wire  _T_257 = csr_we_int & _T_35; // @[CsrRegisterFile.scala 397:19]
  wire  _T_266 = _WIRE_15[3:2] != 2'h3 & _WIRE_15[3:2] != 2'h0; // @[CsrRegisterFile.scala 404:66]
  wire [31:0] _T_453 = io_i_csr_wdata | io_o_csr_rdata; // @[CsrRegisterFile.scala 603:39]
  wire [31:0] _T_455 = ~io_i_csr_wdata; // @[CsrRegisterFile.scala 607:24]
  wire [31:0] _T_456 = _T_455 & io_o_csr_rdata; // @[CsrRegisterFile.scala 607:40]
  wire [31:0] _GEN_371 = _T_461 ? _T_456 : io_i_csr_wdata; // @[CsrRegisterFile.scala 606:5 CsrRegisterFile.scala 607:21]
  wire [31:0] _GEN_372 = _T_459 ? _T_453 : _GEN_371; // @[CsrRegisterFile.scala 602:5 CsrRegisterFile.scala 603:21]
  wire [31:0] csr_wdata_int = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  wire [1:0] _GEN_112 = _T_266 ? 2'h3 : csr_wdata_int[12:11]; // @[CsrRegisterFile.scala 405:5 CsrRegisterFile.scala 406:21 CsrRegisterFile.scala 402:20]
  wire [1:0] _GEN_287 = _T_257 ? _GEN_112 : _WIRE_15[3:2]; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 180:18]
  wire [1:0] _GEN_356 = io_i_csr_save_cause ? priv_lvl_q : _GEN_287; // @[CsrRegisterFile.scala 509:3]
  wire [1:0] mstatus_d_mpp = io_i_csr_restore_mret ? 2'h3 : _GEN_356; // @[CsrRegisterFile.scala 561:5 CsrRegisterFile.scala 566:22]
  wire  _T_269 = csr_we_int & _T_38; // @[CsrRegisterFile.scala 410:26]
  wire  _T_271 = csr_we_int & _T_40; // @[CsrRegisterFile.scala 414:26]
  wire  _T_273 = csr_we_int & _T_42; // @[CsrRegisterFile.scala 418:26]
  wire  _T_275 = csr_we_int & _T_43; // @[CsrRegisterFile.scala 422:26]
  wire  _T_277 = csr_we_int & _T_45; // @[CsrRegisterFile.scala 426:26]
  wire  _T_279 = csr_we_int & _T_41; // @[CsrRegisterFile.scala 430:26]
  wire  _T_281 = csr_we_int & _T_48; // @[CsrRegisterFile.scala 434:26]
  wire [1:0] _GEN_329 = {{1'd0}, _WIRE_19[0]}; // @[CsrRegisterFile.scala 526:5 CsrRegisterFile.scala 529:21 CsrRegisterFile.scala 500:14]
  wire [1:0] _GEN_347 = io_i_csr_save_cause ? _GEN_329 : {{1'd0}, _WIRE_19[0]}; // @[CsrRegisterFile.scala 509:3 CsrRegisterFile.scala 500:14]
  wire  dcsr_d_prv = _GEN_347[0];
  wire  _T_304 = csr_we_int & _T_53; // @[CsrRegisterFile.scala 453:26]
  wire  _T_306 = csr_we_int & _T_54; // @[CsrRegisterFile.scala 457:26]
  wire  _T_308 = csr_we_int & _T_56; // @[CsrRegisterFile.scala 461:26]
  wire  _T_370 = csr_we_int & _T_174; // @[CsrRegisterFile.scala 465:26]
  wire [31:0] _T_371 = 32'h1 << mhpmcounter_idx; // @[CsrRegisterFile.scala 474:32]
  wire  _T_433 = csr_we_int & _T_236; // @[CsrRegisterFile.scala 476:26]
  wire [31:0] _GEN_114 = _T_433 ? _T_371 : 32'h0; // @[CsrRegisterFile.scala 484:5 CsrRegisterFile.scala 485:23 CsrRegisterFile.scala 194:20]
  wire [31:0] _GEN_115 = _T_370 ? _T_371 : 32'h0; // @[CsrRegisterFile.scala 473:5 CsrRegisterFile.scala 474:22 CsrRegisterFile.scala 193:20]
  wire [31:0] _GEN_116 = _T_370 ? 32'h0 : _GEN_114; // @[CsrRegisterFile.scala 473:5 CsrRegisterFile.scala 194:20]
  wire [31:0] _GEN_118 = _T_308 ? 32'h0 : _GEN_115; // @[CsrRegisterFile.scala 462:5 CsrRegisterFile.scala 193:20]
  wire [31:0] _GEN_119 = _T_308 ? 32'h0 : _GEN_116; // @[CsrRegisterFile.scala 462:5 CsrRegisterFile.scala 194:20]
  wire  _GEN_121 = _T_306 ? 1'h0 : _T_308; // @[CsrRegisterFile.scala 458:5 CsrRegisterFile.scala 192:20]
  wire [31:0] _GEN_122 = _T_306 ? 32'h0 : _GEN_118; // @[CsrRegisterFile.scala 458:5 CsrRegisterFile.scala 193:20]
  wire [31:0] _GEN_123 = _T_306 ? 32'h0 : _GEN_119; // @[CsrRegisterFile.scala 458:5 CsrRegisterFile.scala 194:20]
  wire  _GEN_125 = _T_304 ? 1'h0 : _T_306; // @[CsrRegisterFile.scala 454:5 CsrRegisterFile.scala 190:16]
  wire  _GEN_126 = _T_304 ? 1'h0 : _GEN_121; // @[CsrRegisterFile.scala 454:5 CsrRegisterFile.scala 192:20]
  wire [31:0] _GEN_127 = _T_304 ? 32'h0 : _GEN_122; // @[CsrRegisterFile.scala 454:5 CsrRegisterFile.scala 193:20]
  wire [31:0] _GEN_128 = _T_304 ? 32'h0 : _GEN_123; // @[CsrRegisterFile.scala 454:5 CsrRegisterFile.scala 194:20]
  wire  _GEN_144 = _T_281 ? 1'h0 : _T_304; // @[CsrRegisterFile.scala 435:5 CsrRegisterFile.scala 189:16]
  wire  _GEN_145 = _T_281 ? 1'h0 : _GEN_125; // @[CsrRegisterFile.scala 435:5 CsrRegisterFile.scala 190:16]
  wire  _GEN_146 = _T_281 ? 1'h0 : _GEN_126; // @[CsrRegisterFile.scala 435:5 CsrRegisterFile.scala 192:20]
  wire [31:0] _GEN_147 = _T_281 ? 32'h0 : _GEN_127; // @[CsrRegisterFile.scala 435:5 CsrRegisterFile.scala 193:20]
  wire [31:0] _GEN_148 = _T_281 ? 32'h0 : _GEN_128; // @[CsrRegisterFile.scala 435:5 CsrRegisterFile.scala 194:20]
  wire  _GEN_164 = _T_279 ? 1'h0 : _GEN_144; // @[CsrRegisterFile.scala 431:5 CsrRegisterFile.scala 189:16]
  wire  _GEN_165 = _T_279 ? 1'h0 : _GEN_145; // @[CsrRegisterFile.scala 431:5 CsrRegisterFile.scala 190:16]
  wire  _GEN_166 = _T_279 ? 1'h0 : _GEN_146; // @[CsrRegisterFile.scala 431:5 CsrRegisterFile.scala 192:20]
  wire [31:0] _GEN_167 = _T_279 ? 32'h0 : _GEN_147; // @[CsrRegisterFile.scala 431:5 CsrRegisterFile.scala 193:20]
  wire [31:0] _GEN_168 = _T_279 ? 32'h0 : _GEN_148; // @[CsrRegisterFile.scala 431:5 CsrRegisterFile.scala 194:20]
  wire  _GEN_185 = _T_277 ? 1'h0 : _GEN_164; // @[CsrRegisterFile.scala 427:5 CsrRegisterFile.scala 189:16]
  wire  _GEN_186 = _T_277 ? 1'h0 : _GEN_165; // @[CsrRegisterFile.scala 427:5 CsrRegisterFile.scala 190:16]
  wire  _GEN_187 = _T_277 ? 1'h0 : _GEN_166; // @[CsrRegisterFile.scala 427:5 CsrRegisterFile.scala 192:20]
  wire [31:0] _GEN_188 = _T_277 ? 32'h0 : _GEN_167; // @[CsrRegisterFile.scala 427:5 CsrRegisterFile.scala 193:20]
  wire [31:0] _GEN_189 = _T_277 ? 32'h0 : _GEN_168; // @[CsrRegisterFile.scala 427:5 CsrRegisterFile.scala 194:20]
  wire  _GEN_191 = _T_275 ? 1'h0 : _T_277; // @[CsrRegisterFile.scala 423:5 CsrRegisterFile.scala 187:14]
  wire  _GEN_207 = _T_275 ? 1'h0 : _GEN_185; // @[CsrRegisterFile.scala 423:5 CsrRegisterFile.scala 189:16]
  wire  _GEN_208 = _T_275 ? 1'h0 : _GEN_186; // @[CsrRegisterFile.scala 423:5 CsrRegisterFile.scala 190:16]
  wire  _GEN_209 = _T_275 ? 1'h0 : _GEN_187; // @[CsrRegisterFile.scala 423:5 CsrRegisterFile.scala 192:20]
  wire [31:0] _GEN_210 = _T_275 ? 32'h0 : _GEN_188; // @[CsrRegisterFile.scala 423:5 CsrRegisterFile.scala 193:20]
  wire [31:0] _GEN_211 = _T_275 ? 32'h0 : _GEN_189; // @[CsrRegisterFile.scala 423:5 CsrRegisterFile.scala 194:20]
  wire  _GEN_213 = _T_273 ? 1'h0 : _T_275; // @[CsrRegisterFile.scala 419:5 CsrRegisterFile.scala 186:14]
  wire  _GEN_214 = _T_273 ? 1'h0 : _GEN_191; // @[CsrRegisterFile.scala 419:5 CsrRegisterFile.scala 187:14]
  wire  _GEN_230 = _T_273 ? 1'h0 : _GEN_207; // @[CsrRegisterFile.scala 419:5 CsrRegisterFile.scala 189:16]
  wire  _GEN_231 = _T_273 ? 1'h0 : _GEN_208; // @[CsrRegisterFile.scala 419:5 CsrRegisterFile.scala 190:16]
  wire  _GEN_232 = _T_273 ? 1'h0 : _GEN_209; // @[CsrRegisterFile.scala 419:5 CsrRegisterFile.scala 192:20]
  wire [31:0] _GEN_233 = _T_273 ? 32'h0 : _GEN_210; // @[CsrRegisterFile.scala 419:5 CsrRegisterFile.scala 193:20]
  wire [31:0] _GEN_234 = _T_273 ? 32'h0 : _GEN_211; // @[CsrRegisterFile.scala 419:5 CsrRegisterFile.scala 194:20]
  wire  _GEN_236 = _T_271 ? 1'h0 : _T_273; // @[CsrRegisterFile.scala 415:5 CsrRegisterFile.scala 185:14]
  wire  _GEN_237 = _T_271 ? 1'h0 : _GEN_213; // @[CsrRegisterFile.scala 415:5 CsrRegisterFile.scala 186:14]
  wire  _GEN_238 = _T_271 ? 1'h0 : _GEN_214; // @[CsrRegisterFile.scala 415:5 CsrRegisterFile.scala 187:14]
  wire  _GEN_254 = _T_271 ? 1'h0 : _GEN_230; // @[CsrRegisterFile.scala 415:5 CsrRegisterFile.scala 189:16]
  wire  _GEN_255 = _T_271 ? 1'h0 : _GEN_231; // @[CsrRegisterFile.scala 415:5 CsrRegisterFile.scala 190:16]
  wire  _GEN_256 = _T_271 ? 1'h0 : _GEN_232; // @[CsrRegisterFile.scala 415:5 CsrRegisterFile.scala 192:20]
  wire [31:0] _GEN_257 = _T_271 ? 32'h0 : _GEN_233; // @[CsrRegisterFile.scala 415:5 CsrRegisterFile.scala 193:20]
  wire [31:0] _GEN_258 = _T_271 ? 32'h0 : _GEN_234; // @[CsrRegisterFile.scala 415:5 CsrRegisterFile.scala 194:20]
  wire  _GEN_260 = _T_269 ? 1'h0 : _T_271; // @[CsrRegisterFile.scala 411:5 CsrRegisterFile.scala 183:14]
  wire  _GEN_261 = _T_269 ? 1'h0 : _GEN_236; // @[CsrRegisterFile.scala 411:5 CsrRegisterFile.scala 185:14]
  wire  _GEN_262 = _T_269 ? 1'h0 : _GEN_237; // @[CsrRegisterFile.scala 411:5 CsrRegisterFile.scala 186:14]
  wire  _GEN_263 = _T_269 ? 1'h0 : _GEN_238; // @[CsrRegisterFile.scala 411:5 CsrRegisterFile.scala 187:14]
  wire  _GEN_279 = _T_269 ? 1'h0 : _GEN_254; // @[CsrRegisterFile.scala 411:5 CsrRegisterFile.scala 189:16]
  wire  _GEN_280 = _T_269 ? 1'h0 : _GEN_255; // @[CsrRegisterFile.scala 411:5 CsrRegisterFile.scala 190:16]
  wire  _GEN_281 = _T_269 ? 1'h0 : _GEN_256; // @[CsrRegisterFile.scala 411:5 CsrRegisterFile.scala 192:20]
  wire [31:0] _GEN_282 = _T_269 ? 32'h0 : _GEN_257; // @[CsrRegisterFile.scala 411:5 CsrRegisterFile.scala 193:20]
  wire [31:0] _GEN_283 = _T_269 ? 32'h0 : _GEN_258; // @[CsrRegisterFile.scala 411:5 CsrRegisterFile.scala 194:20]
  wire  _GEN_285 = _T_257 ? csr_wdata_int[3] : _WIRE_15[0]; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 400:20 CsrRegisterFile.scala 178:18]
  wire  _GEN_286 = _T_257 ? csr_wdata_int[7] : _WIRE_15[1]; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 401:20 CsrRegisterFile.scala 179:18]
  wire  _GEN_288 = _T_257 ? csr_wdata_int[21] : _WIRE_15[5]; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 403:20 CsrRegisterFile.scala 182:18]
  wire  _GEN_291 = _T_257 ? 1'h0 : _GEN_261; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 185:14]
  wire  _GEN_292 = _T_257 ? 1'h0 : _GEN_262; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 186:14]
  wire  _GEN_293 = _T_257 ? 1'h0 : _GEN_263; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 187:14]
  wire [30:0] hi_5 = csr_wdata_int[31:1]; // @[CsrRegisterFile.scala 490:34]
  wire [31:0] _T_435 = {hi_5,1'h0}; // @[Cat.scala 30:58]
  wire  hi_6 = csr_wdata_int[31]; // @[CsrRegisterFile.scala 491:34]
  wire [4:0] lo_5 = csr_wdata_int[4:0]; // @[CsrRegisterFile.scala 491:53]
  wire [5:0] _T_436 = {hi_6,lo_5}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_316 = io_i_csr_save_if ? io_i_pc_if : 32'h0; // @[CsrRegisterFile.scala 511:5 CsrRegisterFile.scala 512:20]
  wire [31:0] exception_pc = io_i_csr_save_cause ? _GEN_316 : 32'h0; // @[CsrRegisterFile.scala 509:3 CsrRegisterFile.scala 504:16]
  wire [4:0] _GEN_330 = {{4'd0}, _WIRE_19[5]}; // @[CsrRegisterFile.scala 526:5 CsrRegisterFile.scala 530:21 CsrRegisterFile.scala 500:14]
  wire [31:0] _GEN_332 = {hi_5,1'h0}; // @[Cat.scala 30:58]
  wire [4:0] _GEN_348 = io_i_csr_save_cause ? _GEN_330 : {{4'd0}, _WIRE_19[5]}; // @[CsrRegisterFile.scala 509:3 CsrRegisterFile.scala 500:14]
  wire  _GEN_353 = io_i_csr_save_cause | _T_257; // @[CsrRegisterFile.scala 509:3]
  wire  _GEN_354 = io_i_csr_save_cause ? 1'h0 : _GEN_285; // @[CsrRegisterFile.scala 509:3]
  wire  _GEN_355 = io_i_csr_save_cause ? _WIRE_15[0] : _GEN_286; // @[CsrRegisterFile.scala 509:3]
  wire  hi_hi_7 = mip_irq_software & _WIRE_17[2]; // @[CsrRegisterFile.scala 636:42]
  wire  hi_lo_4 = mip_irq_software & _WIRE_17[1]; // @[CsrRegisterFile.scala 636:117]
  wire  lo_6 = mip_irq_software & _WIRE_17[0]; // @[CsrRegisterFile.scala 636:192]
  wire [1:0] hi_10 = {hi_hi_7,hi_lo_4}; // @[Cat.scala 30:58]
  wire  mstatus_d_mpie = io_i_csr_restore_mret | _GEN_355; // @[CsrRegisterFile.scala 561:5 CsrRegisterFile.scala 565:22]
  wire  mstatus_d_mie = io_i_csr_restore_mret ? _WIRE_15[1] : _GEN_354; // @[CsrRegisterFile.scala 561:5 CsrRegisterFile.scala 564:22]
  wire [1:0] lo_7 = {mstatus_d_mpie,mstatus_d_mie}; // @[CsrRegisterFile.scala 648:41]
  wire  mstatus_d_tw = io_i_csr_save_cause ? 1'h0 : _GEN_288; // @[CsrRegisterFile.scala 509:3]
  wire  mstatus_d_mprv = io_i_csr_save_cause ? 1'h0 : _WIRE_15[4]; // @[CsrRegisterFile.scala 509:3 CsrRegisterFile.scala 181:18]
  wire [3:0] hi_11 = {mstatus_d_tw,mstatus_d_mprv,mstatus_d_mpp}; // @[CsrRegisterFile.scala 648:41]
  wire  mie_d_irq_external = csr_wdata_int[11]; // @[CsrRegisterFile.scala 662:39]
  wire  mie_d_irq_timer = csr_wdata_int[7]; // @[CsrRegisterFile.scala 661:39]
  wire [1:0] hi_12 = {mie_d_irq_external,mie_d_irq_timer}; // @[CsrRegisterFile.scala 665:33]
  wire  mie_d_irq_software = csr_wdata_int[3]; // @[CsrRegisterFile.scala 660:39]
  wire  dcsr_d_nmip = _WIRE_19[2];
  wire  dcsr_d_step = _WIRE_19[1];
  wire  dcsr_d_zero0 = _WIRE_19[4];
  wire  dcsr_d_mprven = _WIRE_19[3];
  wire  dcsr_d_stoptime = _WIRE_19[6];
  wire  dcsr_d_cause = _GEN_348[0];
  wire [6:0] lo_8 = {dcsr_d_stoptime,dcsr_d_cause,dcsr_d_zero0,dcsr_d_mprven,dcsr_d_nmip,dcsr_d_step,dcsr_d_prv}; // @[CsrRegisterFile.scala 702:35]
  wire  dcsr_d_ebreaks = _WIRE_19[9];
  wire  dcsr_d_stepie = _WIRE_19[8];
  wire  dcsr_d_stopcount = _WIRE_19[7];
  wire  dcsr_d_ebreakm = _WIRE_19[11];
  wire  dcsr_d_zero1 = _WIRE_19[10];
  wire [3:0] dcsr_d_xdebugver = _WIRE_19[27:24];
  wire [11:0] dcsr_d_zero2 = _WIRE_19[23:12];
  wire [20:0] hi_13 = {dcsr_d_xdebugver,dcsr_d_zero2,dcsr_d_ebreakm,dcsr_d_zero1,dcsr_d_ebreaks,dcsr_d_stepie,
    dcsr_d_stopcount}; // @[CsrRegisterFile.scala 702:35]
  wire [10:0] hi_hi_10 = csr_wdata_int[12:2]; // @[CsrRegisterFile.scala 736:41]
  wire  lo_9 = csr_wdata_int[0]; // @[CsrRegisterFile.scala 736:70]
  wire [12:0] _T_500 = {hi_hi_10,1'h1,lo_9}; // @[Cat.scala 30:58]
  wire  mcountinhibit_we = _T_257 ? 1'h0 : _GEN_281; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 192:20]
  wire [31:0] mhpmcounter_incr = 32'h0; // @[CsrRegisterFile.scala 141:46 CsrRegisterFile.scala 758:21]
  wire [31:0] mhpmcounterh_we = _T_257 ? 32'h0 : _GEN_283; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 194:20]
  wire [31:0] mhpmcounter_we = _T_257 ? 32'h0 : _GEN_282; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 193:20]
  wire  mstatus_en = io_i_csr_restore_mret | _GEN_353; // @[CsrRegisterFile.scala 561:5 CsrRegisterFile.scala 563:22]
  wire  mie_en = _T_257 ? 1'h0 : _T_269; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 184:14]
  wire  mscratch_en = _T_257 ? 1'h0 : _GEN_260; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 183:14]
  wire [31:0] mepc_d = io_i_csr_save_cause ? exception_pc : _T_435; // @[CsrRegisterFile.scala 509:3 CsrRegisterFile.scala 490:14]
  wire  mepc_en = io_i_csr_save_cause | _GEN_291; // @[CsrRegisterFile.scala 509:3]
  wire [5:0] mcause_d = io_i_csr_save_cause ? io_i_csr_mcause : _T_436; // @[CsrRegisterFile.scala 509:3 CsrRegisterFile.scala 491:14]
  wire  mcause_en = io_i_csr_save_cause | _GEN_292; // @[CsrRegisterFile.scala 509:3]
  wire [31:0] mtval_d = io_i_csr_save_cause ? 32'h0 : csr_wdata_int; // @[CsrRegisterFile.scala 509:3 CsrRegisterFile.scala 492:14]
  wire  mtval_en = io_i_csr_save_cause | _GEN_293; // @[CsrRegisterFile.scala 509:3]
  wire [31:0] mtvec_d = 32'h1; // @[CsrRegisterFile.scala 117:46 CsrRegisterFile.scala 496:14]
  wire  mtvec_en = 1'h1; // @[CsrRegisterFile.scala 118:46 CsrRegisterFile.scala 493:14]
  wire  dcsr_en = 1'h0; // @[CsrRegisterFile.scala 509:3 CsrRegisterFile.scala 191:14]
  wire [31:0] depc_d = {hi_5,1'h0}; // @[Cat.scala 30:58]
  wire  depc_en = 1'h0; // @[CsrRegisterFile.scala 509:3 CsrRegisterFile.scala 191:14]
  wire  dscratch0_en = _T_257 ? 1'h0 : _GEN_279; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 189:16]
  wire  dscratch1_en = _T_257 ? 1'h0 : _GEN_280; // @[CsrRegisterFile.scala 398:3 CsrRegisterFile.scala 190:16]
  wire [12:0] mcountinhibit_d = mcountinhibit_we ? _T_500 : mcountinhibit_q; // @[CsrRegisterFile.scala 734:3 CsrRegisterFile.scala 736:21 CsrRegisterFile.scala 740:23]
  wire  mstat_priv = mstatus_d_mpp != 2'h3 & mstatus_d_mpp != 2'h0; // @[CsrRegisterFile.scala 392:74]
  wire [18:0] _WIRE_20 = mhpmcounter_we[31:13]; // @[CsrRegisterFile.scala 814:45]
  CsrPrimitive PRIM_MSTATUS ( // @[CsrRegisterFile.scala 647:28]
    .clock(PRIM_MSTATUS_clock),
    .reset(PRIM_MSTATUS_reset),
    .io_i_wrdata(PRIM_MSTATUS_io_i_wrdata),
    .io_i_wr_en(PRIM_MSTATUS_io_i_wr_en),
    .io_o_rd_data(PRIM_MSTATUS_io_o_rd_data)
  );
  CsrPrimitive_1 PRIM_MEPC ( // @[CsrRegisterFile.scala 653:25]
    .clock(PRIM_MEPC_clock),
    .reset(PRIM_MEPC_reset),
    .io_i_wrdata(PRIM_MEPC_io_i_wrdata),
    .io_i_wr_en(PRIM_MEPC_io_i_wr_en),
    .io_o_rd_data(PRIM_MEPC_io_o_rd_data)
  );
  CsrPrimitive_2 PRIM_MIE ( // @[CsrRegisterFile.scala 664:24]
    .clock(PRIM_MIE_clock),
    .reset(PRIM_MIE_reset),
    .io_i_wrdata(PRIM_MIE_io_i_wrdata),
    .io_i_wr_en(PRIM_MIE_io_i_wr_en),
    .io_o_rd_data(PRIM_MIE_io_o_rd_data)
  );
  CsrPrimitive_1 PRIM_MSCRATCH ( // @[CsrRegisterFile.scala 671:29]
    .clock(PRIM_MSCRATCH_clock),
    .reset(PRIM_MSCRATCH_reset),
    .io_i_wrdata(PRIM_MSCRATCH_io_i_wrdata),
    .io_i_wr_en(PRIM_MSCRATCH_io_i_wr_en),
    .io_o_rd_data(PRIM_MSCRATCH_io_o_rd_data)
  );
  CsrPrimitive_4 PRIM_MCAUSE ( // @[CsrRegisterFile.scala 678:27]
    .clock(PRIM_MCAUSE_clock),
    .reset(PRIM_MCAUSE_reset),
    .io_i_wrdata(PRIM_MCAUSE_io_i_wrdata),
    .io_i_wr_en(PRIM_MCAUSE_io_i_wr_en),
    .io_o_rd_data(PRIM_MCAUSE_io_o_rd_data)
  );
  CsrPrimitive_1 PRIM_MTVAL ( // @[CsrRegisterFile.scala 684:26]
    .clock(PRIM_MTVAL_clock),
    .reset(PRIM_MTVAL_reset),
    .io_i_wrdata(PRIM_MTVAL_io_i_wrdata),
    .io_i_wr_en(PRIM_MTVAL_io_i_wr_en),
    .io_o_rd_data(PRIM_MTVAL_io_o_rd_data)
  );
  CsrPrimitive_6 PRIM_MTVEC ( // @[CsrRegisterFile.scala 691:26]
    .clock(PRIM_MTVEC_clock),
    .reset(PRIM_MTVEC_reset),
    .io_i_wrdata(PRIM_MTVEC_io_i_wrdata),
    .io_i_wr_en(PRIM_MTVEC_io_i_wr_en),
    .io_o_rd_data(PRIM_MTVEC_io_o_rd_data)
  );
  CsrPrimitive_7 PRIM_DCSR ( // @[CsrRegisterFile.scala 701:25]
    .clock(PRIM_DCSR_clock),
    .reset(PRIM_DCSR_reset),
    .io_i_wrdata(PRIM_DCSR_io_i_wrdata),
    .io_i_wr_en(PRIM_DCSR_io_i_wr_en),
    .io_o_rd_data(PRIM_DCSR_io_o_rd_data)
  );
  CsrPrimitive_1 PRIM_DEPC ( // @[CsrRegisterFile.scala 708:25]
    .clock(PRIM_DEPC_clock),
    .reset(PRIM_DEPC_reset),
    .io_i_wrdata(PRIM_DEPC_io_i_wrdata),
    .io_i_wr_en(PRIM_DEPC_io_i_wr_en),
    .io_o_rd_data(PRIM_DEPC_io_o_rd_data)
  );
  CsrPrimitive_1 PRIM_DSCRATCH0 ( // @[CsrRegisterFile.scala 714:30]
    .clock(PRIM_DSCRATCH0_clock),
    .reset(PRIM_DSCRATCH0_reset),
    .io_i_wrdata(PRIM_DSCRATCH0_io_i_wrdata),
    .io_i_wr_en(PRIM_DSCRATCH0_io_i_wr_en),
    .io_o_rd_data(PRIM_DSCRATCH0_io_o_rd_data)
  );
  CsrPrimitive_1 PRIM_DSCRATCH1 ( // @[CsrRegisterFile.scala 721:30]
    .clock(PRIM_DSCRATCH1_clock),
    .reset(PRIM_DSCRATCH1_reset),
    .io_i_wrdata(PRIM_DSCRATCH1_io_i_wrdata),
    .io_i_wr_en(PRIM_DSCRATCH1_io_i_wr_en),
    .io_o_rd_data(PRIM_DSCRATCH1_io_o_rd_data)
  );
  BrqCounter COUNT_MCYCLE ( // @[CsrRegisterFile.scala 777:28]
    .clock(COUNT_MCYCLE_clock),
    .reset(COUNT_MCYCLE_reset),
    .io_i_counter_inc(COUNT_MCYCLE_io_i_counter_inc),
    .io_i_counterh_we(COUNT_MCYCLE_io_i_counterh_we),
    .io_i_counter_we(COUNT_MCYCLE_io_i_counter_we),
    .io_i_counter_val(COUNT_MCYCLE_io_i_counter_val),
    .io_o_counter_val(COUNT_MCYCLE_io_o_counter_val)
  );
  BrqCounter COUNT_MINSTRET ( // @[CsrRegisterFile.scala 785:30]
    .clock(COUNT_MINSTRET_clock),
    .reset(COUNT_MINSTRET_reset),
    .io_i_counter_inc(COUNT_MINSTRET_io_i_counter_inc),
    .io_i_counterh_we(COUNT_MINSTRET_io_i_counterh_we),
    .io_i_counter_we(COUNT_MINSTRET_io_i_counter_we),
    .io_i_counter_val(COUNT_MINSTRET_io_i_counter_val),
    .io_o_counter_val(COUNT_MINSTRET_io_o_counter_val)
  );
  BrqCounter_2 BrqCounter ( // @[CsrRegisterFile.scala 797:26]
    .clock(BrqCounter_clock),
    .reset(BrqCounter_reset),
    .io_i_counter_inc(BrqCounter_io_i_counter_inc),
    .io_i_counterh_we(BrqCounter_io_i_counterh_we),
    .io_i_counter_we(BrqCounter_io_i_counter_we),
    .io_i_counter_val(BrqCounter_io_i_counter_val),
    .io_o_counter_val(BrqCounter_io_o_counter_val)
  );
  BrqCounter_2 BrqCounter_1 ( // @[CsrRegisterFile.scala 797:26]
    .clock(BrqCounter_1_clock),
    .reset(BrqCounter_1_reset),
    .io_i_counter_inc(BrqCounter_1_io_i_counter_inc),
    .io_i_counterh_we(BrqCounter_1_io_i_counterh_we),
    .io_i_counter_we(BrqCounter_1_io_i_counter_we),
    .io_i_counter_val(BrqCounter_1_io_i_counter_val),
    .io_o_counter_val(BrqCounter_1_io_o_counter_val)
  );
  BrqCounter_2 BrqCounter_2 ( // @[CsrRegisterFile.scala 797:26]
    .clock(BrqCounter_2_clock),
    .reset(BrqCounter_2_reset),
    .io_i_counter_inc(BrqCounter_2_io_i_counter_inc),
    .io_i_counterh_we(BrqCounter_2_io_i_counterh_we),
    .io_i_counter_we(BrqCounter_2_io_i_counter_we),
    .io_i_counter_val(BrqCounter_2_io_i_counter_val),
    .io_o_counter_val(BrqCounter_2_io_o_counter_val)
  );
  BrqCounter_2 BrqCounter_3 ( // @[CsrRegisterFile.scala 797:26]
    .clock(BrqCounter_3_clock),
    .reset(BrqCounter_3_reset),
    .io_i_counter_inc(BrqCounter_3_io_i_counter_inc),
    .io_i_counterh_we(BrqCounter_3_io_i_counterh_we),
    .io_i_counter_we(BrqCounter_3_io_i_counter_we),
    .io_i_counter_val(BrqCounter_3_io_i_counter_val),
    .io_o_counter_val(BrqCounter_3_io_o_counter_val)
  );
  BrqCounter_2 BrqCounter_4 ( // @[CsrRegisterFile.scala 797:26]
    .clock(BrqCounter_4_clock),
    .reset(BrqCounter_4_reset),
    .io_i_counter_inc(BrqCounter_4_io_i_counter_inc),
    .io_i_counterh_we(BrqCounter_4_io_i_counterh_we),
    .io_i_counter_we(BrqCounter_4_io_i_counter_we),
    .io_i_counter_val(BrqCounter_4_io_i_counter_val),
    .io_o_counter_val(BrqCounter_4_io_o_counter_val)
  );
  BrqCounter_2 BrqCounter_5 ( // @[CsrRegisterFile.scala 797:26]
    .clock(BrqCounter_5_clock),
    .reset(BrqCounter_5_reset),
    .io_i_counter_inc(BrqCounter_5_io_i_counter_inc),
    .io_i_counterh_we(BrqCounter_5_io_i_counterh_we),
    .io_i_counter_we(BrqCounter_5_io_i_counter_we),
    .io_i_counter_val(BrqCounter_5_io_i_counter_val),
    .io_o_counter_val(BrqCounter_5_io_o_counter_val)
  );
  BrqCounter_2 BrqCounter_6 ( // @[CsrRegisterFile.scala 797:26]
    .clock(BrqCounter_6_clock),
    .reset(BrqCounter_6_reset),
    .io_i_counter_inc(BrqCounter_6_io_i_counter_inc),
    .io_i_counterh_we(BrqCounter_6_io_i_counterh_we),
    .io_i_counter_we(BrqCounter_6_io_i_counter_we),
    .io_i_counter_val(BrqCounter_6_io_i_counter_val),
    .io_o_counter_val(BrqCounter_6_io_o_counter_val)
  );
  BrqCounter_2 BrqCounter_7 ( // @[CsrRegisterFile.scala 797:26]
    .clock(BrqCounter_7_clock),
    .reset(BrqCounter_7_reset),
    .io_i_counter_inc(BrqCounter_7_io_i_counter_inc),
    .io_i_counterh_we(BrqCounter_7_io_i_counterh_we),
    .io_i_counter_we(BrqCounter_7_io_i_counter_we),
    .io_i_counter_val(BrqCounter_7_io_i_counter_val),
    .io_o_counter_val(BrqCounter_7_io_o_counter_val)
  );
  BrqCounter_2 BrqCounter_8 ( // @[CsrRegisterFile.scala 797:26]
    .clock(BrqCounter_8_clock),
    .reset(BrqCounter_8_reset),
    .io_i_counter_inc(BrqCounter_8_io_i_counter_inc),
    .io_i_counterh_we(BrqCounter_8_io_i_counterh_we),
    .io_i_counter_we(BrqCounter_8_io_i_counter_we),
    .io_i_counter_val(BrqCounter_8_io_i_counter_val),
    .io_o_counter_val(BrqCounter_8_io_o_counter_val)
  );
  BrqCounter_2 BrqCounter_9 ( // @[CsrRegisterFile.scala 797:26]
    .clock(BrqCounter_9_clock),
    .reset(BrqCounter_9_reset),
    .io_i_counter_inc(BrqCounter_9_io_i_counter_inc),
    .io_i_counterh_we(BrqCounter_9_io_i_counterh_we),
    .io_i_counter_we(BrqCounter_9_io_i_counter_we),
    .io_i_counter_val(BrqCounter_9_io_i_counter_val),
    .io_o_counter_val(BrqCounter_9_io_o_counter_val)
  );
  assign io_o_csr_mtvec = mtvec_q; // @[CsrRegisterFile.scala 628:18]
  assign io_o_csr_rdata = _T_34 ? 32'h0 : _GEN_108; // @[CsrRegisterFile.scala 219:3 CsrRegisterFile.scala 221:19]
  assign io_o_irq_pending = |io_o_irqs; // @[CsrRegisterFile.scala 637:35]
  assign io_o_irqs = {hi_10,lo_6}; // @[Cat.scala 30:58]
  assign io_o_csr_mstatus_mie = _WIRE_15[0]; // @[CsrRegisterFile.scala 629:24]
  assign io_o_csr_mepc = mepc_q; // @[CsrRegisterFile.scala 626:18]
  assign io_o_illegal_csr_insn = io_i_csr_access & (illegal_csr | illegal_csr_priv | illegal_csr_write); // @[CsrRegisterFile.scala 205:46]
  assign PRIM_MSTATUS_clock = clock;
  assign PRIM_MSTATUS_reset = reset;
  assign PRIM_MSTATUS_io_i_wrdata = {hi_11,lo_7}; // @[CsrRegisterFile.scala 648:41]
  assign PRIM_MSTATUS_io_i_wr_en = mstatus_en; // @[CsrRegisterFile.scala 649:29]
  assign PRIM_MEPC_clock = clock;
  assign PRIM_MEPC_reset = reset;
  assign PRIM_MEPC_io_i_wrdata = mepc_d; // @[CsrRegisterFile.scala 654:25]
  assign PRIM_MEPC_io_i_wr_en = mepc_en; // @[CsrRegisterFile.scala 655:26]
  assign PRIM_MIE_clock = clock;
  assign PRIM_MIE_reset = reset;
  assign PRIM_MIE_io_i_wrdata = {hi_12,mie_d_irq_software}; // @[CsrRegisterFile.scala 665:33]
  assign PRIM_MIE_io_i_wr_en = mie_en; // @[CsrRegisterFile.scala 666:25]
  assign PRIM_MSCRATCH_clock = clock;
  assign PRIM_MSCRATCH_reset = reset;
  assign PRIM_MSCRATCH_io_i_wrdata = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign PRIM_MSCRATCH_io_i_wr_en = mscratch_en; // @[CsrRegisterFile.scala 673:30]
  assign PRIM_MCAUSE_clock = clock;
  assign PRIM_MCAUSE_reset = reset;
  assign PRIM_MCAUSE_io_i_wrdata = mcause_d; // @[CsrRegisterFile.scala 679:27]
  assign PRIM_MCAUSE_io_i_wr_en = mcause_en; // @[CsrRegisterFile.scala 680:28]
  assign PRIM_MTVAL_clock = clock;
  assign PRIM_MTVAL_reset = reset;
  assign PRIM_MTVAL_io_i_wrdata = mtval_d; // @[CsrRegisterFile.scala 685:26]
  assign PRIM_MTVAL_io_i_wr_en = mtval_en; // @[CsrRegisterFile.scala 686:27]
  assign PRIM_MTVEC_clock = clock;
  assign PRIM_MTVEC_reset = reset;
  assign PRIM_MTVEC_io_i_wrdata = mtvec_d; // @[CsrRegisterFile.scala 692:26]
  assign PRIM_MTVEC_io_i_wr_en = _T_50; // @[CsrRegisterFile.scala 693:27]
  assign PRIM_DCSR_clock = clock;
  assign PRIM_DCSR_reset = reset;
  assign PRIM_DCSR_io_i_wrdata = {hi_13,lo_8}; // @[CsrRegisterFile.scala 702:35]
  assign PRIM_DCSR_io_i_wr_en = mip_irq_software; // @[CsrRegisterFile.scala 703:26]
  assign PRIM_DEPC_clock = clock;
  assign PRIM_DEPC_reset = reset;
  assign PRIM_DEPC_io_i_wrdata = _GEN_332; // @[CsrRegisterFile.scala 709:25]
  assign PRIM_DEPC_io_i_wr_en = mip_irq_software; // @[CsrRegisterFile.scala 710:26]
  assign PRIM_DSCRATCH0_clock = clock;
  assign PRIM_DSCRATCH0_reset = reset;
  assign PRIM_DSCRATCH0_io_i_wrdata = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign PRIM_DSCRATCH0_io_i_wr_en = dscratch0_en; // @[CsrRegisterFile.scala 716:31]
  assign PRIM_DSCRATCH1_clock = clock;
  assign PRIM_DSCRATCH1_reset = reset;
  assign PRIM_DSCRATCH1_io_i_wrdata = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign PRIM_DSCRATCH1_io_i_wr_en = dscratch1_en; // @[CsrRegisterFile.scala 723:31]
  assign COUNT_MCYCLE_clock = clock;
  assign COUNT_MCYCLE_reset = reset;
  assign COUNT_MCYCLE_io_i_counter_inc = tmatch_value_rdata[0] & ~mcountinhibit[0]; // @[CsrRegisterFile.scala 778:56]
  assign COUNT_MCYCLE_io_i_counterh_we = mhpmcounterh_we[0]; // @[CsrRegisterFile.scala 779:51]
  assign COUNT_MCYCLE_io_i_counter_we = mhpmcounter_we[0]; // @[CsrRegisterFile.scala 780:50]
  assign COUNT_MCYCLE_io_i_counter_val = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign COUNT_MINSTRET_clock = clock;
  assign COUNT_MINSTRET_reset = reset;
  assign COUNT_MINSTRET_io_i_counter_inc = tmatch_value_rdata[2] & ~mcountinhibit[2]; // @[CsrRegisterFile.scala 786:58]
  assign COUNT_MINSTRET_io_i_counterh_we = mhpmcounterh_we[2]; // @[CsrRegisterFile.scala 787:53]
  assign COUNT_MINSTRET_io_i_counter_we = mhpmcounter_we[2]; // @[CsrRegisterFile.scala 788:52]
  assign COUNT_MINSTRET_io_i_counter_val = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign BrqCounter_clock = clock;
  assign BrqCounter_reset = reset;
  assign BrqCounter_io_i_counter_inc = tmatch_value_rdata[3] & ~mcountinhibit[3]; // @[CsrRegisterFile.scala 799:58]
  assign BrqCounter_io_i_counterh_we = mhpmcounterh_we[3]; // @[CsrRegisterFile.scala 800:49]
  assign BrqCounter_io_i_counter_we = mhpmcounter_we[3]; // @[CsrRegisterFile.scala 801:48]
  assign BrqCounter_io_i_counter_val = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign BrqCounter_1_clock = clock;
  assign BrqCounter_1_reset = reset;
  assign BrqCounter_1_io_i_counter_inc = tmatch_value_rdata[4] & ~mcountinhibit[4]; // @[CsrRegisterFile.scala 799:58]
  assign BrqCounter_1_io_i_counterh_we = mhpmcounterh_we[4]; // @[CsrRegisterFile.scala 800:49]
  assign BrqCounter_1_io_i_counter_we = mhpmcounter_we[4]; // @[CsrRegisterFile.scala 801:48]
  assign BrqCounter_1_io_i_counter_val = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign BrqCounter_2_clock = clock;
  assign BrqCounter_2_reset = reset;
  assign BrqCounter_2_io_i_counter_inc = tmatch_value_rdata[5] & ~mcountinhibit[5]; // @[CsrRegisterFile.scala 799:58]
  assign BrqCounter_2_io_i_counterh_we = mhpmcounterh_we[5]; // @[CsrRegisterFile.scala 800:49]
  assign BrqCounter_2_io_i_counter_we = mhpmcounter_we[5]; // @[CsrRegisterFile.scala 801:48]
  assign BrqCounter_2_io_i_counter_val = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign BrqCounter_3_clock = clock;
  assign BrqCounter_3_reset = reset;
  assign BrqCounter_3_io_i_counter_inc = tmatch_value_rdata[6] & ~mcountinhibit[6]; // @[CsrRegisterFile.scala 799:58]
  assign BrqCounter_3_io_i_counterh_we = mhpmcounterh_we[6]; // @[CsrRegisterFile.scala 800:49]
  assign BrqCounter_3_io_i_counter_we = mhpmcounter_we[6]; // @[CsrRegisterFile.scala 801:48]
  assign BrqCounter_3_io_i_counter_val = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign BrqCounter_4_clock = clock;
  assign BrqCounter_4_reset = reset;
  assign BrqCounter_4_io_i_counter_inc = tmatch_value_rdata[7] & ~mcountinhibit[7]; // @[CsrRegisterFile.scala 799:58]
  assign BrqCounter_4_io_i_counterh_we = mhpmcounterh_we[7]; // @[CsrRegisterFile.scala 800:49]
  assign BrqCounter_4_io_i_counter_we = mhpmcounter_we[7]; // @[CsrRegisterFile.scala 801:48]
  assign BrqCounter_4_io_i_counter_val = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign BrqCounter_5_clock = clock;
  assign BrqCounter_5_reset = reset;
  assign BrqCounter_5_io_i_counter_inc = tmatch_value_rdata[8] & ~mcountinhibit[8]; // @[CsrRegisterFile.scala 799:58]
  assign BrqCounter_5_io_i_counterh_we = mhpmcounterh_we[8]; // @[CsrRegisterFile.scala 800:49]
  assign BrqCounter_5_io_i_counter_we = mhpmcounter_we[8]; // @[CsrRegisterFile.scala 801:48]
  assign BrqCounter_5_io_i_counter_val = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign BrqCounter_6_clock = clock;
  assign BrqCounter_6_reset = reset;
  assign BrqCounter_6_io_i_counter_inc = tmatch_value_rdata[9] & ~mcountinhibit[9]; // @[CsrRegisterFile.scala 799:58]
  assign BrqCounter_6_io_i_counterh_we = mhpmcounterh_we[9]; // @[CsrRegisterFile.scala 800:49]
  assign BrqCounter_6_io_i_counter_we = mhpmcounter_we[9]; // @[CsrRegisterFile.scala 801:48]
  assign BrqCounter_6_io_i_counter_val = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign BrqCounter_7_clock = clock;
  assign BrqCounter_7_reset = reset;
  assign BrqCounter_7_io_i_counter_inc = tmatch_value_rdata[10] & ~mcountinhibit[10]; // @[CsrRegisterFile.scala 799:58]
  assign BrqCounter_7_io_i_counterh_we = mhpmcounterh_we[10]; // @[CsrRegisterFile.scala 800:49]
  assign BrqCounter_7_io_i_counter_we = mhpmcounter_we[10]; // @[CsrRegisterFile.scala 801:48]
  assign BrqCounter_7_io_i_counter_val = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign BrqCounter_8_clock = clock;
  assign BrqCounter_8_reset = reset;
  assign BrqCounter_8_io_i_counter_inc = tmatch_value_rdata[11] & ~mcountinhibit[11]; // @[CsrRegisterFile.scala 799:58]
  assign BrqCounter_8_io_i_counterh_we = mhpmcounterh_we[11]; // @[CsrRegisterFile.scala 800:49]
  assign BrqCounter_8_io_i_counter_we = mhpmcounter_we[11]; // @[CsrRegisterFile.scala 801:48]
  assign BrqCounter_8_io_i_counter_val = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  assign BrqCounter_9_clock = clock;
  assign BrqCounter_9_reset = reset;
  assign BrqCounter_9_io_i_counter_inc = tmatch_value_rdata[12] & ~mcountinhibit[12]; // @[CsrRegisterFile.scala 799:58]
  assign BrqCounter_9_io_i_counterh_we = mhpmcounterh_we[12]; // @[CsrRegisterFile.scala 800:49]
  assign BrqCounter_9_io_i_counter_we = mhpmcounter_we[12]; // @[CsrRegisterFile.scala 801:48]
  assign BrqCounter_9_io_i_counter_val = _T_458 ? io_i_csr_wdata : _GEN_372; // @[CsrRegisterFile.scala 598:3 CsrRegisterFile.scala 599:19]
  always @(posedge clock) begin
    if (reset) begin // @[CsrRegisterFile.scala 100:27]
      priv_lvl_q <= 2'h3; // @[CsrRegisterFile.scala 100:27]
    end else if (reset) begin // @[CsrRegisterFile.scala 571:3]
      priv_lvl_q <= 2'h3; // @[CsrRegisterFile.scala 572:17]
    end else if (io_i_csr_restore_mret) begin // @[CsrRegisterFile.scala 561:5]
      priv_lvl_q <= _WIRE_15[3:2]; // @[CsrRegisterFile.scala 562:26]
    end else if (io_i_csr_save_cause) begin // @[CsrRegisterFile.scala 509:3]
      priv_lvl_q <= 2'h3; // @[CsrRegisterFile.scala 523:16]
    end
    if (reset) begin // @[CsrRegisterFile.scala 133:49]
      mcountinhibit_q <= 13'h0; // @[CsrRegisterFile.scala 133:49]
    end else if (mcountinhibit_we) begin // @[CsrRegisterFile.scala 734:3]
      mcountinhibit_q <= _T_500; // @[CsrRegisterFile.scala 736:21]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_0 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end else begin
      mhpmcounter_0 <= COUNT_MCYCLE_io_o_counter_val; // @[CsrRegisterFile.scala 782:33]
    end
    mhpmcounter_1 <= 64'h0; // @[CsrRegisterFile.scala 137:49 CsrRegisterFile.scala 137:49 CsrRegisterFile.scala 793:18]
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_2 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end else begin
      mhpmcounter_2 <= COUNT_MINSTRET_io_o_counter_val; // @[CsrRegisterFile.scala 790:35]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_3 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end else begin
      mhpmcounter_3 <= BrqCounter_io_o_counter_val; // @[CsrRegisterFile.scala 803:31]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_4 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end else begin
      mhpmcounter_4 <= BrqCounter_1_io_o_counter_val; // @[CsrRegisterFile.scala 803:31]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_5 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end else begin
      mhpmcounter_5 <= BrqCounter_2_io_o_counter_val; // @[CsrRegisterFile.scala 803:31]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_6 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end else begin
      mhpmcounter_6 <= BrqCounter_3_io_o_counter_val; // @[CsrRegisterFile.scala 803:31]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_7 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end else begin
      mhpmcounter_7 <= BrqCounter_4_io_o_counter_val; // @[CsrRegisterFile.scala 803:31]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_8 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end else begin
      mhpmcounter_8 <= BrqCounter_5_io_o_counter_val; // @[CsrRegisterFile.scala 803:31]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_9 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end else begin
      mhpmcounter_9 <= BrqCounter_6_io_o_counter_val; // @[CsrRegisterFile.scala 803:31]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_10 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end else begin
      mhpmcounter_10 <= BrqCounter_7_io_o_counter_val; // @[CsrRegisterFile.scala 803:31]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_11 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end else begin
      mhpmcounter_11 <= BrqCounter_8_io_o_counter_val; // @[CsrRegisterFile.scala 803:31]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_12 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end else begin
      mhpmcounter_12 <= BrqCounter_9_io_o_counter_val; // @[CsrRegisterFile.scala 803:31]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_13 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_14 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_15 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_16 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_17 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_18 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_19 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_20 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_21 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_22 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_23 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_24 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_25 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_26 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_27 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_28 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_29 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_30 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 137:49]
      mhpmcounter_31 <= 64'h0; // @[CsrRegisterFile.scala 137:49]
    end
    if (reset) begin // @[CsrRegisterFile.scala 142:49]
      mhpmevent_0 <= 32'h0; // @[CsrRegisterFile.scala 142:49]
    end else begin
      mhpmevent_0 <= 32'h1; // @[CsrRegisterFile.scala 765:18]
    end
    mhpmevent_1 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 769:16]
    if (reset) begin // @[CsrRegisterFile.scala 142:49]
      mhpmevent_2 <= 32'h0; // @[CsrRegisterFile.scala 142:49]
    end else begin
      mhpmevent_2 <= 32'h4; // @[CsrRegisterFile.scala 765:18]
    end
    if (reset) begin // @[CsrRegisterFile.scala 142:49]
      mhpmevent_3 <= 32'h0; // @[CsrRegisterFile.scala 142:49]
    end else begin
      mhpmevent_3 <= 32'h8; // @[CsrRegisterFile.scala 765:18]
    end
    if (reset) begin // @[CsrRegisterFile.scala 142:49]
      mhpmevent_4 <= 32'h0; // @[CsrRegisterFile.scala 142:49]
    end else begin
      mhpmevent_4 <= 32'h10; // @[CsrRegisterFile.scala 765:18]
    end
    if (reset) begin // @[CsrRegisterFile.scala 142:49]
      mhpmevent_5 <= 32'h0; // @[CsrRegisterFile.scala 142:49]
    end else begin
      mhpmevent_5 <= 32'h20; // @[CsrRegisterFile.scala 765:18]
    end
    if (reset) begin // @[CsrRegisterFile.scala 142:49]
      mhpmevent_6 <= 32'h0; // @[CsrRegisterFile.scala 142:49]
    end else begin
      mhpmevent_6 <= 32'h40; // @[CsrRegisterFile.scala 765:18]
    end
    if (reset) begin // @[CsrRegisterFile.scala 142:49]
      mhpmevent_7 <= 32'h0; // @[CsrRegisterFile.scala 142:49]
    end else begin
      mhpmevent_7 <= 32'h80; // @[CsrRegisterFile.scala 765:18]
    end
    if (reset) begin // @[CsrRegisterFile.scala 142:49]
      mhpmevent_8 <= 32'h0; // @[CsrRegisterFile.scala 142:49]
    end else begin
      mhpmevent_8 <= 32'h100; // @[CsrRegisterFile.scala 765:18]
    end
    if (reset) begin // @[CsrRegisterFile.scala 142:49]
      mhpmevent_9 <= 32'h0; // @[CsrRegisterFile.scala 142:49]
    end else begin
      mhpmevent_9 <= 32'h200; // @[CsrRegisterFile.scala 765:18]
    end
    if (reset) begin // @[CsrRegisterFile.scala 142:49]
      mhpmevent_10 <= 32'h0; // @[CsrRegisterFile.scala 142:49]
    end else begin
      mhpmevent_10 <= 32'h400; // @[CsrRegisterFile.scala 765:18]
    end
    if (reset) begin // @[CsrRegisterFile.scala 142:49]
      mhpmevent_11 <= 32'h0; // @[CsrRegisterFile.scala 142:49]
    end else begin
      mhpmevent_11 <= 32'h800; // @[CsrRegisterFile.scala 765:18]
    end
    if (reset) begin // @[CsrRegisterFile.scala 142:49]
      mhpmevent_12 <= 32'h0; // @[CsrRegisterFile.scala 142:49]
    end else begin
      mhpmevent_12 <= 32'h1000; // @[CsrRegisterFile.scala 765:18]
    end
    mhpmevent_13 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_14 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_15 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_16 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_17 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_18 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_19 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_20 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_21 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_22 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_23 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_24 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_25 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_26 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_27 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_28 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_29 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_30 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
    mhpmevent_31 <= 32'h0; // @[CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 142:49 CsrRegisterFile.scala 773:18]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  priv_lvl_q = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  mcountinhibit_q = _RAND_1[12:0];
  _RAND_2 = {2{`RANDOM}};
  mhpmcounter_0 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  mhpmcounter_1 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  mhpmcounter_2 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  mhpmcounter_3 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  mhpmcounter_4 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  mhpmcounter_5 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  mhpmcounter_6 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  mhpmcounter_7 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  mhpmcounter_8 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  mhpmcounter_9 = _RAND_11[63:0];
  _RAND_12 = {2{`RANDOM}};
  mhpmcounter_10 = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  mhpmcounter_11 = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  mhpmcounter_12 = _RAND_14[63:0];
  _RAND_15 = {2{`RANDOM}};
  mhpmcounter_13 = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  mhpmcounter_14 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  mhpmcounter_15 = _RAND_17[63:0];
  _RAND_18 = {2{`RANDOM}};
  mhpmcounter_16 = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  mhpmcounter_17 = _RAND_19[63:0];
  _RAND_20 = {2{`RANDOM}};
  mhpmcounter_18 = _RAND_20[63:0];
  _RAND_21 = {2{`RANDOM}};
  mhpmcounter_19 = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  mhpmcounter_20 = _RAND_22[63:0];
  _RAND_23 = {2{`RANDOM}};
  mhpmcounter_21 = _RAND_23[63:0];
  _RAND_24 = {2{`RANDOM}};
  mhpmcounter_22 = _RAND_24[63:0];
  _RAND_25 = {2{`RANDOM}};
  mhpmcounter_23 = _RAND_25[63:0];
  _RAND_26 = {2{`RANDOM}};
  mhpmcounter_24 = _RAND_26[63:0];
  _RAND_27 = {2{`RANDOM}};
  mhpmcounter_25 = _RAND_27[63:0];
  _RAND_28 = {2{`RANDOM}};
  mhpmcounter_26 = _RAND_28[63:0];
  _RAND_29 = {2{`RANDOM}};
  mhpmcounter_27 = _RAND_29[63:0];
  _RAND_30 = {2{`RANDOM}};
  mhpmcounter_28 = _RAND_30[63:0];
  _RAND_31 = {2{`RANDOM}};
  mhpmcounter_29 = _RAND_31[63:0];
  _RAND_32 = {2{`RANDOM}};
  mhpmcounter_30 = _RAND_32[63:0];
  _RAND_33 = {2{`RANDOM}};
  mhpmcounter_31 = _RAND_33[63:0];
  _RAND_34 = {1{`RANDOM}};
  mhpmevent_0 = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  mhpmevent_1 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  mhpmevent_2 = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  mhpmevent_3 = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  mhpmevent_4 = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  mhpmevent_5 = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  mhpmevent_6 = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  mhpmevent_7 = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  mhpmevent_8 = _RAND_42[31:0];
  _RAND_43 = {1{`RANDOM}};
  mhpmevent_9 = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  mhpmevent_10 = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  mhpmevent_11 = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  mhpmevent_12 = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  mhpmevent_13 = _RAND_47[31:0];
  _RAND_48 = {1{`RANDOM}};
  mhpmevent_14 = _RAND_48[31:0];
  _RAND_49 = {1{`RANDOM}};
  mhpmevent_15 = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  mhpmevent_16 = _RAND_50[31:0];
  _RAND_51 = {1{`RANDOM}};
  mhpmevent_17 = _RAND_51[31:0];
  _RAND_52 = {1{`RANDOM}};
  mhpmevent_18 = _RAND_52[31:0];
  _RAND_53 = {1{`RANDOM}};
  mhpmevent_19 = _RAND_53[31:0];
  _RAND_54 = {1{`RANDOM}};
  mhpmevent_20 = _RAND_54[31:0];
  _RAND_55 = {1{`RANDOM}};
  mhpmevent_21 = _RAND_55[31:0];
  _RAND_56 = {1{`RANDOM}};
  mhpmevent_22 = _RAND_56[31:0];
  _RAND_57 = {1{`RANDOM}};
  mhpmevent_23 = _RAND_57[31:0];
  _RAND_58 = {1{`RANDOM}};
  mhpmevent_24 = _RAND_58[31:0];
  _RAND_59 = {1{`RANDOM}};
  mhpmevent_25 = _RAND_59[31:0];
  _RAND_60 = {1{`RANDOM}};
  mhpmevent_26 = _RAND_60[31:0];
  _RAND_61 = {1{`RANDOM}};
  mhpmevent_27 = _RAND_61[31:0];
  _RAND_62 = {1{`RANDOM}};
  mhpmevent_28 = _RAND_62[31:0];
  _RAND_63 = {1{`RANDOM}};
  mhpmevent_29 = _RAND_63[31:0];
  _RAND_64 = {1{`RANDOM}};
  mhpmevent_30 = _RAND_64[31:0];
  _RAND_65 = {1{`RANDOM}};
  mhpmevent_31 = _RAND_65[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CsrControlUnit(
  input        io_reg_wr_in_execute,
  input  [4:0] io_rd_sel_in_execute,
  input        io_csr_wr_in_execute,
  input        io_reg_wr_in_memory,
  input  [4:0] io_rd_sel_in_memory,
  input        io_csr_wr_in_memory,
  input        io_reg_wr_in_writeback,
  input  [4:0] io_rd_sel_in_writeback,
  input        io_csr_wr_in_writeback,
  input  [4:0] io_rs1_sel_in_decode,
  input        io_csr_inst_in_decode,
  input        io_csr_imm_inst_in_decode,
  input        io_load_inst_in_execute,
  input        io_load_inst_in_memory,
  input        io_dccm_rvalid_i,
  output [2:0] io_forward_rs1,
  output       io_csr_op_en_o
);
  wire  _T_1 = ~io_csr_imm_inst_in_decode; // @[CsrControlUnit.scala 51:86]
  wire  _T_4 = io_reg_wr_in_execute & io_csr_inst_in_decode & ~io_csr_imm_inst_in_decode & io_rd_sel_in_execute != 5'h0; // @[CsrControlUnit.scala 51:113]
  wire  _T_7 = io_rd_sel_in_execute == io_rs1_sel_in_decode; // @[CsrControlUnit.scala 51:195]
  wire  hazard_in_decode_execute = io_reg_wr_in_execute & io_csr_inst_in_decode & ~io_csr_imm_inst_in_decode &
    io_rd_sel_in_execute != 5'h0 & ~io_csr_wr_in_execute & io_rd_sel_in_execute == io_rs1_sel_in_decode; // @[CsrControlUnit.scala 51:170]
  wire  _T_14 = io_reg_wr_in_memory & io_csr_inst_in_decode & _T_1 & io_rd_sel_in_memory != 5'h0; // @[CsrControlUnit.scala 52:112]
  wire  _T_15 = ~hazard_in_decode_execute; // @[CsrControlUnit.scala 52:147]
  wire  _T_19 = io_rd_sel_in_memory == io_rs1_sel_in_decode; // @[CsrControlUnit.scala 52:221]
  wire  hazard_in_decode_memory = io_reg_wr_in_memory & io_csr_inst_in_decode & _T_1 & io_rd_sel_in_memory != 5'h0 & ~
    hazard_in_decode_execute & ~io_csr_wr_in_memory & io_rd_sel_in_memory == io_rs1_sel_in_decode; // @[CsrControlUnit.scala 52:197]
  wire  _T_26 = io_reg_wr_in_writeback & io_csr_inst_in_decode & _T_1 & io_rd_sel_in_writeback != 5'h0; // @[CsrControlUnit.scala 53:115]
  wire  _T_33 = io_rd_sel_in_writeback == io_rs1_sel_in_decode; // @[CsrControlUnit.scala 53:259]
  wire  hazard_in_decode_writeback = io_reg_wr_in_writeback & io_csr_inst_in_decode & _T_1 & io_rd_sel_in_writeback != 5'h0
     & _T_15 & ~hazard_in_decode_memory & ~io_csr_wr_in_writeback & io_rd_sel_in_writeback == io_rs1_sel_in_decode; // @[CsrControlUnit.scala 53:232]
  wire  csr_hazard_in_decode_execute = _T_4 & io_csr_wr_in_execute & _T_7; // @[CsrControlUnit.scala 55:171]
  wire  _T_51 = ~csr_hazard_in_decode_execute; // @[CsrControlUnit.scala 56:170]
  wire  csr_hazard_in_decode_memory = _T_14 & io_csr_wr_in_memory & ~csr_hazard_in_decode_execute & _T_19; // @[CsrControlUnit.scala 56:200]
  wire  csr_hazard_in_decode_writeback = _T_26 & io_csr_wr_in_writeback & _T_51 & ~csr_hazard_in_decode_memory & _T_33; // @[CsrControlUnit.scala 57:245]
  wire [1:0] _GEN_1 = hazard_in_decode_memory ? 2'h2 : {{1'd0}, hazard_in_decode_execute}; // @[CsrControlUnit.scala 64:33 CsrControlUnit.scala 65:20]
  wire [1:0] _GEN_2 = hazard_in_decode_writeback ? 2'h3 : _GEN_1; // @[CsrControlUnit.scala 69:36 CsrControlUnit.scala 70:20]
  wire [2:0] _GEN_3 = csr_hazard_in_decode_execute ? 3'h4 : {{1'd0}, _GEN_2}; // @[CsrControlUnit.scala 73:38 CsrControlUnit.scala 74:20]
  wire [2:0] _GEN_4 = csr_hazard_in_decode_memory ? 3'h5 : _GEN_3; // @[CsrControlUnit.scala 77:37 CsrControlUnit.scala 78:20]
  wire  _T_72 = ~io_load_inst_in_execute & ~io_load_inst_in_memory; // @[CsrControlUnit.scala 88:42]
  wire  _GEN_7 = io_load_inst_in_memory & io_dccm_rvalid_i | _T_72; // @[CsrControlUnit.scala 86:54 CsrControlUnit.scala 87:22]
  assign io_forward_rs1 = csr_hazard_in_decode_writeback ? 3'h6 : _GEN_4; // @[CsrControlUnit.scala 81:40 CsrControlUnit.scala 82:20]
  assign io_csr_op_en_o = io_csr_inst_in_decode & _GEN_7; // @[CsrControlUnit.scala 85:31 CsrControlUnit.scala 41:18]
endmodule
module Decode(
  input         clock,
  input         reset,
  input  [31:0] io_IF_ID_inst,
  input  [31:0] io_IF_ID_pc,
  input  [31:0] io_IF_ID_pc4,
  input         io_MEM_WB_ctrl_regWr,
  input         io_MEM_WB_ctrl_csrWen,
  input  [4:0]  io_MEM_WB_rd_sel,
  input         io_ID_EX_ctrl_MemRd,
  input         io_ID_EX_ctrl_regWr,
  input         io_ID_EX_ctrl_csrWen,
  input         io_EX_MEM_ctrl_csrWen,
  input  [4:0]  io_ID_EX_rd_sel,
  input  [4:0]  io_EX_MEM_rd_sel,
  input         io_EX_MEM_ctrl_MemRd,
  input         io_EX_MEM_ctrl_regWr,
  input         io_MEM_WB_ctrl_MemRd,
  input  [31:0] io_alu_output,
  input  [31:0] io_EX_MEM_alu_output,
  input  [31:0] io_dmem_memOut,
  input         io_dccm_rvalid_i,
  input  [31:0] io_writeback_write_data,
  input  [31:0] io_MEM_WB_csr_rdata_i,
  input  [31:0] io_EX_MEM_csr_rdata_i,
  input  [31:0] io_ID_EX_csr_rdata_i,
  input  [31:0] io_fetch_csr_if_pc,
  input         io_fetch_csr_save_if,
  input  [5:0]  io_fetch_exc_cause_i,
  input         io_fetch_csr_save_cause_i,
  input         io_execute_regwrite,
  input         io_mem_regwrite,
  input         io_wb_regwrite,
  output [31:0] io_pc_out,
  output [31:0] io_pc4_out,
  output [31:0] io_inst_op_out,
  output [2:0]  io_func3_out,
  output [6:0]  io_func7_out,
  output [4:0]  io_rd_sel_out,
  output [4:0]  io_rs1_sel_out,
  output [4:0]  io_rs2_sel_out,
  output [31:0] io_rs1_out,
  output [31:0] io_rs2_out,
  output [31:0] io_csr_rdata_o,
  output [31:0] io_imm_out,
  output [31:0] io_sb_imm,
  output [31:0] io_uj_imm,
  output [31:0] io_jalr_output,
  output        io_branchLogic_output,
  output [31:0] io_hazardDetection_pc_out,
  output [31:0] io_hazardDetection_inst_out,
  output [31:0] io_hazardDetection_current_pc_out,
  output        io_hazardDetection_pc_forward,
  output        io_hazardDetection_inst_forward,
  output        io_ctrl_MemWr_out,
  output        io_ctrl_MemRd_out,
  output        io_ctrl_Branch_out,
  output        io_ctrl_RegWr_out,
  output        io_ctrl_CsrWen_out,
  output        io_ctrl_MemToReg_out,
  output [3:0]  io_ctrl_AluOp_out,
  output [1:0]  io_ctrl_OpA_sel_out,
  output        io_ctrl_OpB_sel_out,
  output [1:0]  io_ctrl_next_pc_sel_out,
  output        io_fetch_irq_pending_o,
  output        io_fetch_csr_mstatus_mie_o,
  output [31:0] io_fetch_csr_mtvec_o,
  output [31:0] io_fetch_csr_mepc_o,
  output        io_fetch_mret_inst_o
);
  wire [31:0] hazardDetection_io_IF_ID_INST; // @[Decode.scala 95:31]
  wire  hazardDetection_io_ID_EX_MEMREAD; // @[Decode.scala 95:31]
  wire [4:0] hazardDetection_io_ID_EX_REGRD; // @[Decode.scala 95:31]
  wire [31:0] hazardDetection_io_pc_in; // @[Decode.scala 95:31]
  wire [31:0] hazardDetection_io_current_pc; // @[Decode.scala 95:31]
  wire  hazardDetection_io_IF_ID_MEMREAD; // @[Decode.scala 95:31]
  wire  hazardDetection_io_inst_forward; // @[Decode.scala 95:31]
  wire  hazardDetection_io_pc_forward; // @[Decode.scala 95:31]
  wire  hazardDetection_io_ctrl_forward; // @[Decode.scala 95:31]
  wire [31:0] hazardDetection_io_inst_out; // @[Decode.scala 95:31]
  wire [31:0] hazardDetection_io_pc_out; // @[Decode.scala 95:31]
  wire [31:0] hazardDetection_io_current_pc_out; // @[Decode.scala 95:31]
  wire [6:0] control_io_in_opcode; // @[Decode.scala 96:23]
  wire [6:0] control_io_func7; // @[Decode.scala 96:23]
  wire [2:0] control_io_func3; // @[Decode.scala 96:23]
  wire  control_io_out_memWrite; // @[Decode.scala 96:23]
  wire  control_io_out_branch; // @[Decode.scala 96:23]
  wire  control_io_out_memRead; // @[Decode.scala 96:23]
  wire  control_io_out_regWrite; // @[Decode.scala 96:23]
  wire  control_io_csr_we_o; // @[Decode.scala 96:23]
  wire  control_io_csr_imm_type; // @[Decode.scala 96:23]
  wire [1:0] control_io_csr_op_o; // @[Decode.scala 96:23]
  wire  control_io_out_memToReg; // @[Decode.scala 96:23]
  wire [3:0] control_io_out_aluOp; // @[Decode.scala 96:23]
  wire [1:0] control_io_out_operand_a_sel; // @[Decode.scala 96:23]
  wire  control_io_out_operand_b_sel; // @[Decode.scala 96:23]
  wire [1:0] control_io_out_extend_sel; // @[Decode.scala 96:23]
  wire [1:0] control_io_out_next_pc_sel; // @[Decode.scala 96:23]
  wire [4:0] decodeForwardUnit_io_ID_EX_REGRD; // @[Decode.scala 97:33]
  wire  decodeForwardUnit_io_ID_EX_MEMRD; // @[Decode.scala 97:33]
  wire [4:0] decodeForwardUnit_io_EX_MEM_REGRD; // @[Decode.scala 97:33]
  wire  decodeForwardUnit_io_EX_MEM_MEMRD; // @[Decode.scala 97:33]
  wire [4:0] decodeForwardUnit_io_MEM_WB_REGRD; // @[Decode.scala 97:33]
  wire  decodeForwardUnit_io_MEM_WB_MEMRD; // @[Decode.scala 97:33]
  wire  decodeForwardUnit_io_execute_regwrite; // @[Decode.scala 97:33]
  wire  decodeForwardUnit_io_mem_regwrite; // @[Decode.scala 97:33]
  wire  decodeForwardUnit_io_wb_regwrite; // @[Decode.scala 97:33]
  wire [4:0] decodeForwardUnit_io_rs1_sel; // @[Decode.scala 97:33]
  wire [4:0] decodeForwardUnit_io_rs2_sel; // @[Decode.scala 97:33]
  wire  decodeForwardUnit_io_ctrl_branch; // @[Decode.scala 97:33]
  wire [3:0] decodeForwardUnit_io_forward_rs1; // @[Decode.scala 97:33]
  wire [3:0] decodeForwardUnit_io_forward_rs2; // @[Decode.scala 97:33]
  wire [31:0] branchLogic_io_in_rs1; // @[Decode.scala 98:27]
  wire [31:0] branchLogic_io_in_rs2; // @[Decode.scala 98:27]
  wire [2:0] branchLogic_io_in_func3; // @[Decode.scala 98:27]
  wire  branchLogic_io_output; // @[Decode.scala 98:27]
  wire  reg_file_clock; // @[Decode.scala 99:24]
  wire  reg_file_reset; // @[Decode.scala 99:24]
  wire  reg_file_io_regWrite; // @[Decode.scala 99:24]
  wire [4:0] reg_file_io_rd_sel; // @[Decode.scala 99:24]
  wire [4:0] reg_file_io_rs1_sel; // @[Decode.scala 99:24]
  wire [4:0] reg_file_io_rs2_sel; // @[Decode.scala 99:24]
  wire [31:0] reg_file_io_writeData; // @[Decode.scala 99:24]
  wire [31:0] reg_file_io_rs1; // @[Decode.scala 99:24]
  wire [31:0] reg_file_io_rs2; // @[Decode.scala 99:24]
  wire [31:0] imm_generation_io_instruction; // @[Decode.scala 100:30]
  wire [31:0] imm_generation_io_pc; // @[Decode.scala 100:30]
  wire [31:0] imm_generation_io_s_imm; // @[Decode.scala 100:30]
  wire [31:0] imm_generation_io_sb_imm; // @[Decode.scala 100:30]
  wire [31:0] imm_generation_io_u_imm; // @[Decode.scala 100:30]
  wire [31:0] imm_generation_io_uj_imm; // @[Decode.scala 100:30]
  wire [31:0] imm_generation_io_i_imm; // @[Decode.scala 100:30]
  wire [4:0] structuralDetector_io_rs1_sel; // @[Decode.scala 101:34]
  wire [4:0] structuralDetector_io_rs2_sel; // @[Decode.scala 101:34]
  wire  structuralDetector_io_MEM_WB_regWr; // @[Decode.scala 101:34]
  wire [4:0] structuralDetector_io_MEM_WB_REGRD; // @[Decode.scala 101:34]
  wire [6:0] structuralDetector_io_inst_op_in; // @[Decode.scala 101:34]
  wire  structuralDetector_io_fwd_rs1; // @[Decode.scala 101:34]
  wire  structuralDetector_io_fwd_rs2; // @[Decode.scala 101:34]
  wire [31:0] jalr_io_input_a; // @[Decode.scala 102:20]
  wire [31:0] jalr_io_input_b; // @[Decode.scala 102:20]
  wire [31:0] jalr_io_output; // @[Decode.scala 102:20]
  wire  csrRegFile_clock; // @[Decode.scala 103:26]
  wire  csrRegFile_reset; // @[Decode.scala 103:26]
  wire [31:0] csrRegFile_io_o_csr_mtvec; // @[Decode.scala 103:26]
  wire  csrRegFile_io_i_csr_access; // @[Decode.scala 103:26]
  wire [11:0] csrRegFile_io_i_csr_addr; // @[Decode.scala 103:26]
  wire [31:0] csrRegFile_io_i_csr_wdata; // @[Decode.scala 103:26]
  wire [1:0] csrRegFile_io_i_csr_op; // @[Decode.scala 103:26]
  wire  csrRegFile_io_i_csr_op_en; // @[Decode.scala 103:26]
  wire [31:0] csrRegFile_io_o_csr_rdata; // @[Decode.scala 103:26]
  wire  csrRegFile_io_o_irq_pending; // @[Decode.scala 103:26]
  wire [2:0] csrRegFile_io_o_irqs; // @[Decode.scala 103:26]
  wire  csrRegFile_io_o_csr_mstatus_mie; // @[Decode.scala 103:26]
  wire [31:0] csrRegFile_io_o_csr_mepc; // @[Decode.scala 103:26]
  wire [31:0] csrRegFile_io_i_pc_if; // @[Decode.scala 103:26]
  wire  csrRegFile_io_i_csr_save_if; // @[Decode.scala 103:26]
  wire  csrRegFile_io_i_csr_restore_mret; // @[Decode.scala 103:26]
  wire  csrRegFile_io_i_csr_save_cause; // @[Decode.scala 103:26]
  wire [5:0] csrRegFile_io_i_csr_mcause; // @[Decode.scala 103:26]
  wire  csrRegFile_io_o_illegal_csr_insn; // @[Decode.scala 103:26]
  wire  csrControlUnit_io_reg_wr_in_execute; // @[Decode.scala 104:30]
  wire [4:0] csrControlUnit_io_rd_sel_in_execute; // @[Decode.scala 104:30]
  wire  csrControlUnit_io_csr_wr_in_execute; // @[Decode.scala 104:30]
  wire  csrControlUnit_io_reg_wr_in_memory; // @[Decode.scala 104:30]
  wire [4:0] csrControlUnit_io_rd_sel_in_memory; // @[Decode.scala 104:30]
  wire  csrControlUnit_io_csr_wr_in_memory; // @[Decode.scala 104:30]
  wire  csrControlUnit_io_reg_wr_in_writeback; // @[Decode.scala 104:30]
  wire [4:0] csrControlUnit_io_rd_sel_in_writeback; // @[Decode.scala 104:30]
  wire  csrControlUnit_io_csr_wr_in_writeback; // @[Decode.scala 104:30]
  wire [4:0] csrControlUnit_io_rs1_sel_in_decode; // @[Decode.scala 104:30]
  wire  csrControlUnit_io_csr_inst_in_decode; // @[Decode.scala 104:30]
  wire  csrControlUnit_io_csr_imm_inst_in_decode; // @[Decode.scala 104:30]
  wire  csrControlUnit_io_load_inst_in_execute; // @[Decode.scala 104:30]
  wire  csrControlUnit_io_load_inst_in_memory; // @[Decode.scala 104:30]
  wire  csrControlUnit_io_dccm_rvalid_i; // @[Decode.scala 104:30]
  wire [2:0] csrControlUnit_io_forward_rs1; // @[Decode.scala 104:30]
  wire  csrControlUnit_io_csr_op_en_o; // @[Decode.scala 104:30]
  wire [31:0] _GEN_0 = decodeForwardUnit_io_forward_rs1 == 4'ha ? $signed(reg_file_io_writeData) : $signed(
    reg_file_io_rs1); // @[Decode.scala 262:62 Decode.scala 264:21 Decode.scala 269:23]
  wire [31:0] _GEN_1 = reg_file_io_rs1; // @[Decode.scala 262:62 Decode.scala 265:27 Decode.scala 268:29]
  wire [31:0] _GEN_2 = decodeForwardUnit_io_forward_rs1 == 4'h9 ? $signed(io_dmem_memOut) : $signed(_GEN_0); // @[Decode.scala 258:62 Decode.scala 260:21]
  wire [31:0] _GEN_3 = decodeForwardUnit_io_forward_rs1 == 4'h9 ? $signed(reg_file_io_rs1) : $signed(_GEN_1); // @[Decode.scala 258:62 Decode.scala 261:27]
  wire [31:0] _GEN_4 = decodeForwardUnit_io_forward_rs1 == 4'h8 ? $signed(reg_file_io_writeData) : $signed(_GEN_2); // @[Decode.scala 254:62 Decode.scala 256:21]
  wire [31:0] _GEN_5 = decodeForwardUnit_io_forward_rs1 == 4'h8 ? $signed(reg_file_io_rs1) : $signed(_GEN_3); // @[Decode.scala 254:62 Decode.scala 257:27]
  wire [31:0] _GEN_6 = decodeForwardUnit_io_forward_rs1 == 4'h7 ? $signed(io_EX_MEM_alu_output) : $signed(_GEN_4); // @[Decode.scala 250:64 Decode.scala 252:21]
  wire [31:0] _GEN_7 = decodeForwardUnit_io_forward_rs1 == 4'h7 ? $signed(reg_file_io_rs1) : $signed(_GEN_5); // @[Decode.scala 250:64 Decode.scala 253:27]
  wire [31:0] _GEN_8 = decodeForwardUnit_io_forward_rs1 == 4'h6 ? $signed(io_alu_output) : $signed(_GEN_6); // @[Decode.scala 246:63 Decode.scala 248:23]
  wire [31:0] _GEN_9 = decodeForwardUnit_io_forward_rs1 == 4'h6 ? $signed(reg_file_io_rs1) : $signed(_GEN_7); // @[Decode.scala 246:63 Decode.scala 249:29]
  wire [31:0] _GEN_10 = decodeForwardUnit_io_forward_rs1 == 4'h5 ? $signed(reg_file_io_writeData) : $signed(_GEN_9); // @[Decode.scala 236:62 Decode.scala 238:27]
  wire [31:0] _GEN_11 = decodeForwardUnit_io_forward_rs1 == 4'h5 ? $signed(reg_file_io_rs1) : $signed(_GEN_8); // @[Decode.scala 236:62 Decode.scala 239:21]
  wire [31:0] _GEN_12 = decodeForwardUnit_io_forward_rs1 == 4'h4 ? $signed(io_dmem_memOut) : $signed(_GEN_10); // @[Decode.scala 232:62 Decode.scala 234:27]
  wire [31:0] _GEN_13 = decodeForwardUnit_io_forward_rs1 == 4'h4 ? $signed(reg_file_io_rs1) : $signed(_GEN_11); // @[Decode.scala 232:62 Decode.scala 235:21]
  wire [31:0] _GEN_14 = decodeForwardUnit_io_forward_rs1 == 4'h3 ? $signed(reg_file_io_writeData) : $signed(_GEN_12); // @[Decode.scala 228:62 Decode.scala 230:27]
  wire [31:0] _GEN_15 = decodeForwardUnit_io_forward_rs1 == 4'h3 ? $signed(reg_file_io_rs1) : $signed(_GEN_13); // @[Decode.scala 228:62 Decode.scala 231:21]
  wire [31:0] _GEN_16 = decodeForwardUnit_io_forward_rs1 == 4'h2 ? $signed(io_EX_MEM_alu_output) : $signed(_GEN_14); // @[Decode.scala 224:62 Decode.scala 226:27]
  wire [31:0] _GEN_17 = decodeForwardUnit_io_forward_rs1 == 4'h2 ? $signed(reg_file_io_rs1) : $signed(_GEN_15); // @[Decode.scala 224:62 Decode.scala 227:21]
  wire [31:0] _GEN_18 = decodeForwardUnit_io_forward_rs1 == 4'h1 ? $signed(io_alu_output) : $signed(_GEN_16); // @[Decode.scala 220:62 Decode.scala 222:27]
  wire [31:0] _GEN_19 = decodeForwardUnit_io_forward_rs1 == 4'h1 ? $signed(reg_file_io_rs1) : $signed(_GEN_17); // @[Decode.scala 220:62 Decode.scala 223:21]
  wire [31:0] _GEN_22 = decodeForwardUnit_io_forward_rs2 == 4'h5 ? $signed(reg_file_io_writeData) : $signed(
    reg_file_io_rs2); // @[Decode.scala 289:62 Decode.scala 291:27 Decode.scala 294:29]
  wire [31:0] _GEN_23 = decodeForwardUnit_io_forward_rs2 == 4'h4 ? $signed(io_dmem_memOut) : $signed(_GEN_22); // @[Decode.scala 286:62 Decode.scala 288:27]
  wire [31:0] _GEN_24 = decodeForwardUnit_io_forward_rs2 == 4'h3 ? $signed(reg_file_io_writeData) : $signed(_GEN_23); // @[Decode.scala 283:62 Decode.scala 285:27]
  wire [31:0] _GEN_25 = decodeForwardUnit_io_forward_rs2 == 4'h2 ? $signed(io_EX_MEM_alu_output) : $signed(_GEN_24); // @[Decode.scala 280:62 Decode.scala 282:27]
  wire [31:0] _GEN_26 = decodeForwardUnit_io_forward_rs2 == 4'h1 ? $signed(io_alu_output) : $signed(_GEN_25); // @[Decode.scala 277:62 Decode.scala 279:27]
  wire  _T_44 = io_IF_ID_inst[6:0] != 7'h37; // @[Decode.scala 341:43]
  wire [31:0] _T_45 = io_IF_ID_inst[6:0] != 7'h37 ? $signed(reg_file_io_writeData) : $signed(32'sh0); // @[Decode.scala 341:22]
  wire [31:0] _T_48 = _T_44 ? $signed(reg_file_io_rs1) : $signed(32'sh0); // @[Decode.scala 343:22]
  wire [31:0] _T_55 = _T_44 ? $signed(reg_file_io_rs2) : $signed(32'sh0); // @[Decode.scala 353:22]
  wire [31:0] _GEN_40 = control_io_out_extend_sel == 2'h2 ? $signed(imm_generation_io_u_imm) : $signed(32'sh0); // @[Decode.scala 362:53 Decode.scala 364:13 Decode.scala 366:13]
  wire [31:0] _GEN_41 = control_io_out_extend_sel == 2'h1 ? $signed(imm_generation_io_s_imm) : $signed(_GEN_40); // @[Decode.scala 359:53 Decode.scala 361:13]
  wire [31:0] _T_73 = io_EX_MEM_ctrl_MemRd ? io_dmem_memOut : io_EX_MEM_alu_output; // @[Decode.scala 420:23]
  wire [31:0] _GEN_43 = csrControlUnit_io_forward_rs1 == 3'h6 ? io_MEM_WB_csr_rdata_i : reg_file_io_rs1; // @[Decode.scala 429:55 Decode.scala 430:17 Decode.scala 432:17]
  wire [31:0] _GEN_44 = csrControlUnit_io_forward_rs1 == 3'h5 ? io_EX_MEM_csr_rdata_i : _GEN_43; // @[Decode.scala 426:55 Decode.scala 428:17]
  wire [31:0] _GEN_45 = csrControlUnit_io_forward_rs1 == 3'h4 ? io_ID_EX_csr_rdata_i : _GEN_44; // @[Decode.scala 423:55 Decode.scala 425:17]
  wire [31:0] _GEN_46 = csrControlUnit_io_forward_rs1 == 3'h3 ? io_writeback_write_data : _GEN_45; // @[Decode.scala 421:55 Decode.scala 422:17]
  wire [31:0] _GEN_47 = csrControlUnit_io_forward_rs1 == 3'h2 ? _T_73 : _GEN_46; // @[Decode.scala 417:55 Decode.scala 420:17]
  wire [31:0] _GEN_48 = csrControlUnit_io_forward_rs1 == 3'h1 ? io_alu_output : _GEN_47; // @[Decode.scala 415:49 Decode.scala 416:17]
  HazardDetection hazardDetection ( // @[Decode.scala 95:31]
    .io_IF_ID_INST(hazardDetection_io_IF_ID_INST),
    .io_ID_EX_MEMREAD(hazardDetection_io_ID_EX_MEMREAD),
    .io_ID_EX_REGRD(hazardDetection_io_ID_EX_REGRD),
    .io_pc_in(hazardDetection_io_pc_in),
    .io_current_pc(hazardDetection_io_current_pc),
    .io_IF_ID_MEMREAD(hazardDetection_io_IF_ID_MEMREAD),
    .io_inst_forward(hazardDetection_io_inst_forward),
    .io_pc_forward(hazardDetection_io_pc_forward),
    .io_ctrl_forward(hazardDetection_io_ctrl_forward),
    .io_inst_out(hazardDetection_io_inst_out),
    .io_pc_out(hazardDetection_io_pc_out),
    .io_current_pc_out(hazardDetection_io_current_pc_out)
  );
  Control control ( // @[Decode.scala 96:23]
    .io_in_opcode(control_io_in_opcode),
    .io_func7(control_io_func7),
    .io_func3(control_io_func3),
    .io_out_memWrite(control_io_out_memWrite),
    .io_out_branch(control_io_out_branch),
    .io_out_memRead(control_io_out_memRead),
    .io_out_regWrite(control_io_out_regWrite),
    .io_csr_we_o(control_io_csr_we_o),
    .io_csr_imm_type(control_io_csr_imm_type),
    .io_csr_op_o(control_io_csr_op_o),
    .io_out_memToReg(control_io_out_memToReg),
    .io_out_aluOp(control_io_out_aluOp),
    .io_out_operand_a_sel(control_io_out_operand_a_sel),
    .io_out_operand_b_sel(control_io_out_operand_b_sel),
    .io_out_extend_sel(control_io_out_extend_sel),
    .io_out_next_pc_sel(control_io_out_next_pc_sel)
  );
  DecodeForwardUnit decodeForwardUnit ( // @[Decode.scala 97:33]
    .io_ID_EX_REGRD(decodeForwardUnit_io_ID_EX_REGRD),
    .io_ID_EX_MEMRD(decodeForwardUnit_io_ID_EX_MEMRD),
    .io_EX_MEM_REGRD(decodeForwardUnit_io_EX_MEM_REGRD),
    .io_EX_MEM_MEMRD(decodeForwardUnit_io_EX_MEM_MEMRD),
    .io_MEM_WB_REGRD(decodeForwardUnit_io_MEM_WB_REGRD),
    .io_MEM_WB_MEMRD(decodeForwardUnit_io_MEM_WB_MEMRD),
    .io_execute_regwrite(decodeForwardUnit_io_execute_regwrite),
    .io_mem_regwrite(decodeForwardUnit_io_mem_regwrite),
    .io_wb_regwrite(decodeForwardUnit_io_wb_regwrite),
    .io_rs1_sel(decodeForwardUnit_io_rs1_sel),
    .io_rs2_sel(decodeForwardUnit_io_rs2_sel),
    .io_ctrl_branch(decodeForwardUnit_io_ctrl_branch),
    .io_forward_rs1(decodeForwardUnit_io_forward_rs1),
    .io_forward_rs2(decodeForwardUnit_io_forward_rs2)
  );
  BranchLogic branchLogic ( // @[Decode.scala 98:27]
    .io_in_rs1(branchLogic_io_in_rs1),
    .io_in_rs2(branchLogic_io_in_rs2),
    .io_in_func3(branchLogic_io_in_func3),
    .io_output(branchLogic_io_output)
  );
  RegisterFile reg_file ( // @[Decode.scala 99:24]
    .clock(reg_file_clock),
    .reset(reg_file_reset),
    .io_regWrite(reg_file_io_regWrite),
    .io_rd_sel(reg_file_io_rd_sel),
    .io_rs1_sel(reg_file_io_rs1_sel),
    .io_rs2_sel(reg_file_io_rs2_sel),
    .io_writeData(reg_file_io_writeData),
    .io_rs1(reg_file_io_rs1),
    .io_rs2(reg_file_io_rs2)
  );
  ImmediateGeneration imm_generation ( // @[Decode.scala 100:30]
    .io_instruction(imm_generation_io_instruction),
    .io_pc(imm_generation_io_pc),
    .io_s_imm(imm_generation_io_s_imm),
    .io_sb_imm(imm_generation_io_sb_imm),
    .io_u_imm(imm_generation_io_u_imm),
    .io_uj_imm(imm_generation_io_uj_imm),
    .io_i_imm(imm_generation_io_i_imm)
  );
  StructuralDetector structuralDetector ( // @[Decode.scala 101:34]
    .io_rs1_sel(structuralDetector_io_rs1_sel),
    .io_rs2_sel(structuralDetector_io_rs2_sel),
    .io_MEM_WB_regWr(structuralDetector_io_MEM_WB_regWr),
    .io_MEM_WB_REGRD(structuralDetector_io_MEM_WB_REGRD),
    .io_inst_op_in(structuralDetector_io_inst_op_in),
    .io_fwd_rs1(structuralDetector_io_fwd_rs1),
    .io_fwd_rs2(structuralDetector_io_fwd_rs2)
  );
  Jalr jalr ( // @[Decode.scala 102:20]
    .io_input_a(jalr_io_input_a),
    .io_input_b(jalr_io_input_b),
    .io_output(jalr_io_output)
  );
  CsrRegisterFile csrRegFile ( // @[Decode.scala 103:26]
    .clock(csrRegFile_clock),
    .reset(csrRegFile_reset),
    .io_o_csr_mtvec(csrRegFile_io_o_csr_mtvec),
    .io_i_csr_access(csrRegFile_io_i_csr_access),
    .io_i_csr_addr(csrRegFile_io_i_csr_addr),
    .io_i_csr_wdata(csrRegFile_io_i_csr_wdata),
    .io_i_csr_op(csrRegFile_io_i_csr_op),
    .io_i_csr_op_en(csrRegFile_io_i_csr_op_en),
    .io_o_csr_rdata(csrRegFile_io_o_csr_rdata),
    .io_o_irq_pending(csrRegFile_io_o_irq_pending),
    .io_o_irqs(csrRegFile_io_o_irqs),
    .io_o_csr_mstatus_mie(csrRegFile_io_o_csr_mstatus_mie),
    .io_o_csr_mepc(csrRegFile_io_o_csr_mepc),
    .io_i_pc_if(csrRegFile_io_i_pc_if),
    .io_i_csr_save_if(csrRegFile_io_i_csr_save_if),
    .io_i_csr_restore_mret(csrRegFile_io_i_csr_restore_mret),
    .io_i_csr_save_cause(csrRegFile_io_i_csr_save_cause),
    .io_i_csr_mcause(csrRegFile_io_i_csr_mcause),
    .io_o_illegal_csr_insn(csrRegFile_io_o_illegal_csr_insn)
  );
  CsrControlUnit csrControlUnit ( // @[Decode.scala 104:30]
    .io_reg_wr_in_execute(csrControlUnit_io_reg_wr_in_execute),
    .io_rd_sel_in_execute(csrControlUnit_io_rd_sel_in_execute),
    .io_csr_wr_in_execute(csrControlUnit_io_csr_wr_in_execute),
    .io_reg_wr_in_memory(csrControlUnit_io_reg_wr_in_memory),
    .io_rd_sel_in_memory(csrControlUnit_io_rd_sel_in_memory),
    .io_csr_wr_in_memory(csrControlUnit_io_csr_wr_in_memory),
    .io_reg_wr_in_writeback(csrControlUnit_io_reg_wr_in_writeback),
    .io_rd_sel_in_writeback(csrControlUnit_io_rd_sel_in_writeback),
    .io_csr_wr_in_writeback(csrControlUnit_io_csr_wr_in_writeback),
    .io_rs1_sel_in_decode(csrControlUnit_io_rs1_sel_in_decode),
    .io_csr_inst_in_decode(csrControlUnit_io_csr_inst_in_decode),
    .io_csr_imm_inst_in_decode(csrControlUnit_io_csr_imm_inst_in_decode),
    .io_load_inst_in_execute(csrControlUnit_io_load_inst_in_execute),
    .io_load_inst_in_memory(csrControlUnit_io_load_inst_in_memory),
    .io_dccm_rvalid_i(csrControlUnit_io_dccm_rvalid_i),
    .io_forward_rs1(csrControlUnit_io_forward_rs1),
    .io_csr_op_en_o(csrControlUnit_io_csr_op_en_o)
  );
  assign io_pc_out = io_IF_ID_pc; // @[Decode.scala 369:13]
  assign io_pc4_out = io_IF_ID_pc4; // @[Decode.scala 370:14]
  assign io_inst_op_out = {{25'd0}, io_IF_ID_inst[6:0]}; // @[Decode.scala 371:34]
  assign io_func3_out = io_IF_ID_inst[14:12]; // @[Decode.scala 372:32]
  assign io_func7_out = io_IF_ID_inst[31:25]; // @[Decode.scala 373:32]
  assign io_rd_sel_out = io_IF_ID_inst[11:7]; // @[Decode.scala 374:33]
  assign io_rs1_sel_out = io_IF_ID_inst[19:15]; // @[Decode.scala 375:34]
  assign io_rs2_sel_out = io_IF_ID_inst[24:20]; // @[Decode.scala 376:34]
  assign io_rs1_out = structuralDetector_io_fwd_rs1 ? $signed(_T_45) : $signed(_T_48); // @[Decode.scala 337:47 Decode.scala 341:16 Decode.scala 343:16]
  assign io_rs2_out = structuralDetector_io_fwd_rs2 ? $signed(_T_45) : $signed(_T_55); // @[Decode.scala 347:47 Decode.scala 351:16 Decode.scala 353:16]
  assign io_csr_rdata_o = csrRegFile_io_o_csr_rdata; // @[Decode.scala 437:18]
  assign io_imm_out = control_io_out_extend_sel == 2'h0 ? $signed(imm_generation_io_i_imm) : $signed(_GEN_41); // @[Decode.scala 356:47 Decode.scala 358:13]
  assign io_sb_imm = imm_generation_io_sb_imm; // @[Decode.scala 325:13]
  assign io_uj_imm = imm_generation_io_uj_imm; // @[Decode.scala 326:13]
  assign io_jalr_output = jalr_io_output; // @[Decode.scala 327:18]
  assign io_branchLogic_output = branchLogic_io_output; // @[Decode.scala 300:25]
  assign io_hazardDetection_pc_out = hazardDetection_io_pc_out; // @[Decode.scala 182:29]
  assign io_hazardDetection_inst_out = hazardDetection_io_inst_out; // @[Decode.scala 185:31]
  assign io_hazardDetection_current_pc_out = hazardDetection_io_current_pc_out; // @[Decode.scala 183:37]
  assign io_hazardDetection_pc_forward = hazardDetection_io_pc_forward; // @[Decode.scala 184:33]
  assign io_hazardDetection_inst_forward = hazardDetection_io_inst_forward; // @[Decode.scala 186:35]
  assign io_ctrl_MemWr_out = hazardDetection_io_ctrl_forward ? 1'h0 : control_io_out_memWrite; // @[Decode.scala 305:52 Decode.scala 381:23 Decode.scala 395:23]
  assign io_ctrl_MemRd_out = hazardDetection_io_ctrl_forward ? 1'h0 : control_io_out_memRead; // @[Decode.scala 305:52 Decode.scala 382:23 Decode.scala 396:23]
  assign io_ctrl_Branch_out = hazardDetection_io_ctrl_forward ? 1'h0 : control_io_out_branch; // @[Decode.scala 305:52 Decode.scala 383:24 Decode.scala 397:24]
  assign io_ctrl_RegWr_out = hazardDetection_io_ctrl_forward ? 1'h0 : control_io_out_regWrite; // @[Decode.scala 305:52 Decode.scala 384:23 Decode.scala 398:23]
  assign io_ctrl_CsrWen_out = hazardDetection_io_ctrl_forward ? 1'h0 : control_io_csr_we_o; // @[Decode.scala 305:52 Decode.scala 385:24 Decode.scala 399:24]
  assign io_ctrl_MemToReg_out = hazardDetection_io_ctrl_forward ? 1'h0 : control_io_out_memToReg; // @[Decode.scala 305:52 Decode.scala 386:26 Decode.scala 400:26]
  assign io_ctrl_AluOp_out = hazardDetection_io_ctrl_forward ? 4'h0 : control_io_out_aluOp; // @[Decode.scala 305:52 Decode.scala 387:23 Decode.scala 401:23]
  assign io_ctrl_OpA_sel_out = hazardDetection_io_ctrl_forward ? 2'h0 : control_io_out_operand_a_sel; // @[Decode.scala 305:52 Decode.scala 388:25 Decode.scala 402:25]
  assign io_ctrl_OpB_sel_out = hazardDetection_io_ctrl_forward ? 1'h0 : control_io_out_operand_b_sel; // @[Decode.scala 305:52 Decode.scala 389:25 Decode.scala 403:25]
  assign io_ctrl_next_pc_sel_out = hazardDetection_io_ctrl_forward ? 2'h0 : control_io_out_next_pc_sel; // @[Decode.scala 305:52 Decode.scala 390:29 Decode.scala 404:29]
  assign io_fetch_irq_pending_o = csrRegFile_io_o_irq_pending; // @[Decode.scala 149:26]
  assign io_fetch_csr_mstatus_mie_o = csrRegFile_io_o_csr_mstatus_mie; // @[Decode.scala 150:30]
  assign io_fetch_csr_mtvec_o = csrRegFile_io_o_csr_mtvec; // @[Decode.scala 151:24]
  assign io_fetch_csr_mepc_o = csrRegFile_io_o_csr_mepc; // @[Decode.scala 152:23]
  assign io_fetch_mret_inst_o = io_IF_ID_inst[6:0] == 7'h73 & io_IF_ID_inst[14:12] == 3'h0 & io_IF_ID_inst[31:20] == 12'h302
    ; // @[Decode.scala 111:90]
  assign hazardDetection_io_IF_ID_INST = io_IF_ID_inst; // @[Decode.scala 174:33]
  assign hazardDetection_io_ID_EX_MEMREAD = io_ID_EX_ctrl_MemRd; // @[Decode.scala 175:36]
  assign hazardDetection_io_ID_EX_REGRD = io_ID_EX_rd_sel; // @[Decode.scala 176:34]
  assign hazardDetection_io_pc_in = io_IF_ID_pc4; // @[Decode.scala 177:28]
  assign hazardDetection_io_current_pc = io_IF_ID_pc; // @[Decode.scala 178:33]
  assign hazardDetection_io_IF_ID_MEMREAD = control_io_out_memRead; // @[Decode.scala 179:36]
  assign control_io_in_opcode = io_IF_ID_inst[6:0]; // @[Decode.scala 189:40]
  assign control_io_func7 = io_IF_ID_inst[31:25]; // @[Decode.scala 191:36]
  assign control_io_func3 = io_IF_ID_inst[14:12]; // @[Decode.scala 192:36]
  assign decodeForwardUnit_io_ID_EX_REGRD = io_ID_EX_rd_sel; // @[Decode.scala 195:36]
  assign decodeForwardUnit_io_ID_EX_MEMRD = io_ID_EX_ctrl_MemRd; // @[Decode.scala 196:36]
  assign decodeForwardUnit_io_EX_MEM_REGRD = io_EX_MEM_rd_sel; // @[Decode.scala 197:37]
  assign decodeForwardUnit_io_EX_MEM_MEMRD = io_EX_MEM_ctrl_MemRd; // @[Decode.scala 199:37]
  assign decodeForwardUnit_io_MEM_WB_REGRD = io_MEM_WB_rd_sel; // @[Decode.scala 198:37]
  assign decodeForwardUnit_io_MEM_WB_MEMRD = io_MEM_WB_ctrl_MemRd; // @[Decode.scala 200:37]
  assign decodeForwardUnit_io_execute_regwrite = io_execute_regwrite; // @[Decode.scala 205:41]
  assign decodeForwardUnit_io_mem_regwrite = io_mem_regwrite; // @[Decode.scala 206:37]
  assign decodeForwardUnit_io_wb_regwrite = io_wb_regwrite; // @[Decode.scala 207:36]
  assign decodeForwardUnit_io_rs1_sel = io_IF_ID_inst[19:15]; // @[Decode.scala 201:48]
  assign decodeForwardUnit_io_rs2_sel = io_IF_ID_inst[24:20]; // @[Decode.scala 202:48]
  assign decodeForwardUnit_io_ctrl_branch = control_io_out_branch; // @[Decode.scala 203:36]
  assign branchLogic_io_in_rs1 = decodeForwardUnit_io_forward_rs1 == 4'h0 ? $signed(reg_file_io_rs1) : $signed(_GEN_18); // @[Decode.scala 216:56 Decode.scala 218:27]
  assign branchLogic_io_in_rs2 = decodeForwardUnit_io_forward_rs2 == 4'h0 ? $signed(reg_file_io_rs2) : $signed(_GEN_26); // @[Decode.scala 274:56 Decode.scala 276:27]
  assign branchLogic_io_in_func3 = io_IF_ID_inst[14:12]; // @[Decode.scala 209:43]
  assign reg_file_clock = clock;
  assign reg_file_reset = reset;
  assign reg_file_io_regWrite = io_MEM_WB_ctrl_regWr; // @[Decode.scala 315:24]
  assign reg_file_io_rd_sel = io_MEM_WB_rd_sel; // @[Decode.scala 316:22]
  assign reg_file_io_rs1_sel = io_IF_ID_inst[19:15]; // @[Decode.scala 313:39]
  assign reg_file_io_rs2_sel = io_IF_ID_inst[24:20]; // @[Decode.scala 314:39]
  assign reg_file_io_writeData = io_MEM_WB_ctrl_csrWen ? $signed(io_MEM_WB_csr_rdata_i) : $signed(
    io_writeback_write_data); // @[Decode.scala 317:31]
  assign imm_generation_io_instruction = io_IF_ID_inst; // @[Decode.scala 321:33]
  assign imm_generation_io_pc = io_IF_ID_pc; // @[Decode.scala 322:24]
  assign structuralDetector_io_rs1_sel = io_IF_ID_inst[19:15]; // @[Decode.scala 330:49]
  assign structuralDetector_io_rs2_sel = io_IF_ID_inst[24:20]; // @[Decode.scala 331:49]
  assign structuralDetector_io_MEM_WB_regWr = io_MEM_WB_ctrl_regWr; // @[Decode.scala 333:38]
  assign structuralDetector_io_MEM_WB_REGRD = io_MEM_WB_rd_sel; // @[Decode.scala 332:38]
  assign structuralDetector_io_inst_op_in = io_IF_ID_inst[6:0]; // @[Decode.scala 334:52]
  assign jalr_io_input_a = decodeForwardUnit_io_forward_rs1 == 4'h0 ? $signed(reg_file_io_rs1) : $signed(_GEN_19); // @[Decode.scala 216:56 Decode.scala 219:21]
  assign jalr_io_input_b = imm_generation_io_i_imm; // @[Decode.scala 297:19]
  assign csrRegFile_clock = clock;
  assign csrRegFile_reset = reset;
  assign csrRegFile_io_i_csr_access = control_io_csr_we_o; // @[Decode.scala 117:30]
  assign csrRegFile_io_i_csr_addr = io_IF_ID_inst[31:20]; // @[Decode.scala 121:44]
  assign csrRegFile_io_i_csr_wdata = control_io_csr_imm_type ? {{27'd0}, io_IF_ID_inst[19:15]} : _GEN_48; // @[Decode.scala 412:41 Decode.scala 413:15]
  assign csrRegFile_io_i_csr_op = control_io_csr_op_o; // @[Decode.scala 119:26]
  assign csrRegFile_io_i_csr_op_en = csrControlUnit_io_csr_op_en_o; // @[Decode.scala 120:29]
  assign csrRegFile_io_i_pc_if = io_fetch_csr_if_pc; // @[Decode.scala 126:25]
  assign csrRegFile_io_i_csr_save_if = io_fetch_csr_save_if; // @[Decode.scala 129:31]
  assign csrRegFile_io_i_csr_restore_mret = io_IF_ID_inst[6:0] == 7'h73 & io_IF_ID_inst[14:12] == 3'h0 & io_IF_ID_inst[
    31:20] == 12'h302; // @[Decode.scala 111:90]
  assign csrRegFile_io_i_csr_save_cause = io_fetch_csr_save_cause_i; // @[Decode.scala 135:34]
  assign csrRegFile_io_i_csr_mcause = io_fetch_exc_cause_i; // @[Decode.scala 134:30]
  assign csrControlUnit_io_reg_wr_in_execute = io_ID_EX_ctrl_regWr; // @[Decode.scala 156:39]
  assign csrControlUnit_io_rd_sel_in_execute = io_ID_EX_rd_sel; // @[Decode.scala 157:39]
  assign csrControlUnit_io_csr_wr_in_execute = io_ID_EX_ctrl_csrWen; // @[Decode.scala 167:39]
  assign csrControlUnit_io_reg_wr_in_memory = io_EX_MEM_ctrl_regWr; // @[Decode.scala 158:38]
  assign csrControlUnit_io_rd_sel_in_memory = io_EX_MEM_rd_sel; // @[Decode.scala 159:38]
  assign csrControlUnit_io_csr_wr_in_memory = io_EX_MEM_ctrl_csrWen; // @[Decode.scala 168:38]
  assign csrControlUnit_io_reg_wr_in_writeback = io_MEM_WB_ctrl_regWr; // @[Decode.scala 160:41]
  assign csrControlUnit_io_rd_sel_in_writeback = io_MEM_WB_rd_sel; // @[Decode.scala 161:41]
  assign csrControlUnit_io_csr_wr_in_writeback = io_MEM_WB_ctrl_csrWen; // @[Decode.scala 169:41]
  assign csrControlUnit_io_rs1_sel_in_decode = io_IF_ID_inst[19:15]; // @[Decode.scala 162:55]
  assign csrControlUnit_io_csr_inst_in_decode = control_io_csr_we_o; // @[Decode.scala 163:40]
  assign csrControlUnit_io_csr_imm_inst_in_decode = control_io_csr_imm_type; // @[Decode.scala 170:44]
  assign csrControlUnit_io_load_inst_in_execute = io_ID_EX_ctrl_MemRd; // @[Decode.scala 164:42]
  assign csrControlUnit_io_load_inst_in_memory = io_EX_MEM_ctrl_MemRd; // @[Decode.scala 165:41]
  assign csrControlUnit_io_dccm_rvalid_i = io_dccm_rvalid_i; // @[Decode.scala 166:35]
endmodule
module ForwardUnit(
  input  [4:0] io_EX_MEM_REGRD,
  input  [4:0] io_MEM_WB_REGRD,
  input  [4:0] io_ID_EX_REGRS1,
  input  [4:0] io_ID_EX_REGRS2,
  input  [6:0] io_ID_EX_inst_op,
  input        io_EX_MEM_REGWR,
  input        io_MEM_WB_REGWR,
  output [1:0] io_forward_a,
  output [1:0] io_forward_b
);
  wire  _T_2 = io_EX_MEM_REGWR & io_EX_MEM_REGRD != 5'h0; // @[ForwardUnit.scala 23:37]
  wire  _T_4 = io_EX_MEM_REGWR & io_EX_MEM_REGRD != 5'h0 & io_EX_MEM_REGRD == io_ID_EX_REGRS1; // @[ForwardUnit.scala 23:71]
  wire  _T_5 = io_EX_MEM_REGRD == io_ID_EX_REGRS2; // @[ForwardUnit.scala 23:132]
  wire  _T_6 = io_EX_MEM_REGWR & io_EX_MEM_REGRD != 5'h0 & io_EX_MEM_REGRD == io_ID_EX_REGRS1 & io_EX_MEM_REGRD ==
    io_ID_EX_REGRS2; // @[ForwardUnit.scala 23:112]
  wire  _T_7 = io_ID_EX_inst_op != 7'h37; // @[ForwardUnit.scala 23:173]
  wire  _T_13 = _T_2 & _T_5; // @[ForwardUnit.scala 31:78]
  wire  _T_15 = _T_2 & _T_5 & _T_7; // @[ForwardUnit.scala 31:119]
  wire  _T_22 = _T_4 & _T_7; // @[ForwardUnit.scala 34:119]
  wire  _GEN_2 = _T_2 & _T_5 & _T_7 ? 1'h0 : _T_22; // @[ForwardUnit.scala 31:157 ForwardUnit.scala 17:18]
  wire  _GEN_3 = io_EX_MEM_REGWR & io_EX_MEM_REGRD != 5'h0 & io_EX_MEM_REGRD == io_ID_EX_REGRS1 & io_EX_MEM_REGRD ==
    io_ID_EX_REGRS2 & io_ID_EX_inst_op != 7'h37 | _GEN_2; // @[ForwardUnit.scala 23:191 ForwardUnit.scala 29:22]
  wire  _GEN_4 = io_EX_MEM_REGWR & io_EX_MEM_REGRD != 5'h0 & io_EX_MEM_REGRD == io_ID_EX_REGRS1 & io_EX_MEM_REGRD ==
    io_ID_EX_REGRS2 & io_ID_EX_inst_op != 7'h37 | _T_15; // @[ForwardUnit.scala 23:191 ForwardUnit.scala 30:22]
  wire  _T_25 = io_MEM_WB_REGWR & io_MEM_WB_REGRD != 5'h0; // @[ForwardUnit.scala 42:37]
  wire  _T_35 = io_MEM_WB_REGRD == io_ID_EX_REGRS1; // @[ForwardUnit.scala 42:244]
  wire  _T_37 = io_MEM_WB_REGRD == io_ID_EX_REGRS2; // @[ForwardUnit.scala 42:285]
  wire [1:0] _GEN_5 = _T_25 & ~_T_4 & _T_35 & _T_7 ? 2'h2 : {{1'd0}, _GEN_3}; // @[ForwardUnit.scala 48:270 ForwardUnit.scala 49:22]
  wire [1:0] _GEN_6 = _T_25 & ~_T_13 & _T_37 & _T_7 ? 2'h2 : {{1'd0}, _GEN_4}; // @[ForwardUnit.scala 45:269 ForwardUnit.scala 46:22]
  wire [1:0] _GEN_7 = _T_25 & ~_T_13 & _T_37 & _T_7 ? {{1'd0}, _GEN_3} : _GEN_5; // @[ForwardUnit.scala 45:269]
  assign io_forward_a = io_MEM_WB_REGWR & io_MEM_WB_REGRD != 5'h0 & ~_T_6 & io_MEM_WB_REGRD == io_ID_EX_REGRS1 &
    io_MEM_WB_REGRD == io_ID_EX_REGRS2 & _T_7 ? 2'h2 : _GEN_7; // @[ForwardUnit.scala 42:344 ForwardUnit.scala 43:22]
  assign io_forward_b = io_MEM_WB_REGWR & io_MEM_WB_REGRD != 5'h0 & ~_T_6 & io_MEM_WB_REGRD == io_ID_EX_REGRS1 &
    io_MEM_WB_REGRD == io_ID_EX_REGRS2 & _T_7 ? 2'h2 : _GEN_6; // @[ForwardUnit.scala 42:344 ForwardUnit.scala 44:22]
endmodule
module Alu(
  input  [31:0] io_oper_a,
  input  [31:0] io_oper_b,
  input  [4:0]  io_aluCtrl,
  output [31:0] io_output
);
  wire [31:0] _T_3 = $signed(io_oper_a) + $signed(io_oper_b); // @[Alu.scala 19:32]
  wire [62:0] _GEN_31 = {{31{io_oper_a[31]}},io_oper_a}; // @[Alu.scala 23:32]
  wire [62:0] _T_6 = $signed(_GEN_31) << io_oper_b[4:0]; // @[Alu.scala 23:32]
  wire [1:0] _GEN_0 = $signed(io_oper_a) < $signed(io_oper_b) ? $signed(2'sh1) : $signed(2'sh0); // @[Alu.scala 26:37 Alu.scala 27:23 Alu.scala 29:23]
  wire [1:0] _GEN_1 = io_oper_a < io_oper_b ? $signed(2'sh1) : $signed(2'sh0); // @[Alu.scala 33:51 Alu.scala 34:23 Alu.scala 36:23]
  wire [31:0] _T_17 = $signed(io_oper_a) ^ $signed(io_oper_b); // @[Alu.scala 40:32]
  wire [31:0] _T_22 = $signed(io_oper_a) >>> io_oper_b[4:0]; // @[Alu.scala 49:32]
  wire [31:0] _T_25 = $signed(io_oper_a) | $signed(io_oper_b); // @[Alu.scala 52:32]
  wire [31:0] _T_28 = $signed(io_oper_a) & $signed(io_oper_b); // @[Alu.scala 55:32]
  wire [31:0] _T_32 = $signed(io_oper_a) - $signed(io_oper_b); // @[Alu.scala 58:32]
  wire  _T_34 = $signed(io_oper_a) == $signed(io_oper_b); // @[Alu.scala 62:24]
  wire [1:0] _GEN_2 = $signed(io_oper_a) == $signed(io_oper_b) ? $signed(2'sh1) : $signed(2'sh0); // @[Alu.scala 62:39 Alu.scala 63:23 Alu.scala 65:23]
  wire [1:0] _GEN_3 = ~_T_34 ? $signed(2'sh1) : $signed(2'sh0); // @[Alu.scala 69:42 Alu.scala 70:23 Alu.scala 72:23]
  wire [1:0] _GEN_5 = $signed(io_oper_a) >= $signed(io_oper_b) ? $signed(2'sh1) : $signed(2'sh0); // @[Alu.scala 83:38 Alu.scala 84:23 Alu.scala 86:23]
  wire [1:0] _GEN_6 = io_oper_a >= io_oper_b ? $signed(2'sh1) : $signed(2'sh0); // @[Alu.scala 90:52 Alu.scala 91:23 Alu.scala 93:23]
  wire  _T_47 = io_aluCtrl == 5'hb; // @[Alu.scala 99:26]
  wire  _T_48 = io_aluCtrl == 5'h1e; // @[Alu.scala 104:26]
  wire [63:0] _T_49 = $signed(io_oper_a) * $signed(io_oper_b); // @[Alu.scala 106:32]
  wire  _T_50 = io_aluCtrl == 5'h1d; // @[Alu.scala 108:26]
  wire [32:0] _T_51 = $signed(io_oper_a) / $signed(io_oper_b); // @[Alu.scala 110:32]
  wire  _T_52 = io_aluCtrl == 5'h1b; // @[Alu.scala 112:26]
  wire [31:0] _T_56 = io_oper_a / io_oper_b; // @[Alu.scala 114:64]
  wire  _T_57 = io_aluCtrl == 5'h1a; // @[Alu.scala 116:26]
  wire [31:0] _GEN_4 = $signed(io_oper_a) % $signed(io_oper_b); // @[Alu.scala 118:32]
  wire [31:0] _T_58 = _GEN_4[31:0]; // @[Alu.scala 118:32]
  wire  _T_59 = io_aluCtrl == 5'h19; // @[Alu.scala 120:26]
  wire [31:0] _T_63 = io_oper_a % io_oper_b; // @[Alu.scala 122:64]
  wire  _T_64 = io_aluCtrl == 5'h18; // @[Alu.scala 124:26]
  wire [31:0] _T_67 = _T_49[63:32]; // @[Alu.scala 127:51]
  wire  _T_68 = io_aluCtrl == 5'h13; // @[Alu.scala 129:26]
  wire [32:0] _T_70 = {1'b0,$signed(io_oper_b)}; // @[Alu.scala 131:49]
  wire [64:0] _T_71 = $signed(io_oper_a) * $signed(_T_70); // @[Alu.scala 131:49]
  wire [63:0] _T_73 = _T_71[63:0]; // @[Alu.scala 131:49]
  wire [31:0] _T_75 = _T_73[63:32]; // @[Alu.scala 132:53]
  wire [63:0] _T_79 = io_oper_a * io_oper_b; // @[Alu.scala 136:55]
  wire [31:0] _T_81 = _T_79[63:32]; // @[Alu.scala 137:52]
  wire [31:0] _GEN_8 = _T_68 ? $signed(_T_75) : $signed(_T_81); // @[Alu.scala 130:5 Alu.scala 132:19]
  wire [31:0] _GEN_9 = _T_64 ? $signed(_T_67) : $signed(_GEN_8); // @[Alu.scala 125:5 Alu.scala 127:19]
  wire [31:0] _GEN_10 = _T_59 ? $signed(_T_63) : $signed(_GEN_9); // @[Alu.scala 121:5 Alu.scala 122:19]
  wire [31:0] _GEN_11 = _T_57 ? $signed(_T_58) : $signed(_GEN_10); // @[Alu.scala 117:5 Alu.scala 118:19]
  wire [31:0] _GEN_12 = _T_52 ? $signed(_T_56) : $signed(_GEN_11); // @[Alu.scala 113:5 Alu.scala 114:19]
  wire [32:0] _GEN_13 = _T_50 ? $signed(_T_51) : $signed({{1{_GEN_12[31]}},_GEN_12}); // @[Alu.scala 109:5 Alu.scala 110:19]
  wire [63:0] _GEN_14 = _T_48 ? $signed(_T_49) : $signed({{31{_GEN_13[32]}},_GEN_13}); // @[Alu.scala 105:5 Alu.scala 106:19]
  wire [63:0] _GEN_15 = _T_47 ? $signed({{32{io_oper_b[31]}},io_oper_b}) : $signed(_GEN_14); // @[Alu.scala 100:5 Alu.scala 101:19]
  wire [63:0] _GEN_16 = io_aluCtrl == 5'h1f ? $signed({{32{io_oper_a[31]}},io_oper_a}) : $signed(_GEN_15); // @[Alu.scala 95:44 Alu.scala 97:19]
  wire [63:0] _GEN_17 = io_aluCtrl == 5'h17 ? $signed({{62{_GEN_6[1]}},_GEN_6}) : $signed(_GEN_16); // @[Alu.scala 88:44]
  wire [63:0] _GEN_18 = io_aluCtrl == 5'h15 ? $signed({{62{_GEN_5[1]}},_GEN_5}) : $signed(_GEN_17); // @[Alu.scala 81:44]
  wire [63:0] _GEN_19 = io_aluCtrl == 5'h14 ? $signed({{62{_GEN_0[1]}},_GEN_0}) : $signed(_GEN_18); // @[Alu.scala 74:44]
  wire [63:0] _GEN_20 = io_aluCtrl == 5'h11 ? $signed({{62{_GEN_3[1]}},_GEN_3}) : $signed(_GEN_19); // @[Alu.scala 67:44]
  wire [63:0] _GEN_21 = io_aluCtrl == 5'h10 ? $signed({{62{_GEN_2[1]}},_GEN_2}) : $signed(_GEN_20); // @[Alu.scala 60:44]
  wire [63:0] _GEN_22 = io_aluCtrl == 5'h8 ? $signed({{32{_T_32[31]}},_T_32}) : $signed(_GEN_21); // @[Alu.scala 56:44 Alu.scala 58:19]
  wire [63:0] _GEN_23 = io_aluCtrl == 5'h7 ? $signed({{32{_T_28[31]}},_T_28}) : $signed(_GEN_22); // @[Alu.scala 53:44 Alu.scala 55:19]
  wire [63:0] _GEN_24 = io_aluCtrl == 5'h6 ? $signed({{32{_T_25[31]}},_T_25}) : $signed(_GEN_23); // @[Alu.scala 50:44 Alu.scala 52:19]
  wire [63:0] _GEN_25 = io_aluCtrl == 5'h5 | io_aluCtrl == 5'hd ? $signed({{32{_T_22[31]}},_T_22}) : $signed(_GEN_24); // @[Alu.scala 41:73 Alu.scala 49:19]
  wire [63:0] _GEN_26 = io_aluCtrl == 5'h4 ? $signed({{32{_T_17[31]}},_T_17}) : $signed(_GEN_25); // @[Alu.scala 38:44 Alu.scala 40:19]
  wire [63:0] _GEN_27 = io_aluCtrl == 5'h3 | io_aluCtrl == 5'h16 ? $signed({{62{_GEN_1[1]}},_GEN_1}) : $signed(_GEN_26); // @[Alu.scala 31:73]
  wire [63:0] _GEN_28 = io_aluCtrl == 5'h2 ? $signed({{62{_GEN_0[1]}},_GEN_0}) : $signed(_GEN_27); // @[Alu.scala 24:44]
  wire [63:0] _GEN_29 = io_aluCtrl == 5'h1 ? $signed({{1{_T_6[62]}},_T_6}) : $signed(_GEN_28); // @[Alu.scala 20:44 Alu.scala 23:19]
  wire [63:0] _GEN_30 = io_aluCtrl == 5'h0 ? $signed({{32{_T_3[31]}},_T_3}) : $signed(_GEN_29); // @[Alu.scala 17:37 Alu.scala 19:19]
  assign io_output = _GEN_30[31:0];
endmodule
module AluControl(
  input  [3:0] io_aluOp,
  input  [6:0] io_func7,
  input  [2:0] io_func3,
  output [4:0] io_output
);
  wire  _T = io_func3 == 3'h0; // @[ALU_operations_Sel.scala 37:35]
  wire  _T_1 = io_aluOp == 4'h0; // @[ALU_operations_Sel.scala 37:57]
  wire  _T_2 = io_func3 == 3'h0 & io_aluOp == 4'h0; // @[ALU_operations_Sel.scala 37:49]
  wire  _T_3 = io_func7 == 7'h0; // @[ALU_operations_Sel.scala 37:80]
  wire  _T_4 = io_func3 == 3'h0 & io_aluOp == 4'h0 & io_func7 == 7'h0; // @[ALU_operations_Sel.scala 37:71]
  wire  _T_6 = io_aluOp == 4'h1; // @[ALU_operations_Sel.scala 12:57]
  wire  _T_7 = _T & io_aluOp == 4'h1; // @[ALU_operations_Sel.scala 12:49]
  wire  _T_9 = io_func3 == 3'h2; // @[ALU_operations_Sel.scala 33:35]
  wire  _T_10 = io_aluOp == 4'h5; // @[ALU_operations_Sel.scala 33:57]
  wire  _T_11 = io_func3 == 3'h2 & io_aluOp == 4'h5; // @[ALU_operations_Sel.scala 33:49]
  wire  _T_15 = _T & _T_10; // @[ALU_operations_Sel.scala 31:49]
  wire  _T_17 = io_func3 == 3'h1; // @[ALU_operations_Sel.scala 32:35]
  wire  _T_19 = io_func3 == 3'h1 & _T_10; // @[ALU_operations_Sel.scala 32:49]
  wire  _T_22 = io_aluOp == 4'h4; // @[ALU_operations_Sel.scala 27:57]
  wire  _T_23 = _T_9 & io_aluOp == 4'h4; // @[ALU_operations_Sel.scala 27:49]
  wire  _T_27 = _T & _T_22; // @[ALU_operations_Sel.scala 25:49]
  wire  _T_31 = _T_17 & _T_22; // @[ALU_operations_Sel.scala 26:49]
  wire  _T_33 = io_func3 == 3'h4; // @[ALU_operations_Sel.scala 28:35]
  wire  _T_35 = io_func3 == 3'h4 & _T_22; // @[ALU_operations_Sel.scala 28:49]
  wire  _T_37 = io_func3 == 3'h5; // @[ALU_operations_Sel.scala 29:35]
  wire  _T_39 = io_func3 == 3'h5 & _T_22; // @[ALU_operations_Sel.scala 29:49]
  wire  _T_41 = io_func3 == 3'h6; // @[ALU_operations_Sel.scala 30:35]
  wire  _T_43 = io_func3 == 3'h6 & _T_22; // @[ALU_operations_Sel.scala 30:49]
  wire  _T_45 = io_aluOp == 4'h6; // @[ALU_operations_Sel.scala 10:35]
  wire  _T_47 = io_aluOp == 4'h7; // @[ALU_operations_Sel.scala 11:35]
  wire  _T_48 = _T_4 | _T_7 | _T_11 | _T_15 | _T_19 | _T_23 | _T_27 | _T_31 | _T_35 | _T_39 | _T_43 | _T_45 | _T_47; // @[AluControl.scala 19:158]
  wire  _T_53 = _T_17 & _T_1 & _T_3; // @[ALU_operations_Sel.scala 39:71]
  wire  _T_58 = _T_17 & _T_6 & _T_3; // @[ALU_operations_Sel.scala 34:71]
  wire  _T_64 = _T_9 & _T_1 & _T_3; // @[ALU_operations_Sel.scala 40:71]
  wire  _T_67 = _T_9 & _T_6; // @[ALU_operations_Sel.scala 13:49]
  wire  _T_69 = io_func3 == 3'h3; // @[ALU_operations_Sel.scala 41:35]
  wire  _T_73 = io_func3 == 3'h3 & _T_1 & _T_3; // @[ALU_operations_Sel.scala 41:71]
  wire  _T_76 = _T_69 & _T_6; // @[ALU_operations_Sel.scala 14:49]
  wire  _T_79 = io_aluOp == 4'h2; // @[ALU_operations_Sel.scala 22:57]
  wire  _T_80 = _T_41 & io_aluOp == 4'h2; // @[ALU_operations_Sel.scala 22:49]
  wire  _T_86 = _T_33 & _T_1 & _T_3; // @[ALU_operations_Sel.scala 42:71]
  wire  _T_89 = _T_33 & _T_6; // @[ALU_operations_Sel.scala 15:49]
  wire  _T_93 = _T_37 & _T_1; // @[ALU_operations_Sel.scala 43:49]
  wire  _T_95 = _T_37 & _T_1 & _T_3; // @[ALU_operations_Sel.scala 43:71]
  wire  _T_98 = _T_37 & _T_6; // @[ALU_operations_Sel.scala 35:49]
  wire  _T_100 = _T_37 & _T_6 & _T_3; // @[ALU_operations_Sel.scala 35:71]
  wire  _T_105 = io_func7 == 7'h20; // @[ALU_operations_Sel.scala 44:80]
  wire  _T_106 = _T_93 & io_func7 == 7'h20; // @[ALU_operations_Sel.scala 44:71]
  wire  _T_112 = _T_98 & _T_105; // @[ALU_operations_Sel.scala 36:71]
  wire  _T_118 = _T_41 & _T_1 & _T_3; // @[ALU_operations_Sel.scala 45:71]
  wire  _T_121 = _T_41 & _T_6; // @[ALU_operations_Sel.scala 16:49]
  wire  _T_123 = io_func3 == 3'h7; // @[ALU_operations_Sel.scala 46:35]
  wire  _T_127 = io_func3 == 3'h7 & _T_1 & _T_3; // @[ALU_operations_Sel.scala 46:71]
  wire  _T_130 = _T_123 & _T_6; // @[ALU_operations_Sel.scala 17:49]
  wire  _T_136 = _T_2 & _T_105; // @[ALU_operations_Sel.scala 38:71]
  wire  _T_139 = _T & _T_79; // @[ALU_operations_Sel.scala 18:49]
  wire  _T_142 = _T_17 & _T_79; // @[ALU_operations_Sel.scala 19:49]
  wire  _T_145 = _T_33 & _T_79; // @[ALU_operations_Sel.scala 20:49]
  wire  _T_148 = _T_37 & _T_79; // @[ALU_operations_Sel.scala 21:49]
  wire  _T_151 = _T_123 & _T_79; // @[ALU_operations_Sel.scala 23:49]
  wire  _T_152 = io_aluOp == 4'h3; // @[ALU_operations_Sel.scala 9:35]
  wire  _T_155 = _T & _T_152; // @[ALU_operations_Sel.scala 24:49]
  wire  _T_158 = io_aluOp == 4'h8; // @[ALU_operations_Sel.scala 55:57]
  wire  _T_159 = _T_17 & io_aluOp == 4'h8; // @[ALU_operations_Sel.scala 55:49]
  wire  _T_163 = _T_9 & _T_158; // @[ALU_operations_Sel.scala 56:49]
  wire  _T_167 = _T_69 & _T_158; // @[ALU_operations_Sel.scala 57:49]
  wire  _T_171 = _T_37 & _T_158; // @[ALU_operations_Sel.scala 58:49]
  wire  _T_175 = _T_41 & _T_158; // @[ALU_operations_Sel.scala 59:49]
  wire  _T_179 = _T_123 & _T_158; // @[ALU_operations_Sel.scala 60:49]
  wire  _T_182 = io_aluOp == 4'h9; // @[ALU_operations_Sel.scala 47:57]
  wire  _T_184 = io_func7 == 7'h1; // @[ALU_operations_Sel.scala 47:80]
  wire  _T_185 = _T & io_aluOp == 4'h9 & io_func7 == 7'h1; // @[ALU_operations_Sel.scala 47:71]
  wire  _T_190 = _T_33 & _T_182 & _T_184; // @[ALU_operations_Sel.scala 51:71]
  wire  _T_195 = _T_37 & _T_182 & _T_184; // @[ALU_operations_Sel.scala 52:71]
  wire  _T_200 = _T_41 & _T_182 & _T_184; // @[ALU_operations_Sel.scala 53:71]
  wire  _T_205 = _T_123 & _T_182 & _T_184; // @[ALU_operations_Sel.scala 54:71]
  wire  _T_210 = _T_17 & _T_182 & _T_184; // @[ALU_operations_Sel.scala 48:71]
  wire  _T_215 = _T_9 & _T_182 & _T_184; // @[ALU_operations_Sel.scala 49:71]
  wire [4:0] _GEN_1 = _T_215 ? 5'h13 : 5'h12; // @[AluControl.scala 41:29 AluControl.scala 41:41]
  wire [4:0] _GEN_2 = _T_210 ? 5'h18 : _GEN_1; // @[AluControl.scala 40:26 AluControl.scala 40:38]
  wire [4:0] _GEN_3 = _T_205 ? 5'h19 : _GEN_2; // @[AluControl.scala 39:26 AluControl.scala 39:38]
  wire [4:0] _GEN_4 = _T_200 ? 5'h1a : _GEN_3; // @[AluControl.scala 38:26 AluControl.scala 38:38]
  wire [4:0] _GEN_5 = _T_195 ? 5'h1b : _GEN_4; // @[AluControl.scala 37:26 AluControl.scala 37:38]
  wire [4:0] _GEN_6 = _T_190 ? 5'h1d : _GEN_5; // @[AluControl.scala 36:26 AluControl.scala 36:38]
  wire [4:0] _GEN_7 = _T_185 ? 5'h1e : _GEN_6; // @[AluControl.scala 35:26 AluControl.scala 35:38]
  wire [4:0] _GEN_8 = _T_152 | _T_155 | _T_159 | _T_163 | _T_167 | _T_171 | _T_175 | _T_179 ? 5'h1f : _GEN_7; // @[AluControl.scala 34:133 AluControl.scala 34:145]
  wire [4:0] _GEN_9 = _T_151 ? 5'h17 : _GEN_8; // @[AluControl.scala 33:26 AluControl.scala 33:38]
  wire [4:0] _GEN_10 = _T_148 ? 5'h15 : _GEN_9; // @[AluControl.scala 32:26 AluControl.scala 32:38]
  wire [4:0] _GEN_11 = _T_145 ? 5'h14 : _GEN_10; // @[AluControl.scala 31:26 AluControl.scala 31:38]
  wire [4:0] _GEN_12 = _T_142 ? 5'h11 : _GEN_11; // @[AluControl.scala 30:26 AluControl.scala 30:38]
  wire [4:0] _GEN_13 = _T_139 ? 5'h10 : _GEN_12; // @[AluControl.scala 29:26 AluControl.scala 29:38]
  wire [4:0] _GEN_14 = _T_136 ? 5'h8 : _GEN_13; // @[AluControl.scala 28:26 AluControl.scala 28:38]
  wire [4:0] _GEN_15 = _T_127 | _T_130 ? 5'h7 : _GEN_14; // @[AluControl.scala 27:40 AluControl.scala 27:52]
  wire [4:0] _GEN_16 = _T_118 | _T_121 ? 5'h6 : _GEN_15; // @[AluControl.scala 26:40 AluControl.scala 26:52]
  wire [4:0] _GEN_17 = _T_95 | _T_100 | _T_106 | _T_112 ? 5'h5 : _GEN_16; // @[AluControl.scala 25:67 AluControl.scala 25:79]
  wire [4:0] _GEN_18 = _T_86 | _T_89 ? 5'h4 : _GEN_17; // @[AluControl.scala 24:40 AluControl.scala 24:52]
  wire [4:0] _GEN_19 = _T_73 | _T_76 | _T_80 ? 5'h3 : _GEN_18; // @[AluControl.scala 23:55 AluControl.scala 23:67]
  wire [4:0] _GEN_20 = _T_64 | _T_67 ? 5'h2 : _GEN_19; // @[AluControl.scala 22:40 AluControl.scala 22:52]
  wire [4:0] _GEN_21 = _T_53 | _T_58 ? 5'h1 : _GEN_20; // @[AluControl.scala 21:40 AluControl.scala 21:52]
  assign io_output = _T_48 ? 5'h0 : _GEN_21; // @[AluControl.scala 20:5 AluControl.scala 20:17]
endmodule
module Execute(
  input  [4:0]  io_EX_MEM_rd_sel,
  input  [4:0]  io_MEM_WB_rd_sel,
  input  [4:0]  io_ID_EX_rs1_sel,
  input  [4:0]  io_ID_EX_rs2_sel,
  input         io_EX_MEM_ctrl_RegWr,
  input         io_EX_MEM_ctrl_csrWen,
  input         io_MEM_WB_ctrl_csrWen,
  input         io_MEM_WB_ctrl_RegWr,
  input  [1:0]  io_ID_EX_ctrl_OpA_sel,
  input         io_ID_EX_ctrl_OpB_sel,
  input  [31:0] io_ID_EX_pc4,
  input  [31:0] io_ID_EX_pc_out,
  input  [31:0] io_ID_EX_rs1,
  input  [31:0] io_ID_EX_rs2,
  input  [31:0] io_ID_EX_csr_data,
  input  [31:0] io_EX_MEM_alu_output,
  input  [31:0] io_EX_MEM_csr_rdata,
  input  [31:0] io_MEM_WB_csr_rdata,
  input  [31:0] io_writeback_write_data,
  input  [31:0] io_ID_EX_imm,
  input  [3:0]  io_ID_EX_ctrl_AluOp,
  input  [6:0]  io_ID_EX_func7,
  input  [6:0]  io_ID_EX_inst_op,
  input  [2:0]  io_ID_EX_func3,
  input  [4:0]  io_ID_EX_rd_sel,
  input         io_ID_EX_ctrl_MemWr,
  input         io_ID_EX_ctrl_MemRd,
  input         io_ID_EX_ctrl_RegWr,
  input         io_ID_EX_ctrl_CsrWen,
  input         io_ID_EX_ctrl_MemToReg,
  output [31:0] io_rs2_out,
  output [31:0] io_alu_output,
  output [4:0]  io_rd_sel_out,
  output        io_ctrl_MemWr_out,
  output        io_ctrl_MemRd_out,
  output        io_ctrl_RegWr_out,
  output        io_ctrl_CsrWe_out,
  output        io_ctrl_MemToReg_out,
  output [2:0]  io_func3_out,
  output [31:0] io_csr_data_o
);
  wire [4:0] forwardUnit_io_EX_MEM_REGRD; // @[Execute.scala 57:27]
  wire [4:0] forwardUnit_io_MEM_WB_REGRD; // @[Execute.scala 57:27]
  wire [4:0] forwardUnit_io_ID_EX_REGRS1; // @[Execute.scala 57:27]
  wire [4:0] forwardUnit_io_ID_EX_REGRS2; // @[Execute.scala 57:27]
  wire [6:0] forwardUnit_io_ID_EX_inst_op; // @[Execute.scala 57:27]
  wire  forwardUnit_io_EX_MEM_REGWR; // @[Execute.scala 57:27]
  wire  forwardUnit_io_MEM_WB_REGWR; // @[Execute.scala 57:27]
  wire [1:0] forwardUnit_io_forward_a; // @[Execute.scala 57:27]
  wire [1:0] forwardUnit_io_forward_b; // @[Execute.scala 57:27]
  wire [31:0] alu_io_oper_a; // @[Execute.scala 58:19]
  wire [31:0] alu_io_oper_b; // @[Execute.scala 58:19]
  wire [4:0] alu_io_aluCtrl; // @[Execute.scala 58:19]
  wire [31:0] alu_io_output; // @[Execute.scala 58:19]
  wire [3:0] alu_control_io_aluOp; // @[Execute.scala 59:27]
  wire [6:0] alu_control_io_func7; // @[Execute.scala 59:27]
  wire [2:0] alu_control_io_func3; // @[Execute.scala 59:27]
  wire [4:0] alu_control_io_output; // @[Execute.scala 59:27]
  wire  _T_1 = io_ID_EX_ctrl_OpA_sel == 2'h1; // @[Execute.scala 74:35]
  wire [31:0] _T_5 = io_EX_MEM_ctrl_csrWen ? $signed(io_EX_MEM_csr_rdata) : $signed(io_EX_MEM_alu_output); // @[Execute.scala 82:27]
  wire [31:0] _T_8 = io_MEM_WB_ctrl_csrWen ? $signed(io_MEM_WB_csr_rdata) : $signed(io_writeback_write_data); // @[Execute.scala 84:27]
  wire [31:0] _GEN_0 = forwardUnit_io_forward_a == 2'h2 ? $signed(_T_8) : $signed(io_ID_EX_rs1); // @[Execute.scala 83:55 Execute.scala 84:21 Execute.scala 86:21]
  wire [31:0] _GEN_1 = forwardUnit_io_forward_a == 2'h1 ? $signed(_T_5) : $signed(_GEN_0); // @[Execute.scala 81:55 Execute.scala 82:21]
  wire [31:0] _GEN_2 = forwardUnit_io_forward_a == 2'h0 ? $signed(io_ID_EX_rs1) : $signed(_GEN_1); // @[Execute.scala 79:48 Execute.scala 80:21]
  wire [31:0] _GEN_3 = _T_1 ? $signed(io_ID_EX_pc_out) : $signed(_GEN_2); // @[Execute.scala 75:4 Execute.scala 76:21]
  wire [31:0] _GEN_5 = forwardUnit_io_forward_b == 2'h2 ? $signed(_T_8) : $signed(io_ID_EX_rs2); // @[Execute.scala 97:55 Execute.scala 98:18 Execute.scala 100:18]
  wire [31:0] _GEN_6 = forwardUnit_io_forward_b == 2'h1 ? $signed(_T_5) : $signed(_GEN_5); // @[Execute.scala 95:55 Execute.scala 96:18]
  wire [31:0] _GEN_7 = forwardUnit_io_forward_b == 2'h0 ? $signed(io_ID_EX_rs2) : $signed(_GEN_6); // @[Execute.scala 93:48 Execute.scala 94:18]
  ForwardUnit forwardUnit ( // @[Execute.scala 57:27]
    .io_EX_MEM_REGRD(forwardUnit_io_EX_MEM_REGRD),
    .io_MEM_WB_REGRD(forwardUnit_io_MEM_WB_REGRD),
    .io_ID_EX_REGRS1(forwardUnit_io_ID_EX_REGRS1),
    .io_ID_EX_REGRS2(forwardUnit_io_ID_EX_REGRS2),
    .io_ID_EX_inst_op(forwardUnit_io_ID_EX_inst_op),
    .io_EX_MEM_REGWR(forwardUnit_io_EX_MEM_REGWR),
    .io_MEM_WB_REGWR(forwardUnit_io_MEM_WB_REGWR),
    .io_forward_a(forwardUnit_io_forward_a),
    .io_forward_b(forwardUnit_io_forward_b)
  );
  Alu alu ( // @[Execute.scala 58:19]
    .io_oper_a(alu_io_oper_a),
    .io_oper_b(alu_io_oper_b),
    .io_aluCtrl(alu_io_aluCtrl),
    .io_output(alu_io_output)
  );
  AluControl alu_control ( // @[Execute.scala 59:27]
    .io_aluOp(alu_control_io_aluOp),
    .io_func7(alu_control_io_func7),
    .io_func3(alu_control_io_func3),
    .io_output(alu_control_io_output)
  );
  assign io_rs2_out = io_ID_EX_ctrl_OpB_sel ? $signed(_GEN_7) : $signed(_GEN_7); // @[Execute.scala 91:42]
  assign io_alu_output = alu_io_output; // @[Execute.scala 130:17]
  assign io_rd_sel_out = io_ID_EX_rd_sel; // @[Execute.scala 133:17]
  assign io_ctrl_MemWr_out = io_ID_EX_ctrl_MemWr; // @[Execute.scala 137:21]
  assign io_ctrl_MemRd_out = io_ID_EX_ctrl_MemRd; // @[Execute.scala 138:21]
  assign io_ctrl_RegWr_out = io_ID_EX_ctrl_RegWr; // @[Execute.scala 139:21]
  assign io_ctrl_CsrWe_out = io_ID_EX_ctrl_CsrWen; // @[Execute.scala 140:21]
  assign io_ctrl_MemToReg_out = io_ID_EX_ctrl_MemToReg; // @[Execute.scala 141:24]
  assign io_func3_out = io_ID_EX_func3; // @[Execute.scala 135:16]
  assign io_csr_data_o = io_ID_EX_csr_data; // @[Execute.scala 144:17]
  assign forwardUnit_io_EX_MEM_REGRD = io_EX_MEM_rd_sel; // @[Execute.scala 63:31]
  assign forwardUnit_io_MEM_WB_REGRD = io_MEM_WB_rd_sel; // @[Execute.scala 64:31]
  assign forwardUnit_io_ID_EX_REGRS1 = io_ID_EX_rs1_sel; // @[Execute.scala 65:31]
  assign forwardUnit_io_ID_EX_REGRS2 = io_ID_EX_rs2_sel; // @[Execute.scala 66:31]
  assign forwardUnit_io_ID_EX_inst_op = io_ID_EX_inst_op; // @[Execute.scala 62:32]
  assign forwardUnit_io_EX_MEM_REGWR = io_EX_MEM_ctrl_RegWr; // @[Execute.scala 67:31]
  assign forwardUnit_io_MEM_WB_REGWR = io_MEM_WB_ctrl_RegWr; // @[Execute.scala 68:31]
  assign alu_io_oper_a = io_ID_EX_ctrl_OpA_sel == 2'h2 ? $signed(io_ID_EX_pc4) : $signed(_GEN_3); // @[Execute.scala 71:44 Execute.scala 72:19]
  assign alu_io_oper_b = io_ID_EX_ctrl_OpB_sel ? $signed(io_ID_EX_imm) : $signed(_GEN_7); // @[Execute.scala 91:42 Execute.scala 92:19]
  assign alu_io_aluCtrl = alu_control_io_output; // @[Execute.scala 127:18]
  assign alu_control_io_aluOp = io_ID_EX_ctrl_AluOp; // @[Execute.scala 121:24]
  assign alu_control_io_func7 = io_ID_EX_func7; // @[Execute.scala 122:24]
  assign alu_control_io_func3 = io_ID_EX_func3; // @[Execute.scala 123:24]
endmodule
module Load_unit(
  input  [2:0]  io_func3,
  input  [1:0]  io_data_offset,
  input  [31:0] io_memData,
  output [31:0] io_LoadData
);
  wire [7:0] lb = io_memData[7:0]; // @[Load_unit.scala 13:24]
  wire [15:0] lh = io_memData[15:0]; // @[Load_unit.scala 14:24]
  wire  _T_1 = io_data_offset == 2'h0; // @[Load_unit.scala 28:33]
  wire [23:0] hi = io_memData[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_5 = {hi,lb}; // @[Load_unit.scala 30:76]
  wire  _T_6 = io_data_offset == 2'h1; // @[Load_unit.scala 31:40]
  wire [23:0] hi_1 = io_memData[15] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [7:0] lo_1 = io_memData[15:8]; // @[Load_unit.scala 33:71]
  wire [31:0] _T_10 = {hi_1,lo_1}; // @[Load_unit.scala 33:85]
  wire  _T_11 = io_data_offset == 2'h2; // @[Load_unit.scala 34:40]
  wire [23:0] hi_2 = io_memData[23] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [7:0] lo_2 = io_memData[23:16]; // @[Load_unit.scala 36:71]
  wire [31:0] _T_15 = {hi_2,lo_2}; // @[Load_unit.scala 36:86]
  wire [23:0] hi_3 = io_memData[31] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [7:0] lo_3 = io_memData[31:24]; // @[Load_unit.scala 39:71]
  wire [31:0] _T_20 = {hi_3,lo_3}; // @[Load_unit.scala 39:86]
  wire [31:0] _GEN_1 = io_data_offset == 2'h2 ? $signed(_T_15) : $signed(_T_20); // @[Load_unit.scala 34:53 Load_unit.scala 36:29]
  wire [31:0] _GEN_2 = io_data_offset == 2'h1 ? $signed(_T_10) : $signed(_GEN_1); // @[Load_unit.scala 31:53 Load_unit.scala 33:29]
  wire [31:0] _GEN_3 = io_data_offset == 2'h0 ? $signed(_T_5) : $signed(_GEN_2); // @[Load_unit.scala 28:46 Load_unit.scala 30:29]
  wire [15:0] hi_4 = io_memData[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_26 = {hi_4,lh}; // @[Load_unit.scala 48:78]
  wire [15:0] hi_5 = io_memData[23] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [15:0] lo_5 = io_memData[23:8]; // @[Load_unit.scala 51:71]
  wire [31:0] _T_31 = {hi_5,lo_5}; // @[Load_unit.scala 51:85]
  wire [15:0] hi_6 = io_memData[31] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [15:0] lo_6 = io_memData[31:16]; // @[Load_unit.scala 54:71]
  wire [31:0] _T_36 = {hi_6,lo_6}; // @[Load_unit.scala 54:86]
  wire [31:0] _T_39 = {24'h0,lo_3}; // @[Load_unit.scala 63:75]
  wire [31:0] _GEN_5 = _T_11 ? $signed(_T_36) : $signed(_T_39); // @[Load_unit.scala 52:53 Load_unit.scala 54:29]
  wire [31:0] _GEN_6 = _T_6 ? $signed(_T_31) : $signed(_GEN_5); // @[Load_unit.scala 49:53 Load_unit.scala 51:29]
  wire [31:0] _GEN_7 = _T_1 ? $signed(_T_26) : $signed(_GEN_6); // @[Load_unit.scala 46:46 Load_unit.scala 48:29]
  wire [31:0] _T_44 = {24'h0,lb}; // @[Load_unit.scala 78:66]
  wire [31:0] _T_47 = {24'h0,lo_1}; // @[Load_unit.scala 81:74]
  wire [31:0] _T_50 = {24'h0,lo_2}; // @[Load_unit.scala 84:75]
  wire [31:0] _GEN_9 = _T_11 ? $signed(_T_50) : $signed(_T_39); // @[Load_unit.scala 82:53 Load_unit.scala 84:29]
  wire [31:0] _GEN_10 = _T_6 ? $signed(_T_47) : $signed(_GEN_9); // @[Load_unit.scala 79:53 Load_unit.scala 81:29]
  wire [31:0] _GEN_11 = _T_1 ? $signed(_T_44) : $signed(_GEN_10); // @[Load_unit.scala 76:46 Load_unit.scala 78:29]
  wire [31:0] _T_57 = {16'h0,lh}; // @[Load_unit.scala 96:68]
  wire [31:0] _T_60 = {16'h0,lo_5}; // @[Load_unit.scala 99:74]
  wire [31:0] _T_63 = {16'h0,lo_6}; // @[Load_unit.scala 102:75]
  wire [31:0] _GEN_13 = _T_11 ? $signed(_T_63) : $signed(_T_39); // @[Load_unit.scala 100:53 Load_unit.scala 102:29]
  wire [31:0] _GEN_14 = _T_6 ? $signed(_T_60) : $signed(_GEN_13); // @[Load_unit.scala 97:53 Load_unit.scala 99:29]
  wire [31:0] _GEN_15 = _T_1 ? $signed(_T_57) : $signed(_GEN_14); // @[Load_unit.scala 94:46 Load_unit.scala 96:29]
  wire [23:0] lo_16 = io_memData[31:8]; // @[Load_unit.scala 130:59]
  wire [31:0] _T_73 = {8'h0,lo_16}; // @[Load_unit.scala 130:73]
  wire [31:0] _GEN_18 = _T_6 ? $signed(_T_73) : $signed(_GEN_13); // @[Load_unit.scala 121:53 Load_unit.scala 130:29]
  wire [31:0] _GEN_19 = _T_1 ? $signed(io_memData) : $signed(_GEN_18); // @[Load_unit.scala 118:46 Load_unit.scala 120:29]
  wire [31:0] _GEN_21 = io_func3 == 3'h5 ? $signed(_GEN_15) : $signed(_GEN_19); // @[Load_unit.scala 92:44]
  wire [31:0] _GEN_22 = io_func3 == 3'h4 ? $signed(_GEN_11) : $signed(_GEN_21); // @[Load_unit.scala 74:44]
  wire [31:0] _GEN_23 = io_func3 == 3'h6 ? $signed(io_memData) : $signed(_GEN_22); // @[Load_unit.scala 68:44 Load_unit.scala 73:25]
  wire [31:0] _GEN_24 = io_func3 == 3'h1 ? $signed(_GEN_7) : $signed(_GEN_23); // @[Load_unit.scala 44:44]
  assign io_LoadData = io_func3 == 3'h0 ? $signed(_GEN_3) : $signed(_GEN_24); // @[Load_unit.scala 26:37]
endmodule
module MemoryStage(
  input  [31:0] io_EX_MEM_alu_output,
  input  [4:0]  io_EX_MEM_rd_sel,
  input         io_EX_MEM_RegWr,
  input         io_EX_MEM_CsrWe,
  input         io_EX_MEM_MemRd,
  input         io_EX_MEM_MemToReg,
  input         io_EX_MEM_MemWr,
  input  [31:0] io_EX_MEM_rs2,
  input  [2:0]  io_func3,
  input  [31:0] io_EX_MEM_csr_data,
  input         io_coreDccmReq_ready,
  output        io_coreDccmReq_valid,
  output [31:0] io_coreDccmReq_bits_addrRequest,
  output [31:0] io_coreDccmReq_bits_dataRequest,
  output [3:0]  io_coreDccmReq_bits_activeByteLane,
  output        io_coreDccmReq_bits_isWrite,
  input         io_coreDccmRsp_valid,
  input  [31:0] io_coreDccmRsp_bits_dataResponse,
  output [31:0] io_data_out,
  output [31:0] io_alu_output,
  output [4:0]  io_rd_sel_out,
  output        io_ctrl_RegWr_out,
  output        io_ctrl_CsrWen_out,
  output        io_ctrl_MemRd_out,
  output        io_ctrl_MemToReg_out,
  output [31:0] io_csr_data_out,
  output        io_stall
);
  wire [2:0] load_unit_io_func3; // @[MemoryStage.scala 40:25]
  wire [1:0] load_unit_io_data_offset; // @[MemoryStage.scala 40:25]
  wire [31:0] load_unit_io_memData; // @[MemoryStage.scala 40:25]
  wire [31:0] load_unit_io_LoadData; // @[MemoryStage.scala 40:25]
  wire [1:0] data_offset = io_EX_MEM_alu_output[1:0]; // @[MemoryStage.scala 42:41]
  wire  _T_9 = data_offset == 2'h0; // @[MemoryStage.scala 77:22]
  wire  _T_10 = data_offset == 2'h1; // @[MemoryStage.scala 81:29]
  wire  _T_11 = data_offset == 2'h2; // @[MemoryStage.scala 85:29]
  wire  _T_12 = data_offset == 2'h3; // @[MemoryStage.scala 89:29]
  wire [3:0] _GEN_0 = data_offset == 2'h3 ? 4'h8 : 4'hf; // @[MemoryStage.scala 89:42 MemoryStage.scala 91:42 MemoryStage.scala 94:42]
  wire [3:0] _GEN_1 = data_offset == 2'h2 ? 4'hc : _GEN_0; // @[MemoryStage.scala 85:42 MemoryStage.scala 87:42]
  wire [3:0] _GEN_2 = data_offset == 2'h1 ? 4'he : _GEN_1; // @[MemoryStage.scala 81:42 MemoryStage.scala 83:42]
  wire [3:0] _GEN_3 = data_offset == 2'h0 ? 4'hf : _GEN_2; // @[MemoryStage.scala 77:35 MemoryStage.scala 79:42]
  wire [3:0] _GEN_6 = _T_10 ? 4'h6 : _GEN_1; // @[MemoryStage.scala 103:42 MemoryStage.scala 105:42]
  wire [3:0] _GEN_7 = _T_9 ? 4'h3 : _GEN_6; // @[MemoryStage.scala 99:35 MemoryStage.scala 101:42]
  wire [3:0] _GEN_9 = _T_11 ? 4'h4 : _GEN_0; // @[MemoryStage.scala 128:42 MemoryStage.scala 130:42]
  wire [3:0] _GEN_10 = _T_10 ? 4'h2 : _GEN_9; // @[MemoryStage.scala 124:42 MemoryStage.scala 126:42]
  wire [3:0] _GEN_11 = _T_9 ? 4'h1 : _GEN_10; // @[MemoryStage.scala 120:35 MemoryStage.scala 122:42]
  wire [3:0] _GEN_13 = io_func3 == 3'h1 & io_EX_MEM_MemWr ? _GEN_7 : _GEN_11; // @[MemoryStage.scala 97:65]
  wire [7:0] _T_29 = io_EX_MEM_rs2[7:0]; // @[MemoryStage.scala 148:47]
  wire [7:0] _T_31 = io_EX_MEM_rs2[15:8]; // @[MemoryStage.scala 149:48]
  wire [7:0] _T_33 = io_EX_MEM_rs2[23:16]; // @[MemoryStage.scala 150:49]
  wire [7:0] _T_35 = io_EX_MEM_rs2[31:24]; // @[MemoryStage.scala 151:49]
  wire [7:0] _GEN_15 = _T_12 ? $signed(_T_35) : $signed(_T_29); // @[MemoryStage.scala 162:40 MemoryStage.scala 163:19 MemoryStage.scala 168:19]
  wire [7:0] _GEN_16 = _T_12 ? $signed(_T_33) : $signed(_T_31); // @[MemoryStage.scala 162:40 MemoryStage.scala 164:19 MemoryStage.scala 169:19]
  wire [7:0] _GEN_17 = _T_12 ? $signed(_T_31) : $signed(_T_33); // @[MemoryStage.scala 162:40 MemoryStage.scala 165:19 MemoryStage.scala 170:19]
  wire [7:0] _GEN_18 = _T_12 ? $signed(_T_29) : $signed(_T_35); // @[MemoryStage.scala 162:40 MemoryStage.scala 166:19 MemoryStage.scala 171:19]
  wire [7:0] _GEN_19 = _T_11 ? $signed(_T_35) : $signed(_GEN_15); // @[MemoryStage.scala 157:40 MemoryStage.scala 158:19]
  wire [7:0] _GEN_20 = _T_11 ? $signed(_T_33) : $signed(_GEN_16); // @[MemoryStage.scala 157:40 MemoryStage.scala 159:19]
  wire [7:0] _GEN_21 = _T_11 ? $signed(_T_29) : $signed(_GEN_17); // @[MemoryStage.scala 157:40 MemoryStage.scala 160:19]
  wire [7:0] _GEN_22 = _T_11 ? $signed(_T_31) : $signed(_GEN_18); // @[MemoryStage.scala 157:40 MemoryStage.scala 161:19]
  wire [7:0] _GEN_23 = _T_10 ? $signed(_T_35) : $signed(_GEN_19); // @[MemoryStage.scala 152:40 MemoryStage.scala 153:19]
  wire [7:0] _GEN_24 = _T_10 ? $signed(_T_29) : $signed(_GEN_20); // @[MemoryStage.scala 152:40 MemoryStage.scala 154:19]
  wire [7:0] _GEN_25 = _T_10 ? $signed(_T_31) : $signed(_GEN_21); // @[MemoryStage.scala 152:40 MemoryStage.scala 155:19]
  wire [7:0] _GEN_26 = _T_10 ? $signed(_T_33) : $signed(_GEN_22); // @[MemoryStage.scala 152:40 MemoryStage.scala 156:19]
  wire  _T_73 = io_coreDccmReq_ready & io_EX_MEM_MemWr; // @[MemoryStage.scala 179:29]
  wire [7:0] lo_lo = _T_9 ? $signed(_T_29) : $signed(_GEN_23); // @[MemoryStage.scala 182:57]
  wire [7:0] lo_hi = _T_9 ? $signed(_T_31) : $signed(_GEN_24); // @[MemoryStage.scala 182:57]
  wire [7:0] hi_lo = _T_9 ? $signed(_T_33) : $signed(_GEN_25); // @[MemoryStage.scala 182:57]
  wire [7:0] hi_hi = _T_9 ? $signed(_T_35) : $signed(_GEN_26); // @[MemoryStage.scala 182:57]
  wire [15:0] lo = {lo_hi,lo_lo}; // @[MemoryStage.scala 182:57]
  wire [15:0] hi = {hi_hi,hi_lo}; // @[MemoryStage.scala 182:57]
  wire  _T_76 = io_coreDccmReq_ready & io_EX_MEM_MemRd; // @[MemoryStage.scala 183:36]
  Load_unit load_unit ( // @[MemoryStage.scala 40:25]
    .io_func3(load_unit_io_func3),
    .io_data_offset(load_unit_io_data_offset),
    .io_memData(load_unit_io_memData),
    .io_LoadData(load_unit_io_LoadData)
  );
  assign io_coreDccmReq_valid = _T_73 | _T_76; // @[MemoryStage.scala 180:3 MemoryStage.scala 181:26]
  assign io_coreDccmReq_bits_addrRequest = io_EX_MEM_alu_output; // @[MemoryStage.scala 178:65]
  assign io_coreDccmReq_bits_dataRequest = {hi,lo}; // @[MemoryStage.scala 182:57]
  assign io_coreDccmReq_bits_activeByteLane = io_func3 == 3'h2 & io_EX_MEM_MemWr ? _GEN_3 : _GEN_13; // @[MemoryStage.scala 75:58]
  assign io_coreDccmReq_bits_isWrite = io_EX_MEM_MemWr; // @[MemoryStage.scala 211:31]
  assign io_data_out = load_unit_io_LoadData; // @[MemoryStage.scala 197:3 MemoryStage.scala 200:21]
  assign io_alu_output = io_EX_MEM_alu_output; // @[MemoryStage.scala 212:17]
  assign io_rd_sel_out = io_EX_MEM_rd_sel; // @[MemoryStage.scala 214:17]
  assign io_ctrl_RegWr_out = io_EX_MEM_RegWr; // @[MemoryStage.scala 215:21]
  assign io_ctrl_CsrWen_out = io_EX_MEM_CsrWe; // @[MemoryStage.scala 216:22]
  assign io_ctrl_MemRd_out = io_EX_MEM_MemRd; // @[MemoryStage.scala 217:21]
  assign io_ctrl_MemToReg_out = io_EX_MEM_MemToReg; // @[MemoryStage.scala 218:24]
  assign io_csr_data_out = io_EX_MEM_csr_data; // @[MemoryStage.scala 219:19]
  assign io_stall = (io_EX_MEM_MemWr | io_EX_MEM_MemRd) & ~io_coreDccmRsp_valid; // @[MemoryStage.scala 52:68]
  assign load_unit_io_func3 = io_func3; // @[MemoryStage.scala 56:22]
  assign load_unit_io_data_offset = io_EX_MEM_alu_output[1:0]; // @[MemoryStage.scala 42:41]
  assign load_unit_io_memData = io_coreDccmRsp_bits_dataResponse; // @[MemoryStage.scala 57:66]
endmodule
module WriteBack(
  input         io_MEM_WB_MemToReg,
  input  [31:0] io_MEM_WB_dataMem_data,
  input  [31:0] io_MEM_WB_alu_output,
  output [31:0] io_write_data
);
  assign io_write_data = io_MEM_WB_MemToReg ? $signed(io_MEM_WB_dataMem_data) : $signed(io_MEM_WB_alu_output); // @[WriteBack.scala 13:38 WriteBack.scala 14:23 WriteBack.scala 16:23]
endmodule
module Core(
  input         clock,
  input         reset,
  input         io_dmemReq_ready,
  output        io_dmemReq_valid,
  output [31:0] io_dmemReq_bits_addrRequest,
  output [31:0] io_dmemReq_bits_dataRequest,
  output [3:0]  io_dmemReq_bits_activeByteLane,
  output        io_dmemReq_bits_isWrite,
  input         io_dmemRsp_valid,
  input  [31:0] io_dmemRsp_bits_dataResponse,
  input         io_imemReq_ready,
  output        io_imemReq_valid,
  output [31:0] io_imemReq_bits_addrRequest,
  input         io_imemRsp_valid,
  input  [31:0] io_imemRsp_bits_dataResponse
);
  wire  ID_EX_clock; // @[Core.scala 45:37]
  wire  ID_EX_reset; // @[Core.scala 45:37]
  wire [31:0] ID_EX_io_pc_in; // @[Core.scala 45:37]
  wire [31:0] ID_EX_io_pc4_in; // @[Core.scala 45:37]
  wire [4:0] ID_EX_io_rs1_sel_in; // @[Core.scala 45:37]
  wire [4:0] ID_EX_io_rs2_sel_in; // @[Core.scala 45:37]
  wire [31:0] ID_EX_io_rs1_in; // @[Core.scala 45:37]
  wire [31:0] ID_EX_io_rs2_in; // @[Core.scala 45:37]
  wire [31:0] ID_EX_io_imm; // @[Core.scala 45:37]
  wire [4:0] ID_EX_io_rd_sel_in; // @[Core.scala 45:37]
  wire [2:0] ID_EX_io_func3_in; // @[Core.scala 45:37]
  wire [6:0] ID_EX_io_func7_in; // @[Core.scala 45:37]
  wire  ID_EX_io_ctrl_MemWr_in; // @[Core.scala 45:37]
  wire  ID_EX_io_ctrl_MemRd_in; // @[Core.scala 45:37]
  wire  ID_EX_io_ctrl_CsrWen_in; // @[Core.scala 45:37]
  wire  ID_EX_io_ctrl_RegWr_in; // @[Core.scala 45:37]
  wire  ID_EX_io_ctrl_MemToReg_in; // @[Core.scala 45:37]
  wire [3:0] ID_EX_io_ctrl_AluOp_in; // @[Core.scala 45:37]
  wire [1:0] ID_EX_io_ctrl_OpA_sel_in; // @[Core.scala 45:37]
  wire  ID_EX_io_ctrl_OpB_sel_in; // @[Core.scala 45:37]
  wire [6:0] ID_EX_io_inst_op_in; // @[Core.scala 45:37]
  wire [31:0] ID_EX_io_csr_data_i; // @[Core.scala 45:37]
  wire  ID_EX_io_stall; // @[Core.scala 45:37]
  wire [31:0] ID_EX_io_pc_out; // @[Core.scala 45:37]
  wire [31:0] ID_EX_io_pc4_out; // @[Core.scala 45:37]
  wire [31:0] ID_EX_io_rs1_out; // @[Core.scala 45:37]
  wire [31:0] ID_EX_io_rs2_out; // @[Core.scala 45:37]
  wire [31:0] ID_EX_io_imm_out; // @[Core.scala 45:37]
  wire [2:0] ID_EX_io_func3_out; // @[Core.scala 45:37]
  wire [6:0] ID_EX_io_func7_out; // @[Core.scala 45:37]
  wire [6:0] ID_EX_io_inst_op_out; // @[Core.scala 45:37]
  wire [4:0] ID_EX_io_rd_sel_out; // @[Core.scala 45:37]
  wire [4:0] ID_EX_io_rs1_sel_out; // @[Core.scala 45:37]
  wire [4:0] ID_EX_io_rs2_sel_out; // @[Core.scala 45:37]
  wire  ID_EX_io_ctrl_MemWr_out; // @[Core.scala 45:37]
  wire  ID_EX_io_ctrl_MemRd_out; // @[Core.scala 45:37]
  wire  ID_EX_io_ctrl_RegWr_out; // @[Core.scala 45:37]
  wire  ID_EX_io_ctrl_CsrWen_out; // @[Core.scala 45:37]
  wire  ID_EX_io_ctrl_MemToReg_out; // @[Core.scala 45:37]
  wire [3:0] ID_EX_io_ctrl_AluOp_out; // @[Core.scala 45:37]
  wire [1:0] ID_EX_io_ctrl_OpA_sel_out; // @[Core.scala 45:37]
  wire  ID_EX_io_ctrl_OpB_sel_out; // @[Core.scala 45:37]
  wire [31:0] ID_EX_io_csr_data_o; // @[Core.scala 45:37]
  wire  EX_MEM_clock; // @[Core.scala 46:37]
  wire  EX_MEM_reset; // @[Core.scala 46:37]
  wire  EX_MEM_io_ctrl_MemWr_in; // @[Core.scala 46:37]
  wire  EX_MEM_io_ctrl_MemRd_in; // @[Core.scala 46:37]
  wire  EX_MEM_io_ctrl_RegWr_in; // @[Core.scala 46:37]
  wire  EX_MEM_io_ctrl_CsrWen_in; // @[Core.scala 46:37]
  wire  EX_MEM_io_ctrl_MemToReg_in; // @[Core.scala 46:37]
  wire [31:0] EX_MEM_io_rs2_in; // @[Core.scala 46:37]
  wire [4:0] EX_MEM_io_rd_sel_in; // @[Core.scala 46:37]
  wire [31:0] EX_MEM_io_alu_in; // @[Core.scala 46:37]
  wire [2:0] EX_MEM_io_EX_MEM_func3; // @[Core.scala 46:37]
  wire [31:0] EX_MEM_io_csr_data_i; // @[Core.scala 46:37]
  wire  EX_MEM_io_stall; // @[Core.scala 46:37]
  wire  EX_MEM_io_ctrl_MemWr_out; // @[Core.scala 46:37]
  wire  EX_MEM_io_ctrl_MemRd_out; // @[Core.scala 46:37]
  wire  EX_MEM_io_ctrl_RegWr_out; // @[Core.scala 46:37]
  wire  EX_MEM_io_ctrl_CsrWen_out; // @[Core.scala 46:37]
  wire  EX_MEM_io_ctrl_MemToReg_out; // @[Core.scala 46:37]
  wire [31:0] EX_MEM_io_rs2_out; // @[Core.scala 46:37]
  wire [4:0] EX_MEM_io_rd_sel_out; // @[Core.scala 46:37]
  wire [31:0] EX_MEM_io_alu_output; // @[Core.scala 46:37]
  wire [2:0] EX_MEM_io_EX_MEM_func3_out; // @[Core.scala 46:37]
  wire [31:0] EX_MEM_io_csr_data_o; // @[Core.scala 46:37]
  wire  MEM_WB_clock; // @[Core.scala 47:37]
  wire  MEM_WB_reset; // @[Core.scala 47:37]
  wire  MEM_WB_io_ctrl_RegWr_in; // @[Core.scala 47:37]
  wire  MEM_WB_io_ctrl_CsrWen_in; // @[Core.scala 47:37]
  wire  MEM_WB_io_ctrl_MemToReg_in; // @[Core.scala 47:37]
  wire [4:0] MEM_WB_io_rd_sel_in; // @[Core.scala 47:37]
  wire  MEM_WB_io_ctrl_MemRd_in; // @[Core.scala 47:37]
  wire [31:0] MEM_WB_io_dmem_data_in; // @[Core.scala 47:37]
  wire [31:0] MEM_WB_io_alu_in; // @[Core.scala 47:37]
  wire [31:0] MEM_WB_io_csr_data_in; // @[Core.scala 47:37]
  wire  MEM_WB_io_stall; // @[Core.scala 47:37]
  wire  MEM_WB_io_ctrl_RegWr_out; // @[Core.scala 47:37]
  wire  MEM_WB_io_ctrl_CsrWen_out; // @[Core.scala 47:37]
  wire  MEM_WB_io_ctrl_MemToReg_out; // @[Core.scala 47:37]
  wire  MEM_WB_io_ctrl_MemRd_out; // @[Core.scala 47:37]
  wire [4:0] MEM_WB_io_rd_sel_out; // @[Core.scala 47:37]
  wire [31:0] MEM_WB_io_dmem_data_out; // @[Core.scala 47:37]
  wire [31:0] MEM_WB_io_alu_output; // @[Core.scala 47:37]
  wire [31:0] MEM_WB_io_csr_data_out; // @[Core.scala 47:37]
  wire  fetch_clock; // @[Core.scala 48:37]
  wire  fetch_reset; // @[Core.scala 48:37]
  wire  fetch_io_coreInstrReq_ready; // @[Core.scala 48:37]
  wire  fetch_io_coreInstrReq_valid; // @[Core.scala 48:37]
  wire [31:0] fetch_io_coreInstrReq_bits_addrRequest; // @[Core.scala 48:37]
  wire  fetch_io_coreInstrRsp_valid; // @[Core.scala 48:37]
  wire [31:0] fetch_io_coreInstrRsp_bits_dataResponse; // @[Core.scala 48:37]
  wire  fetch_io_csrRegFile_irq_pending_i; // @[Core.scala 48:37]
  wire  fetch_io_csrRegFile_csr_mstatus_mie_i; // @[Core.scala 48:37]
  wire [31:0] fetch_io_csrRegFile_csr_mtvec_i; // @[Core.scala 48:37]
  wire  fetch_io_csrRegFile_csr_save_cause_o; // @[Core.scala 48:37]
  wire  fetch_io_csrRegFile_csr_save_if_o; // @[Core.scala 48:37]
  wire [31:0] fetch_io_csrRegFile_csr_if_pc_o; // @[Core.scala 48:37]
  wire [5:0] fetch_io_csrRegFile_exc_cause_o; // @[Core.scala 48:37]
  wire [31:0] fetch_io_csrRegFile_csr_mepc_i; // @[Core.scala 48:37]
  wire [31:0] fetch_io_decode_sb_imm_i; // @[Core.scala 48:37]
  wire [31:0] fetch_io_decode_uj_imm_i; // @[Core.scala 48:37]
  wire [31:0] fetch_io_decode_jalr_imm_i; // @[Core.scala 48:37]
  wire [1:0] fetch_io_decode_ctrl_next_pc_sel_i; // @[Core.scala 48:37]
  wire  fetch_io_decode_ctrl_out_branch_i; // @[Core.scala 48:37]
  wire  fetch_io_decode_branchLogic_output_i; // @[Core.scala 48:37]
  wire [31:0] fetch_io_decode_hazardDetection_pc_i; // @[Core.scala 48:37]
  wire [31:0] fetch_io_decode_hazardDetection_inst_i; // @[Core.scala 48:37]
  wire [31:0] fetch_io_decode_hazardDetection_current_pc_i; // @[Core.scala 48:37]
  wire  fetch_io_decode_hazardDetection_pc_forward_i; // @[Core.scala 48:37]
  wire  fetch_io_decode_hazardDetection_inst_forward_i; // @[Core.scala 48:37]
  wire  fetch_io_decode_mret_inst_i; // @[Core.scala 48:37]
  wire  fetch_io_core_stall_i; // @[Core.scala 48:37]
  wire [31:0] fetch_io_decode_if_id_pc_o; // @[Core.scala 48:37]
  wire [31:0] fetch_io_decode_if_id_pc4_o; // @[Core.scala 48:37]
  wire [31:0] fetch_io_decode_if_id_inst_o; // @[Core.scala 48:37]
  wire  decode_clock; // @[Core.scala 49:37]
  wire  decode_reset; // @[Core.scala 49:37]
  wire [31:0] decode_io_IF_ID_inst; // @[Core.scala 49:37]
  wire [31:0] decode_io_IF_ID_pc; // @[Core.scala 49:37]
  wire [31:0] decode_io_IF_ID_pc4; // @[Core.scala 49:37]
  wire  decode_io_MEM_WB_ctrl_regWr; // @[Core.scala 49:37]
  wire  decode_io_MEM_WB_ctrl_csrWen; // @[Core.scala 49:37]
  wire [4:0] decode_io_MEM_WB_rd_sel; // @[Core.scala 49:37]
  wire  decode_io_ID_EX_ctrl_MemRd; // @[Core.scala 49:37]
  wire  decode_io_ID_EX_ctrl_regWr; // @[Core.scala 49:37]
  wire  decode_io_ID_EX_ctrl_csrWen; // @[Core.scala 49:37]
  wire  decode_io_EX_MEM_ctrl_csrWen; // @[Core.scala 49:37]
  wire [4:0] decode_io_ID_EX_rd_sel; // @[Core.scala 49:37]
  wire [4:0] decode_io_EX_MEM_rd_sel; // @[Core.scala 49:37]
  wire  decode_io_EX_MEM_ctrl_MemRd; // @[Core.scala 49:37]
  wire  decode_io_EX_MEM_ctrl_regWr; // @[Core.scala 49:37]
  wire  decode_io_MEM_WB_ctrl_MemRd; // @[Core.scala 49:37]
  wire [31:0] decode_io_alu_output; // @[Core.scala 49:37]
  wire [31:0] decode_io_EX_MEM_alu_output; // @[Core.scala 49:37]
  wire [31:0] decode_io_dmem_memOut; // @[Core.scala 49:37]
  wire  decode_io_dccm_rvalid_i; // @[Core.scala 49:37]
  wire [31:0] decode_io_writeback_write_data; // @[Core.scala 49:37]
  wire [31:0] decode_io_MEM_WB_csr_rdata_i; // @[Core.scala 49:37]
  wire [31:0] decode_io_EX_MEM_csr_rdata_i; // @[Core.scala 49:37]
  wire [31:0] decode_io_ID_EX_csr_rdata_i; // @[Core.scala 49:37]
  wire [31:0] decode_io_fetch_csr_if_pc; // @[Core.scala 49:37]
  wire  decode_io_fetch_csr_save_if; // @[Core.scala 49:37]
  wire [5:0] decode_io_fetch_exc_cause_i; // @[Core.scala 49:37]
  wire  decode_io_fetch_csr_save_cause_i; // @[Core.scala 49:37]
  wire  decode_io_execute_regwrite; // @[Core.scala 49:37]
  wire  decode_io_mem_regwrite; // @[Core.scala 49:37]
  wire  decode_io_wb_regwrite; // @[Core.scala 49:37]
  wire [31:0] decode_io_pc_out; // @[Core.scala 49:37]
  wire [31:0] decode_io_pc4_out; // @[Core.scala 49:37]
  wire [31:0] decode_io_inst_op_out; // @[Core.scala 49:37]
  wire [2:0] decode_io_func3_out; // @[Core.scala 49:37]
  wire [6:0] decode_io_func7_out; // @[Core.scala 49:37]
  wire [4:0] decode_io_rd_sel_out; // @[Core.scala 49:37]
  wire [4:0] decode_io_rs1_sel_out; // @[Core.scala 49:37]
  wire [4:0] decode_io_rs2_sel_out; // @[Core.scala 49:37]
  wire [31:0] decode_io_rs1_out; // @[Core.scala 49:37]
  wire [31:0] decode_io_rs2_out; // @[Core.scala 49:37]
  wire [31:0] decode_io_csr_rdata_o; // @[Core.scala 49:37]
  wire [31:0] decode_io_imm_out; // @[Core.scala 49:37]
  wire [31:0] decode_io_sb_imm; // @[Core.scala 49:37]
  wire [31:0] decode_io_uj_imm; // @[Core.scala 49:37]
  wire [31:0] decode_io_jalr_output; // @[Core.scala 49:37]
  wire  decode_io_branchLogic_output; // @[Core.scala 49:37]
  wire [31:0] decode_io_hazardDetection_pc_out; // @[Core.scala 49:37]
  wire [31:0] decode_io_hazardDetection_inst_out; // @[Core.scala 49:37]
  wire [31:0] decode_io_hazardDetection_current_pc_out; // @[Core.scala 49:37]
  wire  decode_io_hazardDetection_pc_forward; // @[Core.scala 49:37]
  wire  decode_io_hazardDetection_inst_forward; // @[Core.scala 49:37]
  wire  decode_io_ctrl_MemWr_out; // @[Core.scala 49:37]
  wire  decode_io_ctrl_MemRd_out; // @[Core.scala 49:37]
  wire  decode_io_ctrl_Branch_out; // @[Core.scala 49:37]
  wire  decode_io_ctrl_RegWr_out; // @[Core.scala 49:37]
  wire  decode_io_ctrl_CsrWen_out; // @[Core.scala 49:37]
  wire  decode_io_ctrl_MemToReg_out; // @[Core.scala 49:37]
  wire [3:0] decode_io_ctrl_AluOp_out; // @[Core.scala 49:37]
  wire [1:0] decode_io_ctrl_OpA_sel_out; // @[Core.scala 49:37]
  wire  decode_io_ctrl_OpB_sel_out; // @[Core.scala 49:37]
  wire [1:0] decode_io_ctrl_next_pc_sel_out; // @[Core.scala 49:37]
  wire  decode_io_fetch_irq_pending_o; // @[Core.scala 49:37]
  wire  decode_io_fetch_csr_mstatus_mie_o; // @[Core.scala 49:37]
  wire [31:0] decode_io_fetch_csr_mtvec_o; // @[Core.scala 49:37]
  wire [31:0] decode_io_fetch_csr_mepc_o; // @[Core.scala 49:37]
  wire  decode_io_fetch_mret_inst_o; // @[Core.scala 49:37]
  wire [4:0] execute_io_EX_MEM_rd_sel; // @[Core.scala 50:37]
  wire [4:0] execute_io_MEM_WB_rd_sel; // @[Core.scala 50:37]
  wire [4:0] execute_io_ID_EX_rs1_sel; // @[Core.scala 50:37]
  wire [4:0] execute_io_ID_EX_rs2_sel; // @[Core.scala 50:37]
  wire  execute_io_EX_MEM_ctrl_RegWr; // @[Core.scala 50:37]
  wire  execute_io_EX_MEM_ctrl_csrWen; // @[Core.scala 50:37]
  wire  execute_io_MEM_WB_ctrl_csrWen; // @[Core.scala 50:37]
  wire  execute_io_MEM_WB_ctrl_RegWr; // @[Core.scala 50:37]
  wire [1:0] execute_io_ID_EX_ctrl_OpA_sel; // @[Core.scala 50:37]
  wire  execute_io_ID_EX_ctrl_OpB_sel; // @[Core.scala 50:37]
  wire [31:0] execute_io_ID_EX_pc4; // @[Core.scala 50:37]
  wire [31:0] execute_io_ID_EX_pc_out; // @[Core.scala 50:37]
  wire [31:0] execute_io_ID_EX_rs1; // @[Core.scala 50:37]
  wire [31:0] execute_io_ID_EX_rs2; // @[Core.scala 50:37]
  wire [31:0] execute_io_ID_EX_csr_data; // @[Core.scala 50:37]
  wire [31:0] execute_io_EX_MEM_alu_output; // @[Core.scala 50:37]
  wire [31:0] execute_io_EX_MEM_csr_rdata; // @[Core.scala 50:37]
  wire [31:0] execute_io_MEM_WB_csr_rdata; // @[Core.scala 50:37]
  wire [31:0] execute_io_writeback_write_data; // @[Core.scala 50:37]
  wire [31:0] execute_io_ID_EX_imm; // @[Core.scala 50:37]
  wire [3:0] execute_io_ID_EX_ctrl_AluOp; // @[Core.scala 50:37]
  wire [6:0] execute_io_ID_EX_func7; // @[Core.scala 50:37]
  wire [6:0] execute_io_ID_EX_inst_op; // @[Core.scala 50:37]
  wire [2:0] execute_io_ID_EX_func3; // @[Core.scala 50:37]
  wire [4:0] execute_io_ID_EX_rd_sel; // @[Core.scala 50:37]
  wire  execute_io_ID_EX_ctrl_MemWr; // @[Core.scala 50:37]
  wire  execute_io_ID_EX_ctrl_MemRd; // @[Core.scala 50:37]
  wire  execute_io_ID_EX_ctrl_RegWr; // @[Core.scala 50:37]
  wire  execute_io_ID_EX_ctrl_CsrWen; // @[Core.scala 50:37]
  wire  execute_io_ID_EX_ctrl_MemToReg; // @[Core.scala 50:37]
  wire [31:0] execute_io_rs2_out; // @[Core.scala 50:37]
  wire [31:0] execute_io_alu_output; // @[Core.scala 50:37]
  wire [4:0] execute_io_rd_sel_out; // @[Core.scala 50:37]
  wire  execute_io_ctrl_MemWr_out; // @[Core.scala 50:37]
  wire  execute_io_ctrl_MemRd_out; // @[Core.scala 50:37]
  wire  execute_io_ctrl_RegWr_out; // @[Core.scala 50:37]
  wire  execute_io_ctrl_CsrWe_out; // @[Core.scala 50:37]
  wire  execute_io_ctrl_MemToReg_out; // @[Core.scala 50:37]
  wire [2:0] execute_io_func3_out; // @[Core.scala 50:37]
  wire [31:0] execute_io_csr_data_o; // @[Core.scala 50:37]
  wire [31:0] memory_stage_io_EX_MEM_alu_output; // @[Core.scala 51:37]
  wire [4:0] memory_stage_io_EX_MEM_rd_sel; // @[Core.scala 51:37]
  wire  memory_stage_io_EX_MEM_RegWr; // @[Core.scala 51:37]
  wire  memory_stage_io_EX_MEM_CsrWe; // @[Core.scala 51:37]
  wire  memory_stage_io_EX_MEM_MemRd; // @[Core.scala 51:37]
  wire  memory_stage_io_EX_MEM_MemToReg; // @[Core.scala 51:37]
  wire  memory_stage_io_EX_MEM_MemWr; // @[Core.scala 51:37]
  wire [31:0] memory_stage_io_EX_MEM_rs2; // @[Core.scala 51:37]
  wire [2:0] memory_stage_io_func3; // @[Core.scala 51:37]
  wire [31:0] memory_stage_io_EX_MEM_csr_data; // @[Core.scala 51:37]
  wire  memory_stage_io_coreDccmReq_ready; // @[Core.scala 51:37]
  wire  memory_stage_io_coreDccmReq_valid; // @[Core.scala 51:37]
  wire [31:0] memory_stage_io_coreDccmReq_bits_addrRequest; // @[Core.scala 51:37]
  wire [31:0] memory_stage_io_coreDccmReq_bits_dataRequest; // @[Core.scala 51:37]
  wire [3:0] memory_stage_io_coreDccmReq_bits_activeByteLane; // @[Core.scala 51:37]
  wire  memory_stage_io_coreDccmReq_bits_isWrite; // @[Core.scala 51:37]
  wire  memory_stage_io_coreDccmRsp_valid; // @[Core.scala 51:37]
  wire [31:0] memory_stage_io_coreDccmRsp_bits_dataResponse; // @[Core.scala 51:37]
  wire [31:0] memory_stage_io_data_out; // @[Core.scala 51:37]
  wire [31:0] memory_stage_io_alu_output; // @[Core.scala 51:37]
  wire [4:0] memory_stage_io_rd_sel_out; // @[Core.scala 51:37]
  wire  memory_stage_io_ctrl_RegWr_out; // @[Core.scala 51:37]
  wire  memory_stage_io_ctrl_CsrWen_out; // @[Core.scala 51:37]
  wire  memory_stage_io_ctrl_MemRd_out; // @[Core.scala 51:37]
  wire  memory_stage_io_ctrl_MemToReg_out; // @[Core.scala 51:37]
  wire [31:0] memory_stage_io_csr_data_out; // @[Core.scala 51:37]
  wire  memory_stage_io_stall; // @[Core.scala 51:37]
  wire  writeback_io_MEM_WB_MemToReg; // @[Core.scala 52:37]
  wire [31:0] writeback_io_MEM_WB_dataMem_data; // @[Core.scala 52:37]
  wire [31:0] writeback_io_MEM_WB_alu_output; // @[Core.scala 52:37]
  wire [31:0] writeback_io_write_data; // @[Core.scala 52:37]
  ID_EX ID_EX ( // @[Core.scala 45:37]
    .clock(ID_EX_clock),
    .reset(ID_EX_reset),
    .io_pc_in(ID_EX_io_pc_in),
    .io_pc4_in(ID_EX_io_pc4_in),
    .io_rs1_sel_in(ID_EX_io_rs1_sel_in),
    .io_rs2_sel_in(ID_EX_io_rs2_sel_in),
    .io_rs1_in(ID_EX_io_rs1_in),
    .io_rs2_in(ID_EX_io_rs2_in),
    .io_imm(ID_EX_io_imm),
    .io_rd_sel_in(ID_EX_io_rd_sel_in),
    .io_func3_in(ID_EX_io_func3_in),
    .io_func7_in(ID_EX_io_func7_in),
    .io_ctrl_MemWr_in(ID_EX_io_ctrl_MemWr_in),
    .io_ctrl_MemRd_in(ID_EX_io_ctrl_MemRd_in),
    .io_ctrl_CsrWen_in(ID_EX_io_ctrl_CsrWen_in),
    .io_ctrl_RegWr_in(ID_EX_io_ctrl_RegWr_in),
    .io_ctrl_MemToReg_in(ID_EX_io_ctrl_MemToReg_in),
    .io_ctrl_AluOp_in(ID_EX_io_ctrl_AluOp_in),
    .io_ctrl_OpA_sel_in(ID_EX_io_ctrl_OpA_sel_in),
    .io_ctrl_OpB_sel_in(ID_EX_io_ctrl_OpB_sel_in),
    .io_inst_op_in(ID_EX_io_inst_op_in),
    .io_csr_data_i(ID_EX_io_csr_data_i),
    .io_stall(ID_EX_io_stall),
    .io_pc_out(ID_EX_io_pc_out),
    .io_pc4_out(ID_EX_io_pc4_out),
    .io_rs1_out(ID_EX_io_rs1_out),
    .io_rs2_out(ID_EX_io_rs2_out),
    .io_imm_out(ID_EX_io_imm_out),
    .io_func3_out(ID_EX_io_func3_out),
    .io_func7_out(ID_EX_io_func7_out),
    .io_inst_op_out(ID_EX_io_inst_op_out),
    .io_rd_sel_out(ID_EX_io_rd_sel_out),
    .io_rs1_sel_out(ID_EX_io_rs1_sel_out),
    .io_rs2_sel_out(ID_EX_io_rs2_sel_out),
    .io_ctrl_MemWr_out(ID_EX_io_ctrl_MemWr_out),
    .io_ctrl_MemRd_out(ID_EX_io_ctrl_MemRd_out),
    .io_ctrl_RegWr_out(ID_EX_io_ctrl_RegWr_out),
    .io_ctrl_CsrWen_out(ID_EX_io_ctrl_CsrWen_out),
    .io_ctrl_MemToReg_out(ID_EX_io_ctrl_MemToReg_out),
    .io_ctrl_AluOp_out(ID_EX_io_ctrl_AluOp_out),
    .io_ctrl_OpA_sel_out(ID_EX_io_ctrl_OpA_sel_out),
    .io_ctrl_OpB_sel_out(ID_EX_io_ctrl_OpB_sel_out),
    .io_csr_data_o(ID_EX_io_csr_data_o)
  );
  EX_MEM EX_MEM ( // @[Core.scala 46:37]
    .clock(EX_MEM_clock),
    .reset(EX_MEM_reset),
    .io_ctrl_MemWr_in(EX_MEM_io_ctrl_MemWr_in),
    .io_ctrl_MemRd_in(EX_MEM_io_ctrl_MemRd_in),
    .io_ctrl_RegWr_in(EX_MEM_io_ctrl_RegWr_in),
    .io_ctrl_CsrWen_in(EX_MEM_io_ctrl_CsrWen_in),
    .io_ctrl_MemToReg_in(EX_MEM_io_ctrl_MemToReg_in),
    .io_rs2_in(EX_MEM_io_rs2_in),
    .io_rd_sel_in(EX_MEM_io_rd_sel_in),
    .io_alu_in(EX_MEM_io_alu_in),
    .io_EX_MEM_func3(EX_MEM_io_EX_MEM_func3),
    .io_csr_data_i(EX_MEM_io_csr_data_i),
    .io_stall(EX_MEM_io_stall),
    .io_ctrl_MemWr_out(EX_MEM_io_ctrl_MemWr_out),
    .io_ctrl_MemRd_out(EX_MEM_io_ctrl_MemRd_out),
    .io_ctrl_RegWr_out(EX_MEM_io_ctrl_RegWr_out),
    .io_ctrl_CsrWen_out(EX_MEM_io_ctrl_CsrWen_out),
    .io_ctrl_MemToReg_out(EX_MEM_io_ctrl_MemToReg_out),
    .io_rs2_out(EX_MEM_io_rs2_out),
    .io_rd_sel_out(EX_MEM_io_rd_sel_out),
    .io_alu_output(EX_MEM_io_alu_output),
    .io_EX_MEM_func3_out(EX_MEM_io_EX_MEM_func3_out),
    .io_csr_data_o(EX_MEM_io_csr_data_o)
  );
  MEM_WB MEM_WB ( // @[Core.scala 47:37]
    .clock(MEM_WB_clock),
    .reset(MEM_WB_reset),
    .io_ctrl_RegWr_in(MEM_WB_io_ctrl_RegWr_in),
    .io_ctrl_CsrWen_in(MEM_WB_io_ctrl_CsrWen_in),
    .io_ctrl_MemToReg_in(MEM_WB_io_ctrl_MemToReg_in),
    .io_rd_sel_in(MEM_WB_io_rd_sel_in),
    .io_ctrl_MemRd_in(MEM_WB_io_ctrl_MemRd_in),
    .io_dmem_data_in(MEM_WB_io_dmem_data_in),
    .io_alu_in(MEM_WB_io_alu_in),
    .io_csr_data_in(MEM_WB_io_csr_data_in),
    .io_stall(MEM_WB_io_stall),
    .io_ctrl_RegWr_out(MEM_WB_io_ctrl_RegWr_out),
    .io_ctrl_CsrWen_out(MEM_WB_io_ctrl_CsrWen_out),
    .io_ctrl_MemToReg_out(MEM_WB_io_ctrl_MemToReg_out),
    .io_ctrl_MemRd_out(MEM_WB_io_ctrl_MemRd_out),
    .io_rd_sel_out(MEM_WB_io_rd_sel_out),
    .io_dmem_data_out(MEM_WB_io_dmem_data_out),
    .io_alu_output(MEM_WB_io_alu_output),
    .io_csr_data_out(MEM_WB_io_csr_data_out)
  );
  Fetch fetch ( // @[Core.scala 48:37]
    .clock(fetch_clock),
    .reset(fetch_reset),
    .io_coreInstrReq_ready(fetch_io_coreInstrReq_ready),
    .io_coreInstrReq_valid(fetch_io_coreInstrReq_valid),
    .io_coreInstrReq_bits_addrRequest(fetch_io_coreInstrReq_bits_addrRequest),
    .io_coreInstrRsp_valid(fetch_io_coreInstrRsp_valid),
    .io_coreInstrRsp_bits_dataResponse(fetch_io_coreInstrRsp_bits_dataResponse),
    .io_csrRegFile_irq_pending_i(fetch_io_csrRegFile_irq_pending_i),
    .io_csrRegFile_csr_mstatus_mie_i(fetch_io_csrRegFile_csr_mstatus_mie_i),
    .io_csrRegFile_csr_mtvec_i(fetch_io_csrRegFile_csr_mtvec_i),
    .io_csrRegFile_csr_save_cause_o(fetch_io_csrRegFile_csr_save_cause_o),
    .io_csrRegFile_csr_save_if_o(fetch_io_csrRegFile_csr_save_if_o),
    .io_csrRegFile_csr_if_pc_o(fetch_io_csrRegFile_csr_if_pc_o),
    .io_csrRegFile_exc_cause_o(fetch_io_csrRegFile_exc_cause_o),
    .io_csrRegFile_csr_mepc_i(fetch_io_csrRegFile_csr_mepc_i),
    .io_decode_sb_imm_i(fetch_io_decode_sb_imm_i),
    .io_decode_uj_imm_i(fetch_io_decode_uj_imm_i),
    .io_decode_jalr_imm_i(fetch_io_decode_jalr_imm_i),
    .io_decode_ctrl_next_pc_sel_i(fetch_io_decode_ctrl_next_pc_sel_i),
    .io_decode_ctrl_out_branch_i(fetch_io_decode_ctrl_out_branch_i),
    .io_decode_branchLogic_output_i(fetch_io_decode_branchLogic_output_i),
    .io_decode_hazardDetection_pc_i(fetch_io_decode_hazardDetection_pc_i),
    .io_decode_hazardDetection_inst_i(fetch_io_decode_hazardDetection_inst_i),
    .io_decode_hazardDetection_current_pc_i(fetch_io_decode_hazardDetection_current_pc_i),
    .io_decode_hazardDetection_pc_forward_i(fetch_io_decode_hazardDetection_pc_forward_i),
    .io_decode_hazardDetection_inst_forward_i(fetch_io_decode_hazardDetection_inst_forward_i),
    .io_decode_mret_inst_i(fetch_io_decode_mret_inst_i),
    .io_core_stall_i(fetch_io_core_stall_i),
    .io_decode_if_id_pc_o(fetch_io_decode_if_id_pc_o),
    .io_decode_if_id_pc4_o(fetch_io_decode_if_id_pc4_o),
    .io_decode_if_id_inst_o(fetch_io_decode_if_id_inst_o)
  );
  Decode decode ( // @[Core.scala 49:37]
    .clock(decode_clock),
    .reset(decode_reset),
    .io_IF_ID_inst(decode_io_IF_ID_inst),
    .io_IF_ID_pc(decode_io_IF_ID_pc),
    .io_IF_ID_pc4(decode_io_IF_ID_pc4),
    .io_MEM_WB_ctrl_regWr(decode_io_MEM_WB_ctrl_regWr),
    .io_MEM_WB_ctrl_csrWen(decode_io_MEM_WB_ctrl_csrWen),
    .io_MEM_WB_rd_sel(decode_io_MEM_WB_rd_sel),
    .io_ID_EX_ctrl_MemRd(decode_io_ID_EX_ctrl_MemRd),
    .io_ID_EX_ctrl_regWr(decode_io_ID_EX_ctrl_regWr),
    .io_ID_EX_ctrl_csrWen(decode_io_ID_EX_ctrl_csrWen),
    .io_EX_MEM_ctrl_csrWen(decode_io_EX_MEM_ctrl_csrWen),
    .io_ID_EX_rd_sel(decode_io_ID_EX_rd_sel),
    .io_EX_MEM_rd_sel(decode_io_EX_MEM_rd_sel),
    .io_EX_MEM_ctrl_MemRd(decode_io_EX_MEM_ctrl_MemRd),
    .io_EX_MEM_ctrl_regWr(decode_io_EX_MEM_ctrl_regWr),
    .io_MEM_WB_ctrl_MemRd(decode_io_MEM_WB_ctrl_MemRd),
    .io_alu_output(decode_io_alu_output),
    .io_EX_MEM_alu_output(decode_io_EX_MEM_alu_output),
    .io_dmem_memOut(decode_io_dmem_memOut),
    .io_dccm_rvalid_i(decode_io_dccm_rvalid_i),
    .io_writeback_write_data(decode_io_writeback_write_data),
    .io_MEM_WB_csr_rdata_i(decode_io_MEM_WB_csr_rdata_i),
    .io_EX_MEM_csr_rdata_i(decode_io_EX_MEM_csr_rdata_i),
    .io_ID_EX_csr_rdata_i(decode_io_ID_EX_csr_rdata_i),
    .io_fetch_csr_if_pc(decode_io_fetch_csr_if_pc),
    .io_fetch_csr_save_if(decode_io_fetch_csr_save_if),
    .io_fetch_exc_cause_i(decode_io_fetch_exc_cause_i),
    .io_fetch_csr_save_cause_i(decode_io_fetch_csr_save_cause_i),
    .io_execute_regwrite(decode_io_execute_regwrite),
    .io_mem_regwrite(decode_io_mem_regwrite),
    .io_wb_regwrite(decode_io_wb_regwrite),
    .io_pc_out(decode_io_pc_out),
    .io_pc4_out(decode_io_pc4_out),
    .io_inst_op_out(decode_io_inst_op_out),
    .io_func3_out(decode_io_func3_out),
    .io_func7_out(decode_io_func7_out),
    .io_rd_sel_out(decode_io_rd_sel_out),
    .io_rs1_sel_out(decode_io_rs1_sel_out),
    .io_rs2_sel_out(decode_io_rs2_sel_out),
    .io_rs1_out(decode_io_rs1_out),
    .io_rs2_out(decode_io_rs2_out),
    .io_csr_rdata_o(decode_io_csr_rdata_o),
    .io_imm_out(decode_io_imm_out),
    .io_sb_imm(decode_io_sb_imm),
    .io_uj_imm(decode_io_uj_imm),
    .io_jalr_output(decode_io_jalr_output),
    .io_branchLogic_output(decode_io_branchLogic_output),
    .io_hazardDetection_pc_out(decode_io_hazardDetection_pc_out),
    .io_hazardDetection_inst_out(decode_io_hazardDetection_inst_out),
    .io_hazardDetection_current_pc_out(decode_io_hazardDetection_current_pc_out),
    .io_hazardDetection_pc_forward(decode_io_hazardDetection_pc_forward),
    .io_hazardDetection_inst_forward(decode_io_hazardDetection_inst_forward),
    .io_ctrl_MemWr_out(decode_io_ctrl_MemWr_out),
    .io_ctrl_MemRd_out(decode_io_ctrl_MemRd_out),
    .io_ctrl_Branch_out(decode_io_ctrl_Branch_out),
    .io_ctrl_RegWr_out(decode_io_ctrl_RegWr_out),
    .io_ctrl_CsrWen_out(decode_io_ctrl_CsrWen_out),
    .io_ctrl_MemToReg_out(decode_io_ctrl_MemToReg_out),
    .io_ctrl_AluOp_out(decode_io_ctrl_AluOp_out),
    .io_ctrl_OpA_sel_out(decode_io_ctrl_OpA_sel_out),
    .io_ctrl_OpB_sel_out(decode_io_ctrl_OpB_sel_out),
    .io_ctrl_next_pc_sel_out(decode_io_ctrl_next_pc_sel_out),
    .io_fetch_irq_pending_o(decode_io_fetch_irq_pending_o),
    .io_fetch_csr_mstatus_mie_o(decode_io_fetch_csr_mstatus_mie_o),
    .io_fetch_csr_mtvec_o(decode_io_fetch_csr_mtvec_o),
    .io_fetch_csr_mepc_o(decode_io_fetch_csr_mepc_o),
    .io_fetch_mret_inst_o(decode_io_fetch_mret_inst_o)
  );
  Execute execute ( // @[Core.scala 50:37]
    .io_EX_MEM_rd_sel(execute_io_EX_MEM_rd_sel),
    .io_MEM_WB_rd_sel(execute_io_MEM_WB_rd_sel),
    .io_ID_EX_rs1_sel(execute_io_ID_EX_rs1_sel),
    .io_ID_EX_rs2_sel(execute_io_ID_EX_rs2_sel),
    .io_EX_MEM_ctrl_RegWr(execute_io_EX_MEM_ctrl_RegWr),
    .io_EX_MEM_ctrl_csrWen(execute_io_EX_MEM_ctrl_csrWen),
    .io_MEM_WB_ctrl_csrWen(execute_io_MEM_WB_ctrl_csrWen),
    .io_MEM_WB_ctrl_RegWr(execute_io_MEM_WB_ctrl_RegWr),
    .io_ID_EX_ctrl_OpA_sel(execute_io_ID_EX_ctrl_OpA_sel),
    .io_ID_EX_ctrl_OpB_sel(execute_io_ID_EX_ctrl_OpB_sel),
    .io_ID_EX_pc4(execute_io_ID_EX_pc4),
    .io_ID_EX_pc_out(execute_io_ID_EX_pc_out),
    .io_ID_EX_rs1(execute_io_ID_EX_rs1),
    .io_ID_EX_rs2(execute_io_ID_EX_rs2),
    .io_ID_EX_csr_data(execute_io_ID_EX_csr_data),
    .io_EX_MEM_alu_output(execute_io_EX_MEM_alu_output),
    .io_EX_MEM_csr_rdata(execute_io_EX_MEM_csr_rdata),
    .io_MEM_WB_csr_rdata(execute_io_MEM_WB_csr_rdata),
    .io_writeback_write_data(execute_io_writeback_write_data),
    .io_ID_EX_imm(execute_io_ID_EX_imm),
    .io_ID_EX_ctrl_AluOp(execute_io_ID_EX_ctrl_AluOp),
    .io_ID_EX_func7(execute_io_ID_EX_func7),
    .io_ID_EX_inst_op(execute_io_ID_EX_inst_op),
    .io_ID_EX_func3(execute_io_ID_EX_func3),
    .io_ID_EX_rd_sel(execute_io_ID_EX_rd_sel),
    .io_ID_EX_ctrl_MemWr(execute_io_ID_EX_ctrl_MemWr),
    .io_ID_EX_ctrl_MemRd(execute_io_ID_EX_ctrl_MemRd),
    .io_ID_EX_ctrl_RegWr(execute_io_ID_EX_ctrl_RegWr),
    .io_ID_EX_ctrl_CsrWen(execute_io_ID_EX_ctrl_CsrWen),
    .io_ID_EX_ctrl_MemToReg(execute_io_ID_EX_ctrl_MemToReg),
    .io_rs2_out(execute_io_rs2_out),
    .io_alu_output(execute_io_alu_output),
    .io_rd_sel_out(execute_io_rd_sel_out),
    .io_ctrl_MemWr_out(execute_io_ctrl_MemWr_out),
    .io_ctrl_MemRd_out(execute_io_ctrl_MemRd_out),
    .io_ctrl_RegWr_out(execute_io_ctrl_RegWr_out),
    .io_ctrl_CsrWe_out(execute_io_ctrl_CsrWe_out),
    .io_ctrl_MemToReg_out(execute_io_ctrl_MemToReg_out),
    .io_func3_out(execute_io_func3_out),
    .io_csr_data_o(execute_io_csr_data_o)
  );
  MemoryStage memory_stage ( // @[Core.scala 51:37]
    .io_EX_MEM_alu_output(memory_stage_io_EX_MEM_alu_output),
    .io_EX_MEM_rd_sel(memory_stage_io_EX_MEM_rd_sel),
    .io_EX_MEM_RegWr(memory_stage_io_EX_MEM_RegWr),
    .io_EX_MEM_CsrWe(memory_stage_io_EX_MEM_CsrWe),
    .io_EX_MEM_MemRd(memory_stage_io_EX_MEM_MemRd),
    .io_EX_MEM_MemToReg(memory_stage_io_EX_MEM_MemToReg),
    .io_EX_MEM_MemWr(memory_stage_io_EX_MEM_MemWr),
    .io_EX_MEM_rs2(memory_stage_io_EX_MEM_rs2),
    .io_func3(memory_stage_io_func3),
    .io_EX_MEM_csr_data(memory_stage_io_EX_MEM_csr_data),
    .io_coreDccmReq_ready(memory_stage_io_coreDccmReq_ready),
    .io_coreDccmReq_valid(memory_stage_io_coreDccmReq_valid),
    .io_coreDccmReq_bits_addrRequest(memory_stage_io_coreDccmReq_bits_addrRequest),
    .io_coreDccmReq_bits_dataRequest(memory_stage_io_coreDccmReq_bits_dataRequest),
    .io_coreDccmReq_bits_activeByteLane(memory_stage_io_coreDccmReq_bits_activeByteLane),
    .io_coreDccmReq_bits_isWrite(memory_stage_io_coreDccmReq_bits_isWrite),
    .io_coreDccmRsp_valid(memory_stage_io_coreDccmRsp_valid),
    .io_coreDccmRsp_bits_dataResponse(memory_stage_io_coreDccmRsp_bits_dataResponse),
    .io_data_out(memory_stage_io_data_out),
    .io_alu_output(memory_stage_io_alu_output),
    .io_rd_sel_out(memory_stage_io_rd_sel_out),
    .io_ctrl_RegWr_out(memory_stage_io_ctrl_RegWr_out),
    .io_ctrl_CsrWen_out(memory_stage_io_ctrl_CsrWen_out),
    .io_ctrl_MemRd_out(memory_stage_io_ctrl_MemRd_out),
    .io_ctrl_MemToReg_out(memory_stage_io_ctrl_MemToReg_out),
    .io_csr_data_out(memory_stage_io_csr_data_out),
    .io_stall(memory_stage_io_stall)
  );
  WriteBack writeback ( // @[Core.scala 52:37]
    .io_MEM_WB_MemToReg(writeback_io_MEM_WB_MemToReg),
    .io_MEM_WB_dataMem_data(writeback_io_MEM_WB_dataMem_data),
    .io_MEM_WB_alu_output(writeback_io_MEM_WB_alu_output),
    .io_write_data(writeback_io_write_data)
  );
  assign io_dmemReq_valid = memory_stage_io_coreDccmReq_valid; // @[Core.scala 232:14]
  assign io_dmemReq_bits_addrRequest = memory_stage_io_coreDccmReq_bits_addrRequest; // @[Core.scala 232:14]
  assign io_dmemReq_bits_dataRequest = memory_stage_io_coreDccmReq_bits_dataRequest; // @[Core.scala 232:14]
  assign io_dmemReq_bits_activeByteLane = memory_stage_io_coreDccmReq_bits_activeByteLane; // @[Core.scala 232:14]
  assign io_dmemReq_bits_isWrite = memory_stage_io_coreDccmReq_bits_isWrite; // @[Core.scala 232:14]
  assign io_imemReq_valid = fetch_io_coreInstrReq_valid; // @[Core.scala 62:14]
  assign io_imemReq_bits_addrRequest = fetch_io_coreInstrReq_bits_addrRequest; // @[Core.scala 62:14]
  assign ID_EX_clock = clock;
  assign ID_EX_reset = reset;
  assign ID_EX_io_pc_in = decode_io_pc_out; // @[Core.scala 147:49]
  assign ID_EX_io_pc4_in = decode_io_pc4_out; // @[Core.scala 148:49]
  assign ID_EX_io_rs1_sel_in = decode_io_rs1_sel_out; // @[Core.scala 153:49]
  assign ID_EX_io_rs2_sel_in = decode_io_rs2_sel_out; // @[Core.scala 154:49]
  assign ID_EX_io_rs1_in = decode_io_rs1_out; // @[Core.scala 141:49]
  assign ID_EX_io_rs2_in = decode_io_rs2_out; // @[Core.scala 142:49]
  assign ID_EX_io_imm = decode_io_imm_out; // @[Core.scala 143:49]
  assign ID_EX_io_rd_sel_in = decode_io_rd_sel_out; // @[Core.scala 152:49]
  assign ID_EX_io_func3_in = decode_io_func3_out; // @[Core.scala 149:49]
  assign ID_EX_io_func7_in = decode_io_func7_out; // @[Core.scala 150:49]
  assign ID_EX_io_ctrl_MemWr_in = decode_io_ctrl_MemWr_out; // @[Core.scala 130:49]
  assign ID_EX_io_ctrl_MemRd_in = decode_io_ctrl_MemRd_out; // @[Core.scala 131:49]
  assign ID_EX_io_ctrl_CsrWen_in = decode_io_ctrl_CsrWen_out; // @[Core.scala 134:49]
  assign ID_EX_io_ctrl_RegWr_in = decode_io_ctrl_RegWr_out; // @[Core.scala 133:49]
  assign ID_EX_io_ctrl_MemToReg_in = decode_io_ctrl_MemToReg_out; // @[Core.scala 135:49]
  assign ID_EX_io_ctrl_AluOp_in = decode_io_ctrl_AluOp_out; // @[Core.scala 136:49]
  assign ID_EX_io_ctrl_OpA_sel_in = decode_io_ctrl_OpA_sel_out; // @[Core.scala 137:49]
  assign ID_EX_io_ctrl_OpB_sel_in = decode_io_ctrl_OpB_sel_out; // @[Core.scala 138:49]
  assign ID_EX_io_inst_op_in = decode_io_inst_op_out[6:0]; // @[Core.scala 151:49]
  assign ID_EX_io_csr_data_i = decode_io_csr_rdata_o; // @[Core.scala 145:49]
  assign ID_EX_io_stall = memory_stage_io_stall; // @[Core.scala 55:53]
  assign EX_MEM_clock = clock;
  assign EX_MEM_reset = reset;
  assign EX_MEM_io_ctrl_MemWr_in = execute_io_ctrl_MemWr_out; // @[Core.scala 210:49]
  assign EX_MEM_io_ctrl_MemRd_in = execute_io_ctrl_MemRd_out; // @[Core.scala 211:49]
  assign EX_MEM_io_ctrl_RegWr_in = execute_io_ctrl_RegWr_out; // @[Core.scala 212:49]
  assign EX_MEM_io_ctrl_CsrWen_in = execute_io_ctrl_CsrWe_out; // @[Core.scala 203:49]
  assign EX_MEM_io_ctrl_MemToReg_in = execute_io_ctrl_MemToReg_out; // @[Core.scala 213:49]
  assign EX_MEM_io_rs2_in = execute_io_rs2_out; // @[Core.scala 201:49]
  assign EX_MEM_io_rd_sel_in = execute_io_rd_sel_out; // @[Core.scala 199:49]
  assign EX_MEM_io_alu_in = execute_io_alu_output; // @[Core.scala 196:49]
  assign EX_MEM_io_EX_MEM_func3 = execute_io_func3_out; // @[Core.scala 202:49]
  assign EX_MEM_io_csr_data_i = execute_io_csr_data_o; // @[Core.scala 206:49]
  assign EX_MEM_io_stall = memory_stage_io_stall; // @[Core.scala 55:53]
  assign MEM_WB_clock = clock;
  assign MEM_WB_reset = reset;
  assign MEM_WB_io_ctrl_RegWr_in = memory_stage_io_ctrl_RegWr_out; // @[Core.scala 250:49]
  assign MEM_WB_io_ctrl_CsrWen_in = memory_stage_io_ctrl_CsrWen_out; // @[Core.scala 251:49]
  assign MEM_WB_io_ctrl_MemToReg_in = memory_stage_io_ctrl_MemToReg_out; // @[Core.scala 253:49]
  assign MEM_WB_io_rd_sel_in = memory_stage_io_rd_sel_out; // @[Core.scala 248:49]
  assign MEM_WB_io_ctrl_MemRd_in = memory_stage_io_ctrl_MemRd_out; // @[Core.scala 252:49]
  assign MEM_WB_io_dmem_data_in = memory_stage_io_data_out; // @[Core.scala 247:49]
  assign MEM_WB_io_alu_in = memory_stage_io_alu_output; // @[Core.scala 245:49]
  assign MEM_WB_io_csr_data_in = memory_stage_io_csr_data_out; // @[Core.scala 256:49]
  assign MEM_WB_io_stall = memory_stage_io_stall; // @[Core.scala 55:53]
  assign fetch_clock = clock;
  assign fetch_reset = reset;
  assign fetch_io_coreInstrReq_ready = io_imemReq_ready; // @[Core.scala 62:14]
  assign fetch_io_coreInstrRsp_valid = io_imemRsp_valid; // @[Core.scala 63:25]
  assign fetch_io_coreInstrRsp_bits_dataResponse = io_imemRsp_bits_dataResponse; // @[Core.scala 63:25]
  assign fetch_io_csrRegFile_irq_pending_i = decode_io_fetch_irq_pending_o; // @[Core.scala 69:49]
  assign fetch_io_csrRegFile_csr_mstatus_mie_i = decode_io_fetch_csr_mstatus_mie_o; // @[Core.scala 70:49]
  assign fetch_io_csrRegFile_csr_mtvec_i = decode_io_fetch_csr_mtvec_o; // @[Core.scala 71:49]
  assign fetch_io_csrRegFile_csr_mepc_i = decode_io_fetch_csr_mepc_o; // @[Core.scala 72:49]
  assign fetch_io_decode_sb_imm_i = decode_io_sb_imm; // @[Core.scala 75:49]
  assign fetch_io_decode_uj_imm_i = decode_io_uj_imm; // @[Core.scala 76:49]
  assign fetch_io_decode_jalr_imm_i = decode_io_jalr_output; // @[Core.scala 77:49]
  assign fetch_io_decode_ctrl_next_pc_sel_i = decode_io_ctrl_next_pc_sel_out; // @[Core.scala 78:49]
  assign fetch_io_decode_ctrl_out_branch_i = decode_io_ctrl_Branch_out; // @[Core.scala 79:49]
  assign fetch_io_decode_branchLogic_output_i = decode_io_branchLogic_output; // @[Core.scala 80:49]
  assign fetch_io_decode_hazardDetection_pc_i = decode_io_hazardDetection_pc_out; // @[Core.scala 81:49]
  assign fetch_io_decode_hazardDetection_inst_i = decode_io_hazardDetection_inst_out; // @[Core.scala 82:49]
  assign fetch_io_decode_hazardDetection_current_pc_i = decode_io_hazardDetection_current_pc_out; // @[Core.scala 83:49]
  assign fetch_io_decode_hazardDetection_pc_forward_i = decode_io_hazardDetection_pc_forward; // @[Core.scala 84:49]
  assign fetch_io_decode_hazardDetection_inst_forward_i = decode_io_hazardDetection_inst_forward; // @[Core.scala 85:49]
  assign fetch_io_decode_mret_inst_i = decode_io_fetch_mret_inst_o; // @[Core.scala 73:49]
  assign fetch_io_core_stall_i = memory_stage_io_stall; // @[Core.scala 55:53]
  assign decode_clock = clock;
  assign decode_reset = reset;
  assign decode_io_IF_ID_inst = fetch_io_decode_if_id_inst_o; // @[Core.scala 93:49]
  assign decode_io_IF_ID_pc = fetch_io_decode_if_id_pc_o; // @[Core.scala 94:49]
  assign decode_io_IF_ID_pc4 = fetch_io_decode_if_id_pc4_o; // @[Core.scala 95:49]
  assign decode_io_MEM_WB_ctrl_regWr = MEM_WB_io_ctrl_RegWr_out; // @[Core.scala 96:49]
  assign decode_io_MEM_WB_ctrl_csrWen = MEM_WB_io_ctrl_CsrWen_out; // @[Core.scala 97:49]
  assign decode_io_MEM_WB_rd_sel = MEM_WB_io_rd_sel_out; // @[Core.scala 104:49]
  assign decode_io_ID_EX_ctrl_MemRd = ID_EX_io_ctrl_MemRd_out; // @[Core.scala 105:49]
  assign decode_io_ID_EX_ctrl_regWr = ID_EX_io_ctrl_RegWr_out; // @[Core.scala 126:49]
  assign decode_io_ID_EX_ctrl_csrWen = ID_EX_io_ctrl_CsrWen_out; // @[Core.scala 98:49]
  assign decode_io_EX_MEM_ctrl_csrWen = EX_MEM_io_ctrl_CsrWen_out; // @[Core.scala 99:49]
  assign decode_io_ID_EX_rd_sel = ID_EX_io_rd_sel_out; // @[Core.scala 106:49]
  assign decode_io_EX_MEM_rd_sel = EX_MEM_io_rd_sel_out; // @[Core.scala 107:49]
  assign decode_io_EX_MEM_ctrl_MemRd = EX_MEM_io_ctrl_MemRd_out; // @[Core.scala 108:49]
  assign decode_io_EX_MEM_ctrl_regWr = EX_MEM_io_ctrl_RegWr_out; // @[Core.scala 127:49]
  assign decode_io_MEM_WB_ctrl_MemRd = MEM_WB_io_ctrl_MemRd_out; // @[Core.scala 109:49]
  assign decode_io_alu_output = execute_io_alu_output; // @[Core.scala 114:49]
  assign decode_io_EX_MEM_alu_output = EX_MEM_io_alu_output; // @[Core.scala 115:49]
  assign decode_io_dmem_memOut = io_dmemRsp_bits_dataResponse; // @[Core.scala 117:92]
  assign decode_io_dccm_rvalid_i = io_dmemRsp_valid; // @[Core.scala 118:49]
  assign decode_io_writeback_write_data = writeback_io_write_data; // @[Core.scala 110:49]
  assign decode_io_MEM_WB_csr_rdata_i = MEM_WB_io_csr_data_out; // @[Core.scala 111:51]
  assign decode_io_EX_MEM_csr_rdata_i = EX_MEM_io_csr_data_o; // @[Core.scala 112:49]
  assign decode_io_ID_EX_csr_rdata_i = ID_EX_io_csr_data_o; // @[Core.scala 113:49]
  assign decode_io_fetch_csr_if_pc = fetch_io_csrRegFile_csr_if_pc_o; // @[Core.scala 122:49]
  assign decode_io_fetch_csr_save_if = fetch_io_csrRegFile_csr_save_if_o; // @[Core.scala 121:49]
  assign decode_io_fetch_exc_cause_i = fetch_io_csrRegFile_exc_cause_o; // @[Core.scala 120:49]
  assign decode_io_fetch_csr_save_cause_i = fetch_io_csrRegFile_csr_save_cause_o; // @[Core.scala 119:49]
  assign decode_io_execute_regwrite = ID_EX_io_ctrl_RegWr_out; // @[Core.scala 156:49]
  assign decode_io_mem_regwrite = EX_MEM_io_ctrl_RegWr_out; // @[Core.scala 157:49]
  assign decode_io_wb_regwrite = MEM_WB_io_ctrl_RegWr_out; // @[Core.scala 158:49]
  assign execute_io_EX_MEM_rd_sel = EX_MEM_io_rd_sel_out; // @[Core.scala 163:49]
  assign execute_io_MEM_WB_rd_sel = MEM_WB_io_rd_sel_out; // @[Core.scala 164:49]
  assign execute_io_ID_EX_rs1_sel = ID_EX_io_rs1_sel_out; // @[Core.scala 165:49]
  assign execute_io_ID_EX_rs2_sel = ID_EX_io_rs2_sel_out; // @[Core.scala 166:49]
  assign execute_io_EX_MEM_ctrl_RegWr = EX_MEM_io_ctrl_RegWr_out; // @[Core.scala 167:49]
  assign execute_io_EX_MEM_ctrl_csrWen = EX_MEM_io_ctrl_CsrWen_out; // @[Core.scala 168:49]
  assign execute_io_MEM_WB_ctrl_csrWen = MEM_WB_io_ctrl_CsrWen_out; // @[Core.scala 169:49]
  assign execute_io_MEM_WB_ctrl_RegWr = MEM_WB_io_ctrl_RegWr_out; // @[Core.scala 170:49]
  assign execute_io_ID_EX_ctrl_OpA_sel = ID_EX_io_ctrl_OpA_sel_out; // @[Core.scala 171:49]
  assign execute_io_ID_EX_ctrl_OpB_sel = ID_EX_io_ctrl_OpB_sel_out; // @[Core.scala 172:49]
  assign execute_io_ID_EX_pc4 = ID_EX_io_pc4_out; // @[Core.scala 173:49]
  assign execute_io_ID_EX_pc_out = ID_EX_io_pc_out; // @[Core.scala 162:49]
  assign execute_io_ID_EX_rs1 = ID_EX_io_rs1_out; // @[Core.scala 174:49]
  assign execute_io_ID_EX_rs2 = ID_EX_io_rs2_out; // @[Core.scala 175:49]
  assign execute_io_ID_EX_csr_data = ID_EX_io_csr_data_o; // @[Core.scala 192:49]
  assign execute_io_EX_MEM_alu_output = EX_MEM_io_alu_output; // @[Core.scala 176:49]
  assign execute_io_EX_MEM_csr_rdata = EX_MEM_io_csr_data_o; // @[Core.scala 177:49]
  assign execute_io_MEM_WB_csr_rdata = MEM_WB_io_csr_data_out; // @[Core.scala 178:49]
  assign execute_io_writeback_write_data = writeback_io_write_data; // @[Core.scala 179:49]
  assign execute_io_ID_EX_imm = ID_EX_io_imm_out; // @[Core.scala 180:49]
  assign execute_io_ID_EX_ctrl_AluOp = ID_EX_io_ctrl_AluOp_out; // @[Core.scala 181:49]
  assign execute_io_ID_EX_func7 = ID_EX_io_func7_out; // @[Core.scala 182:49]
  assign execute_io_ID_EX_inst_op = ID_EX_io_inst_op_out; // @[Core.scala 183:49]
  assign execute_io_ID_EX_func3 = ID_EX_io_func3_out; // @[Core.scala 184:49]
  assign execute_io_ID_EX_rd_sel = ID_EX_io_rd_sel_out; // @[Core.scala 185:49]
  assign execute_io_ID_EX_ctrl_MemWr = ID_EX_io_ctrl_MemWr_out; // @[Core.scala 186:49]
  assign execute_io_ID_EX_ctrl_MemRd = ID_EX_io_ctrl_MemRd_out; // @[Core.scala 187:49]
  assign execute_io_ID_EX_ctrl_RegWr = ID_EX_io_ctrl_RegWr_out; // @[Core.scala 188:49]
  assign execute_io_ID_EX_ctrl_CsrWen = ID_EX_io_ctrl_CsrWen_out; // @[Core.scala 189:49]
  assign execute_io_ID_EX_ctrl_MemToReg = ID_EX_io_ctrl_MemToReg_out; // @[Core.scala 190:49]
  assign memory_stage_io_EX_MEM_alu_output = EX_MEM_io_alu_output; // @[Core.scala 219:49]
  assign memory_stage_io_EX_MEM_rd_sel = EX_MEM_io_rd_sel_out; // @[Core.scala 220:49]
  assign memory_stage_io_EX_MEM_RegWr = EX_MEM_io_ctrl_RegWr_out; // @[Core.scala 221:49]
  assign memory_stage_io_EX_MEM_CsrWe = EX_MEM_io_ctrl_CsrWen_out; // @[Core.scala 222:49]
  assign memory_stage_io_EX_MEM_MemRd = EX_MEM_io_ctrl_MemRd_out; // @[Core.scala 223:49]
  assign memory_stage_io_EX_MEM_MemToReg = EX_MEM_io_ctrl_MemToReg_out; // @[Core.scala 224:49]
  assign memory_stage_io_EX_MEM_MemWr = EX_MEM_io_ctrl_MemWr_out; // @[Core.scala 225:49]
  assign memory_stage_io_EX_MEM_rs2 = EX_MEM_io_rs2_out; // @[Core.scala 226:49]
  assign memory_stage_io_func3 = EX_MEM_io_EX_MEM_func3_out; // @[Core.scala 227:49]
  assign memory_stage_io_EX_MEM_csr_data = EX_MEM_io_csr_data_o; // @[Core.scala 230:49]
  assign memory_stage_io_coreDccmReq_ready = io_dmemReq_ready; // @[Core.scala 232:14]
  assign memory_stage_io_coreDccmRsp_valid = io_dmemRsp_valid; // @[Core.scala 233:31]
  assign memory_stage_io_coreDccmRsp_bits_dataResponse = io_dmemRsp_bits_dataResponse; // @[Core.scala 233:31]
  assign writeback_io_MEM_WB_MemToReg = MEM_WB_io_ctrl_MemToReg_out; // @[Core.scala 261:49]
  assign writeback_io_MEM_WB_dataMem_data = MEM_WB_io_dmem_data_out; // @[Core.scala 265:49]
  assign writeback_io_MEM_WB_alu_output = MEM_WB_io_alu_output; // @[Core.scala 266:49]
endmodule
module Switch1toN(
  input         io_hostIn_valid,
  input         io_hostIn_bits_cyc,
  input         io_hostIn_bits_stb,
  input         io_hostIn_bits_we,
  input  [31:0] io_hostIn_bits_adr,
  input  [31:0] io_hostIn_bits_dat,
  input  [3:0]  io_hostIn_bits_sel,
  output        io_hostOut_bits_ack,
  output [31:0] io_hostOut_bits_dat,
  output        io_hostOut_bits_err,
  output        io_devOut_0_valid,
  output        io_devOut_0_bits_cyc,
  output        io_devOut_0_bits_stb,
  output        io_devOut_0_bits_we,
  output [31:0] io_devOut_0_bits_adr,
  output [31:0] io_devOut_0_bits_dat,
  output [3:0]  io_devOut_0_bits_sel,
  output        io_devOut_1_valid,
  output        io_devOut_1_bits_cyc,
  output        io_devOut_1_bits_stb,
  output        io_devOut_1_bits_we,
  output [31:0] io_devOut_1_bits_adr,
  output [31:0] io_devOut_1_bits_dat,
  output [3:0]  io_devOut_1_bits_sel,
  output        io_devOut_2_valid,
  output        io_devOut_2_bits_cyc,
  output        io_devOut_2_bits_stb,
  output        io_devOut_2_bits_we,
  output [31:0] io_devOut_2_bits_adr,
  output [31:0] io_devOut_2_bits_dat,
  output [3:0]  io_devOut_2_bits_sel,
  output        io_devOut_3_valid,
  output        io_devOut_3_bits_cyc,
  output        io_devOut_3_bits_stb,
  output        io_devOut_3_bits_we,
  output [31:0] io_devOut_3_bits_adr,
  output [31:0] io_devOut_3_bits_dat,
  output [3:0]  io_devOut_3_bits_sel,
  output        io_devOut_4_valid,
  output        io_devOut_4_bits_cyc,
  output        io_devOut_4_bits_stb,
  input         io_devIn_0_bits_ack,
  input  [31:0] io_devIn_0_bits_dat,
  input         io_devIn_0_bits_err,
  input         io_devIn_1_bits_ack,
  input  [31:0] io_devIn_1_bits_dat,
  input         io_devIn_1_bits_err,
  input         io_devIn_2_bits_ack,
  input  [31:0] io_devIn_2_bits_dat,
  input         io_devIn_2_bits_err,
  input         io_devIn_3_bits_ack,
  input  [31:0] io_devIn_3_bits_dat,
  input         io_devIn_3_bits_err,
  input  [31:0] io_devIn_4_bits_dat,
  input         io_devIn_4_bits_err,
  input  [2:0]  io_devSel
);
  wire  _io_devOut_0_valid_T = io_devSel == 3'h0; // @[Switch1toN.scala 33:57]
  wire  _io_devOut_1_valid_T = io_devSel == 3'h1; // @[Switch1toN.scala 33:57]
  wire  _io_devOut_2_valid_T = io_devSel == 3'h2; // @[Switch1toN.scala 33:57]
  wire  _io_devOut_3_valid_T = io_devSel == 3'h3; // @[Switch1toN.scala 33:57]
  wire  _GEN_0 = _io_devOut_0_valid_T ? io_devIn_0_bits_err : io_devIn_4_bits_err; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23 Switch1toN.scala 27:19]
  wire [31:0] _GEN_1 = _io_devOut_0_valid_T ? io_devIn_0_bits_dat : io_devIn_4_bits_dat; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23 Switch1toN.scala 27:19]
  wire  _GEN_2 = _io_devOut_0_valid_T & io_devIn_0_bits_ack; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23 Switch1toN.scala 27:19]
  wire  _GEN_4 = _io_devOut_1_valid_T ? io_devIn_1_bits_err : _GEN_0; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  wire [31:0] _GEN_5 = _io_devOut_1_valid_T ? io_devIn_1_bits_dat : _GEN_1; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  wire  _GEN_6 = _io_devOut_1_valid_T ? io_devIn_1_bits_ack : _GEN_2; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  wire  _GEN_8 = _io_devOut_2_valid_T ? io_devIn_2_bits_err : _GEN_4; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  wire [31:0] _GEN_9 = _io_devOut_2_valid_T ? io_devIn_2_bits_dat : _GEN_5; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  wire  _GEN_10 = _io_devOut_2_valid_T ? io_devIn_2_bits_ack : _GEN_6; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  assign io_hostOut_bits_ack = _io_devOut_3_valid_T ? io_devIn_3_bits_ack : _GEN_10; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  assign io_hostOut_bits_dat = _io_devOut_3_valid_T ? io_devIn_3_bits_dat : _GEN_9; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  assign io_hostOut_bits_err = _io_devOut_3_valid_T ? io_devIn_3_bits_err : _GEN_8; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  assign io_devOut_0_valid = io_hostIn_valid & io_devSel == 3'h0; // @[Switch1toN.scala 33:43]
  assign io_devOut_0_bits_cyc = io_hostIn_bits_cyc; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_stb = io_hostIn_bits_stb; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_we = io_hostIn_bits_we; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_adr = io_hostIn_bits_adr; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_dat = io_hostIn_bits_dat; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_sel = io_hostIn_bits_sel; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_valid = io_hostIn_valid & io_devSel == 3'h1; // @[Switch1toN.scala 33:43]
  assign io_devOut_1_bits_cyc = io_hostIn_bits_cyc; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_stb = io_hostIn_bits_stb; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_we = io_hostIn_bits_we; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_adr = io_hostIn_bits_adr; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_dat = io_hostIn_bits_dat; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_sel = io_hostIn_bits_sel; // @[Switch1toN.scala 31:33]
  assign io_devOut_2_valid = io_hostIn_valid & io_devSel == 3'h2; // @[Switch1toN.scala 33:43]
  assign io_devOut_2_bits_cyc = io_hostIn_bits_cyc; // @[Switch1toN.scala 31:33]
  assign io_devOut_2_bits_stb = io_hostIn_bits_stb; // @[Switch1toN.scala 31:33]
  assign io_devOut_2_bits_we = io_hostIn_bits_we; // @[Switch1toN.scala 31:33]
  assign io_devOut_2_bits_adr = io_hostIn_bits_adr; // @[Switch1toN.scala 31:33]
  assign io_devOut_2_bits_dat = io_hostIn_bits_dat; // @[Switch1toN.scala 31:33]
  assign io_devOut_2_bits_sel = io_hostIn_bits_sel; // @[Switch1toN.scala 31:33]
  assign io_devOut_3_valid = io_hostIn_valid & io_devSel == 3'h3; // @[Switch1toN.scala 33:43]
  assign io_devOut_3_bits_cyc = io_hostIn_bits_cyc; // @[Switch1toN.scala 31:33]
  assign io_devOut_3_bits_stb = io_hostIn_bits_stb; // @[Switch1toN.scala 31:33]
  assign io_devOut_3_bits_we = io_hostIn_bits_we; // @[Switch1toN.scala 31:33]
  assign io_devOut_3_bits_adr = io_hostIn_bits_adr; // @[Switch1toN.scala 31:33]
  assign io_devOut_3_bits_dat = io_hostIn_bits_dat; // @[Switch1toN.scala 31:33]
  assign io_devOut_3_bits_sel = io_hostIn_bits_sel; // @[Switch1toN.scala 31:33]
  assign io_devOut_4_valid = io_hostIn_valid & io_devSel == 3'h4; // @[Switch1toN.scala 23:41]
  assign io_devOut_4_bits_cyc = io_hostIn_bits_cyc; // @[Switch1toN.scala 31:33]
  assign io_devOut_4_bits_stb = io_hostIn_bits_stb; // @[Switch1toN.scala 31:33]
endmodule
module Top(
  input        clock,
  input        reset,
  output       io_spi_cs_n,
  output       io_spi_sclk,
  output       io_spi_mosi,
  input        io_spi_miso,
  input        io_cio_uart_rx_i,
  output       io_cio_uart_tx_o,
  output       io_cio_uart_intr_tx_o,
  output [3:0] io_gpio_o,
  output [3:0] io_gpio_en_o,
  input  [3:0] io_gpio_i
);
  wire  wb_imem_host_clock; // @[Top.scala 300:28]
  wire  wb_imem_host_reset; // @[Top.scala 300:28]
  wire  wb_imem_host_io_wbMasterTransmitter_ready; // @[Top.scala 300:28]
  wire  wb_imem_host_io_wbMasterTransmitter_valid; // @[Top.scala 300:28]
  wire  wb_imem_host_io_wbMasterTransmitter_bits_cyc; // @[Top.scala 300:28]
  wire  wb_imem_host_io_wbMasterTransmitter_bits_stb; // @[Top.scala 300:28]
  wire  wb_imem_host_io_wbMasterTransmitter_bits_we; // @[Top.scala 300:28]
  wire [31:0] wb_imem_host_io_wbMasterTransmitter_bits_adr; // @[Top.scala 300:28]
  wire [31:0] wb_imem_host_io_wbMasterTransmitter_bits_dat; // @[Top.scala 300:28]
  wire [3:0] wb_imem_host_io_wbMasterTransmitter_bits_sel; // @[Top.scala 300:28]
  wire  wb_imem_host_io_wbSlaveReceiver_ready; // @[Top.scala 300:28]
  wire  wb_imem_host_io_wbSlaveReceiver_bits_ack; // @[Top.scala 300:28]
  wire [31:0] wb_imem_host_io_wbSlaveReceiver_bits_dat; // @[Top.scala 300:28]
  wire  wb_imem_host_io_wbSlaveReceiver_bits_err; // @[Top.scala 300:28]
  wire  wb_imem_host_io_reqIn_ready; // @[Top.scala 300:28]
  wire  wb_imem_host_io_reqIn_valid; // @[Top.scala 300:28]
  wire [31:0] wb_imem_host_io_reqIn_bits_addrRequest; // @[Top.scala 300:28]
  wire [31:0] wb_imem_host_io_reqIn_bits_dataRequest; // @[Top.scala 300:28]
  wire [3:0] wb_imem_host_io_reqIn_bits_activeByteLane; // @[Top.scala 300:28]
  wire  wb_imem_host_io_reqIn_bits_isWrite; // @[Top.scala 300:28]
  wire  wb_imem_host_io_rspOut_valid; // @[Top.scala 300:28]
  wire [31:0] wb_imem_host_io_rspOut_bits_dataResponse; // @[Top.scala 300:28]
  wire  wb_imem_slave_io_wbSlaveTransmitter_ready; // @[Top.scala 301:29]
  wire  wb_imem_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 301:29]
  wire [31:0] wb_imem_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 301:29]
  wire  wb_imem_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 301:29]
  wire  wb_imem_slave_io_wbMasterReceiver_ready; // @[Top.scala 301:29]
  wire  wb_imem_slave_io_wbMasterReceiver_valid; // @[Top.scala 301:29]
  wire  wb_imem_slave_io_wbMasterReceiver_bits_cyc; // @[Top.scala 301:29]
  wire  wb_imem_slave_io_wbMasterReceiver_bits_stb; // @[Top.scala 301:29]
  wire  wb_imem_slave_io_wbMasterReceiver_bits_we; // @[Top.scala 301:29]
  wire [31:0] wb_imem_slave_io_wbMasterReceiver_bits_adr; // @[Top.scala 301:29]
  wire [31:0] wb_imem_slave_io_wbMasterReceiver_bits_dat; // @[Top.scala 301:29]
  wire [3:0] wb_imem_slave_io_wbMasterReceiver_bits_sel; // @[Top.scala 301:29]
  wire  wb_imem_slave_io_reqOut_valid; // @[Top.scala 301:29]
  wire [31:0] wb_imem_slave_io_reqOut_bits_addrRequest; // @[Top.scala 301:29]
  wire [31:0] wb_imem_slave_io_reqOut_bits_dataRequest; // @[Top.scala 301:29]
  wire [3:0] wb_imem_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 301:29]
  wire  wb_imem_slave_io_reqOut_bits_isWrite; // @[Top.scala 301:29]
  wire  wb_imem_slave_io_rspIn_valid; // @[Top.scala 301:29]
  wire [31:0] wb_imem_slave_io_rspIn_bits_dataResponse; // @[Top.scala 301:29]
  wire  wb_imem_slave_io_rspIn_bits_error; // @[Top.scala 301:29]
  wire  wb_dmem_host_clock; // @[Top.scala 302:28]
  wire  wb_dmem_host_reset; // @[Top.scala 302:28]
  wire  wb_dmem_host_io_wbMasterTransmitter_ready; // @[Top.scala 302:28]
  wire  wb_dmem_host_io_wbMasterTransmitter_valid; // @[Top.scala 302:28]
  wire  wb_dmem_host_io_wbMasterTransmitter_bits_cyc; // @[Top.scala 302:28]
  wire  wb_dmem_host_io_wbMasterTransmitter_bits_stb; // @[Top.scala 302:28]
  wire  wb_dmem_host_io_wbMasterTransmitter_bits_we; // @[Top.scala 302:28]
  wire [31:0] wb_dmem_host_io_wbMasterTransmitter_bits_adr; // @[Top.scala 302:28]
  wire [31:0] wb_dmem_host_io_wbMasterTransmitter_bits_dat; // @[Top.scala 302:28]
  wire [3:0] wb_dmem_host_io_wbMasterTransmitter_bits_sel; // @[Top.scala 302:28]
  wire  wb_dmem_host_io_wbSlaveReceiver_ready; // @[Top.scala 302:28]
  wire  wb_dmem_host_io_wbSlaveReceiver_bits_ack; // @[Top.scala 302:28]
  wire [31:0] wb_dmem_host_io_wbSlaveReceiver_bits_dat; // @[Top.scala 302:28]
  wire  wb_dmem_host_io_wbSlaveReceiver_bits_err; // @[Top.scala 302:28]
  wire  wb_dmem_host_io_reqIn_ready; // @[Top.scala 302:28]
  wire  wb_dmem_host_io_reqIn_valid; // @[Top.scala 302:28]
  wire [31:0] wb_dmem_host_io_reqIn_bits_addrRequest; // @[Top.scala 302:28]
  wire [31:0] wb_dmem_host_io_reqIn_bits_dataRequest; // @[Top.scala 302:28]
  wire [3:0] wb_dmem_host_io_reqIn_bits_activeByteLane; // @[Top.scala 302:28]
  wire  wb_dmem_host_io_reqIn_bits_isWrite; // @[Top.scala 302:28]
  wire  wb_dmem_host_io_rspOut_valid; // @[Top.scala 302:28]
  wire [31:0] wb_dmem_host_io_rspOut_bits_dataResponse; // @[Top.scala 302:28]
  wire  wb_dmem_slave_io_wbSlaveTransmitter_ready; // @[Top.scala 303:29]
  wire  wb_dmem_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 303:29]
  wire [31:0] wb_dmem_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 303:29]
  wire  wb_dmem_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 303:29]
  wire  wb_dmem_slave_io_wbMasterReceiver_ready; // @[Top.scala 303:29]
  wire  wb_dmem_slave_io_wbMasterReceiver_valid; // @[Top.scala 303:29]
  wire  wb_dmem_slave_io_wbMasterReceiver_bits_cyc; // @[Top.scala 303:29]
  wire  wb_dmem_slave_io_wbMasterReceiver_bits_stb; // @[Top.scala 303:29]
  wire  wb_dmem_slave_io_wbMasterReceiver_bits_we; // @[Top.scala 303:29]
  wire [31:0] wb_dmem_slave_io_wbMasterReceiver_bits_adr; // @[Top.scala 303:29]
  wire [31:0] wb_dmem_slave_io_wbMasterReceiver_bits_dat; // @[Top.scala 303:29]
  wire [3:0] wb_dmem_slave_io_wbMasterReceiver_bits_sel; // @[Top.scala 303:29]
  wire  wb_dmem_slave_io_reqOut_valid; // @[Top.scala 303:29]
  wire [31:0] wb_dmem_slave_io_reqOut_bits_addrRequest; // @[Top.scala 303:29]
  wire [31:0] wb_dmem_slave_io_reqOut_bits_dataRequest; // @[Top.scala 303:29]
  wire [3:0] wb_dmem_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 303:29]
  wire  wb_dmem_slave_io_reqOut_bits_isWrite; // @[Top.scala 303:29]
  wire  wb_dmem_slave_io_rspIn_valid; // @[Top.scala 303:29]
  wire [31:0] wb_dmem_slave_io_rspIn_bits_dataResponse; // @[Top.scala 303:29]
  wire  wb_dmem_slave_io_rspIn_bits_error; // @[Top.scala 303:29]
  wire  wb_spi_slave_io_wbSlaveTransmitter_ready; // @[Top.scala 304:28]
  wire  wb_spi_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 304:28]
  wire [31:0] wb_spi_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 304:28]
  wire  wb_spi_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 304:28]
  wire  wb_spi_slave_io_wbMasterReceiver_ready; // @[Top.scala 304:28]
  wire  wb_spi_slave_io_wbMasterReceiver_valid; // @[Top.scala 304:28]
  wire  wb_spi_slave_io_wbMasterReceiver_bits_cyc; // @[Top.scala 304:28]
  wire  wb_spi_slave_io_wbMasterReceiver_bits_stb; // @[Top.scala 304:28]
  wire  wb_spi_slave_io_wbMasterReceiver_bits_we; // @[Top.scala 304:28]
  wire [31:0] wb_spi_slave_io_wbMasterReceiver_bits_adr; // @[Top.scala 304:28]
  wire [31:0] wb_spi_slave_io_wbMasterReceiver_bits_dat; // @[Top.scala 304:28]
  wire [3:0] wb_spi_slave_io_wbMasterReceiver_bits_sel; // @[Top.scala 304:28]
  wire  wb_spi_slave_io_reqOut_valid; // @[Top.scala 304:28]
  wire [31:0] wb_spi_slave_io_reqOut_bits_addrRequest; // @[Top.scala 304:28]
  wire [31:0] wb_spi_slave_io_reqOut_bits_dataRequest; // @[Top.scala 304:28]
  wire [3:0] wb_spi_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 304:28]
  wire  wb_spi_slave_io_reqOut_bits_isWrite; // @[Top.scala 304:28]
  wire  wb_spi_slave_io_rspIn_valid; // @[Top.scala 304:28]
  wire [31:0] wb_spi_slave_io_rspIn_bits_dataResponse; // @[Top.scala 304:28]
  wire  wb_spi_slave_io_rspIn_bits_error; // @[Top.scala 304:28]
  wire  wb_uart_slave_io_wbSlaveTransmitter_ready; // @[Top.scala 305:29]
  wire  wb_uart_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 305:29]
  wire [31:0] wb_uart_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 305:29]
  wire  wb_uart_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 305:29]
  wire  wb_uart_slave_io_wbMasterReceiver_ready; // @[Top.scala 305:29]
  wire  wb_uart_slave_io_wbMasterReceiver_valid; // @[Top.scala 305:29]
  wire  wb_uart_slave_io_wbMasterReceiver_bits_cyc; // @[Top.scala 305:29]
  wire  wb_uart_slave_io_wbMasterReceiver_bits_stb; // @[Top.scala 305:29]
  wire  wb_uart_slave_io_wbMasterReceiver_bits_we; // @[Top.scala 305:29]
  wire [31:0] wb_uart_slave_io_wbMasterReceiver_bits_adr; // @[Top.scala 305:29]
  wire [31:0] wb_uart_slave_io_wbMasterReceiver_bits_dat; // @[Top.scala 305:29]
  wire [3:0] wb_uart_slave_io_wbMasterReceiver_bits_sel; // @[Top.scala 305:29]
  wire  wb_uart_slave_io_reqOut_valid; // @[Top.scala 305:29]
  wire [31:0] wb_uart_slave_io_reqOut_bits_addrRequest; // @[Top.scala 305:29]
  wire [31:0] wb_uart_slave_io_reqOut_bits_dataRequest; // @[Top.scala 305:29]
  wire [3:0] wb_uart_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 305:29]
  wire  wb_uart_slave_io_reqOut_bits_isWrite; // @[Top.scala 305:29]
  wire  wb_uart_slave_io_rspIn_valid; // @[Top.scala 305:29]
  wire [31:0] wb_uart_slave_io_rspIn_bits_dataResponse; // @[Top.scala 305:29]
  wire  wb_uart_slave_io_rspIn_bits_error; // @[Top.scala 305:29]
  wire  wb_gpio_slave_io_wbSlaveTransmitter_ready; // @[Top.scala 306:29]
  wire  wb_gpio_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 306:29]
  wire [31:0] wb_gpio_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 306:29]
  wire  wb_gpio_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 306:29]
  wire  wb_gpio_slave_io_wbMasterReceiver_ready; // @[Top.scala 306:29]
  wire  wb_gpio_slave_io_wbMasterReceiver_valid; // @[Top.scala 306:29]
  wire  wb_gpio_slave_io_wbMasterReceiver_bits_cyc; // @[Top.scala 306:29]
  wire  wb_gpio_slave_io_wbMasterReceiver_bits_stb; // @[Top.scala 306:29]
  wire  wb_gpio_slave_io_wbMasterReceiver_bits_we; // @[Top.scala 306:29]
  wire [31:0] wb_gpio_slave_io_wbMasterReceiver_bits_adr; // @[Top.scala 306:29]
  wire [31:0] wb_gpio_slave_io_wbMasterReceiver_bits_dat; // @[Top.scala 306:29]
  wire [3:0] wb_gpio_slave_io_wbMasterReceiver_bits_sel; // @[Top.scala 306:29]
  wire  wb_gpio_slave_io_reqOut_valid; // @[Top.scala 306:29]
  wire [31:0] wb_gpio_slave_io_reqOut_bits_addrRequest; // @[Top.scala 306:29]
  wire [31:0] wb_gpio_slave_io_reqOut_bits_dataRequest; // @[Top.scala 306:29]
  wire [3:0] wb_gpio_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 306:29]
  wire  wb_gpio_slave_io_reqOut_bits_isWrite; // @[Top.scala 306:29]
  wire  wb_gpio_slave_io_rspIn_valid; // @[Top.scala 306:29]
  wire [31:0] wb_gpio_slave_io_rspIn_bits_dataResponse; // @[Top.scala 306:29]
  wire  wb_gpio_slave_io_rspIn_bits_error; // @[Top.scala 306:29]
  wire  imem_clock; // @[Top.scala 307:20]
  wire  imem_reset; // @[Top.scala 307:20]
  wire  imem_io_req_ready; // @[Top.scala 307:20]
  wire  imem_io_req_valid; // @[Top.scala 307:20]
  wire [31:0] imem_io_req_bits_addrRequest; // @[Top.scala 307:20]
  wire [31:0] imem_io_req_bits_dataRequest; // @[Top.scala 307:20]
  wire  imem_io_req_bits_isWrite; // @[Top.scala 307:20]
  wire  imem_io_rsp_valid; // @[Top.scala 307:20]
  wire [31:0] imem_io_rsp_bits_dataResponse; // @[Top.scala 307:20]
  wire  imem_io_rsp_bits_error; // @[Top.scala 307:20]
  wire  dmem_clock; // @[Top.scala 308:20]
  wire  dmem_reset; // @[Top.scala 308:20]
  wire  dmem_io_req_ready; // @[Top.scala 308:20]
  wire  dmem_io_req_valid; // @[Top.scala 308:20]
  wire [31:0] dmem_io_req_bits_addrRequest; // @[Top.scala 308:20]
  wire [31:0] dmem_io_req_bits_dataRequest; // @[Top.scala 308:20]
  wire [3:0] dmem_io_req_bits_activeByteLane; // @[Top.scala 308:20]
  wire  dmem_io_req_bits_isWrite; // @[Top.scala 308:20]
  wire  dmem_io_rsp_valid; // @[Top.scala 308:20]
  wire [31:0] dmem_io_rsp_bits_dataResponse; // @[Top.scala 308:20]
  wire  gpio_clock; // @[Top.scala 309:20]
  wire  gpio_reset; // @[Top.scala 309:20]
  wire  gpio_io_req_valid; // @[Top.scala 309:20]
  wire [31:0] gpio_io_req_bits_addrRequest; // @[Top.scala 309:20]
  wire [31:0] gpio_io_req_bits_dataRequest; // @[Top.scala 309:20]
  wire [3:0] gpio_io_req_bits_activeByteLane; // @[Top.scala 309:20]
  wire  gpio_io_req_bits_isWrite; // @[Top.scala 309:20]
  wire  gpio_io_rsp_valid; // @[Top.scala 309:20]
  wire [31:0] gpio_io_rsp_bits_dataResponse; // @[Top.scala 309:20]
  wire  gpio_io_rsp_bits_error; // @[Top.scala 309:20]
  wire [31:0] gpio_io_cio_gpio_i; // @[Top.scala 309:20]
  wire [31:0] gpio_io_cio_gpio_o; // @[Top.scala 309:20]
  wire [31:0] gpio_io_cio_gpio_en_o; // @[Top.scala 309:20]
  wire  spi_clock; // @[Top.scala 311:19]
  wire  spi_reset; // @[Top.scala 311:19]
  wire  spi_io_req_valid; // @[Top.scala 311:19]
  wire [31:0] spi_io_req_bits_addrRequest; // @[Top.scala 311:19]
  wire [31:0] spi_io_req_bits_dataRequest; // @[Top.scala 311:19]
  wire [3:0] spi_io_req_bits_activeByteLane; // @[Top.scala 311:19]
  wire  spi_io_req_bits_isWrite; // @[Top.scala 311:19]
  wire  spi_io_rsp_valid; // @[Top.scala 311:19]
  wire [31:0] spi_io_rsp_bits_dataResponse; // @[Top.scala 311:19]
  wire  spi_io_rsp_bits_error; // @[Top.scala 311:19]
  wire  spi_io_cs_n; // @[Top.scala 311:19]
  wire  spi_io_sclk; // @[Top.scala 311:19]
  wire  spi_io_mosi; // @[Top.scala 311:19]
  wire  spi_io_miso; // @[Top.scala 311:19]
  wire  uart_clock; // @[Top.scala 312:20]
  wire  uart_reset; // @[Top.scala 312:20]
  wire  uart_io_request_ready; // @[Top.scala 312:20]
  wire  uart_io_request_valid; // @[Top.scala 312:20]
  wire [31:0] uart_io_request_bits_addrRequest; // @[Top.scala 312:20]
  wire [31:0] uart_io_request_bits_dataRequest; // @[Top.scala 312:20]
  wire  uart_io_request_bits_isWrite; // @[Top.scala 312:20]
  wire  uart_io_response_valid; // @[Top.scala 312:20]
  wire [31:0] uart_io_response_bits_dataResponse; // @[Top.scala 312:20]
  wire  uart_io_response_bits_error; // @[Top.scala 312:20]
  wire  uart_io_cio_uart_rx_i; // @[Top.scala 312:20]
  wire  uart_io_cio_uart_tx_o; // @[Top.scala 312:20]
  wire  uart_io_cio_uart_intr_tx_o; // @[Top.scala 312:20]
  wire  wbErr_clock; // @[Top.scala 314:21]
  wire  wbErr_reset; // @[Top.scala 314:21]
  wire [31:0] wbErr_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 314:21]
  wire  wbErr_io_wbSlaveTransmitter_bits_err; // @[Top.scala 314:21]
  wire  wbErr_io_wbMasterReceiver_valid; // @[Top.scala 314:21]
  wire  wbErr_io_wbMasterReceiver_bits_cyc; // @[Top.scala 314:21]
  wire  wbErr_io_wbMasterReceiver_bits_stb; // @[Top.scala 314:21]
  wire  core_clock; // @[Top.scala 315:20]
  wire  core_reset; // @[Top.scala 315:20]
  wire  core_io_dmemReq_ready; // @[Top.scala 315:20]
  wire  core_io_dmemReq_valid; // @[Top.scala 315:20]
  wire [31:0] core_io_dmemReq_bits_addrRequest; // @[Top.scala 315:20]
  wire [31:0] core_io_dmemReq_bits_dataRequest; // @[Top.scala 315:20]
  wire [3:0] core_io_dmemReq_bits_activeByteLane; // @[Top.scala 315:20]
  wire  core_io_dmemReq_bits_isWrite; // @[Top.scala 315:20]
  wire  core_io_dmemRsp_valid; // @[Top.scala 315:20]
  wire [31:0] core_io_dmemRsp_bits_dataResponse; // @[Top.scala 315:20]
  wire  core_io_imemReq_ready; // @[Top.scala 315:20]
  wire  core_io_imemReq_valid; // @[Top.scala 315:20]
  wire [31:0] core_io_imemReq_bits_addrRequest; // @[Top.scala 315:20]
  wire  core_io_imemRsp_valid; // @[Top.scala 315:20]
  wire [31:0] core_io_imemRsp_bits_dataResponse; // @[Top.scala 315:20]
  wire  switch_io_hostIn_valid; // @[Top.scala 326:22]
  wire  switch_io_hostIn_bits_cyc; // @[Top.scala 326:22]
  wire  switch_io_hostIn_bits_stb; // @[Top.scala 326:22]
  wire  switch_io_hostIn_bits_we; // @[Top.scala 326:22]
  wire [31:0] switch_io_hostIn_bits_adr; // @[Top.scala 326:22]
  wire [31:0] switch_io_hostIn_bits_dat; // @[Top.scala 326:22]
  wire [3:0] switch_io_hostIn_bits_sel; // @[Top.scala 326:22]
  wire  switch_io_hostOut_bits_ack; // @[Top.scala 326:22]
  wire [31:0] switch_io_hostOut_bits_dat; // @[Top.scala 326:22]
  wire  switch_io_hostOut_bits_err; // @[Top.scala 326:22]
  wire  switch_io_devOut_0_valid; // @[Top.scala 326:22]
  wire  switch_io_devOut_0_bits_cyc; // @[Top.scala 326:22]
  wire  switch_io_devOut_0_bits_stb; // @[Top.scala 326:22]
  wire  switch_io_devOut_0_bits_we; // @[Top.scala 326:22]
  wire [31:0] switch_io_devOut_0_bits_adr; // @[Top.scala 326:22]
  wire [31:0] switch_io_devOut_0_bits_dat; // @[Top.scala 326:22]
  wire [3:0] switch_io_devOut_0_bits_sel; // @[Top.scala 326:22]
  wire  switch_io_devOut_1_valid; // @[Top.scala 326:22]
  wire  switch_io_devOut_1_bits_cyc; // @[Top.scala 326:22]
  wire  switch_io_devOut_1_bits_stb; // @[Top.scala 326:22]
  wire  switch_io_devOut_1_bits_we; // @[Top.scala 326:22]
  wire [31:0] switch_io_devOut_1_bits_adr; // @[Top.scala 326:22]
  wire [31:0] switch_io_devOut_1_bits_dat; // @[Top.scala 326:22]
  wire [3:0] switch_io_devOut_1_bits_sel; // @[Top.scala 326:22]
  wire  switch_io_devOut_2_valid; // @[Top.scala 326:22]
  wire  switch_io_devOut_2_bits_cyc; // @[Top.scala 326:22]
  wire  switch_io_devOut_2_bits_stb; // @[Top.scala 326:22]
  wire  switch_io_devOut_2_bits_we; // @[Top.scala 326:22]
  wire [31:0] switch_io_devOut_2_bits_adr; // @[Top.scala 326:22]
  wire [31:0] switch_io_devOut_2_bits_dat; // @[Top.scala 326:22]
  wire [3:0] switch_io_devOut_2_bits_sel; // @[Top.scala 326:22]
  wire  switch_io_devOut_3_valid; // @[Top.scala 326:22]
  wire  switch_io_devOut_3_bits_cyc; // @[Top.scala 326:22]
  wire  switch_io_devOut_3_bits_stb; // @[Top.scala 326:22]
  wire  switch_io_devOut_3_bits_we; // @[Top.scala 326:22]
  wire [31:0] switch_io_devOut_3_bits_adr; // @[Top.scala 326:22]
  wire [31:0] switch_io_devOut_3_bits_dat; // @[Top.scala 326:22]
  wire [3:0] switch_io_devOut_3_bits_sel; // @[Top.scala 326:22]
  wire  switch_io_devOut_4_valid; // @[Top.scala 326:22]
  wire  switch_io_devOut_4_bits_cyc; // @[Top.scala 326:22]
  wire  switch_io_devOut_4_bits_stb; // @[Top.scala 326:22]
  wire  switch_io_devIn_0_bits_ack; // @[Top.scala 326:22]
  wire [31:0] switch_io_devIn_0_bits_dat; // @[Top.scala 326:22]
  wire  switch_io_devIn_0_bits_err; // @[Top.scala 326:22]
  wire  switch_io_devIn_1_bits_ack; // @[Top.scala 326:22]
  wire [31:0] switch_io_devIn_1_bits_dat; // @[Top.scala 326:22]
  wire  switch_io_devIn_1_bits_err; // @[Top.scala 326:22]
  wire  switch_io_devIn_2_bits_ack; // @[Top.scala 326:22]
  wire [31:0] switch_io_devIn_2_bits_dat; // @[Top.scala 326:22]
  wire  switch_io_devIn_2_bits_err; // @[Top.scala 326:22]
  wire  switch_io_devIn_3_bits_ack; // @[Top.scala 326:22]
  wire [31:0] switch_io_devIn_3_bits_dat; // @[Top.scala 326:22]
  wire  switch_io_devIn_3_bits_err; // @[Top.scala 326:22]
  wire [31:0] switch_io_devIn_4_bits_dat; // @[Top.scala 326:22]
  wire  switch_io_devIn_4_bits_err; // @[Top.scala 326:22]
  wire [2:0] switch_io_devSel; // @[Top.scala 326:22]
  wire [31:0] _switch_io_devSel_addr_hit_0_T_1 = 32'hfffff000 & wb_dmem_host_io_wbMasterTransmitter_bits_adr; // @[BusDecoder.scala 45:60]
  wire  switch_io_devSel_addr_hit_0 = _switch_io_devSel_addr_hit_0_T_1 == 32'h40001000; // @[BusDecoder.scala 45:68]
  wire [2:0] switch_io_devSel_id_0 = switch_io_devSel_addr_hit_0 ? 3'h1 : 3'h4; // @[BusDecoder.scala 46:19]
  wire  switch_io_devSel_addr_hit_1 = _switch_io_devSel_addr_hit_0_T_1 == 32'h40003000; // @[BusDecoder.scala 45:68]
  wire [2:0] switch_io_devSel_id_1 = switch_io_devSel_addr_hit_1 ? 3'h3 : 3'h4; // @[BusDecoder.scala 46:19]
  wire  switch_io_devSel_addr_hit_2 = _switch_io_devSel_addr_hit_0_T_1 == 32'h40002000; // @[BusDecoder.scala 45:68]
  wire [2:0] switch_io_devSel_id_2 = switch_io_devSel_addr_hit_2 ? 3'h2 : 3'h4; // @[BusDecoder.scala 46:19]
  wire  switch_io_devSel_addr_hit_3 = _switch_io_devSel_addr_hit_0_T_1 == 32'h40000000; // @[BusDecoder.scala 45:68]
  wire [2:0] switch_io_devSel_id_3 = switch_io_devSel_addr_hit_3 ? 3'h0 : 3'h4; // @[BusDecoder.scala 46:19]
  wire [2:0] _switch_io_devSel_T = switch_io_devSel_addr_hit_3 ? switch_io_devSel_id_3 : 3'h4; // @[Mux.scala 98:16]
  wire [2:0] _switch_io_devSel_T_1 = switch_io_devSel_addr_hit_2 ? switch_io_devSel_id_2 : _switch_io_devSel_T; // @[Mux.scala 98:16]
  wire [2:0] _switch_io_devSel_T_2 = switch_io_devSel_addr_hit_1 ? switch_io_devSel_id_1 : _switch_io_devSel_T_1; // @[Mux.scala 98:16]
  WishboneHost wb_imem_host ( // @[Top.scala 300:28]
    .clock(wb_imem_host_clock),
    .reset(wb_imem_host_reset),
    .io_wbMasterTransmitter_ready(wb_imem_host_io_wbMasterTransmitter_ready),
    .io_wbMasterTransmitter_valid(wb_imem_host_io_wbMasterTransmitter_valid),
    .io_wbMasterTransmitter_bits_cyc(wb_imem_host_io_wbMasterTransmitter_bits_cyc),
    .io_wbMasterTransmitter_bits_stb(wb_imem_host_io_wbMasterTransmitter_bits_stb),
    .io_wbMasterTransmitter_bits_we(wb_imem_host_io_wbMasterTransmitter_bits_we),
    .io_wbMasterTransmitter_bits_adr(wb_imem_host_io_wbMasterTransmitter_bits_adr),
    .io_wbMasterTransmitter_bits_dat(wb_imem_host_io_wbMasterTransmitter_bits_dat),
    .io_wbMasterTransmitter_bits_sel(wb_imem_host_io_wbMasterTransmitter_bits_sel),
    .io_wbSlaveReceiver_ready(wb_imem_host_io_wbSlaveReceiver_ready),
    .io_wbSlaveReceiver_bits_ack(wb_imem_host_io_wbSlaveReceiver_bits_ack),
    .io_wbSlaveReceiver_bits_dat(wb_imem_host_io_wbSlaveReceiver_bits_dat),
    .io_wbSlaveReceiver_bits_err(wb_imem_host_io_wbSlaveReceiver_bits_err),
    .io_reqIn_ready(wb_imem_host_io_reqIn_ready),
    .io_reqIn_valid(wb_imem_host_io_reqIn_valid),
    .io_reqIn_bits_addrRequest(wb_imem_host_io_reqIn_bits_addrRequest),
    .io_reqIn_bits_dataRequest(wb_imem_host_io_reqIn_bits_dataRequest),
    .io_reqIn_bits_activeByteLane(wb_imem_host_io_reqIn_bits_activeByteLane),
    .io_reqIn_bits_isWrite(wb_imem_host_io_reqIn_bits_isWrite),
    .io_rspOut_valid(wb_imem_host_io_rspOut_valid),
    .io_rspOut_bits_dataResponse(wb_imem_host_io_rspOut_bits_dataResponse)
  );
  WishboneDevice wb_imem_slave ( // @[Top.scala 301:29]
    .io_wbSlaveTransmitter_ready(wb_imem_slave_io_wbSlaveTransmitter_ready),
    .io_wbSlaveTransmitter_bits_ack(wb_imem_slave_io_wbSlaveTransmitter_bits_ack),
    .io_wbSlaveTransmitter_bits_dat(wb_imem_slave_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(wb_imem_slave_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_ready(wb_imem_slave_io_wbMasterReceiver_ready),
    .io_wbMasterReceiver_valid(wb_imem_slave_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(wb_imem_slave_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(wb_imem_slave_io_wbMasterReceiver_bits_stb),
    .io_wbMasterReceiver_bits_we(wb_imem_slave_io_wbMasterReceiver_bits_we),
    .io_wbMasterReceiver_bits_adr(wb_imem_slave_io_wbMasterReceiver_bits_adr),
    .io_wbMasterReceiver_bits_dat(wb_imem_slave_io_wbMasterReceiver_bits_dat),
    .io_wbMasterReceiver_bits_sel(wb_imem_slave_io_wbMasterReceiver_bits_sel),
    .io_reqOut_valid(wb_imem_slave_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(wb_imem_slave_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(wb_imem_slave_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(wb_imem_slave_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(wb_imem_slave_io_reqOut_bits_isWrite),
    .io_rspIn_valid(wb_imem_slave_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(wb_imem_slave_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(wb_imem_slave_io_rspIn_bits_error)
  );
  WishboneHost wb_dmem_host ( // @[Top.scala 302:28]
    .clock(wb_dmem_host_clock),
    .reset(wb_dmem_host_reset),
    .io_wbMasterTransmitter_ready(wb_dmem_host_io_wbMasterTransmitter_ready),
    .io_wbMasterTransmitter_valid(wb_dmem_host_io_wbMasterTransmitter_valid),
    .io_wbMasterTransmitter_bits_cyc(wb_dmem_host_io_wbMasterTransmitter_bits_cyc),
    .io_wbMasterTransmitter_bits_stb(wb_dmem_host_io_wbMasterTransmitter_bits_stb),
    .io_wbMasterTransmitter_bits_we(wb_dmem_host_io_wbMasterTransmitter_bits_we),
    .io_wbMasterTransmitter_bits_adr(wb_dmem_host_io_wbMasterTransmitter_bits_adr),
    .io_wbMasterTransmitter_bits_dat(wb_dmem_host_io_wbMasterTransmitter_bits_dat),
    .io_wbMasterTransmitter_bits_sel(wb_dmem_host_io_wbMasterTransmitter_bits_sel),
    .io_wbSlaveReceiver_ready(wb_dmem_host_io_wbSlaveReceiver_ready),
    .io_wbSlaveReceiver_bits_ack(wb_dmem_host_io_wbSlaveReceiver_bits_ack),
    .io_wbSlaveReceiver_bits_dat(wb_dmem_host_io_wbSlaveReceiver_bits_dat),
    .io_wbSlaveReceiver_bits_err(wb_dmem_host_io_wbSlaveReceiver_bits_err),
    .io_reqIn_ready(wb_dmem_host_io_reqIn_ready),
    .io_reqIn_valid(wb_dmem_host_io_reqIn_valid),
    .io_reqIn_bits_addrRequest(wb_dmem_host_io_reqIn_bits_addrRequest),
    .io_reqIn_bits_dataRequest(wb_dmem_host_io_reqIn_bits_dataRequest),
    .io_reqIn_bits_activeByteLane(wb_dmem_host_io_reqIn_bits_activeByteLane),
    .io_reqIn_bits_isWrite(wb_dmem_host_io_reqIn_bits_isWrite),
    .io_rspOut_valid(wb_dmem_host_io_rspOut_valid),
    .io_rspOut_bits_dataResponse(wb_dmem_host_io_rspOut_bits_dataResponse)
  );
  WishboneDevice wb_dmem_slave ( // @[Top.scala 303:29]
    .io_wbSlaveTransmitter_ready(wb_dmem_slave_io_wbSlaveTransmitter_ready),
    .io_wbSlaveTransmitter_bits_ack(wb_dmem_slave_io_wbSlaveTransmitter_bits_ack),
    .io_wbSlaveTransmitter_bits_dat(wb_dmem_slave_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(wb_dmem_slave_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_ready(wb_dmem_slave_io_wbMasterReceiver_ready),
    .io_wbMasterReceiver_valid(wb_dmem_slave_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(wb_dmem_slave_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(wb_dmem_slave_io_wbMasterReceiver_bits_stb),
    .io_wbMasterReceiver_bits_we(wb_dmem_slave_io_wbMasterReceiver_bits_we),
    .io_wbMasterReceiver_bits_adr(wb_dmem_slave_io_wbMasterReceiver_bits_adr),
    .io_wbMasterReceiver_bits_dat(wb_dmem_slave_io_wbMasterReceiver_bits_dat),
    .io_wbMasterReceiver_bits_sel(wb_dmem_slave_io_wbMasterReceiver_bits_sel),
    .io_reqOut_valid(wb_dmem_slave_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(wb_dmem_slave_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(wb_dmem_slave_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(wb_dmem_slave_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(wb_dmem_slave_io_reqOut_bits_isWrite),
    .io_rspIn_valid(wb_dmem_slave_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(wb_dmem_slave_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(wb_dmem_slave_io_rspIn_bits_error)
  );
  WishboneDevice wb_spi_slave ( // @[Top.scala 304:28]
    .io_wbSlaveTransmitter_ready(wb_spi_slave_io_wbSlaveTransmitter_ready),
    .io_wbSlaveTransmitter_bits_ack(wb_spi_slave_io_wbSlaveTransmitter_bits_ack),
    .io_wbSlaveTransmitter_bits_dat(wb_spi_slave_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(wb_spi_slave_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_ready(wb_spi_slave_io_wbMasterReceiver_ready),
    .io_wbMasterReceiver_valid(wb_spi_slave_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(wb_spi_slave_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(wb_spi_slave_io_wbMasterReceiver_bits_stb),
    .io_wbMasterReceiver_bits_we(wb_spi_slave_io_wbMasterReceiver_bits_we),
    .io_wbMasterReceiver_bits_adr(wb_spi_slave_io_wbMasterReceiver_bits_adr),
    .io_wbMasterReceiver_bits_dat(wb_spi_slave_io_wbMasterReceiver_bits_dat),
    .io_wbMasterReceiver_bits_sel(wb_spi_slave_io_wbMasterReceiver_bits_sel),
    .io_reqOut_valid(wb_spi_slave_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(wb_spi_slave_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(wb_spi_slave_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(wb_spi_slave_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(wb_spi_slave_io_reqOut_bits_isWrite),
    .io_rspIn_valid(wb_spi_slave_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(wb_spi_slave_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(wb_spi_slave_io_rspIn_bits_error)
  );
  WishboneDevice wb_uart_slave ( // @[Top.scala 305:29]
    .io_wbSlaveTransmitter_ready(wb_uart_slave_io_wbSlaveTransmitter_ready),
    .io_wbSlaveTransmitter_bits_ack(wb_uart_slave_io_wbSlaveTransmitter_bits_ack),
    .io_wbSlaveTransmitter_bits_dat(wb_uart_slave_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(wb_uart_slave_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_ready(wb_uart_slave_io_wbMasterReceiver_ready),
    .io_wbMasterReceiver_valid(wb_uart_slave_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(wb_uart_slave_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(wb_uart_slave_io_wbMasterReceiver_bits_stb),
    .io_wbMasterReceiver_bits_we(wb_uart_slave_io_wbMasterReceiver_bits_we),
    .io_wbMasterReceiver_bits_adr(wb_uart_slave_io_wbMasterReceiver_bits_adr),
    .io_wbMasterReceiver_bits_dat(wb_uart_slave_io_wbMasterReceiver_bits_dat),
    .io_wbMasterReceiver_bits_sel(wb_uart_slave_io_wbMasterReceiver_bits_sel),
    .io_reqOut_valid(wb_uart_slave_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(wb_uart_slave_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(wb_uart_slave_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(wb_uart_slave_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(wb_uart_slave_io_reqOut_bits_isWrite),
    .io_rspIn_valid(wb_uart_slave_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(wb_uart_slave_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(wb_uart_slave_io_rspIn_bits_error)
  );
  WishboneDevice wb_gpio_slave ( // @[Top.scala 306:29]
    .io_wbSlaveTransmitter_ready(wb_gpio_slave_io_wbSlaveTransmitter_ready),
    .io_wbSlaveTransmitter_bits_ack(wb_gpio_slave_io_wbSlaveTransmitter_bits_ack),
    .io_wbSlaveTransmitter_bits_dat(wb_gpio_slave_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(wb_gpio_slave_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_ready(wb_gpio_slave_io_wbMasterReceiver_ready),
    .io_wbMasterReceiver_valid(wb_gpio_slave_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(wb_gpio_slave_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(wb_gpio_slave_io_wbMasterReceiver_bits_stb),
    .io_wbMasterReceiver_bits_we(wb_gpio_slave_io_wbMasterReceiver_bits_we),
    .io_wbMasterReceiver_bits_adr(wb_gpio_slave_io_wbMasterReceiver_bits_adr),
    .io_wbMasterReceiver_bits_dat(wb_gpio_slave_io_wbMasterReceiver_bits_dat),
    .io_wbMasterReceiver_bits_sel(wb_gpio_slave_io_wbMasterReceiver_bits_sel),
    .io_reqOut_valid(wb_gpio_slave_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(wb_gpio_slave_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(wb_gpio_slave_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(wb_gpio_slave_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(wb_gpio_slave_io_reqOut_bits_isWrite),
    .io_rspIn_valid(wb_gpio_slave_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(wb_gpio_slave_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(wb_gpio_slave_io_rspIn_bits_error)
  );
  BlockRamWithoutMasking imem ( // @[Top.scala 307:20]
    .clock(imem_clock),
    .reset(imem_reset),
    .io_req_ready(imem_io_req_ready),
    .io_req_valid(imem_io_req_valid),
    .io_req_bits_addrRequest(imem_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(imem_io_req_bits_dataRequest),
    .io_req_bits_isWrite(imem_io_req_bits_isWrite),
    .io_rsp_valid(imem_io_rsp_valid),
    .io_rsp_bits_dataResponse(imem_io_rsp_bits_dataResponse),
    .io_rsp_bits_error(imem_io_rsp_bits_error)
  );
  BlockRamWithMasking dmem ( // @[Top.scala 308:20]
    .clock(dmem_clock),
    .reset(dmem_reset),
    .io_req_ready(dmem_io_req_ready),
    .io_req_valid(dmem_io_req_valid),
    .io_req_bits_addrRequest(dmem_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(dmem_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(dmem_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(dmem_io_req_bits_isWrite),
    .io_rsp_valid(dmem_io_rsp_valid),
    .io_rsp_bits_dataResponse(dmem_io_rsp_bits_dataResponse)
  );
  Gpio gpio ( // @[Top.scala 309:20]
    .clock(gpio_clock),
    .reset(gpio_reset),
    .io_req_valid(gpio_io_req_valid),
    .io_req_bits_addrRequest(gpio_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(gpio_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(gpio_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(gpio_io_req_bits_isWrite),
    .io_rsp_valid(gpio_io_rsp_valid),
    .io_rsp_bits_dataResponse(gpio_io_rsp_bits_dataResponse),
    .io_rsp_bits_error(gpio_io_rsp_bits_error),
    .io_cio_gpio_i(gpio_io_cio_gpio_i),
    .io_cio_gpio_o(gpio_io_cio_gpio_o),
    .io_cio_gpio_en_o(gpio_io_cio_gpio_en_o)
  );
  Spi spi ( // @[Top.scala 311:19]
    .clock(spi_clock),
    .reset(spi_reset),
    .io_req_valid(spi_io_req_valid),
    .io_req_bits_addrRequest(spi_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(spi_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(spi_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(spi_io_req_bits_isWrite),
    .io_rsp_valid(spi_io_rsp_valid),
    .io_rsp_bits_dataResponse(spi_io_rsp_bits_dataResponse),
    .io_rsp_bits_error(spi_io_rsp_bits_error),
    .io_cs_n(spi_io_cs_n),
    .io_sclk(spi_io_sclk),
    .io_mosi(spi_io_mosi),
    .io_miso(spi_io_miso)
  );
  uart uart ( // @[Top.scala 312:20]
    .clock(uart_clock),
    .reset(uart_reset),
    .io_request_ready(uart_io_request_ready),
    .io_request_valid(uart_io_request_valid),
    .io_request_bits_addrRequest(uart_io_request_bits_addrRequest),
    .io_request_bits_dataRequest(uart_io_request_bits_dataRequest),
    .io_request_bits_isWrite(uart_io_request_bits_isWrite),
    .io_response_valid(uart_io_response_valid),
    .io_response_bits_dataResponse(uart_io_response_bits_dataResponse),
    .io_response_bits_error(uart_io_response_bits_error),
    .io_cio_uart_rx_i(uart_io_cio_uart_rx_i),
    .io_cio_uart_tx_o(uart_io_cio_uart_tx_o),
    .io_cio_uart_intr_tx_o(uart_io_cio_uart_intr_tx_o)
  );
  WishboneErr wbErr ( // @[Top.scala 314:21]
    .clock(wbErr_clock),
    .reset(wbErr_reset),
    .io_wbSlaveTransmitter_bits_dat(wbErr_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(wbErr_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_valid(wbErr_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(wbErr_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(wbErr_io_wbMasterReceiver_bits_stb)
  );
  Core core ( // @[Top.scala 315:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_dmemReq_ready(core_io_dmemReq_ready),
    .io_dmemReq_valid(core_io_dmemReq_valid),
    .io_dmemReq_bits_addrRequest(core_io_dmemReq_bits_addrRequest),
    .io_dmemReq_bits_dataRequest(core_io_dmemReq_bits_dataRequest),
    .io_dmemReq_bits_activeByteLane(core_io_dmemReq_bits_activeByteLane),
    .io_dmemReq_bits_isWrite(core_io_dmemReq_bits_isWrite),
    .io_dmemRsp_valid(core_io_dmemRsp_valid),
    .io_dmemRsp_bits_dataResponse(core_io_dmemRsp_bits_dataResponse),
    .io_imemReq_ready(core_io_imemReq_ready),
    .io_imemReq_valid(core_io_imemReq_valid),
    .io_imemReq_bits_addrRequest(core_io_imemReq_bits_addrRequest),
    .io_imemRsp_valid(core_io_imemRsp_valid),
    .io_imemRsp_bits_dataResponse(core_io_imemRsp_bits_dataResponse)
  );
  Switch1toN switch ( // @[Top.scala 326:22]
    .io_hostIn_valid(switch_io_hostIn_valid),
    .io_hostIn_bits_cyc(switch_io_hostIn_bits_cyc),
    .io_hostIn_bits_stb(switch_io_hostIn_bits_stb),
    .io_hostIn_bits_we(switch_io_hostIn_bits_we),
    .io_hostIn_bits_adr(switch_io_hostIn_bits_adr),
    .io_hostIn_bits_dat(switch_io_hostIn_bits_dat),
    .io_hostIn_bits_sel(switch_io_hostIn_bits_sel),
    .io_hostOut_bits_ack(switch_io_hostOut_bits_ack),
    .io_hostOut_bits_dat(switch_io_hostOut_bits_dat),
    .io_hostOut_bits_err(switch_io_hostOut_bits_err),
    .io_devOut_0_valid(switch_io_devOut_0_valid),
    .io_devOut_0_bits_cyc(switch_io_devOut_0_bits_cyc),
    .io_devOut_0_bits_stb(switch_io_devOut_0_bits_stb),
    .io_devOut_0_bits_we(switch_io_devOut_0_bits_we),
    .io_devOut_0_bits_adr(switch_io_devOut_0_bits_adr),
    .io_devOut_0_bits_dat(switch_io_devOut_0_bits_dat),
    .io_devOut_0_bits_sel(switch_io_devOut_0_bits_sel),
    .io_devOut_1_valid(switch_io_devOut_1_valid),
    .io_devOut_1_bits_cyc(switch_io_devOut_1_bits_cyc),
    .io_devOut_1_bits_stb(switch_io_devOut_1_bits_stb),
    .io_devOut_1_bits_we(switch_io_devOut_1_bits_we),
    .io_devOut_1_bits_adr(switch_io_devOut_1_bits_adr),
    .io_devOut_1_bits_dat(switch_io_devOut_1_bits_dat),
    .io_devOut_1_bits_sel(switch_io_devOut_1_bits_sel),
    .io_devOut_2_valid(switch_io_devOut_2_valid),
    .io_devOut_2_bits_cyc(switch_io_devOut_2_bits_cyc),
    .io_devOut_2_bits_stb(switch_io_devOut_2_bits_stb),
    .io_devOut_2_bits_we(switch_io_devOut_2_bits_we),
    .io_devOut_2_bits_adr(switch_io_devOut_2_bits_adr),
    .io_devOut_2_bits_dat(switch_io_devOut_2_bits_dat),
    .io_devOut_2_bits_sel(switch_io_devOut_2_bits_sel),
    .io_devOut_3_valid(switch_io_devOut_3_valid),
    .io_devOut_3_bits_cyc(switch_io_devOut_3_bits_cyc),
    .io_devOut_3_bits_stb(switch_io_devOut_3_bits_stb),
    .io_devOut_3_bits_we(switch_io_devOut_3_bits_we),
    .io_devOut_3_bits_adr(switch_io_devOut_3_bits_adr),
    .io_devOut_3_bits_dat(switch_io_devOut_3_bits_dat),
    .io_devOut_3_bits_sel(switch_io_devOut_3_bits_sel),
    .io_devOut_4_valid(switch_io_devOut_4_valid),
    .io_devOut_4_bits_cyc(switch_io_devOut_4_bits_cyc),
    .io_devOut_4_bits_stb(switch_io_devOut_4_bits_stb),
    .io_devIn_0_bits_ack(switch_io_devIn_0_bits_ack),
    .io_devIn_0_bits_dat(switch_io_devIn_0_bits_dat),
    .io_devIn_0_bits_err(switch_io_devIn_0_bits_err),
    .io_devIn_1_bits_ack(switch_io_devIn_1_bits_ack),
    .io_devIn_1_bits_dat(switch_io_devIn_1_bits_dat),
    .io_devIn_1_bits_err(switch_io_devIn_1_bits_err),
    .io_devIn_2_bits_ack(switch_io_devIn_2_bits_ack),
    .io_devIn_2_bits_dat(switch_io_devIn_2_bits_dat),
    .io_devIn_2_bits_err(switch_io_devIn_2_bits_err),
    .io_devIn_3_bits_ack(switch_io_devIn_3_bits_ack),
    .io_devIn_3_bits_dat(switch_io_devIn_3_bits_dat),
    .io_devIn_3_bits_err(switch_io_devIn_3_bits_err),
    .io_devIn_4_bits_dat(switch_io_devIn_4_bits_dat),
    .io_devIn_4_bits_err(switch_io_devIn_4_bits_err),
    .io_devSel(switch_io_devSel)
  );
  assign io_spi_cs_n = spi_io_cs_n; // @[Top.scala 369:15]
  assign io_spi_sclk = spi_io_sclk; // @[Top.scala 370:15]
  assign io_spi_mosi = spi_io_mosi; // @[Top.scala 371:15]
  assign io_cio_uart_tx_o = uart_io_cio_uart_tx_o; // @[Top.scala 365:20]
  assign io_cio_uart_intr_tx_o = uart_io_cio_uart_intr_tx_o; // @[Top.scala 366:25]
  assign io_gpio_o = gpio_io_cio_gpio_o[3:0]; // @[Top.scala 379:34]
  assign io_gpio_en_o = gpio_io_cio_gpio_en_o[3:0]; // @[Top.scala 380:40]
  assign wb_imem_host_clock = clock;
  assign wb_imem_host_reset = reset;
  assign wb_imem_host_io_wbMasterTransmitter_ready = wb_imem_slave_io_wbMasterReceiver_ready; // @[Top.scala 335:39]
  assign wb_imem_host_io_wbSlaveReceiver_bits_ack = wb_imem_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 336:39]
  assign wb_imem_host_io_wbSlaveReceiver_bits_dat = wb_imem_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 336:39]
  assign wb_imem_host_io_wbSlaveReceiver_bits_err = wb_imem_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 336:39]
  assign wb_imem_host_io_reqIn_valid = core_io_imemReq_valid; // @[Top.scala 329:25]
  assign wb_imem_host_io_reqIn_bits_addrRequest = core_io_imemReq_bits_addrRequest; // @[Top.scala 329:25]
  assign wb_imem_host_io_reqIn_bits_dataRequest = 32'h0; // @[Top.scala 329:25]
  assign wb_imem_host_io_reqIn_bits_activeByteLane = 4'hf; // @[Top.scala 329:25]
  assign wb_imem_host_io_reqIn_bits_isWrite = 1'h0; // @[Top.scala 329:25]
  assign wb_imem_slave_io_wbSlaveTransmitter_ready = wb_imem_host_io_wbSlaveReceiver_ready; // @[Top.scala 336:39]
  assign wb_imem_slave_io_wbMasterReceiver_valid = wb_imem_host_io_wbMasterTransmitter_valid; // @[Top.scala 335:39]
  assign wb_imem_slave_io_wbMasterReceiver_bits_cyc = wb_imem_host_io_wbMasterTransmitter_bits_cyc; // @[Top.scala 335:39]
  assign wb_imem_slave_io_wbMasterReceiver_bits_stb = wb_imem_host_io_wbMasterTransmitter_bits_stb; // @[Top.scala 335:39]
  assign wb_imem_slave_io_wbMasterReceiver_bits_we = wb_imem_host_io_wbMasterTransmitter_bits_we; // @[Top.scala 335:39]
  assign wb_imem_slave_io_wbMasterReceiver_bits_adr = wb_imem_host_io_wbMasterTransmitter_bits_adr; // @[Top.scala 335:39]
  assign wb_imem_slave_io_wbMasterReceiver_bits_dat = wb_imem_host_io_wbMasterTransmitter_bits_dat; // @[Top.scala 335:39]
  assign wb_imem_slave_io_wbMasterReceiver_bits_sel = wb_imem_host_io_wbMasterTransmitter_bits_sel; // @[Top.scala 335:39]
  assign wb_imem_slave_io_rspIn_valid = imem_io_rsp_valid; // @[Top.scala 332:26]
  assign wb_imem_slave_io_rspIn_bits_dataResponse = imem_io_rsp_bits_dataResponse; // @[Top.scala 332:26]
  assign wb_imem_slave_io_rspIn_bits_error = imem_io_rsp_bits_error; // @[Top.scala 332:26]
  assign wb_dmem_host_clock = clock;
  assign wb_dmem_host_reset = reset;
  assign wb_dmem_host_io_wbMasterTransmitter_ready = 1'h1; // @[Top.scala 346:20]
  assign wb_dmem_host_io_wbSlaveReceiver_bits_ack = switch_io_hostOut_bits_ack; // @[Top.scala 347:21]
  assign wb_dmem_host_io_wbSlaveReceiver_bits_dat = switch_io_hostOut_bits_dat; // @[Top.scala 347:21]
  assign wb_dmem_host_io_wbSlaveReceiver_bits_err = switch_io_hostOut_bits_err; // @[Top.scala 347:21]
  assign wb_dmem_host_io_reqIn_valid = core_io_dmemReq_valid; // @[Top.scala 339:25]
  assign wb_dmem_host_io_reqIn_bits_addrRequest = core_io_dmemReq_bits_addrRequest; // @[Top.scala 339:25]
  assign wb_dmem_host_io_reqIn_bits_dataRequest = core_io_dmemReq_bits_dataRequest; // @[Top.scala 339:25]
  assign wb_dmem_host_io_reqIn_bits_activeByteLane = core_io_dmemReq_bits_activeByteLane; // @[Top.scala 339:25]
  assign wb_dmem_host_io_reqIn_bits_isWrite = core_io_dmemReq_bits_isWrite; // @[Top.scala 339:25]
  assign wb_dmem_slave_io_wbSlaveTransmitter_ready = 1'h1; // @[Top.scala 349:53]
  assign wb_dmem_slave_io_wbMasterReceiver_valid = switch_io_devOut_0_valid; // @[Top.scala 350:54]
  assign wb_dmem_slave_io_wbMasterReceiver_bits_cyc = switch_io_devOut_0_bits_cyc; // @[Top.scala 350:54]
  assign wb_dmem_slave_io_wbMasterReceiver_bits_stb = switch_io_devOut_0_bits_stb; // @[Top.scala 350:54]
  assign wb_dmem_slave_io_wbMasterReceiver_bits_we = switch_io_devOut_0_bits_we; // @[Top.scala 350:54]
  assign wb_dmem_slave_io_wbMasterReceiver_bits_adr = switch_io_devOut_0_bits_adr; // @[Top.scala 350:54]
  assign wb_dmem_slave_io_wbMasterReceiver_bits_dat = switch_io_devOut_0_bits_dat; // @[Top.scala 350:54]
  assign wb_dmem_slave_io_wbMasterReceiver_bits_sel = switch_io_devOut_0_bits_sel; // @[Top.scala 350:54]
  assign wb_dmem_slave_io_rspIn_valid = dmem_io_rsp_valid; // @[Top.scala 342:26]
  assign wb_dmem_slave_io_rspIn_bits_dataResponse = dmem_io_rsp_bits_dataResponse; // @[Top.scala 342:26]
  assign wb_dmem_slave_io_rspIn_bits_error = 1'h0; // @[Top.scala 342:26]
  assign wb_spi_slave_io_wbSlaveTransmitter_ready = 1'h1; // @[Top.scala 349:53]
  assign wb_spi_slave_io_wbMasterReceiver_valid = switch_io_devOut_1_valid; // @[Top.scala 350:54]
  assign wb_spi_slave_io_wbMasterReceiver_bits_cyc = switch_io_devOut_1_bits_cyc; // @[Top.scala 350:54]
  assign wb_spi_slave_io_wbMasterReceiver_bits_stb = switch_io_devOut_1_bits_stb; // @[Top.scala 350:54]
  assign wb_spi_slave_io_wbMasterReceiver_bits_we = switch_io_devOut_1_bits_we; // @[Top.scala 350:54]
  assign wb_spi_slave_io_wbMasterReceiver_bits_adr = switch_io_devOut_1_bits_adr; // @[Top.scala 350:54]
  assign wb_spi_slave_io_wbMasterReceiver_bits_dat = switch_io_devOut_1_bits_dat; // @[Top.scala 350:54]
  assign wb_spi_slave_io_wbMasterReceiver_bits_sel = switch_io_devOut_1_bits_sel; // @[Top.scala 350:54]
  assign wb_spi_slave_io_rspIn_valid = spi_io_rsp_valid; // @[Top.scala 359:25]
  assign wb_spi_slave_io_rspIn_bits_dataResponse = spi_io_rsp_bits_dataResponse; // @[Top.scala 359:25]
  assign wb_spi_slave_io_rspIn_bits_error = spi_io_rsp_bits_error; // @[Top.scala 359:25]
  assign wb_uart_slave_io_wbSlaveTransmitter_ready = 1'h1; // @[Top.scala 349:53]
  assign wb_uart_slave_io_wbMasterReceiver_valid = switch_io_devOut_2_valid; // @[Top.scala 350:54]
  assign wb_uart_slave_io_wbMasterReceiver_bits_cyc = switch_io_devOut_2_bits_cyc; // @[Top.scala 350:54]
  assign wb_uart_slave_io_wbMasterReceiver_bits_stb = switch_io_devOut_2_bits_stb; // @[Top.scala 350:54]
  assign wb_uart_slave_io_wbMasterReceiver_bits_we = switch_io_devOut_2_bits_we; // @[Top.scala 350:54]
  assign wb_uart_slave_io_wbMasterReceiver_bits_adr = switch_io_devOut_2_bits_adr; // @[Top.scala 350:54]
  assign wb_uart_slave_io_wbMasterReceiver_bits_dat = switch_io_devOut_2_bits_dat; // @[Top.scala 350:54]
  assign wb_uart_slave_io_wbMasterReceiver_bits_sel = switch_io_devOut_2_bits_sel; // @[Top.scala 350:54]
  assign wb_uart_slave_io_rspIn_valid = uart_io_response_valid; // @[Top.scala 362:26]
  assign wb_uart_slave_io_rspIn_bits_dataResponse = uart_io_response_bits_dataResponse; // @[Top.scala 362:26]
  assign wb_uart_slave_io_rspIn_bits_error = uart_io_response_bits_error; // @[Top.scala 362:26]
  assign wb_gpio_slave_io_wbSlaveTransmitter_ready = 1'h1; // @[Top.scala 349:53]
  assign wb_gpio_slave_io_wbMasterReceiver_valid = switch_io_devOut_3_valid; // @[Top.scala 350:54]
  assign wb_gpio_slave_io_wbMasterReceiver_bits_cyc = switch_io_devOut_3_bits_cyc; // @[Top.scala 350:54]
  assign wb_gpio_slave_io_wbMasterReceiver_bits_stb = switch_io_devOut_3_bits_stb; // @[Top.scala 350:54]
  assign wb_gpio_slave_io_wbMasterReceiver_bits_we = switch_io_devOut_3_bits_we; // @[Top.scala 350:54]
  assign wb_gpio_slave_io_wbMasterReceiver_bits_adr = switch_io_devOut_3_bits_adr; // @[Top.scala 350:54]
  assign wb_gpio_slave_io_wbMasterReceiver_bits_dat = switch_io_devOut_3_bits_dat; // @[Top.scala 350:54]
  assign wb_gpio_slave_io_wbMasterReceiver_bits_sel = switch_io_devOut_3_bits_sel; // @[Top.scala 350:54]
  assign wb_gpio_slave_io_rspIn_valid = gpio_io_rsp_valid; // @[Top.scala 377:26]
  assign wb_gpio_slave_io_rspIn_bits_dataResponse = gpio_io_rsp_bits_dataResponse; // @[Top.scala 377:26]
  assign wb_gpio_slave_io_rspIn_bits_error = gpio_io_rsp_bits_error; // @[Top.scala 377:26]
  assign imem_clock = clock;
  assign imem_reset = reset;
  assign imem_io_req_valid = wb_imem_slave_io_reqOut_valid; // @[Top.scala 331:27]
  assign imem_io_req_bits_addrRequest = wb_imem_slave_io_reqOut_bits_addrRequest; // @[Top.scala 331:27]
  assign imem_io_req_bits_dataRequest = wb_imem_slave_io_reqOut_bits_dataRequest; // @[Top.scala 331:27]
  assign imem_io_req_bits_isWrite = wb_imem_slave_io_reqOut_bits_isWrite; // @[Top.scala 331:27]
  assign dmem_clock = clock;
  assign dmem_reset = reset;
  assign dmem_io_req_valid = wb_dmem_slave_io_reqOut_valid; // @[Top.scala 341:27]
  assign dmem_io_req_bits_addrRequest = wb_dmem_slave_io_reqOut_bits_addrRequest; // @[Top.scala 341:27]
  assign dmem_io_req_bits_dataRequest = wb_dmem_slave_io_reqOut_bits_dataRequest; // @[Top.scala 341:27]
  assign dmem_io_req_bits_activeByteLane = wb_dmem_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 341:27]
  assign dmem_io_req_bits_isWrite = wb_dmem_slave_io_reqOut_bits_isWrite; // @[Top.scala 341:27]
  assign gpio_clock = clock;
  assign gpio_reset = reset;
  assign gpio_io_req_valid = wb_gpio_slave_io_reqOut_valid; // @[Top.scala 376:27]
  assign gpio_io_req_bits_addrRequest = wb_gpio_slave_io_reqOut_bits_addrRequest; // @[Top.scala 376:27]
  assign gpio_io_req_bits_dataRequest = wb_gpio_slave_io_reqOut_bits_dataRequest; // @[Top.scala 376:27]
  assign gpio_io_req_bits_activeByteLane = wb_gpio_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 376:27]
  assign gpio_io_req_bits_isWrite = wb_gpio_slave_io_reqOut_bits_isWrite; // @[Top.scala 376:27]
  assign gpio_io_cio_gpio_i = {{28'd0}, io_gpio_i}; // @[Top.scala 381:22]
  assign spi_clock = clock;
  assign spi_reset = reset;
  assign spi_io_req_valid = wb_spi_slave_io_reqOut_valid; // @[Top.scala 358:26]
  assign spi_io_req_bits_addrRequest = wb_spi_slave_io_reqOut_bits_addrRequest; // @[Top.scala 358:26]
  assign spi_io_req_bits_dataRequest = wb_spi_slave_io_reqOut_bits_dataRequest; // @[Top.scala 358:26]
  assign spi_io_req_bits_activeByteLane = wb_spi_slave_io_reqOut_bits_activeByteLane; // @[Top.scala 358:26]
  assign spi_io_req_bits_isWrite = wb_spi_slave_io_reqOut_bits_isWrite; // @[Top.scala 358:26]
  assign spi_io_miso = io_spi_miso; // @[Top.scala 372:15]
  assign uart_clock = clock;
  assign uart_reset = reset;
  assign uart_io_request_valid = wb_uart_slave_io_reqOut_valid; // @[Top.scala 361:27]
  assign uart_io_request_bits_addrRequest = wb_uart_slave_io_reqOut_bits_addrRequest; // @[Top.scala 361:27]
  assign uart_io_request_bits_dataRequest = wb_uart_slave_io_reqOut_bits_dataRequest; // @[Top.scala 361:27]
  assign uart_io_request_bits_isWrite = wb_uart_slave_io_reqOut_bits_isWrite; // @[Top.scala 361:27]
  assign uart_io_cio_uart_rx_i = io_cio_uart_rx_i; // @[Top.scala 364:25]
  assign wbErr_clock = clock;
  assign wbErr_reset = reset;
  assign wbErr_io_wbMasterReceiver_valid = switch_io_devOut_4_valid; // @[Top.scala 353:34]
  assign wbErr_io_wbMasterReceiver_bits_cyc = switch_io_devOut_4_bits_cyc; // @[Top.scala 353:34]
  assign wbErr_io_wbMasterReceiver_bits_stb = switch_io_devOut_4_bits_stb; // @[Top.scala 353:34]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_dmemReq_ready = wb_dmem_host_io_reqIn_ready; // @[Top.scala 339:25]
  assign core_io_dmemRsp_valid = wb_dmem_host_io_rspOut_valid; // @[Top.scala 340:19]
  assign core_io_dmemRsp_bits_dataResponse = wb_dmem_host_io_rspOut_bits_dataResponse; // @[Top.scala 340:19]
  assign core_io_imemReq_ready = wb_imem_host_io_reqIn_ready; // @[Top.scala 329:25]
  assign core_io_imemRsp_valid = wb_imem_host_io_rspOut_valid; // @[Top.scala 330:19]
  assign core_io_imemRsp_bits_dataResponse = wb_imem_host_io_rspOut_bits_dataResponse; // @[Top.scala 330:19]
  assign switch_io_hostIn_valid = wb_dmem_host_io_wbMasterTransmitter_valid; // @[Top.scala 346:20]
  assign switch_io_hostIn_bits_cyc = wb_dmem_host_io_wbMasterTransmitter_bits_cyc; // @[Top.scala 346:20]
  assign switch_io_hostIn_bits_stb = wb_dmem_host_io_wbMasterTransmitter_bits_stb; // @[Top.scala 346:20]
  assign switch_io_hostIn_bits_we = wb_dmem_host_io_wbMasterTransmitter_bits_we; // @[Top.scala 346:20]
  assign switch_io_hostIn_bits_adr = wb_dmem_host_io_wbMasterTransmitter_bits_adr; // @[Top.scala 346:20]
  assign switch_io_hostIn_bits_dat = wb_dmem_host_io_wbMasterTransmitter_bits_dat; // @[Top.scala 346:20]
  assign switch_io_hostIn_bits_sel = wb_dmem_host_io_wbMasterTransmitter_bits_sel; // @[Top.scala 346:20]
  assign switch_io_devIn_0_bits_ack = wb_dmem_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 349:53]
  assign switch_io_devIn_0_bits_dat = wb_dmem_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 349:53]
  assign switch_io_devIn_0_bits_err = wb_dmem_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 349:53]
  assign switch_io_devIn_1_bits_ack = wb_spi_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 349:53]
  assign switch_io_devIn_1_bits_dat = wb_spi_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 349:53]
  assign switch_io_devIn_1_bits_err = wb_spi_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 349:53]
  assign switch_io_devIn_2_bits_ack = wb_uart_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 349:53]
  assign switch_io_devIn_2_bits_dat = wb_uart_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 349:53]
  assign switch_io_devIn_2_bits_err = wb_uart_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 349:53]
  assign switch_io_devIn_3_bits_ack = wb_gpio_slave_io_wbSlaveTransmitter_bits_ack; // @[Top.scala 349:53]
  assign switch_io_devIn_3_bits_dat = wb_gpio_slave_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 349:53]
  assign switch_io_devIn_3_bits_err = wb_gpio_slave_io_wbSlaveTransmitter_bits_err; // @[Top.scala 349:53]
  assign switch_io_devIn_4_bits_dat = wbErr_io_wbSlaveTransmitter_bits_dat; // @[Top.scala 352:33]
  assign switch_io_devIn_4_bits_err = wbErr_io_wbSlaveTransmitter_bits_err; // @[Top.scala 352:33]
  assign switch_io_devSel = switch_io_devSel_addr_hit_0 ? switch_io_devSel_id_0 : _switch_io_devSel_T_2; // @[Mux.scala 98:16]
endmodule
module Picofoxy(
  input   clock,
  input   reset,
  output  io_cio_spi_cs_n,
  output  io_cio_spi_sclk,
  output  io_cio_spi_mosi,
  input   io_cio_spi_miso,
  input   io_cio_uart_rx_i,
  output  io_cio_uart_tx_o,
  output  io_cio_uart_intr_tx_o,
  inout   io_gpio_io_0,
  inout   io_gpio_io_1,
  inout   io_gpio_io_2,
  inout   io_gpio_io_3
);
  wire  top_clock; // @[Top.scala 239:19]
  wire  top_reset; // @[Top.scala 239:19]
  wire  top_io_spi_cs_n; // @[Top.scala 239:19]
  wire  top_io_spi_sclk; // @[Top.scala 239:19]
  wire  top_io_spi_mosi; // @[Top.scala 239:19]
  wire  top_io_spi_miso; // @[Top.scala 239:19]
  wire  top_io_cio_uart_rx_i; // @[Top.scala 239:19]
  wire  top_io_cio_uart_tx_o; // @[Top.scala 239:19]
  wire  top_io_cio_uart_intr_tx_o; // @[Top.scala 239:19]
  wire [3:0] top_io_gpio_o; // @[Top.scala 239:19]
  wire [3:0] top_io_gpio_en_o; // @[Top.scala 239:19]
  wire [3:0] top_io_gpio_i; // @[Top.scala 239:19]
  wire  pll_clk_in1; // @[Top.scala 240:19]
  wire  pll_clk_out1; // @[Top.scala 240:19]
  wire  gpioPads_0_O; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_0_I; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_0_T; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_1_O; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_1_I; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_1_T; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_2_O; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_2_I; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_2_T; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_3_O; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_3_I; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_3_T; // @[TriStateBuffer.scala 21:81]
  wire  gpioEnableWires_0 = top_io_gpio_en_o[0]; // @[Top.scala 261:46]
  wire  gpioEnableWires_1 = top_io_gpio_en_o[1]; // @[Top.scala 261:46]
  wire  gpioEnableWires_2 = top_io_gpio_en_o[2]; // @[Top.scala 261:46]
  wire  gpioEnableWires_3 = top_io_gpio_en_o[3]; // @[Top.scala 261:46]
  wire  gpioInputWires_1 = gpioPads_1_O; // @[Top.scala 246:28 TriStateBuffer.scala 16:11]
  wire  gpioInputWires_0 = gpioPads_0_O; // @[Top.scala 246:28 TriStateBuffer.scala 16:11]
  wire [1:0] top_io_gpio_i_lo = {gpioInputWires_1,gpioInputWires_0}; // @[Top.scala 259:41]
  wire  gpioInputWires_3 = gpioPads_3_O; // @[Top.scala 246:28 TriStateBuffer.scala 16:11]
  wire  gpioInputWires_2 = gpioPads_2_O; // @[Top.scala 246:28 TriStateBuffer.scala 16:11]
  wire [1:0] top_io_gpio_i_hi = {gpioInputWires_3,gpioInputWires_2}; // @[Top.scala 259:41]
  Top top ( // @[Top.scala 239:19]
    .clock(top_clock),
    .reset(top_reset),
    .io_spi_cs_n(top_io_spi_cs_n),
    .io_spi_sclk(top_io_spi_sclk),
    .io_spi_mosi(top_io_spi_mosi),
    .io_spi_miso(top_io_spi_miso),
    .io_cio_uart_rx_i(top_io_cio_uart_rx_i),
    .io_cio_uart_tx_o(top_io_cio_uart_tx_o),
    .io_cio_uart_intr_tx_o(top_io_cio_uart_intr_tx_o),
    .io_gpio_o(top_io_gpio_o),
    .io_gpio_en_o(top_io_gpio_en_o),
    .io_gpio_i(top_io_gpio_i)
  );
  PLL_8MHz pll ( // @[Top.scala 240:19]
    .clk_in1(pll_clk_in1),
    .clk_out1(pll_clk_out1)
  );
  IOBUF gpioPads_0 ( // @[TriStateBuffer.scala 21:81]
    .O(gpioPads_0_O),
    .IO(io_gpio_io_0),
    .I(gpioPads_0_I),
    .T(gpioPads_0_T)
  );
  IOBUF gpioPads_1 ( // @[TriStateBuffer.scala 21:81]
    .O(gpioPads_1_O),
    .IO(io_gpio_io_1),
    .I(gpioPads_1_I),
    .T(gpioPads_1_T)
  );
  IOBUF gpioPads_2 ( // @[TriStateBuffer.scala 21:81]
    .O(gpioPads_2_O),
    .IO(io_gpio_io_2),
    .I(gpioPads_2_I),
    .T(gpioPads_2_T)
  );
  IOBUF gpioPads_3 ( // @[TriStateBuffer.scala 21:81]
    .O(gpioPads_3_O),
    .IO(io_gpio_io_3),
    .I(gpioPads_3_I),
    .T(gpioPads_3_T)
  );
  assign io_cio_spi_cs_n = top_io_spi_cs_n; // @[Top.scala 270:19]
  assign io_cio_spi_sclk = top_io_spi_sclk; // @[Top.scala 271:19]
  assign io_cio_spi_mosi = top_io_spi_mosi; // @[Top.scala 272:19]
  assign io_cio_uart_tx_o = top_io_cio_uart_tx_o; // @[Top.scala 266:20]
  assign io_cio_uart_intr_tx_o = top_io_cio_uart_intr_tx_o; // @[Top.scala 267:25]
  assign top_clock = pll_clk_out1; // @[Top.scala 243:13]
  assign top_reset = reset;
  assign top_io_spi_miso = io_cio_spi_miso; // @[Top.scala 273:19]
  assign top_io_cio_uart_rx_i = io_cio_uart_rx_i; // @[Top.scala 265:24]
  assign top_io_gpio_i = {top_io_gpio_i_hi,top_io_gpio_i_lo}; // @[Top.scala 259:41]
  assign pll_clk_in1 = clock; // @[Top.scala 242:18]
  assign gpioPads_0_I = top_io_gpio_o[0]; // @[Top.scala 260:43]
  assign gpioPads_0_T = ~gpioEnableWires_0; // @[TriStateBuffer.scala 15:10]
  assign gpioPads_1_I = top_io_gpio_o[1]; // @[Top.scala 260:43]
  assign gpioPads_1_T = ~gpioEnableWires_1; // @[TriStateBuffer.scala 15:10]
  assign gpioPads_2_I = top_io_gpio_o[2]; // @[Top.scala 260:43]
  assign gpioPads_2_T = ~gpioEnableWires_2; // @[TriStateBuffer.scala 15:10]
  assign gpioPads_3_I = top_io_gpio_o[3]; // @[Top.scala 260:43]
  assign gpioPads_3_T = ~gpioEnableWires_3; // @[TriStateBuffer.scala 15:10]
endmodule
