VERILATOR ?= verilator
TOP       := tb_lut3
SRCS      := lut3.v tb_lut3.sv

.PHONY: sim clean

sim:
	$(VERILATOR) --binary --timing --trace -Wall --top-module $(TOP) $(SRCS)
	./obj_dir/V$(TOP)

clean:
	rm -rf obj_dir *.vcd
