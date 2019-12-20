#!/usr/bin/env python3
import redis, os, sys, json

r = redis.StrictRedis(host=os.environ['REDIS_HOST'], port=os.environ.get('REDIS_PORT', 6379), db=0)
r.set('x','123')
print(r.get('x'))
