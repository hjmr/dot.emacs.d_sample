;;-*- coding: utf-8 -*-
;;-------------------------------------
;; 初期ディレクトリをホームに変更
;;-------------------------------------
(when (getenv "HOME")
  (cd (getenv "HOME")))
;;-------------------------------------
;; パッケージ周りの初期化
;;-------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 27)
  (package-initialize))
;;-------------------------------------
;; 言語環境：日本語
;;-------------------------------------
(set-language-environment 'Japanese)
;;-------------------------------------
;; 文字コード：UTF-8
;;-------------------------------------
(prefer-coding-system        'utf-8)
(set-default-coding-systems  'utf-8)
(set-terminal-coding-system  'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-keyboard-coding-system  nil)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq default-file-name-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
;;-------------------------------------
;; タブ位置の指定
;;-------------------------------------
(setq default-tab-width 4)
;; use spaces instead of tab to fill blank
(setq-default indent-tabs-mode nil)
(setq tab-stop-list
      '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
;;-------------------------------------
;; キーワードのハイライト表示
;;-------------------------------------
(global-font-lock-mode t)
;;-------------------------------------
;; 選択範囲のハイライト表示
;;-------------------------------------
(transient-mark-mode 1)
;;-------------------------------------
;; 対応する括弧のハイライト表示
;;-------------------------------------
(show-paren-mode t)
(setq show-paren-style 'parensis)
;;(setq show-paren-style 'mixed)
;;-------------------------------------
;; テキストとプログラムでは左側に行番号を表示
;;-------------------------------------
(setq-default display-line-numbers-width 4
              display-line-numbers-widen t)
(set-face-attribute 'line-number nil
                    :foreground "gray40")
(set-face-attribute 'line-number-current-line nil
                    :foreground "white")
(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
;;-------------------------------------
;; テーマの読み込み
;;-------------------------------------
(load-theme 'wombat t)
(enable-theme 'wombat)
;;-------------------------------------
;; 初期フレームの位置・大きさ・半透明
;;-------------------------------------
(add-to-list 'default-frame-alist '(alpha . (100 . 80))) ;; 非アクティブ時透明度80%
(add-to-list 'default-frame-alist '(top .  0))         ;; y座標 0
(add-to-list 'default-frame-alist '(left . 0))         ;; x座標 0
(add-to-list 'default-frame-alist '(width . 120))      ;; 幅：120文字
(add-to-list 'default-frame-alist '(height . 100))     ;; 縦：100行
;;-------------------------------------
;; その他の設定
;;-------------------------------------
;; (menu-bar-mode -1)            ;; メニューバーを表示しない
(tool-bar-mode -1)               ;; ツールバーを表示しない
(set-scroll-bar-mode 'nil)       ;; スクロールバーを表示しない
(setq visible-bell t)            ;; 警告をビープ音ではなく画面フラッシュで通知
(setq-default major-mode 'indented-text-mode)  ;; デフォルトモードの設定
(setq-default fill-column 96)    ;; 96文字で改行する
(setq case-replace t)            ;; 置換時に大文字小文字を区別する
(set-default 'cursor-type 'bar)  ;; カーソルの形状
;;-------------------------------------
;; キー設定
;;-------------------------------------
(global-set-key   (kbd "C-h")     'backward-delete-char-untabify)  ;; C-hでバックスペース
(global-set-key   (kbd "C-x C-b") 'buffer-menu) ;; C-x C-bでバッファ選択画面を表示
(global-set-key   (kbd "C-z")     'scroll-down) ;; C-z で上にスクロール
(global-set-key   (kbd "M-g")     'goto-line)   ;; M-g で行番号にジャンプ
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta))             ;; macOS で option キーを Meta として使う
;;-------------------------------------
;; フォント設定
;;-------------------------------------
;;
;; フォント定義用関数の定義
(defun my-def-font (name asciifont asciifont-size asciifont-weight jpfont jpfont-size jpfont-weight)
  (ignore-errors
    (let* ((fontspec (font-spec :family asciifont :size asciifont-size :weight asciifont-weight))
           (jp-fontspec (font-spec :family jpfont :size jpfont-size :weight jpfont-weight))
           (fsn (create-fontset-from-ascii-font asciifont nil name)))
      (set-fontset-font fsn 'ascii fontspec)
      (set-fontset-font fsn 'japanese-jisx0213.2004-1 jp-fontspec)
      (set-fontset-font fsn 'japanese-jisx0213-2 jp-fontspec)
      (set-fontset-font fsn 'japanese-jisx0208 jp-fontspec)
      (set-fontset-font fsn 'katakana-jisx0201 jp-fontspec)
      (set-fontset-font fsn '(#x0080 . #x024F) fontspec)
      (set-fontset-font fsn '(#x0370 . #x03FF) fontspec)
      )
    t))
;;
;; フォントの定義
(defvar my-ascii-font-size 14)
(defvar my-jp-font-size (truncate (* my-ascii-font-size 1.2)))
(my-def-font "hirakaku" "Monaco" my-ascii-font-size 'medium "Hiragino Kaku Gothic Pro" my-jp-font-size 'medium)
;;
;; フォントの設定
(set-default-font "fontset-hirakaku")
(add-to-list 'default-frame-alist '(font . "fontset-hirakaku"))
;;-------------------------------------
;; END OF FILE
;;-------------------------------------
