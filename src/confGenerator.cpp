/**
 * @file  confGenerator.cpp
 *
 * @brief Initial configuration generator.
 */

#include "defs.h"
#include "Managers/GeneratorManager.h"
#include "Utilities/SignalManager.h"

/**
 * confGenerator is a tool to generate initial configurations for oxDNA
 *
 * See high-level documentation on web: http://dna.physics.ox.ac.uk
 */

void print_version() {
	fprintf(stdout, "Configuration generator for oxDNA %d.%d.%d by Lorenzo Rovigatti, Flavio Romano, Petr Sulc and Benedict Snodin (c) 2013\n", VERSION_MAJOR, VERSION_MINOR, VERSION_STAGE);
	exit(-1);
}

int main(int argc, char *argv[]) {
	try {
		Logger::init();
		SignalManager::manage_segfault();
		if(argc < 3) throw oxDNAException("Usage is '%s input_file [box_size|density]'\nthe third argument will be interpreted as a density if it is less than 2.0", argv[0]);
		else if(argc > 1 && !strcmp(argv[1], "-v")) print_version();

		GeneratorManager mygenerator(argc, argv);
		OX_DEBUG("Loading options");
		mygenerator.load_options();

		OX_DEBUG("Initializing");
		mygenerator.init();

		OX_LOG(Logger::LOG_INFO, "SVN CODE VERSION: %s", SVN_VERSION);
		OX_LOG(Logger::LOG_INFO, "COMPILED ON: %s", BUILD_TIME);

		OX_DEBUG("Running");
		OX_LOG(Logger::LOG_INFO, "Starting generation");
		mygenerator.generate();

		OX_LOG(Logger::LOG_INFO, "END OF THE GENERATION, everything went OK!");
	}
	catch (oxDNAException &e) {
		OX_LOG(Logger::LOG_ERROR, "%s", e.error());
		exit(1);
	}

	Logger::clear();

	return 0;
}
