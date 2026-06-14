;; 确保加载本地包
(require 'package)
(package-initialize)

;; scratch text
(setq initial-scratch-message "\
;; 1.compile mode and its dependencies
;; 2.EAF
;; 3.记录一些命令和快捷键

;; 1.更改字体：
;; menu-set-font
;; customize-face apply and save
")

;; compile mode
(global-set-key (kbd "C-x c") 'compile)

;; 缩进4格
(setq-default c-basic-offset 4)
(setq-default python-indent-offset 4)

;; makefile文件按tab插入制表符
(add-hook 'makefile-mode-hook
          (lambda ()
            (setq-local indent-tabs-mode t)
            (setq-local tab-width 8)))    ; Makefile 标准是 8 格制表符

;; 换行自动缩进
(electric-indent-mode 1)

;;; 没有ivy的时候很好用
;;(ido-mode 'both)
;;; 补全界面优化（垂直显示）
;;(fido-vertical-mode 1)         ; minibuffer 补全列表垂直排列（28.1+）

;;multiple cursors
;; (require 'multiple-cursors)
;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines) ; 为选中的每一行都建一个光标[reference:11]
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this) ; 标记下一个
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this) ; 标记上一个相 同的词[reference:13]
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this) ; 标记所有相同的词[reference:14]

(use-package multiple-cursors :ensure t :defer t
  :bind
  (("C-S-c C-S-c" . 'mc/edit-lines)
   ("C->" . 'mc/mark-next-like-this)
   ("C-<" . 'mc/mark-previous-like-this) 
   ("C-c C-<" . 'mc/mark-all-like-this) 
   ))

;;;配合swiper一起用
;;;批量改写buffer中的匹配项
(use-package iedit :ensure t :defer t)

;;搜索
;;ivy
(use-package ivy :ensure t :defer t
  :defer 1
  :demand
  :hook (after-init . ivy-mode)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-initial-inputs-alist nil
        ivy-count-format "%d/%d"
        enable-recursive-minibuffers t
        ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (ivy-posframe-mode 0))

(use-package ivy-posframe :ensure t :defer t
  :after ivy
  :config
  (ivy-posframe-mode 0))

(use-package counsel :ensure t :defer t
  :after (ivy)
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c f" . counsel-recentf)
         ("C-c g" . counsel-git)))

;;search
(use-package swiper :ensure t :defer t
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper-isearch-backward))
  :config (setq swiper-action-recenter t
                swiper-include-line-number-in-search t))

;; 选中拖动
(use-package move-dup :ensure t :defer t
  :hook (after-init . global-move-dup-mode)
  :bind (("M-n" . move-dup-move-lines-down)
	 ("M-p" . move-dup-move-lines-up)
	 ("C-M-n" . move-dup-duplicate-down)
	 ("C-M-p" . move-duo-duplicate-up))
  )

(use-package which-key :ensure t :defer t
  :hook (after-init . which-key-mode))

;; great for programmers
(use-package format-all :ensure t :defer t
  ;; 开启保存时自动格式化
  :hook (prog-mode . format-all-mode)
  ;; 绑定一个手动格式化的快捷键
  :bind ("C-c f" . #'format-all-region-or-buffer))

;;设置环境变量
(defvar cabins--os-win (memq system-type '(ms-dos windows-nt cygwin)))
(defvar cabins--os-mac (eq system-type 'darwin))
;; Settings for exec-path-from-shell
;; fix the PATH environment variable issue
(use-package exec-path-from-shell
  :ensure t
  :when (or (memq window-system '(mac ns x))
            (unless cabins--os-win
              (daemonp)))
  :init (exec-path-from-shell-initialize))

;; C-c C-o 打开ivy occur缓冲区
;; 按e进入wgrep编辑模式
;; 多光标修改(选中，C-; 批量插入)
;; TODO:C-c C-c写入
(use-package wgrep :ensure t :defer t
  :bind
  (
   "C-c C-q" . wgrep-change-to-wgrep-mode)
  )

;; 自动补全
(use-package company :ensure t :defer t
  :hook (after-init . global-company-mode))

;; 更好的文档
(use-package helpful :ensure t :defer t
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-h s" . helpful-symbol)
   ))
