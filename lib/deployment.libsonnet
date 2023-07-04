local kube = import '../vendor/github.com/jsonnet-libs/k8s-libsonnet/1.24/main.libsonnet';
local deployment = kube.apps.v1.deployment;

local tsc = kube.core.v1.topologySpreadConstraint;

{
  mkTopologySpreadConstraints:: function(when, labels) {
    topology_spread_constraints: tsc.withMaxSkew(1)
                                 + tsc.withWhenUnsatisfiable(when)
                                 + tsc.withTopologyKey('topology.kubernetes.io/zone')
                                 + tsc.labelSelector.withMatchLabels(labels),
  }.topology_spread_constraints,

  mkDefaults:: function(labels) {
    defaults: deployment.spec.withRevisionHistoryLimit(3)
              + deployment.spec.template.spec.withTopologySpreadConstraints($.mkTopologySpreadConstraints('ScheduleAnyway', labels)),
  }.defaults,
}
