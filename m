Return-Path: <linux-pwm+bounces-9504-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ycXzH2vIRGqg0woAu9opvQ
	(envelope-from <linux-pwm+bounces-9504-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 09:57:31 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E446EAE65
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 09:57:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9504-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9504-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79F08300D571
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991193BBFDA;
	Wed,  1 Jul 2026 07:46:16 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2113.outbound.protection.partner.outlook.cn [139.219.146.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864F7E792;
	Wed,  1 Jul 2026 07:46:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891976; cv=fail; b=lIEiEZ+eOkIv+q+U59P3Ejq5HVo8IZX3Wl8rUXixgk19+p1fce4fMxRvVU5GNIUQXGBnFLjfnTxpZvHvOybisz0yD5FfQfk+Vn5JFb2KGj0ATj8sI4448rCoPSrWj7PHCpR+YiXstfBArAeis+LT+7L/hBd24C2hlG3yOgy0l+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891976; c=relaxed/simple;
	bh=Oe6mAdaqDhTzEvkZMf1NXJPHR1ApMyb799tewMVREG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mSeJj3c3slDW+OfGLbkWHa02T7/bZbOtRzG41UKjYl4zCCyvonKncLqcibRzl/89/XMdz0MPkUqq7HyT/Qoe8rX1GNYHiHhg7x9qwJWfAP0ukrXR54fk/F4fm3mRg24Vp6N2wAA+Rxig5W4FFyGIkaVvXnRWe6jhsn6mNGk9LWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.113
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoyLGcSgp1W2vyNLOLsAiOJRu0mIfnn9WIigKFe+1gbHBep7th0fualvgEeDDtFBHnpeyYKsBnj2BUxjGLvuBY5hW5TNR3TP1DE+uaJ6I9v/lZIFLsqpK5XjlkyArqX4w4ft2QGd+TT8cT0mz7U94lthZ/fc6NLCKasJhFV1sWLju9VMvQdFmzXd+rt6Nmx6UAEz4/MnlCH3kqFCYv4we9IvD7FghiuNmmmC0YQrdP2WLebsNstcxxPonEi2ZtF2Jz7nYGlW215HnFDGAZA4pdOHSp+P2tnBqcJCVCSeOMb5w77JdmzyE4zLxmbBGhB2ntRPOIsJvxFXyTNBTwx4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmIJ4sfdGofEAgXfUC0E5k0OHZ893VTZTl37VPzIWgU=;
 b=i173QsGWMf+8zL0WJ/lC0kFG9UKHSrpvjqfsYI3Ed3f8u4Ghcd2g8ol7JfcHw3Ob5kKZClMHeBLiCT9jW6aDdFPqHuq5KPSCE97KHEbFQj+iw1+8Zqb4OTaJokPu9zl6c6EMuMFFo1jD/k/ZthdOOWCDDjih5eeSZejB7yAVE9xuh3PbuVXHIk5p/Gj5EUTsPZXf0JYkroHWPfA826TNX1WJn6RiGnD747e5ry+yvhW6aQeLUwdlNVGhw1aUuToVpqCS0lMZZ89iBwnkG2oGxZR1i7Uv3nuOFaACV8Y53l6r9L5Siqh0Fv0gf37T4NWXGJ/zj+RiTBbT9WgEx4TRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.25; Wed, 1 Jul
 2026 07:44:52 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0139.024; Wed, 1 Jul 2026 07:44:52 +0000
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
Subject: [PATCH v21 3/3] pwm: Add OpenCores PTC PWM driver
Date: Wed,  1 Jul 2026 15:44:42 +0800
Message-ID: <20260701074442.7714-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260701074442.7714-1-hal.feng@starfivetech.com>
References: <20260701074442.7714-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0026.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::35) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2929e2-062e-4ba9-06b8-08ded744a30e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|23010399003|7416014|376014|1800799024|13003099007|38350700014|22082099003|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	/NKVgXAraQ4zzlgXgQGMEfhYuFrrb5WqyebdjW8MFAwHOBgz3gqPc9JLPSAIywVDYrAsYXWTmtrruSGFKRGwBycBBlcYIx6rv1xS8LRZS1lqUTU52729lmyuBxZx1Lnsi9FQNBLa7rg1LwlfEHYokehyxeRhgiMqdos4ltaWbioYjRUZwLLhomMVla2WOsgdAIvO2SXX/M7E5Rno5RBiAq+hSYLBkYQquc00gHL6wZ3vkLMSQszgXlunrw7oMDABAAE7u2RpCnLUT9x5vg6NyeoEBK1gunJz4iR770l2aXMGxx2rc206uGWV8zAxRoHGKckLKIIa0fFv9y1Y76vDn1mSYKpERhBpQgEZmA9veF2/nxb9y5TJm75koiNJC8AAx+K25f/Bl+fdSqUqIiEHuL4w/uAszYGuWU/i7NRxU7adU7q4ttPfmMcGexZyAuUQDkePUAlDKj9pR3C5pn1ThKF6CHSf7a/ODJjQY+/uZFaPmCTiNdzbHC51NY6PMuoqmI4OQRGL8fxAdFg/tY0qlK+pHhjtdaItheEZOFO8lRAEk0UrCo6iTSh3Aix5o1K/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(23010399003)(7416014)(376014)(1800799024)(13003099007)(38350700014)(22082099003)(3023799007)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BAK4WWA/e8kYVg7Qs2R6GUCNGcEgnhUIoPv0zptEIcT3d++nYMM5Pbh6YDjD?=
 =?us-ascii?Q?NlLoBObkyce+/IpUyt/x8d1I990vFVmAJpMIRvsgXqcsPQCkEAMofgaJbOwW?=
 =?us-ascii?Q?F6OrOuzWt9xL4ZVJ9glMLaI45p2YfTG/6FI8e9Umnn6Y7yCU2QHSYrkYHdF9?=
 =?us-ascii?Q?DP10HiKjahoph9KxrvGBhI1yDtB0ghAXZToaJfeJq7m1DqfhhMtSZ8J7Ttru?=
 =?us-ascii?Q?WXWs16YIld5vL0I/GRQxP58dshzMn5TwJPMqkvSJ1JLot8FGtqWKY2ur7Ter?=
 =?us-ascii?Q?xH2tG3co5rv4Vr9bGM4tqe2pC2G4k7QWzB6qbYl4tiKb66OcxQsR+ugk3Cvk?=
 =?us-ascii?Q?IE4Fzt9KkYeb5BjesledGseO4kXP8VdvbZ/1xZRAtlzPf9lTPSlUL+CSQ40d?=
 =?us-ascii?Q?euJqQ8YKPg5T0bcGtD2x6ZLZJ/7KtfJmPUFiW9Jub30JQVrPPgvllT004IlP?=
 =?us-ascii?Q?NK+xAgmFGAw60Tva9AS4GeVOXKdgaeD+Y/d0h9s+ahSV9V4YjpLbsZ2dhxKi?=
 =?us-ascii?Q?sZSFhB5V2yTyFY81bjNKVeDozfV8GzxbsrHPJGmSVnS00XZ7E6kNfQwhPfWN?=
 =?us-ascii?Q?PJbpAxLh86hObIXuisneu2/nYgNvuAnk0mdubds4uHoY/4z/IMrQpTP9nktc?=
 =?us-ascii?Q?ZpIemUqGXBCaE2LHGb0BQdd2Ljpx5gnUKbS6pypED4MukL/IdfI3+K0gJRHG?=
 =?us-ascii?Q?lSdGe4iJqaBk0fOmytIEOOrmKZZYNXgd18CvJOTR+7fsedXpmyqV7fCh56/b?=
 =?us-ascii?Q?MQbmjSNptWGp9yOY40xMdPo02/3fjbE+uxnW+6XOjkyADkzqsCtw3v8urG15?=
 =?us-ascii?Q?80yZyKPWicPMhsq8A3owrSIbLqIibm2W5p9MQcxyYdTACoJ4doBpLnGuQAvO?=
 =?us-ascii?Q?nY8SIZURLrfei2RNvrLSsBe/K0XqS5VJRCZs1O3BK1lgCZ7ZZ7zZ+Chh3v0I?=
 =?us-ascii?Q?ZsYWsYKNDeAzLyuXcvEr8wGjDtFvJY3sqCFDkYKJY4cP9zrIw1NasSAkqzXX?=
 =?us-ascii?Q?TntePzh/aF00OXz0rHX41aI0XCcqrT69N801yOcphv1wIpQIQw1TTgZhG8Jv?=
 =?us-ascii?Q?qjaVh+6oQyp/zy8sXuI/1DVB3PZKnWnhw1kZ1X8Hg+R+3GYBfMTqxCF5SBAC?=
 =?us-ascii?Q?pdg9Em9Ey2RYmquEWplYz1h/9s0aJrbCndKI52iA5FzL0fhJb47YuJ0LnF/C?=
 =?us-ascii?Q?02sF4Udo4dtEnVnmkndgqptZi3SisDBJHMk3E37KMwW4BU7UMuweeeaCrODf?=
 =?us-ascii?Q?5SWflXW8qSH9zwwXYG/I/PjFixzIoJUjNEAaKCxdyrOYpTlGMSiOEuFOGMs7?=
 =?us-ascii?Q?PHr5SHY1mRcP0CTzsO8APvWiVvYW0Mi79Y4YQY5wJedw1e5OyPvBABtN4ioH?=
 =?us-ascii?Q?LLOKJGFx6na2i5yEZP22/TBMEX9NuLLfkODvcorCEwko88/cPvwgtsZFhPXN?=
 =?us-ascii?Q?E7oAmsmNCqg5YKKy93hjfMHAS1Ap3Eob5N1SORHQvuZ5l+UzPrH/eQ3Cnw3x?=
 =?us-ascii?Q?d6fzkXh83ETux0AASPHzAg4xInrRKRApU8mFfSWYL+ng2SQx4/8kUCHTlSnG?=
 =?us-ascii?Q?oFV85EA//nUOA8IJ7T3TYGhv+I9Aqdwpk26aVcDZvOEJ0eTqSU1FCOtsQTVC?=
 =?us-ascii?Q?YsyoULEebcMf7NJhe2FNqsKTDzX4LSS9lCXaFwOZYBbEi5zqSArMbBHj9ZCi?=
 =?us-ascii?Q?GkJrCe38dG8OwKXsP8DPNoQ6Xwju/ZZH3GwJ1S5sGoQckJAWw7Y9BBBjoVml?=
 =?us-ascii?Q?BwSJuIsy0LEJkZVBapwDyViS+8syIZw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2929e2-062e-4ba9-06b8-08ded744a30e
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:44:52.7618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcJ7aArL1/1CdaYF5yDlYkAgFfBk+KfO6msaPZdldxiLIdEVt4bDs06Zszi1Zd76rLoZ56ghFl/f9/cBycMdovfvmjfoPlhEQLikDQzi/sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1307
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-9504-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,starfivetech.com:from_mime,saunalahti.fi:email,southpole.se:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,opencores.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69E446EAE65

Add PWM driver for OpenCores PTC IP core.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS              |   6 +
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 309 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 328 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..2ff33cc9ca39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20270,6 +20270,12 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
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
index e8886a9b64d9..1268c07d07f1 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -546,6 +546,18 @@ config PWM_NTXEC
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
index 5630a521a7cf..4d2d14c4852f 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
+obj-$(CONFIG_PWM_OCORES)	+= pwm-ocores.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
new file mode 100644
index 000000000000..297c24d5805c
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,309 @@
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
+	if (!state->enabled) {
+		if (was_enabled) {
+			writel(0, ddata->base + OCPWM_CTRL);
+			pm_runtime_put(pwmchip_parent(chip));
+		}
+		return 0;
+	}
+
+	period_data = mul_u64_u32_div(state->period, ddata->clk_rate, NSEC_PER_SEC);
+	if (period_data > U32_MAX)
+		period_data = U32_MAX;
+
+	duty_data = mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_PER_SEC);
+	if (duty_data > U32_MAX)
+		duty_data = U32_MAX;
+
+	if (!period_data || (!duty_data && state->duty_cycle))
+		return -EINVAL;
+
+	if (!was_enabled) {
+		ret = pm_runtime_resume_and_get(pwmchip_parent(chip));
+		if (ret < 0)
+			return ret;
+	}
+
+	writel(0, ddata->base + OCPWM_CTRL);
+	writel(OCPWM_CTRL_RST, ddata->base + OCPWM_CTRL);
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


