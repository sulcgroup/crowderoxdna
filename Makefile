# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Default target executed when no arguments are given to make.
default_target: all

.PHONY : default_target

# Allow only one "make -f Makefile2" at a time, but pass parallelism.
.NOTPARALLEL:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/petr/workspace/oxdna-code/oxDNA

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/petr/workspace/oxdna-code/oxDNA

#=============================================================================
# Targets provided globally by CMake.

# Special rule for the target edit_cache
edit_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "No interactive CMake dialog available..."
	/usr/bin/cmake -E echo No\ interactive\ CMake\ dialog\ available.
.PHONY : edit_cache

# Special rule for the target edit_cache
edit_cache/fast: edit_cache

.PHONY : edit_cache/fast

# Special rule for the target rebuild_cache
rebuild_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake to regenerate build system..."
	/usr/bin/cmake -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : rebuild_cache

# Special rule for the target rebuild_cache
rebuild_cache/fast: rebuild_cache

.PHONY : rebuild_cache/fast

# The main all target
all: cmake_check_build_system
	$(CMAKE_COMMAND) -E cmake_progress_start /home/petr/workspace/oxdna-code/oxDNA/CMakeFiles /home/petr/workspace/oxdna-code/oxDNA/CMakeFiles/progress.marks
	$(MAKE) -f CMakeFiles/Makefile2 all
	$(CMAKE_COMMAND) -E cmake_progress_start /home/petr/workspace/oxdna-code/oxDNA/CMakeFiles 0
.PHONY : all

# The main clean target
clean:
	$(MAKE) -f CMakeFiles/Makefile2 clean
.PHONY : clean

# The main clean target
clean/fast: clean

.PHONY : clean/fast

# Prepare targets for installation.
preinstall: all
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall

# Prepare targets for installation.
preinstall/fast:
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall/fast

# clear depends
depend:
	$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 1
.PHONY : depend

#=============================================================================
# Target rules for targets named test_run

# Build rule for target.
test_run: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 test_run
.PHONY : test_run

# fast build rule for target.
test_run/fast:
	$(MAKE) -f CMakeFiles/test_run.dir/build.make CMakeFiles/test_run.dir/build
.PHONY : test_run/fast

#=============================================================================
# Target rules for targets named test_quick

# Build rule for target.
test_quick: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 test_quick
.PHONY : test_quick

# fast build rule for target.
test_quick/fast:
	$(MAKE) -f CMakeFiles/test_quick.dir/build.make CMakeFiles/test_quick.dir/build
.PHONY : test_quick/fast

#=============================================================================
# Target rules for targets named docs

# Build rule for target.
docs: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 docs
.PHONY : docs

# fast build rule for target.
docs/fast:
	$(MAKE) -f CMakeFiles/docs.dir/build.make CMakeFiles/docs.dir/build
.PHONY : docs/fast

#=============================================================================
# Target rules for targets named test_scientific

# Build rule for target.
test_scientific: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 test_scientific
.PHONY : test_scientific

# fast build rule for target.
test_scientific/fast:
	$(MAKE) -f CMakeFiles/test_scientific.dir/build.make CMakeFiles/test_scientific.dir/build
.PHONY : test_scientific/fast

#=============================================================================
# Target rules for targets named oxDNA

# Build rule for target.
oxDNA: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 oxDNA
.PHONY : oxDNA

# fast build rule for target.
oxDNA/fast:
	$(MAKE) -f src/CMakeFiles/oxDNA.dir/build.make src/CMakeFiles/oxDNA.dir/build
.PHONY : oxDNA/fast

#=============================================================================
# Target rules for targets named confGenerator

# Build rule for target.
confGenerator: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 confGenerator
.PHONY : confGenerator

# fast build rule for target.
confGenerator/fast:
	$(MAKE) -f src/CMakeFiles/confGenerator.dir/build.make src/CMakeFiles/confGenerator.dir/build
.PHONY : confGenerator/fast

#=============================================================================
# Target rules for targets named DNAnalysis

# Build rule for target.
DNAnalysis: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 DNAnalysis
.PHONY : DNAnalysis

# fast build rule for target.
DNAnalysis/fast:
	$(MAKE) -f src/CMakeFiles/DNAnalysis.dir/build.make src/CMakeFiles/DNAnalysis.dir/build
.PHONY : DNAnalysis/fast

#=============================================================================
# Target rules for targets named common

# Build rule for target.
common: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 common
.PHONY : common

# fast build rule for target.
common/fast:
	$(MAKE) -f src/CMakeFiles/common.dir/build.make src/CMakeFiles/common.dir/build
.PHONY : common/fast

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... depend"
	@echo "... edit_cache"
	@echo "... rebuild_cache"
	@echo "... test_run"
	@echo "... test_quick"
	@echo "... docs"
	@echo "... test_scientific"
	@echo "... oxDNA"
	@echo "... confGenerator"
	@echo "... DNAnalysis"
	@echo "... common"
.PHONY : help



#=============================================================================
# Special targets to cleanup operation of make.

# Special rule to run CMake to check the build system integrity.
# No rule that depends on this can have commands that come from listfiles
# because they might be regenerated.
cmake_check_build_system:
	$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 0
.PHONY : cmake_check_build_system

