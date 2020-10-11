#az login
az group create \
    --location CentralIndia \
    --name Girish-India

az network vnet create \
    --name Hub-India \
    --resource-group Girish-India \
    --location CentralIndia \
    --address-prefixes 30.10.0.0/16 \
    --subnet-prefixes 30.10.2.0/24 \
    --subnet-name AzureFirewallSubnet 
    

az network vnet subnet create \
    --address-prefixes "30.10.3.0/24" \
    --name Production \
    --resource-group Girish-India \
    --vnet-name Hub-India

az network vnet subnet create \
    --address-prefixes "30.10.2.0/24" \
    --name GatewaySubnet \
    --resource-group Girish-India \
    --vnet-name Hub-India


