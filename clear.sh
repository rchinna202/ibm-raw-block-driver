#!/bin/bash

cd /root


oc delete project csi
oc delete -f ibm-block-csi-operator.yaml
rm -rf csi.ibm.com_v1_ibmblockcsi_cr.yaml
oc delete -f array-secret.yaml
oc delete -f block-csi-storage.yaml
oc delete -f demo-pvc-file-system.yaml
oc delete -f demo-pvc-raw-block.yaml
