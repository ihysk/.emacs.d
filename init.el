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

;; beep音を消す
(defun my-bell-function ()
  (unless (memq this-command
		'(isearch-abort abort-recursive-edit exit-minibuffer
				keyboard-quit mwheel-scroll down up next-line previous-line
				backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; 多くの設定ファイル用のメジャーモード
(require 'generic-x)


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
(tool-bar-mode -1)

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

;; ------------------------------------------------------------------------
;; Name     : yasnippet
;; Fucntion : スニペット(テンプレート)をすぐに呼び出す
;; ------------------------------------------------------------------------
(el-get-bundle yasnippet)
(add-to-list 'load-path
             "~/.emacs.d/plugins/yasnippet")
(yas-global-mode 1)

;; ------------------------------------------------------------------------
;; Name     : Multi-term
;; Fucntion : shell mode
;; ------------------------------------------------------------------------
(el-get-bundle multi-term)

;; ------------------------------------------------------------------------
;; Name     : undo-tree
;; ------------------------------------------------------------------------
(el-get-bundle undo-tree)
(global-undo-tree-mode)
(global-set-key (kbd "M-/") 'undo-tree-redo)

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
;; Name     : company-mode
;; Function : auto complete
;; ------------------------------------------------------------------------
(el-get-bundle company-mode)
(global-company-mode) ; 全バッファで有効にする
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る


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

;; Gradle
(el-get-bundle gradle-mode)

;; Markdown
(el-get-bundle markdown-mode)
