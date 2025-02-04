#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data
configs=$base/configs

translations=$base/translations

mkdir -p $translations

src=de
trg=en

# cloned from https://github.com/bricksdont/moses-scripts
MOSES=$base/tools/moses-scripts/scripts

num_threads=4
device=0

# measure time

SECONDS=0

model_name=deen_transformer_layerdrop # deen_transformer_regular

echo "###############################################################################"
echo "model_name $model_name"

translations_sub=$translations/$model_name

mkdir -p $translations_sub

CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt translate $configs/$model_name.yaml < $data/test.bpe.$src > $translations_sub/test.bpe.$model_name.$trg

# undo BPE (this does not do anything: https://github.com/joeynmt/joeynmt/issues/91)

cat $translations_sub/test.bpe.$model_name.$trg | sed 's/\@\@ //g' > $translations_sub/test.truecased.$model_name.$trg

# undo truecasing

cat $translations_sub/test.truecased.$model_name.$trg | $MOSES/recaser/detruecase.perl > $translations_sub/test.tokenized.$model_name.$trg

# undo tokenization

cat $translations_sub/test.tokenized.$model_name.$trg | $MOSES/tokenizer/detokenizer.perl -l $trg > $translations_sub/test.$model_name.$trg

# compute case-sensitive BLEU on detokenized data

cat $translations_sub/test.$model_name.$trg | sacrebleu $data/test.$trg


echo "time taken:"
echo "$SECONDS seconds"
