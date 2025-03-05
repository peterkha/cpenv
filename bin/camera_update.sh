#!/bin/bash

source ~/.bashrc

ssh-add ~/.ssh/gamma_unconfigured.identity
scp /media/psf/Home//Desktop/mp_data/B383/camera_parameters.pb.b383_psi $MPCH/eos/camera_parameters.pb
scp /media/psf/Home//Desktop/mp_data/B383/SSH_key.identity.pub $MPCH/.ssh/authorized_keys
scp $FLAGF $MPCH/conf/



