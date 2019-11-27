#!/bin/sh
docker run -d --name=redis redis
docker run -d --name=db postgres:9.4
docker run -d --name vote -p 5000:80 --link redis:redis dockersamples/examplevotingapp_vote
docker run -d --name result -p 5001:80 --link db:db dockersamples/examplevotingapp_result
docker run -d --name worker --link db:db --link redis:redis dockersamples/examplevotingapp_worker
