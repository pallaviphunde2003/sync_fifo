`include "uvm_macros.svh"
import uvm_pkg::*;

`include "sequence_item.sv"
`include "sequencer.sv"
`include "sequence.sv"
`include "driver.sv"
`include "interface.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"
`include "wr_test.sv"
`include "wr_rd_test.sv"
`include "wr_then_rd_test.sv"
`include "wr_rd_parll_test.sv"

module tbench_top;
  
  bit clk;
  bit reset;
  
//clock generation
  initial begin
    clk=0;
    forever #5 clk = ~clk; 
  end

//reset generation
  initial begin
    reset = 0;
    #2 reset =1;
  end
  
//interface instance
  fifo_interface in(clk,reset);
  
//dut's
  fifo_sync dut(.data_in(in.data_in),
                .clk(in.clk),
                .rst(in.rst),
                .wr(in.wr),
                .rd(in.rd),
                .empty(in.empty),
                .full(in.full),
                .data_out(in.data_out)
               );
//config db  
   initial begin 
     //set interface into config db, virtual intf, to get access in dynamic clss
     uvm_config_db#(virtual fifo_interface)::set(null,"*","vif",in);
  end
  

// test case
  initial begin
    //run_test("fifo_test"); // random stimulus       
    //run_test("fifo_wr_test"); //  write Only    
    //run_test("fifo_wr_then_rd_test"); //  write complete then read
    //run_test("fifo_wr_rd_parll_test"); //  write read parallel

    $display("Starting UVM Test...");  

    run_test("fifo_wr_rd_test"); //  back to back write & read
  end
  
  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
endmodule
