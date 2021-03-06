PROJECT_SHORTNAME=RogueCraftSquadron

LOVE=love
LOVE_VERSION=0.10.2
SRC_DIR=src
GIT_HASH=$(shell git log --pretty=format:'%h' -n 1 ${SRC_DIR})
GIT_COUNT=$(shell git log --pretty=format:'' ${SRC_DIR} | wc -l)
GIT_TARGET=${SRC_DIR}/git.lua
WORKING_DIRECTORY=$(shell pwd)

LOVE_TARGET=${PROJECT_SHORTNAME}.love
LOVE_TARGET_DEMO=${PROJECT_SHORTNAME}_demo.love

DEPS_DATA=dev/build_data
DEPS_DOWNLOAD_TARGET=https://bitbucket.org/rude/love/downloads/
DEPS_DOWNLOAD_LINUX_TARGET=http://50.116.63.25/public/love/
DEPS_WIN32_TARGET=love-${LOVE_VERSION}\-win64.zip
DEPS_WIN64_TARGET=love-${LOVE_VERSION}\-win32.zip
DEPS_MACOS_TARGET=love-${LOVE_VERSION}\-macosx-x64.zip
DEPS_LINUX_TARGET=love-${LOVE_VERSION}\-amd64.tar.gz

BUILD_INFO=v${GIT_COUNT}-[${GIT_HASH}]
BUILD_BIN_NAME=${PROJECT_SHORTNAME}
BUILD_DIR=builds
STEAM_PREP_DIR=steam_prep

BUILD_LOVE=${PROJECT_SHORTNAME}_${BUILD_INFO}
BUILD_WIN32=${PROJECT_SHORTNAME}_win32_${BUILD_INFO}
BUILD_WIN64=${PROJECT_SHORTNAME}_win64_${BUILD_INFO}
BUILD_MACOS=${PROJECT_SHORTNAME}_macosx_${BUILD_INFO}
BUILD_LINUX=${PROJECT_SHORTNAME}_linux64_${BUILD_INFO}

BUILD_LOVE_DEMO=${PROJECT_SHORTNAME}_${BUILD_INFO}_demo
BUILD_WIN32_DEMO=${PROJECT_SHORTNAME}_win32_${BUILD_INFO}_demo
BUILD_WIN64_DEMO=${PROJECT_SHORTNAME}_win64_${BUILD_INFO}_demo
BUILD_MACOS_DEMO=${PROJECT_SHORTNAME}_macosx_${BUILD_INFO}_demo
BUILD_LINUX_DEMO=${PROJECT_SHORTNAME}_linux64_${BUILD_INFO}_demo

BUTLER=butler
BUTLER_VERSION=${GIT_COUNT}[git:${GIT_HASH}]
BUTLER_ITCHNAME=roguecraft-squadron
BUTLER_ITCHUSERNAME=josefnpat

IMAGE_FILES := $(wildcard src/assets/objects/*.png)

-include Makefile.config

.PHONY: clean
clean:
	#Remove generated `${GIT_TARGET}`
	rm -f ${GIT_TARGET}

.PHONY: cleanlove
cleanlove:
	rm -f ${LOVE_TARGET}
	rm -f ${LOVE_TARGET_DEMO}

.PHONY: love
love: clean
	#Writing ${GIT_TARGET}
	echo "git_hash,git_count = '${GIT_HASH}',${GIT_COUNT}" > ${GIT_TARGET}
	#Make love file
	cd ${SRC_DIR};\
	zip --filesync -x "*.swp" -r ../${LOVE_TARGET} *;\
	cd ..

.PHONY: love_demo
love_demo: clean
	#Writing ${GIT_TARGET}
	echo "git_hash,git_count = '${GIT_HASH}',${GIT_COUNT}" > ${GIT_TARGET}
	#Make love file
	cd ${SRC_DIR};\
	zip --filesync -x "release*" -x "*.swp" -r ../${LOVE_TARGET_DEMO} *;\
	cd ..

.PHONY: run
run: love
	exec ${LOVE} --fused ${LOVE_TARGET} ${loveargs}

.PHONY: run_demo
run_demo: love_demo
	exec ${LOVE} --fused ${LOVE_TARGET_DEMO} ${loveargs}

.PHONY: debug
debug: love
	exec ${LOVE} --fused ${SRC_DIR} --debug

.PHONY: cleandeps
cleandeps:
	rm -rf ${DEPS_DATA}

.PHONY: deps
deps:
	# Download binaries, and unpack
	mkdir -p ${DEPS_DATA}; \
	cd ${DEPS_DATA}; \
	\
	wget -t 2 -c ${DEPS_DOWNLOAD_TARGET}${DEPS_WIN32_TARGET};\
	unzip -o ${DEPS_WIN32_TARGET};\
	\
	wget -t 2 -c ${DEPS_DOWNLOAD_TARGET}${DEPS_WIN64_TARGET};\
	unzip -o ${DEPS_WIN64_TARGET};\
	\
	wget -t 2 -c ${DEPS_DOWNLOAD_TARGET}${DEPS_MACOS_TARGET};\
	unzip -o ${DEPS_MACOS_TARGET};\
	\
	wget -t 2 -c ${DEPS_DOWNLOAD_LINUX_TARGET}${DEPS_LINUX_TARGET};\
	tar xvf ${DEPS_LINUX_TARGET};\
	cd -

.PHONY: build_love
build_love: love
	mkdir -p ${BUILD_DIR}
	cp ${LOVE_TARGET} ${BUILD_DIR}/${BUILD_LOVE}.love

.PHONY: build_love_demo
build_love_demo: love_demo
	mkdir -p ${BUILD_DIR}
	cp ${LOVE_TARGET_DEMO} ${BUILD_DIR}/${BUILD_LOVE_DEMO}.love

.PHONY: build_win32
build_win32: love
	mkdir -p ${BUILD_DIR}
	$(eval TMP := $(shell mktemp -d))
	cat ${DEPS_DATA}/love-${LOVE_VERSION}\-win32/love.exe ${LOVE_TARGET} > ${TMP}/${BUILD_BIN_NAME}.exe
	cp ${DEPS_DATA}/love-${LOVE_VERSION}\-win32/*.dll ${TMP}
	zip -rj ${BUILD_DIR}/${BUILD_WIN32} $(TMP)/*
	rm -rf $(TMP)

.PHONY: build_win32_demo
build_win32_demo: love_demo
	mkdir -p ${BUILD_DIR}
	$(eval TMP := $(shell mktemp -d))
	cat ${DEPS_DATA}/love-${LOVE_VERSION}\-win32/love.exe ${LOVE_TARGET_DEMO} > ${TMP}/${BUILD_BIN_NAME}_demo.exe
	cp ${DEPS_DATA}/love-${LOVE_VERSION}\-win32/*.dll ${TMP}
	zip -rj ${BUILD_DIR}/${BUILD_WIN32_DEMO} $(TMP)/*
	rm -rf $(TMP)

.PHONY: build_win64
build_win64: love
	mkdir -p ${BUILD_DIR}
	$(eval TMP := $(shell mktemp -d))
	cat ${DEPS_DATA}/love-${LOVE_VERSION}\-win64/love.exe ${LOVE_TARGET} > ${TMP}/${BUILD_BIN_NAME}.exe
	cp ${DEPS_DATA}/love-${LOVE_VERSION}\-win64/*.dll ${TMP}
	zip -rj ${BUILD_DIR}/${BUILD_WIN64} $(TMP)/*
	rm -rf $(TMP)

.PHONY: build_win64_demo
build_win64_demo: love_demo
	mkdir -p ${BUILD_DIR}
	$(eval TMP := $(shell mktemp -d))
	cat ${DEPS_DATA}/love-${LOVE_VERSION}\-win64/love.exe ${LOVE_TARGET_DEMO} > ${TMP}/${BUILD_BIN_NAME}_demo.exe
	cp ${DEPS_DATA}/love-${LOVE_VERSION}\-win64/*.dll ${TMP}
	zip -rj ${BUILD_DIR}/${BUILD_WIN64_DEMO} $(TMP)/*
	rm -rf $(TMP)

.PHONY: build_macos
build_macos: love
	mkdir -p ${BUILD_DIR}
	$(eval TMP := $(shell mktemp -d))
	cp ${DEPS_DATA}/love.app/ ${TMP}/${BUILD_BIN_NAME}.app -Rv
	cp ${LOVE_TARGET} ${TMP}/${BUILD_BIN_NAME}.app/Contents/Resources/${BUILD_BIN_NAME}.love
	cd ${TMP}; \
	zip -ry ${WORKING_DIRECTORY}/${BUILD_DIR}/${BUILD_MACOS}.zip ${BUILD_BIN_NAME}.app/
	cd ${WORKING_DIRECTORY}
	rm -rf $(TMP)

.PHONY: build_macos_demo
build_macos_demo: love_demo
	mkdir -p ${BUILD_DIR}
	$(eval TMP := $(shell mktemp -d))
	cp ${DEPS_DATA}/love.app/ ${TMP}/${BUILD_BIN_NAME}_demo.app -Rv
	cp ${LOVE_TARGET_DEMO} ${TMP}/${BUILD_BIN_NAME}_demo.app/Contents/Resources/${BUILD_BIN_NAME}.love
	cd ${TMP}; \
	zip -ry ${WORKING_DIRECTORY}/${BUILD_DIR}/${BUILD_MACOS_DEMO}.zip ${BUILD_BIN_NAME}_demo.app/
	cd ${WORKING_DIRECTORY}
	rm -rf $(TMP)

.PHONY: build_linux64
build_linux64: love
	mkdir -p ${BUILD_DIR}
	$(eval TMP := $(shell mktemp -d))
	cp -r ${DEPS_DATA}/love-${LOVE_VERSION}\-amd64/* ${TMP}
	mv ${TMP}/love ${TMP}/${BUILD_BIN_NAME}
	cp ${TMP}/usr/bin/love ${TMP}/usr/bin/love_bin
	cat ${TMP}/usr/bin/love_bin ${LOVE_TARGET} > ${TMP}/usr/bin/love
	cd ${TMP}; \
	zip -ry ${WORKING_DIRECTORY}/${BUILD_DIR}/${BUILD_LINUX}.zip *
	rm -rf $(TMP)

.PHONY: build_linux64_demo
build_linux64_demo: love_demo
	mkdir -p ${BUILD_DIR}
	$(eval TMP := $(shell mktemp -d))
	cp -r ${DEPS_DATA}/love-${LOVE_VERSION}\-amd64/* ${TMP}
	mv ${TMP}/love ${TMP}/${BUILD_BIN_NAME}_demo
	cp ${TMP}/usr/bin/love ${TMP}/usr/bin/love_bin
	cat ${TMP}/usr/bin/love_bin ${LOVE_TARGET_DEMO} > ${TMP}/usr/bin/love
	cd ${TMP}; \
	zip -ry ${WORKING_DIRECTORY}/${BUILD_DIR}/${BUILD_LINUX_DEMO}.zip *
	rm -rf $(TMP)

.PHONY: all
all: build_love build_love_demo build_win32 build_win32_demo build_win64 build_win64_demo build_macos build_macos_demo build_linux64 build_linux64_demo

.PHONY: deploy
deploy: all
	${BUTLER} login
	${BUTLER} push ${BUILD_DIR}/${BUILD_LOVE}.love ${BUTLER_ITCHUSERNAME}/${BUTLER_ITCHNAME}:love --userversion ${BUTLER_VERSION}
	${BUTLER} push ${BUILD_DIR}/${BUILD_WIN32}.zip ${BUTLER_ITCHUSERNAME}/${BUTLER_ITCHNAME}:win32 --userversion ${BUTLER_VERSION}
	${BUTLER} push ${BUILD_DIR}/${BUILD_WIN64}.zip ${BUTLER_ITCHUSERNAME}/${BUTLER_ITCHNAME}:win64 --userversion ${BUTLER_VERSION}
	${BUTLER} push ${BUILD_DIR}/${BUILD_MACOS}.zip ${BUTLER_ITCHUSERNAME}/${BUTLER_ITCHNAME}:macosx --userversion ${BUTLER_VERSION}
	${BUTLER} push ${BUILD_DIR}/${BUILD_LINUX}.zip ${BUTLER_ITCHUSERNAME}/${BUTLER_ITCHNAME}:linux64 --userversion ${BUTLER_VERSION}
	${BUTLER} push ${BUILD_DIR}/${BUILD_LOVE_DEMO}.love ${BUTLER_ITCHUSERNAME}/${BUTLER_ITCHNAME}:love_demo --userversion ${BUTLER_VERSION}
	${BUTLER} push ${BUILD_DIR}/${BUILD_WIN32_DEMO}.zip ${BUTLER_ITCHUSERNAME}/${BUTLER_ITCHNAME}:win32_demo --userversion ${BUTLER_VERSION}
	${BUTLER} push ${BUILD_DIR}/${BUILD_WIN64_DEMO}.zip ${BUTLER_ITCHUSERNAME}/${BUTLER_ITCHNAME}:win64_demo --userversion ${BUTLER_VERSION}
	${BUTLER} push ${BUILD_DIR}/${BUILD_MACOS_DEMO}.zip ${BUTLER_ITCHUSERNAME}/${BUTLER_ITCHNAME}:macosx_demo --userversion ${BUTLER_VERSION}
	${BUTLER} push ${BUILD_DIR}/${BUILD_LINUX_DEMO}.zip ${BUTLER_ITCHUSERNAME}/${BUTLER_ITCHNAME}:linux64_demo --userversion ${BUTLER_VERSION}
	${BUTLER} status ${BUTLER_ITCHUSERNAME}/${BUTLER_ITCHNAME}

.PHONY: status
status:
	#VERSION: ${BUILD_INFO}
	butler status ${BUTLER_ITCHUSERNAME}/${BUTLER_ITCHNAME}

.PHONY: steam_prep
steam_prep: all

	rm -rf ${STEAM_PREP_DIR}

	mkdir -p ${STEAM_PREP_DIR}/win64 # depot 1
	mkdir -p ${STEAM_PREP_DIR}/win32 # depot 2
	mkdir -p ${STEAM_PREP_DIR}/macosx # depot 3
	mkdir -p ${STEAM_PREP_DIR}/linux64 # depot 4

	mkdir -p ${STEAM_PREP_DIR}/win64_demo # depot 1
	mkdir -p ${STEAM_PREP_DIR}/win32_demo # depot 2
	mkdir -p ${STEAM_PREP_DIR}/macosx_demo # depot 3
	mkdir -p ${STEAM_PREP_DIR}/linux64_demo # depot 4

	unzip ${BUILD_DIR}/${BUILD_WIN64}.zip -d ${STEAM_PREP_DIR}/win64
	unzip ${BUILD_DIR}/${BUILD_WIN32}.zip -d ${STEAM_PREP_DIR}/win32
	unzip ${BUILD_DIR}/${BUILD_MACOS}.zip -d ${STEAM_PREP_DIR}/macosx
	unzip ${BUILD_DIR}/${BUILD_LINUX}.zip -d ${STEAM_PREP_DIR}/linux64

	unzip ${BUILD_DIR}/${BUILD_WIN64_DEMO}.zip -d ${STEAM_PREP_DIR}/win64_demo
	unzip ${BUILD_DIR}/${BUILD_WIN32_DEMO}.zip -d ${STEAM_PREP_DIR}/win32_demo
	unzip ${BUILD_DIR}/${BUILD_MACOS_DEMO}.zip -d ${STEAM_PREP_DIR}/macosx_demo
	unzip ${BUILD_DIR}/${BUILD_LINUX_DEMO}.zip -d ${STEAM_PREP_DIR}/linux64_demo

	cp src/git.lua ${STEAM_PREP_DIR}/win32/version
	cp src/git.lua ${STEAM_PREP_DIR}/win64/version
	cp src/git.lua ${STEAM_PREP_DIR}/macosx/version
	cp src/git.lua ${STEAM_PREP_DIR}/linux64/version

	cp src/git.lua ${STEAM_PREP_DIR}/win32_demo/version
	cp src/git.lua ${STEAM_PREP_DIR}/win64_demo/version
	cp src/git.lua ${STEAM_PREP_DIR}/macosx_demo/version
	cp src/git.lua ${STEAM_PREP_DIR}/linux64_demo/version
