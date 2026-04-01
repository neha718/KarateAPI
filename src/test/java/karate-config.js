function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  
  if (!env) {
    env = 'dev';
  }
  
  var config = {
    env: env,
    baseUrl: 'http://localhost:9897',
    logLevel: 'info'
  };
  
  // Environment-specific configurations
  if (env == 'dev') {
    config.baseUrl = 'http://localhost:9897';
  } else if (env == 'stage') {
    config.baseUrl = 'http://stage-server:9897';
  } else if (env == 'prod') {
    config.baseUrl = 'http://prod-server:9897';
  }
  
  return config;
}