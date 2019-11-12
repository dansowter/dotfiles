#!/usr/bin/env bash

set -euo pipefail

eval $(op signin stacktrace)

PASSWORD=$(op get item ssh-keyphrase | jq -r .details.password)

echo $PASSWORD