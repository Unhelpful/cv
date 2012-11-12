all: cv.pdf cv.html cv.txt

clean:
	rm -fr cv.aux cv.haux cv.htoc cv.log cv.out cv.pdf cv.txt cv.tmp.haux cv.tmp.htoc cv.tmp.txt cv.html upload

cv.pdf: cv.tex moderncvstylebankingmod.sty
	xelatex $<

cv.html: cv.tex moderncv.hva
	hevea -O -fix $<

cv.txt: cv.tex plaintext.hva moderncv.hva
	hevea -O -fix -text -w 9999 -o cv.tmp.txt plaintext.hva $<
	perl -0777 -p -e 's-(\s*\n)+\s*\n-\n\n-gms' cv.tmp.txt >$@

upload: cv.pdf cv.html cv.txt
	scp $? $(UPLOAD_TARGET)
	touch upload
