#!/bin/bash


cd /root

#To check version
oc version



#Installing the operator and driver
curl -L https://github.com/IBM/ibm-block-csi-operator/releases/download/v1.2.0/ibm-block-csi-operator-non-x86.yaml > ibm-block-csi-operator.yaml



#Create a namespace for csi
oc create namespace csi


#Verify the operator running.
oc create -f ibm-block-csi-operator.yaml -n csi



#Install the operator, while using a user-defined namespace.
oc apply -f ibm-block-csi-operator.yaml
if [ $? -eq 0 ]; then
        echo "ibm-block-csi-operator.yaml file installed successfully"
else
        echo "ibm-block-csi-operator.yaml file doesn't installed"
exit 1;
fi



#Install the IBM block storage CSI driver by creating an IBMBlockCSI custom resource.
curl -L https://github.com/IBM/ibm-block-csi-operator/releases/download/v1.2.0/csi.ibm.com_v1.2_ibmblockcsi_cr_ocp.yaml > csi.ibm.com_v1_ibmblockcsi_cr.yaml



#Install the csi.ibm.com_v1_ibmblockcsi_cr.yaml.
oc apply -f csi.ibm.com_v1_ibmblockcsi_cr.yaml
if [ $? -eq 0 ]; then
        echo "csi.ibm.com_v1_ibmblockcsi_cr.yaml file installed successfully"
else
        echo "csi.ibm.com_v1_ibmblockcsi_cr.yaml file doesn't installed"
exit 1;
fi



#To check list of pods
oc get pods



#CSI Driver config
# To create the secret file.
oc create -f array-secret.yaml
if [ $? -eq 0 ]; then
	echo "secret file created succcessfully"
else
	echo "secret file doesn't created"
exit 1;
fi



#Apply the storage class
oc apply -f block-csi-storage.yaml
if [ $? -eq 0 ]; then
        echo "block-csi-storage.yaml file installed"
else
        echo "block-csi-storage.yaml file doesn't installed"
exit 1;
fi




#Creating PVC for volume with file system
oc apply -f demo-pvc-file-system.yaml
if [ $? -eq 0 ]; then
        echo "PVC for Volume successfully created"
else
        echo "PVC for Volume doesn't created"
exit 1;
fi



#To check PVC status
oc get pvc



#Creating PVC for raw block volume
oc apply -f demo-pvc-raw-block.yaml
if [ $? -eq 0 ]; then
        echo "PVC for raw block volume successfully created"
else
        echo "PVC for raw block volume doesn't created"
exit 1;
fi



oc get pvc | grep raw
