VERILATOR ?= verilator
TOP       := tb_delay_chain
SRCS      := delay_chain.v tb_delay_chain.sv

.PHONY: sim clean

sim:
	$(VERILATOR) --binary --timing --trace -Wall --top-module $(TOP) $(SRCS)
	./obj_dir/V$(TOP)

clean:
	rm -rf obj_dir *.vcd
