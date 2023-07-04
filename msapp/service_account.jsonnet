local kube = import '../vendor/github.com/jsonnet-libs/k8s-libsonnet/1.24/main.libsonnet';

local serviceAccount = kube.core.v1.serviceAccount;

local msappAnnotations = {
  'example.io/key': 'value',
};

serviceAccount.new('msapp') + serviceAccount.metadata.withAnnotations(msappAnnotations)
