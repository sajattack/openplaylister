fairseq-train --task language_modeling data-bin/brainz/  --save-dir checkpoints/brainz   --arch transformer_lm --share-decoder-input-output-embed   --dropout 0.1   --optimizer adam --adam-betas '(0.9, 0.98)' --weight-decay 0.01 --clip-norm 0.0   --lr 0.0005 --lr-scheduler inverse_sqrt --warmup-updates 4000 --warmup-init-lr 1e-07   --tokens-per-sample 2500 --sample-break-mode none   --max-tokens 2048 --update-freq 16   --fp16   --max-update 50000 --save-interval 1000 --keep-last-epochs 10 --combine-valid-subsets
