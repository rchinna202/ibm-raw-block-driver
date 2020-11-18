#!/bin/bash

cd /root/ibm-raw-block-driver

#To check version
oc version

#Installing the operator and driver
curl -L https://github.com/IBM/ibm-block-csi-operator/releases/download/v1.2.0/ibm-block-csi-operator-non-x86.yaml > ibm-block-csi-operator.yaml


#Install the operator, while using a user-defined namespace.
oc apply -f ibm-block-csi-operator.yaml -n default
if [ $? -eq 0 ]; then
        echo "ibm-block-csi-operator.yaml file installed successfully"
else
        echo "ibm-block-csi-operator.yaml file installation failed"
fi


#Install the IBM block storage CSI driver by creating an IBMBlockCSI custom resource.
curl -L https://github.com/IBM/ibm-block-csi-operator/releases/download/v1.2.0/csi.ibm.com_v1.2_ibmblockcsi_cr_ocp.yaml > csi.ibm.com_v1_ibmblockcsi_cr.yaml


#Install the csi.ibm.com_v1_ibmblockcsi_cr.yaml.
oc apply -f csi.ibm.com_v1_ibmblockcsi_cr.yaml -n default
if [ $? -eq 0 ]; then
        echo "csi.ibm.com_v1_ibmblockcsi_cr.yaml file installed successfully"
else
        echo "csi.ibm.com_v1_ibmblockcsi_cr.yaml file installation failed"
fi
#To check list of pods
oc get pods


#To Check the secret status
oc get secret array-secret -n default
if [ $? -eq 0 ]; then
	echo "array-secret file alredy created"
fi
#CSI Driver config
#To create the secret file.
oc create -f array-secret.yaml
if [ $? -eq 0 ]; then
        echo "secret file created"
else
	echo "secret file does not created"
fi


#Apply the storage class
oc apply -f block-csi-storage.yaml
if [ $? -eq 0 ]; then
        echo "block-csi-storage.yaml file installed"
else
        echo "block-csi-storage.yaml file doesn't installed"
fi
#To check the block storage
oc get sc


#To check demo-pvc-file-system volume status
oc get pvc demo-pvc-file-system -n default
if [ $? -eq 0 ]; then
        echo "demo-pvc-file-system file already created"
fi
#Creating PVC for volume with file system
oc apply -f demo-pvc-file-system.yaml
if [ $? -eq 0 ]; then
        echo "demo-pvc-file-system volume successfully created"
else
        echo "demo-pvc-file-system Volume does not created"
fi


#To check demo-pvc-raw-block volume status
oc get pvc demo-pvc-raw-block -n default
if [ $? -eq 0 ]; then  
     	echo "demo-pvc-raw-block file already created"
fi
#Creating PVC for raw block volume
oc apply -f demo-pvc-raw-block.yaml
if [ $? -eq 0 ]; then
        echo "demo-pvc-raw-block volume successfully created"
else
        echo "demo-pvc-raw-block volume does not created"
fi
