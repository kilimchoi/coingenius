json.id conversion.id

json.deposit_amount conversion.raw_data["depositAmount"]
json.rate_expiration conversion.raw_data["expiration"]
json.withdrawal_amount conversion.raw_data["withdrawalAmount"]

json.partial! "conversion", conversion: conversion
