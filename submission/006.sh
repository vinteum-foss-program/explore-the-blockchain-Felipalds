# Which tx in block 257,343 spends the coinbase output of block 256,128?

tx=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 256128) | jq -r '.tx[0]')
tx_objective=$(bitcoin-cli decoderawtransaction $(bitcoin-cli getrawtransaction $tx) | jq -r '.txid')
txs=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 257343) | jq -r '.tx[]')

for tx in $txs; do
    txd=$(bitcoin-cli decoderawtransaction $(bitcoin-cli getrawtransaction $tx))
    inputs=$(echo $txd | jq -r '.vin[].txid')
    for input in $inputs; do
        if [ "$input" == "$tx_objective" ]; then
            echo $tx
            exit 0;
        fi
    done
done
