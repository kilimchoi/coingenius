import request from '_lib/request';

export const getCoins = () => request.fetch('/coins');
