VERILATOR ?= verilator
TOP       := tb_comb
SRCS      := comb.v tb_comb.sv

.PHONY: sim clean

sim:
	$(VERILATOR) --binary --timing --trace -Wall --top-module $(TOP) $(SRCS)
	./obj_dir/V$(TOP)

clean:
	rm -rf obj_dir *.vcd
