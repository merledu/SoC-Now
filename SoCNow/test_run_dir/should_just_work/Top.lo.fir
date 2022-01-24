circuit Top :
  module WishboneHost :
    input clock : Clock
    input reset : UInt<1>
    input io_wbMasterTransmitter_ready : UInt<1>
    output io_wbMasterTransmitter_valid : UInt<1>
    output io_wbMasterTransmitter_bits_cyc : UInt<1>
    output io_wbMasterTransmitter_bits_stb : UInt<1>
    output io_wbMasterTransmitter_bits_we : UInt<1>
    output io_wbMasterTransmitter_bits_adr : UInt<32>
    output io_wbMasterTransmitter_bits_dat : UInt<32>
    output io_wbMasterTransmitter_bits_sel : UInt<4>
    output io_wbSlaveReceiver_ready : UInt<1>
    input io_wbSlaveReceiver_valid : UInt<1>
    input io_wbSlaveReceiver_bits_ack : UInt<1>
    input io_wbSlaveReceiver_bits_dat : UInt<32>
    input io_wbSlaveReceiver_bits_err : UInt<1>
    output io_reqIn_ready : UInt<1>
    input io_reqIn_valid : UInt<1>
    input io_reqIn_bits_addrRequest : UInt<32>
    input io_reqIn_bits_dataRequest : UInt<32>
    input io_reqIn_bits_activeByteLane : UInt<4>
    input io_reqIn_bits_isWrite : UInt<1>
    input io_rspOut_ready : UInt<1>
    output io_rspOut_valid : UInt<1>
    output io_rspOut_bits_dataResponse : UInt<32>
    output io_rspOut_bits_error : UInt<1>
    output io_rspOut_bits_ackWrite : UInt<1>

    node _T = asUInt(reset) @[WishboneHost.scala 30:20]
    node _T_1 = eq(_T, UInt<1>("h1")) @[WishboneHost.scala 30:23]
    reg startWBTransaction : UInt<1>, clock with :
      reset => (UInt<1>("h0"), startWBTransaction) @[WishboneHost.scala 39:35]
    reg dataReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[WishboneHost.scala 41:24]
    reg respReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), respReg) @[WishboneHost.scala 42:24]
    reg errReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), errReg) @[WishboneHost.scala 43:23]
    reg ackReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ackReg) @[WishboneHost.scala 44:23]
    reg stbReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stbReg) @[WishboneHost.scala 46:23]
    reg cycReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), cycReg) @[WishboneHost.scala 47:23]
    reg weReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), weReg) @[WishboneHost.scala 48:22]
    reg datReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), datReg) @[WishboneHost.scala 49:23]
    reg adrReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), adrReg) @[WishboneHost.scala 50:23]
    reg selReg : UInt<4>, clock with :
      reset => (UInt<1>("h0"), selReg) @[WishboneHost.scala 51:23]
    reg stateReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stateReg) @[WishboneHost.scala 56:25]
    reg readyReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), readyReg) @[WishboneHost.scala 62:25]
    node _T_2 = and(io_reqIn_valid, io_wbMasterTransmitter_ready) @[WishboneHost.scala 18:37]
    node _GEN_0 = mux(_T_2, UInt<1>("h0"), readyReg) @[WishboneHost.scala 63:14 WishboneHost.scala 64:14 WishboneHost.scala 62:25]
    node _T_3 = eq(stateReg, UInt<1>("h1")) @[WishboneHost.scala 66:17]
    node _GEN_1 = mux(_T_3, UInt<1>("h1"), _GEN_0) @[WishboneHost.scala 66:33 WishboneHost.scala 67:14]
    node _T_4 = eq(io_reqIn_bits_isWrite, UInt<1>("h0")) @[WishboneHost.scala 77:32]
    node _T_5 = eq(readyReg, UInt<1>("h1")) @[WishboneHost.scala 77:56]
    node _T_6 = and(_T_4, _T_5) @[WishboneHost.scala 77:44]
    node _T_7 = and(_T_6, io_reqIn_valid) @[WishboneHost.scala 77:67]
    node _T_8 = eq(io_reqIn_bits_isWrite, UInt<1>("h1")) @[WishboneHost.scala 85:39]
    node _T_9 = eq(readyReg, UInt<1>("h1")) @[WishboneHost.scala 85:62]
    node _T_10 = and(_T_8, _T_9) @[WishboneHost.scala 85:50]
    node _T_11 = and(_T_10, io_reqIn_valid) @[WishboneHost.scala 85:73]
    node _GEN_2 = mux(_T_11, UInt<1>("h1"), startWBTransaction) @[WishboneHost.scala 85:92 WishboneHost.scala 86:26 WishboneHost.scala 39:35]
    node _GEN_3 = mux(_T_11, UInt<1>("h1"), stbReg) @[WishboneHost.scala 85:92 WishboneHost.scala 87:14 WishboneHost.scala 46:23]
    node _GEN_4 = mux(_T_11, UInt<1>("h1"), cycReg) @[WishboneHost.scala 85:92 WishboneHost.scala 88:14 WishboneHost.scala 47:23]
    node _GEN_5 = mux(_T_11, io_reqIn_bits_isWrite, weReg) @[WishboneHost.scala 85:92 WishboneHost.scala 89:13 WishboneHost.scala 48:22]
    node _GEN_6 = mux(_T_11, io_reqIn_bits_addrRequest, adrReg) @[WishboneHost.scala 85:92 WishboneHost.scala 90:14 WishboneHost.scala 50:23]
    node _GEN_7 = mux(_T_11, io_reqIn_bits_dataRequest, datReg) @[WishboneHost.scala 85:92 WishboneHost.scala 91:14 WishboneHost.scala 49:23]
    node _GEN_8 = mux(_T_11, io_reqIn_bits_activeByteLane, selReg) @[WishboneHost.scala 85:92 WishboneHost.scala 92:14 WishboneHost.scala 51:23]
    node _GEN_9 = mux(_T_7, UInt<1>("h1"), _GEN_2) @[WishboneHost.scala 77:86 WishboneHost.scala 78:26]
    node _GEN_10 = mux(_T_7, UInt<1>("h1"), _GEN_3) @[WishboneHost.scala 77:86 WishboneHost.scala 79:14]
    node _GEN_11 = mux(_T_7, UInt<1>("h1"), _GEN_4) @[WishboneHost.scala 77:86 WishboneHost.scala 80:14]
    node _GEN_12 = mux(_T_7, io_reqIn_bits_isWrite, _GEN_5) @[WishboneHost.scala 77:86 WishboneHost.scala 81:13]
    node _GEN_13 = mux(_T_7, io_reqIn_bits_addrRequest, _GEN_6) @[WishboneHost.scala 77:86 WishboneHost.scala 82:14]
    node _GEN_14 = mux(_T_7, UInt<1>("h0"), _GEN_7) @[WishboneHost.scala 77:86 WishboneHost.scala 83:14]
    node _GEN_15 = mux(_T_7, io_reqIn_bits_activeByteLane, _GEN_8) @[WishboneHost.scala 77:86 WishboneHost.scala 84:14]
    node _T_12 = eq(startWBTransaction, UInt<1>("h0")) @[WishboneHost.scala 102:10]
    node _GEN_16 = mux(_T_12, UInt<1>("h0"), selReg) @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 100:37]
    node _GEN_17 = mux(_T_12, UInt<1>("h0"), datReg) @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 99:37]
    node _GEN_18 = mux(_T_12, UInt<1>("h0"), adrReg) @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 98:37]
    node _GEN_19 = mux(_T_12, UInt<1>("h0"), weReg) @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 97:36]
    node _GEN_20 = mux(_T_12, UInt<1>("h0"), stbReg) @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 95:37]
    node _GEN_21 = mux(_T_12, UInt<1>("h0"), cycReg) @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 96:37]
    node _T_13 = eq(io_wbSlaveReceiver_bits_err, UInt<1>("h0")) @[WishboneHost.scala 106:41]
    node _T_14 = and(io_wbSlaveReceiver_bits_ack, _T_13) @[WishboneHost.scala 106:38]
    node _T_15 = eq(io_wbSlaveReceiver_bits_ack, UInt<1>("h0")) @[WishboneHost.scala 112:48]
    node _T_16 = and(io_wbSlaveReceiver_bits_err, _T_15) @[WishboneHost.scala 112:45]
    node _GEN_22 = mux(_T_16, io_wbSlaveReceiver_bits_dat, dataReg) @[WishboneHost.scala 112:78 WishboneHost.scala 113:15 WishboneHost.scala 41:24]
    node _GEN_23 = mux(_T_16, UInt<1>("h1"), respReg) @[WishboneHost.scala 112:78 WishboneHost.scala 114:15 WishboneHost.scala 42:24]
    node _GEN_24 = mux(_T_16, UInt<1>("h1"), errReg) @[WishboneHost.scala 112:78 WishboneHost.scala 115:14 WishboneHost.scala 43:23]
    node _GEN_25 = mux(_T_16, UInt<1>("h0"), _GEN_9) @[WishboneHost.scala 112:78 WishboneHost.scala 116:26]
    node _GEN_26 = mux(_T_14, io_wbSlaveReceiver_bits_dat, _GEN_22) @[WishboneHost.scala 106:71 WishboneHost.scala 107:15]
    node _GEN_27 = mux(_T_14, UInt<1>("h1"), _GEN_23) @[WishboneHost.scala 106:71 WishboneHost.scala 108:15]
    node _GEN_28 = mux(_T_14, UInt<1>("h0"), _GEN_24) @[WishboneHost.scala 106:71 WishboneHost.scala 109:14]
    node _GEN_29 = mux(_T_14, UInt<1>("h0"), _GEN_25) @[WishboneHost.scala 106:71 WishboneHost.scala 111:26]
    node _T_17 = eq(stateReg, UInt<1>("h0")) @[WishboneHost.scala 119:19]
    node _stateReg_T = or(io_wbSlaveReceiver_bits_ack, io_wbSlaveReceiver_bits_err) @[WishboneHost.scala 120:51]
    node _stateReg_T_1 = mux(_stateReg_T, UInt<1>("h1"), UInt<1>("h0")) @[WishboneHost.scala 120:22]
    node _T_18 = eq(stateReg, UInt<1>("h1")) @[WishboneHost.scala 121:26]
    node _GEN_30 = mux(_T_18, UInt<1>("h0"), _GEN_27) @[WishboneHost.scala 121:42 WishboneHost.scala 122:15]
    node _GEN_31 = mux(_T_18, UInt<1>("h0"), stateReg) @[WishboneHost.scala 121:42 WishboneHost.scala 123:16 WishboneHost.scala 56:25]
    node _GEN_32 = mux(_T_17, _stateReg_T_1, _GEN_31) @[WishboneHost.scala 119:29 WishboneHost.scala 120:16]
    node _GEN_33 = mux(_T_17, _GEN_27, _GEN_30) @[WishboneHost.scala 119:29]
    io_wbMasterTransmitter_valid <= io_wbMasterTransmitter_bits_stb @[WishboneHost.scala 23:32]
    io_wbMasterTransmitter_bits_cyc <= _GEN_21
    io_wbMasterTransmitter_bits_stb <= _GEN_20
    io_wbMasterTransmitter_bits_we <= _GEN_19
    io_wbMasterTransmitter_bits_adr <= _GEN_18
    io_wbMasterTransmitter_bits_dat <= _GEN_17
    io_wbMasterTransmitter_bits_sel <= _GEN_16
    io_wbSlaveReceiver_ready <= UInt<1>("h1") @[WishboneHost.scala 26:28]
    io_reqIn_ready <= readyReg @[WishboneHost.scala 76:20]
    io_rspOut_valid <= respReg @[WishboneHost.scala 128:21]
    io_rspOut_bits_dataResponse <= dataReg @[WishboneHost.scala 129:33]
    io_rspOut_bits_error <= errReg @[WishboneHost.scala 130:26]
    io_rspOut_bits_ackWrite <= ackReg @[WishboneHost.scala 131:29]
    startWBTransaction <= mux(reset, UInt<1>("h0"), _GEN_29) @[WishboneHost.scala 39:35 WishboneHost.scala 39:35]
    dataReg <= mux(reset, UInt<32>("h0"), _GEN_26) @[WishboneHost.scala 41:24 WishboneHost.scala 41:24]
    respReg <= mux(reset, UInt<1>("h0"), _GEN_33) @[WishboneHost.scala 42:24 WishboneHost.scala 42:24]
    errReg <= mux(reset, UInt<1>("h0"), _GEN_28) @[WishboneHost.scala 43:23 WishboneHost.scala 43:23]
    ackReg <= mux(reset, io_wbSlaveReceiver_bits_ack, ackReg) @[WishboneHost.scala 44:23 WishboneHost.scala 44:23 WishboneHost.scala 44:23]
    stbReg <= mux(reset, UInt<1>("h0"), _GEN_10) @[WishboneHost.scala 46:23 WishboneHost.scala 46:23]
    cycReg <= mux(reset, UInt<1>("h0"), _GEN_11) @[WishboneHost.scala 47:23 WishboneHost.scala 47:23]
    weReg <= mux(reset, UInt<1>("h0"), _GEN_12) @[WishboneHost.scala 48:22 WishboneHost.scala 48:22]
    datReg <= mux(reset, UInt<1>("h0"), _GEN_14) @[WishboneHost.scala 49:23 WishboneHost.scala 49:23]
    adrReg <= mux(reset, UInt<1>("h0"), _GEN_13) @[WishboneHost.scala 50:23 WishboneHost.scala 50:23]
    selReg <= mux(reset, UInt<1>("h0"), _GEN_15) @[WishboneHost.scala 51:23 WishboneHost.scala 51:23]
    stateReg <= mux(reset, UInt<1>("h0"), _GEN_32) @[WishboneHost.scala 56:25 WishboneHost.scala 56:25]
    readyReg <= mux(reset, UInt<1>("h1"), _GEN_1) @[WishboneHost.scala 62:25 WishboneHost.scala 62:25]

  module WishboneDevice :
    input clock : Clock
    input reset : UInt<1>
    input io_wbSlaveTransmitter_ready : UInt<1>
    output io_wbSlaveTransmitter_valid : UInt<1>
    output io_wbSlaveTransmitter_bits_ack : UInt<1>
    output io_wbSlaveTransmitter_bits_dat : UInt<32>
    output io_wbSlaveTransmitter_bits_err : UInt<1>
    output io_wbMasterReceiver_ready : UInt<1>
    input io_wbMasterReceiver_valid : UInt<1>
    input io_wbMasterReceiver_bits_cyc : UInt<1>
    input io_wbMasterReceiver_bits_stb : UInt<1>
    input io_wbMasterReceiver_bits_we : UInt<1>
    input io_wbMasterReceiver_bits_adr : UInt<32>
    input io_wbMasterReceiver_bits_dat : UInt<32>
    input io_wbMasterReceiver_bits_sel : UInt<4>
    input io_reqOut_ready : UInt<1>
    output io_reqOut_valid : UInt<1>
    output io_reqOut_bits_addrRequest : UInt<32>
    output io_reqOut_bits_dataRequest : UInt<32>
    output io_reqOut_bits_activeByteLane : UInt<4>
    output io_reqOut_bits_isWrite : UInt<1>
    output io_rspIn_ready : UInt<1>
    input io_rspIn_valid : UInt<1>
    input io_rspIn_bits_dataResponse : UInt<32>
    input io_rspIn_bits_error : UInt<1>
    input io_rspIn_bits_ackWrite : UInt<1>

    node _T = and(io_wbMasterReceiver_valid, io_wbMasterReceiver_bits_cyc) @[WishboneDevice.scala 16:48]
    node _T_1 = and(_T, io_wbMasterReceiver_bits_stb) @[WishboneDevice.scala 16:80]
    node _T_2 = eq(io_wbMasterReceiver_bits_we, UInt<1>("h0")) @[WishboneDevice.scala 26:10]
    node _T_3 = eq(io_rspIn_bits_error, UInt<1>("h0")) @[WishboneDevice.scala 36:30]
    node _T_4 = and(io_rspIn_valid, _T_3) @[WishboneDevice.scala 36:27]
    node _T_5 = and(io_rspIn_valid, io_rspIn_bits_error) @[WishboneDevice.scala 42:34]
    node _GEN_0 = mux(_T_5, UInt<1>("h1"), UInt<1>("h0")) @[WishboneDevice.scala 42:58 WishboneDevice.scala 43:37 WishboneDevice.scala 48:37]
    node _GEN_1 = mux(_T_5, UInt<1>("h0"), UInt<1>("h0")) @[WishboneDevice.scala 42:58 WishboneDevice.scala 44:13 WishboneDevice.scala 49:13]
    node _GEN_2 = validif(_T_5, io_rspIn_bits_dataResponse) @[WishboneDevice.scala 42:58 WishboneDevice.scala 46:40]
    node _GEN_3 = mux(_T_4, UInt<1>("h1"), _GEN_0) @[WishboneDevice.scala 36:52 WishboneDevice.scala 38:37]
    node _GEN_4 = mux(_T_4, UInt<1>("h1"), _GEN_1) @[WishboneDevice.scala 36:52 WishboneDevice.scala 39:13]
    node _GEN_5 = mux(_T_4, UInt<1>("h0"), _GEN_0) @[WishboneDevice.scala 36:52 WishboneDevice.scala 40:40]
    node _GEN_6 = mux(_T_4, io_rspIn_bits_dataResponse, _GEN_2) @[WishboneDevice.scala 36:52 WishboneDevice.scala 41:40]
    node _T_6 = eq(io_rspIn_bits_error, UInt<1>("h0")) @[WishboneDevice.scala 60:30]
    node _T_7 = and(io_rspIn_valid, _T_6) @[WishboneDevice.scala 60:27]
    node _T_8 = and(io_rspIn_valid, io_rspIn_bits_error) @[WishboneDevice.scala 65:34]
    node _GEN_7 = mux(_T_8, UInt<1>("h1"), UInt<1>("h0")) @[WishboneDevice.scala 65:58 WishboneDevice.scala 66:37 WishboneDevice.scala 71:37]
    node _GEN_8 = mux(_T_8, UInt<1>("h0"), UInt<1>("h0")) @[WishboneDevice.scala 65:58 WishboneDevice.scala 67:13 WishboneDevice.scala 72:13]
    node _GEN_9 = mux(_T_7, UInt<1>("h1"), _GEN_7) @[WishboneDevice.scala 60:52 WishboneDevice.scala 61:37]
    node _GEN_10 = mux(_T_7, UInt<1>("h1"), _GEN_8) @[WishboneDevice.scala 60:52 WishboneDevice.scala 62:13]
    node _GEN_11 = mux(_T_7, UInt<1>("h0"), _GEN_7) @[WishboneDevice.scala 60:52 WishboneDevice.scala 63:40]
    node _GEN_12 = mux(_T_2, UInt<1>("h1"), UInt<1>("h1")) @[WishboneDevice.scala 26:40 WishboneDevice.scala 31:23 WishboneDevice.scala 55:23]
    node _GEN_13 = mux(_T_2, io_wbMasterReceiver_bits_adr, io_wbMasterReceiver_bits_adr) @[WishboneDevice.scala 26:40 WishboneDevice.scala 32:34 WishboneDevice.scala 56:34]
    node _GEN_14 = validif(eq(_T_2, UInt<1>("h0")), io_wbMasterReceiver_bits_dat) @[WishboneDevice.scala 26:40 WishboneDevice.scala 57:34]
    node _GEN_15 = mux(_T_2, io_wbMasterReceiver_bits_sel, io_wbMasterReceiver_bits_sel) @[WishboneDevice.scala 26:40 WishboneDevice.scala 34:37 WishboneDevice.scala 58:37]
    node _GEN_16 = mux(_T_2, UInt<1>("h0"), io_wbMasterReceiver_bits_we) @[WishboneDevice.scala 26:40 WishboneDevice.scala 35:30 WishboneDevice.scala 59:30]
    node _GEN_17 = mux(_T_2, _GEN_3, _GEN_9) @[WishboneDevice.scala 26:40]
    node _GEN_18 = mux(_T_2, _GEN_4, _GEN_10) @[WishboneDevice.scala 26:40]
    node _GEN_19 = mux(_T_2, _GEN_5, _GEN_11) @[WishboneDevice.scala 26:40]
    node _GEN_20 = validif(_T_2, _GEN_6) @[WishboneDevice.scala 26:40]
    node _GEN_21 = mux(_T_1, _GEN_12, UInt<1>("h0")) @[WishboneDevice.scala 25:16 WishboneDevice.scala 81:21]
    node _GEN_22 = validif(_T_1, _GEN_13) @[WishboneDevice.scala 25:16]
    node _GEN_23 = validif(_T_1, _GEN_14) @[WishboneDevice.scala 25:16]
    node _GEN_24 = validif(_T_1, _GEN_15) @[WishboneDevice.scala 25:16]
    node _GEN_25 = validif(_T_1, _GEN_16) @[WishboneDevice.scala 25:16]
    node _GEN_26 = mux(_T_1, _GEN_17, UInt<1>("h0")) @[WishboneDevice.scala 25:16 WishboneDevice.scala 87:33]
    node _GEN_27 = mux(_T_1, _GEN_18, UInt<1>("h0")) @[WishboneDevice.scala 25:16 WishboneDevice.scala 88:9]
    node _GEN_28 = mux(_T_1, _GEN_19, UInt<1>("h0")) @[WishboneDevice.scala 25:16 WishboneDevice.scala 89:36]
    node _GEN_29 = validif(_T_1, _GEN_20) @[WishboneDevice.scala 25:16]
    node ack = _GEN_27
    io_wbSlaveTransmitter_valid <= _GEN_26
    io_wbSlaveTransmitter_bits_ack <= ack @[WishboneDevice.scala 93:34]
    io_wbSlaveTransmitter_bits_dat <= _GEN_29
    io_wbSlaveTransmitter_bits_err <= _GEN_28
    io_wbMasterReceiver_ready <= UInt<1>("h1") @[WishboneDevice.scala 19:29]
    io_reqOut_valid <= _GEN_21
    io_reqOut_bits_addrRequest <= _GEN_22
    io_reqOut_bits_dataRequest <= _GEN_23
    io_reqOut_bits_activeByteLane <= _GEN_24
    io_reqOut_bits_isWrite <= _GEN_25
    io_rspIn_ready <= UInt<1>("h1") @[WishboneDevice.scala 23:18]

  module BlockRamWithoutMasking :
    input clock : Clock
    input reset : UInt<1>
    output io_req_ready : UInt<1>
    input io_req_valid : UInt<1>
    input io_req_bits_addrRequest : UInt<32>
    input io_req_bits_dataRequest : UInt<32>
    input io_req_bits_activeByteLane : UInt<4>
    input io_req_bits_isWrite : UInt<1>
    input io_rsp_ready : UInt<1>
    output io_rsp_valid : UInt<1>
    output io_rsp_bits_dataResponse : UInt<32>
    output io_rsp_bits_error : UInt<1>
    output io_rsp_bits_ackWrite : UInt<1>

    mem mem : @[BlockRam.scala 87:24]
      data-type => UInt<32>
      depth => 1024
      read-latency => 1
      write-latency => 1
      reader => io_rsp_bits_dataResponse_MPORT
      writer => MPORT
      read-under-write => undefined
    reg validReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), validReg) @[BlockRam.scala 72:25]
    reg errReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), errReg) @[BlockRam.scala 73:23]
    reg ackReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ackReg) @[BlockRam.scala 74:23]
    node _addrMisaligned_T = and(io_req_ready, io_req_valid) @[Decoupled.scala 40:37]
    node _addrMisaligned_T_1 = bits(io_req_bits_addrRequest, 1, 0) @[BlockRam.scala 80:63]
    node _addrMisaligned_T_2 = orr(_addrMisaligned_T_1) @[BlockRam.scala 80:72]
    node _addrMisaligned_T_3 = mux(_addrMisaligned_T, _addrMisaligned_T_2, UInt<1>("h0")) @[BlockRam.scala 80:24]
    node _addrOutOfBounds_T = and(io_req_ready, io_req_valid) @[Decoupled.scala 40:37]
    node _addrOutOfBounds_T_1 = div(io_req_bits_addrRequest, UInt<3>("h4")) @[BlockRam.scala 81:65]
    node _addrOutOfBounds_T_2 = geq(_addrOutOfBounds_T_1, UInt<10>("h3ff")) @[BlockRam.scala 81:71]
    node _addrOutOfBounds_T_3 = mux(_addrOutOfBounds_T, _addrOutOfBounds_T_2, UInt<1>("h0")) @[BlockRam.scala 81:25]
    node addrMisaligned = _addrMisaligned_T_3 @[BlockRam.scala 67:28 BlockRam.scala 80:18]
    node addrOutOfBounds = _addrOutOfBounds_T_3 @[BlockRam.scala 68:29 BlockRam.scala 81:19]
    node _errReg_T = or(addrMisaligned, addrOutOfBounds) @[BlockRam.scala 83:28]
    node _T = and(io_req_ready, io_req_valid) @[Decoupled.scala 40:37]
    node _T_1 = eq(io_req_bits_isWrite, UInt<1>("h0")) @[BlockRam.scala 93:25]
    node _T_2 = and(_T, _T_1) @[BlockRam.scala 93:22]
    node _io_rsp_bits_dataResponse_T = div(io_req_bits_addrRequest, UInt<3>("h4")) @[BlockRam.scala 95:65]
    node _io_rsp_bits_dataResponse_T_1 = bits(_io_rsp_bits_dataResponse_T, 9, 0) @[BlockRam.scala 95:41]
    node _T_3 = and(io_req_ready, io_req_valid) @[Decoupled.scala 40:37]
    node _T_4 = and(_T_3, io_req_bits_isWrite) @[BlockRam.scala 97:29]
    node _T_5 = div(io_req_bits_addrRequest, UInt<3>("h4")) @[BlockRam.scala 99:38]
    node _T_6 = bits(_T_5, 9, 0)
    node _GEN_0 = validif(_T_4, _T_6) @[BlockRam.scala 97:53]
    node _GEN_1 = validif(_T_4, clock) @[BlockRam.scala 97:53]
    node _GEN_2 = mux(_T_4, UInt<1>("h1"), UInt<1>("h0")) @[BlockRam.scala 97:53 BlockRam.scala 87:24]
    node _GEN_3 = validif(_T_4, UInt<1>("h1")) @[BlockRam.scala 97:53]
    node _GEN_4 = validif(_T_4, io_req_bits_dataRequest) @[BlockRam.scala 97:53]
    node _GEN_5 = mux(_T_2, UInt<1>("h1"), UInt<1>("h0")) @[BlockRam.scala 93:47 BlockRam.scala 95:41 BlockRam.scala 87:24]
    node _GEN_6 = validif(_T_2, _io_rsp_bits_dataResponse_T_1) @[BlockRam.scala 93:47 BlockRam.scala 95:41]
    node _GEN_7 = validif(_T_2, clock) @[BlockRam.scala 93:47 BlockRam.scala 95:41]
    node _GEN_8 = validif(_T_2, mem.io_rsp_bits_dataResponse_MPORT.data) @[BlockRam.scala 93:47 BlockRam.scala 95:30]
    node _GEN_9 = mux(_T_2, UInt<1>("h1"), _GEN_2) @[BlockRam.scala 93:47 BlockRam.scala 96:14]
    node _GEN_10 = validif(eq(_T_2, UInt<1>("h0")), _GEN_0) @[BlockRam.scala 93:47]
    node _GEN_11 = validif(eq(_T_2, UInt<1>("h0")), _GEN_1) @[BlockRam.scala 93:47]
    node _GEN_12 = mux(_T_2, UInt<1>("h0"), _GEN_2) @[BlockRam.scala 93:47 BlockRam.scala 87:24]
    node _GEN_13 = validif(eq(_T_2, UInt<1>("h0")), _GEN_3) @[BlockRam.scala 93:47]
    node _GEN_14 = validif(eq(_T_2, UInt<1>("h0")), _GEN_4) @[BlockRam.scala 93:47]
    io_req_ready <= UInt<1>("h1") @[BlockRam.scala 78:16]
    io_rsp_valid <= validReg @[BlockRam.scala 75:16]
    io_rsp_bits_dataResponse <= _GEN_8
    io_rsp_bits_error <= errReg @[BlockRam.scala 76:21]
    io_rsp_bits_ackWrite <= ackReg @[BlockRam.scala 77:24]
    validReg <= mux(reset, UInt<1>("h0"), _GEN_9) @[BlockRam.scala 72:25 BlockRam.scala 72:25]
    errReg <= mux(reset, UInt<1>("h0"), _errReg_T) @[BlockRam.scala 73:23 BlockRam.scala 73:23 BlockRam.scala 83:10]
    ackReg <= mux(reset, UInt<1>("h0"), io_req_bits_isWrite) @[BlockRam.scala 74:23 BlockRam.scala 74:23 BlockRam.scala 85:10]
    mem.io_rsp_bits_dataResponse_MPORT.addr <= _GEN_6
    mem.io_rsp_bits_dataResponse_MPORT.en <= _GEN_5
    mem.io_rsp_bits_dataResponse_MPORT.clk <= _GEN_7
    mem.MPORT.addr <= _GEN_10
    mem.MPORT.en <= _GEN_12
    mem.MPORT.clk <= _GEN_11
    mem.MPORT.data <= _GEN_14
    mem.MPORT.mask <= _GEN_13

  module BlockRamWithMasking :
    input clock : Clock
    input reset : UInt<1>
    output io_req_ready : UInt<1>
    input io_req_valid : UInt<1>
    input io_req_bits_addrRequest : UInt<32>
    input io_req_bits_dataRequest : UInt<32>
    input io_req_bits_activeByteLane : UInt<4>
    input io_req_bits_isWrite : UInt<1>
    input io_rsp_ready : UInt<1>
    output io_rsp_valid : UInt<1>
    output io_rsp_bits_dataResponse : UInt<32>
    output io_rsp_bits_error : UInt<1>
    output io_rsp_bits_ackWrite : UInt<1>

    mem mem_0 : @[BlockRam.scala 148:24]
      data-type => UInt<8>
      depth => 1024
      read-latency => 1
      write-latency => 1
      reader => MPORT
      writer => MPORT_1
      read-under-write => undefined
    mem mem_1 : @[BlockRam.scala 148:24]
      data-type => UInt<8>
      depth => 1024
      read-latency => 1
      write-latency => 1
      reader => MPORT
      writer => MPORT_1
      read-under-write => undefined
    mem mem_2 : @[BlockRam.scala 148:24]
      data-type => UInt<8>
      depth => 1024
      read-latency => 1
      write-latency => 1
      reader => MPORT
      writer => MPORT_1
      read-under-write => undefined
    mem mem_3 : @[BlockRam.scala 148:24]
      data-type => UInt<8>
      depth => 1024
      read-latency => 1
      write-latency => 1
      reader => MPORT
      writer => MPORT_1
      read-under-write => undefined
    node _wdata_0_T = bits(io_req_bits_dataRequest, 7, 0) @[BlockRam.scala 126:38]
    node _wdata_1_T = bits(io_req_bits_dataRequest, 15, 8) @[BlockRam.scala 127:38]
    node _wdata_2_T = bits(io_req_bits_dataRequest, 23, 16) @[BlockRam.scala 128:38]
    node _wdata_3_T = bits(io_req_bits_dataRequest, 31, 24) @[BlockRam.scala 129:38]
    node byteLane_0 = bits(io_req_bits_activeByteLane, 0, 0) @[BlockRam.scala 133:52]
    node byteLane_1 = bits(io_req_bits_activeByteLane, 1, 1) @[BlockRam.scala 133:52]
    node byteLane_2 = bits(io_req_bits_activeByteLane, 2, 2) @[BlockRam.scala 133:52]
    node byteLane_3 = bits(io_req_bits_activeByteLane, 3, 3) @[BlockRam.scala 133:52]
    reg validReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), validReg) @[BlockRam.scala 141:25]
    reg ackReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ackReg) @[BlockRam.scala 142:23]
    node _T = and(io_req_ready, io_req_valid) @[Decoupled.scala 40:37]
    node _T_1 = eq(io_req_bits_isWrite, UInt<1>("h0")) @[BlockRam.scala 150:25]
    node _T_2 = and(_T, _T_1) @[BlockRam.scala 150:22]
    node _T_3 = div(io_req_bits_addrRequest, UInt<3>("h4")) @[BlockRam.scala 152:46]
    node _T_4 = bits(_T_3, 9, 0) @[BlockRam.scala 152:22]
    node _T_5 = and(io_req_ready, io_req_valid) @[Decoupled.scala 40:37]
    node _T_6 = and(_T_5, io_req_bits_isWrite) @[BlockRam.scala 155:29]
    node _T_7 = div(io_req_bits_addrRequest, UInt<3>("h4")) @[BlockRam.scala 157:38]
    node _T_8 = bits(_T_7, 9, 0)
    node mask_0 = byteLane_0 @[BlockRam.scala 122:18 BlockRam.scala 135:7]
    node wdata_0 = _wdata_0_T @[BlockRam.scala 118:19 BlockRam.scala 126:12]
    node _GEN_0 = validif(mask_0, wdata_0)
    node _GEN_1 = mux(mask_0, UInt<1>("h1"), UInt<1>("h0"))
    node mask_1 = byteLane_1 @[BlockRam.scala 122:18 BlockRam.scala 135:7]
    node wdata_1 = _wdata_1_T @[BlockRam.scala 118:19 BlockRam.scala 127:12]
    node _GEN_2 = validif(mask_1, wdata_1)
    node _GEN_3 = mux(mask_1, UInt<1>("h1"), UInt<1>("h0"))
    node mask_2 = byteLane_2 @[BlockRam.scala 122:18 BlockRam.scala 135:7]
    node wdata_2 = _wdata_2_T @[BlockRam.scala 118:19 BlockRam.scala 128:12]
    node _GEN_4 = validif(mask_2, wdata_2)
    node _GEN_5 = mux(mask_2, UInt<1>("h1"), UInt<1>("h0"))
    node mask_3 = byteLane_3 @[BlockRam.scala 122:18 BlockRam.scala 135:7]
    node wdata_3 = _wdata_3_T @[BlockRam.scala 118:19 BlockRam.scala 129:12]
    node _GEN_6 = validif(mask_3, wdata_3)
    node _GEN_7 = mux(mask_3, UInt<1>("h1"), UInt<1>("h0"))
    node _GEN_8 = validif(_T_6, _T_8) @[BlockRam.scala 155:53]
    node _GEN_9 = validif(_T_6, clock) @[BlockRam.scala 155:53]
    node _GEN_10 = mux(_T_6, UInt<1>("h1"), UInt<1>("h0")) @[BlockRam.scala 155:53 BlockRam.scala 148:24]
    node _GEN_11 = validif(_T_6, _GEN_1) @[BlockRam.scala 155:53]
    node _GEN_12 = validif(_T_6, _GEN_3) @[BlockRam.scala 155:53]
    node _GEN_13 = validif(_T_6, _GEN_5) @[BlockRam.scala 155:53]
    node _GEN_14 = validif(_T_6, _GEN_7) @[BlockRam.scala 155:53]
    node _GEN_15 = validif(_T_6, _GEN_0) @[BlockRam.scala 155:53]
    node _GEN_16 = validif(_T_6, _GEN_2) @[BlockRam.scala 155:53]
    node _GEN_17 = validif(_T_6, _GEN_4) @[BlockRam.scala 155:53]
    node _GEN_18 = validif(_T_6, _GEN_6) @[BlockRam.scala 155:53]
    node _GEN_19 = mux(_T_6, UInt<1>("h0"), UInt<1>("h0")) @[BlockRam.scala 155:53 BlockRam.scala 159:12 BlockRam.scala 163:12]
    node _GEN_20 = mux(_T_2, UInt<1>("h1"), UInt<1>("h0")) @[BlockRam.scala 150:47 BlockRam.scala 152:22 BlockRam.scala 148:24]
    node _GEN_21 = validif(_T_2, _T_4) @[BlockRam.scala 150:47 BlockRam.scala 152:22]
    node _GEN_22 = validif(_T_2, clock) @[BlockRam.scala 150:47 BlockRam.scala 152:22]
    node _GEN_23 = validif(_T_2, mem_0.MPORT.data) @[BlockRam.scala 150:47 BlockRam.scala 152:11]
    node _GEN_24 = validif(_T_2, mem_1.MPORT.data) @[BlockRam.scala 150:47 BlockRam.scala 152:11]
    node _GEN_25 = validif(_T_2, mem_2.MPORT.data) @[BlockRam.scala 150:47 BlockRam.scala 152:11]
    node _GEN_26 = validif(_T_2, mem_3.MPORT.data) @[BlockRam.scala 150:47 BlockRam.scala 152:11]
    node _GEN_27 = mux(_T_2, UInt<1>("h1"), _GEN_10) @[BlockRam.scala 150:47 BlockRam.scala 153:14]
    node _GEN_28 = mux(_T_2, UInt<1>("h1"), _GEN_19) @[BlockRam.scala 150:47 BlockRam.scala 154:12]
    node _GEN_29 = validif(eq(_T_2, UInt<1>("h0")), _GEN_8) @[BlockRam.scala 150:47]
    node _GEN_30 = validif(eq(_T_2, UInt<1>("h0")), _GEN_9) @[BlockRam.scala 150:47]
    node _GEN_31 = mux(_T_2, UInt<1>("h0"), _GEN_10) @[BlockRam.scala 150:47 BlockRam.scala 148:24]
    node _GEN_32 = validif(eq(_T_2, UInt<1>("h0")), _GEN_11) @[BlockRam.scala 150:47]
    node _GEN_33 = validif(eq(_T_2, UInt<1>("h0")), _GEN_12) @[BlockRam.scala 150:47]
    node _GEN_34 = validif(eq(_T_2, UInt<1>("h0")), _GEN_13) @[BlockRam.scala 150:47]
    node _GEN_35 = validif(eq(_T_2, UInt<1>("h0")), _GEN_14) @[BlockRam.scala 150:47]
    node _GEN_36 = validif(eq(_T_2, UInt<1>("h0")), _GEN_15) @[BlockRam.scala 150:47]
    node _GEN_37 = validif(eq(_T_2, UInt<1>("h0")), _GEN_16) @[BlockRam.scala 150:47]
    node _GEN_38 = validif(eq(_T_2, UInt<1>("h0")), _GEN_17) @[BlockRam.scala 150:47]
    node _GEN_39 = validif(eq(_T_2, UInt<1>("h0")), _GEN_18) @[BlockRam.scala 150:47]
    node _T_9 = eq(mask_0, UInt<1>("h1")) @[BlockRam.scala 170:11]
    node rdata_0 = _GEN_23 @[BlockRam.scala 120:19]
    node _T_10 = mux(_T_9, rdata_0, UInt<1>("h0")) @[BlockRam.scala 170:8]
    node _T_11 = eq(mask_1, UInt<1>("h1")) @[BlockRam.scala 170:11]
    node rdata_1 = _GEN_24 @[BlockRam.scala 120:19]
    node _T_12 = mux(_T_11, rdata_1, UInt<1>("h0")) @[BlockRam.scala 170:8]
    node _T_13 = eq(mask_2, UInt<1>("h1")) @[BlockRam.scala 170:11]
    node rdata_2 = _GEN_25 @[BlockRam.scala 120:19]
    node _T_14 = mux(_T_13, rdata_2, UInt<1>("h0")) @[BlockRam.scala 170:8]
    node _T_15 = eq(mask_3, UInt<1>("h1")) @[BlockRam.scala 170:11]
    node rdata_3 = _GEN_26 @[BlockRam.scala 120:19]
    node _T_16 = mux(_T_15, rdata_3, UInt<1>("h0")) @[BlockRam.scala 170:8]
    node data_1 = _T_12 @[BlockRam.scala 124:18 BlockRam.scala 169:8]
    node data_0 = _T_10 @[BlockRam.scala 124:18 BlockRam.scala 169:8]
    node io_rsp_bits_dataResponse_lo = cat(data_1, data_0) @[Cat.scala 30:58]
    node data_3 = _T_16 @[BlockRam.scala 124:18 BlockRam.scala 169:8]
    node data_2 = _T_14 @[BlockRam.scala 124:18 BlockRam.scala 169:8]
    node io_rsp_bits_dataResponse_hi = cat(data_3, data_2) @[Cat.scala 30:58]
    node _io_rsp_bits_dataResponse_T = cat(io_rsp_bits_dataResponse_hi, io_rsp_bits_dataResponse_lo) @[Cat.scala 30:58]
    io_req_ready <= UInt<1>("h1") @[BlockRam.scala 146:16]
    io_rsp_valid <= validReg @[BlockRam.scala 143:16]
    io_rsp_bits_dataResponse <= _io_rsp_bits_dataResponse_T @[BlockRam.scala 173:28]
    io_rsp_bits_error <= UInt<1>("h0") @[BlockRam.scala 145:21]
    io_rsp_bits_ackWrite <= ackReg @[BlockRam.scala 144:24]
    validReg <= mux(reset, UInt<1>("h0"), _GEN_27) @[BlockRam.scala 141:25 BlockRam.scala 141:25]
    ackReg <= mux(reset, UInt<1>("h0"), _GEN_28) @[BlockRam.scala 142:23 BlockRam.scala 142:23]
    mem_0.MPORT.addr <= _GEN_21
    mem_1.MPORT.addr <= _GEN_21
    mem_2.MPORT.addr <= _GEN_21
    mem_3.MPORT.addr <= _GEN_21
    mem_0.MPORT.en <= _GEN_20
    mem_1.MPORT.en <= _GEN_20
    mem_2.MPORT.en <= _GEN_20
    mem_3.MPORT.en <= _GEN_20
    mem_0.MPORT.clk <= _GEN_22
    mem_1.MPORT.clk <= _GEN_22
    mem_2.MPORT.clk <= _GEN_22
    mem_3.MPORT.clk <= _GEN_22
    mem_0.MPORT_1.addr <= _GEN_29
    mem_1.MPORT_1.addr <= _GEN_29
    mem_2.MPORT_1.addr <= _GEN_29
    mem_3.MPORT_1.addr <= _GEN_29
    mem_0.MPORT_1.en <= _GEN_31
    mem_1.MPORT_1.en <= _GEN_31
    mem_2.MPORT_1.en <= _GEN_31
    mem_3.MPORT_1.en <= _GEN_31
    mem_0.MPORT_1.clk <= _GEN_30
    mem_1.MPORT_1.clk <= _GEN_30
    mem_2.MPORT_1.clk <= _GEN_30
    mem_3.MPORT_1.clk <= _GEN_30
    mem_0.MPORT_1.data <= _GEN_36
    mem_1.MPORT_1.data <= _GEN_37
    mem_2.MPORT_1.data <= _GEN_38
    mem_3.MPORT_1.data <= _GEN_39
    mem_0.MPORT_1.mask <= _GEN_32
    mem_1.MPORT_1.mask <= _GEN_33
    mem_2.MPORT_1.mask <= _GEN_34
    mem_3.MPORT_1.mask <= _GEN_35

  module SubReg :
    input clock : Clock
    input reset : UInt<1>
    input io_we : UInt<1>
    input io_wd : UInt<32>
    input io_de : UInt<1>
    input io_d : UInt<32>
    output io_qe : UInt<1>
    output io_q : UInt<32>
    output io_qs : UInt<32>

    reg qe_reg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), qe_reg) @[SubReg.scala 23:23]
    reg q_reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), q_reg) @[SubReg.scala 24:22]
    node _wr_en_T = or(io_we, io_de) @[SubReg.scala 33:20]
    node _wr_data_T = mux(io_de, io_d, q_reg) @[SubReg.scala 34:19]
    node _wr_data_T_1 = not(io_wd) @[SubReg.scala 34:53]
    node _wr_data_T_2 = mux(UInt<1>("h1"), UInt<32>("hffffffff"), UInt<32>("h0")) @[Bitwise.scala 72:12]
    node _wr_data_T_3 = mux(io_we, _wr_data_T_1, _wr_data_T_2) @[SubReg.scala 34:45]
    node _wr_data_T_4 = and(_wr_data_T, _wr_data_T_3) @[SubReg.scala 34:40]
    node wr_en = _wr_en_T @[SubReg.scala 20:19 SubReg.scala 33:11]
    node wr_data = _wr_data_T_4 @[SubReg.scala 21:21 SubReg.scala 34:13]
    node _GEN_0 = mux(wr_en, wr_data, q_reg) @[SubReg.scala 47:15 SubReg.scala 48:11 SubReg.scala 24:22]
    io_qe <= qe_reg @[SubReg.scala 53:9]
    io_q <= q_reg @[SubReg.scala 52:8]
    io_qs <= q_reg @[SubReg.scala 51:9]
    qe_reg <= mux(reset, UInt<1>("h0"), io_we) @[SubReg.scala 23:23 SubReg.scala 23:23 SubReg.scala 46:10]
    q_reg <= mux(reset, UInt<32>("h0"), _GEN_0) @[SubReg.scala 24:22 SubReg.scala 24:22]

  module SubReg_1 :
    input clock : Clock
    input reset : UInt<1>
    input io_we : UInt<1>
    input io_wd : UInt<32>
    input io_de : UInt<1>
    input io_d : UInt<32>
    output io_qe : UInt<1>
    output io_q : UInt<32>
    output io_qs : UInt<32>

    reg qe_reg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), qe_reg) @[SubReg.scala 23:23]
    reg q_reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), q_reg) @[SubReg.scala 24:22]
    node _wr_en_T = or(io_we, io_de) @[SubReg.scala 27:20]
    node _wr_data_T = mux(io_we, io_wd, io_d) @[SubReg.scala 28:19]
    node wr_en = _wr_en_T @[SubReg.scala 20:19 SubReg.scala 27:11]
    node wr_data = _wr_data_T @[SubReg.scala 21:21 SubReg.scala 28:13]
    node _GEN_0 = mux(wr_en, wr_data, q_reg) @[SubReg.scala 47:15 SubReg.scala 48:11 SubReg.scala 24:22]
    io_qe <= qe_reg @[SubReg.scala 53:9]
    io_q <= q_reg @[SubReg.scala 52:8]
    io_qs <= q_reg @[SubReg.scala 51:9]
    qe_reg <= mux(reset, UInt<1>("h0"), io_we) @[SubReg.scala 23:23 SubReg.scala 23:23 SubReg.scala 46:10]
    q_reg <= mux(reset, UInt<32>("h0"), _GEN_0) @[SubReg.scala 24:22 SubReg.scala 24:22]

  module SubRegExt :
    input clock : Clock
    input reset : UInt<1>
    input io_re : UInt<1>
    input io_we : UInt<1>
    input io_wd : UInt<32>
    input io_d : UInt<32>
    output io_qe : UInt<1>
    output io_qre : UInt<1>
    output io_q : UInt<32>
    output io_qs : UInt<32>

    io_qe <= io_we @[SubRegExt.scala 25:9]
    io_qre <= io_re @[SubRegExt.scala 26:10]
    io_q <= io_wd @[SubRegExt.scala 24:8]
    io_qs <= io_d @[SubRegExt.scala 23:9]

  module SubReg_2 :
    input clock : Clock
    input reset : UInt<1>
    input io_we : UInt<1>
    input io_wd : UInt<32>
    input io_de : UInt<1>
    input io_d : UInt<32>
    output io_qe : UInt<1>
    output io_q : UInt<32>
    output io_qs : UInt<32>

    reg qe_reg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), qe_reg) @[SubReg.scala 23:23]
    reg q_reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), q_reg) @[SubReg.scala 24:22]
    node wr_en = io_de @[SubReg.scala 20:19 SubReg.scala 30:11]
    node wr_data = io_d @[SubReg.scala 21:21 SubReg.scala 31:13]
    node _GEN_0 = mux(wr_en, wr_data, q_reg) @[SubReg.scala 47:15 SubReg.scala 48:11 SubReg.scala 24:22]
    io_qe <= qe_reg @[SubReg.scala 53:9]
    io_q <= q_reg @[SubReg.scala 52:8]
    io_qs <= q_reg @[SubReg.scala 51:9]
    qe_reg <= mux(reset, UInt<1>("h0"), io_we) @[SubReg.scala 23:23 SubReg.scala 23:23 SubReg.scala 46:10]
    q_reg <= mux(reset, UInt<32>("h0"), _GEN_0) @[SubReg.scala 24:22 SubReg.scala 24:22]

  module SubRegExt_2 :
    input clock : Clock
    input reset : UInt<1>
    input io_re : UInt<1>
    input io_we : UInt<1>
    input io_wd : UInt<16>
    input io_d : UInt<16>
    output io_qe : UInt<1>
    output io_qre : UInt<1>
    output io_q : UInt<16>
    output io_qs : UInt<16>

    io_qe <= io_we @[SubRegExt.scala 25:9]
    io_qre <= io_re @[SubRegExt.scala 26:10]
    io_q <= io_wd @[SubRegExt.scala 24:8]
    io_qs <= io_d @[SubRegExt.scala 23:9]

  module GpioRegTop :
    input clock : Clock
    input reset : UInt<1>
    output io_req_ready : UInt<1>
    input io_req_valid : UInt<1>
    input io_req_bits_addrRequest : UInt<32>
    input io_req_bits_dataRequest : UInt<32>
    input io_req_bits_activeByteLane : UInt<4>
    input io_req_bits_isWrite : UInt<1>
    input io_rsp_ready : UInt<1>
    output io_rsp_valid : UInt<1>
    output io_rsp_bits_dataResponse : UInt<32>
    output io_rsp_bits_error : UInt<1>
    output io_rsp_bits_ackWrite : UInt<1>
    output io_reg2hw_intr_state_q : UInt<32>
    output io_reg2hw_intr_enable_q : UInt<32>
    output io_reg2hw_intr_test_q : UInt<32>
    output io_reg2hw_intr_test_qe : UInt<1>
    output io_reg2hw_direct_out_q : UInt<32>
    output io_reg2hw_direct_out_qe : UInt<1>
    output io_reg2hw_masked_out_lower_data_q : UInt<16>
    output io_reg2hw_masked_out_lower_data_qe : UInt<1>
    output io_reg2hw_masked_out_lower_mask_q : UInt<16>
    output io_reg2hw_masked_out_lower_mask_qe : UInt<1>
    output io_reg2hw_masked_out_upper_data_q : UInt<16>
    output io_reg2hw_masked_out_upper_data_qe : UInt<1>
    output io_reg2hw_masked_out_upper_mask_q : UInt<16>
    output io_reg2hw_masked_out_upper_mask_qe : UInt<1>
    output io_reg2hw_direct_oe_q : UInt<32>
    output io_reg2hw_direct_oe_qe : UInt<1>
    output io_reg2hw_masked_oe_lower_data_q : UInt<16>
    output io_reg2hw_masked_oe_lower_data_qe : UInt<1>
    output io_reg2hw_masked_oe_lower_mask_q : UInt<16>
    output io_reg2hw_masked_oe_lower_mask_qe : UInt<1>
    output io_reg2hw_masked_oe_upper_data_q : UInt<16>
    output io_reg2hw_masked_oe_upper_data_qe : UInt<1>
    output io_reg2hw_masked_oe_upper_mask_q : UInt<16>
    output io_reg2hw_masked_oe_upper_mask_qe : UInt<1>
    output io_reg2hw_intr_ctrl_en_rising_q : UInt<32>
    output io_reg2hw_intr_ctrl_en_falling_q : UInt<32>
    output io_reg2hw_intr_ctrl_en_lvlHigh_q : UInt<32>
    output io_reg2hw_intr_ctrl_en_lvlLow_q : UInt<32>
    input io_hw2reg_intr_state_d : UInt<32>
    input io_hw2reg_intr_state_de : UInt<1>
    input io_hw2reg_data_in_d : UInt<32>
    input io_hw2reg_data_in_de : UInt<1>
    input io_hw2reg_direct_out_d : UInt<32>
    input io_hw2reg_masked_out_lower_data_d : UInt<16>
    input io_hw2reg_masked_out_lower_mask_d : UInt<16>
    input io_hw2reg_masked_out_upper_data_d : UInt<16>
    input io_hw2reg_masked_out_upper_mask_d : UInt<16>
    input io_hw2reg_direct_oe_d : UInt<32>
    input io_hw2reg_masked_oe_lower_data_d : UInt<16>
    input io_hw2reg_masked_oe_lower_mask_d : UInt<16>
    input io_hw2reg_masked_oe_upper_data_d : UInt<16>
    input io_hw2reg_masked_oe_upper_mask_d : UInt<16>

    inst intr_state_reg of SubReg @[GpioRegTop.scala 95:30]
    inst intr_enable_reg of SubReg_1 @[GpioRegTop.scala 110:31]
    inst intr_test_reg of SubRegExt @[GpioRegTop.scala 119:29]
    inst data_in_reg of SubReg_2 @[GpioRegTop.scala 128:27]
    inst direct_out_reg of SubRegExt @[GpioRegTop.scala 136:30]
    inst masked_out_lower_data_reg of SubRegExt_2 @[GpioRegTop.scala 147:41]
    inst masked_out_lower_mask_reg of SubRegExt_2 @[GpioRegTop.scala 158:41]
    inst masked_out_upper_data_reg of SubRegExt_2 @[GpioRegTop.scala 168:41]
    inst masked_out_upper_mask_reg of SubRegExt_2 @[GpioRegTop.scala 179:41]
    inst direct_oe_reg of SubRegExt @[GpioRegTop.scala 188:29]
    inst masked_oe_lower_data_reg of SubRegExt_2 @[GpioRegTop.scala 199:40]
    inst masked_oe_lower_mask_reg of SubRegExt_2 @[GpioRegTop.scala 210:40]
    inst masked_oe_upper_data_reg of SubRegExt_2 @[GpioRegTop.scala 221:40]
    inst masked_oe_upper_mask_reg of SubRegExt_2 @[GpioRegTop.scala 232:40]
    inst intr_ctrl_en_rising_reg of SubReg_1 @[GpioRegTop.scala 242:39]
    inst intr_ctrl_en_falling_reg of SubReg_1 @[GpioRegTop.scala 251:40]
    inst intr_ctrl_en_lvlhigh_reg of SubReg_1 @[GpioRegTop.scala 260:40]
    inst intr_ctrl_en_lvllow_reg of SubReg_1 @[GpioRegTop.scala 269:39]
    node _reg_we_T = and(io_req_ready, io_req_valid) @[Decoupled.scala 40:37]
    node _reg_we_T_1 = mux(_reg_we_T, io_req_bits_isWrite, UInt<1>("h0")) @[GpioRegTop.scala 33:16]
    node _reg_re_T = and(io_req_ready, io_req_valid) @[Decoupled.scala 40:37]
    node _reg_re_T_1 = eq(io_req_bits_isWrite, UInt<1>("h0")) @[GpioRegTop.scala 34:32]
    node _reg_re_T_2 = mux(_reg_re_T, _reg_re_T_1, UInt<1>("h0")) @[GpioRegTop.scala 34:16]
    node reg_we = _reg_we_T_1 @[GpioRegTop.scala 24:48 GpioRegTop.scala 33:10]
    node reg_re = _reg_re_T_2 @[GpioRegTop.scala 24:48 GpioRegTop.scala 34:10]
    node _io_rsp_valid_T = or(reg_we, reg_re) @[GpioRegTop.scala 39:38]
    node _io_rsp_valid_T_1 = mux(_io_rsp_valid_T, UInt<1>("h1"), UInt<1>("h0")) @[GpioRegTop.scala 39:30]
    reg io_rsp_valid_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_rsp_valid_REG) @[GpioRegTop.scala 39:26]
    node _addr_miss_T = or(reg_re, reg_we) @[GpioRegTop.scala 282:27]
    node reg_addr = bits(io_req_bits_addrRequest, 5, 0) @[GpioRegTop.scala 26:22 GpioRegTop.scala 36:12]
    node _addr_hit_0_T = asUInt(UInt<1>("h0")) @[GpioRegTop.scala 279:63]
    node _addr_hit_0_T_1 = eq(reg_addr, _addr_hit_0_T) @[GpioRegTop.scala 279:29]
    node addr_hit_0 = _addr_hit_0_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_1 = eq(addr_hit_0, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_15 = or(UInt<1>("h0"), _addr_miss_T_1) @[GpioRegTop.scala 282:56]
    node _addr_hit_1_T = asUInt(UInt<3>("h4")) @[GpioRegTop.scala 279:63]
    node _addr_hit_1_T_1 = eq(reg_addr, _addr_hit_1_T) @[GpioRegTop.scala 279:29]
    node addr_hit_1 = _addr_hit_1_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_2 = eq(addr_hit_1, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_16 = or(_addr_miss_T_15, _addr_miss_T_2) @[GpioRegTop.scala 282:56]
    node _addr_hit_2_T = asUInt(UInt<4>("h8")) @[GpioRegTop.scala 279:63]
    node _addr_hit_2_T_1 = eq(reg_addr, _addr_hit_2_T) @[GpioRegTop.scala 279:29]
    node addr_hit_2 = _addr_hit_2_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_3 = eq(addr_hit_2, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_17 = or(_addr_miss_T_16, _addr_miss_T_3) @[GpioRegTop.scala 282:56]
    node _addr_hit_3_T = asUInt(UInt<4>("hc")) @[GpioRegTop.scala 279:63]
    node _addr_hit_3_T_1 = eq(reg_addr, _addr_hit_3_T) @[GpioRegTop.scala 279:29]
    node addr_hit_3 = _addr_hit_3_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_4 = eq(addr_hit_3, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_18 = or(_addr_miss_T_17, _addr_miss_T_4) @[GpioRegTop.scala 282:56]
    node _addr_hit_4_T = asUInt(UInt<5>("h10")) @[GpioRegTop.scala 279:63]
    node _addr_hit_4_T_1 = eq(reg_addr, _addr_hit_4_T) @[GpioRegTop.scala 279:29]
    node addr_hit_4 = _addr_hit_4_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_5 = eq(addr_hit_4, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_19 = or(_addr_miss_T_18, _addr_miss_T_5) @[GpioRegTop.scala 282:56]
    node _addr_hit_5_T = asUInt(UInt<5>("h14")) @[GpioRegTop.scala 279:63]
    node _addr_hit_5_T_1 = eq(reg_addr, _addr_hit_5_T) @[GpioRegTop.scala 279:29]
    node addr_hit_5 = _addr_hit_5_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_6 = eq(addr_hit_5, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_20 = or(_addr_miss_T_19, _addr_miss_T_6) @[GpioRegTop.scala 282:56]
    node _addr_hit_6_T = asUInt(UInt<5>("h18")) @[GpioRegTop.scala 279:63]
    node _addr_hit_6_T_1 = eq(reg_addr, _addr_hit_6_T) @[GpioRegTop.scala 279:29]
    node addr_hit_6 = _addr_hit_6_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_7 = eq(addr_hit_6, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_21 = or(_addr_miss_T_20, _addr_miss_T_7) @[GpioRegTop.scala 282:56]
    node _addr_hit_7_T = asUInt(UInt<5>("h1c")) @[GpioRegTop.scala 279:63]
    node _addr_hit_7_T_1 = eq(reg_addr, _addr_hit_7_T) @[GpioRegTop.scala 279:29]
    node addr_hit_7 = _addr_hit_7_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_8 = eq(addr_hit_7, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_22 = or(_addr_miss_T_21, _addr_miss_T_8) @[GpioRegTop.scala 282:56]
    node _addr_hit_8_T = asUInt(UInt<6>("h20")) @[GpioRegTop.scala 279:63]
    node _addr_hit_8_T_1 = eq(reg_addr, _addr_hit_8_T) @[GpioRegTop.scala 279:29]
    node addr_hit_8 = _addr_hit_8_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_9 = eq(addr_hit_8, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_23 = or(_addr_miss_T_22, _addr_miss_T_9) @[GpioRegTop.scala 282:56]
    node _addr_hit_9_T = asUInt(UInt<6>("h24")) @[GpioRegTop.scala 279:63]
    node _addr_hit_9_T_1 = eq(reg_addr, _addr_hit_9_T) @[GpioRegTop.scala 279:29]
    node addr_hit_9 = _addr_hit_9_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_10 = eq(addr_hit_9, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_24 = or(_addr_miss_T_23, _addr_miss_T_10) @[GpioRegTop.scala 282:56]
    node _addr_hit_10_T = asUInt(UInt<6>("h28")) @[GpioRegTop.scala 279:63]
    node _addr_hit_10_T_1 = eq(reg_addr, _addr_hit_10_T) @[GpioRegTop.scala 279:29]
    node addr_hit_10 = _addr_hit_10_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_11 = eq(addr_hit_10, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_25 = or(_addr_miss_T_24, _addr_miss_T_11) @[GpioRegTop.scala 282:56]
    node _addr_hit_11_T = asUInt(UInt<6>("h2c")) @[GpioRegTop.scala 279:63]
    node _addr_hit_11_T_1 = eq(reg_addr, _addr_hit_11_T) @[GpioRegTop.scala 279:29]
    node addr_hit_11 = _addr_hit_11_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_12 = eq(addr_hit_11, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_26 = or(_addr_miss_T_25, _addr_miss_T_12) @[GpioRegTop.scala 282:56]
    node _addr_hit_12_T = asUInt(UInt<6>("h30")) @[GpioRegTop.scala 279:63]
    node _addr_hit_12_T_1 = eq(reg_addr, _addr_hit_12_T) @[GpioRegTop.scala 279:29]
    node addr_hit_12 = _addr_hit_12_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_13 = eq(addr_hit_12, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_27 = or(_addr_miss_T_26, _addr_miss_T_13) @[GpioRegTop.scala 282:56]
    node _addr_hit_13_T = asUInt(UInt<6>("h34")) @[GpioRegTop.scala 279:63]
    node _addr_hit_13_T_1 = eq(reg_addr, _addr_hit_13_T) @[GpioRegTop.scala 279:29]
    node addr_hit_13 = _addr_hit_13_T_1 @[GpioRegTop.scala 277:22 GpioRegTop.scala 279:17]
    node _addr_miss_T_14 = eq(addr_hit_13, UInt<1>("h1")) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_28 = or(_addr_miss_T_27, _addr_miss_T_14) @[GpioRegTop.scala 282:56]
    node _addr_miss_T_29 = not(_addr_miss_T_28) @[GpioRegTop.scala 282:38]
    node _addr_miss_T_30 = mux(_addr_miss_T, _addr_miss_T_29, UInt<1>("h0")) @[GpioRegTop.scala 282:19]
    node addr_miss = _addr_miss_T_30 @[GpioRegTop.scala 29:31 GpioRegTop.scala 282:13]
    node _T = and(addr_hit_0, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_0 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node reg_be = io_req_bits_activeByteLane @[GpioRegTop.scala 27:20 GpioRegTop.scala 37:10]
    node _T_1 = and(GPIO_PERMIT_0, reg_be) @[GpioRegTop.scala 291:31]
    node _T_2 = neq(GPIO_PERMIT_0, _T_1) @[GpioRegTop.scala 291:24]
    node _T_3 = and(_T, _T_2) @[GpioRegTop.scala 291:18]
    node _T_4 = and(addr_hit_1, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_1 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_5 = and(GPIO_PERMIT_1, reg_be) @[GpioRegTop.scala 291:31]
    node _T_6 = neq(GPIO_PERMIT_1, _T_5) @[GpioRegTop.scala 291:24]
    node _T_7 = and(_T_4, _T_6) @[GpioRegTop.scala 291:18]
    node _T_8 = and(addr_hit_2, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_2 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_9 = and(GPIO_PERMIT_2, reg_be) @[GpioRegTop.scala 291:31]
    node _T_10 = neq(GPIO_PERMIT_2, _T_9) @[GpioRegTop.scala 291:24]
    node _T_11 = and(_T_8, _T_10) @[GpioRegTop.scala 291:18]
    node _T_12 = and(addr_hit_3, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_3 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_13 = and(GPIO_PERMIT_3, reg_be) @[GpioRegTop.scala 291:31]
    node _T_14 = neq(GPIO_PERMIT_3, _T_13) @[GpioRegTop.scala 291:24]
    node _T_15 = and(_T_12, _T_14) @[GpioRegTop.scala 291:18]
    node _T_16 = and(addr_hit_4, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_4 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_17 = and(GPIO_PERMIT_4, reg_be) @[GpioRegTop.scala 291:31]
    node _T_18 = neq(GPIO_PERMIT_4, _T_17) @[GpioRegTop.scala 291:24]
    node _T_19 = and(_T_16, _T_18) @[GpioRegTop.scala 291:18]
    node _T_20 = and(addr_hit_5, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_5 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_21 = and(GPIO_PERMIT_5, reg_be) @[GpioRegTop.scala 291:31]
    node _T_22 = neq(GPIO_PERMIT_5, _T_21) @[GpioRegTop.scala 291:24]
    node _T_23 = and(_T_20, _T_22) @[GpioRegTop.scala 291:18]
    node _T_24 = and(addr_hit_6, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_6 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_25 = and(GPIO_PERMIT_6, reg_be) @[GpioRegTop.scala 291:31]
    node _T_26 = neq(GPIO_PERMIT_6, _T_25) @[GpioRegTop.scala 291:24]
    node _T_27 = and(_T_24, _T_26) @[GpioRegTop.scala 291:18]
    node _T_28 = and(addr_hit_7, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_7 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_29 = and(GPIO_PERMIT_7, reg_be) @[GpioRegTop.scala 291:31]
    node _T_30 = neq(GPIO_PERMIT_7, _T_29) @[GpioRegTop.scala 291:24]
    node _T_31 = and(_T_28, _T_30) @[GpioRegTop.scala 291:18]
    node _T_32 = and(addr_hit_8, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_8 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_33 = and(GPIO_PERMIT_8, reg_be) @[GpioRegTop.scala 291:31]
    node _T_34 = neq(GPIO_PERMIT_8, _T_33) @[GpioRegTop.scala 291:24]
    node _T_35 = and(_T_32, _T_34) @[GpioRegTop.scala 291:18]
    node _T_36 = and(addr_hit_9, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_9 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_37 = and(GPIO_PERMIT_9, reg_be) @[GpioRegTop.scala 291:31]
    node _T_38 = neq(GPIO_PERMIT_9, _T_37) @[GpioRegTop.scala 291:24]
    node _T_39 = and(_T_36, _T_38) @[GpioRegTop.scala 291:18]
    node _T_40 = and(addr_hit_10, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_10 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_41 = and(GPIO_PERMIT_10, reg_be) @[GpioRegTop.scala 291:31]
    node _T_42 = neq(GPIO_PERMIT_10, _T_41) @[GpioRegTop.scala 291:24]
    node _T_43 = and(_T_40, _T_42) @[GpioRegTop.scala 291:18]
    node _T_44 = and(addr_hit_11, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_11 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_45 = and(GPIO_PERMIT_11, reg_be) @[GpioRegTop.scala 291:31]
    node _T_46 = neq(GPIO_PERMIT_11, _T_45) @[GpioRegTop.scala 291:24]
    node _T_47 = and(_T_44, _T_46) @[GpioRegTop.scala 291:18]
    node _T_48 = and(addr_hit_12, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_12 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_49 = and(GPIO_PERMIT_12, reg_be) @[GpioRegTop.scala 291:31]
    node _T_50 = neq(GPIO_PERMIT_12, _T_49) @[GpioRegTop.scala 291:24]
    node _T_51 = and(_T_48, _T_50) @[GpioRegTop.scala 291:18]
    node _T_52 = and(addr_hit_13, reg_we) @[GpioRegTop.scala 291:8]
    node GPIO_PERMIT_13 = UInt<4>("hf") @[GpioRegTop.scala 284:25 GpioRegTop.scala 287:20]
    node _T_53 = and(GPIO_PERMIT_13, reg_be) @[GpioRegTop.scala 291:31]
    node _T_54 = neq(GPIO_PERMIT_13, _T_53) @[GpioRegTop.scala 291:24]
    node _T_55 = and(_T_52, _T_54) @[GpioRegTop.scala 291:18]
    node _wr_err_T = mux(_T_55, UInt<1>("h1"), UInt<1>("h0")) @[Mux.scala 98:16]
    node _wr_err_T_1 = mux(_T_51, UInt<1>("h1"), _wr_err_T) @[Mux.scala 98:16]
    node _wr_err_T_2 = mux(_T_47, UInt<1>("h1"), _wr_err_T_1) @[Mux.scala 98:16]
    node _wr_err_T_3 = mux(_T_43, UInt<1>("h1"), _wr_err_T_2) @[Mux.scala 98:16]
    node _wr_err_T_4 = mux(_T_39, UInt<1>("h1"), _wr_err_T_3) @[Mux.scala 98:16]
    node _wr_err_T_5 = mux(_T_35, UInt<1>("h1"), _wr_err_T_4) @[Mux.scala 98:16]
    node _wr_err_T_6 = mux(_T_31, UInt<1>("h1"), _wr_err_T_5) @[Mux.scala 98:16]
    node _wr_err_T_7 = mux(_T_27, UInt<1>("h1"), _wr_err_T_6) @[Mux.scala 98:16]
    node _wr_err_T_8 = mux(_T_23, UInt<1>("h1"), _wr_err_T_7) @[Mux.scala 98:16]
    node _wr_err_T_9 = mux(_T_19, UInt<1>("h1"), _wr_err_T_8) @[Mux.scala 98:16]
    node _wr_err_T_10 = mux(_T_15, UInt<1>("h1"), _wr_err_T_9) @[Mux.scala 98:16]
    node _wr_err_T_11 = mux(_T_11, UInt<1>("h1"), _wr_err_T_10) @[Mux.scala 98:16]
    node _wr_err_T_12 = mux(_T_7, UInt<1>("h1"), _wr_err_T_11) @[Mux.scala 98:16]
    node _wr_err_T_13 = mux(_T_3, UInt<1>("h1"), _wr_err_T_12) @[Mux.scala 98:16]
    node wr_err = _wr_err_T_13 @[GpioRegTop.scala 29:31 GpioRegTop.scala 294:10]
    node _reg_error_T = or(addr_miss, wr_err) @[GpioRegTop.scala 45:26]
    node _intr_state_we_T = and(addr_hit_0, reg_we) @[GpioRegTop.scala 298:32]
    node _intr_state_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 298:43]
    node _intr_state_we_T_2 = and(_intr_state_we_T, _intr_state_we_T_1) @[GpioRegTop.scala 298:41]
    node _intr_enable_we_T = and(addr_hit_1, reg_we) @[GpioRegTop.scala 301:33]
    node _intr_enable_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 301:44]
    node _intr_enable_we_T_2 = and(_intr_enable_we_T, _intr_enable_we_T_1) @[GpioRegTop.scala 301:42]
    node _intr_test_we_T = and(addr_hit_2, reg_we) @[GpioRegTop.scala 304:31]
    node _intr_test_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 304:42]
    node _intr_test_we_T_2 = and(_intr_test_we_T, _intr_test_we_T_1) @[GpioRegTop.scala 304:40]
    node _direct_out_we_T = and(addr_hit_4, reg_we) @[GpioRegTop.scala 307:32]
    node _direct_out_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 307:43]
    node _direct_out_we_T_2 = and(_direct_out_we_T, _direct_out_we_T_1) @[GpioRegTop.scala 307:41]
    node _direct_out_re_T = and(addr_hit_4, reg_re) @[GpioRegTop.scala 309:32]
    node _masked_out_lower_data_we_T = and(addr_hit_5, reg_we) @[GpioRegTop.scala 311:43]
    node _masked_out_lower_data_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 311:54]
    node _masked_out_lower_data_we_T_2 = and(_masked_out_lower_data_we_T, _masked_out_lower_data_we_T_1) @[GpioRegTop.scala 311:52]
    node reg_wdata = io_req_bits_dataRequest @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
    node _masked_out_lower_data_wd_T = bits(reg_wdata, 15, 0) @[GpioRegTop.scala 312:40]
    node _masked_out_lower_data_re_T = and(addr_hit_5, reg_re) @[GpioRegTop.scala 313:43]
    node _masked_out_lower_mask_we_T = and(addr_hit_5, reg_we) @[GpioRegTop.scala 315:43]
    node _masked_out_lower_mask_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 315:54]
    node _masked_out_lower_mask_we_T_2 = and(_masked_out_lower_mask_we_T, _masked_out_lower_mask_we_T_1) @[GpioRegTop.scala 315:52]
    node _masked_out_lower_mask_wd_T = bits(reg_wdata, 31, 16) @[GpioRegTop.scala 316:40]
    node _masked_out_upper_data_we_T = and(addr_hit_6, reg_we) @[GpioRegTop.scala 318:43]
    node _masked_out_upper_data_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 318:54]
    node _masked_out_upper_data_we_T_2 = and(_masked_out_upper_data_we_T, _masked_out_upper_data_we_T_1) @[GpioRegTop.scala 318:52]
    node _masked_out_upper_data_wd_T = bits(reg_wdata, 15, 0) @[GpioRegTop.scala 319:40]
    node _masked_out_upper_data_re_T = and(addr_hit_6, reg_re) @[GpioRegTop.scala 320:43]
    node _masked_out_upper_mask_we_T = and(addr_hit_6, reg_we) @[GpioRegTop.scala 322:43]
    node _masked_out_upper_mask_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 322:54]
    node _masked_out_upper_mask_we_T_2 = and(_masked_out_upper_mask_we_T, _masked_out_upper_mask_we_T_1) @[GpioRegTop.scala 322:52]
    node _masked_out_upper_mask_wd_T = bits(reg_wdata, 31, 16) @[GpioRegTop.scala 323:40]
    node _direct_oe_we_T = and(addr_hit_7, reg_we) @[GpioRegTop.scala 325:31]
    node _direct_oe_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 325:42]
    node _direct_oe_we_T_2 = and(_direct_oe_we_T, _direct_oe_we_T_1) @[GpioRegTop.scala 325:40]
    node _direct_oe_re_T = and(addr_hit_7, reg_re) @[GpioRegTop.scala 327:31]
    node _masked_oe_lower_data_we_T = and(addr_hit_8, reg_we) @[GpioRegTop.scala 329:42]
    node _masked_oe_lower_data_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 329:53]
    node _masked_oe_lower_data_we_T_2 = and(_masked_oe_lower_data_we_T, _masked_oe_lower_data_we_T_1) @[GpioRegTop.scala 329:51]
    node _masked_oe_lower_data_wd_T = bits(reg_wdata, 15, 0) @[GpioRegTop.scala 330:39]
    node _masked_oe_lower_data_re_T = and(addr_hit_8, reg_re) @[GpioRegTop.scala 331:42]
    node _masked_oe_lower_mask_we_T = and(addr_hit_8, reg_we) @[GpioRegTop.scala 333:42]
    node _masked_oe_lower_mask_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 333:53]
    node _masked_oe_lower_mask_we_T_2 = and(_masked_oe_lower_mask_we_T, _masked_oe_lower_mask_we_T_1) @[GpioRegTop.scala 333:51]
    node _masked_oe_lower_mask_wd_T = bits(reg_wdata, 31, 16) @[GpioRegTop.scala 334:39]
    node _masked_oe_lower_mask_re_T = and(addr_hit_8, reg_re) @[GpioRegTop.scala 335:42]
    node _masked_oe_upper_data_we_T = and(addr_hit_9, reg_we) @[GpioRegTop.scala 337:42]
    node _masked_oe_upper_data_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 337:53]
    node _masked_oe_upper_data_we_T_2 = and(_masked_oe_upper_data_we_T, _masked_oe_upper_data_we_T_1) @[GpioRegTop.scala 337:51]
    node _masked_oe_upper_data_wd_T = bits(reg_wdata, 15, 0) @[GpioRegTop.scala 338:39]
    node _masked_oe_upper_data_re_T = and(addr_hit_9, reg_re) @[GpioRegTop.scala 339:42]
    node _masked_oe_upper_mask_we_T = and(addr_hit_9, reg_we) @[GpioRegTop.scala 341:42]
    node _masked_oe_upper_mask_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 341:53]
    node _masked_oe_upper_mask_we_T_2 = and(_masked_oe_upper_mask_we_T, _masked_oe_upper_mask_we_T_1) @[GpioRegTop.scala 341:51]
    node _masked_oe_upper_mask_wd_T = bits(reg_wdata, 31, 16) @[GpioRegTop.scala 342:39]
    node _masked_oe_upper_mask_re_T = and(addr_hit_9, reg_re) @[GpioRegTop.scala 343:42]
    node _intr_ctrl_en_rising_we_T = and(addr_hit_10, reg_we) @[GpioRegTop.scala 345:42]
    node _intr_ctrl_en_rising_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 345:53]
    node _intr_ctrl_en_rising_we_T_2 = and(_intr_ctrl_en_rising_we_T, _intr_ctrl_en_rising_we_T_1) @[GpioRegTop.scala 345:51]
    node _intr_ctrl_en_falling_we_T = and(addr_hit_11, reg_we) @[GpioRegTop.scala 348:43]
    node _intr_ctrl_en_falling_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 348:54]
    node _intr_ctrl_en_falling_we_T_2 = and(_intr_ctrl_en_falling_we_T, _intr_ctrl_en_falling_we_T_1) @[GpioRegTop.scala 348:52]
    node _intr_ctrl_en_lvlhigh_we_T = and(addr_hit_12, reg_we) @[GpioRegTop.scala 351:43]
    node _intr_ctrl_en_lvlhigh_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 351:54]
    node _intr_ctrl_en_lvlhigh_we_T_2 = and(_intr_ctrl_en_lvlhigh_we_T, _intr_ctrl_en_lvlhigh_we_T_1) @[GpioRegTop.scala 351:52]
    node _intr_ctrl_en_lvllow_we_T = and(addr_hit_13, reg_we) @[GpioRegTop.scala 354:42]
    node _intr_ctrl_en_lvllow_we_T_1 = eq(wr_err, UInt<1>("h0")) @[GpioRegTop.scala 354:53]
    node _intr_ctrl_en_lvllow_we_T_2 = and(_intr_ctrl_en_lvllow_we_T, _intr_ctrl_en_lvllow_we_T_1) @[GpioRegTop.scala 354:51]
    node masked_out_lower_data_qs = masked_out_lower_data_reg.io_qs @[GpioRegTop.scala 63:90 GpioRegTop.scala 154:28]
    node _reg_rdata_next_T = cat(UInt<16>("h0"), masked_out_lower_data_qs) @[Cat.scala 30:58]
    node masked_out_upper_data_qs = masked_out_upper_data_reg.io_qs @[GpioRegTop.scala 66:90 GpioRegTop.scala 175:28]
    node _reg_rdata_next_T_1 = cat(UInt<16>("h0"), masked_out_upper_data_qs) @[Cat.scala 30:58]
    node masked_oe_lower_mask_qs = masked_oe_lower_mask_reg.io_qs @[GpioRegTop.scala 73:112 GpioRegTop.scala 217:27]
    node masked_oe_lower_data_qs = masked_oe_lower_data_reg.io_qs @[GpioRegTop.scala 73:112 GpioRegTop.scala 206:27]
    node _reg_rdata_next_T_2 = cat(masked_oe_lower_mask_qs, masked_oe_lower_data_qs) @[Cat.scala 30:58]
    node masked_oe_upper_mask_qs = masked_oe_upper_mask_reg.io_qs @[GpioRegTop.scala 76:112 GpioRegTop.scala 239:27]
    node masked_oe_upper_data_qs = masked_oe_upper_data_reg.io_qs @[GpioRegTop.scala 76:112 GpioRegTop.scala 228:27]
    node _reg_rdata_next_T_3 = cat(masked_oe_upper_mask_qs, masked_oe_upper_data_qs) @[Cat.scala 30:58]
    node _reg_rdata_next_T_4 = mux(UInt<1>("h1"), UInt<32>("hffffffff"), UInt<32>("h0")) @[Bitwise.scala 72:12]
    node intr_ctrl_en_lvllow_qs = intr_ctrl_en_lvllow_reg.io_qs @[GpioRegTop.scala 88:60 GpioRegTop.scala 275:26]
    node _GEN_0 = mux(addr_hit_13, intr_ctrl_en_lvllow_qs, _reg_rdata_next_T_4) @[GpioRegTop.scala 384:28 GpioRegTop.scala 385:20 GpioRegTop.scala 387:20]
    node intr_ctrl_en_lvlhigh_qs = intr_ctrl_en_lvlhigh_reg.io_qs @[GpioRegTop.scala 85:62 GpioRegTop.scala 266:27]
    node _GEN_1 = mux(addr_hit_12, intr_ctrl_en_lvlhigh_qs, _GEN_0) @[GpioRegTop.scala 382:28 GpioRegTop.scala 383:20]
    node intr_ctrl_en_falling_qs = intr_ctrl_en_falling_reg.io_qs @[GpioRegTop.scala 82:62 GpioRegTop.scala 257:27]
    node _GEN_2 = mux(addr_hit_11, intr_ctrl_en_falling_qs, _GEN_1) @[GpioRegTop.scala 380:28 GpioRegTop.scala 381:20]
    node intr_ctrl_en_rising_qs = intr_ctrl_en_rising_reg.io_qs @[GpioRegTop.scala 79:60 GpioRegTop.scala 248:26]
    node _GEN_3 = mux(addr_hit_10, intr_ctrl_en_rising_qs, _GEN_2) @[GpioRegTop.scala 378:28 GpioRegTop.scala 379:20]
    node _GEN_4 = mux(addr_hit_9, _reg_rdata_next_T_3, _GEN_3) @[GpioRegTop.scala 376:27 GpioRegTop.scala 377:20]
    node _GEN_5 = mux(addr_hit_8, _reg_rdata_next_T_2, _GEN_4) @[GpioRegTop.scala 374:27 GpioRegTop.scala 375:20]
    node direct_oe_qs = direct_oe_reg.io_qs @[GpioRegTop.scala 69:26 GpioRegTop.scala 195:16]
    node _GEN_6 = mux(addr_hit_7, direct_oe_qs, _GEN_5) @[GpioRegTop.scala 372:27 GpioRegTop.scala 373:20]
    node _GEN_7 = mux(addr_hit_6, _reg_rdata_next_T_1, _GEN_6) @[GpioRegTop.scala 370:27 GpioRegTop.scala 371:20]
    node _GEN_8 = mux(addr_hit_5, _reg_rdata_next_T, _GEN_7) @[GpioRegTop.scala 368:27 GpioRegTop.scala 369:20]
    node direct_out_qs = direct_out_reg.io_qs @[GpioRegTop.scala 60:42 GpioRegTop.scala 143:17]
    node _GEN_9 = mux(addr_hit_4, direct_out_qs, _GEN_8) @[GpioRegTop.scala 366:27 GpioRegTop.scala 367:20]
    node data_in_qs = data_in_reg.io_qs @[GpioRegTop.scala 58:24 GpioRegTop.scala 133:14]
    node _GEN_10 = mux(addr_hit_3, data_in_qs, _GEN_9) @[GpioRegTop.scala 364:27 GpioRegTop.scala 365:20]
    node _GEN_11 = mux(addr_hit_2, UInt<1>("h0"), _GEN_10) @[GpioRegTop.scala 362:27 GpioRegTop.scala 363:20]
    node intr_enable_qs = intr_enable_reg.io_qs @[GpioRegTop.scala 52:44 GpioRegTop.scala 116:18]
    node _GEN_12 = mux(addr_hit_1, intr_enable_qs, _GEN_11) @[GpioRegTop.scala 360:27 GpioRegTop.scala 361:20]
    node intr_state_qs = intr_state_reg.io_qs @[GpioRegTop.scala 49:42 GpioRegTop.scala 107:17]
    node _GEN_13 = mux(addr_hit_0, intr_state_qs, _GEN_12) @[GpioRegTop.scala 358:21 GpioRegTop.scala 359:20]
    node reg_error = _reg_error_T @[GpioRegTop.scala 24:48 GpioRegTop.scala 45:13]
    node reg_ack = io_req_bits_isWrite @[GpioRegTop.scala 24:48 GpioRegTop.scala 46:11]
    node reg_rdata_next = _GEN_13 @[GpioRegTop.scala 30:28]
    node reg_rdata = reg_rdata_next @[GpioRegTop.scala 25:34 GpioRegTop.scala 44:13]
    node intr_state_wd = reg_wdata @[GpioRegTop.scala 49:42 GpioRegTop.scala 299:17]
    node intr_state_we = _intr_state_we_T_2 @[GpioRegTop.scala 50:27 GpioRegTop.scala 298:17]
    node intr_enable_wd = reg_wdata @[GpioRegTop.scala 52:44 GpioRegTop.scala 302:18]
    node intr_enable_we = _intr_enable_we_T_2 @[GpioRegTop.scala 53:28 GpioRegTop.scala 301:18]
    node intr_test_wd = reg_wdata @[GpioRegTop.scala 55:26 GpioRegTop.scala 305:16]
    node intr_test_we = _intr_test_we_T_2 @[GpioRegTop.scala 56:26 GpioRegTop.scala 304:16]
    node direct_out_wd = reg_wdata @[GpioRegTop.scala 60:42 GpioRegTop.scala 308:17]
    node direct_out_we = _direct_out_we_T_2 @[GpioRegTop.scala 61:42 GpioRegTop.scala 307:17]
    node direct_out_re = _direct_out_re_T @[GpioRegTop.scala 61:42 GpioRegTop.scala 309:17]
    node masked_out_lower_data_wd = _masked_out_lower_data_wd_T @[GpioRegTop.scala 63:90 GpioRegTop.scala 312:28]
    node masked_out_lower_mask_wd = _masked_out_lower_mask_wd_T @[GpioRegTop.scala 63:90 GpioRegTop.scala 316:28]
    node masked_out_lower_data_we = _masked_out_lower_data_we_T_2 @[GpioRegTop.scala 64:90 GpioRegTop.scala 311:28]
    node masked_out_lower_data_re = _masked_out_lower_data_re_T @[GpioRegTop.scala 64:90 GpioRegTop.scala 313:28]
    node masked_out_lower_mask_we = _masked_out_lower_mask_we_T_2 @[GpioRegTop.scala 64:90 GpioRegTop.scala 315:28]
    node masked_out_upper_data_wd = _masked_out_upper_data_wd_T @[GpioRegTop.scala 66:90 GpioRegTop.scala 319:28]
    node masked_out_upper_mask_wd = _masked_out_upper_mask_wd_T @[GpioRegTop.scala 66:90 GpioRegTop.scala 323:28]
    node masked_out_upper_data_we = _masked_out_upper_data_we_T_2 @[GpioRegTop.scala 67:90 GpioRegTop.scala 318:28]
    node masked_out_upper_data_re = _masked_out_upper_data_re_T @[GpioRegTop.scala 67:90 GpioRegTop.scala 320:28]
    node masked_out_upper_mask_we = _masked_out_upper_mask_we_T_2 @[GpioRegTop.scala 67:90 GpioRegTop.scala 322:28]
    node direct_oe_wd = reg_wdata @[GpioRegTop.scala 70:26 GpioRegTop.scala 326:16]
    node direct_oe_we = _direct_oe_we_T_2 @[GpioRegTop.scala 71:40 GpioRegTop.scala 325:16]
    node direct_oe_re = _direct_oe_re_T @[GpioRegTop.scala 71:40 GpioRegTop.scala 327:16]
    node masked_oe_lower_data_wd = _masked_oe_lower_data_wd_T @[GpioRegTop.scala 73:112 GpioRegTop.scala 330:27]
    node masked_oe_lower_mask_wd = _masked_oe_lower_mask_wd_T @[GpioRegTop.scala 73:112 GpioRegTop.scala 334:27]
    node masked_oe_lower_data_we = _masked_oe_lower_data_we_T_2 @[GpioRegTop.scala 74:112 GpioRegTop.scala 329:27]
    node masked_oe_lower_data_re = _masked_oe_lower_data_re_T @[GpioRegTop.scala 74:112 GpioRegTop.scala 331:27]
    node masked_oe_lower_mask_we = _masked_oe_lower_mask_we_T_2 @[GpioRegTop.scala 74:112 GpioRegTop.scala 333:27]
    node masked_oe_lower_mask_re = _masked_oe_lower_mask_re_T @[GpioRegTop.scala 74:112 GpioRegTop.scala 335:27]
    node masked_oe_upper_data_wd = _masked_oe_upper_data_wd_T @[GpioRegTop.scala 76:112 GpioRegTop.scala 338:27]
    node masked_oe_upper_mask_wd = _masked_oe_upper_mask_wd_T @[GpioRegTop.scala 76:112 GpioRegTop.scala 342:27]
    node masked_oe_upper_data_we = _masked_oe_upper_data_we_T_2 @[GpioRegTop.scala 77:112 GpioRegTop.scala 337:27]
    node masked_oe_upper_data_re = _masked_oe_upper_data_re_T @[GpioRegTop.scala 77:112 GpioRegTop.scala 339:27]
    node masked_oe_upper_mask_we = _masked_oe_upper_mask_we_T_2 @[GpioRegTop.scala 77:112 GpioRegTop.scala 341:27]
    node masked_oe_upper_mask_re = _masked_oe_upper_mask_re_T @[GpioRegTop.scala 77:112 GpioRegTop.scala 343:27]
    node intr_ctrl_en_rising_wd = reg_wdata @[GpioRegTop.scala 79:60 GpioRegTop.scala 346:26]
    node intr_ctrl_en_rising_we = _intr_ctrl_en_rising_we_T_2 @[GpioRegTop.scala 80:36 GpioRegTop.scala 345:26]
    node intr_ctrl_en_falling_wd = reg_wdata @[GpioRegTop.scala 82:62 GpioRegTop.scala 349:27]
    node intr_ctrl_en_falling_we = _intr_ctrl_en_falling_we_T_2 @[GpioRegTop.scala 83:37 GpioRegTop.scala 348:27]
    node intr_ctrl_en_lvlhigh_wd = reg_wdata @[GpioRegTop.scala 85:62 GpioRegTop.scala 352:27]
    node intr_ctrl_en_lvlhigh_we = _intr_ctrl_en_lvlhigh_we_T_2 @[GpioRegTop.scala 86:37 GpioRegTop.scala 351:27]
    node intr_ctrl_en_lvllow_wd = reg_wdata @[GpioRegTop.scala 88:60 GpioRegTop.scala 355:26]
    node intr_ctrl_en_lvllow_we = _intr_ctrl_en_lvllow_we_T_2 @[GpioRegTop.scala 89:36 GpioRegTop.scala 354:26]
    io_req_ready <= UInt<1>("h1") @[GpioRegTop.scala 18:16]
    io_rsp_valid <= io_rsp_valid_REG @[GpioRegTop.scala 39:16]
    io_rsp_bits_dataResponse <= reg_rdata @[GpioRegTop.scala 40:28]
    io_rsp_bits_error <= reg_error @[GpioRegTop.scala 41:21]
    io_rsp_bits_ackWrite <= reg_ack @[GpioRegTop.scala 42:24]
    io_reg2hw_intr_state_q <= intr_state_reg.io_q @[GpioRegTop.scala 105:26]
    io_reg2hw_intr_enable_q <= intr_enable_reg.io_q @[GpioRegTop.scala 115:27]
    io_reg2hw_intr_test_q <= intr_test_reg.io_q @[GpioRegTop.scala 125:25]
    io_reg2hw_intr_test_qe <= intr_test_reg.io_qe @[GpioRegTop.scala 124:26]
    io_reg2hw_direct_out_q <= direct_out_reg.io_q @[GpioRegTop.scala 142:26]
    io_reg2hw_direct_out_qe <= direct_out_reg.io_qe @[GpioRegTop.scala 141:27]
    io_reg2hw_masked_out_lower_data_q <= masked_out_lower_data_reg.io_q @[GpioRegTop.scala 153:37]
    io_reg2hw_masked_out_lower_data_qe <= masked_out_lower_data_reg.io_qe @[GpioRegTop.scala 152:38]
    io_reg2hw_masked_out_lower_mask_q <= masked_out_lower_mask_reg.io_q @[GpioRegTop.scala 164:37]
    io_reg2hw_masked_out_lower_mask_qe <= masked_out_lower_mask_reg.io_qe @[GpioRegTop.scala 163:38]
    io_reg2hw_masked_out_upper_data_q <= masked_out_upper_data_reg.io_q @[GpioRegTop.scala 174:37]
    io_reg2hw_masked_out_upper_data_qe <= masked_out_upper_data_reg.io_qe @[GpioRegTop.scala 173:38]
    io_reg2hw_masked_out_upper_mask_q <= masked_out_upper_mask_reg.io_q @[GpioRegTop.scala 185:37]
    io_reg2hw_masked_out_upper_mask_qe <= masked_out_upper_mask_reg.io_qe @[GpioRegTop.scala 184:38]
    io_reg2hw_direct_oe_q <= direct_oe_reg.io_q @[GpioRegTop.scala 194:25]
    io_reg2hw_direct_oe_qe <= direct_oe_reg.io_qe @[GpioRegTop.scala 193:26]
    io_reg2hw_masked_oe_lower_data_q <= masked_oe_lower_data_reg.io_q @[GpioRegTop.scala 205:36]
    io_reg2hw_masked_oe_lower_data_qe <= masked_oe_lower_data_reg.io_qe @[GpioRegTop.scala 204:37]
    io_reg2hw_masked_oe_lower_mask_q <= masked_oe_lower_mask_reg.io_q @[GpioRegTop.scala 216:36]
    io_reg2hw_masked_oe_lower_mask_qe <= masked_oe_lower_mask_reg.io_qe @[GpioRegTop.scala 215:37]
    io_reg2hw_masked_oe_upper_data_q <= masked_oe_upper_data_reg.io_q @[GpioRegTop.scala 227:36]
    io_reg2hw_masked_oe_upper_data_qe <= masked_oe_upper_data_reg.io_qe @[GpioRegTop.scala 226:37]
    io_reg2hw_masked_oe_upper_mask_q <= masked_oe_upper_mask_reg.io_q @[GpioRegTop.scala 238:36]
    io_reg2hw_masked_oe_upper_mask_qe <= masked_oe_upper_mask_reg.io_qe @[GpioRegTop.scala 237:37]
    io_reg2hw_intr_ctrl_en_rising_q <= intr_ctrl_en_rising_reg.io_q @[GpioRegTop.scala 247:35]
    io_reg2hw_intr_ctrl_en_falling_q <= intr_ctrl_en_falling_reg.io_q @[GpioRegTop.scala 256:36]
    io_reg2hw_intr_ctrl_en_lvlHigh_q <= intr_ctrl_en_lvlhigh_reg.io_q @[GpioRegTop.scala 265:36]
    io_reg2hw_intr_ctrl_en_lvlLow_q <= intr_ctrl_en_lvllow_reg.io_q @[GpioRegTop.scala 274:35]
    io_rsp_valid_REG <= _io_rsp_valid_T_1 @[GpioRegTop.scala 39:26]
    intr_state_reg.clock <= clock
    intr_state_reg.reset <= reset
    intr_state_reg.io_we <= intr_state_we @[GpioRegTop.scala 97:24]
    intr_state_reg.io_wd <= intr_state_wd @[GpioRegTop.scala 99:24]
    intr_state_reg.io_de <= io_hw2reg_intr_state_de @[GpioRegTop.scala 101:24]
    intr_state_reg.io_d <= io_hw2reg_intr_state_d @[GpioRegTop.scala 103:23]
    intr_enable_reg.clock <= clock
    intr_enable_reg.reset <= reset
    intr_enable_reg.io_we <= intr_enable_we @[GpioRegTop.scala 111:25]
    intr_enable_reg.io_wd <= intr_enable_wd @[GpioRegTop.scala 112:25]
    intr_enable_reg.io_de <= UInt<1>("h0") @[GpioRegTop.scala 114:25]
    intr_enable_reg.io_d <= UInt<32>("h0") @[GpioRegTop.scala 113:24]
    intr_test_reg.clock <= clock
    intr_test_reg.reset <= reset
    intr_test_reg.io_re <= UInt<1>("h0") @[GpioRegTop.scala 121:23]
    intr_test_reg.io_we <= intr_test_we @[GpioRegTop.scala 120:23]
    intr_test_reg.io_wd <= intr_test_wd @[GpioRegTop.scala 122:23]
    intr_test_reg.io_d <= UInt<32>("h0") @[GpioRegTop.scala 123:22]
    data_in_reg.clock <= clock
    data_in_reg.reset <= reset
    data_in_reg.io_we <= UInt<1>("h0") @[GpioRegTop.scala 129:21]
    data_in_reg.io_wd <= UInt<32>("h0") @[GpioRegTop.scala 130:21]
    data_in_reg.io_de <= io_hw2reg_data_in_de @[GpioRegTop.scala 131:21]
    data_in_reg.io_d <= io_hw2reg_data_in_d @[GpioRegTop.scala 132:20]
    direct_out_reg.clock <= clock
    direct_out_reg.reset <= reset
    direct_out_reg.io_re <= direct_out_re @[GpioRegTop.scala 137:24]
    direct_out_reg.io_we <= direct_out_we @[GpioRegTop.scala 138:24]
    direct_out_reg.io_wd <= direct_out_wd @[GpioRegTop.scala 139:24]
    direct_out_reg.io_d <= io_hw2reg_direct_out_d @[GpioRegTop.scala 140:23]
    masked_out_lower_data_reg.clock <= clock
    masked_out_lower_data_reg.reset <= reset
    masked_out_lower_data_reg.io_re <= masked_out_lower_data_re @[GpioRegTop.scala 148:35]
    masked_out_lower_data_reg.io_we <= masked_out_lower_data_we @[GpioRegTop.scala 149:35]
    masked_out_lower_data_reg.io_wd <= masked_out_lower_data_wd @[GpioRegTop.scala 150:35]
    masked_out_lower_data_reg.io_d <= io_hw2reg_masked_out_lower_data_d @[GpioRegTop.scala 151:34]
    masked_out_lower_mask_reg.clock <= clock
    masked_out_lower_mask_reg.reset <= reset
    masked_out_lower_mask_reg.io_re <= UInt<1>("h0") @[GpioRegTop.scala 159:35]
    masked_out_lower_mask_reg.io_we <= masked_out_lower_mask_we @[GpioRegTop.scala 160:35]
    masked_out_lower_mask_reg.io_wd <= masked_out_lower_mask_wd @[GpioRegTop.scala 161:35]
    masked_out_lower_mask_reg.io_d <= io_hw2reg_masked_out_lower_mask_d @[GpioRegTop.scala 162:34]
    masked_out_upper_data_reg.clock <= clock
    masked_out_upper_data_reg.reset <= reset
    masked_out_upper_data_reg.io_re <= masked_out_upper_data_re @[GpioRegTop.scala 169:35]
    masked_out_upper_data_reg.io_we <= masked_out_upper_data_we @[GpioRegTop.scala 170:35]
    masked_out_upper_data_reg.io_wd <= masked_out_upper_data_wd @[GpioRegTop.scala 171:35]
    masked_out_upper_data_reg.io_d <= io_hw2reg_masked_out_upper_data_d @[GpioRegTop.scala 172:34]
    masked_out_upper_mask_reg.clock <= clock
    masked_out_upper_mask_reg.reset <= reset
    masked_out_upper_mask_reg.io_re <= UInt<1>("h0") @[GpioRegTop.scala 180:35]
    masked_out_upper_mask_reg.io_we <= masked_out_upper_mask_we @[GpioRegTop.scala 181:35]
    masked_out_upper_mask_reg.io_wd <= masked_out_upper_mask_wd @[GpioRegTop.scala 182:35]
    masked_out_upper_mask_reg.io_d <= io_hw2reg_masked_out_upper_mask_d @[GpioRegTop.scala 183:34]
    direct_oe_reg.clock <= clock
    direct_oe_reg.reset <= reset
    direct_oe_reg.io_re <= direct_oe_re @[GpioRegTop.scala 189:23]
    direct_oe_reg.io_we <= direct_oe_we @[GpioRegTop.scala 190:23]
    direct_oe_reg.io_wd <= direct_oe_wd @[GpioRegTop.scala 191:23]
    direct_oe_reg.io_d <= io_hw2reg_direct_oe_d @[GpioRegTop.scala 192:22]
    masked_oe_lower_data_reg.clock <= clock
    masked_oe_lower_data_reg.reset <= reset
    masked_oe_lower_data_reg.io_re <= masked_oe_lower_data_re @[GpioRegTop.scala 200:34]
    masked_oe_lower_data_reg.io_we <= masked_oe_lower_data_we @[GpioRegTop.scala 201:34]
    masked_oe_lower_data_reg.io_wd <= masked_oe_lower_data_wd @[GpioRegTop.scala 202:34]
    masked_oe_lower_data_reg.io_d <= io_hw2reg_masked_oe_lower_data_d @[GpioRegTop.scala 203:33]
    masked_oe_lower_mask_reg.clock <= clock
    masked_oe_lower_mask_reg.reset <= reset
    masked_oe_lower_mask_reg.io_re <= masked_oe_lower_mask_re @[GpioRegTop.scala 211:34]
    masked_oe_lower_mask_reg.io_we <= masked_oe_lower_mask_we @[GpioRegTop.scala 212:34]
    masked_oe_lower_mask_reg.io_wd <= masked_oe_lower_mask_wd @[GpioRegTop.scala 213:34]
    masked_oe_lower_mask_reg.io_d <= io_hw2reg_masked_oe_lower_mask_d @[GpioRegTop.scala 214:33]
    masked_oe_upper_data_reg.clock <= clock
    masked_oe_upper_data_reg.reset <= reset
    masked_oe_upper_data_reg.io_re <= masked_oe_upper_data_re @[GpioRegTop.scala 222:34]
    masked_oe_upper_data_reg.io_we <= masked_oe_upper_data_we @[GpioRegTop.scala 223:34]
    masked_oe_upper_data_reg.io_wd <= masked_oe_upper_data_wd @[GpioRegTop.scala 224:34]
    masked_oe_upper_data_reg.io_d <= io_hw2reg_masked_oe_upper_data_d @[GpioRegTop.scala 225:33]
    masked_oe_upper_mask_reg.clock <= clock
    masked_oe_upper_mask_reg.reset <= reset
    masked_oe_upper_mask_reg.io_re <= masked_oe_upper_mask_re @[GpioRegTop.scala 233:34]
    masked_oe_upper_mask_reg.io_we <= masked_oe_upper_mask_we @[GpioRegTop.scala 234:34]
    masked_oe_upper_mask_reg.io_wd <= masked_oe_upper_mask_wd @[GpioRegTop.scala 235:34]
    masked_oe_upper_mask_reg.io_d <= io_hw2reg_masked_oe_upper_mask_d @[GpioRegTop.scala 236:33]
    intr_ctrl_en_rising_reg.clock <= clock
    intr_ctrl_en_rising_reg.reset <= reset
    intr_ctrl_en_rising_reg.io_we <= intr_ctrl_en_rising_we @[GpioRegTop.scala 243:33]
    intr_ctrl_en_rising_reg.io_wd <= intr_ctrl_en_rising_wd @[GpioRegTop.scala 244:33]
    intr_ctrl_en_rising_reg.io_de <= UInt<1>("h0") @[GpioRegTop.scala 245:33]
    intr_ctrl_en_rising_reg.io_d <= UInt<32>("h0") @[GpioRegTop.scala 246:32]
    intr_ctrl_en_falling_reg.clock <= clock
    intr_ctrl_en_falling_reg.reset <= reset
    intr_ctrl_en_falling_reg.io_we <= intr_ctrl_en_falling_we @[GpioRegTop.scala 252:34]
    intr_ctrl_en_falling_reg.io_wd <= intr_ctrl_en_falling_wd @[GpioRegTop.scala 253:34]
    intr_ctrl_en_falling_reg.io_de <= UInt<1>("h0") @[GpioRegTop.scala 254:34]
    intr_ctrl_en_falling_reg.io_d <= UInt<32>("h0") @[GpioRegTop.scala 255:33]
    intr_ctrl_en_lvlhigh_reg.clock <= clock
    intr_ctrl_en_lvlhigh_reg.reset <= reset
    intr_ctrl_en_lvlhigh_reg.io_we <= intr_ctrl_en_lvlhigh_we @[GpioRegTop.scala 261:34]
    intr_ctrl_en_lvlhigh_reg.io_wd <= intr_ctrl_en_lvlhigh_wd @[GpioRegTop.scala 262:34]
    intr_ctrl_en_lvlhigh_reg.io_de <= UInt<1>("h0") @[GpioRegTop.scala 263:34]
    intr_ctrl_en_lvlhigh_reg.io_d <= UInt<32>("h0") @[GpioRegTop.scala 264:33]
    intr_ctrl_en_lvllow_reg.clock <= clock
    intr_ctrl_en_lvllow_reg.reset <= reset
    intr_ctrl_en_lvllow_reg.io_we <= intr_ctrl_en_lvllow_we @[GpioRegTop.scala 270:33]
    intr_ctrl_en_lvllow_reg.io_wd <= intr_ctrl_en_lvllow_wd @[GpioRegTop.scala 271:33]
    intr_ctrl_en_lvllow_reg.io_de <= UInt<1>("h0") @[GpioRegTop.scala 272:33]
    intr_ctrl_en_lvllow_reg.io_d <= UInt<32>("h0") @[GpioRegTop.scala 273:32]

  module IntrHardware :
    input clock : Clock
    input reset : UInt<1>
    input io_event_intr_i : UInt<32>
    input io_reg2hw_intr_enable_q_i : UInt<32>
    input io_reg2hw_intr_test_q_i : UInt<32>
    input io_reg2hw_intr_test_qe_i : UInt<1>
    input io_reg2hw_intr_state_q_i : UInt<32>
    output io_hw2reg_intr_state_de_o : UInt<1>
    output io_hw2reg_intr_state_d_o : UInt<32>
    output io_intr_o : UInt<32>

    node _new_event_T = bits(io_reg2hw_intr_test_qe_i, 0, 0) @[Bitwise.scala 72:15]
    node _new_event_T_1 = mux(_new_event_T, UInt<32>("hffffffff"), UInt<32>("h0")) @[Bitwise.scala 72:12]
    node _new_event_T_2 = and(_new_event_T_1, io_reg2hw_intr_test_q_i) @[IntrHardware.scala 25:54]
    node _new_event_T_3 = or(_new_event_T_2, io_event_intr_i) @[IntrHardware.scala 25:80]
    node new_event = _new_event_T_3 @[IntrHardware.scala 24:23 IntrHardware.scala 25:13]
    node _io_hw2reg_intr_state_de_o_T = orr(new_event) @[IntrHardware.scala 26:45]
    node _io_hw2reg_intr_state_d_o_T = or(new_event, io_reg2hw_intr_state_q_i) @[IntrHardware.scala 27:41]
    reg reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg) @[IntrHardware.scala 30:22]
    node _reg_T = and(io_reg2hw_intr_state_q_i, io_reg2hw_intr_enable_q_i) @[IntrHardware.scala 31:37]
    io_hw2reg_intr_state_de_o <= _io_hw2reg_intr_state_de_o_T @[IntrHardware.scala 26:29]
    io_hw2reg_intr_state_d_o <= _io_hw2reg_intr_state_d_o_T @[IntrHardware.scala 27:28]
    io_intr_o <= reg @[IntrHardware.scala 32:15]
    reg <= mux(reset, UInt<32>("h0"), _reg_T) @[IntrHardware.scala 30:22 IntrHardware.scala 30:22 IntrHardware.scala 31:9]

  module Gpio :
    input clock : Clock
    input reset : UInt<1>
    output io_req_ready : UInt<1>
    input io_req_valid : UInt<1>
    input io_req_bits_addrRequest : UInt<32>
    input io_req_bits_dataRequest : UInt<32>
    input io_req_bits_activeByteLane : UInt<4>
    input io_req_bits_isWrite : UInt<1>
    input io_rsp_ready : UInt<1>
    output io_rsp_valid : UInt<1>
    output io_rsp_bits_dataResponse : UInt<32>
    output io_rsp_bits_error : UInt<1>
    output io_rsp_bits_ackWrite : UInt<1>
    input io_cio_gpio_i : UInt<32>
    output io_cio_gpio_o : UInt<32>
    output io_cio_gpio_en_o : UInt<32>
    output io_intr_gpio_o : UInt<32>

    inst gpioRegTop of GpioRegTop @[Gpio.scala 23:26]
    inst intr_hw of IntrHardware @[Gpio.scala 115:23]
    reg cio_gpio_q : UInt<32>, clock with :
      reset => (UInt<1>("h0"), cio_gpio_q) @[Gpio.scala 31:27]
    reg cio_gpio_en_q : UInt<32>, clock with :
      reset => (UInt<1>("h0"), cio_gpio_en_q) @[Gpio.scala 32:30]
    reg data_in_q : UInt<32>, clock with :
      reset => (UInt<1>("h0"), data_in_q) @[Gpio.scala 33:26]
    node _hw2reg_masked_out_upper_data_d_T = bits(cio_gpio_q, 31, 16) @[Gpio.scala 48:47]
    node _hw2reg_masked_out_lower_data_d_T = bits(cio_gpio_q, 15, 0) @[Gpio.scala 50:47]
    node reg2hw_masked_out_upper_data_q = gpioRegTop.io_reg2hw_masked_out_upper_data_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_masked_out_upper_mask_q = gpioRegTop.io_reg2hw_masked_out_upper_mask_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _cio_gpio_q_T = and(reg2hw_masked_out_upper_data_q, reg2hw_masked_out_upper_mask_q) @[Gpio.scala 57:39]
    node _cio_gpio_q_T_1 = not(reg2hw_masked_out_upper_mask_q) @[Gpio.scala 58:10]
    node _cio_gpio_q_T_2 = bits(cio_gpio_q, 31, 16) @[Gpio.scala 58:54]
    node _cio_gpio_q_T_3 = and(_cio_gpio_q_T_1, _cio_gpio_q_T_2) @[Gpio.scala 58:42]
    node cio_gpio_q_hi = or(_cio_gpio_q_T, _cio_gpio_q_T_3) @[Gpio.scala 57:73]
    node _cio_gpio_q_T_4 = cat(cio_gpio_q_hi, UInt<16>("h0")) @[Cat.scala 30:58]
    node reg2hw_masked_out_lower_data_q = gpioRegTop.io_reg2hw_masked_out_lower_data_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_masked_out_lower_mask_q = gpioRegTop.io_reg2hw_masked_out_lower_mask_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _cio_gpio_q_T_5 = and(reg2hw_masked_out_lower_data_q, reg2hw_masked_out_lower_mask_q) @[Gpio.scala 67:66]
    node _cio_gpio_q_T_6 = not(reg2hw_masked_out_lower_mask_q) @[Gpio.scala 68:8]
    node _cio_gpio_q_T_7 = bits(cio_gpio_q, 15, 0) @[Gpio.scala 68:52]
    node _cio_gpio_q_T_8 = and(_cio_gpio_q_T_6, _cio_gpio_q_T_7) @[Gpio.scala 68:40]
    node cio_gpio_q_lo = or(_cio_gpio_q_T_5, _cio_gpio_q_T_8) @[Gpio.scala 67:100]
    node _cio_gpio_q_T_9 = cat(UInt<16>("h0"), cio_gpio_q_lo) @[Cat.scala 30:58]
    node reg2hw_masked_out_lower_data_qe = gpioRegTop.io_reg2hw_masked_out_lower_data_qe @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _GEN_0 = mux(reg2hw_masked_out_lower_data_qe, _cio_gpio_q_T_9, cio_gpio_q) @[Gpio.scala 66:48 Gpio.scala 67:16 Gpio.scala 31:27]
    node reg2hw_masked_out_upper_data_qe = gpioRegTop.io_reg2hw_masked_out_upper_data_qe @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _GEN_1 = mux(reg2hw_masked_out_upper_data_qe, _cio_gpio_q_T_4, _GEN_0) @[Gpio.scala 55:48 Gpio.scala 56:16]
    node reg2hw_direct_out_qe = gpioRegTop.io_reg2hw_direct_out_qe @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_direct_out_q = gpioRegTop.io_reg2hw_direct_out_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _GEN_2 = mux(reg2hw_direct_out_qe, reg2hw_direct_out_q, _GEN_1) @[Gpio.scala 53:30 Gpio.scala 54:16]
    node _hw2reg_masked_oe_upper_data_d_T = bits(cio_gpio_en_q, 31, 16) @[Gpio.scala 73:49]
    node _hw2reg_masked_oe_lower_data_d_T = bits(cio_gpio_en_q, 15, 0) @[Gpio.scala 75:49]
    node reg2hw_masked_oe_upper_data_q = gpioRegTop.io_reg2hw_masked_oe_upper_data_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_masked_oe_upper_mask_q = gpioRegTop.io_reg2hw_masked_oe_upper_mask_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _cio_gpio_en_q_T = and(reg2hw_masked_oe_upper_data_q, reg2hw_masked_oe_upper_mask_q) @[Gpio.scala 81:57]
    node _cio_gpio_en_q_T_1 = not(reg2hw_masked_oe_upper_mask_q) @[Gpio.scala 82:8]
    node _cio_gpio_en_q_T_2 = bits(cio_gpio_en_q, 31, 16) @[Gpio.scala 82:54]
    node _cio_gpio_en_q_T_3 = and(_cio_gpio_en_q_T_1, _cio_gpio_en_q_T_2) @[Gpio.scala 82:39]
    node cio_gpio_en_q_hi = or(_cio_gpio_en_q_T, _cio_gpio_en_q_T_3) @[Gpio.scala 81:90]
    node _cio_gpio_en_q_T_4 = cat(cio_gpio_en_q_hi, UInt<16>("h0")) @[Cat.scala 30:58]
    node reg2hw_masked_oe_lower_data_q = gpioRegTop.io_reg2hw_masked_oe_lower_data_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_masked_oe_lower_mask_q = gpioRegTop.io_reg2hw_masked_oe_lower_mask_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _cio_gpio_en_q_T_5 = and(reg2hw_masked_oe_lower_data_q, reg2hw_masked_oe_lower_mask_q) @[Gpio.scala 84:68]
    node _cio_gpio_en_q_T_6 = not(reg2hw_masked_oe_lower_mask_q) @[Gpio.scala 85:8]
    node _cio_gpio_en_q_T_7 = bits(cio_gpio_en_q, 15, 0) @[Gpio.scala 85:54]
    node _cio_gpio_en_q_T_8 = and(_cio_gpio_en_q_T_6, _cio_gpio_en_q_T_7) @[Gpio.scala 85:39]
    node cio_gpio_en_q_lo = or(_cio_gpio_en_q_T_5, _cio_gpio_en_q_T_8) @[Gpio.scala 84:101]
    node _cio_gpio_en_q_T_9 = cat(UInt<16>("h0"), cio_gpio_en_q_lo) @[Cat.scala 30:58]
    node reg2hw_masked_oe_lower_data_qe = gpioRegTop.io_reg2hw_masked_oe_lower_data_qe @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _GEN_3 = mux(reg2hw_masked_oe_lower_data_qe, _cio_gpio_en_q_T_9, cio_gpio_en_q) @[Gpio.scala 83:47 Gpio.scala 84:19 Gpio.scala 32:30]
    node reg2hw_masked_oe_upper_data_qe = gpioRegTop.io_reg2hw_masked_oe_upper_data_qe @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _GEN_4 = mux(reg2hw_masked_oe_upper_data_qe, _cio_gpio_en_q_T_4, _GEN_3) @[Gpio.scala 80:47 Gpio.scala 81:19]
    node reg2hw_direct_oe_qe = gpioRegTop.io_reg2hw_direct_oe_qe @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_direct_oe_q = gpioRegTop.io_reg2hw_direct_oe_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _GEN_5 = mux(reg2hw_direct_oe_qe, reg2hw_direct_oe_q, _GEN_4) @[Gpio.scala 78:29 Gpio.scala 79:19]
    node _event_intr_rise_T = not(data_in_q) @[Gpio.scala 95:23]
    node data_in_d = io_cio_gpio_i @[Gpio.scala 35:23 Gpio.scala 36:13]
    node _event_intr_rise_T_1 = and(_event_intr_rise_T, data_in_d) @[Gpio.scala 95:34]
    node reg2hw_intr_ctrl_en_rising_q = gpioRegTop.io_reg2hw_intr_ctrl_en_rising_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _event_intr_rise_T_2 = and(_event_intr_rise_T_1, reg2hw_intr_ctrl_en_rising_q) @[Gpio.scala 95:47]
    node _event_intr_fall_T = not(data_in_d) @[Gpio.scala 99:35]
    node _event_intr_fall_T_1 = and(data_in_q, _event_intr_fall_T) @[Gpio.scala 99:33]
    node reg2hw_intr_ctrl_en_falling_q = gpioRegTop.io_reg2hw_intr_ctrl_en_falling_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _event_intr_fall_T_2 = and(_event_intr_fall_T_1, reg2hw_intr_ctrl_en_falling_q) @[Gpio.scala 99:47]
    node reg2hw_intr_ctrl_en_lvlHigh_q = gpioRegTop.io_reg2hw_intr_ctrl_en_lvlHigh_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _event_intr_acthigh_T = and(data_in_d, reg2hw_intr_ctrl_en_lvlHigh_q) @[Gpio.scala 105:35]
    node _event_intr_actlow_T = not(data_in_d) @[Gpio.scala 111:24]
    node reg2hw_intr_ctrl_en_lvlLow_q = gpioRegTop.io_reg2hw_intr_ctrl_en_lvlLow_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node _event_intr_actlow_T_1 = and(_event_intr_actlow_T, reg2hw_intr_ctrl_en_lvlLow_q) @[Gpio.scala 111:35]
    node event_intr_rise = _event_intr_rise_T_2 @[Gpio.scala 88:85 Gpio.scala 95:19]
    node event_intr_fall = _event_intr_fall_T_2 @[Gpio.scala 88:85 Gpio.scala 99:19]
    node _event_intr_combined_T = or(event_intr_rise, event_intr_fall) @[Gpio.scala 113:42]
    node event_intr_acthigh = _event_intr_acthigh_T @[Gpio.scala 88:85 Gpio.scala 105:22]
    node _event_intr_combined_T_1 = or(_event_intr_combined_T, event_intr_acthigh) @[Gpio.scala 113:60]
    node event_intr_actlow = _event_intr_actlow_T_1 @[Gpio.scala 88:85 Gpio.scala 111:21]
    node _event_intr_combined_T_2 = or(_event_intr_combined_T_1, event_intr_actlow) @[Gpio.scala 113:81]
    node reg2hw_intr_state_q = gpioRegTop.io_reg2hw_intr_state_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_intr_enable_q = gpioRegTop.io_reg2hw_intr_enable_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_intr_test_q = gpioRegTop.io_reg2hw_intr_test_q @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_intr_test_qe = gpioRegTop.io_reg2hw_intr_test_qe @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_masked_out_lower_mask_qe = gpioRegTop.io_reg2hw_masked_out_lower_mask_qe @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_masked_out_upper_mask_qe = gpioRegTop.io_reg2hw_masked_out_upper_mask_qe @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_masked_oe_lower_mask_qe = gpioRegTop.io_reg2hw_masked_oe_lower_mask_qe @[Gpio.scala 20:20 Gpio.scala 28:10]
    node reg2hw_masked_oe_upper_mask_qe = gpioRegTop.io_reg2hw_masked_oe_upper_mask_qe @[Gpio.scala 20:20 Gpio.scala 28:10]
    node hw2reg_intr_state_d = intr_hw.io_hw2reg_intr_state_d_o @[Gpio.scala 21:20 Gpio.scala 122:23]
    node hw2reg_intr_state_de = intr_hw.io_hw2reg_intr_state_de_o @[Gpio.scala 21:20 Gpio.scala 121:24]
    node hw2reg_data_in_d = data_in_d @[Gpio.scala 21:20 Gpio.scala 41:20]
    node hw2reg_data_in_de = UInt<1>("h1") @[Gpio.scala 21:20 Gpio.scala 40:21]
    node hw2reg_direct_out_d = cio_gpio_q @[Gpio.scala 21:20 Gpio.scala 47:23]
    node hw2reg_masked_out_lower_data_d = _hw2reg_masked_out_lower_data_d_T @[Gpio.scala 21:20 Gpio.scala 50:34]
    node hw2reg_masked_out_lower_mask_d = UInt<16>("h0") @[Gpio.scala 21:20 Gpio.scala 51:34]
    node hw2reg_masked_out_upper_data_d = _hw2reg_masked_out_upper_data_d_T @[Gpio.scala 21:20 Gpio.scala 48:34]
    node hw2reg_masked_out_upper_mask_d = UInt<16>("h0") @[Gpio.scala 21:20 Gpio.scala 49:34]
    node hw2reg_direct_oe_d = cio_gpio_en_q @[Gpio.scala 21:20 Gpio.scala 72:22]
    node hw2reg_masked_oe_lower_data_d = _hw2reg_masked_oe_lower_data_d_T @[Gpio.scala 21:20 Gpio.scala 75:33]
    node hw2reg_masked_oe_lower_mask_d = UInt<16>("h0") @[Gpio.scala 21:20 Gpio.scala 76:33]
    node hw2reg_masked_oe_upper_data_d = _hw2reg_masked_oe_upper_data_d_T @[Gpio.scala 21:20 Gpio.scala 73:33]
    node hw2reg_masked_oe_upper_mask_d = UInt<16>("h0") @[Gpio.scala 21:20 Gpio.scala 74:33]
    node event_intr_combined = _event_intr_combined_T_2 @[Gpio.scala 89:33 Gpio.scala 113:23]
    io_req_ready <= gpioRegTop.io_req_ready @[Gpio.scala 25:21]
    io_rsp_valid <= gpioRegTop.io_rsp_valid @[Gpio.scala 26:10]
    io_rsp_bits_dataResponse <= gpioRegTop.io_rsp_bits_dataResponse @[Gpio.scala 26:10]
    io_rsp_bits_error <= gpioRegTop.io_rsp_bits_error @[Gpio.scala 26:10]
    io_rsp_bits_ackWrite <= gpioRegTop.io_rsp_bits_ackWrite @[Gpio.scala 26:10]
    io_cio_gpio_o <= cio_gpio_q @[Gpio.scala 44:17]
    io_cio_gpio_en_o <= cio_gpio_en_q @[Gpio.scala 45:20]
    io_intr_gpio_o <= intr_hw.io_intr_o @[Gpio.scala 123:18]
    gpioRegTop.clock <= clock
    gpioRegTop.reset <= reset
    gpioRegTop.io_req_valid <= io_req_valid @[Gpio.scala 25:21]
    gpioRegTop.io_req_bits_addrRequest <= io_req_bits_addrRequest @[Gpio.scala 25:21]
    gpioRegTop.io_req_bits_dataRequest <= io_req_bits_dataRequest @[Gpio.scala 25:21]
    gpioRegTop.io_req_bits_activeByteLane <= io_req_bits_activeByteLane @[Gpio.scala 25:21]
    gpioRegTop.io_req_bits_isWrite <= io_req_bits_isWrite @[Gpio.scala 25:21]
    gpioRegTop.io_rsp_ready <= io_rsp_ready @[Gpio.scala 26:10]
    gpioRegTop.io_hw2reg_intr_state_d <= hw2reg_intr_state_d @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_intr_state_de <= hw2reg_intr_state_de @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_data_in_d <= hw2reg_data_in_d @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_data_in_de <= hw2reg_data_in_de @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_direct_out_d <= hw2reg_direct_out_d @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_masked_out_lower_data_d <= hw2reg_masked_out_lower_data_d @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_masked_out_lower_mask_d <= hw2reg_masked_out_lower_mask_d @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_masked_out_upper_data_d <= hw2reg_masked_out_upper_data_d @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_masked_out_upper_mask_d <= hw2reg_masked_out_upper_mask_d @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_direct_oe_d <= hw2reg_direct_oe_d @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_masked_oe_lower_data_d <= hw2reg_masked_oe_lower_data_d @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_masked_oe_lower_mask_d <= hw2reg_masked_oe_lower_mask_d @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_masked_oe_upper_data_d <= hw2reg_masked_oe_upper_data_d @[Gpio.scala 29:10]
    gpioRegTop.io_hw2reg_masked_oe_upper_mask_d <= hw2reg_masked_oe_upper_mask_d @[Gpio.scala 29:10]
    cio_gpio_q <= mux(reset, UInt<32>("h0"), _GEN_2) @[Gpio.scala 31:27 Gpio.scala 31:27]
    cio_gpio_en_q <= mux(reset, UInt<32>("h0"), _GEN_5) @[Gpio.scala 32:30 Gpio.scala 32:30]
    data_in_q <= mux(reset, UInt<32>("h0"), data_in_d) @[Gpio.scala 33:26 Gpio.scala 33:26 Gpio.scala 37:13]
    intr_hw.clock <= clock
    intr_hw.reset <= reset
    intr_hw.io_event_intr_i <= event_intr_combined @[Gpio.scala 116:27]
    intr_hw.io_reg2hw_intr_enable_q_i <= reg2hw_intr_enable_q @[Gpio.scala 117:37]
    intr_hw.io_reg2hw_intr_test_q_i <= reg2hw_intr_test_q @[Gpio.scala 118:35]
    intr_hw.io_reg2hw_intr_test_qe_i <= reg2hw_intr_test_qe @[Gpio.scala 119:36]
    intr_hw.io_reg2hw_intr_state_q_i <= reg2hw_intr_state_q @[Gpio.scala 120:36]

  module Protocol :
    input clock : Clock
    input reset : UInt<1>
    input io_miso : UInt<1>
    output io_mosi : UInt<1>
    output io_ss : UInt<1>
    output io_sck : UInt<1>
    output io_data_in_ready : UInt<1>
    input io_data_in_valid : UInt<1>
    input io_data_in_bits : UInt<32>
    input io_data_out_ready : UInt<1>
    output io_data_out_valid : UInt<1>
    output io_data_out_bits : UInt<32>
    input io_CPOL : UInt<1>
    input io_CPHA : UInt<1>

    reg state : UInt<1>, clock with :
      reset => (UInt<1>("h0"), state) @[Protocol.scala 29:24]
    reg miso_dataReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), miso_dataReg) @[Protocol.scala 31:31]
    reg count : UInt<7>, clock with :
      reset => (UInt<1>("h0"), count) @[Protocol.scala 32:24]
    reg dataReg : UInt<64>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[Protocol.scala 33:26]
    node _clk_T = asUInt(clock) @[Protocol.scala 35:36]
    node _clk_T_1 = bits(_clk_T, 0, 0) @[Protocol.scala 35:38]
    node _io_sck_T = eq(state, UInt<1>("h1")) @[Protocol.scala 36:25]
    node clk = _clk_T_1
    node _io_sck_T_1 = not(clk) @[Protocol.scala 36:44]
    node CPOL = io_CPOL
    node _io_sck_T_2 = mux(CPOL, _io_sck_T_1, clk) @[Protocol.scala 36:38]
    node _io_sck_T_3 = mux(_io_sck_T, _io_sck_T_2, UInt<1>("h0")) @[Protocol.scala 36:18]
    node _T = eq(UInt<1>("h0"), state) @[Conditional.scala 37:30]
    node dataReg_lo = mux(UInt<1>("h0"), UInt<32>("hffffffff"), UInt<32>("h0")) @[Bitwise.scala 72:12]
    node _dataReg_T = cat(io_data_in_bits, dataReg_lo) @[Cat.scala 30:58]
    node _GEN_0 = mux(io_data_in_valid, _dataReg_T, dataReg) @[Protocol.scala 50:59 Protocol.scala 51:25 Protocol.scala 33:26]
    node _GEN_1 = mux(io_data_in_valid, UInt<1>("h1"), state) @[Protocol.scala 50:59 Protocol.scala 52:23 Protocol.scala 29:24]
    node _T_1 = eq(UInt<1>("h1"), state) @[Conditional.scala 37:30]
    node _T_2 = eq(count, UInt<7>("h40")) @[Protocol.scala 61:25]
    node _io_mosi_T = bits(dataReg, 63, 63) @[Protocol.scala 68:35]
    node _dataReg_T_1 = shl(dataReg, 1) @[Protocol.scala 69:36]
    node _count_T = add(count, UInt<1>("h1")) @[Protocol.scala 70:32]
    node _count_T_1 = tail(_count_T, 1) @[Protocol.scala 70:32]
    node _GEN_2 = mux(_T_2, UInt<1>("h1"), UInt<1>("h0")) @[Protocol.scala 61:48 Protocol.scala 62:34 Protocol.scala 40:22]
    node _GEN_3 = mux(_T_2, UInt<1>("h0"), state) @[Protocol.scala 61:48 Protocol.scala 64:23 Protocol.scala 29:24]
    node _GEN_4 = mux(_T_2, UInt<1>("h0"), _count_T_1) @[Protocol.scala 61:48 Protocol.scala 65:23 Protocol.scala 70:23]
    node _GEN_5 = mux(_T_2, UInt<1>("h0"), _io_mosi_T) @[Protocol.scala 61:48 Protocol.scala 44:13 Protocol.scala 68:25]
    node _GEN_6 = mux(_T_2, dataReg, _dataReg_T_1) @[Protocol.scala 61:48 Protocol.scala 33:26 Protocol.scala 69:25]
    node _GEN_7 = mux(_T_1, _GEN_2, UInt<1>("h0")) @[Conditional.scala 39:67 Protocol.scala 40:22]
    node _GEN_8 = mux(_T_1, _GEN_2, UInt<1>("h1")) @[Conditional.scala 39:67 Protocol.scala 43:11]
    node _GEN_9 = mux(_T_1, _GEN_3, state) @[Conditional.scala 39:67 Protocol.scala 29:24]
    node _GEN_10 = mux(_T_1, _GEN_4, count) @[Conditional.scala 39:67 Protocol.scala 32:24]
    node _GEN_11 = mux(_T_1, _GEN_5, UInt<1>("h0")) @[Conditional.scala 39:67 Protocol.scala 44:13]
    node _GEN_12 = mux(_T_1, _GEN_6, dataReg) @[Conditional.scala 39:67 Protocol.scala 33:26]
    node _GEN_13 = mux(_T, UInt<1>("h1"), _GEN_7) @[Conditional.scala 40:58 Protocol.scala 49:30]
    node _GEN_14 = mux(_T, _GEN_0, _GEN_12) @[Conditional.scala 40:58]
    node _GEN_15 = mux(_T, _GEN_1, _GEN_9) @[Conditional.scala 40:58]
    node _GEN_16 = mux(_T, UInt<1>("h1"), _GEN_8) @[Conditional.scala 40:58 Protocol.scala 43:11]
    node _GEN_17 = mux(_T, count, _GEN_10) @[Conditional.scala 40:58 Protocol.scala 32:24]
    node _GEN_18 = mux(_T, UInt<1>("h0"), _GEN_11) @[Conditional.scala 40:58 Protocol.scala 44:13]
    reg count1 : UInt<7>, clock with :
      reset => (UInt<1>("h0"), count1) @[Protocol.scala 76:25]
    node _T_3 = eq(UInt<1>("h1"), state) @[Conditional.scala 37:30]
    node _T_4 = eq(count1, UInt<7>("h40")) @[Protocol.scala 80:26]
    node _miso_dataReg_T = shl(miso_dataReg, 1) @[Protocol.scala 85:46]
    node _miso_dataReg_T_1 = or(_miso_dataReg_T, io_miso) @[Protocol.scala 85:51]
    node _count1_T = add(count1, UInt<1>("h1")) @[Protocol.scala 86:34]
    node _count1_T_1 = tail(_count1_T, 1) @[Protocol.scala 86:34]
    node _GEN_19 = mux(_T_4, miso_dataReg, UInt<1>("h0")) @[Protocol.scala 80:73 Protocol.scala 81:34 Protocol.scala 42:22]
    node _GEN_20 = mux(_T_4, UInt<1>("h1"), UInt<1>("h0")) @[Protocol.scala 80:73 Protocol.scala 82:35 Protocol.scala 41:23]
    node _GEN_21 = mux(_T_4, UInt<1>("h0"), _count1_T_1) @[Protocol.scala 80:73 Protocol.scala 83:24 Protocol.scala 86:24]
    node _GEN_22 = mux(_T_4, miso_dataReg, _miso_dataReg_T_1) @[Protocol.scala 80:73 Protocol.scala 31:31 Protocol.scala 85:30]
    node _GEN_23 = mux(_T_3, UInt<1>("h0"), _GEN_16) @[Conditional.scala 40:58 Protocol.scala 79:19]
    node _GEN_24 = mux(_T_3, _GEN_19, UInt<1>("h0")) @[Conditional.scala 40:58 Protocol.scala 42:22]
    node _GEN_25 = mux(_T_3, _GEN_20, UInt<1>("h0")) @[Conditional.scala 40:58 Protocol.scala 41:23]
    node _GEN_26 = mux(_T_3, _GEN_21, count1) @[Conditional.scala 40:58 Protocol.scala 76:25]
    node _GEN_27 = mux(_T_3, _GEN_22, miso_dataReg) @[Conditional.scala 40:58 Protocol.scala 31:31]
    node CPHA = io_CPHA
    io_mosi <= _GEN_18
    io_ss <= _GEN_23
    io_sck <= _io_sck_T_3 @[Protocol.scala 36:12]
    io_data_in_ready <= _GEN_13
    io_data_out_valid <= _GEN_25
    io_data_out_bits <= _GEN_24
    state <= mux(reset, UInt<1>("h0"), _GEN_15) @[Protocol.scala 29:24 Protocol.scala 29:24]
    miso_dataReg <= mux(reset, UInt<32>("h0"), bits(_GEN_27, 31, 0)) @[Protocol.scala 31:31 Protocol.scala 31:31]
    count <= mux(reset, UInt<7>("h0"), _GEN_17) @[Protocol.scala 32:24 Protocol.scala 32:24]
    dataReg <= mux(reset, UInt<64>("h0"), bits(_GEN_14, 63, 0)) @[Protocol.scala 33:26 Protocol.scala 33:26]
    count1 <= mux(reset, UInt<7>("h0"), _GEN_26) @[Protocol.scala 76:25 Protocol.scala 76:25]

  module Spi :
    input clock : Clock
    input reset : UInt<1>
    output io_req_ready : UInt<1>
    input io_req_valid : UInt<1>
    input io_req_bits_addrRequest : UInt<32>
    input io_req_bits_dataRequest : UInt<32>
    input io_req_bits_activeByteLane : UInt<4>
    input io_req_bits_isWrite : UInt<1>
    input io_rsp_ready : UInt<1>
    output io_rsp_valid : UInt<1>
    output io_rsp_bits_dataResponse : UInt<32>
    output io_rsp_bits_error : UInt<1>
    output io_rsp_bits_ackWrite : UInt<1>
    output io_cs_n : UInt<1>
    output io_sclk : UInt<1>
    output io_mosi : UInt<1>
    input io_miso : UInt<1>

    inst spiProtocol of Protocol @[Spi.scala 112:29]
    reg ControlReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), ControlReg) @[Spi.scala 29:29]
    reg TxDataReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), TxDataReg) @[Spi.scala 30:31]
    reg TxDataValidReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), TxDataValidReg) @[Spi.scala 31:33]
    reg RxDataReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), RxDataReg) @[Spi.scala 32:31]
    reg RxDataValidReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), RxDataValidReg) @[Spi.scala 33:33]
    node _WIRE_1 = io_req_bits_activeByteLane
    node _T = bits(_WIRE_1, 0, 0) @[Spi.scala 36:54]
    node _T_1 = bits(_WIRE_1, 1, 1) @[Spi.scala 36:54]
    node _T_2 = bits(_WIRE_1, 2, 2) @[Spi.scala 36:54]
    node _T_3 = bits(_WIRE_1, 3, 3) @[Spi.scala 36:54]
    node _WIRE__0 = _T @[Spi.scala 36:54 Spi.scala 36:54]
    node _T_4 = bits(_WIRE__0, 0, 0) @[Bitwise.scala 72:15]
    node _T_5 = mux(_T_4, UInt<8>("hff"), UInt<8>("h0")) @[Bitwise.scala 72:12]
    node _WIRE__1 = _T_1 @[Spi.scala 36:54 Spi.scala 36:54]
    node _T_6 = bits(_WIRE__1, 0, 0) @[Bitwise.scala 72:15]
    node _T_7 = mux(_T_6, UInt<8>("hff"), UInt<8>("h0")) @[Bitwise.scala 72:12]
    node _WIRE__2 = _T_2 @[Spi.scala 36:54 Spi.scala 36:54]
    node _T_8 = bits(_WIRE__2, 0, 0) @[Bitwise.scala 72:15]
    node _T_9 = mux(_T_8, UInt<8>("hff"), UInt<8>("h0")) @[Bitwise.scala 72:12]
    node _WIRE__3 = _T_3 @[Spi.scala 36:54 Spi.scala 36:54]
    node _T_10 = bits(_WIRE__3, 0, 0) @[Bitwise.scala 72:15]
    node _T_11 = mux(_T_10, UInt<8>("hff"), UInt<8>("h0")) @[Bitwise.scala 72:12]
    node _T_12 = bits(io_req_bits_addrRequest, 3, 0) @[Spi.scala 42:34]
    node _T_13 = eq(_T_12, UInt<1>("h0")) @[Spi.scala 42:40]
    node _T_14 = eq(io_req_bits_isWrite, UInt<1>("h1")) @[Spi.scala 42:71]
    node _T_15 = and(_T_13, _T_14) @[Spi.scala 42:48]
    node maskedData_1 = _T_7 @[Spi.scala 35:26 Spi.scala 36:16]
    node maskedData_0 = _T_5 @[Spi.scala 35:26 Spi.scala 36:16]
    node ControlReg_lo = cat(maskedData_1, maskedData_0) @[Spi.scala 43:78]
    node maskedData_3 = _T_11 @[Spi.scala 35:26 Spi.scala 36:16]
    node maskedData_2 = _T_9 @[Spi.scala 35:26 Spi.scala 36:16]
    node ControlReg_hi = cat(maskedData_3, maskedData_2) @[Spi.scala 43:78]
    node _ControlReg_T = cat(ControlReg_hi, ControlReg_lo) @[Spi.scala 43:78]
    node _ControlReg_T_1 = and(io_req_bits_dataRequest, _ControlReg_T) @[Spi.scala 43:65]
    node _ControlReg_T_2 = mux(io_req_valid, _ControlReg_T_1, UInt<1>("h0")) @[Spi.scala 43:26]
    node _io_rsp_bits_dataResponse_T = mux(io_rsp_ready, io_req_bits_dataRequest, UInt<1>("h0")) @[Spi.scala 45:48]
    reg io_rsp_bits_dataResponse_REG : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_rsp_bits_dataResponse_REG) @[Spi.scala 45:44]
    reg io_rsp_valid_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_rsp_valid_REG) @[Spi.scala 46:32]
    node _T_16 = bits(io_req_bits_addrRequest, 3, 0) @[Spi.scala 52:38]
    node _T_17 = eq(_T_16, UInt<1>("h0")) @[Spi.scala 52:44]
    node _T_18 = eq(io_req_bits_isWrite, UInt<1>("h0")) @[Spi.scala 52:75]
    node _T_19 = and(_T_17, _T_18) @[Spi.scala 52:52]
    node _io_rsp_bits_dataResponse_T_1 = mux(io_rsp_ready, ControlReg, UInt<1>("h0")) @[Spi.scala 53:48]
    reg io_rsp_bits_dataResponse_REG_1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_rsp_bits_dataResponse_REG_1) @[Spi.scala 53:44]
    node _io_rsp_valid_T = mux(io_req_valid, UInt<1>("h1"), UInt<1>("h0")) @[Spi.scala 54:36]
    reg io_rsp_valid_REG_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_rsp_valid_REG_1) @[Spi.scala 54:32]
    node _T_20 = bits(io_req_bits_addrRequest, 3, 0) @[Spi.scala 60:38]
    node _T_21 = eq(_T_20, UInt<3>("h4")) @[Spi.scala 60:44]
    node _T_22 = eq(io_req_bits_isWrite, UInt<1>("h1")) @[Spi.scala 60:75]
    node _T_23 = and(_T_21, _T_22) @[Spi.scala 60:52]
    node _T_24 = bits(ControlReg, 4, 2) @[Spi.scala 61:24]
    node _T_25 = eq(_T_24, UInt<1>("h0")) @[Spi.scala 61:30]
    node TxDataReg_lo = cat(maskedData_1, maskedData_0) @[Spi.scala 62:100]
    node TxDataReg_hi = cat(maskedData_3, maskedData_2) @[Spi.scala 62:100]
    node _TxDataReg_T = cat(TxDataReg_hi, TxDataReg_lo) @[Spi.scala 62:100]
    node _TxDataReg_T_1 = and(io_req_bits_dataRequest, _TxDataReg_T) @[Spi.scala 62:87]
    node TxDataReg_lo_1 = bits(_TxDataReg_T_1, 23, 0) @[Spi.scala 62:107]
    node _TxDataReg_T_2 = cat(UInt<2>("h3"), TxDataReg_lo_1) @[Cat.scala 30:58]
    node _TxDataReg_T_3 = mux(io_req_valid, _TxDataReg_T_2, UInt<1>("h0")) @[Spi.scala 62:29]
    node _T_26 = bits(ControlReg, 4, 2) @[Spi.scala 65:29]
    node _T_27 = eq(_T_26, UInt<1>("h1")) @[Spi.scala 65:35]
    node TxDataReg_lo_2 = mux(UInt<1>("h0"), UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 72:12]
    node _TxDataReg_T_4 = cat(UInt<3>("h6"), TxDataReg_lo_2) @[Cat.scala 30:58]
    node _TxDataReg_T_5 = mux(io_req_valid, _TxDataReg_T_4, UInt<1>("h0")) @[Spi.scala 66:29]
    node _T_28 = bits(ControlReg, 4, 2) @[Spi.scala 69:29]
    node _T_29 = eq(_T_28, UInt<2>("h2")) @[Spi.scala 69:35]
    node TxDataReg_lo_3 = cat(maskedData_1, maskedData_0) @[Spi.scala 70:100]
    node TxDataReg_hi_1 = cat(maskedData_3, maskedData_2) @[Spi.scala 70:100]
    node _TxDataReg_T_6 = cat(TxDataReg_hi_1, TxDataReg_lo_3) @[Spi.scala 70:100]
    node _TxDataReg_T_7 = and(io_req_bits_dataRequest, _TxDataReg_T_6) @[Spi.scala 70:87]
    node TxDataReg_lo_4 = bits(_TxDataReg_T_7, 23, 0) @[Spi.scala 70:107]
    node _TxDataReg_T_8 = cat(UInt<2>("h2"), TxDataReg_lo_4) @[Cat.scala 30:58]
    node _TxDataReg_T_9 = mux(io_req_valid, _TxDataReg_T_8, UInt<1>("h0")) @[Spi.scala 70:29]
    node _T_30 = bits(ControlReg, 4, 2) @[Spi.scala 73:29]
    node _T_31 = eq(_T_30, UInt<2>("h3")) @[Spi.scala 73:35]
    node TxDataReg_lo_5 = cat(maskedData_1, maskedData_0) @[Spi.scala 74:81]
    node TxDataReg_hi_2 = cat(maskedData_3, maskedData_2) @[Spi.scala 74:81]
    node _TxDataReg_T_10 = cat(TxDataReg_hi_2, TxDataReg_lo_5) @[Spi.scala 74:81]
    node _TxDataReg_T_11 = and(io_req_bits_dataRequest, _TxDataReg_T_10) @[Spi.scala 74:68]
    node _TxDataReg_T_12 = mux(io_req_valid, _TxDataReg_T_11, UInt<1>("h0")) @[Spi.scala 74:29]
    node _T_32 = bits(ControlReg, 4, 2) @[Spi.scala 77:29]
    node _T_33 = eq(_T_32, UInt<3>("h4")) @[Spi.scala 77:35]
    node TxDataReg_lo_6 = mux(UInt<1>("h0"), UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 72:12]
    node _TxDataReg_T_13 = cat(UInt<3>("h4"), TxDataReg_lo_6) @[Cat.scala 30:58]
    node _TxDataReg_T_14 = mux(io_req_valid, _TxDataReg_T_13, UInt<1>("h0")) @[Spi.scala 78:29]
    node _GEN_0 = mux(_T_33, _TxDataReg_T_14, TxDataReg) @[Spi.scala 77:43 Spi.scala 78:23 Spi.scala 30:31]
    node _GEN_1 = mux(_T_33, io_req_valid, TxDataValidReg) @[Spi.scala 77:43 Spi.scala 79:28 Spi.scala 31:33]
    node _GEN_2 = mux(_T_31, _TxDataReg_T_12, _GEN_0) @[Spi.scala 73:43 Spi.scala 74:23]
    node _GEN_3 = mux(_T_31, io_req_valid, _GEN_1) @[Spi.scala 73:43 Spi.scala 75:28]
    node _GEN_4 = mux(_T_29, _TxDataReg_T_9, _GEN_2) @[Spi.scala 69:43 Spi.scala 70:23]
    node _GEN_5 = mux(_T_29, io_req_valid, _GEN_3) @[Spi.scala 69:43 Spi.scala 71:28]
    node _GEN_6 = mux(_T_27, _TxDataReg_T_5, _GEN_4) @[Spi.scala 65:43 Spi.scala 66:23]
    node _GEN_7 = mux(_T_27, io_req_valid, _GEN_5) @[Spi.scala 65:43 Spi.scala 67:28]
    node _GEN_8 = mux(_T_25, _TxDataReg_T_3, _GEN_6) @[Spi.scala 61:38 Spi.scala 62:23]
    node _GEN_9 = mux(_T_25, io_req_valid, _GEN_7) @[Spi.scala 61:38 Spi.scala 63:28]
    node _io_rsp_bits_dataResponse_T_2 = mux(io_rsp_ready, io_req_bits_addrRequest, UInt<1>("h0")) @[Spi.scala 83:48]
    reg io_rsp_bits_dataResponse_REG_2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_rsp_bits_dataResponse_REG_2) @[Spi.scala 83:44]
    reg io_rsp_valid_REG_2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_rsp_valid_REG_2) @[Spi.scala 84:32]
    node _T_34 = bits(io_req_bits_addrRequest, 3, 0) @[Spi.scala 89:38]
    node _T_35 = eq(_T_34, UInt<3>("h4")) @[Spi.scala 89:44]
    node _T_36 = eq(io_req_bits_isWrite, UInt<1>("h0")) @[Spi.scala 89:75]
    node _T_37 = and(_T_35, _T_36) @[Spi.scala 89:52]
    node _io_rsp_bits_dataResponse_T_3 = mux(io_rsp_ready, TxDataReg, UInt<1>("h0")) @[Spi.scala 90:48]
    reg io_rsp_bits_dataResponse_REG_3 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_rsp_bits_dataResponse_REG_3) @[Spi.scala 90:44]
    reg io_rsp_valid_REG_3 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_rsp_valid_REG_3) @[Spi.scala 91:32]
    node _T_38 = bits(io_req_bits_addrRequest, 3, 0) @[Spi.scala 96:38]
    node _T_39 = eq(_T_38, UInt<4>("h8")) @[Spi.scala 96:44]
    node _T_40 = eq(io_req_bits_isWrite, UInt<1>("h0")) @[Spi.scala 96:75]
    node _T_41 = and(_T_39, _T_40) @[Spi.scala 96:52]
    node _io_rsp_bits_dataResponse_T_4 = mux(io_rsp_ready, RxDataReg, UInt<1>("h0")) @[Spi.scala 97:48]
    reg io_rsp_bits_dataResponse_REG_4 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_rsp_bits_dataResponse_REG_4) @[Spi.scala 97:44]
    node _GEN_10 = mux(_T_41, io_rsp_bits_dataResponse_REG_4, io_req_bits_addrRequest) @[Spi.scala 96:83 Spi.scala 97:34 Spi.scala 108:34]
    node _GEN_11 = validif(_T_41, RxDataValidReg) @[Spi.scala 96:83 Spi.scala 98:22]
    node _GEN_12 = mux(_T_37, io_rsp_bits_dataResponse_REG_3, _GEN_10) @[Spi.scala 89:83 Spi.scala 90:34]
    node _GEN_13 = mux(_T_37, io_rsp_valid_REG_3, _GEN_11) @[Spi.scala 89:83 Spi.scala 91:22]
    node _GEN_14 = mux(_T_23, _GEN_8, TxDataReg) @[Spi.scala 60:83 Spi.scala 30:31]
    node _GEN_15 = mux(_T_23, _GEN_9, TxDataValidReg) @[Spi.scala 60:83 Spi.scala 31:33]
    node _GEN_16 = mux(_T_23, io_rsp_bits_dataResponse_REG_2, _GEN_12) @[Spi.scala 60:83 Spi.scala 83:34]
    node _GEN_17 = mux(_T_23, io_rsp_valid_REG_2, _GEN_13) @[Spi.scala 60:83 Spi.scala 84:22]
    node _GEN_18 = mux(_T_19, io_rsp_bits_dataResponse_REG_1, _GEN_16) @[Spi.scala 52:83 Spi.scala 53:34]
    node _GEN_19 = mux(_T_19, io_rsp_valid_REG_1, _GEN_17) @[Spi.scala 52:83 Spi.scala 54:22]
    node _GEN_20 = mux(_T_19, TxDataReg, _GEN_14) @[Spi.scala 52:83 Spi.scala 30:31]
    node _GEN_21 = mux(_T_19, TxDataValidReg, _GEN_15) @[Spi.scala 52:83 Spi.scala 31:33]
    node _GEN_22 = mux(_T_15, _ControlReg_T_2, ControlReg) @[Spi.scala 42:79 Spi.scala 43:20 Spi.scala 29:29]
    node _GEN_23 = mux(_T_15, io_rsp_bits_dataResponse_REG, _GEN_18) @[Spi.scala 42:79 Spi.scala 45:34]
    node _GEN_24 = mux(_T_15, io_rsp_valid_REG, _GEN_19) @[Spi.scala 42:79 Spi.scala 46:22]
    node _GEN_25 = mux(_T_15, TxDataReg, _GEN_20) @[Spi.scala 42:79 Spi.scala 30:31]
    node _GEN_26 = mux(_T_15, TxDataValidReg, _GEN_21) @[Spi.scala 42:79 Spi.scala 31:33]
    node _spiProtocol_io_CPOL_T = bits(ControlReg, 1, 1) @[Spi.scala 116:38]
    node _spiProtocol_io_CPHA_T = bits(ControlReg, 0, 0) @[Spi.scala 117:38]
    node _GEN_27 = mux(spiProtocol.io_data_out_valid, spiProtocol.io_data_out_bits, RxDataReg) @[Spi.scala 121:40 Spi.scala 122:19 Spi.scala 32:31]
    node _GEN_28 = mux(spiProtocol.io_data_out_valid, UInt<1>("h1"), RxDataValidReg) @[Spi.scala 121:40 Spi.scala 123:24 Spi.scala 33:33]
    node _wireAddr_T = bits(io_req_bits_addrRequest, 3, 0) @[Spi.scala 130:52]
    node wireAddr = _wireAddr_T
    node _addr_hit_0_T = eq(wireAddr, UInt<1>("h0")) @[Spi.scala 137:39]
    node _addr_hit_1_T = eq(wireAddr, UInt<3>("h4")) @[Spi.scala 137:39]
    node _addr_hit_2_T = eq(wireAddr, UInt<4>("h8")) @[Spi.scala 137:39]
    node addr_hit_0 = _addr_hit_0_T @[Spi.scala 128:24 Spi.scala 137:27]
    node addr_hit_1 = _addr_hit_1_T @[Spi.scala 128:24 Spi.scala 137:27]
    node _addr_miss_T = or(addr_hit_0, addr_hit_1) @[Spi.scala 145:37]
    node addr_hit_2 = _addr_hit_2_T @[Spi.scala 128:24 Spi.scala 137:27]
    node _addr_miss_T_1 = or(_addr_miss_T, addr_hit_2) @[Spi.scala 145:37]
    node _addr_miss_T_2 = not(_addr_miss_T_1) @[Spi.scala 145:18]
    node _T_42 = eq(wireAddr, UInt<4>("h8")) @[Spi.scala 146:19]
    node _T_43 = and(_T_42, io_req_bits_isWrite) @[Spi.scala 146:27]
    reg io_rsp_bits_error_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_rsp_bits_error_REG) @[Spi.scala 146:78]
    node addr_miss = _addr_miss_T_2 @[Spi.scala 131:25 Spi.scala 145:15]
    node _io_rsp_bits_error_T = and(io_req_valid, addr_miss) @[Spi.scala 147:58]
    reg io_rsp_bits_error_REG_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_rsp_bits_error_REG_1) @[Spi.scala 147:44]
    node _GEN_29 = mux(_T_43, io_rsp_bits_error_REG, io_rsp_bits_error_REG_1) @[Spi.scala 146:49 Spi.scala 146:68 Spi.scala 147:34]
    io_req_ready <= UInt<1>("h1") @[Spi.scala 38:18]
    io_rsp_valid <= _GEN_24
    io_rsp_bits_dataResponse <= _GEN_23
    io_rsp_bits_error <= _GEN_29
    io_rsp_bits_ackWrite <= UInt<1>("h1") @[Spi.scala 40:26]
    io_cs_n <= spiProtocol.io_ss @[Spi.scala 120:121]
    io_sclk <= spiProtocol.io_sck @[Spi.scala 120:121]
    io_mosi <= spiProtocol.io_mosi @[Spi.scala 120:121]
    ControlReg <= mux(reset, UInt<32>("h0"), _GEN_22) @[Spi.scala 29:29 Spi.scala 29:29]
    TxDataReg <= mux(reset, UInt<32>("h0"), _GEN_25) @[Spi.scala 30:31 Spi.scala 30:31]
    TxDataValidReg <= mux(reset, UInt<1>("h0"), _GEN_26) @[Spi.scala 31:33 Spi.scala 31:33]
    RxDataReg <= mux(reset, UInt<32>("h0"), _GEN_27) @[Spi.scala 32:31 Spi.scala 32:31]
    RxDataValidReg <= mux(reset, UInt<1>("h0"), _GEN_28) @[Spi.scala 33:33 Spi.scala 33:33]
    io_rsp_bits_dataResponse_REG <= _io_rsp_bits_dataResponse_T @[Spi.scala 45:44]
    io_rsp_valid_REG <= io_req_valid @[Spi.scala 46:32]
    io_rsp_bits_dataResponse_REG_1 <= _io_rsp_bits_dataResponse_T_1 @[Spi.scala 53:44]
    io_rsp_valid_REG_1 <= _io_rsp_valid_T @[Spi.scala 54:32]
    io_rsp_bits_dataResponse_REG_2 <= _io_rsp_bits_dataResponse_T_2 @[Spi.scala 83:44]
    io_rsp_valid_REG_2 <= UInt<1>("h1") @[Spi.scala 84:32]
    io_rsp_bits_dataResponse_REG_3 <= _io_rsp_bits_dataResponse_T_3 @[Spi.scala 90:44]
    io_rsp_valid_REG_3 <= io_req_valid @[Spi.scala 91:32]
    io_rsp_bits_dataResponse_REG_4 <= _io_rsp_bits_dataResponse_T_4 @[Spi.scala 97:44]
    spiProtocol.clock <= clock
    spiProtocol.reset <= reset
    spiProtocol.io_miso <= io_miso @[Spi.scala 118:25]
    spiProtocol.io_data_in_valid <= TxDataValidReg @[Spi.scala 115:34]
    spiProtocol.io_data_in_bits <= TxDataReg @[Spi.scala 114:34]
    spiProtocol.io_data_out_ready <= UInt<1>("h1") @[Spi.scala 119:35]
    spiProtocol.io_CPOL <= _spiProtocol_io_CPOL_T @[Spi.scala 116:25]
    spiProtocol.io_CPHA <= _spiProtocol_io_CPHA_T @[Spi.scala 117:25]
    io_rsp_bits_error_REG <= io_req_valid @[Spi.scala 146:78]
    io_rsp_bits_error_REG_1 <= _io_rsp_bits_error_T @[Spi.scala 147:44]

  module uartTX :
    input clock : Clock
    input reset : UInt<1>
    input io_tx_en : UInt<1>
    input io_i_TX_Byte : UInt<8>
    input io_CLKS_PER_BIT : UInt<16>
    output io_o_TX_Serial : UInt<1>
    output io_o_TX_Done : UInt<1>

    reg r_SM_Main : UInt<3>, clock with :
      reset => (UInt<1>("h0"), r_SM_Main) @[uartTX.scala 23:28]
    reg r_Clock_Count : UInt<16>, clock with :
      reset => (UInt<1>("h0"), r_Clock_Count) @[uartTX.scala 24:32]
    reg r_Bit_Index : UInt<3>, clock with :
      reset => (UInt<1>("h0"), r_Bit_Index) @[uartTX.scala 25:30]
    reg r_TX_Data : UInt<8>, clock with :
      reset => (UInt<1>("h0"), r_TX_Data) @[uartTX.scala 26:28]
    reg r_TX_Done : UInt<1>, clock with :
      reset => (UInt<1>("h0"), r_TX_Done) @[uartTX.scala 27:28]
    node _T = eq(UInt<3>("h0"), r_SM_Main) @[Conditional.scala 37:30]
    node _T_1 = eq(io_tx_en, UInt<1>("h1")) @[uartTX.scala 40:27]
    node _GEN_0 = mux(_T_1, io_i_TX_Byte, r_TX_Data) @[uartTX.scala 40:35 uartTX.scala 41:27 uartTX.scala 26:28]
    node _GEN_1 = mux(_T_1, UInt<3>("h1"), UInt<3>("h0")) @[uartTX.scala 40:35 uartTX.scala 42:27 uartTX.scala 44:27]
    node _T_2 = eq(UInt<3>("h1"), r_SM_Main) @[Conditional.scala 37:30]
    node _T_3 = sub(io_CLKS_PER_BIT, UInt<1>("h1")) @[uartTX.scala 51:49]
    node _T_4 = tail(_T_3, 1) @[uartTX.scala 51:49]
    node _T_5 = lt(r_Clock_Count, _T_4) @[uartTX.scala 51:32]
    node _r_Clock_Count_T = add(r_Clock_Count, UInt<1>("h1")) @[uartTX.scala 52:48]
    node _r_Clock_Count_T_1 = tail(_r_Clock_Count_T, 1) @[uartTX.scala 52:48]
    node _GEN_2 = mux(_T_5, _r_Clock_Count_T_1, UInt<1>("h0")) @[uartTX.scala 51:54 uartTX.scala 52:31 uartTX.scala 55:31]
    node _GEN_3 = mux(_T_5, UInt<3>("h1"), UInt<3>("h2")) @[uartTX.scala 51:54 uartTX.scala 53:27 uartTX.scala 56:27]
    node _T_6 = eq(UInt<3>("h2"), r_SM_Main) @[Conditional.scala 37:30]
    node _io_o_TX_Serial_T = dshr(r_TX_Data, r_Bit_Index) @[uartTX.scala 61:40]
    node _io_o_TX_Serial_T_1 = bits(_io_o_TX_Serial_T, 0, 0) @[uartTX.scala 61:40]
    node _T_7 = sub(io_CLKS_PER_BIT, UInt<1>("h1")) @[uartTX.scala 63:50]
    node _T_8 = tail(_T_7, 1) @[uartTX.scala 63:50]
    node _T_9 = lt(r_Clock_Count, _T_8) @[uartTX.scala 63:32]
    node _r_Clock_Count_T_2 = add(r_Clock_Count, UInt<1>("h1")) @[uartTX.scala 64:48]
    node _r_Clock_Count_T_3 = tail(_r_Clock_Count_T_2, 1) @[uartTX.scala 64:48]
    node _T_10 = lt(r_Bit_Index, UInt<3>("h7")) @[uartTX.scala 68:34]
    node _r_Bit_Index_T = add(r_Bit_Index, UInt<1>("h1")) @[uartTX.scala 69:48]
    node _r_Bit_Index_T_1 = tail(_r_Bit_Index_T, 1) @[uartTX.scala 69:48]
    node _GEN_4 = mux(_T_10, _r_Bit_Index_T_1, UInt<1>("h0")) @[uartTX.scala 68:40 uartTX.scala 69:33 uartTX.scala 72:33]
    node _GEN_5 = mux(_T_10, UInt<3>("h2"), UInt<3>("h3")) @[uartTX.scala 68:40 uartTX.scala 70:31 uartTX.scala 73:31]
    node _GEN_6 = mux(_T_9, _r_Clock_Count_T_3, UInt<1>("h0")) @[uartTX.scala 63:56 uartTX.scala 64:31 uartTX.scala 67:31]
    node _GEN_7 = mux(_T_9, UInt<3>("h2"), _GEN_5) @[uartTX.scala 63:56 uartTX.scala 65:27]
    node _GEN_8 = mux(_T_9, r_Bit_Index, _GEN_4) @[uartTX.scala 63:56 uartTX.scala 25:30]
    node _T_11 = eq(UInt<3>("h3"), r_SM_Main) @[Conditional.scala 37:30]
    node _T_12 = sub(io_CLKS_PER_BIT, UInt<1>("h1")) @[uartTX.scala 83:50]
    node _T_13 = tail(_T_12, 1) @[uartTX.scala 83:50]
    node _T_14 = lt(r_Clock_Count, _T_13) @[uartTX.scala 83:32]
    node _r_Clock_Count_T_4 = add(r_Clock_Count, UInt<1>("h1")) @[uartTX.scala 84:48]
    node _r_Clock_Count_T_5 = tail(_r_Clock_Count_T_4, 1) @[uartTX.scala 84:48]
    node _GEN_9 = mux(_T_14, _r_Clock_Count_T_5, UInt<1>("h0")) @[uartTX.scala 83:56 uartTX.scala 84:31 uartTX.scala 88:31]
    node _GEN_10 = mux(_T_14, UInt<3>("h3"), UInt<3>("h4")) @[uartTX.scala 83:56 uartTX.scala 85:27 uartTX.scala 89:27]
    node _GEN_11 = mux(_T_14, r_TX_Done, UInt<1>("h1")) @[uartTX.scala 83:56 uartTX.scala 27:28 uartTX.scala 87:27]
    node _T_15 = eq(UInt<3>("h4"), r_SM_Main) @[Conditional.scala 37:30]
    node _GEN_12 = mux(_T_15, UInt<1>("h1"), UInt<1>("h0")) @[Conditional.scala 39:67 uartTX.scala 95:28 uartTX.scala 32:20]
    node _GEN_13 = mux(_T_15, UInt<1>("h1"), r_TX_Done) @[Conditional.scala 39:67 uartTX.scala 96:23 uartTX.scala 27:28]
    node _GEN_14 = mux(_T_15, UInt<3>("h0"), r_SM_Main) @[Conditional.scala 39:67 uartTX.scala 97:23 uartTX.scala 23:28]
    node _GEN_15 = mux(_T_11, UInt<1>("h1"), _GEN_12) @[Conditional.scala 39:67 uartTX.scala 81:28]
    node _GEN_16 = mux(_T_11, _GEN_9, r_Clock_Count) @[Conditional.scala 39:67 uartTX.scala 24:32]
    node _GEN_17 = mux(_T_11, _GEN_10, _GEN_14) @[Conditional.scala 39:67]
    node _GEN_18 = mux(_T_11, _GEN_11, _GEN_13) @[Conditional.scala 39:67]
    node _GEN_19 = mux(_T_6, _io_o_TX_Serial_T_1, _GEN_15) @[Conditional.scala 39:67 uartTX.scala 61:28]
    node _GEN_20 = mux(_T_6, _GEN_6, _GEN_16) @[Conditional.scala 39:67]
    node _GEN_21 = mux(_T_6, _GEN_7, _GEN_17) @[Conditional.scala 39:67]
    node _GEN_22 = mux(_T_6, _GEN_8, r_Bit_Index) @[Conditional.scala 39:67 uartTX.scala 25:30]
    node _GEN_23 = mux(_T_6, r_TX_Done, _GEN_18) @[Conditional.scala 39:67 uartTX.scala 27:28]
    node _GEN_24 = mux(_T_2, UInt<1>("h0"), _GEN_19) @[Conditional.scala 39:67 uartTX.scala 49:28]
    node _GEN_25 = mux(_T_2, _GEN_2, _GEN_20) @[Conditional.scala 39:67]
    node _GEN_26 = mux(_T_2, _GEN_3, _GEN_21) @[Conditional.scala 39:67]
    node _GEN_27 = mux(_T_2, r_Bit_Index, _GEN_22) @[Conditional.scala 39:67 uartTX.scala 25:30]
    node _GEN_28 = mux(_T_2, r_TX_Done, _GEN_23) @[Conditional.scala 39:67 uartTX.scala 27:28]
    node _GEN_29 = mux(_T, UInt<1>("h1"), _GEN_24) @[Conditional.scala 40:58 uartTX.scala 35:28]
    node _GEN_30 = mux(_T, UInt<1>("h0"), _GEN_28) @[Conditional.scala 40:58 uartTX.scala 36:23]
    node _GEN_31 = mux(_T, UInt<1>("h0"), _GEN_25) @[Conditional.scala 40:58 uartTX.scala 37:27]
    node _GEN_32 = mux(_T, UInt<1>("h0"), _GEN_27) @[Conditional.scala 40:58 uartTX.scala 38:25]
    node _GEN_33 = mux(_T, _GEN_0, r_TX_Data) @[Conditional.scala 40:58 uartTX.scala 26:28]
    node _GEN_34 = mux(_T, _GEN_1, _GEN_26) @[Conditional.scala 40:58]
    io_o_TX_Serial <= _GEN_29
    io_o_TX_Done <= r_TX_Done @[uartTX.scala 103:18]
    r_SM_Main <= mux(reset, UInt<3>("h0"), _GEN_34) @[uartTX.scala 23:28 uartTX.scala 23:28]
    r_Clock_Count <= mux(reset, UInt<16>("h0"), _GEN_31) @[uartTX.scala 24:32 uartTX.scala 24:32]
    r_Bit_Index <= mux(reset, UInt<3>("h0"), _GEN_32) @[uartTX.scala 25:30 uartTX.scala 25:30]
    r_TX_Data <= mux(reset, UInt<8>("h0"), _GEN_33) @[uartTX.scala 26:28 uartTX.scala 26:28]
    r_TX_Done <= mux(reset, UInt<1>("h0"), _GEN_30) @[uartTX.scala 27:28 uartTX.scala 27:28]

  module uartRX :
    input clock : Clock
    input reset : UInt<1>
    input io_i_Rx_Serial : UInt<1>
    input io_CLKS_PER_BIT : UInt<16>
    output io_o_Rx_DV : UInt<1>
    output io_o_Rx_Byte : UInt<8>

    reg rxReg_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxReg_REG) @[uartRX.scala 20:32]
    reg rxReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxReg) @[uartRX.scala 20:24]
    reg shiftReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), shiftReg) @[uartRX.scala 21:27]
    reg r_SM_Main : UInt<3>, clock with :
      reset => (UInt<1>("h0"), r_SM_Main) @[uartRX.scala 23:28]
    reg r_Clock_Count : UInt<16>, clock with :
      reset => (UInt<1>("h0"), r_Clock_Count) @[uartRX.scala 24:32]
    reg r_Bit_Index : UInt<3>, clock with :
      reset => (UInt<1>("h0"), r_Bit_Index) @[uartRX.scala 25:30]
    reg r_Rx_DV : UInt<1>, clock with :
      reset => (UInt<1>("h0"), r_Rx_DV) @[uartRX.scala 27:26]
    node _T = eq(UInt<3>("h0"), r_SM_Main) @[Conditional.scala 37:30]
    node _T_1 = eq(io_i_Rx_Serial, UInt<1>("h0")) @[uartRX.scala 36:33]
    node _GEN_0 = mux(_T_1, UInt<3>("h1"), UInt<3>("h0")) @[uartRX.scala 36:41 uartRX.scala 37:27 uartRX.scala 39:27]
    node _T_2 = eq(UInt<3>("h1"), r_SM_Main) @[Conditional.scala 37:30]
    node _T_3 = sub(io_CLKS_PER_BIT, UInt<1>("h1")) @[uartRX.scala 44:52]
    node _T_4 = tail(_T_3, 1) @[uartRX.scala 44:52]
    node _T_5 = div(_T_4, UInt<2>("h2")) @[uartRX.scala 44:57]
    node _T_6 = eq(r_Clock_Count, _T_5) @[uartRX.scala 44:32]
    node _T_7 = eq(io_i_Rx_Serial, UInt<1>("h0")) @[uartRX.scala 45:37]
    node _GEN_1 = mux(_T_7, UInt<1>("h0"), r_Clock_Count) @[uartRX.scala 45:45 uartRX.scala 46:35 uartRX.scala 24:32]
    node _GEN_2 = mux(_T_7, UInt<3>("h2"), UInt<3>("h0")) @[uartRX.scala 45:45 uartRX.scala 47:31 uartRX.scala 49:31]
    node _r_Clock_Count_T = add(r_Clock_Count, UInt<1>("h1")) @[uartRX.scala 52:48]
    node _r_Clock_Count_T_1 = tail(_r_Clock_Count_T, 1) @[uartRX.scala 52:48]
    node _GEN_3 = mux(_T_6, _GEN_1, _r_Clock_Count_T_1) @[uartRX.scala 44:62 uartRX.scala 52:31]
    node _GEN_4 = mux(_T_6, _GEN_2, UInt<3>("h1")) @[uartRX.scala 44:62 uartRX.scala 53:27]
    node _T_8 = eq(UInt<3>("h2"), r_SM_Main) @[Conditional.scala 37:30]
    node _T_9 = sub(io_CLKS_PER_BIT, UInt<1>("h1")) @[uartRX.scala 58:50]
    node _T_10 = tail(_T_9, 1) @[uartRX.scala 58:50]
    node _T_11 = lt(r_Clock_Count, _T_10) @[uartRX.scala 58:32]
    node _r_Clock_Count_T_2 = add(r_Clock_Count, UInt<1>("h1")) @[uartRX.scala 59:48]
    node _r_Clock_Count_T_3 = tail(_r_Clock_Count_T_2, 1) @[uartRX.scala 59:48]
    node shiftReg_lo = shr(shiftReg, 1) @[uartRX.scala 63:49]
    node _shiftReg_T = cat(rxReg, shiftReg_lo) @[Cat.scala 30:58]
    node _T_12 = lt(r_Bit_Index, UInt<3>("h7")) @[uartRX.scala 65:34]
    node _r_Bit_Index_T = add(r_Bit_Index, UInt<1>("h1")) @[uartRX.scala 66:48]
    node _r_Bit_Index_T_1 = tail(_r_Bit_Index_T, 1) @[uartRX.scala 66:48]
    node _GEN_5 = mux(_T_12, _r_Bit_Index_T_1, UInt<1>("h0")) @[uartRX.scala 65:40 uartRX.scala 66:33 uartRX.scala 69:33]
    node _GEN_6 = mux(_T_12, UInt<3>("h2"), UInt<3>("h3")) @[uartRX.scala 65:40 uartRX.scala 67:31 uartRX.scala 70:31]
    node _GEN_7 = mux(_T_11, _r_Clock_Count_T_3, UInt<1>("h0")) @[uartRX.scala 58:56 uartRX.scala 59:31 uartRX.scala 62:31]
    node _GEN_8 = mux(_T_11, UInt<3>("h2"), _GEN_6) @[uartRX.scala 58:56 uartRX.scala 60:27]
    node _GEN_9 = mux(_T_11, shiftReg, _shiftReg_T) @[uartRX.scala 58:56 uartRX.scala 21:27 uartRX.scala 63:26]
    node _GEN_10 = mux(_T_11, r_Bit_Index, _GEN_5) @[uartRX.scala 58:56 uartRX.scala 25:30]
    node _T_13 = eq(UInt<3>("h3"), r_SM_Main) @[Conditional.scala 37:30]
    node _T_14 = sub(io_CLKS_PER_BIT, UInt<1>("h1")) @[uartRX.scala 77:50]
    node _T_15 = tail(_T_14, 1) @[uartRX.scala 77:50]
    node _T_16 = lt(r_Clock_Count, _T_15) @[uartRX.scala 77:32]
    node _r_Clock_Count_T_4 = add(r_Clock_Count, UInt<1>("h1")) @[uartRX.scala 78:48]
    node _r_Clock_Count_T_5 = tail(_r_Clock_Count_T_4, 1) @[uartRX.scala 78:48]
    node _GEN_11 = mux(_T_16, _r_Clock_Count_T_5, UInt<1>("h0")) @[uartRX.scala 77:56 uartRX.scala 78:31 uartRX.scala 82:31]
    node _GEN_12 = mux(_T_16, UInt<3>("h3"), UInt<3>("h4")) @[uartRX.scala 77:56 uartRX.scala 79:27 uartRX.scala 83:27]
    node _GEN_13 = mux(_T_16, r_Rx_DV, UInt<1>("h1")) @[uartRX.scala 77:56 uartRX.scala 27:26 uartRX.scala 81:25]
    node _T_17 = eq(UInt<3>("h4"), r_SM_Main) @[Conditional.scala 37:30]
    node _GEN_14 = mux(_T_17, UInt<3>("h0"), r_SM_Main) @[Conditional.scala 39:67 uartRX.scala 88:23 uartRX.scala 23:28]
    node _GEN_15 = mux(_T_17, UInt<1>("h0"), r_Rx_DV) @[Conditional.scala 39:67 uartRX.scala 89:21 uartRX.scala 27:26]
    node _GEN_16 = mux(_T_13, _GEN_11, r_Clock_Count) @[Conditional.scala 39:67 uartRX.scala 24:32]
    node _GEN_17 = mux(_T_13, _GEN_12, _GEN_14) @[Conditional.scala 39:67]
    node _GEN_18 = mux(_T_13, _GEN_13, _GEN_15) @[Conditional.scala 39:67]
    node _GEN_19 = mux(_T_8, _GEN_7, _GEN_16) @[Conditional.scala 39:67]
    node _GEN_20 = mux(_T_8, _GEN_8, _GEN_17) @[Conditional.scala 39:67]
    node _GEN_21 = mux(_T_8, _GEN_9, shiftReg) @[Conditional.scala 39:67 uartRX.scala 21:27]
    node _GEN_22 = mux(_T_8, _GEN_10, r_Bit_Index) @[Conditional.scala 39:67 uartRX.scala 25:30]
    node _GEN_23 = mux(_T_8, r_Rx_DV, _GEN_18) @[Conditional.scala 39:67 uartRX.scala 27:26]
    node _GEN_24 = mux(_T_2, _GEN_3, _GEN_19) @[Conditional.scala 39:67]
    node _GEN_25 = mux(_T_2, _GEN_4, _GEN_20) @[Conditional.scala 39:67]
    node _GEN_26 = mux(_T_2, shiftReg, _GEN_21) @[Conditional.scala 39:67 uartRX.scala 21:27]
    node _GEN_27 = mux(_T_2, r_Bit_Index, _GEN_22) @[Conditional.scala 39:67 uartRX.scala 25:30]
    node _GEN_28 = mux(_T_2, r_Rx_DV, _GEN_23) @[Conditional.scala 39:67 uartRX.scala 27:26]
    node _GEN_29 = mux(_T, UInt<1>("h0"), _GEN_28) @[Conditional.scala 40:58 uartRX.scala 31:21]
    node _GEN_30 = mux(_T, UInt<1>("h0"), _GEN_24) @[Conditional.scala 40:58 uartRX.scala 32:27]
    node _GEN_31 = mux(_T, UInt<1>("h0"), _GEN_27) @[Conditional.scala 40:58 uartRX.scala 33:25]
    node _GEN_32 = mux(_T, _GEN_0, _GEN_25) @[Conditional.scala 40:58]
    node _GEN_33 = mux(_T, shiftReg, _GEN_26) @[Conditional.scala 40:58 uartRX.scala 21:27]
    io_o_Rx_DV <= r_Rx_DV @[uartRX.scala 93:16]
    io_o_Rx_Byte <= shiftReg @[uartRX.scala 94:18]
    rxReg_REG <= mux(reset, UInt<1>("h1"), io_i_Rx_Serial) @[uartRX.scala 20:32 uartRX.scala 20:32 uartRX.scala 20:32]
    rxReg <= mux(reset, UInt<1>("h1"), rxReg_REG) @[uartRX.scala 20:24 uartRX.scala 20:24 uartRX.scala 20:24]
    shiftReg <= mux(reset, UInt<8>("h0"), _GEN_33) @[uartRX.scala 21:27 uartRX.scala 21:27]
    r_SM_Main <= mux(reset, UInt<3>("h0"), _GEN_32) @[uartRX.scala 23:28 uartRX.scala 23:28]
    r_Clock_Count <= mux(reset, UInt<16>("h0"), _GEN_30) @[uartRX.scala 24:32 uartRX.scala 24:32]
    r_Bit_Index <= mux(reset, UInt<3>("h0"), _GEN_31) @[uartRX.scala 25:30 uartRX.scala 25:30]
    r_Rx_DV <= mux(reset, UInt<1>("h0"), _GEN_29) @[uartRX.scala 27:26 uartRX.scala 27:26]

  module UartTOP :
    input clock : Clock
    input reset : UInt<1>
    input io_ren : UInt<1>
    input io_we : UInt<1>
    input io_wdata : UInt<32>
    input io_addr : UInt<8>
    input io_rx_i : UInt<1>
    output io_rdata : UInt<32>
    output io_tx_o : UInt<1>
    output io_intr_tx : UInt<1>

    inst uart_tx of uartTX @[UartTOP.scala 162:25]
    inst uart_rx of uartRX @[UartTOP.scala 163:25]
    reg control : UInt<16>, clock with :
      reset => (UInt<1>("h0"), control) @[UartTOP.scala 131:26]
    reg tx : UInt<8>, clock with :
      reset => (UInt<1>("h0"), tx) @[UartTOP.scala 132:21]
    reg rx : UInt<8>, clock with :
      reset => (UInt<1>("h0"), rx) @[UartTOP.scala 133:21]
    reg rx_reg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), rx_reg) @[UartTOP.scala 134:25]
    reg rx_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rx_en) @[UartTOP.scala 135:24]
    reg tx_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), tx_en) @[UartTOP.scala 136:24]
    reg rx_status : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rx_status) @[UartTOP.scala 137:28]
    reg rx_clr : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rx_clr) @[UartTOP.scala 138:25]
    reg rx_done : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rx_done) @[UartTOP.scala 139:26]
    node _T = eq(io_ren, UInt<1>("h0")) @[UartTOP.scala 141:10]
    node _T_1 = and(_T, io_we) @[UartTOP.scala 141:20]
    node _T_2 = eq(io_addr, UInt<1>("h0")) @[UartTOP.scala 142:22]
    node _control_T = bits(io_wdata, 15, 0) @[UartTOP.scala 143:32]
    node _T_3 = eq(io_addr, UInt<3>("h4")) @[UartTOP.scala 144:28]
    node _tx_T = bits(io_wdata, 7, 0) @[UartTOP.scala 145:27]
    node _T_4 = eq(io_addr, UInt<4>("hc")) @[UartTOP.scala 146:28]
    node _rx_en_T = bits(io_wdata, 0, 0) @[UartTOP.scala 147:30]
    node _T_5 = eq(io_addr, UInt<5>("h10")) @[UartTOP.scala 148:28]
    node _tx_en_T = bits(io_wdata, 0, 0) @[UartTOP.scala 149:30]
    node _T_6 = eq(io_addr, UInt<5>("h18")) @[UartTOP.scala 150:28]
    node _rx_clr_T = bits(io_wdata, 0, 0) @[UartTOP.scala 151:31]
    node _GEN_0 = mux(_T_6, _rx_clr_T, UInt<1>("h0")) @[UartTOP.scala 150:38 UartTOP.scala 151:20 UartTOP.scala 157:20]
    node _GEN_1 = mux(_T_6, control, UInt<1>("h0")) @[UartTOP.scala 150:38 UartTOP.scala 131:26 UartTOP.scala 153:21]
    node _GEN_2 = mux(_T_6, tx, UInt<1>("h0")) @[UartTOP.scala 150:38 UartTOP.scala 132:21 UartTOP.scala 154:16]
    node _GEN_3 = mux(_T_6, rx_en, UInt<1>("h0")) @[UartTOP.scala 150:38 UartTOP.scala 135:24 UartTOP.scala 155:19]
    node _GEN_4 = mux(_T_6, tx_en, UInt<1>("h0")) @[UartTOP.scala 150:38 UartTOP.scala 136:24 UartTOP.scala 156:19]
    node _GEN_5 = mux(_T_5, _tx_en_T, _GEN_4) @[UartTOP.scala 148:38 UartTOP.scala 149:19]
    node _GEN_6 = mux(_T_5, rx_clr, _GEN_0) @[UartTOP.scala 148:38 UartTOP.scala 138:25]
    node _GEN_7 = mux(_T_5, control, _GEN_1) @[UartTOP.scala 148:38 UartTOP.scala 131:26]
    node _GEN_8 = mux(_T_5, tx, _GEN_2) @[UartTOP.scala 148:38 UartTOP.scala 132:21]
    node _GEN_9 = mux(_T_5, rx_en, _GEN_3) @[UartTOP.scala 148:38 UartTOP.scala 135:24]
    node _GEN_10 = mux(_T_4, _rx_en_T, _GEN_9) @[UartTOP.scala 146:38 UartTOP.scala 147:19]
    node _GEN_11 = mux(_T_4, tx_en, _GEN_5) @[UartTOP.scala 146:38 UartTOP.scala 136:24]
    node _GEN_12 = mux(_T_4, rx_clr, _GEN_6) @[UartTOP.scala 146:38 UartTOP.scala 138:25]
    node _GEN_13 = mux(_T_4, control, _GEN_7) @[UartTOP.scala 146:38 UartTOP.scala 131:26]
    node _GEN_14 = mux(_T_4, tx, _GEN_8) @[UartTOP.scala 146:38 UartTOP.scala 132:21]
    node _GEN_15 = mux(_T_3, _tx_T, _GEN_14) @[UartTOP.scala 144:40 UartTOP.scala 145:16]
    node _GEN_16 = mux(_T_3, rx_en, _GEN_10) @[UartTOP.scala 144:40 UartTOP.scala 135:24]
    node _GEN_17 = mux(_T_3, tx_en, _GEN_11) @[UartTOP.scala 144:40 UartTOP.scala 136:24]
    node _GEN_18 = mux(_T_3, rx_clr, _GEN_12) @[UartTOP.scala 144:40 UartTOP.scala 138:25]
    node _GEN_19 = mux(_T_3, control, _GEN_13) @[UartTOP.scala 144:40 UartTOP.scala 131:26]
    node _GEN_20 = mux(_T_2, _control_T, _GEN_19) @[UartTOP.scala 142:36 UartTOP.scala 143:21]
    node _GEN_21 = mux(_T_2, tx, _GEN_15) @[UartTOP.scala 142:36 UartTOP.scala 132:21]
    node _GEN_22 = mux(_T_2, rx_en, _GEN_16) @[UartTOP.scala 142:36 UartTOP.scala 135:24]
    node _GEN_23 = mux(_T_2, tx_en, _GEN_17) @[UartTOP.scala 142:36 UartTOP.scala 136:24]
    node _GEN_24 = mux(_T_2, rx_clr, _GEN_18) @[UartTOP.scala 142:36 UartTOP.scala 138:25]
    node _GEN_25 = mux(_T_1, _GEN_20, control) @[UartTOP.scala 141:29 UartTOP.scala 131:26]
    node _GEN_26 = mux(_T_1, _GEN_21, tx) @[UartTOP.scala 141:29 UartTOP.scala 132:21]
    node _GEN_27 = mux(_T_1, _GEN_22, rx_en) @[UartTOP.scala 141:29 UartTOP.scala 135:24]
    node _GEN_28 = mux(_T_1, _GEN_23, tx_en) @[UartTOP.scala 141:29 UartTOP.scala 136:24]
    node _GEN_29 = mux(_T_1, _GEN_24, rx_clr) @[UartTOP.scala 141:29 UartTOP.scala 138:25]
    node _GEN_30 = mux(uart_rx.io_o_Rx_DV, uart_rx.io_o_Rx_Byte, _GEN_26) @[UartTOP.scala 166:29 UartTOP.scala 167:12]
    node _GEN_31 = mux(rx_en, io_rx_i, UInt<1>("h1")) @[UartTOP.scala 176:16 UartTOP.scala 177:32 UartTOP.scala 179:32]
    node _T_7 = eq(rx_clr, UInt<1>("h0")) @[UartTOP.scala 190:16]
    node _GEN_32 = mux(_T_7, UInt<1>("h0"), rx_status) @[UartTOP.scala 190:26 UartTOP.scala 191:19 UartTOP.scala 137:28]
    node _GEN_33 = mux(rx_done, rx, rx_reg) @[UartTOP.scala 187:18 UartTOP.scala 188:16 UartTOP.scala 134:25]
    node _GEN_34 = mux(rx_done, UInt<1>("h1"), _GEN_32) @[UartTOP.scala 187:18 UartTOP.scala 189:19]
    node _io_rdata_T = eq(io_addr, UInt<5>("h14")) @[UartTOP.scala 194:29]
    node _io_rdata_T_1 = eq(io_addr, UInt<4>("h8")) @[UartTOP.scala 194:64]
    node _io_rdata_T_2 = mux(_io_rdata_T_1, rx_reg, UInt<1>("h0")) @[UartTOP.scala 194:55]
    node _io_rdata_T_3 = mux(_io_rdata_T, rx_status, _io_rdata_T_2) @[UartTOP.scala 194:20]
    io_rdata <= _io_rdata_T_3 @[UartTOP.scala 194:14]
    io_tx_o <= uart_tx.io_o_TX_Serial @[UartTOP.scala 172:13]
    io_intr_tx <= uart_tx.io_o_TX_Done @[UartTOP.scala 173:16]
    control <= mux(reset, UInt<16>("h0"), _GEN_25) @[UartTOP.scala 131:26 UartTOP.scala 131:26]
    tx <= mux(reset, UInt<8>("h0"), _GEN_30) @[UartTOP.scala 132:21 UartTOP.scala 132:21]
    rx <= mux(reset, UInt<8>("h0"), uart_rx.io_o_Rx_Byte) @[UartTOP.scala 133:21 UartTOP.scala 133:21 UartTOP.scala 184:8]
    rx_reg <= mux(reset, UInt<8>("h0"), _GEN_33) @[UartTOP.scala 134:25 UartTOP.scala 134:25]
    rx_en <= mux(reset, UInt<1>("h0"), _GEN_27) @[UartTOP.scala 135:24 UartTOP.scala 135:24]
    tx_en <= mux(reset, UInt<1>("h0"), _GEN_28) @[UartTOP.scala 136:24 UartTOP.scala 136:24]
    rx_status <= mux(reset, UInt<1>("h0"), _GEN_34) @[UartTOP.scala 137:28 UartTOP.scala 137:28]
    rx_clr <= mux(reset, UInt<1>("h1"), _GEN_29) @[UartTOP.scala 138:25 UartTOP.scala 138:25]
    rx_done <= mux(reset, UInt<1>("h0"), uart_rx.io_o_Rx_DV) @[UartTOP.scala 139:26 UartTOP.scala 139:26 UartTOP.scala 183:13]
    uart_tx.clock <= clock
    uart_tx.reset <= reset
    uart_tx.io_tx_en <= tx_en @[UartTOP.scala 165:22]
    uart_tx.io_i_TX_Byte <= tx @[UartTOP.scala 169:26]
    uart_tx.io_CLKS_PER_BIT <= control @[UartTOP.scala 170:29]
    uart_rx.clock <= clock
    uart_rx.reset <= reset
    uart_rx.io_i_Rx_Serial <= _GEN_31
    uart_rx.io_CLKS_PER_BIT <= control @[UartTOP.scala 181:29]

  module uart :
    input clock : Clock
    input reset : UInt<1>
    output io_request_ready : UInt<1>
    input io_request_valid : UInt<1>
    input io_request_bits_addrRequest : UInt<32>
    input io_request_bits_dataRequest : UInt<32>
    input io_request_bits_activeByteLane : UInt<4>
    input io_request_bits_isWrite : UInt<1>
    input io_response_ready : UInt<1>
    output io_response_valid : UInt<1>
    output io_response_bits_dataResponse : UInt<32>
    output io_response_bits_error : UInt<1>
    output io_response_bits_ackWrite : UInt<1>
    input io_cio_uart_rx_i : UInt<1>
    output io_cio_uart_tx_o : UInt<1>
    output io_cio_uart_intr_tx_o : UInt<1>

    inst uart_top of UartTOP @[uart.scala 64:27]
    node _write_register_T = and(io_request_ready, io_request_valid) @[Decoupled.scala 40:37]
    node _write_register_T_1 = mux(_write_register_T, io_request_bits_isWrite, UInt<1>("h0")) @[uart.scala 71:26]
    node _read_register_T = and(io_request_ready, io_request_valid) @[Decoupled.scala 40:37]
    node _read_register_T_1 = eq(io_request_bits_isWrite, UInt<1>("h0")) @[uart.scala 72:45]
    node _read_register_T_2 = mux(_read_register_T, _read_register_T_1, UInt<1>("h0")) @[uart.scala 72:25]
    node _addr_reg_T = bits(io_request_bits_addrRequest, 7, 0) @[uart.scala 74:44]
    node _io_response_bits_dataResponse_T = mux(io_response_ready, uart_top.io_rdata, UInt<1>("h0")) @[uart.scala 80:49]
    reg io_response_bits_dataResponse_REG : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_response_bits_dataResponse_REG) @[uart.scala 80:45]
    node write_register = _write_register_T_1 @[uart.scala 67:46 uart.scala 71:20]
    node read_register = _read_register_T_2 @[uart.scala 67:46 uart.scala 72:19]
    node _io_response_valid_T = or(write_register, read_register) @[uart.scala 81:53]
    node _io_response_valid_T_1 = mux(_io_response_valid_T, UInt<1>("h1"), UInt<1>("h0")) @[uart.scala 81:37]
    reg io_response_valid_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_response_valid_REG) @[uart.scala 81:33]
    node _io_response_bits_error_T = mux(io_response_ready, uart_top.io_intr_tx, UInt<1>("h0")) @[uart.scala 82:42]
    reg io_response_bits_error_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_response_bits_error_REG) @[uart.scala 82:38]
    node data_reg = io_request_bits_dataRequest @[uart.scala 68:24 uart.scala 73:14]
    node addr_reg = _addr_reg_T @[uart.scala 69:24 uart.scala 74:14]
    io_request_ready <= UInt<1>("h1") @[uart.scala 20:22]
    io_response_valid <= io_response_valid_REG @[uart.scala 81:23]
    io_response_bits_dataResponse <= io_response_bits_dataResponse_REG @[uart.scala 80:35]
    io_response_bits_error <= io_response_bits_error_REG @[uart.scala 82:28]
    io_response_bits_ackWrite <= UInt<1>("h1") @[uart.scala 19:31]
    io_cio_uart_tx_o <= uart_top.io_tx_o @[uart.scala 85:22]
    io_cio_uart_intr_tx_o <= uart_top.io_intr_tx @[uart.scala 84:27]
    uart_top.clock <= clock
    uart_top.reset <= reset
    uart_top.io_ren <= read_register @[uart.scala 78:21]
    uart_top.io_we <= write_register @[uart.scala 77:20]
    uart_top.io_wdata <= data_reg @[uart.scala 75:23]
    uart_top.io_addr <= addr_reg @[uart.scala 76:22]
    uart_top.io_rx_i <= io_cio_uart_rx_i @[uart.scala 86:22]
    io_response_bits_dataResponse_REG <= _io_response_bits_dataResponse_T @[uart.scala 80:45]
    io_response_valid_REG <= _io_response_valid_T_1 @[uart.scala 81:33]
    io_response_bits_error_REG <= _io_response_bits_error_T @[uart.scala 82:38]

  module WishboneErr :
    input clock : Clock
    input reset : UInt<1>
    input io_wbSlaveTransmitter_ready : UInt<1>
    output io_wbSlaveTransmitter_valid : UInt<1>
    output io_wbSlaveTransmitter_bits_ack : UInt<1>
    output io_wbSlaveTransmitter_bits_dat : UInt<32>
    output io_wbSlaveTransmitter_bits_err : UInt<1>
    output io_wbMasterReceiver_ready : UInt<1>
    input io_wbMasterReceiver_valid : UInt<1>
    input io_wbMasterReceiver_bits_cyc : UInt<1>
    input io_wbMasterReceiver_bits_stb : UInt<1>
    input io_wbMasterReceiver_bits_we : UInt<1>
    input io_wbMasterReceiver_bits_adr : UInt<32>
    input io_wbMasterReceiver_bits_dat : UInt<32>
    input io_wbMasterReceiver_bits_sel : UInt<4>

    reg ackReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ackReg) @[WishboneErr.scala 14:23]
    reg dataReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[WishboneErr.scala 15:24]
    reg errReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), errReg) @[WishboneErr.scala 16:23]
    reg validReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), validReg) @[WishboneErr.scala 17:25]
    node _T = and(io_wbMasterReceiver_valid, io_wbMasterReceiver_bits_cyc) @[WishboneErr.scala 12:48]
    node _T_1 = and(_T, io_wbMasterReceiver_bits_stb) @[WishboneErr.scala 12:80]
    node dataReg_hi = cat(UInt<4>("hf"), UInt<4>("hf")) @[Cat.scala 30:58]
    node dataReg_hi_1 = cat(dataReg_hi, dataReg_hi) @[Cat.scala 30:58]
    node _dataReg_T = cat(dataReg_hi_1, dataReg_hi_1) @[Cat.scala 30:58]
    node _GEN_0 = validif(eq(io_wbMasterReceiver_bits_we, UInt<1>("h0")), _dataReg_T) @[WishboneErr.scala 27:39 WishboneErr.scala 32:15]
    node _GEN_1 = mux(_T_1, UInt<1>("h1"), UInt<1>("h0")) @[WishboneErr.scala 21:16 WishboneErr.scala 25:12 WishboneErr.scala 38:12]
    node _GEN_2 = mux(_T_1, _GEN_0, UInt<1>("h0")) @[WishboneErr.scala 21:16 WishboneErr.scala 37:13]
    io_wbSlaveTransmitter_valid <= validReg @[WishboneErr.scala 42:31]
    io_wbSlaveTransmitter_bits_ack <= ackReg @[WishboneErr.scala 43:34]
    io_wbSlaveTransmitter_bits_dat <= dataReg @[WishboneErr.scala 44:34]
    io_wbSlaveTransmitter_bits_err <= errReg @[WishboneErr.scala 45:35]
    io_wbMasterReceiver_ready <= UInt<1>("h1") @[WishboneErr.scala 19:29]
    ackReg <= mux(reset, UInt<1>("h0"), ackReg) @[WishboneErr.scala 14:23 WishboneErr.scala 14:23 WishboneErr.scala 14:23]
    dataReg <= mux(reset, UInt<1>("h0"), _GEN_2) @[WishboneErr.scala 15:24 WishboneErr.scala 15:24]
    errReg <= mux(reset, UInt<1>("h0"), _GEN_1) @[WishboneErr.scala 16:23 WishboneErr.scala 16:23]
    validReg <= mux(reset, UInt<1>("h0"), _GEN_1) @[WishboneErr.scala 17:25 WishboneErr.scala 17:25]

  module InstructionFetch :
    input clock : Clock
    input reset : UInt<1>
    input io_address : UInt<32>
    output io_instruction : UInt<32>
    input io_coreInstrReq_ready : UInt<1>
    output io_coreInstrReq_valid : UInt<1>
    output io_coreInstrReq_bits_addrRequest : UInt<32>
    output io_coreInstrReq_bits_dataRequest : UInt<32>
    output io_coreInstrReq_bits_activeByteLane : UInt<4>
    output io_coreInstrReq_bits_isWrite : UInt<1>
    output io_coreInstrResp_ready : UInt<1>
    input io_coreInstrResp_valid : UInt<1>
    input io_coreInstrResp_bits_dataResponse : UInt<32>
    input io_coreInstrResp_bits_error : UInt<1>
    input io_coreInstrResp_bits_ackWrite : UInt<1>

    node _T = mux(io_coreInstrReq_ready, UInt<1>("h1"), UInt<1>("h0")) @[InstructionFetch.scala 24:31]
    node _WIRE = validif(UInt<1>("h0"), UInt<32>("h0"))
    node _T_1 = mux(io_coreInstrResp_valid, io_coreInstrResp_bits_dataResponse, _WIRE) @[InstructionFetch.scala 26:24]
    io_instruction <= _T_1 @[InstructionFetch.scala 26:18]
    io_coreInstrReq_valid <= _T @[InstructionFetch.scala 24:25]
    io_coreInstrReq_bits_addrRequest <= io_address @[InstructionFetch.scala 23:36]
    io_coreInstrReq_bits_dataRequest is invalid
    io_coreInstrReq_bits_activeByteLane <= UInt<4>("hf") @[InstructionFetch.scala 19:39]
    io_coreInstrReq_bits_isWrite <= UInt<1>("h0") @[InstructionFetch.scala 20:32]
    io_coreInstrResp_ready <= UInt<1>("h1") @[InstructionFetch.scala 17:26]

  module HazardUnit :
    input clock : Clock
    input reset : UInt<1>
    input io_id_ex_memRead : UInt<1>
    input io_ex_mem_memRead : UInt<1>
    input io_id_ex_branch : UInt<1>
    input io_id_ex_rd : UInt<5>
    input io_ex_mem_rd : UInt<5>
    input io_id_rs1 : UInt<5>
    input io_id_rs2 : UInt<5>
    input io_dmem_resp_valid : UInt<1>
    input io_taken : UInt<1>
    input io_jump : UInt<2>
    input io_branch : UInt<1>
    output io_if_reg_write : UInt<1>
    output io_pc_write : UInt<1>
    output io_ctl_mux : UInt<1>
    output io_ifid_flush : UInt<1>
    output io_take_branch : UInt<1>

    node _T = or(io_id_ex_memRead, io_branch) @[HazardUnit.scala 34:23]
    node _T_1 = eq(io_id_ex_rd, io_id_rs1) @[HazardUnit.scala 35:20]
    node _T_2 = eq(io_id_ex_rd, io_id_rs2) @[HazardUnit.scala 35:49]
    node _T_3 = or(_T_1, _T_2) @[HazardUnit.scala 35:34]
    node _T_4 = and(_T, _T_3) @[HazardUnit.scala 34:37]
    node _T_5 = neq(io_id_ex_rd, UInt<1>("h0")) @[HazardUnit.scala 36:21]
    node _T_6 = neq(io_id_rs1, UInt<1>("h0")) @[HazardUnit.scala 36:42]
    node _T_7 = and(_T_5, _T_6) @[HazardUnit.scala 36:29]
    node _T_8 = neq(io_id_ex_rd, UInt<1>("h0")) @[HazardUnit.scala 37:20]
    node _T_9 = neq(io_id_rs2, UInt<1>("h0")) @[HazardUnit.scala 37:41]
    node _T_10 = and(_T_8, _T_9) @[HazardUnit.scala 37:28]
    node _T_11 = or(_T_7, _T_10) @[HazardUnit.scala 36:51]
    node _T_12 = and(_T_4, _T_11) @[HazardUnit.scala 35:65]
    node _T_13 = eq(io_id_ex_branch, UInt<1>("h0")) @[HazardUnit.scala 38:7]
    node _T_14 = and(_T_12, _T_13) @[HazardUnit.scala 37:51]
    node _GEN_0 = mux(_T_14, UInt<1>("h0"), UInt<1>("h1")) @[HazardUnit.scala 40:3 HazardUnit.scala 41:16 HazardUnit.scala 26:14]
    node _T_15 = and(io_ex_mem_memRead, io_branch) @[HazardUnit.scala 47:26]
    node _T_16 = eq(io_ex_mem_rd, io_id_rs1) @[HazardUnit.scala 47:56]
    node _T_17 = eq(io_ex_mem_rd, io_id_rs2) @[HazardUnit.scala 47:86]
    node _T_18 = or(_T_16, _T_17) @[HazardUnit.scala 47:70]
    node _T_19 = and(_T_15, _T_18) @[HazardUnit.scala 47:39]
    node _GEN_1 = mux(_T_19, UInt<1>("h0"), _GEN_0) @[HazardUnit.scala 47:101 HazardUnit.scala 48:16]
    node _T_20 = neq(io_jump, UInt<1>("h0")) @[HazardUnit.scala 55:28]
    node _T_21 = or(io_taken, _T_20) @[HazardUnit.scala 55:17]
    node _GEN_2 = mux(_T_21, UInt<1>("h1"), UInt<1>("h0")) @[HazardUnit.scala 55:37 HazardUnit.scala 56:19 HazardUnit.scala 58:19]
    io_if_reg_write <= _GEN_1
    io_pc_write <= _GEN_1
    io_ctl_mux <= _GEN_1
    io_ifid_flush <= _GEN_2
    io_take_branch <= _GEN_1

  module Control :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<32>
    output io_aluSrc : UInt<1>
    output io_memToReg : UInt<2>
    output io_regWrite : UInt<1>
    output io_memRead : UInt<1>
    output io_memWrite : UInt<1>
    output io_branch : UInt<1>
    output io_aluOp : UInt<2>
    output io_jump : UInt<2>
    output io_aluSrc1 : UInt<2>

    node _T = and(io_in, UInt<7>("h7f")) @[Lookup.scala 31:38]
    node _T_1 = eq(UInt<6>("h33"), _T) @[Lookup.scala 31:38]
    node _T_2 = and(io_in, UInt<7>("h7f")) @[Lookup.scala 31:38]
    node _T_3 = eq(UInt<5>("h13"), _T_2) @[Lookup.scala 31:38]
    node _T_4 = and(io_in, UInt<7>("h7f")) @[Lookup.scala 31:38]
    node _T_5 = eq(UInt<2>("h3"), _T_4) @[Lookup.scala 31:38]
    node _T_6 = and(io_in, UInt<7>("h7f")) @[Lookup.scala 31:38]
    node _T_7 = eq(UInt<6>("h23"), _T_6) @[Lookup.scala 31:38]
    node _T_8 = and(io_in, UInt<7>("h7f")) @[Lookup.scala 31:38]
    node _T_9 = eq(UInt<7>("h63"), _T_8) @[Lookup.scala 31:38]
    node _T_10 = and(io_in, UInt<7>("h7f")) @[Lookup.scala 31:38]
    node _T_11 = eq(UInt<6>("h37"), _T_10) @[Lookup.scala 31:38]
    node _T_12 = and(io_in, UInt<7>("h7f")) @[Lookup.scala 31:38]
    node _T_13 = eq(UInt<5>("h17"), _T_12) @[Lookup.scala 31:38]
    node _T_14 = and(io_in, UInt<7>("h7f")) @[Lookup.scala 31:38]
    node _T_15 = eq(UInt<7>("h6f"), _T_14) @[Lookup.scala 31:38]
    node _T_16 = and(io_in, UInt<7>("h7f")) @[Lookup.scala 31:38]
    node _T_17 = eq(UInt<7>("h67"), _T_16) @[Lookup.scala 31:38]
    node _T_18 = mux(_T_17, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 33:37]
    node _T_19 = mux(_T_15, UInt<1>("h0"), _T_18) @[Lookup.scala 33:37]
    node _T_20 = mux(_T_13, UInt<1>("h0"), _T_19) @[Lookup.scala 33:37]
    node _T_21 = mux(_T_11, UInt<1>("h0"), _T_20) @[Lookup.scala 33:37]
    node _T_22 = mux(_T_9, UInt<1>("h1"), _T_21) @[Lookup.scala 33:37]
    node _T_23 = mux(_T_7, UInt<1>("h0"), _T_22) @[Lookup.scala 33:37]
    node _T_24 = mux(_T_5, UInt<1>("h0"), _T_23) @[Lookup.scala 33:37]
    node _T_25 = mux(_T_3, UInt<1>("h0"), _T_24) @[Lookup.scala 33:37]
    node signals_0 = mux(_T_1, UInt<1>("h1"), _T_25) @[Lookup.scala 33:37]
    node _T_26 = mux(_T_17, UInt<2>("h2"), UInt<1>("h0")) @[Lookup.scala 33:37]
    node _T_27 = mux(_T_15, UInt<2>("h2"), _T_26) @[Lookup.scala 33:37]
    node _T_28 = mux(_T_13, UInt<1>("h0"), _T_27) @[Lookup.scala 33:37]
    node _T_29 = mux(_T_11, UInt<1>("h0"), _T_28) @[Lookup.scala 33:37]
    node _T_30 = mux(_T_9, UInt<1>("h0"), _T_29) @[Lookup.scala 33:37]
    node _T_31 = mux(_T_7, UInt<1>("h0"), _T_30) @[Lookup.scala 33:37]
    node _T_32 = mux(_T_5, UInt<1>("h1"), _T_31) @[Lookup.scala 33:37]
    node _T_33 = mux(_T_3, UInt<1>("h0"), _T_32) @[Lookup.scala 33:37]
    node signals_1 = mux(_T_1, UInt<1>("h0"), _T_33) @[Lookup.scala 33:37]
    node _T_34 = mux(_T_17, UInt<1>("h1"), UInt<1>("h0")) @[Lookup.scala 33:37]
    node _T_35 = mux(_T_15, UInt<1>("h1"), _T_34) @[Lookup.scala 33:37]
    node _T_36 = mux(_T_13, UInt<1>("h1"), _T_35) @[Lookup.scala 33:37]
    node _T_37 = mux(_T_11, UInt<1>("h1"), _T_36) @[Lookup.scala 33:37]
    node _T_38 = mux(_T_9, UInt<1>("h0"), _T_37) @[Lookup.scala 33:37]
    node _T_39 = mux(_T_7, UInt<1>("h0"), _T_38) @[Lookup.scala 33:37]
    node _T_40 = mux(_T_5, UInt<1>("h1"), _T_39) @[Lookup.scala 33:37]
    node _T_41 = mux(_T_3, UInt<1>("h1"), _T_40) @[Lookup.scala 33:37]
    node signals_2 = mux(_T_1, UInt<1>("h1"), _T_41) @[Lookup.scala 33:37]
    node _T_42 = mux(_T_17, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 33:37]
    node _T_43 = mux(_T_15, UInt<1>("h0"), _T_42) @[Lookup.scala 33:37]
    node _T_44 = mux(_T_13, UInt<1>("h0"), _T_43) @[Lookup.scala 33:37]
    node _T_45 = mux(_T_11, UInt<1>("h0"), _T_44) @[Lookup.scala 33:37]
    node _T_46 = mux(_T_9, UInt<1>("h0"), _T_45) @[Lookup.scala 33:37]
    node _T_47 = mux(_T_7, UInt<1>("h0"), _T_46) @[Lookup.scala 33:37]
    node _T_48 = mux(_T_5, UInt<1>("h1"), _T_47) @[Lookup.scala 33:37]
    node _T_49 = mux(_T_3, UInt<1>("h0"), _T_48) @[Lookup.scala 33:37]
    node signals_3 = mux(_T_1, UInt<1>("h0"), _T_49) @[Lookup.scala 33:37]
    node _T_50 = mux(_T_17, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 33:37]
    node _T_51 = mux(_T_15, UInt<1>("h0"), _T_50) @[Lookup.scala 33:37]
    node _T_52 = mux(_T_13, UInt<1>("h0"), _T_51) @[Lookup.scala 33:37]
    node _T_53 = mux(_T_11, UInt<1>("h0"), _T_52) @[Lookup.scala 33:37]
    node _T_54 = mux(_T_9, UInt<1>("h0"), _T_53) @[Lookup.scala 33:37]
    node _T_55 = mux(_T_7, UInt<1>("h1"), _T_54) @[Lookup.scala 33:37]
    node _T_56 = mux(_T_5, UInt<1>("h0"), _T_55) @[Lookup.scala 33:37]
    node _T_57 = mux(_T_3, UInt<1>("h0"), _T_56) @[Lookup.scala 33:37]
    node signals_4 = mux(_T_1, UInt<1>("h0"), _T_57) @[Lookup.scala 33:37]
    node _T_58 = mux(_T_17, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 33:37]
    node _T_59 = mux(_T_15, UInt<1>("h0"), _T_58) @[Lookup.scala 33:37]
    node _T_60 = mux(_T_13, UInt<1>("h0"), _T_59) @[Lookup.scala 33:37]
    node _T_61 = mux(_T_11, UInt<1>("h0"), _T_60) @[Lookup.scala 33:37]
    node _T_62 = mux(_T_9, UInt<1>("h1"), _T_61) @[Lookup.scala 33:37]
    node _T_63 = mux(_T_7, UInt<1>("h0"), _T_62) @[Lookup.scala 33:37]
    node _T_64 = mux(_T_5, UInt<1>("h0"), _T_63) @[Lookup.scala 33:37]
    node _T_65 = mux(_T_3, UInt<1>("h0"), _T_64) @[Lookup.scala 33:37]
    node signals_5 = mux(_T_1, UInt<1>("h0"), _T_65) @[Lookup.scala 33:37]
    node _T_66 = mux(_T_17, UInt<2>("h2"), UInt<1>("h0")) @[Lookup.scala 33:37]
    node _T_67 = mux(_T_15, UInt<1>("h1"), _T_66) @[Lookup.scala 33:37]
    node _T_68 = mux(_T_13, UInt<1>("h0"), _T_67) @[Lookup.scala 33:37]
    node _T_69 = mux(_T_11, UInt<1>("h0"), _T_68) @[Lookup.scala 33:37]
    node _T_70 = mux(_T_9, UInt<1>("h0"), _T_69) @[Lookup.scala 33:37]
    node _T_71 = mux(_T_7, UInt<1>("h0"), _T_70) @[Lookup.scala 33:37]
    node _T_72 = mux(_T_5, UInt<1>("h0"), _T_71) @[Lookup.scala 33:37]
    node _T_73 = mux(_T_3, UInt<1>("h0"), _T_72) @[Lookup.scala 33:37]
    node signals_6 = mux(_T_1, UInt<1>("h0"), _T_73) @[Lookup.scala 33:37]
    node _T_74 = mux(_T_17, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 33:37]
    node _T_75 = mux(_T_15, UInt<1>("h0"), _T_74) @[Lookup.scala 33:37]
    node _T_76 = mux(_T_13, UInt<1>("h0"), _T_75) @[Lookup.scala 33:37]
    node _T_77 = mux(_T_11, UInt<1>("h0"), _T_76) @[Lookup.scala 33:37]
    node _T_78 = mux(_T_9, UInt<1>("h0"), _T_77) @[Lookup.scala 33:37]
    node _T_79 = mux(_T_7, UInt<1>("h0"), _T_78) @[Lookup.scala 33:37]
    node _T_80 = mux(_T_5, UInt<1>("h0"), _T_79) @[Lookup.scala 33:37]
    node _T_81 = mux(_T_3, UInt<2>("h2"), _T_80) @[Lookup.scala 33:37]
    node signals_7 = mux(_T_1, UInt<2>("h2"), _T_81) @[Lookup.scala 33:37]
    node _T_82 = mux(_T_17, UInt<1>("h0"), UInt<1>("h0")) @[Lookup.scala 33:37]
    node _T_83 = mux(_T_15, UInt<1>("h0"), _T_82) @[Lookup.scala 33:37]
    node _T_84 = mux(_T_13, UInt<1>("h1"), _T_83) @[Lookup.scala 33:37]
    node _T_85 = mux(_T_11, UInt<2>("h2"), _T_84) @[Lookup.scala 33:37]
    node _T_86 = mux(_T_9, UInt<1>("h0"), _T_85) @[Lookup.scala 33:37]
    node _T_87 = mux(_T_7, UInt<1>("h0"), _T_86) @[Lookup.scala 33:37]
    node _T_88 = mux(_T_5, UInt<1>("h0"), _T_87) @[Lookup.scala 33:37]
    node _T_89 = mux(_T_3, UInt<1>("h0"), _T_88) @[Lookup.scala 33:37]
    node signals_8 = mux(_T_1, UInt<1>("h0"), _T_89) @[Lookup.scala 33:37]
    io_aluSrc <= signals_0 @[Control.scala 135:13]
    io_memToReg <= signals_1 @[Control.scala 136:15]
    io_regWrite <= signals_2 @[Control.scala 137:15]
    io_memRead <= signals_3 @[Control.scala 138:14]
    io_memWrite <= signals_4 @[Control.scala 139:15]
    io_branch <= signals_5 @[Control.scala 140:13]
    io_aluOp <= signals_7 @[Control.scala 142:12]
    io_jump <= signals_6 @[Control.scala 141:11]
    io_aluSrc1 <= signals_8 @[Control.scala 143:14]

  module Registers :
    input clock : Clock
    input reset : UInt<1>
    input io_readAddress_0 : UInt<5>
    input io_readAddress_1 : UInt<5>
    input io_writeEnable : UInt<1>
    input io_writeAddress : UInt<5>
    input io_writeData : UInt<32>
    output io_readData_0 : UInt<32>
    output io_readData_1 : UInt<32>

    reg reg_0 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_0) @[Registers.scala 14:20]
    reg reg_1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_1) @[Registers.scala 14:20]
    reg reg_2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_2) @[Registers.scala 14:20]
    reg reg_3 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_3) @[Registers.scala 14:20]
    reg reg_4 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_4) @[Registers.scala 14:20]
    reg reg_5 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_5) @[Registers.scala 14:20]
    reg reg_6 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_6) @[Registers.scala 14:20]
    reg reg_7 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_7) @[Registers.scala 14:20]
    reg reg_8 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_8) @[Registers.scala 14:20]
    reg reg_9 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_9) @[Registers.scala 14:20]
    reg reg_10 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_10) @[Registers.scala 14:20]
    reg reg_11 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_11) @[Registers.scala 14:20]
    reg reg_12 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_12) @[Registers.scala 14:20]
    reg reg_13 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_13) @[Registers.scala 14:20]
    reg reg_14 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_14) @[Registers.scala 14:20]
    reg reg_15 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_15) @[Registers.scala 14:20]
    reg reg_16 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_16) @[Registers.scala 14:20]
    reg reg_17 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_17) @[Registers.scala 14:20]
    reg reg_18 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_18) @[Registers.scala 14:20]
    reg reg_19 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_19) @[Registers.scala 14:20]
    reg reg_20 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_20) @[Registers.scala 14:20]
    reg reg_21 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_21) @[Registers.scala 14:20]
    reg reg_22 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_22) @[Registers.scala 14:20]
    reg reg_23 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_23) @[Registers.scala 14:20]
    reg reg_24 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_24) @[Registers.scala 14:20]
    reg reg_25 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_25) @[Registers.scala 14:20]
    reg reg_26 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_26) @[Registers.scala 14:20]
    reg reg_27 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_27) @[Registers.scala 14:20]
    reg reg_28 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_28) @[Registers.scala 14:20]
    reg reg_29 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_29) @[Registers.scala 14:20]
    reg reg_30 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_30) @[Registers.scala 14:20]
    reg reg_31 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_31) @[Registers.scala 14:20]
    node _reg_io_writeAddress = io_writeData @[Registers.scala 17:26 Registers.scala 17:26]
    node _GEN_0 = mux(eq(UInt<1>("h0"), io_writeAddress), _reg_io_writeAddress, reg_0) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_writeAddress), _reg_io_writeAddress, reg_1) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_2 = mux(eq(UInt<2>("h2"), io_writeAddress), _reg_io_writeAddress, reg_2) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_3 = mux(eq(UInt<2>("h3"), io_writeAddress), _reg_io_writeAddress, reg_3) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_4 = mux(eq(UInt<3>("h4"), io_writeAddress), _reg_io_writeAddress, reg_4) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_5 = mux(eq(UInt<3>("h5"), io_writeAddress), _reg_io_writeAddress, reg_5) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_6 = mux(eq(UInt<3>("h6"), io_writeAddress), _reg_io_writeAddress, reg_6) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_7 = mux(eq(UInt<3>("h7"), io_writeAddress), _reg_io_writeAddress, reg_7) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_8 = mux(eq(UInt<4>("h8"), io_writeAddress), _reg_io_writeAddress, reg_8) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_9 = mux(eq(UInt<4>("h9"), io_writeAddress), _reg_io_writeAddress, reg_9) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_10 = mux(eq(UInt<4>("ha"), io_writeAddress), _reg_io_writeAddress, reg_10) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_11 = mux(eq(UInt<4>("hb"), io_writeAddress), _reg_io_writeAddress, reg_11) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_12 = mux(eq(UInt<4>("hc"), io_writeAddress), _reg_io_writeAddress, reg_12) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_13 = mux(eq(UInt<4>("hd"), io_writeAddress), _reg_io_writeAddress, reg_13) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_14 = mux(eq(UInt<4>("he"), io_writeAddress), _reg_io_writeAddress, reg_14) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_15 = mux(eq(UInt<4>("hf"), io_writeAddress), _reg_io_writeAddress, reg_15) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_16 = mux(eq(UInt<5>("h10"), io_writeAddress), _reg_io_writeAddress, reg_16) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_17 = mux(eq(UInt<5>("h11"), io_writeAddress), _reg_io_writeAddress, reg_17) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_18 = mux(eq(UInt<5>("h12"), io_writeAddress), _reg_io_writeAddress, reg_18) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_19 = mux(eq(UInt<5>("h13"), io_writeAddress), _reg_io_writeAddress, reg_19) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_20 = mux(eq(UInt<5>("h14"), io_writeAddress), _reg_io_writeAddress, reg_20) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_21 = mux(eq(UInt<5>("h15"), io_writeAddress), _reg_io_writeAddress, reg_21) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_22 = mux(eq(UInt<5>("h16"), io_writeAddress), _reg_io_writeAddress, reg_22) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_23 = mux(eq(UInt<5>("h17"), io_writeAddress), _reg_io_writeAddress, reg_23) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_24 = mux(eq(UInt<5>("h18"), io_writeAddress), _reg_io_writeAddress, reg_24) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_25 = mux(eq(UInt<5>("h19"), io_writeAddress), _reg_io_writeAddress, reg_25) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_26 = mux(eq(UInt<5>("h1a"), io_writeAddress), _reg_io_writeAddress, reg_26) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_27 = mux(eq(UInt<5>("h1b"), io_writeAddress), _reg_io_writeAddress, reg_27) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_28 = mux(eq(UInt<5>("h1c"), io_writeAddress), _reg_io_writeAddress, reg_28) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_29 = mux(eq(UInt<5>("h1d"), io_writeAddress), _reg_io_writeAddress, reg_29) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_30 = mux(eq(UInt<5>("h1e"), io_writeAddress), _reg_io_writeAddress, reg_30) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_31 = mux(eq(UInt<5>("h1f"), io_writeAddress), _reg_io_writeAddress, reg_31) @[Registers.scala 17:26 Registers.scala 17:26 Registers.scala 14:20]
    node _GEN_32 = mux(io_writeEnable, _GEN_0, reg_0) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_33 = mux(io_writeEnable, _GEN_1, reg_1) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_34 = mux(io_writeEnable, _GEN_2, reg_2) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_35 = mux(io_writeEnable, _GEN_3, reg_3) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_36 = mux(io_writeEnable, _GEN_4, reg_4) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_37 = mux(io_writeEnable, _GEN_5, reg_5) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_38 = mux(io_writeEnable, _GEN_6, reg_6) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_39 = mux(io_writeEnable, _GEN_7, reg_7) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_40 = mux(io_writeEnable, _GEN_8, reg_8) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_41 = mux(io_writeEnable, _GEN_9, reg_9) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_42 = mux(io_writeEnable, _GEN_10, reg_10) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_43 = mux(io_writeEnable, _GEN_11, reg_11) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_44 = mux(io_writeEnable, _GEN_12, reg_12) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_45 = mux(io_writeEnable, _GEN_13, reg_13) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_46 = mux(io_writeEnable, _GEN_14, reg_14) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_47 = mux(io_writeEnable, _GEN_15, reg_15) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_48 = mux(io_writeEnable, _GEN_16, reg_16) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_49 = mux(io_writeEnable, _GEN_17, reg_17) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_50 = mux(io_writeEnable, _GEN_18, reg_18) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_51 = mux(io_writeEnable, _GEN_19, reg_19) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_52 = mux(io_writeEnable, _GEN_20, reg_20) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_53 = mux(io_writeEnable, _GEN_21, reg_21) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_54 = mux(io_writeEnable, _GEN_22, reg_22) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_55 = mux(io_writeEnable, _GEN_23, reg_23) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_56 = mux(io_writeEnable, _GEN_24, reg_24) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_57 = mux(io_writeEnable, _GEN_25, reg_25) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_58 = mux(io_writeEnable, _GEN_26, reg_26) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_59 = mux(io_writeEnable, _GEN_27, reg_27) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_60 = mux(io_writeEnable, _GEN_28, reg_28) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_61 = mux(io_writeEnable, _GEN_29, reg_29) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_62 = mux(io_writeEnable, _GEN_30, reg_30) @[Registers.scala 16:24 Registers.scala 14:20]
    node _GEN_63 = mux(io_writeEnable, _GEN_31, reg_31) @[Registers.scala 16:24 Registers.scala 14:20]
    node _T = eq(io_readAddress_0, UInt<1>("h0")) @[Registers.scala 20:28]
    node _GEN_64 = validif(eq(UInt<1>("h0"), io_readAddress_0), reg_0) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_65 = mux(eq(UInt<1>("h1"), io_readAddress_0), reg_1, _GEN_64) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_66 = mux(eq(UInt<2>("h2"), io_readAddress_0), reg_2, _GEN_65) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_67 = mux(eq(UInt<2>("h3"), io_readAddress_0), reg_3, _GEN_66) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_68 = mux(eq(UInt<3>("h4"), io_readAddress_0), reg_4, _GEN_67) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_69 = mux(eq(UInt<3>("h5"), io_readAddress_0), reg_5, _GEN_68) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_70 = mux(eq(UInt<3>("h6"), io_readAddress_0), reg_6, _GEN_69) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_71 = mux(eq(UInt<3>("h7"), io_readAddress_0), reg_7, _GEN_70) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_72 = mux(eq(UInt<4>("h8"), io_readAddress_0), reg_8, _GEN_71) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_73 = mux(eq(UInt<4>("h9"), io_readAddress_0), reg_9, _GEN_72) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_74 = mux(eq(UInt<4>("ha"), io_readAddress_0), reg_10, _GEN_73) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_75 = mux(eq(UInt<4>("hb"), io_readAddress_0), reg_11, _GEN_74) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_76 = mux(eq(UInt<4>("hc"), io_readAddress_0), reg_12, _GEN_75) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_77 = mux(eq(UInt<4>("hd"), io_readAddress_0), reg_13, _GEN_76) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_78 = mux(eq(UInt<4>("he"), io_readAddress_0), reg_14, _GEN_77) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_79 = mux(eq(UInt<4>("hf"), io_readAddress_0), reg_15, _GEN_78) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_80 = mux(eq(UInt<5>("h10"), io_readAddress_0), reg_16, _GEN_79) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_81 = mux(eq(UInt<5>("h11"), io_readAddress_0), reg_17, _GEN_80) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_82 = mux(eq(UInt<5>("h12"), io_readAddress_0), reg_18, _GEN_81) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_83 = mux(eq(UInt<5>("h13"), io_readAddress_0), reg_19, _GEN_82) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_84 = mux(eq(UInt<5>("h14"), io_readAddress_0), reg_20, _GEN_83) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_85 = mux(eq(UInt<5>("h15"), io_readAddress_0), reg_21, _GEN_84) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_86 = mux(eq(UInt<5>("h16"), io_readAddress_0), reg_22, _GEN_85) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_87 = mux(eq(UInt<5>("h17"), io_readAddress_0), reg_23, _GEN_86) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_88 = mux(eq(UInt<5>("h18"), io_readAddress_0), reg_24, _GEN_87) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_89 = mux(eq(UInt<5>("h19"), io_readAddress_0), reg_25, _GEN_88) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_90 = mux(eq(UInt<5>("h1a"), io_readAddress_0), reg_26, _GEN_89) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_91 = mux(eq(UInt<5>("h1b"), io_readAddress_0), reg_27, _GEN_90) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_92 = mux(eq(UInt<5>("h1c"), io_readAddress_0), reg_28, _GEN_91) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_93 = mux(eq(UInt<5>("h1d"), io_readAddress_0), reg_29, _GEN_92) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_94 = mux(eq(UInt<5>("h1e"), io_readAddress_0), reg_30, _GEN_93) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_95 = mux(eq(UInt<5>("h1f"), io_readAddress_0), reg_31, _GEN_94) @[Registers.scala 23:22 Registers.scala 23:22]
    node _reg_io_readAddress_0 = _GEN_95 @[Registers.scala 23:22]
    node _GEN_96 = mux(_T, UInt<1>("h0"), _reg_io_readAddress_0) @[Registers.scala 20:37 Registers.scala 21:22 Registers.scala 23:22]
    node _T_1 = eq(io_readAddress_1, UInt<1>("h0")) @[Registers.scala 20:28]
    node _GEN_97 = validif(eq(UInt<1>("h0"), io_readAddress_1), reg_0) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_98 = mux(eq(UInt<1>("h1"), io_readAddress_1), reg_1, _GEN_97) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_99 = mux(eq(UInt<2>("h2"), io_readAddress_1), reg_2, _GEN_98) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_100 = mux(eq(UInt<2>("h3"), io_readAddress_1), reg_3, _GEN_99) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_101 = mux(eq(UInt<3>("h4"), io_readAddress_1), reg_4, _GEN_100) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_102 = mux(eq(UInt<3>("h5"), io_readAddress_1), reg_5, _GEN_101) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_103 = mux(eq(UInt<3>("h6"), io_readAddress_1), reg_6, _GEN_102) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_104 = mux(eq(UInt<3>("h7"), io_readAddress_1), reg_7, _GEN_103) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_105 = mux(eq(UInt<4>("h8"), io_readAddress_1), reg_8, _GEN_104) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_106 = mux(eq(UInt<4>("h9"), io_readAddress_1), reg_9, _GEN_105) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_107 = mux(eq(UInt<4>("ha"), io_readAddress_1), reg_10, _GEN_106) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_108 = mux(eq(UInt<4>("hb"), io_readAddress_1), reg_11, _GEN_107) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_109 = mux(eq(UInt<4>("hc"), io_readAddress_1), reg_12, _GEN_108) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_110 = mux(eq(UInt<4>("hd"), io_readAddress_1), reg_13, _GEN_109) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_111 = mux(eq(UInt<4>("he"), io_readAddress_1), reg_14, _GEN_110) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_112 = mux(eq(UInt<4>("hf"), io_readAddress_1), reg_15, _GEN_111) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_113 = mux(eq(UInt<5>("h10"), io_readAddress_1), reg_16, _GEN_112) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_114 = mux(eq(UInt<5>("h11"), io_readAddress_1), reg_17, _GEN_113) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_115 = mux(eq(UInt<5>("h12"), io_readAddress_1), reg_18, _GEN_114) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_116 = mux(eq(UInt<5>("h13"), io_readAddress_1), reg_19, _GEN_115) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_117 = mux(eq(UInt<5>("h14"), io_readAddress_1), reg_20, _GEN_116) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_118 = mux(eq(UInt<5>("h15"), io_readAddress_1), reg_21, _GEN_117) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_119 = mux(eq(UInt<5>("h16"), io_readAddress_1), reg_22, _GEN_118) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_120 = mux(eq(UInt<5>("h17"), io_readAddress_1), reg_23, _GEN_119) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_121 = mux(eq(UInt<5>("h18"), io_readAddress_1), reg_24, _GEN_120) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_122 = mux(eq(UInt<5>("h19"), io_readAddress_1), reg_25, _GEN_121) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_123 = mux(eq(UInt<5>("h1a"), io_readAddress_1), reg_26, _GEN_122) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_124 = mux(eq(UInt<5>("h1b"), io_readAddress_1), reg_27, _GEN_123) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_125 = mux(eq(UInt<5>("h1c"), io_readAddress_1), reg_28, _GEN_124) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_126 = mux(eq(UInt<5>("h1d"), io_readAddress_1), reg_29, _GEN_125) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_127 = mux(eq(UInt<5>("h1e"), io_readAddress_1), reg_30, _GEN_126) @[Registers.scala 23:22 Registers.scala 23:22]
    node _GEN_128 = mux(eq(UInt<5>("h1f"), io_readAddress_1), reg_31, _GEN_127) @[Registers.scala 23:22 Registers.scala 23:22]
    node _reg_io_readAddress_1 = _GEN_128 @[Registers.scala 23:22]
    node _GEN_129 = mux(_T_1, UInt<1>("h0"), _reg_io_readAddress_1) @[Registers.scala 20:37 Registers.scala 21:22 Registers.scala 23:22]
    node _WIRE_0 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_1 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_2 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_3 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_4 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_5 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_6 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_7 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_8 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_9 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_10 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_11 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_12 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_13 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_14 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_15 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_16 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_17 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_18 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_19 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_20 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_21 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_22 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_23 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_24 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_25 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_26 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_27 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_28 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_29 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_30 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    node _WIRE_31 = UInt<32>("h0") @[Registers.scala 14:28 Registers.scala 14:28]
    io_readData_0 <= _GEN_96
    io_readData_1 <= _GEN_129
    reg_0 <= mux(reset, _WIRE_0, _GEN_32) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_1 <= mux(reset, _WIRE_1, _GEN_33) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_2 <= mux(reset, _WIRE_2, _GEN_34) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_3 <= mux(reset, _WIRE_3, _GEN_35) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_4 <= mux(reset, _WIRE_4, _GEN_36) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_5 <= mux(reset, _WIRE_5, _GEN_37) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_6 <= mux(reset, _WIRE_6, _GEN_38) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_7 <= mux(reset, _WIRE_7, _GEN_39) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_8 <= mux(reset, _WIRE_8, _GEN_40) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_9 <= mux(reset, _WIRE_9, _GEN_41) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_10 <= mux(reset, _WIRE_10, _GEN_42) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_11 <= mux(reset, _WIRE_11, _GEN_43) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_12 <= mux(reset, _WIRE_12, _GEN_44) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_13 <= mux(reset, _WIRE_13, _GEN_45) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_14 <= mux(reset, _WIRE_14, _GEN_46) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_15 <= mux(reset, _WIRE_15, _GEN_47) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_16 <= mux(reset, _WIRE_16, _GEN_48) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_17 <= mux(reset, _WIRE_17, _GEN_49) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_18 <= mux(reset, _WIRE_18, _GEN_50) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_19 <= mux(reset, _WIRE_19, _GEN_51) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_20 <= mux(reset, _WIRE_20, _GEN_52) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_21 <= mux(reset, _WIRE_21, _GEN_53) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_22 <= mux(reset, _WIRE_22, _GEN_54) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_23 <= mux(reset, _WIRE_23, _GEN_55) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_24 <= mux(reset, _WIRE_24, _GEN_56) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_25 <= mux(reset, _WIRE_25, _GEN_57) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_26 <= mux(reset, _WIRE_26, _GEN_58) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_27 <= mux(reset, _WIRE_27, _GEN_59) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_28 <= mux(reset, _WIRE_28, _GEN_60) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_29 <= mux(reset, _WIRE_29, _GEN_61) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_30 <= mux(reset, _WIRE_30, _GEN_62) @[Registers.scala 14:20 Registers.scala 14:20]
    reg_31 <= mux(reset, _WIRE_31, _GEN_63) @[Registers.scala 14:20 Registers.scala 14:20]

  module ImmediateGen :
    input clock : Clock
    input reset : UInt<1>
    input io_instruction : UInt<32>
    output io_out : UInt<32>

    node opcode = bits(io_instruction, 6, 0) @[ImmediateGen.scala 11:30]
    node _T = eq(opcode, UInt<2>("h3")) @[ImmediateGen.scala 15:12]
    node _T_1 = eq(opcode, UInt<4>("hf")) @[ImmediateGen.scala 15:30]
    node _T_2 = or(_T, _T_1) @[ImmediateGen.scala 15:20]
    node _T_3 = eq(opcode, UInt<5>("h13")) @[ImmediateGen.scala 15:49]
    node _T_4 = or(_T_2, _T_3) @[ImmediateGen.scala 15:39]
    node _T_5 = eq(opcode, UInt<5>("h1b")) @[ImmediateGen.scala 15:68]
    node _T_6 = or(_T_4, _T_5) @[ImmediateGen.scala 15:58]
    node _T_7 = eq(opcode, UInt<7>("h67")) @[ImmediateGen.scala 15:87]
    node _T_8 = or(_T_6, _T_7) @[ImmediateGen.scala 15:77]
    node _T_9 = eq(opcode, UInt<7>("h73")) @[ImmediateGen.scala 15:107]
    node _T_10 = or(_T_8, _T_9) @[ImmediateGen.scala 15:97]
    node lo = bits(io_instruction, 31, 20) @[ImmediateGen.scala 17:31]
    node _T_11 = bits(lo, 11, 11) @[ImmediateGen.scala 18:35]
    node _T_12 = bits(_T_11, 0, 0) @[Bitwise.scala 72:15]
    node hi = mux(_T_12, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 72:12]
    node _T_13 = cat(hi, lo) @[Cat.scala 30:58]
    node _T_14 = eq(opcode, UInt<5>("h17")) @[ImmediateGen.scala 23:22]
    node _T_15 = eq(opcode, UInt<6>("h37")) @[ImmediateGen.scala 23:41]
    node _T_16 = or(_T_14, _T_15) @[ImmediateGen.scala 23:31]
    node hi_1 = bits(io_instruction, 31, 12) @[ImmediateGen.scala 24:33]
    node lo_1 = mux(UInt<1>("h0"), UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 72:12]
    node _T_17 = cat(hi_1, lo_1) @[Cat.scala 30:58]
    node _T_18 = eq(opcode, UInt<6>("h23")) @[ImmediateGen.scala 29:22]
    node hi_2 = bits(io_instruction, 31, 25) @[ImmediateGen.scala 30:37]
    node lo_2 = bits(io_instruction, 11, 7) @[ImmediateGen.scala 30:61]
    node lo_3 = cat(hi_2, lo_2) @[Cat.scala 30:58]
    node _T_19 = bits(lo_3, 11, 11) @[ImmediateGen.scala 31:37]
    node _T_20 = bits(_T_19, 0, 0) @[Bitwise.scala 72:15]
    node hi_3 = mux(_T_20, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 72:12]
    node _T_21 = cat(hi_3, lo_3) @[Cat.scala 30:58]
    node _T_22 = eq(opcode, UInt<7>("h63")) @[ImmediateGen.scala 35:22]
    node hi_hi = bits(io_instruction, 31, 31) @[ImmediateGen.scala 37:23]
    node hi_lo = bits(io_instruction, 7, 7) @[ImmediateGen.scala 38:23]
    node lo_hi = bits(io_instruction, 30, 25) @[ImmediateGen.scala 39:23]
    node lo_lo = bits(io_instruction, 11, 8) @[ImmediateGen.scala 40:23]
    node lo_4 = cat(lo_hi, lo_lo) @[Cat.scala 30:58]
    node hi_4 = cat(hi_hi, hi_lo) @[Cat.scala 30:58]
    node hi_lo_1 = cat(hi_4, lo_4) @[Cat.scala 30:58]
    node _T_23 = bits(hi_lo_1, 11, 11) @[ImmediateGen.scala 42:39]
    node _T_24 = bits(_T_23, 0, 0) @[Bitwise.scala 72:15]
    node hi_hi_1 = mux(_T_24, UInt<19>("h7ffff"), UInt<19>("h0")) @[Bitwise.scala 72:12]
    node hi_5 = cat(hi_hi_1, hi_lo_1) @[Cat.scala 30:58]
    node _T_25 = cat(hi_5, UInt<1>("h0")) @[Cat.scala 30:58]
    node hi_hi_2 = bits(io_instruction, 31, 31) @[ImmediateGen.scala 49:21]
    node hi_lo_2 = bits(io_instruction, 19, 12) @[ImmediateGen.scala 50:21]
    node lo_hi_1 = bits(io_instruction, 20, 20) @[ImmediateGen.scala 51:21]
    node lo_lo_1 = bits(io_instruction, 30, 21) @[ImmediateGen.scala 52:21]
    node lo_5 = cat(lo_hi_1, lo_lo_1) @[Cat.scala 30:58]
    node hi_6 = cat(hi_hi_2, hi_lo_2) @[Cat.scala 30:58]
    node hi_lo_3 = cat(hi_6, lo_5) @[Cat.scala 30:58]
    node _T_26 = bits(hi_lo_3, 19, 19) @[ImmediateGen.scala 54:37]
    node _T_27 = bits(_T_26, 0, 0) @[Bitwise.scala 72:15]
    node hi_hi_3 = mux(_T_27, UInt<11>("h7ff"), UInt<11>("h0")) @[Bitwise.scala 72:12]
    node hi_7 = cat(hi_hi_3, hi_lo_3) @[Cat.scala 30:58]
    node _T_28 = cat(hi_7, UInt<1>("h0")) @[Cat.scala 30:58]
    node _GEN_0 = mux(_T_22, _T_25, _T_28) @[ImmediateGen.scala 35:32 ImmediateGen.scala 43:14 ImmediateGen.scala 55:12]
    node _GEN_1 = mux(_T_18, _T_21, _GEN_0) @[ImmediateGen.scala 29:32 ImmediateGen.scala 32:14]
    node _GEN_2 = mux(_T_16, _T_17, _GEN_1) @[ImmediateGen.scala 23:51 ImmediateGen.scala 26:14]
    node _GEN_3 = mux(_T_10, _T_13, _GEN_2) @[ImmediateGen.scala 16:5 ImmediateGen.scala 19:12]
    io_out <= _GEN_3

  module BranchUnit :
    input clock : Clock
    input reset : UInt<1>
    input io_branch : UInt<1>
    input io_funct3 : UInt<3>
    input io_rd1 : UInt<32>
    input io_rd2 : UInt<32>
    input io_take_branch : UInt<1>
    output io_taken : UInt<1>

    node _T = eq(UInt<1>("h0"), io_funct3) @[Conditional.scala 37:30]
    node _T_1 = eq(io_rd1, io_rd2) @[BranchUnit.scala 23:32]
    node _T_2 = eq(UInt<1>("h1"), io_funct3) @[Conditional.scala 37:30]
    node _T_3 = neq(io_rd1, io_rd2) @[BranchUnit.scala 24:32]
    node _T_4 = eq(UInt<3>("h4"), io_funct3) @[Conditional.scala 37:30]
    node _T_5 = asSInt(io_rd1) @[BranchUnit.scala 25:32]
    node _T_6 = asSInt(io_rd2) @[BranchUnit.scala 25:48]
    node _T_7 = lt(_T_5, _T_6) @[BranchUnit.scala 25:39]
    node _T_8 = eq(UInt<3>("h5"), io_funct3) @[Conditional.scala 37:30]
    node _T_9 = asSInt(io_rd1) @[BranchUnit.scala 26:32]
    node _T_10 = asSInt(io_rd2) @[BranchUnit.scala 26:49]
    node _T_11 = geq(_T_9, _T_10) @[BranchUnit.scala 26:39]
    node _T_12 = eq(UInt<3>("h6"), io_funct3) @[Conditional.scala 37:30]
    node _T_13 = lt(io_rd1, io_rd2) @[BranchUnit.scala 27:32]
    node _T_14 = eq(UInt<3>("h7"), io_funct3) @[Conditional.scala 37:30]
    node _T_15 = geq(io_rd1, io_rd2) @[BranchUnit.scala 28:32]
    node _GEN_0 = validif(_T_14, _T_15) @[Conditional.scala 39:67 BranchUnit.scala 28:21]
    node _GEN_1 = mux(_T_12, _T_13, _GEN_0) @[Conditional.scala 39:67 BranchUnit.scala 27:21]
    node _GEN_2 = mux(_T_8, _T_11, _GEN_1) @[Conditional.scala 39:67 BranchUnit.scala 26:21]
    node _GEN_3 = mux(_T_4, _T_7, _GEN_2) @[Conditional.scala 39:67 BranchUnit.scala 25:21]
    node _GEN_4 = mux(_T_2, _T_3, _GEN_3) @[Conditional.scala 39:67 BranchUnit.scala 24:21]
    node _GEN_5 = mux(_T, _T_1, _GEN_4) @[Conditional.scala 40:58 BranchUnit.scala 23:21]
    node check = _GEN_5 @[BranchUnit.scala 19:25]
    node _T_16 = and(check, io_branch) @[BranchUnit.scala 31:21]
    node _T_17 = and(_T_16, io_take_branch) @[BranchUnit.scala 31:33]
    io_taken <= _T_17 @[BranchUnit.scala 31:12]

  module InstructionDecode :
    input clock : Clock
    input reset : UInt<1>
    input io_id_instruction : UInt<32>
    input io_writeData : UInt<32>
    input io_writeReg : UInt<5>
    input io_pcAddress : UInt<32>
    input io_ctl_writeEnable : UInt<1>
    input io_id_ex_mem_read : UInt<1>
    input io_ex_mem_mem_read : UInt<1>
    input io_dmem_resp_valid : UInt<1>
    input io_id_ex_rd : UInt<5>
    input io_ex_mem_rd : UInt<5>
    input io_id_ex_branch : UInt<1>
    input io_ex_mem_ins : UInt<32>
    input io_mem_wb_ins : UInt<32>
    input io_ex_ins : UInt<32>
    input io_ex_result : UInt<32>
    input io_ex_mem_result : UInt<32>
    input io_mem_wb_result : UInt<32>
    output io_immediate : UInt<32>
    output io_writeRegAddress : UInt<5>
    output io_readData1 : UInt<32>
    output io_readData2 : UInt<32>
    output io_func7 : UInt<1>
    output io_func3 : UInt<3>
    output io_ctl_aluSrc : UInt<1>
    output io_ctl_memToReg : UInt<2>
    output io_ctl_regWrite : UInt<1>
    output io_ctl_memRead : UInt<1>
    output io_ctl_memWrite : UInt<1>
    output io_ctl_branch : UInt<1>
    output io_ctl_aluOp : UInt<2>
    output io_ctl_jump : UInt<2>
    output io_ctl_aluSrc1 : UInt<2>
    output io_hdu_pcWrite : UInt<1>
    output io_hdu_if_reg_write : UInt<1>
    output io_pcSrc : UInt<1>
    output io_pcPlusOffset : UInt<32>
    output io_ifid_flush : UInt<1>

    inst hdu of HazardUnit @[InstructionDecode.scala 51:19]
    inst control of Control @[InstructionDecode.scala 67:23]
    inst registers of Registers @[InstructionDecode.scala 86:25]
    inst immediate of ImmediateGen @[InstructionDecode.scala 117:25]
    inst bu of BranchUnit @[InstructionDecode.scala 143:18]
    node _T = bits(io_id_instruction, 19, 15) @[InstructionDecode.scala 59:37]
    node _T_1 = bits(io_id_instruction, 24, 20) @[InstructionDecode.scala 60:37]
    node _T_2 = neq(io_id_instruction, UInt<5>("h13")) @[InstructionDecode.scala 76:44]
    node _T_3 = and(hdu.io_ctl_mux, _T_2) @[InstructionDecode.scala 76:23]
    node _GEN_0 = mux(_T_3, control.io_memWrite, UInt<1>("h0")) @[InstructionDecode.scala 76:57 InstructionDecode.scala 77:21 InstructionDecode.scala 81:21]
    node _GEN_1 = mux(_T_3, control.io_regWrite, UInt<1>("h0")) @[InstructionDecode.scala 76:57 InstructionDecode.scala 78:21 InstructionDecode.scala 82:21]
    node registerRs1 = bits(io_id_instruction, 19, 15) @[InstructionDecode.scala 88:38]
    node registerRs2 = bits(io_id_instruction, 24, 20) @[InstructionDecode.scala 89:38]
    node _T_4 = eq(io_writeReg, registerRs1) @[InstructionDecode.scala 97:43]
    node _T_5 = and(io_ctl_writeEnable, _T_4) @[InstructionDecode.scala 97:27]
    node _T_6 = eq(registerRs1, UInt<1>("h0")) @[InstructionDecode.scala 98:22]
    node _GEN_2 = mux(_T_6, UInt<1>("h0"), io_writeData) @[InstructionDecode.scala 98:30 InstructionDecode.scala 99:20 InstructionDecode.scala 101:20]
    node _GEN_3 = mux(_T_5, _GEN_2, registers.io_readData_0) @[InstructionDecode.scala 97:60 InstructionDecode.scala 104:18]
    node _T_7 = eq(io_writeReg, registerRs2) @[InstructionDecode.scala 106:43]
    node _T_8 = and(io_ctl_writeEnable, _T_7) @[InstructionDecode.scala 106:27]
    node _T_9 = eq(registerRs2, UInt<1>("h0")) @[InstructionDecode.scala 107:22]
    node _GEN_4 = mux(_T_9, UInt<1>("h0"), io_writeData) @[InstructionDecode.scala 107:30 InstructionDecode.scala 108:20 InstructionDecode.scala 110:20]
    node _GEN_5 = mux(_T_8, _GEN_4, registers.io_readData_1) @[InstructionDecode.scala 106:60 InstructionDecode.scala 113:18]
    node _T_10 = bits(io_ex_mem_ins, 11, 7) @[InstructionDecode.scala 125:37]
    node _T_11 = eq(registerRs1, _T_10) @[InstructionDecode.scala 125:20]
    node _T_12 = bits(io_mem_wb_ins, 11, 7) @[InstructionDecode.scala 127:43]
    node _T_13 = eq(registerRs1, _T_12) @[InstructionDecode.scala 127:26]
    node _GEN_6 = mux(_T_13, io_mem_wb_result, io_readData1) @[InstructionDecode.scala 127:52 InstructionDecode.scala 128:14 InstructionDecode.scala 131:14]
    node _GEN_7 = mux(_T_11, io_ex_mem_result, _GEN_6) @[InstructionDecode.scala 125:46 InstructionDecode.scala 126:12]
    node _T_14 = bits(io_ex_mem_ins, 11, 7) @[InstructionDecode.scala 133:37]
    node _T_15 = eq(registerRs2, _T_14) @[InstructionDecode.scala 133:20]
    node _T_16 = bits(io_mem_wb_ins, 11, 7) @[InstructionDecode.scala 135:43]
    node _T_17 = eq(registerRs2, _T_16) @[InstructionDecode.scala 135:26]
    node _GEN_8 = mux(_T_17, io_mem_wb_result, io_readData2) @[InstructionDecode.scala 135:52 InstructionDecode.scala 136:14 InstructionDecode.scala 139:14]
    node _GEN_9 = mux(_T_15, io_ex_mem_result, _GEN_8) @[InstructionDecode.scala 133:46 InstructionDecode.scala 134:12]
    node _T_18 = bits(io_id_instruction, 14, 12) @[InstructionDecode.scala 145:36]
    node _T_19 = bits(io_ex_ins, 11, 7) @[InstructionDecode.scala 153:35]
    node _T_20 = eq(registerRs1, _T_19) @[InstructionDecode.scala 153:22]
    node _T_21 = bits(io_ex_mem_ins, 11, 7) @[InstructionDecode.scala 155:45]
    node _T_22 = eq(registerRs1, _T_21) @[InstructionDecode.scala 155:28]
    node _T_23 = bits(io_mem_wb_ins, 11, 7) @[InstructionDecode.scala 157:43]
    node _T_24 = eq(registerRs1, _T_23) @[InstructionDecode.scala 157:26]
    node _T_25 = bits(io_ex_ins, 11, 7) @[InstructionDecode.scala 159:39]
    node _T_26 = eq(registerRs1, _T_25) @[InstructionDecode.scala 159:26]
    node _GEN_10 = mux(_T_26, io_ex_result, io_readData1) @[InstructionDecode.scala 159:47 InstructionDecode.scala 160:14 InstructionDecode.scala 162:16]
    node _GEN_11 = mux(_T_24, io_mem_wb_result, _GEN_10) @[InstructionDecode.scala 157:52 InstructionDecode.scala 158:14]
    node _GEN_12 = mux(_T_22, io_ex_mem_result, _GEN_11) @[InstructionDecode.scala 155:54 InstructionDecode.scala 156:14]
    node _GEN_13 = mux(_T_20, io_ex_result, _GEN_12) @[InstructionDecode.scala 153:43 InstructionDecode.scala 154:16]
    node _T_27 = eq(io_ctl_jump, UInt<1>("h1")) @[InstructionDecode.scala 166:20]
    node _T_28 = add(io_pcAddress, io_immediate) @[InstructionDecode.scala 167:37]
    node _T_29 = tail(_T_28, 1) @[InstructionDecode.scala 167:37]
    node _T_30 = eq(io_ctl_jump, UInt<2>("h2")) @[InstructionDecode.scala 168:26]
    node j_offset = _GEN_13 @[InstructionDecode.scala 152:22]
    node _T_31 = add(j_offset, io_immediate) @[InstructionDecode.scala 169:35]
    node _T_32 = tail(_T_31, 1) @[InstructionDecode.scala 169:35]
    node _T_33 = add(io_pcAddress, immediate.io_out) @[InstructionDecode.scala 172:39]
    node _T_34 = tail(_T_33, 1) @[InstructionDecode.scala 172:39]
    node _GEN_14 = mux(_T_30, _T_32, _T_34) @[InstructionDecode.scala 168:35 InstructionDecode.scala 169:23 InstructionDecode.scala 172:23]
    node _GEN_15 = mux(_T_27, _T_29, _GEN_14) @[InstructionDecode.scala 166:29 InstructionDecode.scala 167:21]
    node _T_35 = neq(io_ctl_jump, UInt<1>("h0")) @[InstructionDecode.scala 175:35]
    node _T_36 = or(bu.io_taken, _T_35) @[InstructionDecode.scala 175:20]
    node _GEN_16 = mux(_T_36, UInt<1>("h1"), UInt<1>("h0")) @[InstructionDecode.scala 175:44 InstructionDecode.scala 176:14 InstructionDecode.scala 178:14]
    node _T_37 = bits(io_id_instruction, 11, 7) @[InstructionDecode.scala 184:42]
    node _T_38 = bits(io_id_instruction, 14, 12) @[InstructionDecode.scala 185:32]
    node _T_39 = bits(io_id_instruction, 30, 30) @[InstructionDecode.scala 186:32]
    node input1 = _GEN_7 @[InstructionDecode.scala 122:20]
    node input2 = _GEN_9 @[InstructionDecode.scala 123:20]
    io_immediate <= immediate.io_out @[InstructionDecode.scala 119:16]
    io_writeRegAddress <= _T_37 @[InstructionDecode.scala 184:22]
    io_readData1 <= _GEN_3
    io_readData2 <= _GEN_5
    io_func7 <= _T_39 @[InstructionDecode.scala 186:12]
    io_func3 <= _T_38 @[InstructionDecode.scala 185:12]
    io_ctl_aluSrc <= control.io_aluSrc @[InstructionDecode.scala 70:17]
    io_ctl_memToReg <= control.io_memToReg @[InstructionDecode.scala 74:19]
    io_ctl_regWrite <= _GEN_1
    io_ctl_memRead <= control.io_memRead @[InstructionDecode.scala 73:18]
    io_ctl_memWrite <= _GEN_0
    io_ctl_branch <= control.io_branch @[InstructionDecode.scala 72:17]
    io_ctl_aluOp <= control.io_aluOp @[InstructionDecode.scala 69:16]
    io_ctl_jump <= control.io_jump @[InstructionDecode.scala 75:15]
    io_ctl_aluSrc1 <= control.io_aluSrc1 @[InstructionDecode.scala 71:18]
    io_hdu_pcWrite <= hdu.io_pc_write @[InstructionDecode.scala 63:18]
    io_hdu_if_reg_write <= hdu.io_if_reg_write @[InstructionDecode.scala 64:23]
    io_pcSrc <= _GEN_16
    io_pcPlusOffset <= _GEN_15
    io_ifid_flush <= hdu.io_ifid_flush @[InstructionDecode.scala 182:17]
    hdu.clock <= clock
    hdu.reset <= reset
    hdu.io_id_ex_memRead <= io_id_ex_mem_read @[InstructionDecode.scala 53:24]
    hdu.io_ex_mem_memRead <= io_ex_mem_mem_read @[InstructionDecode.scala 55:25]
    hdu.io_id_ex_branch <= io_id_ex_branch @[InstructionDecode.scala 57:23]
    hdu.io_id_ex_rd <= io_id_ex_rd @[InstructionDecode.scala 56:19]
    hdu.io_ex_mem_rd <= io_ex_mem_rd @[InstructionDecode.scala 58:20]
    hdu.io_id_rs1 <= _T @[InstructionDecode.scala 59:17]
    hdu.io_id_rs2 <= _T_1 @[InstructionDecode.scala 60:17]
    hdu.io_dmem_resp_valid <= io_dmem_resp_valid @[InstructionDecode.scala 52:26]
    hdu.io_taken <= bu.io_taken @[InstructionDecode.scala 149:16]
    hdu.io_jump <= io_ctl_jump @[InstructionDecode.scala 61:15]
    hdu.io_branch <= io_ctl_branch @[InstructionDecode.scala 62:17]
    control.clock <= clock
    control.reset <= reset
    control.io_in <= io_id_instruction @[InstructionDecode.scala 68:17]
    registers.clock <= clock
    registers.reset <= reset
    registers.io_readAddress_0 <= registerRs1 @[InstructionDecode.scala 90:31]
    registers.io_readAddress_1 <= registerRs2 @[InstructionDecode.scala 91:31]
    registers.io_writeEnable <= io_ctl_writeEnable @[InstructionDecode.scala 92:28]
    registers.io_writeAddress <= io_writeReg @[InstructionDecode.scala 93:29]
    registers.io_writeData <= io_writeData @[InstructionDecode.scala 94:26]
    immediate.clock <= clock
    immediate.reset <= reset
    immediate.io_instruction <= io_id_instruction @[InstructionDecode.scala 118:28]
    bu.clock <= clock
    bu.reset <= reset
    bu.io_branch <= io_ctl_branch @[InstructionDecode.scala 144:16]
    bu.io_funct3 <= _T_18 @[InstructionDecode.scala 145:16]
    bu.io_rd1 <= input1 @[InstructionDecode.scala 146:13]
    bu.io_rd2 <= input2 @[InstructionDecode.scala 147:13]
    bu.io_take_branch <= hdu.io_take_branch @[InstructionDecode.scala 148:21]

  module ALU :
    input clock : Clock
    input reset : UInt<1>
    input io_input1 : UInt<32>
    input io_input2 : UInt<32>
    input io_aluCtl : UInt<4>
    output io_zero : UInt<1>
    output io_result : UInt<32>

    node _T = eq(io_aluCtl, UInt<1>("h0")) @[ALU.scala 17:18]
    node _T_1 = and(io_input1, io_input2) @[ALU.scala 17:41]
    node _T_2 = eq(io_aluCtl, UInt<1>("h1")) @[ALU.scala 18:18]
    node _T_3 = or(io_input1, io_input2) @[ALU.scala 18:41]
    node _T_4 = eq(io_aluCtl, UInt<2>("h2")) @[ALU.scala 19:18]
    node _T_5 = add(io_input1, io_input2) @[ALU.scala 19:41]
    node _T_6 = tail(_T_5, 1) @[ALU.scala 19:41]
    node _T_7 = eq(io_aluCtl, UInt<2>("h3")) @[ALU.scala 20:18]
    node _T_8 = sub(io_input1, io_input2) @[ALU.scala 20:41]
    node _T_9 = tail(_T_8, 1) @[ALU.scala 20:41]
    node _T_10 = eq(io_aluCtl, UInt<3>("h4")) @[ALU.scala 21:18]
    node _T_11 = asSInt(io_input1) @[ALU.scala 21:41]
    node _T_12 = asSInt(io_input2) @[ALU.scala 21:60]
    node _T_13 = lt(_T_11, _T_12) @[ALU.scala 21:48]
    node _T_14 = eq(io_aluCtl, UInt<3>("h5")) @[ALU.scala 22:18]
    node _T_15 = lt(io_input1, io_input2) @[ALU.scala 22:41]
    node _T_16 = eq(io_aluCtl, UInt<3>("h6")) @[ALU.scala 23:18]
    node _T_17 = bits(io_input2, 4, 0) @[ALU.scala 23:53]
    node _T_18 = dshl(io_input1, _T_17) @[ALU.scala 23:41]
    node _T_19 = eq(io_aluCtl, UInt<3>("h7")) @[ALU.scala 24:18]
    node _T_20 = bits(io_input2, 4, 0) @[ALU.scala 24:53]
    node _T_21 = dshr(io_input1, _T_20) @[ALU.scala 24:41]
    node _T_22 = eq(io_aluCtl, UInt<4>("h8")) @[ALU.scala 25:18]
    node _T_23 = asSInt(io_input1) @[ALU.scala 25:41]
    node _T_24 = bits(io_input2, 4, 0) @[ALU.scala 25:60]
    node _T_25 = dshr(_T_23, _T_24) @[ALU.scala 25:48]
    node _T_26 = asUInt(_T_25) @[ALU.scala 25:68]
    node _T_27 = eq(io_aluCtl, UInt<4>("h9")) @[ALU.scala 26:18]
    node _T_28 = xor(io_input1, io_input2) @[ALU.scala 26:41]
    node _T_29 = mux(_T_27, _T_28, UInt<1>("h0")) @[Mux.scala 98:16]
    node _T_30 = mux(_T_22, _T_26, _T_29) @[Mux.scala 98:16]
    node _T_31 = mux(_T_19, _T_21, _T_30) @[Mux.scala 98:16]
    node _T_32 = mux(_T_16, _T_18, _T_31) @[Mux.scala 98:16]
    node _T_33 = mux(_T_14, _T_15, _T_32) @[Mux.scala 98:16]
    node _T_34 = mux(_T_10, _T_13, _T_33) @[Mux.scala 98:16]
    node _T_35 = mux(_T_7, _T_9, _T_34) @[Mux.scala 98:16]
    node _T_36 = mux(_T_4, _T_6, _T_35) @[Mux.scala 98:16]
    node _T_37 = mux(_T_2, _T_3, _T_36) @[Mux.scala 98:16]
    node _T_38 = mux(_T, _T_1, _T_37) @[Mux.scala 98:16]
    io_zero is invalid
    io_result <= bits(_T_38, 31, 0) @[ALU.scala 14:13]

  module AluControl :
    input clock : Clock
    input reset : UInt<1>
    input io_aluOp : UInt<2>
    input io_f7 : UInt<1>
    input io_f3 : UInt<3>
    input io_aluSrc : UInt<1>
    output io_out : UInt<4>

    node _T = eq(io_aluOp, UInt<1>("h0")) @[AluControl.scala 33:17]
    node _T_1 = eq(UInt<1>("h0"), io_f3) @[Conditional.scala 37:30]
    node _T_2 = eq(io_aluSrc, UInt<1>("h0")) @[AluControl.scala 38:14]
    node _T_3 = eq(io_f7, UInt<1>("h0")) @[AluControl.scala 38:34]
    node _T_4 = or(_T_2, _T_3) @[AluControl.scala 38:25]
    node _GEN_0 = mux(_T_4, UInt<2>("h2"), UInt<2>("h3")) @[AluControl.scala 38:43 AluControl.scala 39:18 AluControl.scala 42:20]
    node _T_5 = eq(UInt<1>("h1"), io_f3) @[Conditional.scala 37:30]
    node _T_6 = eq(UInt<2>("h2"), io_f3) @[Conditional.scala 37:30]
    node _T_7 = eq(UInt<2>("h3"), io_f3) @[Conditional.scala 37:30]
    node _T_8 = eq(UInt<3>("h5"), io_f3) @[Conditional.scala 37:30]
    node _T_9 = eq(io_f7, UInt<1>("h0")) @[AluControl.scala 55:20]
    node _GEN_1 = mux(_T_9, UInt<3>("h7"), UInt<4>("h8")) @[AluControl.scala 55:29 AluControl.scala 56:18 AluControl.scala 58:18]
    node _T_10 = eq(UInt<3>("h7"), io_f3) @[Conditional.scala 37:30]
    node _T_11 = eq(UInt<3>("h6"), io_f3) @[Conditional.scala 37:30]
    node _T_12 = eq(UInt<3>("h4"), io_f3) @[Conditional.scala 37:30]
    node _GEN_2 = mux(_T_12, UInt<4>("h9"), UInt<4>("hf")) @[Conditional.scala 39:67 AluControl.scala 68:16 AluControl.scala 31:10]
    node _GEN_3 = mux(_T_11, UInt<1>("h1"), _GEN_2) @[Conditional.scala 39:67 AluControl.scala 65:16]
    node _GEN_4 = mux(_T_10, UInt<1>("h0"), _GEN_3) @[Conditional.scala 39:67 AluControl.scala 62:16]
    node _GEN_5 = mux(_T_8, _GEN_1, _GEN_4) @[Conditional.scala 39:67]
    node _GEN_6 = mux(_T_7, UInt<3>("h5"), _GEN_5) @[Conditional.scala 39:67 AluControl.scala 52:16]
    node _GEN_7 = mux(_T_6, UInt<3>("h4"), _GEN_6) @[Conditional.scala 39:67 AluControl.scala 49:16]
    node _GEN_8 = mux(_T_5, UInt<3>("h6"), _GEN_7) @[Conditional.scala 39:67 AluControl.scala 46:16]
    node _GEN_9 = mux(_T_1, _GEN_0, _GEN_8) @[Conditional.scala 40:58]
    node _GEN_10 = mux(_T, UInt<2>("h2"), _GEN_9) @[AluControl.scala 33:26 AluControl.scala 34:12]
    io_out <= _GEN_10

  module ForwardingUnit :
    input clock : Clock
    input reset : UInt<1>
    input io_ex_reg_rd : UInt<5>
    input io_mem_reg_rd : UInt<5>
    input io_reg_rs1 : UInt<5>
    input io_reg_rs2 : UInt<5>
    input io_ex_regWrite : UInt<1>
    input io_mem_regWrite : UInt<1>
    output io_forwardA : UInt<2>
    output io_forwardB : UInt<2>

    node _T = eq(io_reg_rs1, io_ex_reg_rd) @[ForwardingUnit.scala 21:19]
    node _T_1 = neq(io_ex_reg_rd, UInt<1>("h0")) @[ForwardingUnit.scala 21:52]
    node _T_2 = and(_T, _T_1) @[ForwardingUnit.scala 21:36]
    node _T_3 = and(_T_2, io_ex_regWrite) @[ForwardingUnit.scala 21:60]
    node _T_4 = eq(io_reg_rs1, io_mem_reg_rd) @[ForwardingUnit.scala 24:18]
    node _T_5 = neq(io_mem_reg_rd, UInt<1>("h0")) @[ForwardingUnit.scala 24:53]
    node _T_6 = and(_T_4, _T_5) @[ForwardingUnit.scala 24:36]
    node _T_7 = and(_T_6, io_mem_regWrite) @[ForwardingUnit.scala 24:61]
    node _GEN_0 = mux(_T_7, UInt<2>("h2"), UInt<1>("h0")) @[ForwardingUnit.scala 25:7 ForwardingUnit.scala 26:19 ForwardingUnit.scala 29:19]
    node _GEN_1 = mux(_T_3, UInt<1>("h1"), _GEN_0) @[ForwardingUnit.scala 21:79 ForwardingUnit.scala 22:17]
    node _T_8 = eq(io_reg_rs2, io_ex_reg_rd) @[ForwardingUnit.scala 32:19]
    node _T_9 = neq(io_ex_reg_rd, UInt<1>("h0")) @[ForwardingUnit.scala 32:52]
    node _T_10 = and(_T_8, _T_9) @[ForwardingUnit.scala 32:36]
    node _T_11 = and(_T_10, io_ex_regWrite) @[ForwardingUnit.scala 32:60]
    node _T_12 = eq(io_reg_rs2, io_mem_reg_rd) @[ForwardingUnit.scala 35:18]
    node _T_13 = neq(io_mem_reg_rd, UInt<1>("h0")) @[ForwardingUnit.scala 35:53]
    node _T_14 = and(_T_12, _T_13) @[ForwardingUnit.scala 35:36]
    node _T_15 = and(_T_14, io_mem_regWrite) @[ForwardingUnit.scala 35:61]
    node _GEN_2 = mux(_T_15, UInt<2>("h2"), UInt<1>("h0")) @[ForwardingUnit.scala 36:7 ForwardingUnit.scala 37:19 ForwardingUnit.scala 40:19]
    node _GEN_3 = mux(_T_11, UInt<1>("h1"), _GEN_2) @[ForwardingUnit.scala 32:79 ForwardingUnit.scala 33:17]
    io_forwardA <= _GEN_1
    io_forwardB <= _GEN_3

  module Execute :
    input clock : Clock
    input reset : UInt<1>
    input io_immediate : UInt<32>
    input io_readData1 : UInt<32>
    input io_readData2 : UInt<32>
    input io_pcAddress : UInt<32>
    input io_func7 : UInt<1>
    input io_func3 : UInt<3>
    input io_mem_result : UInt<32>
    input io_wb_result : UInt<32>
    input io_ex_mem_regWrite : UInt<1>
    input io_mem_wb_regWrite : UInt<1>
    input io_id_ex_ins : UInt<32>
    input io_ex_mem_ins : UInt<32>
    input io_mem_wb_ins : UInt<32>
    input io_ctl_aluSrc : UInt<1>
    input io_ctl_aluOp : UInt<2>
    input io_ctl_aluSrc1 : UInt<2>
    output io_writeData : UInt<32>
    output io_ALUresult : UInt<32>

    inst alu of ALU @[Execute.scala 31:19]
    inst aluCtl of AluControl @[Execute.scala 32:22]
    inst ForwardingUnit of ForwardingUnit @[Execute.scala 33:18]
    node _T = bits(io_ex_mem_ins, 11, 7) @[Execute.scala 39:32]
    node _T_1 = bits(io_mem_wb_ins, 11, 7) @[Execute.scala 40:33]
    node _T_2 = bits(io_id_ex_ins, 19, 15) @[Execute.scala 41:29]
    node _T_3 = bits(io_id_ex_ins, 24, 20) @[Execute.scala 42:29]
    node _T_4 = eq(ForwardingUnit.io_forwardA, UInt<1>("h0")) @[Execute.scala 47:20]
    node _T_5 = eq(ForwardingUnit.io_forwardA, UInt<1>("h1")) @[Execute.scala 48:20]
    node _T_6 = eq(ForwardingUnit.io_forwardA, UInt<2>("h2")) @[Execute.scala 49:20]
    node _T_7 = mux(_T_6, io_wb_result, UInt<1>("h0")) @[Mux.scala 98:16]
    node _T_8 = mux(_T_5, io_mem_result, _T_7) @[Mux.scala 98:16]
    node inputMux1 = mux(_T_4, io_readData1, _T_8) @[Mux.scala 98:16]
    node _T_9 = eq(ForwardingUnit.io_forwardB, UInt<1>("h0")) @[Execute.scala 55:20]
    node _T_10 = eq(ForwardingUnit.io_forwardB, UInt<1>("h1")) @[Execute.scala 56:20]
    node _T_11 = eq(ForwardingUnit.io_forwardB, UInt<2>("h2")) @[Execute.scala 57:20]
    node _T_12 = mux(_T_11, io_wb_result, UInt<1>("h0")) @[Mux.scala 98:16]
    node _T_13 = mux(_T_10, io_mem_result, _T_12) @[Mux.scala 98:16]
    node inputMux2 = mux(_T_9, io_readData2, _T_13) @[Mux.scala 98:16]
    node _T_14 = eq(io_ctl_aluSrc1, UInt<1>("h1")) @[Execute.scala 64:23]
    node _T_15 = eq(io_ctl_aluSrc1, UInt<2>("h2")) @[Execute.scala 65:23]
    node _T_16 = mux(_T_15, UInt<1>("h0"), inputMux1) @[Mux.scala 98:16]
    node aluIn1 = mux(_T_14, io_pcAddress, _T_16) @[Mux.scala 98:16]
    node aluIn2 = mux(io_ctl_aluSrc, inputMux2, io_immediate) @[Execute.scala 68:19]
    io_writeData <= inputMux2 @[Execute.scala 80:16]
    io_ALUresult <= alu.io_result @[Execute.scala 78:16]
    alu.clock <= clock
    alu.reset <= reset
    alu.io_input1 <= aluIn1 @[Execute.scala 75:17]
    alu.io_input2 <= aluIn2 @[Execute.scala 76:17]
    alu.io_aluCtl <= aluCtl.io_out @[Execute.scala 77:17]
    aluCtl.clock <= clock
    aluCtl.reset <= reset
    aluCtl.io_aluOp <= io_ctl_aluOp @[Execute.scala 72:19]
    aluCtl.io_f7 <= io_func7 @[Execute.scala 71:16]
    aluCtl.io_f3 <= io_func3 @[Execute.scala 70:16]
    aluCtl.io_aluSrc <= io_ctl_aluSrc @[Execute.scala 73:20]
    ForwardingUnit.clock <= clock
    ForwardingUnit.reset <= reset
    ForwardingUnit.io_ex_reg_rd <= _T @[Execute.scala 39:16]
    ForwardingUnit.io_mem_reg_rd <= _T_1 @[Execute.scala 40:17]
    ForwardingUnit.io_reg_rs1 <= _T_2 @[Execute.scala 41:14]
    ForwardingUnit.io_reg_rs2 <= _T_3 @[Execute.scala 42:14]
    ForwardingUnit.io_ex_regWrite <= io_ex_mem_regWrite @[Execute.scala 37:18]
    ForwardingUnit.io_mem_regWrite <= io_mem_wb_regWrite @[Execute.scala 38:19]

  module MemoryFetch :
    input clock : Clock
    input reset : UInt<1>
    input io_aluResultIn : UInt<32>
    input io_writeData : UInt<32>
    input io_writeEnable : UInt<1>
    input io_readEnable : UInt<1>
    output io_readData : UInt<32>
    output io_stall : UInt<1>
    input io_dccmReq_ready : UInt<1>
    output io_dccmReq_valid : UInt<1>
    output io_dccmReq_bits_addrRequest : UInt<32>
    output io_dccmReq_bits_dataRequest : UInt<32>
    output io_dccmReq_bits_activeByteLane : UInt<4>
    output io_dccmReq_bits_isWrite : UInt<1>
    output io_dccmRsp_ready : UInt<1>
    input io_dccmRsp_valid : UInt<1>
    input io_dccmRsp_bits_dataResponse : UInt<32>
    input io_dccmRsp_bits_error : UInt<1>
    input io_dccmRsp_bits_ackWrite : UInt<1>

    node _T = or(io_writeEnable, io_readEnable) @[MemoryFetch.scala 33:42]
    node _T_1 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[MemoryFetch.scala 33:26]
    node _T_2 = or(io_writeEnable, io_readEnable) @[MemoryFetch.scala 35:31]
    node _T_3 = eq(io_dccmRsp_valid, UInt<1>("h0")) @[MemoryFetch.scala 35:52]
    node _T_4 = and(_T_2, _T_3) @[MemoryFetch.scala 35:49]
    node _WIRE = validif(UInt<1>("h0"), UInt<32>("h0"))
    node _T_5 = mux(io_dccmRsp_valid, io_dccmRsp_bits_dataResponse, _WIRE) @[MemoryFetch.scala 40:21]
    node _T_6 = bits(io_aluResultIn, 31, 28) @[MemoryFetch.scala 42:40]
    node _T_7 = eq(_T_6, UInt<4>("h8")) @[MemoryFetch.scala 42:49]
    node _T_8 = and(io_writeEnable, _T_7) @[MemoryFetch.scala 42:23]
    node _T_9 = asUInt(reset) @[MemoryFetch.scala 43:11]
    node _T_10 = eq(_T_9, UInt<1>("h0")) @[MemoryFetch.scala 43:11]
    io_readData <= _T_5 @[MemoryFetch.scala 40:15]
    io_stall <= _T_4 @[MemoryFetch.scala 35:12]
    io_dccmReq_valid <= _T_1 @[MemoryFetch.scala 33:20]
    io_dccmReq_bits_addrRequest <= io_aluResultIn @[MemoryFetch.scala 31:31]
    io_dccmReq_bits_dataRequest <= io_writeData @[MemoryFetch.scala 30:31]
    io_dccmReq_bits_activeByteLane <= UInt<4>("hf") @[MemoryFetch.scala 29:34]
    io_dccmReq_bits_isWrite <= io_writeEnable @[MemoryFetch.scala 32:27]
    io_dccmRsp_ready <= UInt<1>("h1") @[MemoryFetch.scala 27:20]
    printf(clock, and(and(and(UInt<1>("h1"), _T_8), _T_10), UInt<1>("h1")), "%x\n", io_writeData) @[MemoryFetch.scala 43:11]

  module PC :
    input clock : Clock
    input reset : UInt<1>
    input io_in : SInt<32>
    input io_halt : UInt<1>
    output io_out : SInt<32>
    output io_pc4 : SInt<32>

    reg pc_reg : SInt<32>, clock with :
      reset => (UInt<1>("h0"), pc_reg) @[PC.scala 12:23]
    node _T = add(pc_reg, asSInt(UInt<4>("h4"))) @[PC.scala 15:41]
    node _T_1 = tail(_T, 1) @[PC.scala 15:41]
    node _T_2 = asSInt(_T_1) @[PC.scala 15:41]
    node _T_3 = mux(io_halt, pc_reg, _T_2) @[PC.scala 15:16]
    io_out <= pc_reg @[PC.scala 14:10]
    io_pc4 <= _T_3 @[PC.scala 15:10]
    pc_reg <= mux(reset, asSInt(UInt<32>("hfffffffc")), io_in) @[PC.scala 12:23 PC.scala 12:23 PC.scala 13:10]

  module RVFI :
    input clock : Clock
    input reset : UInt<1>
    input io_stall : UInt<1>
    input io_insn : UInt<32>
    input io_rs1_rdata : UInt<32>
    input io_rs2_rdata : UInt<32>
    input io_rd_addr : UInt<5>
    input io_rd_wdata : UInt<32>
    input io_pc : SInt<32>
    input io_pc_offset : SInt<32>
    input io_pc_four : SInt<32>
    input io_pc_src : UInt<1>
    output io_rvfi_valid : UInt<1>
    output io_rvfi_order : UInt<64>
    output io_rvfi_insn : UInt<32>
    output io_rvfi_trap : UInt<1>
    output io_rvfi_halt : UInt<1>
    output io_rvfi_intr : UInt<1>
    output io_rvfi_ixl : UInt<2>
    output io_rvfi_mode : UInt<2>
    output io_rvfi_rs1_addr : UInt<5>
    output io_rvfi_rs1_rdata : SInt<32>
    output io_rvfi_rs2_addr : UInt<5>
    output io_rvfi_rs2_rdata : SInt<32>
    output io_rvfi_rd_addr : UInt<5>
    output io_rvfi_rd_wdata : SInt<32>
    output io_rvfi_pc_rdata : UInt<32>
    output io_rvfi_pc_wdata : UInt<32>

    reg rvfi_valid : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rvfi_valid) @[RVFI.scala 44:27]
    reg rvfi_order : UInt<64>, clock with :
      reset => (UInt<1>("h0"), rvfi_order) @[RVFI.scala 45:27]
    reg rvfi_halt : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rvfi_halt) @[RVFI.scala 46:26]
    reg rvfi_intr : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rvfi_intr) @[RVFI.scala 47:26]
    reg rvfi_mode : UInt<2>, clock with :
      reset => (UInt<1>("h0"), rvfi_mode) @[RVFI.scala 48:26]
    node _T = asUInt(reset) @[RVFI.scala 50:30]
    node _T_1 = eq(_T, UInt<1>("h0")) @[RVFI.scala 50:17]
    node _T_2 = eq(io_stall, UInt<1>("h0")) @[RVFI.scala 50:36]
    node _T_3 = and(_T_1, _T_2) @[RVFI.scala 50:33]
    node _T_4 = add(rvfi_order, UInt<1>("h1")) @[RVFI.scala 53:30]
    node _T_5 = tail(_T_4, 1) @[RVFI.scala 53:30]
    node _GEN_0 = mux(rvfi_valid, _T_5, rvfi_order) @[RVFI.scala 52:19 RVFI.scala 53:16 RVFI.scala 45:27]
    node _T_6 = asUInt(io_pc) @[RVFI.scala 56:35]
    node _T_7 = asUInt(io_pc_offset) @[RVFI.scala 57:57]
    node _T_8 = asUInt(io_pc_four) @[RVFI.scala 57:78]
    node _T_9 = mux(io_pc_src, _T_7, _T_8) @[RVFI.scala 57:26]
    node _T_10 = bits(io_insn, 19, 15) @[RVFI.scala 59:30]
    node _T_11 = asSInt(io_rs1_rdata) @[RVFI.scala 60:43]
    node _T_12 = bits(io_insn, 24, 20) @[RVFI.scala 61:30]
    node _T_13 = asSInt(io_rs2_rdata) @[RVFI.scala 62:43]
    node _T_14 = asSInt(io_rd_wdata) @[RVFI.scala 65:41]
    io_rvfi_valid <= rvfi_valid @[RVFI.scala 68:17]
    io_rvfi_order <= rvfi_order @[RVFI.scala 69:17]
    io_rvfi_insn <= io_insn @[RVFI.scala 70:16]
    io_rvfi_trap <= UInt<1>("h0") @[RVFI.scala 74:16]
    io_rvfi_halt <= rvfi_halt @[RVFI.scala 71:16]
    io_rvfi_intr <= rvfi_intr @[RVFI.scala 72:16]
    io_rvfi_ixl <= UInt<1>("h1") @[RVFI.scala 73:16]
    io_rvfi_mode <= rvfi_mode @[RVFI.scala 67:16]
    io_rvfi_rs1_addr <= _T_10 @[RVFI.scala 59:20]
    io_rvfi_rs1_rdata <= _T_11 @[RVFI.scala 60:21]
    io_rvfi_rs2_addr <= _T_12 @[RVFI.scala 61:20]
    io_rvfi_rs2_rdata <= _T_13 @[RVFI.scala 62:21]
    io_rvfi_rd_addr <= io_rd_addr @[RVFI.scala 64:19]
    io_rvfi_rd_wdata <= _T_14 @[RVFI.scala 65:20]
    io_rvfi_pc_rdata <= _T_6 @[RVFI.scala 56:20]
    io_rvfi_pc_wdata <= _T_9 @[RVFI.scala 57:20]
    rvfi_valid <= mux(reset, UInt<1>("h0"), _T_3) @[RVFI.scala 44:27 RVFI.scala 44:27 RVFI.scala 50:14]
    rvfi_order <= mux(reset, UInt<64>("h0"), _GEN_0) @[RVFI.scala 45:27 RVFI.scala 45:27]
    rvfi_halt <= mux(reset, UInt<1>("h0"), rvfi_halt) @[RVFI.scala 46:26 RVFI.scala 46:26 RVFI.scala 46:26]
    rvfi_intr <= mux(reset, UInt<1>("h0"), rvfi_intr) @[RVFI.scala 47:26 RVFI.scala 47:26 RVFI.scala 47:26]
    rvfi_mode <= mux(reset, UInt<2>("h3"), rvfi_mode) @[RVFI.scala 48:26 RVFI.scala 48:26 RVFI.scala 48:26]

  module Core :
    input clock : Clock
    input reset : UInt<1>
    output io_pin : UInt<32>
    input io_dmemReq_ready : UInt<1>
    output io_dmemReq_valid : UInt<1>
    output io_dmemReq_bits_addrRequest : UInt<32>
    output io_dmemReq_bits_dataRequest : UInt<32>
    output io_dmemReq_bits_activeByteLane : UInt<4>
    output io_dmemReq_bits_isWrite : UInt<1>
    output io_dmemRsp_ready : UInt<1>
    input io_dmemRsp_valid : UInt<1>
    input io_dmemRsp_bits_dataResponse : UInt<32>
    input io_dmemRsp_bits_error : UInt<1>
    input io_dmemRsp_bits_ackWrite : UInt<1>
    input io_imemReq_ready : UInt<1>
    output io_imemReq_valid : UInt<1>
    output io_imemReq_bits_addrRequest : UInt<32>
    output io_imemReq_bits_dataRequest : UInt<32>
    output io_imemReq_bits_activeByteLane : UInt<4>
    output io_imemReq_bits_isWrite : UInt<1>
    output io_imemRsp_ready : UInt<1>
    input io_imemRsp_valid : UInt<1>
    input io_imemRsp_bits_dataResponse : UInt<32>
    input io_imemRsp_bits_error : UInt<1>
    input io_imemRsp_bits_ackWrite : UInt<1>
    output io_rvfi_valid : UInt<1>
    output io_rvfi_order : UInt<64>
    output io_rvfi_insn : UInt<32>
    output io_rvfi_trap : UInt<1>
    output io_rvfi_halt : UInt<1>
    output io_rvfi_intr : UInt<1>
    output io_rvfi_ixl : UInt<2>
    output io_rvfi_mode : UInt<2>
    output io_rvfi_rs1_addr : UInt<5>
    output io_rvfi_rs1_rdata : SInt<32>
    output io_rvfi_rs2_addr : UInt<5>
    output io_rvfi_rs2_rdata : SInt<32>
    output io_rvfi_rd_addr : UInt<5>
    output io_rvfi_rd_wdata : SInt<32>
    output io_rvfi_pc_rdata : UInt<32>
    output io_rvfi_pc_wdata : UInt<32>

    inst InstructionFetch of InstructionFetch @[Core.scala 70:18]
    inst InstructionDecode of InstructionDecode @[Core.scala 71:18]
    inst Execute of Execute @[Core.scala 72:18]
    inst MEM of MemoryFetch @[Core.scala 73:19]
    inst pc of PC @[Core.scala 79:18]
    inst rvfi of RVFI @[Core.scala 245:20]
    reg if_reg_pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), if_reg_pc) @[Core.scala 23:26]
    reg if_reg_ins : UInt<32>, clock with :
      reset => (UInt<1>("h0"), if_reg_ins) @[Core.scala 24:27]
    reg id_reg_pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), id_reg_pc) @[Core.scala 27:26]
    reg id_reg_rd1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), id_reg_rd1) @[Core.scala 28:27]
    reg id_reg_rd2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), id_reg_rd2) @[Core.scala 29:27]
    reg id_reg_imm : UInt<32>, clock with :
      reset => (UInt<1>("h0"), id_reg_imm) @[Core.scala 30:27]
    reg id_reg_wra : UInt<5>, clock with :
      reset => (UInt<1>("h0"), id_reg_wra) @[Core.scala 31:27]
    reg id_reg_f7 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), id_reg_f7) @[Core.scala 32:26]
    reg id_reg_f3 : UInt<3>, clock with :
      reset => (UInt<1>("h0"), id_reg_f3) @[Core.scala 33:26]
    reg id_reg_ins : UInt<32>, clock with :
      reset => (UInt<1>("h0"), id_reg_ins) @[Core.scala 34:27]
    reg id_reg_ctl_aluSrc : UInt<1>, clock with :
      reset => (UInt<1>("h0"), id_reg_ctl_aluSrc) @[Core.scala 35:34]
    reg id_reg_ctl_aluSrc1 : UInt<2>, clock with :
      reset => (UInt<1>("h0"), id_reg_ctl_aluSrc1) @[Core.scala 36:35]
    reg id_reg_ctl_memToReg : UInt<2>, clock with :
      reset => (UInt<1>("h0"), id_reg_ctl_memToReg) @[Core.scala 37:36]
    reg id_reg_ctl_regWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), id_reg_ctl_regWrite) @[Core.scala 38:36]
    reg id_reg_ctl_memRead : UInt<1>, clock with :
      reset => (UInt<1>("h0"), id_reg_ctl_memRead) @[Core.scala 39:35]
    reg id_reg_ctl_memWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), id_reg_ctl_memWrite) @[Core.scala 40:36]
    reg id_reg_ctl_branch : UInt<1>, clock with :
      reset => (UInt<1>("h0"), id_reg_ctl_branch) @[Core.scala 41:34]
    reg id_reg_ctl_aluOp : UInt<2>, clock with :
      reset => (UInt<1>("h0"), id_reg_ctl_aluOp) @[Core.scala 42:33]
    reg id_reg_ctl_jump : UInt<2>, clock with :
      reset => (UInt<1>("h0"), id_reg_ctl_jump) @[Core.scala 43:32]
    reg ex_reg_branch : UInt<32>, clock with :
      reset => (UInt<1>("h0"), ex_reg_branch) @[Core.scala 46:30]
    reg ex_reg_zero : UInt<32>, clock with :
      reset => (UInt<1>("h0"), ex_reg_zero) @[Core.scala 47:28]
    reg ex_reg_result : UInt<32>, clock with :
      reset => (UInt<1>("h0"), ex_reg_result) @[Core.scala 48:30]
    reg ex_reg_wd : UInt<32>, clock with :
      reset => (UInt<1>("h0"), ex_reg_wd) @[Core.scala 49:26]
    reg ex_reg_wra : UInt<5>, clock with :
      reset => (UInt<1>("h0"), ex_reg_wra) @[Core.scala 50:27]
    reg ex_reg_ins : UInt<32>, clock with :
      reset => (UInt<1>("h0"), ex_reg_ins) @[Core.scala 51:27]
    reg ex_reg_ctl_memToReg : UInt<2>, clock with :
      reset => (UInt<1>("h0"), ex_reg_ctl_memToReg) @[Core.scala 52:36]
    reg ex_reg_ctl_regWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ex_reg_ctl_regWrite) @[Core.scala 53:36]
    reg ex_reg_ctl_memRead : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ex_reg_ctl_memRead) @[Core.scala 54:35]
    reg ex_reg_ctl_memWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ex_reg_ctl_memWrite) @[Core.scala 55:36]
    reg ex_reg_ctl_branch_taken : UInt<1>, clock with :
      reset => (UInt<1>("h0"), ex_reg_ctl_branch_taken) @[Core.scala 56:40]
    reg ex_reg_pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), ex_reg_pc) @[Core.scala 57:26]
    reg mem_reg_rd : UInt<32>, clock with :
      reset => (UInt<1>("h0"), mem_reg_rd) @[Core.scala 60:27]
    reg mem_reg_ins : UInt<32>, clock with :
      reset => (UInt<1>("h0"), mem_reg_ins) @[Core.scala 61:28]
    reg mem_reg_result : UInt<32>, clock with :
      reset => (UInt<1>("h0"), mem_reg_result) @[Core.scala 62:31]
    reg mem_reg_branch : UInt<32>, clock with :
      reset => (UInt<1>("h0"), mem_reg_branch) @[Core.scala 63:31]
    reg mem_reg_wra : UInt<5>, clock with :
      reset => (UInt<1>("h0"), mem_reg_wra) @[Core.scala 64:28]
    reg mem_reg_ctl_memToReg : UInt<2>, clock with :
      reset => (UInt<1>("h0"), mem_reg_ctl_memToReg) @[Core.scala 65:37]
    reg mem_reg_ctl_regWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), mem_reg_ctl_regWrite) @[Core.scala 66:37]
    reg mem_reg_pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), mem_reg_pc) @[Core.scala 67:27]
    node _T = asUInt(pc.io_in) @[Core.scala 84:32]
    node instruction = mux(io_imemRsp_valid, InstructionFetch.io_instruction, UInt<32>("h13")) @[Core.scala 85:24]
    node _T_1 = mux(io_imemReq_valid, UInt<1>("h0"), UInt<1>("h1")) @[Core.scala 87:20]
    node _T_2 = eq(MEM.io_stall, UInt<1>("h0")) @[Core.scala 88:37]
    node _T_3 = and(InstructionDecode.io_hdu_pcWrite, _T_2) @[Core.scala 88:34]
    node _T_4 = asSInt(InstructionDecode.io_pcPlusOffset) @[Core.scala 88:88]
    node _T_5 = mux(InstructionDecode.io_pcSrc, _T_4, pc.io_pc4) @[Core.scala 88:55]
    node _T_6 = mux(_T_3, _T_5, pc.io_out) @[Core.scala 88:18]
    node _T_7 = eq(MEM.io_stall, UInt<1>("h0")) @[Core.scala 91:31]
    node _T_8 = and(InstructionDecode.io_hdu_if_reg_write, _T_7) @[Core.scala 91:28]
    node _T_9 = asUInt(pc.io_out) @[Core.scala 92:34]
    node _GEN_0 = mux(_T_8, _T_9, if_reg_pc) @[Core.scala 91:46 Core.scala 92:15 Core.scala 23:26]
    node _GEN_1 = mux(_T_8, instruction, if_reg_ins) @[Core.scala 91:46 Core.scala 93:16 Core.scala 24:27]
    node _GEN_2 = mux(InstructionDecode.io_ifid_flush, UInt<1>("h0"), _GEN_1) @[Core.scala 95:23 Core.scala 96:16]
    node _T_10 = bits(id_reg_ins, 11, 7) @[Core.scala 167:28]
    node _T_11 = bits(id_reg_ins, 6, 0) @[Core.scala 168:36]
    node _T_12 = eq(_T_11, UInt<7>("h63")) @[Core.scala 168:42]
    node _T_13 = mux(_T_12, UInt<1>("h1"), UInt<1>("h0")) @[Core.scala 168:25]
    node _T_14 = bits(ex_reg_ins, 11, 7) @[Core.scala 169:29]
    node _GEN_3 = mux(MEM.io_stall, mem_reg_rd, MEM.io_readData) @[Core.scala 181:21 Core.scala 182:16 Core.scala 197:16]
    node _GEN_4 = mux(MEM.io_stall, mem_reg_result, ex_reg_result) @[Core.scala 181:21 Core.scala 183:20 Core.scala 198:20]
    node _GEN_5 = mux(MEM.io_stall, ex_reg_wra, id_reg_wra) @[Core.scala 181:21 Core.scala 185:16 Core.scala 153:14]
    node _GEN_6 = mux(MEM.io_stall, ex_reg_ctl_memToReg, id_reg_ctl_memToReg) @[Core.scala 181:21 Core.scala 186:25 Core.scala 155:23]
    node _GEN_7 = mux(MEM.io_stall, ex_reg_ctl_regWrite, id_reg_ctl_regWrite) @[Core.scala 181:21 Core.scala 188:25 Core.scala 156:23]
    node _GEN_8 = mux(MEM.io_stall, ex_reg_ctl_regWrite, ex_reg_ctl_regWrite) @[Core.scala 181:21 Core.scala 189:26 Core.scala 200:26]
    node _GEN_9 = mux(MEM.io_stall, mem_reg_ins, ex_reg_ins) @[Core.scala 181:21 Core.scala 190:17 Core.scala 201:17]
    node _GEN_10 = mux(MEM.io_stall, mem_reg_pc, ex_reg_pc) @[Core.scala 181:21 Core.scala 191:16 Core.scala 202:16]
    node _GEN_11 = mux(MEM.io_stall, ex_reg_ctl_memRead, id_reg_ctl_memRead) @[Core.scala 181:21 Core.scala 193:24 Core.scala 204:24]
    node _GEN_12 = mux(MEM.io_stall, ex_reg_ctl_memWrite, id_reg_ctl_memWrite) @[Core.scala 181:21 Core.scala 194:25 Core.scala 205:25]
    node _GEN_13 = mux(MEM.io_stall, mem_reg_wra, ex_reg_wra) @[Core.scala 181:21 Core.scala 64:28 Core.scala 203:17]
    node _T_15 = eq(mem_reg_ctl_memToReg, UInt<1>("h1")) @[Core.scala 223:29]
    node _T_16 = mux(io_dmemRsp_valid, mem_reg_wra, UInt<1>("h0")) @[Core.scala 225:19]
    node _T_17 = eq(mem_reg_ctl_memToReg, UInt<2>("h2")) @[Core.scala 226:35]
    node _GEN_14 = mux(_T_17, mem_reg_pc, mem_reg_result) @[Core.scala 226:44 Core.scala 227:15 Core.scala 231:15]
    node _GEN_15 = mux(_T_17, mem_reg_wra, mem_reg_wra) @[Core.scala 226:44 Core.scala 228:15 Core.scala 232:15]
    node _GEN_16 = mux(_T_15, MEM.io_readData, _GEN_14) @[Core.scala 223:38 Core.scala 224:13]
    node _GEN_17 = mux(_T_15, _T_16, _GEN_15) @[Core.scala 223:38 Core.scala 225:13]
    node wb_data = _GEN_16 @[Core.scala 220:21]
    node wb_addr = _GEN_17 @[Core.scala 221:21]
    io_pin <= wb_data @[Core.scala 241:10]
    io_dmemReq_valid <= MEM.io_dccmReq_valid @[Core.scala 177:14]
    io_dmemReq_bits_addrRequest <= MEM.io_dccmReq_bits_addrRequest @[Core.scala 177:14]
    io_dmemReq_bits_dataRequest <= MEM.io_dccmReq_bits_dataRequest @[Core.scala 177:14]
    io_dmemReq_bits_activeByteLane <= MEM.io_dccmReq_bits_activeByteLane @[Core.scala 177:14]
    io_dmemReq_bits_isWrite <= MEM.io_dccmReq_bits_isWrite @[Core.scala 177:14]
    io_dmemRsp_ready <= MEM.io_dccmRsp_ready @[Core.scala 178:18]
    io_imemReq_valid <= InstructionFetch.io_coreInstrReq_valid @[Core.scala 81:14]
    io_imemReq_bits_addrRequest <= InstructionFetch.io_coreInstrReq_bits_addrRequest @[Core.scala 81:14]
    io_imemReq_bits_dataRequest <= InstructionFetch.io_coreInstrReq_bits_dataRequest @[Core.scala 81:14]
    io_imemReq_bits_activeByteLane <= InstructionFetch.io_coreInstrReq_bits_activeByteLane @[Core.scala 81:14]
    io_imemReq_bits_isWrite <= InstructionFetch.io_coreInstrReq_bits_isWrite @[Core.scala 81:14]
    io_imemRsp_ready <= InstructionFetch.io_coreInstrResp_ready @[Core.scala 82:20]
    io_rvfi_valid <= rvfi.io_rvfi_valid @[Core.scala 257:11]
    io_rvfi_order <= rvfi.io_rvfi_order @[Core.scala 257:11]
    io_rvfi_insn <= rvfi.io_rvfi_insn @[Core.scala 257:11]
    io_rvfi_trap <= rvfi.io_rvfi_trap @[Core.scala 257:11]
    io_rvfi_halt <= rvfi.io_rvfi_halt @[Core.scala 257:11]
    io_rvfi_intr <= rvfi.io_rvfi_intr @[Core.scala 257:11]
    io_rvfi_ixl <= rvfi.io_rvfi_ixl @[Core.scala 257:11]
    io_rvfi_mode <= rvfi.io_rvfi_mode @[Core.scala 257:11]
    io_rvfi_rs1_addr <= rvfi.io_rvfi_rs1_addr @[Core.scala 257:11]
    io_rvfi_rs1_rdata <= rvfi.io_rvfi_rs1_rdata @[Core.scala 257:11]
    io_rvfi_rs2_addr <= rvfi.io_rvfi_rs2_addr @[Core.scala 257:11]
    io_rvfi_rs2_rdata <= rvfi.io_rvfi_rs2_rdata @[Core.scala 257:11]
    io_rvfi_rd_addr <= rvfi.io_rvfi_rd_addr @[Core.scala 257:11]
    io_rvfi_rd_wdata <= rvfi.io_rvfi_rd_wdata @[Core.scala 257:11]
    io_rvfi_pc_rdata <= rvfi.io_rvfi_pc_rdata @[Core.scala 257:11]
    io_rvfi_pc_wdata <= rvfi.io_rvfi_pc_wdata @[Core.scala 257:11]
    if_reg_pc <= mux(reset, UInt<32>("h0"), _GEN_0) @[Core.scala 23:26 Core.scala 23:26]
    if_reg_ins <= mux(reset, UInt<32>("h0"), _GEN_2) @[Core.scala 24:27 Core.scala 24:27]
    id_reg_pc <= mux(reset, UInt<32>("h0"), if_reg_pc) @[Core.scala 27:26 Core.scala 27:26 Core.scala 111:13]
    id_reg_rd1 <= mux(reset, UInt<32>("h0"), InstructionDecode.io_readData1) @[Core.scala 28:27 Core.scala 28:27 Core.scala 104:14]
    id_reg_rd2 <= mux(reset, UInt<32>("h0"), InstructionDecode.io_readData2) @[Core.scala 29:27 Core.scala 29:27 Core.scala 105:14]
    id_reg_imm <= mux(reset, UInt<32>("h0"), InstructionDecode.io_immediate) @[Core.scala 30:27 Core.scala 30:27 Core.scala 106:14]
    id_reg_wra <= mux(reset, UInt<5>("h0"), InstructionDecode.io_writeRegAddress) @[Core.scala 31:27 Core.scala 31:27 Core.scala 107:14]
    id_reg_f7 <= mux(reset, UInt<1>("h0"), InstructionDecode.io_func7) @[Core.scala 32:26 Core.scala 32:26 Core.scala 109:13]
    id_reg_f3 <= mux(reset, UInt<3>("h0"), InstructionDecode.io_func3) @[Core.scala 33:26 Core.scala 33:26 Core.scala 108:13]
    id_reg_ins <= mux(reset, UInt<32>("h0"), if_reg_ins) @[Core.scala 34:27 Core.scala 34:27 Core.scala 110:14]
    id_reg_ctl_aluSrc <= mux(reset, UInt<1>("h0"), InstructionDecode.io_ctl_aluSrc) @[Core.scala 35:34 Core.scala 35:34 Core.scala 112:21]
    id_reg_ctl_aluSrc1 <= mux(reset, UInt<2>("h0"), InstructionDecode.io_ctl_aluSrc1) @[Core.scala 36:35 Core.scala 36:35 Core.scala 120:22]
    id_reg_ctl_memToReg <= mux(reset, UInt<2>("h0"), InstructionDecode.io_ctl_memToReg) @[Core.scala 37:36 Core.scala 37:36 Core.scala 113:23]
    id_reg_ctl_regWrite <= mux(reset, UInt<1>("h0"), InstructionDecode.io_ctl_regWrite) @[Core.scala 38:36 Core.scala 38:36 Core.scala 114:23]
    id_reg_ctl_memRead <= mux(reset, UInt<1>("h0"), InstructionDecode.io_ctl_memRead) @[Core.scala 39:35 Core.scala 39:35 Core.scala 115:22]
    id_reg_ctl_memWrite <= mux(reset, UInt<1>("h0"), InstructionDecode.io_ctl_memWrite) @[Core.scala 40:36 Core.scala 40:36 Core.scala 116:23]
    id_reg_ctl_branch <= mux(reset, UInt<1>("h0"), InstructionDecode.io_ctl_branch) @[Core.scala 41:34 Core.scala 41:34 Core.scala 117:21]
    id_reg_ctl_aluOp <= mux(reset, UInt<2>("h0"), InstructionDecode.io_ctl_aluOp) @[Core.scala 42:33 Core.scala 42:33 Core.scala 118:20]
    id_reg_ctl_jump <= mux(reset, UInt<2>("h0"), InstructionDecode.io_ctl_jump) @[Core.scala 43:32 Core.scala 43:32 Core.scala 119:19]
    ex_reg_branch <= mux(reset, UInt<32>("h0"), ex_reg_branch) @[Core.scala 46:30 Core.scala 46:30 Core.scala 46:30]
    ex_reg_zero <= mux(reset, UInt<32>("h0"), ex_reg_zero) @[Core.scala 47:28 Core.scala 47:28 Core.scala 47:28]
    ex_reg_result <= mux(reset, UInt<32>("h0"), Execute.io_ALUresult) @[Core.scala 48:30 Core.scala 48:30 Core.scala 139:17]
    ex_reg_wd <= mux(reset, UInt<32>("h0"), Execute.io_writeData) @[Core.scala 49:26 Core.scala 49:26 Core.scala 138:13]
    ex_reg_wra <= mux(reset, UInt<5>("h0"), _GEN_5) @[Core.scala 50:27 Core.scala 50:27]
    ex_reg_ins <= mux(reset, UInt<32>("h0"), id_reg_ins) @[Core.scala 51:27 Core.scala 51:27 Core.scala 154:14]
    ex_reg_ctl_memToReg <= mux(reset, UInt<2>("h0"), _GEN_6) @[Core.scala 52:36 Core.scala 52:36]
    ex_reg_ctl_regWrite <= mux(reset, UInt<1>("h0"), _GEN_7) @[Core.scala 53:36 Core.scala 53:36]
    ex_reg_ctl_memRead <= mux(reset, UInt<1>("h0"), _GEN_11) @[Core.scala 54:35 Core.scala 54:35]
    ex_reg_ctl_memWrite <= mux(reset, UInt<1>("h0"), _GEN_12) @[Core.scala 55:36 Core.scala 55:36]
    ex_reg_ctl_branch_taken <= mux(reset, UInt<1>("h0"), ex_reg_ctl_branch_taken) @[Core.scala 56:40 Core.scala 56:40 Core.scala 56:40]
    ex_reg_pc <= mux(reset, UInt<32>("h0"), id_reg_pc) @[Core.scala 57:26 Core.scala 57:26 Core.scala 152:13]
    mem_reg_rd <= mux(reset, UInt<32>("h0"), _GEN_3) @[Core.scala 60:27 Core.scala 60:27]
    mem_reg_ins <= mux(reset, UInt<32>("h0"), _GEN_9) @[Core.scala 61:28 Core.scala 61:28]
    mem_reg_result <= mux(reset, UInt<32>("h0"), _GEN_4) @[Core.scala 62:31 Core.scala 62:31]
    mem_reg_branch <= mux(reset, UInt<32>("h0"), mem_reg_branch) @[Core.scala 63:31 Core.scala 63:31 Core.scala 63:31]
    mem_reg_wra <= mux(reset, UInt<5>("h0"), ex_reg_wra) @[Core.scala 64:28 Core.scala 64:28 Core.scala 207:15]
    mem_reg_ctl_memToReg <= mux(reset, UInt<2>("h0"), ex_reg_ctl_memToReg) @[Core.scala 65:37 Core.scala 65:37 Core.scala 208:24]
    mem_reg_ctl_regWrite <= mux(reset, UInt<1>("h0"), _GEN_8) @[Core.scala 66:37 Core.scala 66:37]
    mem_reg_pc <= mux(reset, UInt<32>("h0"), _GEN_10) @[Core.scala 67:27 Core.scala 67:27]
    InstructionFetch.clock <= clock
    InstructionFetch.reset <= reset
    InstructionFetch.io_address <= _T @[Core.scala 84:14]
    InstructionFetch.io_coreInstrReq_ready <= io_imemReq_ready @[Core.scala 81:14]
    InstructionFetch.io_coreInstrResp_valid <= io_imemRsp_valid @[Core.scala 82:20]
    InstructionFetch.io_coreInstrResp_bits_dataResponse <= io_imemRsp_bits_dataResponse @[Core.scala 82:20]
    InstructionFetch.io_coreInstrResp_bits_error <= io_imemRsp_bits_error @[Core.scala 82:20]
    InstructionFetch.io_coreInstrResp_bits_ackWrite <= io_imemRsp_bits_ackWrite @[Core.scala 82:20]
    InstructionDecode.clock <= clock
    InstructionDecode.reset <= reset
    InstructionDecode.io_id_instruction <= if_reg_ins @[Core.scala 122:21]
    InstructionDecode.io_writeData <= wb_data @[Core.scala 236:16]
    InstructionDecode.io_writeReg <= wb_addr @[Core.scala 239:15]
    InstructionDecode.io_pcAddress <= if_reg_pc @[Core.scala 123:16]
    InstructionDecode.io_ctl_writeEnable <= mem_reg_ctl_regWrite @[Core.scala 240:22]
    InstructionDecode.io_id_ex_mem_read <= id_reg_ctl_memRead @[Core.scala 159:21]
    InstructionDecode.io_ex_mem_mem_read <= ex_reg_ctl_memRead @[Core.scala 160:22]
    InstructionDecode.io_dmem_resp_valid <= io_dmemRsp_valid @[Core.scala 124:22]
    InstructionDecode.io_id_ex_rd <= _T_10 @[Core.scala 167:15]
    InstructionDecode.io_ex_mem_rd <= _T_14 @[Core.scala 169:16]
    InstructionDecode.io_id_ex_branch <= _T_13 @[Core.scala 168:19]
    InstructionDecode.io_ex_mem_ins <= ex_reg_ins @[Core.scala 128:17]
    InstructionDecode.io_mem_wb_ins <= mem_reg_ins @[Core.scala 129:17]
    InstructionDecode.io_ex_ins <= id_reg_ins @[Core.scala 127:13]
    InstructionDecode.io_ex_result <= Execute.io_ALUresult @[Core.scala 170:16]
    InstructionDecode.io_ex_mem_result <= ex_reg_result @[Core.scala 130:20]
    InstructionDecode.io_mem_wb_result <= wb_data @[Core.scala 235:20]
    Execute.clock <= clock
    Execute.reset <= reset
    Execute.io_immediate <= id_reg_imm @[Core.scala 141:16]
    Execute.io_readData1 <= id_reg_rd1 @[Core.scala 142:16]
    Execute.io_readData2 <= id_reg_rd2 @[Core.scala 143:16]
    Execute.io_pcAddress <= id_reg_pc @[Core.scala 144:16]
    Execute.io_func7 <= id_reg_f7 @[Core.scala 146:12]
    Execute.io_func3 <= id_reg_f3 @[Core.scala 145:12]
    Execute.io_mem_result <= ex_reg_result @[Core.scala 214:17]
    Execute.io_wb_result <= wb_data @[Core.scala 237:16]
    Execute.io_ex_mem_regWrite <= ex_reg_ctl_regWrite @[Core.scala 209:22]
    Execute.io_mem_wb_regWrite <= mem_reg_ctl_regWrite @[Core.scala 238:22]
    Execute.io_id_ex_ins <= id_reg_ins @[Core.scala 164:16]
    Execute.io_ex_mem_ins <= ex_reg_ins @[Core.scala 165:17]
    Execute.io_mem_wb_ins <= mem_reg_ins @[Core.scala 166:17]
    Execute.io_ctl_aluSrc <= id_reg_ctl_aluSrc @[Core.scala 147:17]
    Execute.io_ctl_aluOp <= id_reg_ctl_aluOp @[Core.scala 148:16]
    Execute.io_ctl_aluSrc1 <= id_reg_ctl_aluSrc1 @[Core.scala 149:18]
    MEM.clock <= clock
    MEM.reset <= reset
    MEM.io_aluResultIn <= ex_reg_result @[Core.scala 210:22]
    MEM.io_writeData <= ex_reg_wd @[Core.scala 211:20]
    MEM.io_writeEnable <= ex_reg_ctl_memWrite @[Core.scala 213:22]
    MEM.io_readEnable <= ex_reg_ctl_memRead @[Core.scala 212:21]
    MEM.io_dccmReq_ready <= io_dmemReq_ready @[Core.scala 177:14]
    MEM.io_dccmRsp_valid <= io_dmemRsp_valid @[Core.scala 178:18]
    MEM.io_dccmRsp_bits_dataResponse <= io_dmemRsp_bits_dataResponse @[Core.scala 178:18]
    MEM.io_dccmRsp_bits_error <= io_dmemRsp_bits_error @[Core.scala 178:18]
    MEM.io_dccmRsp_bits_ackWrite <= io_dmemRsp_bits_ackWrite @[Core.scala 178:18]
    pc.clock <= clock
    pc.reset <= reset
    pc.io_in <= _T_6 @[Core.scala 88:12]
    pc.io_halt <= _T_1 @[Core.scala 87:14]
    rvfi.clock <= clock
    rvfi.reset <= reset
    rvfi.io_stall <= MEM.io_stall @[Core.scala 246:17]
    rvfi.io_insn <= if_reg_ins @[Core.scala 255:16]
    rvfi.io_rs1_rdata <= InstructionDecode.io_readData1 @[Core.scala 253:21]
    rvfi.io_rs2_rdata <= InstructionDecode.io_readData2 @[Core.scala 254:21]
    rvfi.io_rd_addr <= wb_addr @[Core.scala 252:19]
    rvfi.io_rd_wdata <= wb_data @[Core.scala 251:20]
    rvfi.io_pc <= pc.io_out @[Core.scala 247:14]
    rvfi.io_pc_offset <= pc.io_in @[Core.scala 250:21]
    rvfi.io_pc_four <= pc.io_pc4 @[Core.scala 249:19]
    rvfi.io_pc_src <= InstructionDecode.io_pcSrc @[Core.scala 248:18]

  module Switch1toN :
    input clock : Clock
    input reset : UInt<1>
    output io_hostIn_ready : UInt<1>
    input io_hostIn_valid : UInt<1>
    input io_hostIn_bits_cyc : UInt<1>
    input io_hostIn_bits_stb : UInt<1>
    input io_hostIn_bits_we : UInt<1>
    input io_hostIn_bits_adr : UInt<32>
    input io_hostIn_bits_dat : UInt<32>
    input io_hostIn_bits_sel : UInt<4>
    input io_hostOut_ready : UInt<1>
    output io_hostOut_valid : UInt<1>
    output io_hostOut_bits_ack : UInt<1>
    output io_hostOut_bits_dat : UInt<32>
    output io_hostOut_bits_err : UInt<1>
    input io_devOut_0_ready : UInt<1>
    output io_devOut_0_valid : UInt<1>
    output io_devOut_0_bits_cyc : UInt<1>
    output io_devOut_0_bits_stb : UInt<1>
    output io_devOut_0_bits_we : UInt<1>
    output io_devOut_0_bits_adr : UInt<32>
    output io_devOut_0_bits_dat : UInt<32>
    output io_devOut_0_bits_sel : UInt<4>
    input io_devOut_1_ready : UInt<1>
    output io_devOut_1_valid : UInt<1>
    output io_devOut_1_bits_cyc : UInt<1>
    output io_devOut_1_bits_stb : UInt<1>
    output io_devOut_1_bits_we : UInt<1>
    output io_devOut_1_bits_adr : UInt<32>
    output io_devOut_1_bits_dat : UInt<32>
    output io_devOut_1_bits_sel : UInt<4>
    input io_devOut_2_ready : UInt<1>
    output io_devOut_2_valid : UInt<1>
    output io_devOut_2_bits_cyc : UInt<1>
    output io_devOut_2_bits_stb : UInt<1>
    output io_devOut_2_bits_we : UInt<1>
    output io_devOut_2_bits_adr : UInt<32>
    output io_devOut_2_bits_dat : UInt<32>
    output io_devOut_2_bits_sel : UInt<4>
    input io_devOut_3_ready : UInt<1>
    output io_devOut_3_valid : UInt<1>
    output io_devOut_3_bits_cyc : UInt<1>
    output io_devOut_3_bits_stb : UInt<1>
    output io_devOut_3_bits_we : UInt<1>
    output io_devOut_3_bits_adr : UInt<32>
    output io_devOut_3_bits_dat : UInt<32>
    output io_devOut_3_bits_sel : UInt<4>
    input io_devOut_4_ready : UInt<1>
    output io_devOut_4_valid : UInt<1>
    output io_devOut_4_bits_cyc : UInt<1>
    output io_devOut_4_bits_stb : UInt<1>
    output io_devOut_4_bits_we : UInt<1>
    output io_devOut_4_bits_adr : UInt<32>
    output io_devOut_4_bits_dat : UInt<32>
    output io_devOut_4_bits_sel : UInt<4>
    output io_devIn_0_ready : UInt<1>
    input io_devIn_0_valid : UInt<1>
    input io_devIn_0_bits_ack : UInt<1>
    input io_devIn_0_bits_dat : UInt<32>
    input io_devIn_0_bits_err : UInt<1>
    output io_devIn_1_ready : UInt<1>
    input io_devIn_1_valid : UInt<1>
    input io_devIn_1_bits_ack : UInt<1>
    input io_devIn_1_bits_dat : UInt<32>
    input io_devIn_1_bits_err : UInt<1>
    output io_devIn_2_ready : UInt<1>
    input io_devIn_2_valid : UInt<1>
    input io_devIn_2_bits_ack : UInt<1>
    input io_devIn_2_bits_dat : UInt<32>
    input io_devIn_2_bits_err : UInt<1>
    output io_devIn_3_ready : UInt<1>
    input io_devIn_3_valid : UInt<1>
    input io_devIn_3_bits_ack : UInt<1>
    input io_devIn_3_bits_dat : UInt<32>
    input io_devIn_3_bits_err : UInt<1>
    output io_devIn_4_ready : UInt<1>
    input io_devIn_4_valid : UInt<1>
    input io_devIn_4_bits_ack : UInt<1>
    input io_devIn_4_bits_dat : UInt<32>
    input io_devIn_4_bits_err : UInt<1>
    input io_devSel : UInt<3>

    node _io_devOut_4_valid_T = eq(io_devSel, UInt<3>("h4")) @[Switch1toN.scala 23:55]
    node _io_devOut_4_valid_T_1 = and(io_hostIn_valid, _io_devOut_4_valid_T) @[Switch1toN.scala 23:41]
    node _io_devOut_0_valid_T = eq(io_devSel, UInt<1>("h0")) @[Switch1toN.scala 33:57]
    node _io_devOut_0_valid_T_1 = and(io_hostIn_valid, _io_devOut_0_valid_T) @[Switch1toN.scala 33:43]
    node _io_devOut_1_valid_T = eq(io_devSel, UInt<1>("h1")) @[Switch1toN.scala 33:57]
    node _io_devOut_1_valid_T_1 = and(io_hostIn_valid, _io_devOut_1_valid_T) @[Switch1toN.scala 33:43]
    node _io_devOut_2_valid_T = eq(io_devSel, UInt<2>("h2")) @[Switch1toN.scala 33:57]
    node _io_devOut_2_valid_T_1 = and(io_hostIn_valid, _io_devOut_2_valid_T) @[Switch1toN.scala 33:43]
    node _io_devOut_3_valid_T = eq(io_devSel, UInt<2>("h3")) @[Switch1toN.scala 33:57]
    node _io_devOut_3_valid_T_1 = and(io_hostIn_valid, _io_devOut_3_valid_T) @[Switch1toN.scala 33:43]
    node _T = eq(io_devSel, UInt<1>("h0")) @[Switch1toN.scala 39:20]
    node _GEN_0 = mux(_T, io_devIn_0_bits_err, io_devIn_4_bits_err) @[Switch1toN.scala 39:35 Switch1toN.scala 40:23 Switch1toN.scala 27:19]
    node _GEN_1 = mux(_T, io_devIn_0_bits_dat, io_devIn_4_bits_dat) @[Switch1toN.scala 39:35 Switch1toN.scala 40:23 Switch1toN.scala 27:19]
    node _GEN_2 = mux(_T, io_devIn_0_bits_ack, io_devIn_4_bits_ack) @[Switch1toN.scala 39:35 Switch1toN.scala 40:23 Switch1toN.scala 27:19]
    node _GEN_3 = mux(_T, io_devIn_0_valid, io_devIn_4_valid) @[Switch1toN.scala 39:35 Switch1toN.scala 41:24 Switch1toN.scala 26:20]
    node _T_1 = eq(io_devSel, UInt<1>("h1")) @[Switch1toN.scala 39:20]
    node _GEN_4 = mux(_T_1, io_devIn_1_bits_err, _GEN_0) @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
    node _GEN_5 = mux(_T_1, io_devIn_1_bits_dat, _GEN_1) @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
    node _GEN_6 = mux(_T_1, io_devIn_1_bits_ack, _GEN_2) @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
    node _GEN_7 = mux(_T_1, io_devIn_1_valid, _GEN_3) @[Switch1toN.scala 39:35 Switch1toN.scala 41:24]
    node _T_2 = eq(io_devSel, UInt<2>("h2")) @[Switch1toN.scala 39:20]
    node _GEN_8 = mux(_T_2, io_devIn_2_bits_err, _GEN_4) @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
    node _GEN_9 = mux(_T_2, io_devIn_2_bits_dat, _GEN_5) @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
    node _GEN_10 = mux(_T_2, io_devIn_2_bits_ack, _GEN_6) @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
    node _GEN_11 = mux(_T_2, io_devIn_2_valid, _GEN_7) @[Switch1toN.scala 39:35 Switch1toN.scala 41:24]
    node _T_3 = eq(io_devSel, UInt<2>("h3")) @[Switch1toN.scala 39:20]
    node _GEN_12 = mux(_T_3, io_devIn_3_bits_err, _GEN_8) @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
    node _GEN_13 = mux(_T_3, io_devIn_3_bits_dat, _GEN_9) @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
    node _GEN_14 = mux(_T_3, io_devIn_3_bits_ack, _GEN_10) @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
    node _GEN_15 = mux(_T_3, io_devIn_3_valid, _GEN_11) @[Switch1toN.scala 39:35 Switch1toN.scala 41:24]
    io_hostIn_ready <= UInt<1>("h1") @[Switch1toN.scala 17:19]
    io_hostOut_valid <= _GEN_15
    io_hostOut_bits_ack <= _GEN_14
    io_hostOut_bits_dat <= _GEN_13
    io_hostOut_bits_err <= _GEN_12
    io_devOut_0_valid <= _io_devOut_0_valid_T_1 @[Switch1toN.scala 33:24]
    io_devOut_0_bits_cyc <= io_hostIn_bits_cyc @[Switch1toN.scala 31:33]
    io_devOut_0_bits_stb <= io_hostIn_bits_stb @[Switch1toN.scala 31:33]
    io_devOut_0_bits_we <= io_hostIn_bits_we @[Switch1toN.scala 31:33]
    io_devOut_0_bits_adr <= io_hostIn_bits_adr @[Switch1toN.scala 31:33]
    io_devOut_0_bits_dat <= io_hostIn_bits_dat @[Switch1toN.scala 31:33]
    io_devOut_0_bits_sel <= io_hostIn_bits_sel @[Switch1toN.scala 31:33]
    io_devOut_1_valid <= _io_devOut_1_valid_T_1 @[Switch1toN.scala 33:24]
    io_devOut_1_bits_cyc <= io_hostIn_bits_cyc @[Switch1toN.scala 31:33]
    io_devOut_1_bits_stb <= io_hostIn_bits_stb @[Switch1toN.scala 31:33]
    io_devOut_1_bits_we <= io_hostIn_bits_we @[Switch1toN.scala 31:33]
    io_devOut_1_bits_adr <= io_hostIn_bits_adr @[Switch1toN.scala 31:33]
    io_devOut_1_bits_dat <= io_hostIn_bits_dat @[Switch1toN.scala 31:33]
    io_devOut_1_bits_sel <= io_hostIn_bits_sel @[Switch1toN.scala 31:33]
    io_devOut_2_valid <= _io_devOut_2_valid_T_1 @[Switch1toN.scala 33:24]
    io_devOut_2_bits_cyc <= io_hostIn_bits_cyc @[Switch1toN.scala 31:33]
    io_devOut_2_bits_stb <= io_hostIn_bits_stb @[Switch1toN.scala 31:33]
    io_devOut_2_bits_we <= io_hostIn_bits_we @[Switch1toN.scala 31:33]
    io_devOut_2_bits_adr <= io_hostIn_bits_adr @[Switch1toN.scala 31:33]
    io_devOut_2_bits_dat <= io_hostIn_bits_dat @[Switch1toN.scala 31:33]
    io_devOut_2_bits_sel <= io_hostIn_bits_sel @[Switch1toN.scala 31:33]
    io_devOut_3_valid <= _io_devOut_3_valid_T_1 @[Switch1toN.scala 33:24]
    io_devOut_3_bits_cyc <= io_hostIn_bits_cyc @[Switch1toN.scala 31:33]
    io_devOut_3_bits_stb <= io_hostIn_bits_stb @[Switch1toN.scala 31:33]
    io_devOut_3_bits_we <= io_hostIn_bits_we @[Switch1toN.scala 31:33]
    io_devOut_3_bits_adr <= io_hostIn_bits_adr @[Switch1toN.scala 31:33]
    io_devOut_3_bits_dat <= io_hostIn_bits_dat @[Switch1toN.scala 31:33]
    io_devOut_3_bits_sel <= io_hostIn_bits_sel @[Switch1toN.scala 31:33]
    io_devOut_4_valid <= _io_devOut_4_valid_T_1 @[Switch1toN.scala 23:22]
    io_devOut_4_bits_cyc <= io_hostIn_bits_cyc @[Switch1toN.scala 31:33]
    io_devOut_4_bits_stb <= io_hostIn_bits_stb @[Switch1toN.scala 31:33]
    io_devOut_4_bits_we <= io_hostIn_bits_we @[Switch1toN.scala 31:33]
    io_devOut_4_bits_adr <= io_hostIn_bits_adr @[Switch1toN.scala 31:33]
    io_devOut_4_bits_dat <= io_hostIn_bits_dat @[Switch1toN.scala 31:33]
    io_devOut_4_bits_sel <= io_hostIn_bits_sel @[Switch1toN.scala 31:33]
    io_devIn_0_ready <= UInt<1>("h1") @[Switch1toN.scala 19:29]
    io_devIn_1_ready <= UInt<1>("h1") @[Switch1toN.scala 19:29]
    io_devIn_2_ready <= UInt<1>("h1") @[Switch1toN.scala 19:29]
    io_devIn_3_ready <= UInt<1>("h1") @[Switch1toN.scala 19:29]
    io_devIn_4_ready <= UInt<1>("h1") @[Switch1toN.scala 19:29]

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io_spi_cs_n : UInt<1>
    output io_spi_sclk : UInt<1>
    output io_spi_mosi : UInt<1>
    input io_spi_miso : UInt<1>
    input io_cio_uart_rx_i : UInt<1>
    output io_cio_uart_tx_o : UInt<1>
    output io_cio_uart_intr_tx_o : UInt<1>
    output io_gpio_o : UInt<8>
    output io_gpio_en_o : UInt<8>
    input io_gpio_i : UInt<8>

    inst wb_imem_host of WishboneHost @[Top.scala 300:28]
    inst wb_imem_slave of WishboneDevice @[Top.scala 301:29]
    inst wb_dmem_host of WishboneHost @[Top.scala 302:28]
    inst wb_dmem_slave of WishboneDevice @[Top.scala 303:29]
    inst wb_spi_slave of WishboneDevice @[Top.scala 304:28]
    inst wb_uart_slave of WishboneDevice @[Top.scala 305:29]
    inst wb_gpio_slave of WishboneDevice @[Top.scala 306:29]
    inst imem of BlockRamWithoutMasking @[Top.scala 307:20]
    inst dmem of BlockRamWithMasking @[Top.scala 308:20]
    inst gpio of Gpio @[Top.scala 309:20]
    inst spi of Spi @[Top.scala 311:19]
    inst uart of uart @[Top.scala 312:20]
    inst wbErr of WishboneErr @[Top.scala 314:21]
    inst core of Core @[Top.scala 315:20]
    inst switch of Switch1toN @[Top.scala 326:22]
    node _switch_io_devSel_addr_hit_0_T = not(UInt<32>("hfff")) @[BusDecoder.scala 45:23]
    node _switch_io_devSel_addr_hit_0_T_1 = and(_switch_io_devSel_addr_hit_0_T, wb_dmem_host.io_wbMasterTransmitter_bits_adr) @[BusDecoder.scala 45:60]
    node _switch_io_devSel_addr_hit_0_T_2 = eq(_switch_io_devSel_addr_hit_0_T_1, UInt<32>("h40000000")) @[BusDecoder.scala 45:68]
    node _switch_io_devSel_id_0_T = not(UInt<32>("hfff")) @[BusDecoder.scala 46:21]
    node _switch_io_devSel_id_0_T_1 = and(_switch_io_devSel_id_0_T, wb_dmem_host.io_wbMasterTransmitter_bits_adr) @[BusDecoder.scala 46:58]
    node _switch_io_devSel_id_0_T_2 = eq(_switch_io_devSel_id_0_T_1, UInt<32>("h40000000")) @[BusDecoder.scala 46:66]
    node _switch_io_devSel_id_0_T_3 = asUInt(UInt<1>("h1")) @[BusDecoder.scala 47:52]
    node _switch_io_devSel_id_0_T_4 = mux(_switch_io_devSel_id_0_T_2, _switch_io_devSel_id_0_T_3, UInt<3>("h4")) @[BusDecoder.scala 46:19]
    node _switch_io_devSel_addr_hit_1_T = not(UInt<32>("hfff")) @[BusDecoder.scala 45:23]
    node _switch_io_devSel_addr_hit_1_T_1 = and(_switch_io_devSel_addr_hit_1_T, wb_dmem_host.io_wbMasterTransmitter_bits_adr) @[BusDecoder.scala 45:60]
    node _switch_io_devSel_addr_hit_1_T_2 = eq(_switch_io_devSel_addr_hit_1_T_1, UInt<32>("h40001000")) @[BusDecoder.scala 45:68]
    node _switch_io_devSel_id_1_T = not(UInt<32>("hfff")) @[BusDecoder.scala 46:21]
    node _switch_io_devSel_id_1_T_1 = and(_switch_io_devSel_id_1_T, wb_dmem_host.io_wbMasterTransmitter_bits_adr) @[BusDecoder.scala 46:58]
    node _switch_io_devSel_id_1_T_2 = eq(_switch_io_devSel_id_1_T_1, UInt<32>("h40001000")) @[BusDecoder.scala 46:66]
    node _switch_io_devSel_id_1_T_3 = asUInt(UInt<2>("h3")) @[BusDecoder.scala 47:52]
    node _switch_io_devSel_id_1_T_4 = mux(_switch_io_devSel_id_1_T_2, _switch_io_devSel_id_1_T_3, UInt<3>("h4")) @[BusDecoder.scala 46:19]
    node _switch_io_devSel_addr_hit_2_T = not(UInt<32>("hfff")) @[BusDecoder.scala 45:23]
    node _switch_io_devSel_addr_hit_2_T_1 = and(_switch_io_devSel_addr_hit_2_T, wb_dmem_host.io_wbMasterTransmitter_bits_adr) @[BusDecoder.scala 45:60]
    node _switch_io_devSel_addr_hit_2_T_2 = eq(_switch_io_devSel_addr_hit_2_T_1, UInt<32>("h40003000")) @[BusDecoder.scala 45:68]
    node _switch_io_devSel_id_2_T = not(UInt<32>("hfff")) @[BusDecoder.scala 46:21]
    node _switch_io_devSel_id_2_T_1 = and(_switch_io_devSel_id_2_T, wb_dmem_host.io_wbMasterTransmitter_bits_adr) @[BusDecoder.scala 46:58]
    node _switch_io_devSel_id_2_T_2 = eq(_switch_io_devSel_id_2_T_1, UInt<32>("h40003000")) @[BusDecoder.scala 46:66]
    node _switch_io_devSel_id_2_T_3 = asUInt(UInt<2>("h2")) @[BusDecoder.scala 47:52]
    node _switch_io_devSel_id_2_T_4 = mux(_switch_io_devSel_id_2_T_2, _switch_io_devSel_id_2_T_3, UInt<3>("h4")) @[BusDecoder.scala 46:19]
    node _switch_io_devSel_addr_hit_3_T = not(UInt<32>("hfff")) @[BusDecoder.scala 45:23]
    node _switch_io_devSel_addr_hit_3_T_1 = and(_switch_io_devSel_addr_hit_3_T, wb_dmem_host.io_wbMasterTransmitter_bits_adr) @[BusDecoder.scala 45:60]
    node _switch_io_devSel_addr_hit_3_T_2 = eq(_switch_io_devSel_addr_hit_3_T_1, UInt<32>("h40002000")) @[BusDecoder.scala 45:68]
    node _switch_io_devSel_id_3_T = not(UInt<32>("hfff")) @[BusDecoder.scala 46:21]
    node _switch_io_devSel_id_3_T_1 = and(_switch_io_devSel_id_3_T, wb_dmem_host.io_wbMasterTransmitter_bits_adr) @[BusDecoder.scala 46:58]
    node _switch_io_devSel_id_3_T_2 = eq(_switch_io_devSel_id_3_T_1, UInt<32>("h40002000")) @[BusDecoder.scala 46:66]
    node _switch_io_devSel_id_3_T_3 = asUInt(UInt<1>("h0")) @[BusDecoder.scala 47:52]
    node _switch_io_devSel_id_3_T_4 = mux(_switch_io_devSel_id_3_T_2, _switch_io_devSel_id_3_T_3, UInt<3>("h4")) @[BusDecoder.scala 46:19]
    node switch_io_devSel_addr_hit_3 = _switch_io_devSel_addr_hit_3_T_2 @[BusDecoder.scala 37:24 BusDecoder.scala 45:19]
    node switch_io_devSel_id_3 = _switch_io_devSel_id_3_T_4 @[BusDecoder.scala 39:18 BusDecoder.scala 46:13]
    node _switch_io_devSel_T = mux(switch_io_devSel_addr_hit_3, switch_io_devSel_id_3, UInt<3>("h4")) @[Mux.scala 98:16]
    node switch_io_devSel_addr_hit_2 = _switch_io_devSel_addr_hit_2_T_2 @[BusDecoder.scala 37:24 BusDecoder.scala 45:19]
    node switch_io_devSel_id_2 = _switch_io_devSel_id_2_T_4 @[BusDecoder.scala 39:18 BusDecoder.scala 46:13]
    node _switch_io_devSel_T_1 = mux(switch_io_devSel_addr_hit_2, switch_io_devSel_id_2, _switch_io_devSel_T) @[Mux.scala 98:16]
    node switch_io_devSel_addr_hit_1 = _switch_io_devSel_addr_hit_1_T_2 @[BusDecoder.scala 37:24 BusDecoder.scala 45:19]
    node switch_io_devSel_id_1 = _switch_io_devSel_id_1_T_4 @[BusDecoder.scala 39:18 BusDecoder.scala 46:13]
    node _switch_io_devSel_T_2 = mux(switch_io_devSel_addr_hit_1, switch_io_devSel_id_1, _switch_io_devSel_T_1) @[Mux.scala 98:16]
    node switch_io_devSel_addr_hit_0 = _switch_io_devSel_addr_hit_0_T_2 @[BusDecoder.scala 37:24 BusDecoder.scala 45:19]
    node switch_io_devSel_id_0 = _switch_io_devSel_id_0_T_4 @[BusDecoder.scala 39:18 BusDecoder.scala 46:13]
    node _switch_io_devSel_T_3 = mux(switch_io_devSel_addr_hit_0, switch_io_devSel_id_0, _switch_io_devSel_T_2) @[Mux.scala 98:16]
    node _io_gpio_o_T = bits(gpio.io_cio_gpio_o, 7, 0) @[Top.scala 379:34]
    node _io_gpio_en_o_T = bits(gpio.io_cio_gpio_en_o, 7, 0) @[Top.scala 380:40]
    io_spi_cs_n <= spi.io_cs_n @[Top.scala 369:15]
    io_spi_sclk <= spi.io_sclk @[Top.scala 370:15]
    io_spi_mosi <= spi.io_mosi @[Top.scala 371:15]
    io_cio_uart_tx_o <= uart.io_cio_uart_tx_o @[Top.scala 365:20]
    io_cio_uart_intr_tx_o <= uart.io_cio_uart_intr_tx_o @[Top.scala 366:25]
    io_gpio_o <= _io_gpio_o_T @[Top.scala 379:13]
    io_gpio_en_o <= _io_gpio_en_o_T @[Top.scala 380:16]
    wb_imem_host.clock <= clock
    wb_imem_host.reset <= reset
    wb_imem_host.io_wbMasterTransmitter_ready <= wb_imem_slave.io_wbMasterReceiver_ready @[Top.scala 335:39]
    wb_imem_host.io_wbSlaveReceiver_valid <= wb_imem_slave.io_wbSlaveTransmitter_valid @[Top.scala 336:39]
    wb_imem_host.io_wbSlaveReceiver_bits_ack <= wb_imem_slave.io_wbSlaveTransmitter_bits_ack @[Top.scala 336:39]
    wb_imem_host.io_wbSlaveReceiver_bits_dat <= wb_imem_slave.io_wbSlaveTransmitter_bits_dat @[Top.scala 336:39]
    wb_imem_host.io_wbSlaveReceiver_bits_err <= wb_imem_slave.io_wbSlaveTransmitter_bits_err @[Top.scala 336:39]
    wb_imem_host.io_reqIn_valid <= core.io_imemReq_valid @[Top.scala 329:25]
    wb_imem_host.io_reqIn_bits_addrRequest <= core.io_imemReq_bits_addrRequest @[Top.scala 329:25]
    wb_imem_host.io_reqIn_bits_dataRequest <= core.io_imemReq_bits_dataRequest @[Top.scala 329:25]
    wb_imem_host.io_reqIn_bits_activeByteLane <= core.io_imemReq_bits_activeByteLane @[Top.scala 329:25]
    wb_imem_host.io_reqIn_bits_isWrite <= core.io_imemReq_bits_isWrite @[Top.scala 329:25]
    wb_imem_host.io_rspOut_ready <= core.io_imemRsp_ready @[Top.scala 330:19]
    wb_imem_slave.clock <= clock
    wb_imem_slave.reset <= reset
    wb_imem_slave.io_wbSlaveTransmitter_ready <= wb_imem_host.io_wbSlaveReceiver_ready @[Top.scala 336:39]
    wb_imem_slave.io_wbMasterReceiver_valid <= wb_imem_host.io_wbMasterTransmitter_valid @[Top.scala 335:39]
    wb_imem_slave.io_wbMasterReceiver_bits_cyc <= wb_imem_host.io_wbMasterTransmitter_bits_cyc @[Top.scala 335:39]
    wb_imem_slave.io_wbMasterReceiver_bits_stb <= wb_imem_host.io_wbMasterTransmitter_bits_stb @[Top.scala 335:39]
    wb_imem_slave.io_wbMasterReceiver_bits_we <= wb_imem_host.io_wbMasterTransmitter_bits_we @[Top.scala 335:39]
    wb_imem_slave.io_wbMasterReceiver_bits_adr <= wb_imem_host.io_wbMasterTransmitter_bits_adr @[Top.scala 335:39]
    wb_imem_slave.io_wbMasterReceiver_bits_dat <= wb_imem_host.io_wbMasterTransmitter_bits_dat @[Top.scala 335:39]
    wb_imem_slave.io_wbMasterReceiver_bits_sel <= wb_imem_host.io_wbMasterTransmitter_bits_sel @[Top.scala 335:39]
    wb_imem_slave.io_reqOut_ready <= imem.io_req_ready @[Top.scala 331:27]
    wb_imem_slave.io_rspIn_valid <= imem.io_rsp_valid @[Top.scala 332:26]
    wb_imem_slave.io_rspIn_bits_dataResponse <= imem.io_rsp_bits_dataResponse @[Top.scala 332:26]
    wb_imem_slave.io_rspIn_bits_error <= imem.io_rsp_bits_error @[Top.scala 332:26]
    wb_imem_slave.io_rspIn_bits_ackWrite <= imem.io_rsp_bits_ackWrite @[Top.scala 332:26]
    wb_dmem_host.clock <= clock
    wb_dmem_host.reset <= reset
    wb_dmem_host.io_wbMasterTransmitter_ready <= switch.io_hostIn_ready @[Top.scala 346:20]
    wb_dmem_host.io_wbSlaveReceiver_valid <= switch.io_hostOut_valid @[Top.scala 347:21]
    wb_dmem_host.io_wbSlaveReceiver_bits_ack <= switch.io_hostOut_bits_ack @[Top.scala 347:21]
    wb_dmem_host.io_wbSlaveReceiver_bits_dat <= switch.io_hostOut_bits_dat @[Top.scala 347:21]
    wb_dmem_host.io_wbSlaveReceiver_bits_err <= switch.io_hostOut_bits_err @[Top.scala 347:21]
    wb_dmem_host.io_reqIn_valid <= core.io_dmemReq_valid @[Top.scala 339:25]
    wb_dmem_host.io_reqIn_bits_addrRequest <= core.io_dmemReq_bits_addrRequest @[Top.scala 339:25]
    wb_dmem_host.io_reqIn_bits_dataRequest <= core.io_dmemReq_bits_dataRequest @[Top.scala 339:25]
    wb_dmem_host.io_reqIn_bits_activeByteLane <= core.io_dmemReq_bits_activeByteLane @[Top.scala 339:25]
    wb_dmem_host.io_reqIn_bits_isWrite <= core.io_dmemReq_bits_isWrite @[Top.scala 339:25]
    wb_dmem_host.io_rspOut_ready <= core.io_dmemRsp_ready @[Top.scala 340:19]
    wb_dmem_slave.clock <= clock
    wb_dmem_slave.reset <= reset
    wb_dmem_slave.io_wbSlaveTransmitter_ready <= switch.io_devIn_1_ready @[Top.scala 349:53]
    wb_dmem_slave.io_wbMasterReceiver_valid <= switch.io_devOut_1_valid @[Top.scala 350:54]
    wb_dmem_slave.io_wbMasterReceiver_bits_cyc <= switch.io_devOut_1_bits_cyc @[Top.scala 350:54]
    wb_dmem_slave.io_wbMasterReceiver_bits_stb <= switch.io_devOut_1_bits_stb @[Top.scala 350:54]
    wb_dmem_slave.io_wbMasterReceiver_bits_we <= switch.io_devOut_1_bits_we @[Top.scala 350:54]
    wb_dmem_slave.io_wbMasterReceiver_bits_adr <= switch.io_devOut_1_bits_adr @[Top.scala 350:54]
    wb_dmem_slave.io_wbMasterReceiver_bits_dat <= switch.io_devOut_1_bits_dat @[Top.scala 350:54]
    wb_dmem_slave.io_wbMasterReceiver_bits_sel <= switch.io_devOut_1_bits_sel @[Top.scala 350:54]
    wb_dmem_slave.io_reqOut_ready <= dmem.io_req_ready @[Top.scala 341:27]
    wb_dmem_slave.io_rspIn_valid <= dmem.io_rsp_valid @[Top.scala 342:26]
    wb_dmem_slave.io_rspIn_bits_dataResponse <= dmem.io_rsp_bits_dataResponse @[Top.scala 342:26]
    wb_dmem_slave.io_rspIn_bits_error <= dmem.io_rsp_bits_error @[Top.scala 342:26]
    wb_dmem_slave.io_rspIn_bits_ackWrite <= dmem.io_rsp_bits_ackWrite @[Top.scala 342:26]
    wb_spi_slave.clock <= clock
    wb_spi_slave.reset <= reset
    wb_spi_slave.io_wbSlaveTransmitter_ready <= switch.io_devIn_3_ready @[Top.scala 349:53]
    wb_spi_slave.io_wbMasterReceiver_valid <= switch.io_devOut_3_valid @[Top.scala 350:54]
    wb_spi_slave.io_wbMasterReceiver_bits_cyc <= switch.io_devOut_3_bits_cyc @[Top.scala 350:54]
    wb_spi_slave.io_wbMasterReceiver_bits_stb <= switch.io_devOut_3_bits_stb @[Top.scala 350:54]
    wb_spi_slave.io_wbMasterReceiver_bits_we <= switch.io_devOut_3_bits_we @[Top.scala 350:54]
    wb_spi_slave.io_wbMasterReceiver_bits_adr <= switch.io_devOut_3_bits_adr @[Top.scala 350:54]
    wb_spi_slave.io_wbMasterReceiver_bits_dat <= switch.io_devOut_3_bits_dat @[Top.scala 350:54]
    wb_spi_slave.io_wbMasterReceiver_bits_sel <= switch.io_devOut_3_bits_sel @[Top.scala 350:54]
    wb_spi_slave.io_reqOut_ready <= spi.io_req_ready @[Top.scala 358:26]
    wb_spi_slave.io_rspIn_valid <= spi.io_rsp_valid @[Top.scala 359:25]
    wb_spi_slave.io_rspIn_bits_dataResponse <= spi.io_rsp_bits_dataResponse @[Top.scala 359:25]
    wb_spi_slave.io_rspIn_bits_error <= spi.io_rsp_bits_error @[Top.scala 359:25]
    wb_spi_slave.io_rspIn_bits_ackWrite <= spi.io_rsp_bits_ackWrite @[Top.scala 359:25]
    wb_uart_slave.clock <= clock
    wb_uart_slave.reset <= reset
    wb_uart_slave.io_wbSlaveTransmitter_ready <= switch.io_devIn_0_ready @[Top.scala 349:53]
    wb_uart_slave.io_wbMasterReceiver_valid <= switch.io_devOut_0_valid @[Top.scala 350:54]
    wb_uart_slave.io_wbMasterReceiver_bits_cyc <= switch.io_devOut_0_bits_cyc @[Top.scala 350:54]
    wb_uart_slave.io_wbMasterReceiver_bits_stb <= switch.io_devOut_0_bits_stb @[Top.scala 350:54]
    wb_uart_slave.io_wbMasterReceiver_bits_we <= switch.io_devOut_0_bits_we @[Top.scala 350:54]
    wb_uart_slave.io_wbMasterReceiver_bits_adr <= switch.io_devOut_0_bits_adr @[Top.scala 350:54]
    wb_uart_slave.io_wbMasterReceiver_bits_dat <= switch.io_devOut_0_bits_dat @[Top.scala 350:54]
    wb_uart_slave.io_wbMasterReceiver_bits_sel <= switch.io_devOut_0_bits_sel @[Top.scala 350:54]
    wb_uart_slave.io_reqOut_ready <= uart.io_request_ready @[Top.scala 361:27]
    wb_uart_slave.io_rspIn_valid <= uart.io_response_valid @[Top.scala 362:26]
    wb_uart_slave.io_rspIn_bits_dataResponse <= uart.io_response_bits_dataResponse @[Top.scala 362:26]
    wb_uart_slave.io_rspIn_bits_error <= uart.io_response_bits_error @[Top.scala 362:26]
    wb_uart_slave.io_rspIn_bits_ackWrite <= uart.io_response_bits_ackWrite @[Top.scala 362:26]
    wb_gpio_slave.clock <= clock
    wb_gpio_slave.reset <= reset
    wb_gpio_slave.io_wbSlaveTransmitter_ready <= switch.io_devIn_2_ready @[Top.scala 349:53]
    wb_gpio_slave.io_wbMasterReceiver_valid <= switch.io_devOut_2_valid @[Top.scala 350:54]
    wb_gpio_slave.io_wbMasterReceiver_bits_cyc <= switch.io_devOut_2_bits_cyc @[Top.scala 350:54]
    wb_gpio_slave.io_wbMasterReceiver_bits_stb <= switch.io_devOut_2_bits_stb @[Top.scala 350:54]
    wb_gpio_slave.io_wbMasterReceiver_bits_we <= switch.io_devOut_2_bits_we @[Top.scala 350:54]
    wb_gpio_slave.io_wbMasterReceiver_bits_adr <= switch.io_devOut_2_bits_adr @[Top.scala 350:54]
    wb_gpio_slave.io_wbMasterReceiver_bits_dat <= switch.io_devOut_2_bits_dat @[Top.scala 350:54]
    wb_gpio_slave.io_wbMasterReceiver_bits_sel <= switch.io_devOut_2_bits_sel @[Top.scala 350:54]
    wb_gpio_slave.io_reqOut_ready <= gpio.io_req_ready @[Top.scala 376:27]
    wb_gpio_slave.io_rspIn_valid <= gpio.io_rsp_valid @[Top.scala 377:26]
    wb_gpio_slave.io_rspIn_bits_dataResponse <= gpio.io_rsp_bits_dataResponse @[Top.scala 377:26]
    wb_gpio_slave.io_rspIn_bits_error <= gpio.io_rsp_bits_error @[Top.scala 377:26]
    wb_gpio_slave.io_rspIn_bits_ackWrite <= gpio.io_rsp_bits_ackWrite @[Top.scala 377:26]
    imem.clock <= clock
    imem.reset <= reset
    imem.io_req_valid <= wb_imem_slave.io_reqOut_valid @[Top.scala 331:27]
    imem.io_req_bits_addrRequest <= wb_imem_slave.io_reqOut_bits_addrRequest @[Top.scala 331:27]
    imem.io_req_bits_dataRequest <= wb_imem_slave.io_reqOut_bits_dataRequest @[Top.scala 331:27]
    imem.io_req_bits_activeByteLane <= wb_imem_slave.io_reqOut_bits_activeByteLane @[Top.scala 331:27]
    imem.io_req_bits_isWrite <= wb_imem_slave.io_reqOut_bits_isWrite @[Top.scala 331:27]
    imem.io_rsp_ready <= wb_imem_slave.io_rspIn_ready @[Top.scala 332:26]
    dmem.clock <= clock
    dmem.reset <= reset
    dmem.io_req_valid <= wb_dmem_slave.io_reqOut_valid @[Top.scala 341:27]
    dmem.io_req_bits_addrRequest <= wb_dmem_slave.io_reqOut_bits_addrRequest @[Top.scala 341:27]
    dmem.io_req_bits_dataRequest <= wb_dmem_slave.io_reqOut_bits_dataRequest @[Top.scala 341:27]
    dmem.io_req_bits_activeByteLane <= wb_dmem_slave.io_reqOut_bits_activeByteLane @[Top.scala 341:27]
    dmem.io_req_bits_isWrite <= wb_dmem_slave.io_reqOut_bits_isWrite @[Top.scala 341:27]
    dmem.io_rsp_ready <= wb_dmem_slave.io_rspIn_ready @[Top.scala 342:26]
    gpio.clock <= clock
    gpio.reset <= reset
    gpio.io_req_valid <= wb_gpio_slave.io_reqOut_valid @[Top.scala 376:27]
    gpio.io_req_bits_addrRequest <= wb_gpio_slave.io_reqOut_bits_addrRequest @[Top.scala 376:27]
    gpio.io_req_bits_dataRequest <= wb_gpio_slave.io_reqOut_bits_dataRequest @[Top.scala 376:27]
    gpio.io_req_bits_activeByteLane <= wb_gpio_slave.io_reqOut_bits_activeByteLane @[Top.scala 376:27]
    gpio.io_req_bits_isWrite <= wb_gpio_slave.io_reqOut_bits_isWrite @[Top.scala 376:27]
    gpio.io_rsp_ready <= wb_gpio_slave.io_rspIn_ready @[Top.scala 377:26]
    gpio.io_cio_gpio_i <= io_gpio_i @[Top.scala 381:22]
    spi.clock <= clock
    spi.reset <= reset
    spi.io_req_valid <= wb_spi_slave.io_reqOut_valid @[Top.scala 358:26]
    spi.io_req_bits_addrRequest <= wb_spi_slave.io_reqOut_bits_addrRequest @[Top.scala 358:26]
    spi.io_req_bits_dataRequest <= wb_spi_slave.io_reqOut_bits_dataRequest @[Top.scala 358:26]
    spi.io_req_bits_activeByteLane <= wb_spi_slave.io_reqOut_bits_activeByteLane @[Top.scala 358:26]
    spi.io_req_bits_isWrite <= wb_spi_slave.io_reqOut_bits_isWrite @[Top.scala 358:26]
    spi.io_rsp_ready <= wb_spi_slave.io_rspIn_ready @[Top.scala 359:25]
    spi.io_miso <= io_spi_miso @[Top.scala 372:15]
    uart.clock <= clock
    uart.reset <= reset
    uart.io_request_valid <= wb_uart_slave.io_reqOut_valid @[Top.scala 361:27]
    uart.io_request_bits_addrRequest <= wb_uart_slave.io_reqOut_bits_addrRequest @[Top.scala 361:27]
    uart.io_request_bits_dataRequest <= wb_uart_slave.io_reqOut_bits_dataRequest @[Top.scala 361:27]
    uart.io_request_bits_activeByteLane <= wb_uart_slave.io_reqOut_bits_activeByteLane @[Top.scala 361:27]
    uart.io_request_bits_isWrite <= wb_uart_slave.io_reqOut_bits_isWrite @[Top.scala 361:27]
    uart.io_response_ready <= wb_uart_slave.io_rspIn_ready @[Top.scala 362:26]
    uart.io_cio_uart_rx_i <= io_cio_uart_rx_i @[Top.scala 364:25]
    wbErr.clock <= clock
    wbErr.reset <= reset
    wbErr.io_wbSlaveTransmitter_ready <= switch.io_devIn_4_ready @[Top.scala 352:33]
    wbErr.io_wbMasterReceiver_valid <= switch.io_devOut_4_valid @[Top.scala 353:34]
    wbErr.io_wbMasterReceiver_bits_cyc <= switch.io_devOut_4_bits_cyc @[Top.scala 353:34]
    wbErr.io_wbMasterReceiver_bits_stb <= switch.io_devOut_4_bits_stb @[Top.scala 353:34]
    wbErr.io_wbMasterReceiver_bits_we <= switch.io_devOut_4_bits_we @[Top.scala 353:34]
    wbErr.io_wbMasterReceiver_bits_adr <= switch.io_devOut_4_bits_adr @[Top.scala 353:34]
    wbErr.io_wbMasterReceiver_bits_dat <= switch.io_devOut_4_bits_dat @[Top.scala 353:34]
    wbErr.io_wbMasterReceiver_bits_sel <= switch.io_devOut_4_bits_sel @[Top.scala 353:34]
    core.clock <= clock
    core.reset <= reset
    core.io_dmemReq_ready <= wb_dmem_host.io_reqIn_ready @[Top.scala 339:25]
    core.io_dmemRsp_valid <= wb_dmem_host.io_rspOut_valid @[Top.scala 340:19]
    core.io_dmemRsp_bits_dataResponse <= wb_dmem_host.io_rspOut_bits_dataResponse @[Top.scala 340:19]
    core.io_dmemRsp_bits_error <= wb_dmem_host.io_rspOut_bits_error @[Top.scala 340:19]
    core.io_dmemRsp_bits_ackWrite <= wb_dmem_host.io_rspOut_bits_ackWrite @[Top.scala 340:19]
    core.io_imemReq_ready <= wb_imem_host.io_reqIn_ready @[Top.scala 329:25]
    core.io_imemRsp_valid <= wb_imem_host.io_rspOut_valid @[Top.scala 330:19]
    core.io_imemRsp_bits_dataResponse <= wb_imem_host.io_rspOut_bits_dataResponse @[Top.scala 330:19]
    core.io_imemRsp_bits_error <= wb_imem_host.io_rspOut_bits_error @[Top.scala 330:19]
    core.io_imemRsp_bits_ackWrite <= wb_imem_host.io_rspOut_bits_ackWrite @[Top.scala 330:19]
    switch.clock <= clock
    switch.reset <= reset
    switch.io_hostIn_valid <= wb_dmem_host.io_wbMasterTransmitter_valid @[Top.scala 346:20]
    switch.io_hostIn_bits_cyc <= wb_dmem_host.io_wbMasterTransmitter_bits_cyc @[Top.scala 346:20]
    switch.io_hostIn_bits_stb <= wb_dmem_host.io_wbMasterTransmitter_bits_stb @[Top.scala 346:20]
    switch.io_hostIn_bits_we <= wb_dmem_host.io_wbMasterTransmitter_bits_we @[Top.scala 346:20]
    switch.io_hostIn_bits_adr <= wb_dmem_host.io_wbMasterTransmitter_bits_adr @[Top.scala 346:20]
    switch.io_hostIn_bits_dat <= wb_dmem_host.io_wbMasterTransmitter_bits_dat @[Top.scala 346:20]
    switch.io_hostIn_bits_sel <= wb_dmem_host.io_wbMasterTransmitter_bits_sel @[Top.scala 346:20]
    switch.io_hostOut_ready <= wb_dmem_host.io_wbSlaveReceiver_ready @[Top.scala 347:21]
    switch.io_devOut_0_ready <= wb_uart_slave.io_wbMasterReceiver_ready @[Top.scala 350:54]
    switch.io_devOut_1_ready <= wb_dmem_slave.io_wbMasterReceiver_ready @[Top.scala 350:54]
    switch.io_devOut_2_ready <= wb_gpio_slave.io_wbMasterReceiver_ready @[Top.scala 350:54]
    switch.io_devOut_3_ready <= wb_spi_slave.io_wbMasterReceiver_ready @[Top.scala 350:54]
    switch.io_devOut_4_ready <= wbErr.io_wbMasterReceiver_ready @[Top.scala 353:34]
    switch.io_devIn_0_valid <= wb_uart_slave.io_wbSlaveTransmitter_valid @[Top.scala 349:53]
    switch.io_devIn_0_bits_ack <= wb_uart_slave.io_wbSlaveTransmitter_bits_ack @[Top.scala 349:53]
    switch.io_devIn_0_bits_dat <= wb_uart_slave.io_wbSlaveTransmitter_bits_dat @[Top.scala 349:53]
    switch.io_devIn_0_bits_err <= wb_uart_slave.io_wbSlaveTransmitter_bits_err @[Top.scala 349:53]
    switch.io_devIn_1_valid <= wb_dmem_slave.io_wbSlaveTransmitter_valid @[Top.scala 349:53]
    switch.io_devIn_1_bits_ack <= wb_dmem_slave.io_wbSlaveTransmitter_bits_ack @[Top.scala 349:53]
    switch.io_devIn_1_bits_dat <= wb_dmem_slave.io_wbSlaveTransmitter_bits_dat @[Top.scala 349:53]
    switch.io_devIn_1_bits_err <= wb_dmem_slave.io_wbSlaveTransmitter_bits_err @[Top.scala 349:53]
    switch.io_devIn_2_valid <= wb_gpio_slave.io_wbSlaveTransmitter_valid @[Top.scala 349:53]
    switch.io_devIn_2_bits_ack <= wb_gpio_slave.io_wbSlaveTransmitter_bits_ack @[Top.scala 349:53]
    switch.io_devIn_2_bits_dat <= wb_gpio_slave.io_wbSlaveTransmitter_bits_dat @[Top.scala 349:53]
    switch.io_devIn_2_bits_err <= wb_gpio_slave.io_wbSlaveTransmitter_bits_err @[Top.scala 349:53]
    switch.io_devIn_3_valid <= wb_spi_slave.io_wbSlaveTransmitter_valid @[Top.scala 349:53]
    switch.io_devIn_3_bits_ack <= wb_spi_slave.io_wbSlaveTransmitter_bits_ack @[Top.scala 349:53]
    switch.io_devIn_3_bits_dat <= wb_spi_slave.io_wbSlaveTransmitter_bits_dat @[Top.scala 349:53]
    switch.io_devIn_3_bits_err <= wb_spi_slave.io_wbSlaveTransmitter_bits_err @[Top.scala 349:53]
    switch.io_devIn_4_valid <= wbErr.io_wbSlaveTransmitter_valid @[Top.scala 352:33]
    switch.io_devIn_4_bits_ack <= wbErr.io_wbSlaveTransmitter_bits_ack @[Top.scala 352:33]
    switch.io_devIn_4_bits_dat <= wbErr.io_wbSlaveTransmitter_bits_dat @[Top.scala 352:33]
    switch.io_devIn_4_bits_err <= wbErr.io_wbSlaveTransmitter_bits_err @[Top.scala 352:33]
    switch.io_devSel <= _switch_io_devSel_T_3 @[Top.scala 355:20]
