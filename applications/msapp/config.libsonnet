local kube = import '../../vendor/github.com/jsonnet-libs/k8s-libsonnet/1.24/main.libsonnet';

local envVar = kube.core.v1.envVar;

{
  env: [
    envVar.new('DD_SERVICE', 'msapp'),
  ],
  image: 'msappimage',
  labels: {
    'app.kubernetes.io/name': 'msapp',
  },
  name: 'msapp',
  port: {
    name: 'http',
    port: 8080,
  },
  service_account: {
    annotations: {
      'example.io/key': 'value',
    },
  },
  version: '1.1.1',
}
