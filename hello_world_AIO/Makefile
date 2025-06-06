#---------------USER CONFIG---------------
TOP_FILE    = hello_uvm_work.sv
TEST_NAME   = hello_test
SIMV        = simv
#------------------------------------------

#--------------DEFAULT TARGET--------------
all: help

#---------------VCS SECTION-----------------
vcs:
  vcs -full64 -sverilog -ntb_opts uvm-1.2 $(TOP_FILE) -o $(SIMV)

run_vcs: vcs
  ./$(SIM) +UVM_TESTNAME=$(TEST_NAME)

#-------------QUESTA SECTION----------------
questa:
  vlog -sv +acc=rn $(TOP_FILE)

run_questa: questa
  vsim -c top +UVM_TESTNAME=$(TEST_NAME) -do "run -all;quit"

#------------CLEAN SECTION-------------------
clean:
  rm -rf csrc simv* *.log *.vpd *.key transcript work *.bak

#--------------HELP SECTION-------------------
help:
  @echo "Usage: make <target>"
  @echo ""
  @echo "Targets:"
  @echo "vcs        -Compile with Synopsys VCS"
  @echo "run_vcs    -Compile and run with VCS"
  @echo "questa     -Compile with Mentor Questa"
  @echo "run_questa -Compile and run using QuestaSim"
  @echo "clean      -Remove generated files"
  @echo "help       -Show this help message"
