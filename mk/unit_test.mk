CHECK_RESULTS ?= ./check_results/
UT_FLAGS ?= --nographic -M stm32-p103 \
		-gdb tcp::3333 -S -serial stdio \
		-kernel main.bin \
		-monitor null >/dev/null &
define ut
	@echo
	$(CROSS_COMPILE)gdb -batch -x $1
	@mv -f  gdb.txt $(CHECK_RESULTS)$2
endef
check: unit_test.c unit_test.h
	$(MAKE) main.bin DEBUG_FLAGS=-DDEBUG
	$(QEMU_STM32) $(UT_FLAGS)
	$(call ut ,test-strcpy.in,test-strcpy.txt)
	$(call ut ,test-strcmp.in,test-strcmp.txt)
	$(call ut ,test-cmdtok.in,test-cmdtok.txt)
	$(call ut ,test-itoa.in,test-itoa.txt)
	$(call ut ,test-find_events.in,test-find_events.txt)
	$(call ut ,test-find_envvar.in,test-find_envvar.txt)
	$(call ut ,test-fill_arg.in,test-fill_arg.txt)
	$(call ut ,test-export_envvar.in,test-export_envvar.txt)
	$(call ut ,test-cmd-hello.in,test-cmd-hello.txt)
	@pkill -9 $(notdir $(QEMU_STM32))
