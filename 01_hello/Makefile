VERILATOR ?= verilator
TOP       := tb_hello
SRCS      := hello.v tb_hello.sv

.PHONY: sim clean

sim:
	$(VERILATOR) --binary --timing --trace -Wall --top-module $(TOP) $(SRCS)
	./obj_dir/V$(TOP)

clean:
	rm -rf obj_dir *.vcd
