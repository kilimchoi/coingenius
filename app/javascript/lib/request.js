import superagent from 'superagent';
import deepMapKeys from 'deep-map-keys';
import camelCase from 'lodash/camelCase';
import es6Promise from 'es6-promise';
import superagentPromise from 'superagent-promise';
import prefix from 'superagent-prefix';

const promise = Promise || es6Promise.Promise;
const agent = superagentPromise(superagent, promise);

const errorsPrepare = ({ response, status }) => {
  if (status === 422) {
    const error = { errors: response.error.details, status };
    throw error;
  }

  const error = { errors: response.error.message, status };
  throw error;
};

const useHost = host => (request) => {
  if (host) {
    request.use(prefix(host));
  }

  return request;
};

const toCamelCase = key => camelCase(key);

/* eslint-disable no-param-reassign */
const setCsrfToken = token => (request) => {
  if (!token) {
    token = document && document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  }

  request.set('X-CSRF-Token', token);
  return request;
};

class Request {
  constructor(options = { host: '/' }) {
    this.options = options;
  }

  fetch(url, query) {
    return this.method('get', url).type('json').query(query).catch(errorsPrepare);
  }

  create(url, data, isFile) {
    const request = this.method('post', url);

    if (isFile) {
      return request.attach('file', data).catch(errorsPrepare);
    }

    return request.send({ data }).catch(errorsPrepare);
  }

  update(url, data) {
    return this.method('patch', url).send({ data }).catch(errorsPrepare);
  }

  delete(url) {
    return this.method('del', url).catch(errorsPrepare);
  }

  method(method, url) {
    return agent[method](url)
      .buffer(false)
      .parse((data) => {
        const serializedBody = deepMapKeys(JSON.parse(data.text), toCamelCase);
        data.serializedBody = serializedBody;
        return data;
      })
      .withCredentials()
      .accept('json')
      .use(useHost(this.options.host))
      .use(setCsrfToken());
  }
}

const defaultOptions = {
  host: document.location.origin,
};

export default new Request(defaultOptions);
