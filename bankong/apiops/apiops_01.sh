#!/bin/bash

# Validate OpenAPI Spec
inso lint spec spc_23d31c

# Unit test an OpenAPI Spec
inso run test uts_145cb5 --env localdev

# Generate deck configuration file
inso generate config spc_23d31c -o bankong/apiops/deck-inso.yaml

# We need to translate our deck configuration file for Kong 3.x 
deck convert --from kong-gateway-2.x  --to kong-gateway-3.x --input-file bankong/apiops/deck-inso-2.x.yaml --output-file bankong/apiops/deck-inso-3.x.yaml

# Validate deck configuration file
deck validate -s bankong/apiops/deck-inso-3.x.yaml

# Push declarative configuration to Kong Gateway workspace 
deck sync -s deck-config-inso.yaml --workspace workspace01 --select-tag inso-generated
