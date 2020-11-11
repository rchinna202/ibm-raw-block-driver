### IBM block storage CSI driver

### step1:- Pre-requisites

Follow the documentation : https://www.ibm.com/support/knowledgecenter/SSRQ8T_1.2.0/csi_block_storage_kc_welcome.html and complete the below steps manually.

Download the following files from GitHub location, on to ```/root```on the Bastion node.

a. Need to modify secret.yaml file

Replace Array_USERNAME and Array_PASSWORD parameters of secret file with your PowerVC username and password encrypted in base 64 format. Use the following command to get base64 encrypted format. and also Update the  ```management_address``` :- provide the powervc storage ip address

```
$ base64 <<< <enter-your-powervc-username>
$ base64 <<< <enter-your-powervc-password>
```

b.  Need to modify block-csi-storage.yaml 

```
csi.storage.k8s.io/provisioner-secret-name: <ARRAY_SECRET>
csi.storage.k8s.io/provisioner-secret-namespace: <ARRAY_SECRET_NAMESPACE>
csi.storage.k8s.io/controller-publish-secret-name: <ARRAY_SECRET>
csi.storage.k8s.io/controller-publish-secret-namespace: <ARRAY_SECRET_NAMESPACE>
```
### step2:- The actual execution of the script.

a. Give the csi-driver.sh file permission.
```
chmod 777 csi.sh
```
b. Execute the script.
```
./csi-driver.sh
```

### step2:-verification steps

After installing IBM block storage CSI driver, you need to verify if the installation is successful or not.

Check the list of pods

```
oc get pods
```


