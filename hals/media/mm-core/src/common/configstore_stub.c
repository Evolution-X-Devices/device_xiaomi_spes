/*
 * Stub implementation for missing ConfigStore symbols.
 * This prevents undefined symbol errors for OMX HAL.
 */

#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <stdio.h>

#define CONFIGSTORE_LOG(...) \
    fprintf(stderr, "[configstore_stub] " __VA_ARGS__)

/**
 * Returns whether ConfigStore is available.
 * Always false on builds without libcapabilityconfigstore.so.
 */
bool isConfigStoreEnabled(void) {
    CONFIGSTORE_LOG("isConfigStoreEnabled() -> false\n");
    return false;
}

/**
 * Retrieves a boolean configuration value.
 * Always returns the provided default value (defVal).
 */
uint32_t getConfigStoreBool(const char *area, const char *config, bool *value, bool defVal) {
    CONFIGSTORE_LOG("getConfigStoreBool(%s, %s) -> %d (default)\n",
                    area ? area : "NULL", config ? config : "NULL", defVal);
    if (value)
        *value = defVal;
    return 0;  // 0 == success
}
