MAPNIK_API = $(shell mapnik-config -v)

TEMPFILE := $(shell mktemp -u)

XMLSTYLE := osm-de.xml

$(XMLSTYLE): *.mss project.mml
	carto -a $(MAPNIK_API) project.mml > $(TEMPFILE)
	mv $(TEMPFILE) $@

project-hrb.mml: project.mml
	sed -e 's/localized_[^ ]\+/name_hrb/g' project.mml >project-hrb.mml

osm-hrb.xml: *.mss project-hrb.mml
	carto -a $(MAPNIK_API) project-hrb.mml > $(TEMPFILE)
	mv $(TEMPFILE) $@

preview-de.png: $(XMLSTYLE)
	nik2img.py $(XMLSTYLE) -d 850 300 -z 15 -c 11.625 48.106  -fPNG --no-open $@

# This target will render one single tile in every zoomlevel
# to ensure successful merges from upstream
test: test-z03.png test-z04.png test-z05.png test-z06.png test-z07.png test-z08.png test-z09.png \
	test-z10.png test-z11.png test-z12.png test-z13.png test-z14.png test-z15.png test-z16.png \
	test-z17.png test-z18.png test-z19.png test-castle1.png test-castle2.png \
	test-camp-caravan.png test-campsite.png test-backcountry.png

test-z03.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /3/3/2.png

test-z04.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /4/7/4.png

test-z05.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /5/15/10.png
	
test-z06.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /6/33/20.png

test-z07.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /7/66/43.png

test-z08.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /8/133/87.png

test-z09.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /9/267/175.png

test-z10.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /10/535/351.png

test-z11.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /11/1071/703.png

test-z12.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /12/2143/1406.png

test-z13.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /13/4287/2812.png
	
test-z14.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /14/8576/5626.png

test-z15.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /15/17153/11252.png

test-z16.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /16/34306/22505.png

test-z17.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /17/68612/45011.png
	
test-z18.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /18/137225/90022.png
	
test-z19.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /19/274450/180045.png

# incomplete tests for German style only features
# castle
test-castle1.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /18/137259/90022.png
# castle (ruined)
test-castle2.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /17/68625/45014.png
# camping/caravaning
test-camp-caravan.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /17/68658/44952.png
# camping tents only
test-campsite.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /18/137346/89837.png
# camping backcountry
test-backcountry.png: $(XMLSTYLE)
	./scripts/render_single_tile.py -s $(XMLSTYLE) -o $@ -u /19/274268/181238.png



clean:
	rm -f project-de.* $(XMLSTYLE) test-*.png
