SET NAMES utf8;

-- ----------------------------
--  Table structure for `BlendEvent`
-- ----------------------------
CREATE TABLE `BlendEvent` (
  `ezcontentobjectattribute_id` int(11) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `start_time` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `recurrence_type` tinyint(4) NOT NULL,
  `month` tinyint(4) DEFAULT NULL,
  `day` tinyint(4) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `week` tinyint(4) DEFAULT NULL,
  `sunday` tinyint(2) DEFAULT NULL,
  `monday` tinyint(2) DEFAULT NULL,
  `tuesday` tinyint(2) DEFAULT NULL,
  `wednesday` tinyint(2) DEFAULT NULL,
  `thursday` tinyint(2) DEFAULT NULL,
  `friday` tinyint(2) DEFAULT NULL,
  `saturday` tinyint(2) DEFAULT NULL,
  `range_start` bigint(20) DEFAULT NULL,
  `range_end` bigint(20) DEFAULT NULL,
  `interval` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ezcontentobjectattribute_id`,`version`),
  KEY `idx_range` (`range_start`,`range_end`)
) DEFAULT CHARSET=utf8;

