
CREATE DATABASE IF NOT EXISTS ${databasename} DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
use ${databasename};

<#list tables as t>
DROP TABLE IF EXISTS `${t.name}`;
CREATE TABLE `${t.name}` (
  `id` bigint(20) NOT NULL,
  <#list t.columns as c>
  `${c.name}` ${c.type}<#if (c.length)?? && (c.length gt 0)>(${c.length})</#if> <#if (c.nullable)?? && !(c.nullable)>NOT NULL<#else>DEFAULT NULL</#if>,
  </#list>
  `ctime` datetime DEFAULT NULL,
  `utime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


</#list>