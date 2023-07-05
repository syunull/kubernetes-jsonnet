local kube = import '../../../../vendor/github.com/jsonnet-libs/k8s-libsonnet/1.24/main.libsonnet';
local container = kube.core.v1.container;
local envVar = kube.core.v1.envVar;

local msappContainer = import '../../container.libsonnet';
local msappDeployment = import '../../deployment.libsonnet';

local prodContainer = msappContainer.defaults
                      + container.withEnvMixin([envVar.new('DD_ENV', 'prod'), envVar.new('USE_DAPHNE', 'true')]);

msappDeployment.mkDeployment(prodContainer)
