import request from '_lib/request';

export const createConvertion = params => request.fetch('/conversions/new', params);
