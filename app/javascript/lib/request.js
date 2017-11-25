import superagent from 'superagent';
import { camelizeKeys } from 'humps';
import es6Promise from 'es6-promise';
import superagentPromise from 'superagent-promise';
import prefix from 'superagent-prefix';
import ReactOnRails from 'react-on-rails';

const promise = Promise || es6Promise.Promise;
const agent = superagentPromise(superagent, promise);
const handleErrors = ({ response, status }) => {
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
/* eslint-disable no-param-reassign */
const setCsrfToken = token => (request) => {
  if (!token) {
    token = ReactOnRails.authenticityToken();
  }

  request.set('X-CSRF-Token', token);

  return request;
};

class Request {
  constructor(options = { host: '/' }) {
    this.options = options;
  }

  fetch(url, query) {
    return this.method('get', url)
      .type('json')
      .query(query)
      .catch(handleErrors);
  }

  create(url, data, isFile) {
    const request = this.method('post', url);

    if (isFile) {
      return request.attach('file', data).catch(handleErrors);
    }

    return request.send(data).catch(handleErrors);
  }

  update(url, data) {
    return this.method('patch', url)
      .send(data)
      .catch(handleErrors);
  }

  delete(url) {
    return this.method('del', url).catch(handleErrors);
  }

  method(method, url) {
    return agent[method](url)
      .buffer(false)
      .parse((data) => {
        const serializedBody = camelizeKeys(JSON.parse(data.text));
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
