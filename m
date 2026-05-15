Return-Path: <linux-pwm+bounces-8878-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGCcCJu2BmrrnAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8878-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 08:00:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C485A549D4A
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 08:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D207430778ED
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 05:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7D036999F;
	Fri, 15 May 2026 05:48:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2093.outbound.protection.partner.outlook.cn [139.219.17.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9ED357A40;
	Fri, 15 May 2026 05:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824135; cv=fail; b=PMUGtlFOhOHQiHXOj+cAk9CJeZjn+ExuFqWYFepaYsd2zojil1zoP8ld82hByRR3c2tbMkyosaQQBvRDyAQHewOmaypBg5j+c23toEWFPTV07tj0ahXCCNNkYoomWx4KU/hBx56QiyBfbj9Vbrm5nZ4wh97gaGgp75VkT3CDt+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824135; c=relaxed/simple;
	bh=wzlg8jr9UzZybZmk3buMCxSpXkcMzEI4MhBbbvIpyBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DADlGXPeEclNaeMPNc4FCaMCM9Tm8b48d5tL4wNmKO4YPMd+n+gJ32chjwdn2kMIPt2DQKC4rWiFOifAols9N1cyAsOJNiXsh9D1Of1AIN3eZlYlnOWQELDgHQIUIiKPisXbkhxSGRdi7AOz3Ox0BaX25KVvizmAkzC1WE0pnNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZFpP/1vnaMawTshJkug2yHznX73WsQ2kWUU9mV+hx4ouB3oBCfTDftqG0xZ0uiQC6359kGxp0Ppq+lSfEqP3BVP/jC5zRBcEMOF63ZVGaPfk+99xouV+bgriayW0iTHVa8Biv+fUi4+NTRIv3vHwE2L0H+Qh8dH8CEcgYyyUw66r+FuL5vIDKyHg2U7/0a950v/P5q3LYpf9z9MvqsaPrubN5BkobzVtqLUbHHLSdeQ4oEWWCJ7RbP+PDwFlU6CfYRegCnkxCy6lefzzp7EWEhb7sgnO3X1qxXDiP+qtpx+z30WYquzDLlewjC51TLckI/DAf4r23rorRUCfxYTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OivD3rqodpHTLCVPIlZiEbGvMcTPZG5rEDwZdFQa/DM=;
 b=Oc2yhB9a2ddLv9Du38yKltwEBsftLHDxcFSPTJZCXz6vgQSpLlwdbyTMcYKesnlX8XK3SrEJK8b1MiX1pKZzg4eUnBrYvBGphQ0oyQk6O+YEJUL8hQobld54J1Dpjamv15zU7wUYVTL63cuXAwMFs7bU/USwlSVtEZ1FJBLSUbp/lKx2elN5NpZj3KpK8RBSPDPwpJ8wBIz8jHpDqJfOdW4ucKjinLEXVVDIkOjYCWVU3wiMGYvW9IXkIfJwHpqZXVD+JTRWRN1Kfm7FZMhG32KuA+MhEEtFKK8rw0LRS3iUxuMz2FtqMVbi8iufINAnx9o+Oi3B7UMKPMV1v77hfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1276.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 05:47:34 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.20.9913.009; Fri, 15 May 2026 05:47:34 +0000
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
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v18 3/3] pwm: Add OpenCores PTC PWM driver
Date: Fri, 15 May 2026 13:47:22 +0800
Message-ID: <20260515054723.25024-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260515054723.25024-1-hal.feng@starfivetech.com>
References: <20260515054723.25024-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::22) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1276:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1bb34a-4fd6-425b-5554-08deb24576a4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|56012099003|18002099003|22082099003|13003099007|38350700014|3023799003;
X-Microsoft-Antispam-Message-Info:
	5zLsvayno+h3nRiQ7BiMFjexR1Sxz4VjSjK8qGSjgsdQDyzS2aS1loinpBNeSI4A6gTAbGv1DfSORTsB8gI6ub823X/pY7nKUP15R+OeA2W3difDDePGExP6FzFSmxWNwWg1+wwdMYpVYbFq+liIsdptoHegktgqH1UbfNjpE0L8XwMufzfJs2Whu5oRkfu/PRkBebYAGY0aQZ+ytL+DCZgzqJlMgsa9rGJlzbA+BrCueDDQ7mok8pIGghqoCUglhOaBQX+QjBTb8iVVmIulrjyiFBUEKN/MmQZ9mcPX2c0iOjysH/lOKdU7BRhf4FOQ5L048uV+In3boQYIzWjj6EayPAapRQ7rZBHu50Kj9LdsLZCp9wE7CCmtlwpuVKMRfIqAKjOX8+OtDwQamrUEEQgBR+ndehEcU2kYZHuKRp6+2IPt+pimQKrMqokpp/nydUUVH4ehnqblWmkpaYf0FqKwCwjhQzb8ixHYEofsa+HjO8jl2oIFux+f5YQox82N33Me7PZcI2nQ0dRHgktgi7yVtThLiJyjonlYySeIx/QuAeTxKonIZgqTpdO9/0bP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(56012099003)(18002099003)(22082099003)(13003099007)(38350700014)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zQ8tPd76SvGIQooECcohFPeNWveL+Wr+1KhuWGwNDE1sU8kSfCEyEXlG6VDa?=
 =?us-ascii?Q?vG+OtqA/4ULI/nwC7LZnSFLOOYpwOpxbAQwg0Bhk5UvzNTct3Z3dKrmP1U4G?=
 =?us-ascii?Q?OikgOjNE71CBrZre8vGDYEKeWE0XFVt3xYrdCKms6csvcpUWGbz/LYn7Rt1l?=
 =?us-ascii?Q?MPlgHGNumfQ61bpIB2Z8oUs1pKQSBuQjJqHvgfJUs/avOaps17wuj8JDofwE?=
 =?us-ascii?Q?DBDWU3FZ0sdVx20lzXuTHI9M2jdzmRfD2aXPplNOkwHaDsaCX9inBK30TJXy?=
 =?us-ascii?Q?XWYwK7kzEHE+x2AXrWCz+JR4/cWqbbDndvBX1oM/31jwFAm9nnaVXPLH/rcu?=
 =?us-ascii?Q?DHGE77o+5ecJuqqqn372NwqzxQXkCx3vAmsTgVdEVNzDT0eQiLIdni0zLILA?=
 =?us-ascii?Q?y5sWI382fsoj7l8U4Te+xC5jhbmnfiWdngHiYGTYk0YeS4mnKrXHJv3vZ5J+?=
 =?us-ascii?Q?HnHrhCd1Viv53ribNvlS7gt0bQPgs1YdANIVjDzDCar/SxWpS51yVZozJ6Y5?=
 =?us-ascii?Q?NVQMdKCrUEQytx2QzqSsIyIjV96PteQVwQ6reg8bsBD8W5veggVeY1HY6HIP?=
 =?us-ascii?Q?6JATZ0ar7vC8RHqkL8Zr9bp6TUiNlRGMxyTkTvqww5A8GiP9K1AkJ+ZU8Dxe?=
 =?us-ascii?Q?SsKTS7PASDMFAxUCk69nkmiGqFjyYmXkx0nHiZfyG+e1rjSc2QskKRH56/Li?=
 =?us-ascii?Q?x0WLO2M0+/9n8WZ/q2YXvi6O57DSeJNxK5FmJT3vPx8q5EB3gmmOC1uqF+ic?=
 =?us-ascii?Q?uq6op+zZM55mdz7Kb6MXN5sEkoUfdsLoi8X1+AB5/6Eppw3mxmMyul4h0XGm?=
 =?us-ascii?Q?a1jhfto13LLrGIHHSHEK5ifpqzkXPGpX/jUmyLck0hthbEef1g9tb0HPJohH?=
 =?us-ascii?Q?1MIIfzZr97WFeJY7NY0UarrDvEJKKOyqdnL4egadW73Oi05IlWh4Vfr7F/X1?=
 =?us-ascii?Q?iAmn2DZ65PSX4A36kfkZxL2cQYJK8WauC9rm4V3YBJ7OmxRQkW4N5jsVr0Le?=
 =?us-ascii?Q?+slCG8k0UtJgKApikx3oPelLlIijORnVaO/je8GxgiMBx2kBUFGWjboYgVzC?=
 =?us-ascii?Q?WttNllKem2XIyGaMLqVUJxXqjzCuCsxYb41H3MXaUoozZRyWZSIcuIcIGC3c?=
 =?us-ascii?Q?4htz1K63/9KqMqPZG63zMagmHdFh18w7dDEvTQVJWJY5+2TnyqTBpgi5GF0T?=
 =?us-ascii?Q?6TNwMMLrS0s765k3coJLkBVYmqHhF1Tamo0c0OZrYKqLMyZ4kOps7ehGURhl?=
 =?us-ascii?Q?2I8/odwmoxFt4XQ45SDo+WWebJ1xQVgUtM99aJJJL1lkd4ibNoIugYBCiw2h?=
 =?us-ascii?Q?AnFkb5/2Wtgt7xXzd1O6nhBjhLZyY/WrDexw44Ee55ciBFNCgeyRin8ViVlG?=
 =?us-ascii?Q?RNBq2zhLkoHGTCGO/TecEBILriTxrCeUOszb0DpaC2IJ5/pTp2TpXMxHTLM2?=
 =?us-ascii?Q?PjzHiP/TVy+Rj+5Je3Tck8fb697GCHYfp4JtUJJqHqa0NikLWUnsfN7rpxzr?=
 =?us-ascii?Q?RPJOFf+SkEMFPS9OTD3rQN/M+kCTGjVwGpiOf6mctFfIrcWmhrQEn0y/Qqu2?=
 =?us-ascii?Q?aC6e7s3L98u/ExuJk04RjwRLVjR2Ll9OBYiT1Oz3GBFpFRTuek6kkW0agPdo?=
 =?us-ascii?Q?/PVLm1dCMijeh3aLy8N0wW6Iqq7kdpDcTPSrEQhKf1j8U5bxJZvZXX0eP1zj?=
 =?us-ascii?Q?K1RJmRwtkcf68CSvDX6RaGNB/JYkPC5WfcZdROvSoRkHqlZpWONHCW4Q1Ckr?=
 =?us-ascii?Q?7Gd11x6f2Y9q4Lx9HZ/ZLVvfmHSjy4I=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1bb34a-4fd6-425b-5554-08deb24576a4
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 05:47:34.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jWDgQHqBVIDwipNeV/m/YPBQC9QiKOXbDOr9PdOrH6xTjLcPeF4Gyh5D5bn/941/fkokjMoBWKo8T1a3Xq8dJKVyoJqp26YTWLFmpe+M2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1276
X-Rspamd-Queue-Id: C485A549D4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8878-lists,linux-pwm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.927];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opencores.org:url,saunalahti.fi:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,starfivetech.com:email,starfivetech.com:mid,southpole.se:email]
X-Rspamd-Action: no action

Add PWM driver for OpenCores PTC IP core.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS              |   6 +
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 249 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6aa3fe2ee1bb..14af609f4ada 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20027,6 +20027,12 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
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
index 000000000000..fa6a34117cde
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,249 @@
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
+struct ocores_pwm_device {
+	void __iomem *base;
+	struct clk *clk;
+	unsigned long clk_rate;
+	struct reset_control *rst;
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
+	u64 period_data, duty_data;
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (state->enabled) {
+		if (!pwm_is_enabled(pwm)) {
+			ret = pm_runtime_resume_and_get(pwmchip_parent(chip));
+			if (ret < 0)
+				return ret;
+		}
+	} else {
+		if (pwm_is_enabled(pwm)) {
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
+	writel(period_data, ddata->base + OCPWM_LRC);
+	writel(duty_data, ddata->base + OCPWM_HRC);
+	writel(OCPWM_CTRL_OE | OCPWM_CTRL_EN, ddata->base + OCPWM_CTRL);
+
+	return 0;
+}
+
+static const struct pwm_ops ocores_pwm_ops = {
+	.get_state = ocores_pwm_get_state,
+	.apply = ocores_pwm_apply,
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
+static const struct dev_pm_ops ocores_pwm_pm_ops = {
+	RUNTIME_PM_OPS(ocores_pwm_runtime_suspend,
+		       ocores_pwm_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+			    pm_runtime_force_resume)
+};
+
+static void ocores_pwm_pm_disable(void *data)
+{
+	struct device *dev = data;
+	struct ocores_pwm_device *ddata = dev_get_drvdata(dev);
+
+	pm_runtime_disable(dev);
+
+	if (!pm_runtime_status_suspended(dev))
+		ocores_pwm_runtime_suspend(dev);
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
+		return -ENOMEM;
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
+	pm_runtime_enable(dev);
+
+	ret = devm_add_action_or_reset(dev, ocores_pwm_pm_disable, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add pm disable action\n");
+
+	pm_runtime_get_noresume(dev);
+
+	writel(0, ddata->base + OCPWM_CTRL);
+
+	pm_runtime_put(dev);
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


