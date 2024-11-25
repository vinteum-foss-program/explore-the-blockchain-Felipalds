# Only one single output remains unspent from block 123,321. What address was it sent to?


txs=$(bitcoin-cli getblock $(bitcoin-cli getblockhash 123321) | jq -r '.tx[]')
for tx in $txs; do
    output=$(bitcoin-cli gettxout $tx 0)
    if [ -z "$output" ]; then
        continue
    else
        echo $output | jq -r '.scriptPubKey.address'
    fi
    # echo $outputs | jq -r
    # spent=$(echo $output | jq '.spentTxId')
    # if [ "$spent" = "null" ]; then
    #     txout=$(echo $output | jq -r '.scriptPubKey.addresses[0]')
    #     echo $txout
    #     exit 1
    # fi
done
