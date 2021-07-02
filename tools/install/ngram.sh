set -e
set -x

# need support c++17, so need gcc >= 8
# openfst
ngram=ngram-1.3.13
shared=true

test -e ${ngram}.tar.gz || wget http://www.openfst.org/twiki/pub/GRM/NGramDownload/${ngram}.tar.gz
test -d ${ngram} || tar -xvf ${ngram}.tar.gz && chown -R root:root ${ngram}

if [ $shared == true ];then
    pushd ${ngram} && ./configure --enable-shared && popd
else
    pushd ${ngram} && ./configure --enable-static && popd
fi
pushd ${ngram} && make -j &&  make install && popd
