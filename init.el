;; ========================================================================
;; Initial Settings
;; ========================================================================
;; el-get ロードパス設定

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (locate-user-emacs-file "el-get/repo/el-get"))

;; ダウンロードした elisp 置き場
(setq el-get-dir "~/.emacs.d/el-get/repo")

;; ダウンロードしていないときはダウンロード
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "http://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;; 初期化処理用
(setq el-get-user-package-directory "~/.emacs.d/el-get/init-files")

;; レシピ置き場
;; 追加のレシピ置き場
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/user-recipes")


;; ========================================================================
;; General Settings
;; ========================================================================
;; 環境を日本語、UTF-8にする
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)

;; バックアップファイルを作成させない
(setq make-backup-files nil)

;; dired設定
(require 'dired-x)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

;; beep音の代わりに画面フラッシュ
(setq visible-bell t)

;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; 多くの設定ファイル用のメジャーモード
(require 'generic-x)

;; recentf
(setq recentf-max-saved-items 2000) ;; 2000ファイルまで履歴保存する
(setq recentf-auto-cleanup 'never)  ;; 存在しないファイルは消さない
(setq recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
(setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
(setq recentf-keep '(file-remote-p file-readable-p)) ;; ignore remote files
(recentf-mode 1)
(global-set-key (kbd "C-c t") 'helm-recentf)

;; 括弧を自動で閉じる
(electric-pair-mode t)

;; ------------------------------------------------------------------------
;; Name     : org-mode
;; ------------------------------------------------------------------------
;; org-mode/lisp, org-mode/contribe/lispをロードパスに追加する
(defconst dotfiles-dir (file-name-directory
                        (or (buffer-file-name) load-file-name)))
(defconst config-dir "~/.emacs.d/inits/")
(let* ((org-dir (expand-file-name
                 "lisp" (expand-file-name
                         "org-mode" el-get-dir)))
       (org-contrib-dir (expand-file-name
                         "lisp" (expand-file-name
                                 "contrib" (expand-file-name
                                            ".." org-dir)))))
  (setq load-path (append (list org-dir org-contrib-dir)
                          (or load-path nil))))
(require 'org)


;; ========================================================================
;; Key Bindings
;; ========================================================================
;; Ctrl+H をバックスペースに割り当てる
(global-set-key (kbd "C-h") 'backward-delete-char)


;; ========================================================================
;; Visual Settings
;; ========================================================================
;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)

;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; 複数ウィンドウを禁止する
(setq ns-pop-up-frames nil)

;; ウィンドウを透明にする
;; アクティブウィンドウ／非アクティブウィンドウ（alphaの値で透明度を指定）
(add-to-list 'default-frame-alist '(alpha . (0.85 0.85)))

;; メニューバーを消す
(menu-bar-mode -1)

;; ツールバーを消す
;; (tool-bar-mode -1)

;; 列数を表示する
(column-number-mode t)

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; 対応する括弧を光らせる
(show-paren-mode 1)

;; ウィンドウ内に収まらないときだけ、カッコ内も光らせる
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "grey")
(set-face-foreground 'show-paren-match-face "black")


;; ========================================================================
;; Utils
;; ========================================================================
;; ------------------------------------------------------------------------
;; Name     : anzu
;; Function : 検索文字列のマッチ数表示と現在の位置の表示
;; ------------------------------------------------------------------------
(el-get-bundle anzu)
(global-anzu-mode +1)

;; ------------------------------------------------------------------------
;; Name     : company-mode
;; Function : auto complete
;; ------------------------------------------------------------------------
(el-get-bundle company-mode)
(global-company-mode) ; 全バッファで有効にする
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

;; ------------------------------------------------------------------------
;; Name     : expand-region
;; Function : カーソル中のシンボルを一括でリージョン選択する
;; ------------------------------------------------------------------------
(el-get-bundle expand-region)
(global-set-key (kbd "C-,") 'er/expand-region)
(global-set-key (kbd "M-,") 'er/contract-region)

;; ------------------------------------------------------------------------
;; Name     : flycheck
;; Function : syntax checker
;; ------------------------------------------------------------------------
(el-get-bundle flycheck)
;; Python
(add-hook 'python-mode-hook 'flycheck-mode)
;; Javascript
(add-hook 'js2-mode-hook 'flycheck-mode)

;; ------------------------------------------------------------------------
;; Name     : helm
;; Function : 補完や検索をするためのframework
;; ------------------------------------------------------------------------
(el-get-bundle helm)
(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; ------------------------------------------------------------------------
;; Name     : highlight-symbol
;; Function : カーソル中のシンボルにハイライトを設定する
;; ------------------------------------------------------------------------
(el-get-bundle highlight-symbol)
(setq highlight-symbol-colors '("LightSeaGreen" "HotPink" "SlateBlue1" "DarkOrange" "SpringGreen1" "tan" "DodgerBlue1"))
(global-set-key (kbd "C-l") 'highlight-symbol-at-point)

;; ------------------------------------------------------------------------
;; Name     : magit
;; Fucntion : emacs git client
;; ------------------------------------------------------------------------
(el-get-bundle magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; ------------------------------------------------------------------------
;; Name     : multi-term
;; Fucntion : shell mode
;; ------------------------------------------------------------------------
(el-get-bundle multi-term)

;; ------------------------------------------------------------------------
;; Name     : powerline
;; Function : モードラインをオシャレに
;; Memo     : 別途Powerline fontsのインストールが必要
;; ------------------------------------------------------------------------
(el-get-bundle powerline)
(powerline-default-theme)

(set-face-attribute 'mode-line nil
                    :foreground "#fff"
                    :background "#FF0066"
                    :box nil)

(set-face-attribute 'powerline-active1 nil
                    :foreground "#fff"
                    :background "#FF6699"
                    :inherit 'mode-line)

(set-face-attribute 'powerline-active2 nil
                    :foreground "#000"
                    :background "#ffaeb9"
                    :inherit 'mode-line)

;; ------------------------------------------------------------------------
;; Name     : tabbar
;; ------------------------------------------------------------------------
(el-get-bundle tabbar)
(tabbar-mode)
(tabbar-mwheel-mode nil)                  ;; マウスホイール無効
(setq tabbar-buffer-groups-function nil)  ;; グループ無効
(setq tabbar-use-images nil)              ;; 画像を使わない
;; (global-set-key (kbd "M-<right>") 'tabbar-forward-tab)
;; (global-set-key (kbd "M-<left>") 'tabbar-backward-tab)

;; ------------------------------------------------------------------------
;; Name     : undo-tree
;; ------------------------------------------------------------------------
;; temporarily disabled since server is down?
;;(el-get-bundle undo-tree)
;;(global-undo-tree-mode)
;;(global-set-key (kbd "M-/") 'undo-tree-redo)

;; ------------------------------------------------------------------------
;; Name     : yasnippet
;; Fucntion : スニペット(テンプレート)をすぐに呼び出す
;; ------------------------------------------------------------------------
(el-get-bundle yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ;; 自作分
        "~/.emacs.d/yasnippet/snippets" ;; オリジナル
        ))
(yas-global-mode 1)


;; ========================================================================
;; Python
;; ========================================================================
;; ------------------------------------------------------------------------
;; Name     : py-autopep8
;; Function : auto pep8
;; ------------------------------------------------------------------------
(el-get-bundle py-autopep8)
(setq py-autopep8-options '("--max-line-length=120"))
(setq flycheck-flake8-maximum-line-length 120)
(py-autopep8-enable-on-save)

;; ------------------------------------------------------------------------
;; Name     : jedi
;; Function : コード補完
;; ------------------------------------------------------------------------
(el-get-bundle jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)


;; ========================================================================
;; javascript
;; ========================================================================
;; j2-mode
(el-get-bundle js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))


;; ========================================================================
;; golang
;; ========================================================================
;; go-mode
(el-get-bundle go-mode)

;; Gradle
(el-get-bundle gradle-mode)

;; Markdown
(el-get-bundle markdown-mode)

;; YAML
(el-get-bundle yaml-mode)

;; plantuml
(el-get-bundle plantuml-mode)
(setq plantuml-jar-path "/usr/local/Cellar/plantuml/1.2017.18/libexec/plantuml.jar")
(setq plantuml-output-type "utxt")
;; Enable puml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
