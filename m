Return-Path: <linux-pwm+bounces-9297-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sDX1LCcuMGo5PgUAu9opvQ
	(envelope-from <linux-pwm+bounces-9297-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 18:53:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2104688905
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 18:53:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9297-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9297-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B5A310BBFD
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9121440BCCA;
	Mon, 15 Jun 2026 16:32:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91140BCCE;
	Mon, 15 Jun 2026 16:32:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541176; cv=fail; b=Dh+oMVc9RQyPDiOHJ7kteduauk1ZTFPRBDTnZwIBpTFaHINF+i32VWv66APsktUaIZwhVIImC69xtS1Ga/mrLfa+jELS2UPHINi6gJvVIaihBlt6g+GQKPWl5viTx47TwJvYdvIzVtZAJt5MLcBQMZnm0WRfEbTFPXIm3EwJoj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541176; c=relaxed/simple;
	bh=Wyv5oJhwHsRNZdQdx1Q9fQNi0+GD82MUZD+/jGktu/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RetgEl/tRWX8LJF20V2D6NL1S7HqjwehiKCkKxgila2zw8HbFqcs0Z3ki+LSAv36uHk8BJL/RC3sYrMDczDpi/GjsEYEMJbG9BFvt0ndn/+3l8T88TVJSLP039SBYCPwU83/RRAps2Ga+xXW8sgZVZmCIYiiTkkASzJ2utZxM7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6CrTHBeUGUXV+X8Ie6oQ251K+0FpgZdKOU8lrl6ZBPm/09ejRhZFJxJkIp/LVkHP+E3k9TC62FFvttkijg/aJr2OpTRMOfg19EO6HHZCvkMjhtlHWQ3FcEppTTFujdnaP2P7fAKZwkAWT+oxrATe33uzJlfwZHHOWBlVaOuTULVTRHKzcW1BPU0PGFg2+oUmCt5wOQ6foSc9yTA6G5/6Qw89VD/7iq1Eu4y75vxlQB5Lv9ZOACQb+5EtR1ML9sHv5CUq2fJk787nmhewO+wfchvY4W1jGK6r/sq3gUb2AnuuTGQ8ay9v5fw2Qx3DjrG9lu0Tb4Q/X1+8j+9PCdBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTNSlTZLn7Qya3ROSCXtBsQ32VXnvsi5WVuWR1fIEn8=;
 b=gjKKrZVfmBTnRN6LlbB9+K/QWoYk70W3UMRF+K1MPSuqd2LgrZBCFD5hCsPmSORbMmrr5hdyWTaIusOGxTrVDgHH4zq0AksPT9A5CwK1fy6jBpiY/Jr7tRDC6esr4TJWEMZe5OMPgPn4uaxsItECwPniSoYGZ01bSUj3T5WD2NinNJwUrTuHuJg4FIWzaKuvscJw3r4IJpbYpm7m92YvNkq221G3S3jVkZK+mCjy5VgKjzL0ovAxP9Kpw1xfwpQeKBPh8a+64P9wzRU7NF1X1ic6KaP1QT82xQY8lMWOH8u0mamTYJ3Hp0HOZzm3QGuuDE3maYAU0znkGygDvwS+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1321.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:58:09 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0113.015; Mon, 15 Jun 2026 15:58:09 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v19 3/3] pwm: Add OpenCores PTC PWM driver
Date: Mon, 15 Jun 2026 23:57:59 +0800
Message-ID: <20260615155759.129210-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260615155759.129210-1-hal.feng@starfivetech.com>
References: <20260615155759.129210-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0065.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::32) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1321:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b00b80-524c-4965-4eb2-08decaf6e5a8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|38350700014|13003099007|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	H7zk05zyAtJIckaHd2Wy81Y59RMCgQliJR2R7JF8HPoJ/UtERMr2Qo95ZU+fiKCWPnneedOv7V0C5NPStkw8/2FdJX5y4T4pFZaD/NgO3yA8AEYQ4Nst2ln2Y4JauuNWSkTVYvaoSoS2wADjwqwNZfKlM5f5zd7MiSTYZEuOZys1+BdH56p7aTLqSfmRXcf6iWD4lDDAvHtt8AQ8ov/a4tPrc5FQeigTB19tZZBdyMlY9pWXcFto/4cUaExekawDja64WLWo21GPVZpb7SCKwp4lXYyERqymZureTgXhFnHR5FhvZ1vC6OhDKFAWSu9VcxzeBYc1w2ifkjR4bh7W14RlnrumS8VBiOg+TOOwOhwccZF/YZ6MXeV4LgjqDHyT7VvqSVSTmmqAvW62xBTq+KeP5R0yw+6onLI9cDONWoXQHYRraAyCoHEXJRNJWFVPuCvgEPlDED6j7Ccm1nNOd4IgXr0+6OyE6sLOA2EQmge2M9mJkgu6n6BkS27ioYG5hQppAieymDOXuP3GWE8KQzmOtXxYTKc8u994MJaEGah7cAxcJXtA/PmUcObtemfr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(38350700014)(13003099007)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6JvFx7cZ3bYhkptls3gZq20SHNzCF3n/Jrb8L3rKq8mX/4HCfdUXaso5Iz3I?=
 =?us-ascii?Q?45CrQh2tYKuQiDgKi79pLBIKjfQ43fIik/wb0iiir2iZdkZ8DFQ2YBDHOl4s?=
 =?us-ascii?Q?rBsfrsWNbbSt7Mo7HPQBExU8RJsQWxKlcskk72K8rwwB16MhE2jLPZqakYJ6?=
 =?us-ascii?Q?OZCFyQGTSRjb2j6WXnslS++7vywo0yiwMhqxK/1/+l2XcrCeFuGI05sKnxh5?=
 =?us-ascii?Q?Vy0xhw4Htj1DvR3KNgoK9U6DH9UW6YOBLsazeC5w/EoF2K/scdCiTXnL2tTt?=
 =?us-ascii?Q?gctQPxLtH3KoGOj+N1VUKUr6mqnYXioTb3AxnsBYvJA877FKSXmNkzWrvGZR?=
 =?us-ascii?Q?eutMjJScAwAI+gqXeUbMI7V3MLME+De/dO4euSSlXS0DJyw0fMw6t9vGTt/x?=
 =?us-ascii?Q?lAHQIkOAZynMQjuxIaqDEO9Pv7oBml5XiLk1pnt/8Y2UNw98i1kpZlbGWXdM?=
 =?us-ascii?Q?FOBQSkS7Q1CDByhtu9tQtkT0/Z5msmEbrqhmRbDL/tBSvibZJYcTdzZK6wnd?=
 =?us-ascii?Q?LDHR1p3ujSD4UtsF9kdqzoSsFyNmAzkqSeonaWOGzBuagmsNAjQkhSTNhFGl?=
 =?us-ascii?Q?rlkcBaUdkveWsSg4QZO7iL+zsrEhjpvtkM9jUNv+6mbbVEQWEJzmtlG2ElKr?=
 =?us-ascii?Q?qJV1wmclCxmjybHWLMpIwq/ZnIWp6XsG/6r4NvfwuMv75kypSBd9oXPvb+Iu?=
 =?us-ascii?Q?8/BtEzWkuo2NyY/1RWnII94zJihCI/6b/8lEW3S9dG4lyT1L9IEhvvJ3+nJZ?=
 =?us-ascii?Q?rCEkfXoYsoQAtvFdVGGcw8hbaslQF+xL0bRxFP2YastuSQEqsJ5yDclt6vO2?=
 =?us-ascii?Q?3btlrDw1GOqsV9RDRm+gZy6YdE8LssNoPydmCOYmHK9YZWyYS2XPPd1wz+RC?=
 =?us-ascii?Q?cpV3u8s5oYjXr6IfqejNY8+bUvb/HzPBodpgzFkCTsMTLYcI8VHVhiBipMoL?=
 =?us-ascii?Q?YGCqVAi1yyNaNzQmtWEsLbT1m1sbYLhKpw9VITboZoUreRUhjU6ICv7kDDtw?=
 =?us-ascii?Q?K+F9lQuZy0hVhj1RTiW+hTe3bctQPpcSSR/Tvvqok4dEjWL0MmsCtH7CH6YJ?=
 =?us-ascii?Q?w+DiCF51J+KNgJ5xT9ZJy8YzmIDxIID9pXAho0EkomjJ4Oe7YVKhGJUguFO3?=
 =?us-ascii?Q?UjN8nIr8U5G/07n++uSM9Y1iV/F8cDqkWJcQCah/NKKO5qOY2LG2gC71NCRb?=
 =?us-ascii?Q?Y298oT+//AVmNkO0JyIWK8VbO1L+ajyvZThtODrhyNva5SBsgdaGxlYI6Z7y?=
 =?us-ascii?Q?7+EHIMjFhkbBk/Bm08s4BA+kPJhVnPjIP98rppVXLGBvUipGpWMp4+07fscB?=
 =?us-ascii?Q?CDpSYhOA2DeWOsS2rEwbth9RyC+EEqyOcpbi6qQ0Y+EtoeH5MPrMmrbVBBYy?=
 =?us-ascii?Q?vA1+5dVjLY3/mJWzDgqyx07HKwGn1VuOXUFw5TTDSbGbCUyEEtVzTbsvG/qx?=
 =?us-ascii?Q?n0zQ3mlR2O7a85Zg/Im4sdXTxJDMKBe8UkkgABPkGZMubJCEU1nFIy4Xjsjn?=
 =?us-ascii?Q?l/7pJCzmLVASSJYYVMpD8YfWyUaADHBKUbxsgdLgBP3ghSrr8ryUlnjgPM4r?=
 =?us-ascii?Q?EDGAYNNz9fAUPz4NIfUKaaXXmeimC/qPT/LqL/TEgMe7Ey5lFkLpGtKLR9Nc?=
 =?us-ascii?Q?3i5MyJLxwYYwxuSkHALW11BmnfNM+3zNZ31gWRWk3n313pSMCyLhvYGslWQH?=
 =?us-ascii?Q?0sA1u64z268RtMgdCG7OJFfhhJFZU6oVgEFtAJ88oHxAeS8fFjcV3BIfpw3i?=
 =?us-ascii?Q?b2hGPMwZoO6VKDa/S4eGvzGctp/g1wE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b00b80-524c-4965-4eb2-08decaf6e5a8
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:58:09.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+Y0j84Qo9g2RdioVXd0HHD6v9u4ODrwfOztkAIvFUnwH4S4RN6Qp+sAnNJOa8MhJAltse1uJbl3TgTRKUtu6L3NuobaUu0WkirtRvb4Z/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1321
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:p.zabel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor@kernel.org,m:emil.renner.berthing@canonical.com,m:palmer@dabbelt.com,m:pjw@kernel.org,m:aou@eecs.berkeley.edu,m:hal.feng@starfivetech.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9297-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,starfivetech.com:email,starfivetech.com:mid,starfivetech.com:from_mime,saunalahti.fi:email,opencores.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2104688905

Add PWM driver for OpenCores PTC IP core.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS              |   6 +
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 312 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 331 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d94420eae3d..b6a004f2e6c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20035,6 +20035,12 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
 F:	drivers/i2c/busses/i2c-ocores.c
 F:	include/linux/platform_data/i2c-ocores.h
 
+OPENCORES PWM DRIVER
+M:	Hal Feng <hal.feng@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
+F:	drivers/pwm/pwm-ocores.c
+
 OPENRISC ARCHITECTURE
 M:	Jonas Bonn <jonas@southpole.se>
 M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6f3147518376..dd7f3bf5c3eb 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -534,6 +534,18 @@ config PWM_NTXEC
 	  controller found in certain e-book readers designed by the original
 	  design manufacturer Netronix.
 
+config PWM_OCORES
+	tristate "OpenCores PTC PWM support"
+	depends on HAS_IOMEM && OF
+	depends on COMMON_CLK
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	help
+	  PWM driver for OpenCores PTC IP core.
+	  For details see https://opencores.org/projects/ptc.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-ocores.
+
 config PWM_OMAP_DMTIMER
 	tristate "OMAP Dual-Mode Timer PWM support"
 	depends on OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0dc0d2b69025..2d47bad7bd74 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
+obj-$(CONFIG_PWM_OCORES)	+= pwm-ocores.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
new file mode 100644
index 000000000000..b126933d9922
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OpenCores PTC PWM Driver
+ *
+ * https://opencores.org/projects/ptc
+ *
+ * Copyright (C) 2018-2026 StarFive Technology Co., Ltd.
+ *
+ * Limitations:
+ * - The hardware only supports inverted polarity.
+ * - The hardware minimum period / duty_cycle of PWM is (1 / pwm_apb clock frequency).
+ * - The hardware maximum period / duty_cycle of PWM is (U32_MAX / pwm_apb clock frequency).
+ * - The output is immediately set to low when the module is disabled.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+
+#define OCPWM_HRC	0x4
+#define OCPWM_LRC	0x8
+#define OCPWM_CTRL	0xC
+
+#define OCPWM_CTRL_EN	BIT(0)
+#define OCPWM_CTRL_OE	BIT(3)
+#define OCPWM_CTRL_RST	BIT(7)
+
+#define OCPWM_NUM_SAVED_REGS	3
+
+struct ocores_pwm_device {
+	void __iomem *base;
+	struct clk *clk;
+	unsigned long clk_rate;
+	struct reset_control *rst;
+	u32 saved_regs[OCPWM_NUM_SAVED_REGS];
+};
+
+static int ocores_pwm_get_state(struct pwm_chip *chip,
+				struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct ocores_pwm_device *ddata = pwmchip_get_drvdata(chip);
+	u32 period_data, duty_data, ctrl_data;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(pwmchip_parent(chip));
+	if (ret < 0)
+		return ret;
+
+	period_data = readl(ddata->base + OCPWM_LRC);
+	duty_data = readl(ddata->base + OCPWM_HRC);
+	ctrl_data = readl(ddata->base + OCPWM_CTRL);
+
+	state->period = DIV_ROUND_UP_ULL((u64)period_data * NSEC_PER_SEC, ddata->clk_rate);
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)duty_data * NSEC_PER_SEC, ddata->clk_rate);
+	if (state->duty_cycle > state->period)
+		state->duty_cycle = state->period;
+
+	state->polarity = PWM_POLARITY_INVERSED;
+	state->enabled = (ctrl_data & OCPWM_CTRL_EN) ? true : false;
+
+	pm_runtime_put(pwmchip_parent(chip));
+
+	return 0;
+}
+
+static int ocores_pwm_apply(struct pwm_chip *chip,
+			    struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct ocores_pwm_device *ddata = pwmchip_get_drvdata(chip);
+	bool was_enabled = pwm_is_enabled(pwm);
+	u64 period_data, duty_data;
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (state->enabled) {
+		if (!was_enabled) {
+			ret = pm_runtime_resume_and_get(pwmchip_parent(chip));
+			if (ret < 0)
+				return ret;
+		}
+	} else {
+		if (was_enabled) {
+			writel(0, ddata->base + OCPWM_CTRL);
+			pm_runtime_put(pwmchip_parent(chip));
+		}
+		return 0;
+	}
+
+	writel(0, ddata->base + OCPWM_CTRL);
+	writel(OCPWM_CTRL_RST, ddata->base + OCPWM_CTRL);
+
+	period_data = mul_u64_u32_div(state->period, ddata->clk_rate, NSEC_PER_SEC);
+	if (period_data > U32_MAX)
+		period_data = U32_MAX;
+
+	duty_data = mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_PER_SEC);
+	if (duty_data > U32_MAX)
+		duty_data = U32_MAX;
+
+	if (!period_data || !duty_data) {
+		if (!was_enabled)
+			pm_runtime_put(pwmchip_parent(chip));
+		return -EINVAL;
+	}
+
+	writel(period_data, ddata->base + OCPWM_LRC);
+	writel(duty_data, ddata->base + OCPWM_HRC);
+	writel(OCPWM_CTRL_OE | OCPWM_CTRL_EN, ddata->base + OCPWM_CTRL);
+
+	return 0;
+}
+
+static void ocores_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct ocores_pwm_device *ddata = pwmchip_get_drvdata(chip);
+
+	if (pwm_is_enabled(pwm)) {
+		writel(0, ddata->base + OCPWM_CTRL);
+		pm_runtime_put_sync(pwmchip_parent(chip));
+	}
+}
+
+static const struct pwm_ops ocores_pwm_ops = {
+	.get_state = ocores_pwm_get_state,
+	.apply = ocores_pwm_apply,
+	.free = ocores_pwm_free,
+};
+
+static int ocores_pwm_runtime_suspend(struct device *dev)
+{
+	struct ocores_pwm_device *ddata = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(ddata->clk);
+
+	return 0;
+}
+
+static int ocores_pwm_runtime_resume(struct device *dev)
+{
+	struct ocores_pwm_device *ddata = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(ddata->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable clock\n");
+
+	return 0;
+}
+
+static int __maybe_unused ocores_pwm_suspend(struct device *dev)
+{
+	struct ocores_pwm_device *ddata = dev_get_drvdata(dev);
+	int ret, i;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < OCPWM_NUM_SAVED_REGS; i++)
+		ddata->saved_regs[i] = readl(ddata->base + 4 + 4 * i);
+
+	pm_runtime_put_sync(dev);
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int __maybe_unused ocores_pwm_resume(struct device *dev)
+{
+	struct ocores_pwm_device *ddata = dev_get_drvdata(dev);
+	int ret, i;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	writel(0, ddata->base + OCPWM_CTRL);
+	writel(OCPWM_CTRL_RST, ddata->base + OCPWM_CTRL);
+	for (i = 0; i < OCPWM_NUM_SAVED_REGS; i++)
+		writel(ddata->saved_regs[i], ddata->base + 4 + 4 * i);
+
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ocores_pwm_pm_ops = {
+	RUNTIME_PM_OPS(ocores_pwm_runtime_suspend,
+		       ocores_pwm_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(ocores_pwm_suspend, ocores_pwm_resume)
+};
+
+static void ocores_pwm_pm_disable(void *data)
+{
+	struct device *dev = data;
+	struct ocores_pwm_device *ddata = dev_get_drvdata(dev);
+
+	pm_runtime_disable(dev);
+
+	if (!pm_runtime_status_suspended(dev)) {
+		/* Balance probe's pm_runtime_get_noresume() for bootloader-enabled PWM. */
+		if (readl(ddata->base + OCPWM_CTRL) & OCPWM_CTRL_EN)
+			pm_runtime_put_noidle(dev);
+
+		ocores_pwm_runtime_suspend(dev);
+	}
+
+	reset_control_assert(ddata->rst);
+}
+
+static int ocores_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ocores_pwm_device *ddata;
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*ddata));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	chip->ops = &ocores_pwm_ops;
+	ddata = pwmchip_get_drvdata(chip);
+
+	ddata->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ddata->base))
+		return dev_err_probe(dev, PTR_ERR(ddata->base),
+				     "Failed to map IO resources\n");
+
+	ddata->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(ddata->clk))
+		return dev_err_probe(dev, PTR_ERR(ddata->clk),
+				     "Failed to get clock\n");
+
+	ddata->clk_rate = clk_get_rate(ddata->clk);
+	if (!ddata->clk_rate || ddata->clk_rate > NSEC_PER_SEC)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid clock rate: %lu\n", ddata->clk_rate);
+
+	ddata->rst = devm_reset_control_get_optional_shared(dev, NULL);
+	if (IS_ERR(ddata->rst))
+		return dev_err_probe(dev, PTR_ERR(ddata->rst),
+				     "Failed to get reset\n");
+
+	platform_set_drvdata(pdev, ddata);
+
+	ret = ocores_pwm_runtime_resume(dev);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(ddata->rst);
+	if (ret)
+		goto err_clk_disable;
+
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		goto err_reset_assert;
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_enable(dev);
+
+	if (!(readl(ddata->base + OCPWM_CTRL) & OCPWM_CTRL_EN))
+		pm_runtime_put_sync(dev);
+
+	ret = devm_add_action_or_reset(dev, ocores_pwm_pm_disable, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add pm disable action\n");
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
+
+	return 0;
+
+err_reset_assert:
+	reset_control_assert(ddata->rst);
+err_clk_disable:
+	ocores_pwm_runtime_suspend(dev);
+	return dev_err_probe(dev, ret, "Failed to init pwm power\n");
+}
+
+static const struct of_device_id ocores_pwm_of_match[] = {
+	{ .compatible = "opencores,pwm-v1" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ocores_pwm_of_match);
+
+static struct platform_driver ocores_pwm_driver = {
+	.probe = ocores_pwm_probe,
+	.driver = {
+		.name = "ocores-pwm",
+		.of_match_table = ocores_pwm_of_match,
+		.pm = pm_ptr(&ocores_pwm_pm_ops),
+	},
+};
+module_platform_driver(ocores_pwm_driver);
+
+MODULE_AUTHOR("Jieqin Chen");
+MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
+MODULE_DESCRIPTION("OpenCores PTC PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.43.2


