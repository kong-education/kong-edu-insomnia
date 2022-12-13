#!/bin/bash

inso lint spec spc_23d31c

inso run test uts_145cb5 --env localdev

inso generate config spc_23d31c -o bankong/apiops/deck-inso-2.x.yaml

# We need to translate our deck configuration file for Kong 3.x 
deck convert --from kong-gateway-2.x  --to kong-gateway-3.x --input-file bankong/apiops/deck-inso-2.x.yaml --output-file bankong/apiops/deck-inso-3.x.yaml

deck validate -s bankong/apiops/deck-inso-3.x.yaml

deck sync -s bankong/apiops/deck-inso-3.x.yaml --workspace workspace01 --select-tag inso-generated

