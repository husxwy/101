##  查看 etcd 版本
# kubectl -n kube-system exec -it etcd-k8s-14-41  -- etcdctl version
## etcdctl version: 3.4.13
## API version: 3.4

## 下载 etcd 复制 etcdctl 到 /usr/bin/
#ETCD_VER=v3.4.13
#DOWNLOAD_URL=https://github.com/etcd-io/etcd/releases/download
#rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
#rm -rf /tmp/etcd-download-test && mkdir -p /tmp/etcd-download-test
#curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
#tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz -C /tmp/etcd-download-test --strip-components=1
#rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
#cp /tmp/etcd-download-test/etcdctl /usr/bin/
# rm -rf /tmp/etcd-download-test

## 查看 ca 等证书信息
# ps -ef |grep etcd
## root     28138 28121  5 1月12 ?       1-06:59:21 kube-apiserver --advertise-address=10.8.14.41 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --insecure-port=0 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=172.17.0.0/16 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key

export ETCDCTL_API=3

## 查看集群状态
etcdctl --endpoints https://10.8.14.41:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key  endpoint status --write-out=table

etcdctl --endpoints https://10.8.14.41:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt --key=/etc/kubernetes/pki/etcd/healthcheck-client.key  get --prefix --keys-only /


export ETCDCTL_API=3
etcdctl --endpoints https://10.8.14.41:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
--key=/etc/kubernetes/pki/etcd/healthcheck-client.key \
snapshot save /data/nfs/k8skf/back/etcd/etcd-snapshot.db