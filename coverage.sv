class fifo_coverage extends uvm_subscriber#(fifo_seq_item);

  `uvm_component_utils(fifo_coverage)

  fifo_seq_item trans;

  covergroup cg;
    option.per_instance = 1;

    // Basic control-signal coverage
    WR: coverpoint trans.wr {
      bins wr_low  = {0};
      bins wr_high = {1};
    }

    RD: coverpoint trans.rd {
      bins rd_low  = {0};
      bins rd_high = {1};
    }

    FULL: coverpoint trans.full {
      bins not_full = {0};
      bins is_full  = {1};
    }

    EMPTY: coverpoint trans.empty {
      bins not_empty = {0};
      bins is_empty  = {1};
    }

    DATA_IN: coverpoint trans.data_in {
      bins low  = {[0                          : (2**`DATA_WIDTH)/3 - 1]};
      bins mid  = {[(2**`DATA_WIDTH)/3          : 2*(2**`DATA_WIDTH)/3 - 1]};
      bins high = {[2*(2**`DATA_WIDTH)/3        : (2**`DATA_WIDTH)-1]};
    }

    WR_WHEN_FULL:    cross WR, FULL;     // did we ever attempt a write while full?
    RD_WHEN_EMPTY:   cross RD, EMPTY;    // did we ever attempt a read while empty?
    WR_RD_TOGETHER:  cross WR, RD;       // simultaneous write+read (parallel test)
    RD_WHEN_FULL:    cross RD, FULL;     // read right as the fifo was full
    WR_WHEN_EMPTY:   cross WR, EMPTY;    // write right as the fifo was empty

  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    cg = new();
  endfunction

  function void write(fifo_seq_item t);
    trans = t;
    cg.sample();
  endfunction

  function void report_phase(uvm_phase phase);
    `uvm_info("COVERAGE", $sformatf("Functional coverage = %0.2f%%", cg.get_coverage()), UVM_LOW)
  endfunction

endclass
