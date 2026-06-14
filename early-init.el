;;可以将一些简单的设置写入early-init.el加快加载速度

;;set the default file path
(setq default-directory "~/")
;;(setenv "HOME" "E:/Emacs")
;;(setenv "PATH" "E:/Emacs")

(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook #'(lambda () (setq gc-cons-threshold 800000)))

;; 关闭响铃
(setq ring-bell-function 'ignore)

;; 自动全屏
(add-hook 'emacs-startup-hook 'toggle-frame-maximized)

;; 取消自动文件备份 "filename~"
(setq make-backup-files nil)

;;display mode
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode)
;;inhibit welcom
(setq inhibit-startup-screen t)


;;字体优化
(when (eq window-system 'w32)
  ;; 设置英文字体
  (set-face-attribute 'default nil :font "-outline-Consolas-regular-normal-normal-mono-18-*-*-*-c-*-iso10646-1")
  ;; 设置中文字体（等宽对齐）
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "黑体" :size 18))))

(setq package-archives '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(setq package-check-signature nil)

;; 加载用户自定义设置文件（包括主题 ）
(setq custom-file "~/.emacs.d/.emacs.custom.el")
(load custom-file 'noerror)

;;(load-theme 'gruber-darker t)

;;utf-8 coding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default display-line-numbers-type 'relative)   ; 全局默认使用相对行号

;;; 基本编辑增强
(delete-selection-mode 1)      ; 选中文本后输入可直接替换（Emacs 20.1+）

;;; 文件自动管理
(global-auto-revert-mode 1)    ; 外部修改文件后 Emacs 自动刷新内容（25.1+）
;;(auto-save-visited-mode 1)     ; 自动保存直接写回原文件，而非生成 #file#（26.1+）自动保存导致卡顿
(setq auto-save-visited-interval 0)        ; 关闭按隔一段时间自动保存
(setq auto-save-visited-idle-seconds 300)   ; 空闲 300 秒后再自动保存
