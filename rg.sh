loc="CentralIndia"
rg="Girish-India"
vnet="Hub-India"
vnet1="Spoke-India"

az group create \
    --location $loc \
    --name $rg

az network vnet create \
    --name $vnet \
    --resource-group $rg \
    --location $loc \
    --address-prefixes 30.10.0.0/16 \
    --subnet-prefixes 30.10.2.0/24 \
    --subnet-name AzureFirewallSubnet 
    
az network vnet subnet create \
    --address-prefixes "30.10.3.0/24" \
    --name Production \
    --resource-group $rg \
    --vnet-name $vnet

az network vnet subnet create \
    --vnet-name $vnet \
    -n GatewaySubnet \
    -g $rg \
    --address-prefixes 30.10.1.0/24

az network vnet create \
    --name $vnet1 \
    --resource-group $rg \
    --location $loc \
    --address-prefixes 172.16.0.0/16 \
    --subnet-prefixes 172.16.1.0/24 \
    --subnet-name Val

az network vnet peering create \
    --vnet-name Hub-India \
    --name hubtospoke \
    --remote-vnet Spoke-India \
    --allow-vnet-access \
    --allow-forwarded-traffic \
    --allow-gateway-transit \
    --resource-group Girish-India

az network vnet peering create \
    --vnet-name Spoke-India \
    --name spoketohub \
    --remote-vnet Hub-India \
    --allow-vnet-access \
    --allow-forwarded-traffic \
    --allow-gateway-transit \
    --resource-group Girish-India

az vm create \
	--resource-group Girish-India \
	--name hub-VM \
	--image win2012datacenter \
	--vnet-name Hub-India \
	--subnet Production \
	--admin-username azuser \
	--admin-password Covid@192021

az vm create \
	--resource-group Girish-India \
	--name spoke-VM \
	--image win2012datacenter \
	--vnet-name Spoke-India \
	--subnet val \
	--admin-username azuser \
	--admin-password Covid@192021

az network public-ip create \
    --name MyFWPIP \
    --resource-group Girish-India \
    --allocation-method static \
    --sku standard

az network firewall create \
    --name MyFireWall \
    --resource-group Girish-India

az network firewall ip-config create \
    --firewall-name MyFireWall \
    --name MyFWIPConfig \
    --public-ip-address MyFWPIP \
    --resource-group Girish-India \
    --vnet-name Hub-India 
    
 az vm stop \
	--resource-group rg1 \
	--name vm1
