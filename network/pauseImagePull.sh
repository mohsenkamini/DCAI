#!/bin/bash
nerdctl -n k8s.io image pull registry.mohsenkamini.ir:5000/pause:3.6
nerdctl -n k8s.io image tag registry.mohsenkamini.ir:5000/pause:3.6 registry.k8s.io/pause:3.6
