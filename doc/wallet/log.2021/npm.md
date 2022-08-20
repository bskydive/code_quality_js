
# PACKAGE

## Dependencies

  name bitpay
  description Secure Bitcoin Wallet
  author BitPay
  version 12.7.6
  keywords [
    bitcoin
    wallet
    bitpay
    copay
    multisignature
    bitcore
  ]
  main electron/main.js
  title BitPay
  user-agent %name %ver (%osinfo)
  webkit 
    page-cache false
    java false
    plugin false
  
  dom_storage_quota 200
  id jid1-x7bV5evAaI1P9Q
  homepage https//bitpay.com
  license MIT
  repository 
    url git//github.com/bitpay/copay.git
    type git
  
  bugs 
    url https//github.com/bitpay/copay/issues
  
  scripts 
    postinstall npm run envdev && npm run prompt && npm run patchbwc && npm run patchwalletconnect
    electronpatch (! grep -q 'com.apple.security.app-sandbox' ./node_modules/app-builder-lib/templates/entitlements.mac.plist && sed -i -e \/<dict>/ a\\ \n<key>com.apple.security.app-sandbox</key><true/>\ ./node_modules/app-builder-lib/templates/entitlements.mac.plist) | echo 'electron patched.'
    patchbwc (sed -i -e 's/\\#private;//' ./node_modules/bitcore-wallet-client/ts_build/lib/key.d.ts) | echo 'BWC patched.'
    patchwalletconnect sh ./utils/walletconnect-patch.sh | echo 'walletconnect patched.'
    prompt \n\n\n\n\n\n#\n#  Choose a distribution with\n#\n#     $ npm run applycopay\n#              or\n#     $ npm run applybitpay\n#\n
    start npm run ionicserve
    clean rm -rf platforms && rm -rf plugins && rm -f config.xml
    preparecopay npm run clean && npm run applycopay && ionic cordova platform add ios; ionic cordova platform add android && npm run fixfcm
    preparebitpay npm run clean && npm run applybitpay  && ionic cordova platform add ios; ionic cordova platform add android && npm run fixfcm && npm run fixiab
    clean-all git clean -dfx
    lint ionic-app-scripts lint
    ionicbuild ionic-app-scripts build
    ionicserve ionic-app-scripts serve --nolivereload
    ionictest npm run envprod && node --max-old-space-size=8192 ./node_modules/@ionic/app-scripts/bin/ionic-app-scripts.js build --release --aot true --environment prod --output-hashing all --sourcemaps false --extract-css true --named-chunks false --build-optimizer true
    watch ng test --browsers=Chrome
    test npm run envdev && npm run testlint && npm run testci
    testcoverage ng test --code-coverage
    testci ng test --watch=false --code-coverage --no-progress
    testlint tslint --project . --format codeFrame && tslint 'testelectronsrc/**/*.ts' --format codeFrame && prettier '***/*.jstsscss' --list-different
    fixtslint tslint --fix --project . && tslint --fix 'testelectronsrc/**/*.ts'
    fixprettier prettier --write '***/*.jstsmdjsonscss'
    fix npm run fixtslint && npm run fixprettier
    fixiab node ./utils/iab-patch.js
    envdesktop rm -f src/environments/index.ts && cp src/environments/desktop.ts src/environments/index.ts \n\n# Environment set to desktop\n\n
    envprod rm -f src/environments/index.ts && cp src/environments/prod.ts src/environments/index.ts \n\n# Environment set to prod\n\n
    envdev rm -f src/environments/index.ts && cp src/environments/dev.ts src/environments/index.ts \n\n# Environment set to dev\n\n
    translationextract ngx-translate-extract --input ./src --output ./i18n/template.pot --clean --sort --format pot
    translationupdate node ./i18n/crowdin_update.js
    translationdownload node ./i18n/crowdin_download.js
    startios npm run buildios && npm run openios
    startandroid npm run runandroid
    startdesktop npm run builddesktop && electron .
    buildios npm run envdev && ionic cordova build ios --debug --buildConfig
    buildandroid npm run envdev && ionic cordova build android --debug
    builddesktop npm run envdev && npm run ionicbuild
    buildios-release npm run envprod && ionic cordova build ios --release --aot true --environment prod --output-hashing all --sourcemaps false --extract-css true --named-chunks false --build-optimizer true --buildConfig
    buildandroid-release npm run envprod && ionic cordova plugin add cordova-android-googlepay-issuer-ng@1.0.4 && ionic cordova build android --release --aot true --environment prod --output-hashing all --sourcemaps false --extract-css true --named-chunks false --build-optimizer true
    builddesktop-release npm run envdesktop && node --max-old-space-size=8192 ./node_modules/@ionic/app-scripts/bin/ionic-app-scripts.js build --prod --uglifyjs ./config/uglify.config.js --webpack ./config/webpack.config.js
    buildelectron npm install electron-builder@22.9.1 --save-dev; node ./electron/build-electron.js
    openios open platforms/ios/*.xcworkspace
    openandroid open -a open -a /Applications/Android\\ Studio.app platforms/android
    finalios NODE_OPTIONS=--max_old_space_size=4096 npm run buildios-release; npm run openios
    finalandroid NODE_OPTIONS=--max_old_space_size=4096 npm run buildandroid-release && npm run alignandroid && npm run signv2android
    finaldesktop npm run builddesktop-release && npm run buildelectron
    runandroid npm run envdev && ionic cordova run android --device --debug
    runandroid-release npm run envprod && ionic cordova run android --device --release
    logandroid adb logcat | grep chromium
    signandroid rm -f platforms/android/app/build/outputs/apk/release/android-release-signed-aligned.apk; jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ../copay.keystore -signedjar platforms/android/app/build/outputs/apk/release/android-release-signed.apk platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk  copay_play && $ANDROID_HOME/build-tools/28.0.3/zipalign -v 4 platforms/android/app/build/outputs/apk/release/android-release-signed.apk platforms/android/app/build/outputs/apk/release/android-release-signed-aligned.apk
    verifyandroid $ANDROID_HOME/build-tools/28.0.3/apksigner verify -v --print-certs platforms/android/app/build/outputs/apk/release/android-release-aligned-signed.apk
    signv2android $ANDROID_HOME/build-tools/28.0.3/apksigner sign --ks ../copay.keystore --ks-key-alias copay_play platforms/android/app/build/outputs/apk/release/android-release-aligned-unsigned.apk && mv platforms/android/app/build/outputs/apk/release/android-release-aligned-unsigned.apk platforms/android/app/build/outputs/apk/release/android-release-aligned-signed.apk
    alignandroid $ANDROID_HOME/build-tools/28.0.3/zipalign -v 4 platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk platforms/android/app/build/outputs/apk/release/android-release-aligned-unsigned.apk
    applycopay cd app-template && node apply.js copay
    applybitpay cd app-template && node apply.js bitpay
    applybitpay-dev cd app-template && NODE_ENV=dev node apply.js bitpay
    fixfcm echo platforms/ios/Copay/Resources platforms/ios/Copay/Resources/Resources platforms/ios/Bitpay/Resources platforms/ios/Bitpay/Resources/Resources | xargs -n 1 cp GoogleService-Info.plist 2>/dev/null; mkdir -p platforms/android/app/src/debug platforms/android/app/src/release; echo platforms/android/app/src/debug platforms/android/app/src/release platforms/android/app | xargs -n 1 cp google-services.json
    signcopay-desktop npm run signcopay-linux && npm run signcopay-windows && npm run signcopay-macos
    signcopay-macos gpg -u 1112CFA1 --output dist/Copay.dmg.sig --detach-sig dist/Copay.dmg
    signcopay-linux gpg -u 1112CFA1 --output dist/Copay-linux.zip.sig --detach-sig dist/Copay-linux.zip
    signcopay-windows gpg -u 1112CFA1 --output dist/Copay.exe.sig --detach-sig dist/Copay.exe
    verifycopay-desktop gpg --verify dist/Copay-linux.zip.sig dist/Copay-linux.zip; gpg --verify dist/Copay.exe.sig dist/Copay.exe; gpg --verify dist/Copay.dmg.sig dist/Copay.dmg
    signbitpay-desktop npm run signbitpay-linux && npm run signbitpay-windows && npm run signbitpay-macos
    signbitpay-macos gpg -u 1112CFA1 --output dist/BitPay.dmg.sig --detach-sig dist/BitPay.dmg
    signbitpay-linux gpg -u 1112CFA1 --output dist/BitPay-linux.zip.sig --detach-sig dist/BitPay-linux.zip
    signbitpay-windows gpg -u 1112CFA1 --output dist/BitPay.exe.sig --detach-sig dist/BitPay.exe
    verifybitpay-desktop gpg --verify dist/BitPay-linux.zip.sig dist/BitPay-linux.zip; gpg --verify dist/BitPay.exe.sig dist/BitPay.exe; gpg --verify dist/BitPay.dmg.sig dist/BitPay.dmg
  
  dependencies 
    @angular/animations 5.2.11
    @angular/common 5.2.11
    @angular/compiler 5.2.11
    @angular/compiler-cli 5.2.11
    @angular/core 5.2.11
    @angular/forms 5.2.11
    @angular/http 5.2.11
    @angular/platform-browser 5.2.11
    @angular/platform-browser-dynamic 5.2.11
    @angular/tsc-wrapped 4.4.6
    @ionic-native/clipboard 4.14.0
    @ionic-native/core 4.14.0
    @ionic-native/device 4.14.0
    @ionic-native/file 4.14.0
    @ionic-native/fingerprint-aio 4.14.0
    @ionic-native/launch-review 4.14.0
    @ionic-native/qr-scanner 4.14.0
    @ionic-native/screen-orientation 4.14.0
    @ionic-native/social-sharing 4.20.0
    @ionic-native/splash-screen 4.14.0
    @ionic-native/status-bar 4.14.0
    @ionic-native/toast 4.14.0
    @ionic-native/user-agent 4.14.0
    @ionic-native/vibration 4.14.0
    @ionic/storage 2.1.3
    @ngx-translate/core 9.1.1
    @walletconnect/client 1.3.1
    angular2-moment 1.7.1
    apexcharts 3.24.0
    apple-wallet-ng 1.1.1
    base64-js 1.3.0
    bitauth git+https//github.com/bitpay/bitauth.git#68cf0353bf517a7e5293478608839fa904351eb6
    bitcore-wallet-client 8.25.15
    buffer-compare 1.1.1
    chart.js 2.9.4
    cordova 9.0.0
    cordova-android 9.0.0
    cordova-apple-wallet-ng 1.3.1
    cordova-clipboard 1.2.1
    cordova-custom-config 5.1.0
    cordova-ios 5.1.1
    cordova-launch-review 3.1.1
    cordova-plugin-add-swift-support 2.0.2
    cordova-plugin-advanced-http 2.1.0
    cordova-plugin-compat 1.2.0
    cordova-plugin-customurlscheme-ng 11.0.0
    cordova-plugin-device 2.0.1
    cordova-plugin-dialogs 2.0.2
    cordova-plugin-fcm-ng 8.3.0
    cordova-plugin-file 6.0.2
    cordova-plugin-fingerprint-aio 3.0.1
    cordova-plugin-globalization 1.0.9
    cordova-plugin-idfa 2.0.0
    cordova-plugin-inappbrowser 4.1.0
    cordova-plugin-ionic-keyboard 2.1.3
    cordova-plugin-qrscanner 3.0.1
    cordova-plugin-screen-orientation 3.0.2
    cordova-plugin-spinner-dialog 1.3.1
    cordova-plugin-splashscreen 5.0.3
    cordova-plugin-statusbar 2.4.3
    cordova-plugin-theme-detection 1.2.1
    cordova-plugin-useragent https//github.com/danielsogl/cordova-plugin-useragent.git
    cordova-plugin-vibration 3.1.1
    cordova-plugin-whitelist 1.3.4
    cordova-plugin-wkwebview-engine 1.2.1
    cordova-plugin-x-socialsharing 5.6.8
    cordova-plugin-x-toast 2.6.0
    cordova-support-android-plugin 1.0.2
    countries-list 2.5.5
    es6-promise-plugin 4.2.2
    eth-sig-util 3.0.1
    fcm-ng 2.1.0
    gettext-parser 1.3.0
    ionic-angular 3.9.10
    ionic-image-loader 6.3.2
    ionicons 3.0.0
    lodash 4.17.21
    ngx-barcode 0.2.4
    ngx-markdown 1.5.2
    ngx-qrcode2 0.1.0
    ngx-text-overflow-clamp 0.0.1
    papaparse 5.3.0
    qr-code-component-ng 0.0.4
    rxjs 5.5.12
    text-encoding 0.6.4
    text-mask-core 5.1.2
    web-animations-js 2.3.1
    webpack-bundle-analyzer ^4.5.0
    zone.js 0.8.26
  
  devDependencies 
    @angular-devkit/build-angular 0.12.4
    @angular/cli 7.1.4
    @biesbjerg/ngx-translate-extract 2.3.4
    @ionic-native-mocks/file 2.0.12
    @ionic-native-mocks/fingerprint-aio 2.0.12
    @ionic-native-mocks/qr-scanner 2.0.12
    @ionic/app-scripts 3.2.3
    @types/chrome 0.0.64
    @types/cordova-plugin-qrscanner 1.0.31
    @types/jasmine 2.8.6
    @types/lodash 4.14.121
    @types/node 12.12.6
    @types/papaparse 4.1.34
    @types/prismjs 1.9.1
    adm-zip 0.4.13
    codecov 3.7.2
    cordova-plugin-androidx-adapter 1.1.3
    core-js 2.6.10
    electron 9.4.2
    fs-extra 9.0.1
    ionic 4.10.4
    ionic-mocks 1.2.1
    jasmine-core 2.99.1
    jasmine-reporters 2.3.0
    karma 3.1.3
    karma-chrome-launcher 2.2.0
    karma-cli 1.0.1
    karma-coverage-istanbul-reporter 1.4.1
    karma-jasmine 1.1.1
    karma-jasmine-html-reporter 0.2.2
    karma-spec-reporter 0.0.32
    mini-css-extract-plugin 0.8.0
    prettier 2.1.2
    shelljs 0.8.1
    ts-node 5.0.0
    tslint 5.8.0
    tslint-config-prettier 1.18.0
    typescript 2.6.2
    webpack 3.12.0
    webpack-obfuscator 0.17.3
  
  config 
    ionic_uglifyjs ./config/uglifyjs.config.js
    ionic_bundler webpack
    ionic_webpack ./config/webpack.config.js
  
  cordova 
    plugins 
      cordova-plugin-device 
      cordova-plugin-splashscreen 
      cordova-plugin-statusbar 
      cordova-plugin-whitelist 
      cordova-plugin-ionic-keyboard 
      cordova-clipboard 
      cordova-plugin-x-toast 
      cordova-plugin-x-socialsharing 
      cordova-plugin-qrscanner 
      cordova-plugin-dialogs 
      cordova-plugin-file 
      cordova-custom-config 
      cordova-plugin-customurlscheme-ng 
        URL_SCHEME bitcoin
        SECOND_URL_SCHEME bitpay
        THIRD_URL_SCHEME bitcoincash
        FOURTH_URL_SCHEME bchtest
        FIFTH_URL_SCHEME ethereum
        SIXTH_URL_SCHEME ripple
        SEVENTH_URL_SCHEME wc
        EIGHTH_URL_SCHEME dogecoin
        ANDROID_SCHEME 
        ANDROID_HOST 
        ANDROID_PATHPREFIX 
      
      cordova-plugin-fcm-ng 
        PAGE_LINK_DOMAIN bitpayapp.page.link
      
      cordova-plugin-globalization 
      cordova-plugin-inappbrowser 
      cordova-plugin-screen-orientation 
      cordova-plugin-spinner-dialog 
      cordova-plugin-vibration 
      im.ltdev.cordova.UserAgent 
      cordova-launch-review 
      cordova-plugin-wkwebview-engine 
      cordova-plugin-advanced-http 
      cordova-plugin-theme-detection 
      cordova-apple-wallet-ng 
      cordova-plugin-add-swift-support 
      cordova-plugin-fingerprint-aio 
        FACEID_USAGE_DESCRIPTION  
      
      cordova-plugin-idfa 
        ANDROID_PLAY_ADID_VERSION 17.0.+
      
      cordova-plugin-androidx-adapter 
    
    platforms [
      android
      ios
    ]
  
  prettier 
    singleQuote true
    trailingComma none
    arrowParens avoid
  


## NPM AUDIT
found 292 vulnerabilities (17 low, 105 moderate, 134 high, 36 critical) in 2650 scanned packages
  run `npm audit fix` to fix 133 of them.
  105 vulnerabilities require semver-major dependency updates.
  54 vulnerabilities require manual review. See the full report for details.
