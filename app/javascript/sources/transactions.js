import request from '_lib/request';

export const getCoinNames = term =>
  request.fetch('/portfolio/transactions/autocomplete_coin_name', { term });
