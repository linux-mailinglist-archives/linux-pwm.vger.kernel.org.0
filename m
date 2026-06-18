Return-Path: <linux-pwm+bounces-9318-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LmXRByjkM2raHgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9318-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 14:27:20 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8410A6A0058
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 14:27:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=axiado.com header.s=selector1 header.b=jSHFMZJ0;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9318-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9318-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6260A302C342
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 12:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6813F4DDD;
	Thu, 18 Jun 2026 12:27:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022120.outbound.protection.outlook.com [40.107.200.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582203F4DC6;
	Thu, 18 Jun 2026 12:27:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785634; cv=fail; b=smm+e5RJyOaj9Rs/h0/nEraMUPqIyRoe1suL90CsfP7J+XZcV0dzX0NsQh/a0bNTPd3aYz7kw5lLkXRf5CI+Q+meDjjMYSMeX8G+10YiBUQHVefxWKEeEGf0GiANdyyj/igDhTKNUDmxiCL+mlDNL1XR3FaF75Sxdf0kILukMtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785634; c=relaxed/simple;
	bh=VBHxefqg+dL1KkEoI4ZuGzcB0ZPsNWn/zEOoZ9ohxB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2KjejKG24dqA0UIKvI/+isj49k6O/3Kq0hoJKTVFwnEIIchQRFujAlGZOFIup4UWFSBywQygFRB+GsqFE5zvuUMlVT5PLDAfXRaqP7yqQ0OMc0m4b7RaYZ8XIduThgwUzJpZxv3myUDr5z6Cu71FQBleuU5JqmKk9C6tBPj4fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=jSHFMZJ0; arc=fail smtp.client-ip=40.107.200.120
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOzk1vbk6ksXf2YQGFlzA3Q7GqvsXKdvWJGQ/5OphIcAkuF5Bblxf5Sc3L0PREeJSzNRO/UgGxfzxRavyKM61zLxWKEEZYXlwKyi6zqBNrOj4E0bb6Le1nICwM+FzEVeAUbHYr+2p3k9MH2evJgDoFNRTbWQLZ37rXN7j+ac96KO5Bp/bcrgtr54NGmEIsBEFQ6oBPa8ow0Yxst9/6zL4m5dy7i9q8XZpmwf4NuuxC8K3Ogg2yJctWv99HjSDGb3yAmQpe1ePaUzaK3kQtHAtRmzdrMJymBixZfO3V8MQ7bVaWxNs+HjpuicbRiFXcW2s/uP6XTq95nga8V/IBpaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nad1zDhqi2499qUwW6AvrK3BWVuPBbR8l5pkgAIE+us=;
 b=BrYTJgerQJFj29893o4436VKIZ0F8rMEQ+tCT1rUk+C3tKbsrYq1kk28BvsX7yszqGM46fYEq+FPfAnHN7gx3AqLOnbjCh5aSDvPL1iMoYfZK/L7Bfe8lLWKvp4D8RYAqHWc52dz5zlUdunre2u07Odl6bi7R1QCYwnTSW89q+uKDDCw5QgoONhdLBVJqhuVoTKNPCQ809QljI0hQr39pympnhlIrxbif1CmBPuSE8+nDjcdo+W3if4PQnJiHn26VQvTbujyFhRj2ocVkDWvlcwyS3RQj2/OeaFtI9bn/+l9WzSfEuLzdGAqceaRhICuiIMlqLRuAW6depED8aPbxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nad1zDhqi2499qUwW6AvrK3BWVuPBbR8l5pkgAIE+us=;
 b=jSHFMZJ02o0Fi0IlyeGBlTWBczYbrCXXG7hJXhrr+un8oNZR8OFgt0Z0H7ullxQWOY+7llcmJSavAit8j2MGEh60n9EGfFKBeuTrLZmjoanbTXHr1yHN47B/+s2vMG/yywQWAX4RBceb+FijuUpnM2AID0XImUbZIS0lD+phK6gAJ+OGWVe4fv25Np1xBngxRMVuj2GgrHi8xKX50p964S3wrkHAEfvjNgnWky0WH926Z9HOagL5pMy7JPZRJXpqdLY5MaszP4UCRSuQu9twQba5ARrVBbmGsBqOvyt31NPON7m/J/2gPpypJOQ78WnfREWSGONHJBNFfoCxcSWReQ==
Received: from MN0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::21)
 by DSVPR18MB988341.namprd18.prod.outlook.com (2603:10b6:8:388::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 12:27:07 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::8d) by MN0P223CA0008.outlook.office365.com
 (2603:10b6:208:52b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 12:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Thu, 18 Jun 2026 12:27:05 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 2BBAD4186B5B;
	Thu, 18 Jun 2026 05:24:25 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Thu, 18 Jun 2026 05:26:57 -0700
Subject: [PATCH 2/2] pwm: add Axiado AX3000 PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-axiado-ax3000-pwm-v1-2-c9797a909414@axiado.com>
References: <20260618-axiado-ax3000-pwm-v1-0-c9797a909414@axiado.com>
In-Reply-To: <20260618-axiado-ax3000-pwm-v1-0-c9797a909414@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781785625; l=7670;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=VBHxefqg+dL1KkEoI4ZuGzcB0ZPsNWn/zEOoZ9ohxB4=;
 b=7FlmY8C8jT8GnjsX9uXWCvVhkIf9HA2U15QWbiV4xkax4rlXDL/ip9P80l4LUnhgxopgrdgKU
 CGxIFxKZlMvArO8oL0UvHN8Pfsx1KeEfd6ZBwF8DIGND9ftzByAfXIJ
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DSVPR18MB988341:EE_
X-MS-Office365-Filtering-Correlation-Id: 80587ff2-8f6e-4dca-d90a-08decd34e8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	aYJ9w1/u9N/1/WceNh6qCkQz7ql+kWqz/Gap78MleYv8YxPpAh9+9BtdMLm9REa1KGVMYsfvLMTDTwhuxqpvPQ5xADUoGivyh61iUik45I+NyPcgOGdXuYweQY5W8H4lgTtGcEhOdLVZ5VrjpfgjsE3ecMqW4y/7ax1Fx6TBU4I199awdGKEgGIQ3lZysCB4N7y+4iDQejyzAuAKZOeC7aQVOJFRAbrqdA7EF/KLle69fdNHen+3dI6UZwq0UMzV92reYesZZMvnNmjVyiJvWkyRCRyjDpyJjTvxB7/ASBsMDc8isUYfcmorRNORts4FxJvtnQ3uWK9IKB0SsLkdx29YkQq0SCMVBLEqb4qrXmJKh0UVMnFoa5X8nONJRSz64o4JyaZ2nbDkv6cy1IwjO70Eski6wBocDvZup4lHLh5boOaF0pjXRq/e8iYrIGslHaV9k+HxqvYBy26sKkyctBurpX7PfIlYHb8EEF62VqmgKvUbdbkRQgGzXrt3xTiv07i5ncSIEY9QSm/HT+4is3gGlhJLOpJEWkc1zdQ3oAV3LUdxfP9SpZObKwuelZ7Yz8Ff2zS4UxFT5KwdShFWDnffMIwJECdK7A46MUo1SsU4P2Us+5bUWyCOX0BKBuTRm01opHWIg6vwUWoy/0fs6W3RpzeNoSgzdB55U+/Gzl392Xl0zkcoNoVGtxagRS6Iuzw5ygdWhCHsJNt3exAm1xX69KJZOrILB5T6Fbs4vN0=
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aJUOCLo6xj0yleIV54R2JWEC3bP2XPdOHZ9YECtUzmK3bJnurxnGibDJGrbxoINIXFfmcuKKvXUHS8XQlfTN0nYJYR3BIShzdZBP38OWbslnqo86z4D09l7cLzai7hNPC4HxC7iJXN07QNdZ/f4cIQT+Qxxjd8b4IEqxyjvq+cHGAWtmaNbsCbVvOgRVKyCbldgk+Iiuu0PBtqemztIfikEl5FJSTWzT69LAAzKAj8KO11dILi8rxb5/mVMxg0hdhCQyjCsjoPzm7qzq7edieaY3/+JHIL6Wy7XLL69CMxIgsCSKRQyQawbHzNlj1aHBU2ZSoa9FSFdj42RYy/j2p3azNHD8wy2w3Gt4Lm+XhN0sTlWGXuupwRXCiLLyGIxU1UMR4DJBcdGEQBQMefhg50/LZVZ9ovhApJXYRnphIdPLTUpLfHph4oBKfo3T0xoy
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 12:27:05.8905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80587ff2-8f6e-4dca-d90a-08decd34e8c7
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR18MB988341
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[axiado.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akavi@axiado.com,m:pbolisetty@axiado.com,m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:hshah@axiado.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:pstepanovic@axiado.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[axiado.com];
	FORGED_SENDER(0.00)[pstepanovic@axiado.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-9318-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,axis.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,axiado.com:dkim,axiado.com:email,axiado.com:mid,axiado.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pstepanovic@axiado.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[axiado.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8410A6A0058

The Axiado AX3000 and AX3005 SoCs include PWM controllers that can be
used to generate configurable PWM output signals.

Add a PWM driver with support for configuring period, duty cycle, and
enable state through the Linux PWM framework.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 MAINTAINERS              |   1 +
 drivers/pwm/Kconfig      |  11 +++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-axiado.c | 193 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 206 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 394c4a3527e8..db93fc235c32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4319,6 +4319,7 @@ M:	Prasad Bolisetty <pbolisetty@axiado.com>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
+F:	drivers/pwm/pwm-axiado.c
 
 AXIS ARTPEC ARM64 SoC SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6f3147518376..76f6c04b0e23 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -129,6 +129,17 @@ config PWM_ATMEL_TCB
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-atmel-tcb.
 
+config PWM_AXIADO
+	tristate "Axiado PWM support"
+	depends on ARCH_AXIADO || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  PWM framework driver for the PWM controller found on Axiado
+	  AX3000 and AX3005 SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-axiado.
+
 config PWM_AXI_PWMGEN
 	tristate "Analog Devices AXI PWM generator"
 	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0dc0d2b69025..4466a29e780a 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_ARGON_FAN_HAT)	+= pwm-argon-fan-hat.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
+obj-$(CONFIG_PWM_AXIADO)	+= pwm-axiado.o
 obj-$(CONFIG_PWM_AXI_PWMGEN)	+= pwm-axi-pwmgen.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
diff --git a/drivers/pwm/pwm-axiado.c b/drivers/pwm/pwm-axiado.c
new file mode 100644
index 000000000000..db197886c5c4
--- /dev/null
+++ b/drivers/pwm/pwm-axiado.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021-2026 Axiado Corporation.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+/* Register offsets */
+#define AX_PWM_CNTRL_REG     0x0000
+#define AX_PWM_PERIOD_REG    0x0004
+#define AX_PWM_HIGH_REG      0x0008
+
+/* PWM channels */
+#define AX_PWM_NUM 1
+
+/* Period and duty cycle limits */
+#define AX_PWM_PERIOD_MIN       2
+#define AX_PWM_PERIOD_MAX       0xfffffffeU
+#define AX_PWM_DUTY_MIN         1
+#define AX_PWM_DUTY_MAX         0xfffffffdU
+
+/* Control register bits */
+#define AX_PWM_CTRL_ENABLE BIT(0)
+#define AX_PWM_CTRL_DISABLE 0x0
+
+struct axiado_pwm_chip {
+	struct clk *clk;
+	void __iomem *base;
+};
+
+static int axiado_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			     u64 duty_ns, u64 period_ns)
+{
+	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
+	unsigned long rate;
+	u64 period_cycles, duty_cycles;
+
+	/*
+	 * The hardware does not support a zero period, 0% duty cycle, or
+	 * 100% duty cycle. The caller should handle 0% duty cycle by
+	 * disabling the PWM.
+	 */
+	if (!period_ns || !duty_ns || duty_ns >= period_ns)
+		return -EINVAL;
+
+	rate = clk_get_rate(axpwm->clk);
+	if (!rate)
+		return -EINVAL;
+
+	period_cycles = mul_u64_u64_div_u64(period_ns, rate, NSEC_PER_SEC);
+	if (period_cycles < AX_PWM_PERIOD_MIN ||
+	    period_cycles > AX_PWM_PERIOD_MAX)
+		return -EINVAL;
+
+	duty_cycles = mul_u64_u64_div_u64(duty_ns, rate, NSEC_PER_SEC);
+	if (duty_cycles < AX_PWM_DUTY_MIN ||
+	    duty_cycles > AX_PWM_DUTY_MAX)
+		return -EINVAL;
+
+	if (duty_cycles >= period_cycles)
+		return -EINVAL;
+
+	writel((u32)period_cycles, axpwm->base + AX_PWM_PERIOD_REG);
+	writel((u32)duty_cycles, axpwm->base + AX_PWM_HIGH_REG);
+
+	return 0;
+}
+
+static int axiado_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled || !state->duty_cycle) {
+		if (pwm->state.enabled)
+			writel(AX_PWM_CTRL_DISABLE, axpwm->base + AX_PWM_CNTRL_REG);
+
+		return 0;
+	}
+
+	ret = axiado_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	if (ret)
+		return ret;
+
+	if (!pwm->state.enabled)
+		writel(AX_PWM_CTRL_ENABLE, axpwm->base + AX_PWM_CNTRL_REG);
+
+	return 0;
+}
+
+static int axiado_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct axiado_pwm_chip *axpwm = pwmchip_get_drvdata(chip);
+	unsigned long rate;
+	u32 period_cycles;
+	u32 duty_cycles;
+	u32 ctrl;
+
+	rate = clk_get_rate(axpwm->clk);
+	if (!rate)
+		return -EINVAL;
+
+	ctrl = readl(axpwm->base + AX_PWM_CNTRL_REG);
+	period_cycles = readl(axpwm->base + AX_PWM_PERIOD_REG);
+	duty_cycles = readl(axpwm->base + AX_PWM_HIGH_REG);
+
+	state->enabled = !!(ctrl & AX_PWM_CTRL_ENABLE);
+	state->period = mul_u64_u64_div_u64(period_cycles, NSEC_PER_SEC, rate);
+	state->duty_cycle = mul_u64_u64_div_u64(duty_cycles, NSEC_PER_SEC, rate);
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	return 0;
+}
+
+static const struct pwm_ops axiado_pwm_ops = {
+	.get_state = axiado_pwm_get_state,
+	.apply = axiado_pwm_apply,
+};
+
+static void axiado_pwm_disable(void *data)
+{
+	struct axiado_pwm_chip *axpwm = data;
+
+	writel(AX_PWM_CTRL_DISABLE, axpwm->base + AX_PWM_CNTRL_REG);
+}
+
+static int axiado_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct axiado_pwm_chip *axpwm;
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, AX_PWM_NUM, sizeof(*axpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	axpwm = pwmchip_get_drvdata(chip);
+
+	axpwm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(axpwm->base))
+		return dev_err_probe(dev, PTR_ERR(axpwm->base),
+				     "failed to map registers\n");
+
+	ret = devm_add_action_or_reset(dev, axiado_pwm_disable, axpwm);
+	if (ret)
+		return ret;
+
+
+	axpwm->clk = devm_clk_get_enabled(dev, "pwm");
+	if (IS_ERR(axpwm->clk))
+		return dev_err_probe(dev, PTR_ERR(axpwm->clk),
+				     "failed to get/enable clock\n");
+
+	chip->ops = &axiado_pwm_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id axiado_pwm_match[] = {
+	{ .compatible = "axiado,ax3000-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axiado_pwm_match);
+
+static struct platform_driver axiado_pwm_driver = {
+	.driver = {
+		.name =  "axiado-pwm",
+		.of_match_table = axiado_pwm_match,
+	},
+	.probe = axiado_pwm_probe,
+};
+
+module_platform_driver(axiado_pwm_driver);
+
+MODULE_AUTHOR("Axiado Corporation");
+MODULE_DESCRIPTION("Axiado PWM driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


