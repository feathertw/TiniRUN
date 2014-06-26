#!/bin/bash
tinyos_dir=../TiniOS
tinysoc_dir=../TiniSOC
make -C ${tinyos_dir} \
&& python ${tinyos_dir}/opr/opcode_check.py ${tinysoc_dir}/CPU/def/def_opcode.v ${tinyos_dir}/elf/main.list \
&& python ${tinyos_dir}/opr/binary_analyze.py ${tinyos_dir}/elf/main.bin mbin.prog \
&& clear  \
&& iverilog testbench.v \
	-I${tinysoc_dir}/CPU \
	-I${tinysoc_dir}/CPU/def \
	-I${tinysoc_dir}/CPU/src \
	-I${tinysoc_dir}/CPU/unt \
	-I${tinysoc_dir}/BUS \
	-I${tinysoc_dir}/BUS/wrp \
	-I${tinysoc_dir}/MEM \
	-I${tinysoc_dir}/PER \
	-I${tinysoc_dir}/WRP \
&& ./a.out
