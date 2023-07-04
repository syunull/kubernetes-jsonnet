{
  image: 'msappimage',
  labels: {
    'app.kubernetes.io/name': 'msapp',
  },
  name: 'msapp',
  port: {
    name: 'http',
    port: '8080',
  },
  service_account: {
    annotations: {
      'example.io/key': 'value',
    },
  },
  version: '1.1.1',

  env: {
    DD_SERVICE: 'msapp',
  },
}
