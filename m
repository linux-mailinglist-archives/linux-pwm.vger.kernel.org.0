Return-Path: <linux-pwm+bounces-9704-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XSXtBnCvVWrBrgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9704-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 05:39:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EE6750AE2
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 05:39:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9704-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9704-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AB90301A730
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 03:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8EF30D3E2;
	Tue, 14 Jul 2026 03:32:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1184C3446DE;
	Tue, 14 Jul 2026 03:32:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999948; cv=fail; b=aRSSMFeKbv142b8fwiV0TSDL7TxqrDzcBa6fvqKskeDxzycdYMS2LG8PUzK2aONFctUen1SYBWj7O9VvxmipbjKzAceHmGLS6pPx6jFCU+R1YLGzdGggR9iUmNOT7QFwMFCCTojxJHWyyUTjez2v54L7U5wNL6YNR+UqIXRKM0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999948; c=relaxed/simple;
	bh=gvXQmRdNgj61mt5qpza3TJDaQX0GISAZHvr+xXx7t2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBJZDM68Z21fjvq5cuhm/nnZfWJ2iILEHBSmitWX0v/KWoTHkU6QeDZWUDk1OyGEncnlOAgYoTNbJy3Gahk+bB6jBQxWvLf4v7JulgR+6tqNoqhXk5pv4W+DvKM9xqYJ9uMcd7ZoPo9u+n4z+lhDLQPC+htm2NBLE0nNzOJdBig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meEm2sf6tnOoSZKKyt/7sdAqY8WjlwPQHqvXM40YpvXceDWVPTmRKtBxaegufVAkXAXlJoY0BW3wlKQPPbrM4w2u/4lg6p+8/44HNAWe1y8ZprB0fMtZsweaWZwTHeR+V3hhIuqeA8g2sGRXPR8pZ8Nli4PKpqsoTv+3kTfyzBxGHPadhAKLtcqzA0z/B5u/K5KuKc9WqJdVjoJaEmh8cYtPrRJI+XRcUxPDooH5EF8sM7NeZj+pCe/IFDQ8CH3NuoHXoyOoaagJASOD8QbAYxX2d9E3aLJrVP2TW3Mupdrx1CZlCUBzeESkfd+7cbQ9ljXpOvEBkxSUPgkTpIf6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdIX0XdMhSpatcsVJ4ZlPHdy9hKzZyKQp+OU21AdEk4=;
 b=Vh0NDS/0zVaK8Vdj5A0MTq3Z1i3p3b65k3jT8NPqgXOhkreT1jjQZVtA2rc9cDNNQB929nrUvX6V1xHvpazr2U+vGvu8X1m02Qki9RUxcxEoJrDLo6ceXcrFK3TqqxlLiF1lcT5qnELXJ9nBf6E0pCF2ooSpIzd0s89npA5pcTnpOlC/90girPrTVea/QdImJ5yX8G5lZ/WkMNsSgyb08YSlSJDVjxpcr35Y0J/pHOZ7K90rsZJEH1rQkHD/qq7+iClgNe7oSBmcTFnEYNOT0GPPuYFE0uizeVteKbGXpgv2n6A38b0Ebi0OHPo7qDcOxgUY+6mqxKmXXdCy0n0a0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1324.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Tue, 14 Jul
 2026 03:31:02 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0139.024; Tue, 14 Jul 2026 03:31:02 +0000
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
Subject: [PATCH v22 3/3] pwm: Add OpenCores PTC PWM driver
Date: Tue, 14 Jul 2026 11:30:50 +0800
Message-ID: <20260714033050.44952-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260714033050.44952-1-hal.feng@starfivetech.com>
References: <20260714033050.44952-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::35) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1324:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cf12db-cd65-4013-cd31-08dee1585426
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|56012099006|38350700014|18002099003|3023799007|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	NTjUTSomBAGrQ6oVkqkby/spI9huH1Q/IPayT+u3XdgKby6tlHs14LLqI24a77zOrhEeEBVYcdgqJslHFMf3Ay2cNqqEIwD3wHn0eXtEWbtrA6E9g13aUIds3YHNjNQXq4lAvy7TVongEEnFETGApfmSyWH/jDd3+mn9i4r1bYrc7FnBovUWHlSZWkh6eLHBxY7x1cNDksoTRl+fwOhqtterID6whVSZzsVY2gOkg6TCqPGlZ7fWYK4DRA2Rc6ND0uMMJs6sYP/91BQkUBHn/tHD2etYkiLFMrsMkyJBQI8IY5Q85ks3mdoR82wbcajTIf9K8maUjfZNEox0+/Wz51cfR4jxtj5hH8DW/8acmkah/g+/U0Eaiu/+Zi4jdnSxWFm+1RbU0J3CArSAIz2yRYWMMOwUY/OHcOp58D/QigHNVmDYinwM31ekkkyqpmZclzATiW183qU3YDdjABt1pVeIolvUykbWFwfBlC7IykVDLmNLCjmFi21prGhcDEJVhC41bvUG9rKSJ/CRJLBxEggeXUwJ+p9yRU1/WPW5KUUzc1/JeQ88EzYtp+3+Hwls
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(56012099006)(38350700014)(18002099003)(3023799007)(22082099003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N3Sh75ykhj1m7YlSesuWmAG7OphtHMbi5wuqTrSGJWZ9Viq5xcaHM5n2avd2?=
 =?us-ascii?Q?jSMCCinDH6S8EKTMVF1s0zFtdY61lH/1c82wQua4FZRM4BAW/ZJ4G57ALGAG?=
 =?us-ascii?Q?ug3tsJAirx6tZZk3yvsvhmkfDhfCfHiXkMBwgIP3BqC5UkM9acIbc7hdqmvn?=
 =?us-ascii?Q?UxrKAESuneHZY9koZ8xTMWEza5+lgyAWTqLXSx+DUx4rHdafsfdzVAEx1kIF?=
 =?us-ascii?Q?Cx3BOzJWKbXq7r/GUxyPRBOKkLqee43JdoNBpAiSUNkqo1o4+QBfkMDPrsRK?=
 =?us-ascii?Q?jQnFFRoEP3+/Bb/zNRmbIYYuOKxHVlOyilEfepdTbevnoxn8h4ZrQkTQb5oM?=
 =?us-ascii?Q?sW4SqgUtNB/95MDhWiotEjGgHuv+8tQQvv+yIb+9AQ/8AHgxNQ/QPCXsZaVe?=
 =?us-ascii?Q?8tPYePalteEZ7N0qoiTy8qgdWNIyn7tsfpNwlVGKWRI52vRxOf1Ncj8UJTne?=
 =?us-ascii?Q?le5brkRer4b1Y1IEQ4EF7MKXet9hWXqgEsaXZEhGrnH0lUYHHH8WYqMSU4SM?=
 =?us-ascii?Q?E5JKEZKlUtiSuykHB9aCGimyyJcbayEvbRXgzg9k4xQX57A1igKg5uC4X0qj?=
 =?us-ascii?Q?WjiSPoMMOYYp+ZGYaOGgk0U1rU05JRtiGLv9dVwZ3c6HscTTmFsraSrl3GAd?=
 =?us-ascii?Q?OUBVkVEiLZVA/k+pSsKmgStQSTXa5+fto5ySf2O65d1UCotaQXrEb7indBj4?=
 =?us-ascii?Q?CCdylBAjtQf7yoNw0q7YD1Qk/WY6fnxRgV/uvKQ90wQoqXL5i3XlNw8gnYMf?=
 =?us-ascii?Q?KePkex+6yPlpEp5sGSpKq7hZ9VXRbADqNOGLrMXJHADxSpz3ZvCHfbrU2GUi?=
 =?us-ascii?Q?p9oSLUKV2HxfuHtv2h/JXdF0SZT3u0u7RXaRHbfd4XJ/0lFlF3PV5Yk3mmw5?=
 =?us-ascii?Q?l7oJC7XF7jXg7nKQ/S2jXLZlQMJHmPyqrD05iUjernh3YxeZ4GKoLA/t7Aen?=
 =?us-ascii?Q?Zx0SBkNkkZCebn1EEUW+ixJ++fkULakGObnoGOFUkUI0UTBGpVNhoSO56nRS?=
 =?us-ascii?Q?kTSCHOOPGCUevr3f+UVQeqxFBir9+KoWn6TlMHGN89CVWR0mRav1C/gO14Tp?=
 =?us-ascii?Q?M0sjvcumVAVMnoEAdfZGKqkWy7XXFC5i+TUeYHnF+1C56tB5ySe/8BtZGwUc?=
 =?us-ascii?Q?PgdPJRgpVpSvADFy7ru5vY3FTQ1i6YR6f9Z1ZzHphHLX7hpbLh39pnv8HXEi?=
 =?us-ascii?Q?u38Jk4hk78aGXWr6Aj+uUsU1Bw7j6d2kiCnrPaRPQN5+i5BgLvgZZJABaZM4?=
 =?us-ascii?Q?PfIaj5yEiTdfas+aUXjKKtIfIYCFwiDCkMjAFmyolZFcYTYBLuQLNyPVZYZP?=
 =?us-ascii?Q?0Tk2OrFGPbRS8HptCD3lb7pLZbV+Ad2behAtfIkuo5UBN/Ytc17P7puA4Nju?=
 =?us-ascii?Q?6Iqu58nO2t9QaGv91VZcegYoXFhwhVK3mnrsFWCTxBkoHUXVGVhqQTAM7sAw?=
 =?us-ascii?Q?5BjWbjHC/iMtoV7ldMAtBg+qKolGl2xHCMVnNSzaQBYjfPbhM4gRJgVx2zYE?=
 =?us-ascii?Q?2henUVaYmuqzrbRETv8NQn7FIwH5pJskM4QT7TEJoGQaLcVDmBx9IEc4IgNw?=
 =?us-ascii?Q?PK2NGtfRQQiklXBy3yfnIAHJE6fPHJFSbY7CYm4l/UMzUS/4B+iRAwPIoMHW?=
 =?us-ascii?Q?AKDgA65y53gJsRzxK2eBcao9SUYkD1umzbulAWBDLh+xczc3rpZE7nav2gj5?=
 =?us-ascii?Q?/x94/7eBBECploLRRLJFhLYfVLw4cgJ6QB+laoikrJhZyTikEJBU97ncM4Cr?=
 =?us-ascii?Q?yLu1zSO5zkdIS8B8Q7ChFZriIglJ0QY=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cf12db-cd65-4013-cd31-08dee1585426
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 03:31:01.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afeUZ45sk40dMKoG8M8ouFJQnasnsbTxsAiFzaWdCGsc4p8GBvCSAQ3BD7BiHngEQw3h310Ud6gDkUtrbccGTUZqryJAKed2vISX7cL7IOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1324
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
	TAGGED_FROM(0.00)[bounces-9704-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[opencores.org:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,southpole.se:email,saunalahti.fi:email,starfivetech.com:from_mime,starfivetech.com:email,starfivetech.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59EE6750AE2

Add PWM driver for OpenCores PTC IP core.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS              |   6 +
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 298 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 317 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 806bd2d80d15..6443c2be49d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20271,6 +20271,12 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
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
index 000000000000..f873089a385b
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,298 @@
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
+ * - The hardware minimum period / non-zero duty_cycle is (1 / pwm_apb clock frequency).
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
+	if (!period_data)
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
+		/* Balance the reference held while the PWM is enabled. */
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


