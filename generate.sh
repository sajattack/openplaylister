seed=`od -A n -l -N 4 /dev/urandom | tr -d ' '`
fairseq-interactive --path checkpoints/brainz/checkpoint_last.pt data-bin/brainz --task language_modeling --skip-invalid-size-inputs-valid-test --seed $seed --prefix-size 10 --sampling --nbest 1 --beam 1 --min-len 100
