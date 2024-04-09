# Ext Cardano UTXO RPC

The approach of this project is to create a UTXO RPC service on the K8S cluster
and an operator to enable the required resources to expose an UTXO RPC
port.

## Folder structure

* bootstrap: contains terraform resources
* operator: rust application integrated with the cluster
* proxy: rust application that proxies the service
* scripts: useful scripts
