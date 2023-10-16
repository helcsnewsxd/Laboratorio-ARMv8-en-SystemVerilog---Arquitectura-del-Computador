// Etapa: DECODE

module decode #(
    parameter N = 64
) (
    input logic regWrite_D,
    reg2loc_D,
    clk,
    input logic [N-1:0] writeData3_D,
    input logic [31:0] instr_D,
    output logic [N-1:0] signImm_D,
    readData1_D,
    readData2_D,
    input logic [4:0] wa3_D,
    output logic data_hazard,
    output logic [4:0] ra1,
    ra2
);  // Eliminar para single cycle processor

  // HAZARD DETECTION UNIT (HDU)

  assign data_hazard = (memRead_ID_EX && (rd_ID_EX === ra1 || rd_ID_EX === ra2));

  // ----------------------

  assign ra1 = instr_D[9:5];

  mux2 #(5) ra2mux (
      .d0(instr_D[20:16]),
      .d1(instr_D[4:0]),
      .s (reg2loc_D),
      .y (ra2)
  );

  regfile registers (
      .clk(clk),
      .we3(regWrite_D),
      .ra1(ra1),
      .ra2(ra2),
      .wa3(wa3_D),
      .wd3(writeData3_D),
      .rd1(readData1_D),
      .rd2(readData2_D)
  );

  // En single cycle processor:						
  //regfile registers (.clk(clk), .we3(regWrite_D), .ra1(instr_D[9:5]), .ra2(ra2), .wa3(instr_D[4:0]), 
  //							 .wd3(writeData3_D), .rd1(readData1_D), .rd2(readData2_D));


  signext ext (
      .a(instr_D),
      .y(signImm_D)
  );

endmodule