CHECK_RESULTS ?= ./check_results/
UT_FLAGS ?= --nographic -M stm32-p103 \
		-gdb tcp::3333 -S -serial stdio \
		-kernel main.bin \
		-monitor null >/dev/null &

check: unit_test.c unit_test.h
	$(MAKE) main.bin DEBUG_FLAGS=-DDEBUG
	$(QEMU_STM32) $(UT_FLAGS)
	@echo
	$(CROSS_COMPILE)gdb -batch -x test-strlen.in
	@mv -f  gdb.txt $(CHECK_RESULTS)test-strlen.txt
	@echo
	$(CROSS_COMPILE)gdb -batch -x test-strcpy.in
	@mv -f gdb.txt $(CHECK_RESULTS)test-strcpy.txt
	@echo
	$(CROSS_COMPILE)gdb -batch -x test-strcmp.in
	@mv -f gdb.txt $(CHECK_RESULTS)test-strcmp.txt
	@echo
	$(CROSS_COMPILE)gdb -batch -x test-strncmp.in
	@mv -f gdb.txt $(CHECK_RESULTS)test-strncmp.txt
	@echo
	$(CROSS_COMPILE)gdb -batch -x test-cmdtok.in
	@mv -f gdb.txt $(CHECK_RESULTS)test-cmdtok.txt
	@echo
	$(CROSS_COMPILE)gdb -batch -x test-itoa.in
	@mv -f gdb.txt $(CHECK_RESULTS)test-itoa.txt
	@echo
	$(CROSS_COMPILE)gdb -batch -x test-find_events.in
	@mv -f gdb.txt $(CHECK_RESULTS)test-find_events.txt
	@echo
	$(CROSS_COMPILE)gdb -batch -x test-find_envvar.in
	@mv -f gdb.txt $(CHECK_RESULTS)test-find_envvar.txt
	@echo
	$(CROSS_COMPILE)gdb -batch -x test-fill_arg.in
	@mv -f gdb.txt $(CHECK_RESULTS)test-fill_arg.txt
	@echo
	$(CROSS_COMPILE)gdb -batch -x test-export_envvar.in
	@mv -f gdb.txt $(CHECK_RESULTS)test-export_envvar.txt
	@echo
	$(CROSS_COMPILE)gdb -batch -x test-cmd-hello.in
	@mv -f gdb.txt $(CHECK_RESULTS)test-cmd-hello.txt
	@pkill -9 $(notdir $(QEMU_STM32))
