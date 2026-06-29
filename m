Return-Path: <linux-pwm+bounces-9456-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rcmgOP4dQmoL0gkAu9opvQ
	(envelope-from <linux-pwm+bounces-9456-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 09:25:50 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 472756D6FA9
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 09:25:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9456-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9456-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7CE5300879F
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 07:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBDD3B47EF;
	Mon, 29 Jun 2026 07:10:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BBC394780;
	Mon, 29 Jun 2026 07:10:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717028; cv=fail; b=WHcGGLDYbC077z8Yh3tCGnHpQtLZsBIsfhiQxCpCSPTFAsW55Iyxo2jAd7ApfmOvqhlB3DklPWu94QgbMB6IzmqMqh+ey25nWkYSVOovzEl1zKCDzcXjYNhYB88p3EwNOT1/2mrPMp/7IgqTYE/JlYoAZw40/UmL+2G7U1e/oWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717028; c=relaxed/simple;
	bh=gwA5ILdejuJLgzdu8v5LtLoUcVc7PuHd0BS+tzDzFPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UT5rsbddyMEMGOzm0Q+N50z5v20Xl7znxar+CVc2fPDu/eBy8pfp7ugNXVSjPmWY+eEwoDjV/oE2XJIvbbq3GJ2YjO2s3WFCOMddfr/AlMtd++XN52y9y+lNkfw56MdmcSJv/6+Yov8jJ3a1F6sR6DwGllRZJv0giMnu+yP4TOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogTc3dLyWKSmvkIXhOVCY87xH0HpxiEvsqHWnz1yY4It1iSRqq9dSo89z5rKlPXgjX2QPwzm6Qndq9MMGnH7FtFbygkKoHGA872gR99QT+ZWnBLBVknqUu8p4Q/1aLbEv6uLxJSDC69hDzjuhioq2rD94Ya1d+edkqPSv9boMJ0ErBpPUv1jDPg5hWqZIMdzn+35oAtgxEmdvBPcVZ8ElyhTE8n+uLkSf+2i70hObLh1APFyPnQsPmNyl4bJv2qC1pX+hY61rVejUoms6dvnyyqqvYq86H135OALLt0DbPG6tKudmJQ0+NxUyRwTj55dRmWlu75pXfyAL6DLY1ELHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhyTJB8MUrSO2/7NQwiMMB6EYpwacjXhqPth5awCXcc=;
 b=gohykrA7AGOmjxy6SB6ZqvIiP9fhmXpxkB8YDonlvUkmaHqWzq8tVAWCSisMCmHC3CS54UWb39y1PNI9LevQ+pO/LVKpjZlhF+ZWLq1XNB9gCyA6ckqv2E0pUm6Orr0NUZMwlUdFaG4QhXz9TDQFS4E80aqn39l0aa1PREet4HGkxCB4VK+v4HCBV5m6MqevDQUG7GsF4ZwjGLPjP8FcvWLGZExCLJYiawinDQrJ9KPCNr4qSpENt9Y4DsnX92MgyUfeEODbBvpTT+9XO3JE2xOd93M4jzOo8v4wZsaDScMoKajSswEZG9uHZPIcjCCq6Snzte2aTvm2wQZloQziJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1323.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Mon, 29 Jun
 2026 06:36:11 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0139.024; Mon, 29 Jun 2026 06:36:11 +0000
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
Subject: [PATCH v20 3/3] pwm: Add OpenCores PTC PWM driver
Date: Mon, 29 Jun 2026 14:36:01 +0800
Message-ID: <20260629063601.63917-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260629063601.63917-1-hal.feng@starfivetech.com>
References: <20260629063601.63917-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0025.CHNPR01.prod.partner.outlook.cn (10.2.0.214)
 To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn (10.2.1.78)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1323:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f1367c-2de8-4416-1c2b-08ded5a8b5ef
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|7416014|38350700014|18002099003|13003099007|22082099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	DjUze9as3anE7KVMCsoklsCHJ471iJ81nOXZvUDWQHWYbpnSkjE3M+Lc+v8Dbw2Z2C6IPQp4pdhFJIlw5Z2gz6m74aQXZbe2z11fx/kOwP8I9n6r1cZXsvB2BFrZbw8bO4Nb35UZ9vklTgAGuZ2j5J13EiEKtCe6V0Eez1ELS8vyGHNXnePe+7uhQfifmZhjCcvEjlI0kgnGT/jCVIAKbsUK/0gdLWFQWWEiSLkWc9dKS7LVhb11CqeRDinWY5S3fJe4xRWyb6WZmJX5HJkSEJTpEK/uHtJXyAVWeKbuTK2K/P3X1nYL9RMPtsXOlV4pkYn2qpeDs8GUL1/SIhfpX2meP5t+i9Muc4/J67Bk7CJirUr50mXZ4klMxGHrzgio32aqdpKe4rR1XitxYZcvP6GTkLQJL/8/3rY2nPGXNwuueY9B/INy3XBnR2qxFD9pV3pV3MAST5GTU6luROrMKDRYrzD+m/7/x7Dg04wzZ+W+FmeR7sFqoWE43siezv/GB5a2u/8MhHkoMf+CBtuauqbYPGMkzQqBsf0aBW32JA0W87mVZH/pnyIJk3p6MtN2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(7416014)(38350700014)(18002099003)(13003099007)(22082099003)(56012099006)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ajTCIvrq6Qnynn1EG0dAU1y7Hr/J41OEx1RyRQtzXmD4QQWsxqI179e23Vm6?=
 =?us-ascii?Q?3b0secg2dZOa+zeXPAm4pY/R4PqBaM+Uiq3WmCLbZAUi+DmpsxNTJitWcq5Y?=
 =?us-ascii?Q?5CcPoEBAi4uwXLebBh89NsDRD4JasgGVZn1KpjeSGIIef7x5rY/m7jOCp06h?=
 =?us-ascii?Q?9Jx/TaGfF0tcHuNbBpZSbB6DKBiEEJlR+f3yll7DgVsHa4zgNDgBWtI4ZbjH?=
 =?us-ascii?Q?IK/o9BnVMWuyyx1WLTZcSpIeNWEJDipboQE1+G+InpuXz1XLfgF3/SejKbSG?=
 =?us-ascii?Q?0uiS1Dw2oJKViNFatkNPc6itaOS8vxaCRw1+ZVy79du6sgqotdLknPweU+Nn?=
 =?us-ascii?Q?lP90aB6VHkPMScrFcfpGhldxTZwWUIEN3w6ZKrxAogIaaoIX/p5WVn6j8yKb?=
 =?us-ascii?Q?Asa3EM4vyyHb/l95KJP3miMeEt6RPhBMC9YJO3NzrUVLpAz7/RhJtjteokGm?=
 =?us-ascii?Q?lzwjwUbrjTGpVmY5T62jjdWBEOm32b4ToSrukXsQacVwwrIriwpie9KSyM1J?=
 =?us-ascii?Q?op1qFgvzifswZZzA/JqPcB9N7UZVqVht69+VWX6t9BZAgZLgRHOi13eZ2L0a?=
 =?us-ascii?Q?qjWv51SmImp0abYOS6Z28k6Ga24l7ZgOanL2uC6jjDl3APevsuiDN/HUfJ+k?=
 =?us-ascii?Q?u47eOHwcwp+UvdAmJUZzpjPbtRcUWtnHiMdHNLRDTIL9tSzzLEDvf9XGjIRf?=
 =?us-ascii?Q?EuIqFDqMcQyfwkzxKE49MZiUKufmEJtG3sb0SOuVtwc3qOQNr4DAwpQUE2LX?=
 =?us-ascii?Q?BhYpgv5IHMuOoOA/qIyeU/k+F204IySwC7iIeQdkSzdUPHwfOdIdYStbBYwK?=
 =?us-ascii?Q?vmNtpULFm30ZQI3R4tcjaoGsN8FDVWDGBXq56LpShVI3xk4xkrE9hpqpR/ht?=
 =?us-ascii?Q?VhYyKTZhadhTAVdvp6CRh5WTPT5sSw0owgMHvLR/X947S7iqcbjq4LT3Nlwc?=
 =?us-ascii?Q?dLEhUGdv4kc0xRZzP/7AjGGV0Jwh7SzNzOCK58SWUp/sz5+zfGkekn2JlmQW?=
 =?us-ascii?Q?Uuuk6dPenWr6ztelhYjgNKi3/BUswNOLx0IC60W9AxBhuZQww4zZsUICRyvh?=
 =?us-ascii?Q?HdJQWu9AW7fvSfde2bRFBDFvcVUiJ3r2dQfKTHx09ylp4jv02VBn1X+2Oqgw?=
 =?us-ascii?Q?MzRJ1w8ntmYwSr8ii85Fk5eCfwfxrthZ7YAeR56flGYRgYzlB4N20hVmlDnf?=
 =?us-ascii?Q?X9ekE46XwKcneONbLC1132v2aFN9Z5Xd0s7R5O33YZwN0UDfehKGW53mF6Vk?=
 =?us-ascii?Q?2fstEF3+MfEXlUF2B81y30BwlibyqK2LC+ucmC4diDxNk+Nzh3VwxXXTytMm?=
 =?us-ascii?Q?u4RKF9pZZQoue3V9kTOrOIwTKYYz5Lv/og5lQcjKOUbFmhjqS1cK8np3x7Sj?=
 =?us-ascii?Q?TU6NpCWlYL3ZkEGAxChXw4QBC2QZ21AQ9tKqp35Z+8SFCAFUxqUP5YL+RoDg?=
 =?us-ascii?Q?GqN7g6YgCrGC5TJvrGSBZ1+ZM5xkxukicQj2U0FLA2Gf6mCNGJ2VGqNBMb0V?=
 =?us-ascii?Q?Ne23FcA6GXGUSYPw6byVxLuyiYSTjTFZMomvKst0OyXj1z1ZNVuQEJtc5HLP?=
 =?us-ascii?Q?/KOIKXBlK1JxEOVU2DlpYfl6lbwSmQk3h2y7RS/KVqlbyZ4NtvmNa8Ml2g+2?=
 =?us-ascii?Q?w4uBGy+IbfOvlRPzvXVJwBntct8fZdLKb2uQqQTubQzUNMHI7VOrfWnZdiB2?=
 =?us-ascii?Q?zFtkfqgATTER05nCan6k5/3znomX+M5BR31Y209+0c5F1ZbD8Wj48HdcdSee?=
 =?us-ascii?Q?mKj54Osxw5bwCyvKQaD81bhYKBu7KpE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f1367c-2de8-4416-1c2b-08ded5a8b5ef
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 06:36:11.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFmeK4jEV21eMPsjvo25HQc2HjoVG0UhNfQY1HxhIWw41PBUbMfrpb45ZhffXOzltfJ8MOqgKK5AcOGmiU/F2NuJavX0rAfAAm7ttZeDQS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1323
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-9456-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[southpole.se:email,starfivetech.com:email,starfivetech.com:mid,starfivetech.com:from_mime,vger.kernel.org:from_smtp,opencores.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,saunalahti.fi:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 472756D6FA9

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
index 000000000000..e01494a33633
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
+	if (!period_data || !duty_data)
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


