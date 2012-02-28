.. -*- coding: utf-8; -*-

MacBook Pro 13-inch Mid 2009

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

.. sourcecode:: sh

   $ vi .zshrc
   ...
   # proxy setting for apt
   export http_proxy="http://proxy.ritsumei.ac.jp:3128/"
   export ftp_proxy="http://proxy.ritsumei.ac.jp:3128/"
   ...
   $ sudo visudo
   ...
   # keep proxy setting for apt
   Defaults        env_keep += "http_proxy ftp_proxy"
   ...
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

`uchida/rcfiles - GitHub <https://github.com/uchida/rcfiles>`_ に設定ファイルがある。

.. sourcecode:: sh

   $ git clone https://uchida@github.com/uchida/rcfiles.git
   $ cd rcfiles
   $ make install

make install で設定ファイルを削除するので注意。
詳細は Makefile 参照。

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
- `LibreOffice <http://www.libreoffice.org/>`_ オフィスソフトウェア
- `LiveQuartz - Mac App Store <http://itunes.apple.com/us/app/livequartz/id402387626>`_ イメージエディタ
- `p4merge <http://www.perforce.com/product/components/perforce_visual_merge_and_diff_tools>`_
  マージツール
  git での p4merge の設定

  .. sourcecode:: sh

     $ git config --global merge.tool p4merge
     $ git config --global mergetool.p4merge.cmd '/Applications/p4merge.app/Contents/MacOS/p4merge $BASE $LOCAL $REMOTE $MERGED'
     $ git config --global mergetool.p4merge.trustExitCode false

  mercurial での p4merge の設定は `P4Merge - Mercurial <http://mercurial.selenic.com/wiki/P4Merge>`_ 参照
- `SecondBar <http://blog.boastr.net/?page_id=79>`_
  デュアルディスプレイ環境でサブモニタにもメニューバーを表示
  サブモニタを自動認識するために
  以下の secondbar.sh を用意する。システム環境設定のディスプレイを参照してプロファイル名を適切に設定する。

  .. sourcecode:: sh

     #/bin/sh
     if [ -n "`system_profiler SPDisplaysDataType| grep 'プロファイル名'`" ]; then
         open -a SecondBar
     fi

  を書いておいて、AppleScript

  .. sourcecode:: applescript

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
- `QLColorCode <http://code.google.com/p/qlcolorcode/>`_
  `QuickLookでソースをカラーリング：QLColorCodeの改良 <http://d.hatena.ne.jp/beehive62/20100802/1280739114>`_
  を参考に日本語が文字化けしないようにする。

IME
---

- `AquaSKK <http://aquaskk.sourceforge.jp/>`_ 日本語入力、慣れると快適。

その他
------

ネットワークディスクアクセス時に .DS_Store ファイルを作らないように

.. sourcecode:: sh

   $ defaults write com.apple.desktopservices DSDontWriteNetworkStores true

その後再起動 `Mac OS X 10.4: ネットワーク接続時に .DS_Store ファイルの作成を抑制する方法
<http://support.apple.com/kb/HT1629?viewlocale=ja_JP>`_

locate を有効に

.. sourcecode:: sh

   $ sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

これで locate コマンドが使える。

