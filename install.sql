CREATE TABLE `t_task` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用戶ID',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '分組ID',
  `task_name` varchar(50) NOT NULL DEFAULT '' COMMENT '任務名稱',
  `task_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '任務類型',
  `description` varchar(200) NOT NULL DEFAULT '' COMMENT '任務描述',
  `cron_spec` varchar(100) NOT NULL DEFAULT '' COMMENT '時間表達式',
  `concurrent` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否只允許一個實例',
  `command` text NOT NULL COMMENT '命令詳情',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0停用 1啟用',
  `notify` tinyint(4) NOT NULL DEFAULT '0' COMMENT '通知設置',
  `notify_email` text NOT NULL COMMENT '通知人列表',
  `timeout` smallint(6) NOT NULL DEFAULT '0' COMMENT '超時設置',
  `execute_times` int(11) NOT NULL DEFAULT '0' COMMENT '累計執行次數',
  `prev_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上次執行時間',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '創建時間',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `t_task_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用戶ID',
  `group_name` varchar(50) NOT NULL DEFAULT '' COMMENT '組名',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '說明',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '創建時間',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `t_task_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '任務ID',
  `output` mediumtext NOT NULL COMMENT '任務輸出',
  `error` text NOT NULL COMMENT '錯誤信息',
  `status` tinyint(4) NOT NULL COMMENT '狀態',
  `process_time` int(11) NOT NULL DEFAULT '0' COMMENT '消耗時間/毫秒',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '創建時間',
  PRIMARY KEY (`id`),
  KEY `idx_task_id` (`task_id`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `t_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) NOT NULL DEFAULT '' COMMENT '用戶名',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '郵箱',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密碼',
  `salt` char(10) NOT NULL DEFAULT '' COMMENT '密碼鹽',
  `last_login` int(11) NOT NULL DEFAULT '0' COMMENT '最後登錄時間',
  `last_ip` char(15) NOT NULL DEFAULT '' COMMENT '最後登錄IP',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '狀態，0正常 -1禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `t_user` (`id`, `user_name`, `email`, `password`, `salt`, `last_login`, `last_ip`, `status`)
VALUES (1,'admin','admin@example.com','7fef6171469e80d32c0559f88b377245','',0,'',0);