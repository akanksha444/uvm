#-----------Variables-----------
TB_FILE1    = top.sv
TB_FILE2    = test.sv
TEST_NAME   = my_test
SIMV        = simv
#-------------------------------

#--------Default Target---------
all: help

#----------VCS Section----------
vcs:
  vcs -full64 -sverilog -ntb_opts uvm-1.2 $(TB_FILE1) $(TB_FILE2) -o $(SIMV)

run_vcs: vcs
  ./$(SIMV) +UVM_TESTNAME=$(TEST_NAME)
#--------------------------------

#---------QUESTA Section-----------
questa:
  vlog -sv +acc=rn $(TB_FILE1) $(TB_FILE2)
run_questa: questa
  vsim -c top +UVM_TESTNAME=$(TEST_NAME) -do "run -all; quit"
#---------------------------------- 

#---------CLEAN Section------------
clean:
  rm -rf csrc simv* *.log *.vpd *.key transcript work *.bak
#----------------------------------

#----------HELP Section-------------
help:
  @echo "Usage: make <target>
  @echo ""
  @echo "Targets:"
  @echo "vcs         -Compile with Synopsys VCS"
  @echo "run_vcs     -Compile and run using VCS"
  @echo "questa      -Compile with Mentor Questa"
  @echo "run_questa  -Compile and run using QuestaSim"
  @echo "clean       -Remove generated files"
  @echo "help        -Show this help message"
  
