***IBM block storage CSI driver***

https://www.ibm.com/support/knowledgecenter/SSRQ8T_1.2.0/csi_ug_install_operator_github.html

***Create a namespace for csi***

#oc create namespace csi

***Errors are seen if namespace other than default is used to install the operator:***

#oc create -f ibm-block-csi-operator.yaml -n csi


***CSI Driver config:***

***Create the secret file.***

#oc create -f array-secret.yaml***

***Create the storage class*** 

#oc apply -f block-csi-storage.yaml

***Creating PVC for volume.***

#oc apply -f demo-pvc-file-system.yaml

***Creating PVC for raw block volume***

#oc apply -f demo-pvc-raw-block.yaml



