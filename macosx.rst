.. -*- coding: utf-8; -*-

Mac OS X 備忘録
===============

インストール時のメモ

:Hardware: MacBook Pro 13-inch Mid 2009
:OS: Mac OS X 10.7 Lion

Xcode
-----

`Xcode - Mac App Store <http://itunes.apple.com/jp/app/xcode/id497799835>`_ から入手。

コマンドラインから使うツールだけ欲しい場合には

`Apple Developer <http://developer.apple.com/downloads>`_ から
Command Line Tools for Xcode のディスクイメージを入手してインストールする。

参考: `XcodeからCommand Line Tools for Xcodeに切り替えたらHDD使用容量が7GB減った - Guide Note -
<http://blog.glidenote.com/blog/2012/02/20/command-line-tools-for-xcode/>`_

Mac OS X WorkShop
-----------------

Xcode をインストールした後に
`MacOSX-WS-10.7.0.dmg <http://www.bach-phys.ritsumei.ac.jp/OSXWS/Lion/MacOSX-WS-10.7.0.dmg>`_ を入手、 インストール。

コマンドラインでの Install & Setting

.. code-block:: console

   $ vi .zshrc
   ...
   export http_proxy="http://proxy.ritsumei.ac.jp:3128/"
   export ftp_proxy="http://proxy.ritsumei.ac.jp:3128/"
   ...
   $ sudo visudo # sudo with env_keep proxy variables
   ...
   Defaults        env_keep += "http_proxy ftp_proxy"
   ...
   $ sudo vi /usr/osxws/etc/apt/sources.list.d/addon.list
   rpm      http://www.ike-dyn.ritsumei.ac.jp/OSXWS 10.7/$(ARCH) main
   rpm      http://www.ike-dyn.ritsumei.ac.jp/OSXWS 10.7/noarch main
   rpm-src  http://www.ike-dyn.ritsumei.ac.jp/OSXWS 10.7/$(ARCH) main
   $ sudo apt-get update
   $ sudo apt-get dist-upgrade
   $ sudo apt-get install task-texlive
   $ sudo apt-get install ipython
   $ sudo apt-get install git git-svn mercurial
   $ sudo apt-get install skk
   $ sudo apt-get install python-scipy python-matplotlib
   $ sudo apt-get install python-docutils python-sphinx
   $ sudo apt-get install xgraph gnuplot
   $ sudo apt-get install tmux newsbeuter
   $ sudo apt-get clean

設定
----

`uchida/rcfiles - GitHub <https://github.com/uchida/rcfiles>`_ にシェルなどの設定ファイルがある。

.. code-block:: console

   $ git clone https://uchida@github.com/uchida/rcfiles.git
   $ cd rcfiles
   $ make install

make install で設定ファイルを削除するので注意。
詳細は `Makefile at master from uchida/rcfiles - GitHub <https://github.com/uchida/rcfiles/blob/master/Makefile>`_ 参照。


`uchida/dot-emacs - GitHub <https://github.com/uchida/dot-emacs>`_ に Emacs の設定がある。

.. code-block:: console

   $ git clone https://uchida@github.com/uchida/dot-emacs.git
   $ cd dot-emacs
   $ make install

これも make install で設定ファイルを削除するので注意。
詳細は `Makefile at master from uchida/dot-emacs - GitHub <https://github.com/uchida/dot-emacs/blob/master/Makefile>`_ 参照。

no-window モードで vimpulse を利用して vim キーバインドを使っているので、一般的な設定にはなっていないと思う。

Applications
------------

- `Alfred - Mac App Store <http://itunes.apple.com/jp/app/alfred/id405843582>`_ ランチャ
- `AppCleaner <http://www.freemacsoft.net/AppCleaner/>`_ アンインストーラ
- `AppFresh <http://metaquark.de/appfresh/>`_ Application の更新チェック
- `atMonitor <http://www.atpurpose.com/atMonitor/>`_ メニューバーに CPU, RAM, Network の状況を表示
- `BibDesk <http://bibdesk.sourceforge.net/>`_ 文献管理
- `Caffeine - Mac App Store <http://itunes.apple.com/jp/app/caffeine/id411246225>`_  スリープ，スクリーンセーバーを一時的に停止
- `Cocoaportrace <http://members3.jcom.home.ne.jp/akitake76/AppleScriptDepot/Cocoapotrace.html>`_
  ビットマップ画像をベクター画像に変換
- `f.lux <http://stereopsis.com/flux/>`_ 時間帯に応じてモニタの色温度を変化
- `GitX(L) <http://gitx.laullon.com/>`_ Git の Mac OS X クライアント GitX の fork でより高機能
- `Google Chrome <http://dev.chromium.org/getting-involved/dev-channel>`_ ブラウザ Dev Channel for Mac を利用している
- `iTerm2 <http://code.google.com/p/iterm2/>`_ ターミナルソフト、標準の Terminal.app より高機能
  色設定は `effkay/iTerm-argonaut - GitHub <https://github.com/effkay/iTerm-argonaut>`_ を使っている
- `LibreOffice <http://www.libreoffice.org/>`_ オフィスソフトウェア
- `LiveQuartz - Mac App Store <http://itunes.apple.com/us/app/livequartz/id402387626>`_ イメージエディタ
- `p4merge <http://www.perforce.com/product/components/perforce_visual_merge_and_diff_tools>`_
  マージツール
  git での p4merge の設定

  .. code-block:: console

     $ git config --global merge.tool p4merge
     $ git config --global mergetool.p4merge.cmd '/Applications/p4merge.app/Contents/MacOS/p4merge $BASE $LOCAL $REMOTE $MERGED'
     $ git config --global mergetool.p4merge.trustExitCode false

  mercurial での p4merge の設定は `P4Merge - Mercurial <http://mercurial.selenic.com/wiki/P4Merge>`_ 参照
- `SecondBar <http://blog.boastr.net/?page_id=79>`_
  デュアルディスプレイ環境でサブモニタにもメニューバーを表示してくれる。

  サブモニタの有無を確認して、つないでいるときだけ起動するために以下の secondbar.sh を用意する。

  .. code-block:: sh

     #/bin/sh
     if [ -n "`system_profiler SPDisplaysDataType| grep 'プロファイル名'`" ]; then
         open -a SecondBar
     fi

  プロファイル名はサブモニタをつないだり、外したりしながら ``system_profiler SPDisplaysDataType`` を実行して確認する。

  そして、以下のシェルスクリプトを起動するだけの AppleScript

  .. code-block:: applescript

     do shell script "/path/to/secondbar.sh"

  をログインアイテムに追加する。

- `The Unarchiver <http://code.google.com/p/theunarchiver/>`_ 圧縮ファイルを展開

Preferences Pane
-----------------

- `KeyRemap4MacBook <http://pqrs.org/macosx/keyremap4macbook/index.html.ja>`_ キーボードリマッパー
- `Perian <http://perian.org/>`_ さまざまな動画形式を Quick Time で再生できるようにする

QuickLook
---------

- `QLStephen <http://whomwah.github.com/qlstephen/>`_ 拡張子の無いテキストファイル
- `QLColorCode <http://code.google.com/p/qlcolorcode/>`_ ソースコード等をハイライト表示して QuickLook できる。

  日本語が含まれると文字化けするので
  `QuickLookでソースをカラーリング：QLColorCodeの改良 <http://d.hatena.ne.jp/beehive62/20100802/1280739114>`_
  を参考に変更する。

  .. code-block:: diff
 
     diff -uNr QLColorCode.qlgenerator.orig/Contents/Resources/colorize.sh QLColorCode.qlgenerator/Contents/Resources/colorize.sh
     --- QLColorCode.qlgenerator.orig/Contents/Resources/colorize.sh 2009-09-19 03:01:32.000000000 +0900
     +++ QLColorCode.qlgenerator/Contents/Resources/colorize.sh  2012-02-28 17:36:18.000000000 +0900
     @@ -37,12 +37,12 @@
      cmdOpts=(-I --font $font --quiet --add-data-dir $rsrcDir/override \
               --data-dir $rsrcDir/highlight/share/highlight \
               --add-config-dir $rsrcDir/override/config --style $hlTheme \
     -         --font-size $fontSizePoints --encoding $textEncoding ${=extraHLFlags})
     +         --font-size $fontSizePoints --encoding $textEncoding utf-8 ${=extraHLFlags})
      
      #for o in $cmdOpts; do echo $o\<br/\>; done 
      
      debug Setting reader
     -reader=(cat $target)
     +reader=(/usr/osxws/bin/nkf -w -Lu $target)
      
      debug Handling special cases
      case $target in

  日本語を含む txt ファイルも QuickLook できるようになる。

IME
---

- `AquaSKK <http://aquaskk.sourceforge.jp/>`_ 日本語入力、慣れると快適。

その他
------

ネットワークディスクアクセス時に .DS_Store ファイルを作らないように

.. code-block:: console

   $ defaults write com.apple.desktopservices DSDontWriteNetworkStores true

その後再起動 `Mac OS X 10.4: ネットワーク接続時に .DS_Store ファイルの作成を抑制する方法
<http://support.apple.com/kb/HT1629?viewlocale=ja_JP>`_

locate を有効に

.. code-block:: console

   $ sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

これで locate コマンドが使える。

