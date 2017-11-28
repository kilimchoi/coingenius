import request from '_lib/request';

export const buildConversion = params => request.fetch('/conversions/new', params);
export const createConversion = conversion => request.create('/conversions', { conversion });
export const fetchConversion = id => request.fetch(`/conversions/${id}`);
