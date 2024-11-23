# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

rt=$(bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517)
keys=$(bitcoin-cli decoderawtransaction $rt | jq -r '.vin[] | .txinwitness[1]?' | jq -R -s -c 'split("\n")[:-1]')
bitcoin-cli createmultisig 1 "$keys" | jq -r '.address'
