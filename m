Return-Path: <linux-pwm+bounces-4636-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E8A122B7
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jan 2025 12:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78659164762
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jan 2025 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E322FAFD;
	Wed, 15 Jan 2025 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nn+RJ0ns"
X-Original-To: linux-pwm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6502416AB;
	Wed, 15 Jan 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941024; cv=fail; b=sNk/69gpvpk6givZygaUVcUJiyw7Fbas4rdN7IcSWg9aaMys3NgcspVvt1BBnDu5NoI560hoFLtXTUjwS/1ojtP6xHevQ/kE+mVU85mzOVs+mUSegieEPoLUE8RSp61CJIV5VcqBvpLYpdE67sXtyfFjQ6JntZCk5CkxyaLsxhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941024; c=relaxed/simple;
	bh=0xe9yjwtNeZw1KVIhPlXwFPuyRVGtfg7qFj3PnPa63w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiL056Ydhrj74zwKitoAlSoH8hV8BCWIr5WLf3wEjsY0X6uHCyMuYFnhH7CKY+20DA4hek8IMoT/X0+6kvJjG8qB9dhmnm9UTb04jCB8vqrqjzpNc5qTWLQF55lxE9i3WM3TYIqIpqe5UxA9lJAVjeU0V/9n6oIPGvc3q9YFd9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nn+RJ0ns; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwLfvoqbFT+Z0SEyPJYIz2eBxozgIKMv/8l1KWKA3rD+S0dijSHrDafL5he6AkEI3pjnHdV1oLoRvL3lVJaNYBh6VKimcqIvLo2hi7oB+LajpaBFUAwTr/U5aEy2Rp+Mp6JeW+ybBVCrCciEZV5kp5MIjSA913RAwNGfl+HS5osgg2IQftA/Xtvoi+4Uv5iIp25yyGxgoNG5JOPVhkOVmrWo9r5DRuA4QiU0WNmdc5C+6ai7VFzdtnT+PHNEuTJm6gNJxdXsbL5ETy991veH7zskmXmapJZgE4ANQpaD9XRAzE89v82QDPYDF0p02PVjjMoDJjJbCZxjHkCEviNdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WUzex5fHpwGtQnlSwIxsUhSFxGF3pEeVGqz8SDZU2s=;
 b=WEXatho3pcDgXFrRct8Lm6uztBTIqbweu5ql1EhEsIpHgsMgCXxK2euPxQD5mpxO75m90oBz4YVrRYtaQR99tlcGz+Q4yVmPoff+op7AZ3IhIxvRgNb9wTu4iI574Av6fVFqYf4it+QZyrRCQBfqPBL9rPaTNVNSsI0njUyMdvM5vk+qnSIJrB3xB9aZOGMHbaAUDz0fEE/egHL2sD8dQeDP8h9jAp9K9LIoz+7PwlPJJxa0tphgMxIMawFIVKgdJFCDKSTgfP3Rq3Bg/SKa8JBcAg9Fub15fnLwQCLPuxOALhjXU5YZ2PH7FRrLklzapPwpokZjcUKO5GoS7C32SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WUzex5fHpwGtQnlSwIxsUhSFxGF3pEeVGqz8SDZU2s=;
 b=nn+RJ0nsEmZns+ffgv7Y/eivMc082hQx3G/e8NtPxaMcLyUpySwwZ75Get3P+8prBZde825r+y0a4a+4c+d0QaANMuRGMYNM1Q+DTEI16Pxl0QhjVINW1X1JLDH7N8kg1tZu7QMCwozli17U+v9jKP0fwcUDAGKmxu9Ss7m+BQk=
Received: from SN7PR04CA0060.namprd04.prod.outlook.com (2603:10b6:806:120::35)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 11:36:57 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::84) by SN7PR04CA0060.outlook.office365.com
 (2603:10b6:806:120::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 11:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 11:36:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Jan
 2025 05:36:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Jan
 2025 05:36:55 -0600
Received: from xhdmubinusm40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 15 Jan 2025 05:36:52 -0600
From: Mubin Sayyed <mubin.sayyed@amd.com>
To: <krzysztof.kozlowski+dt@linaro.org>, <daniel.lezcano@linaro.org>,
	<tglx@linutronix.de>, <michal.simek@amd.com>, <ukleinek@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <git@amd.com>, Mubin Sayyed
	<mubin.sayyed@amd.com>
Subject: [PATCH v4 3/3] pwm: pwm-cadence: Add support for TTC PWM
Date: Wed, 15 Jan 2025 17:05:56 +0530
Message-ID: <20250115113556.2832282-4-mubin.sayyed@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115113556.2832282-1-mubin.sayyed@amd.com>
References: <20250115113556.2832282-1-mubin.sayyed@amd.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a2b934-8db6-4843-91f5-08dd3558eae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZWYt3FM49hNqrze4aRjsxwXc+bm7xoW/VSjcuOgB3lGL+rj6T0lL3G7qwJwB?=
 =?us-ascii?Q?inTzOMbTmLMN/XvEaGTqJNcFLT3e1iXNUfvwlS4T8KR7Skogb8Ap6isipVMC?=
 =?us-ascii?Q?qG3i5/tfYxDWH4/N+cQCCfwTuY3bSxL1ddi/87kWLT1IqF/GGC7RW0u7itE8?=
 =?us-ascii?Q?F4OkURwKvbfFfeV6yBmPY9JoCNe22V+PSv6WYC4DrR6WJowK0kkRbENjvz21?=
 =?us-ascii?Q?DFsnPcviRV9psA7n922hMj1en5eZNyQ3DCKm+qC9GIdE/QvoyqD8pu46YJbw?=
 =?us-ascii?Q?lXQa/0jZT1JMpp1P1W89kRS/dwC/N8PffQ4dN+oqBidFU7THnfYPBSa3tPKg?=
 =?us-ascii?Q?MX1dGvUqFVXdlvkmeLDGyqO90y70orgl9EdjNkFLDeM5AkMWRXV6hqJ0B4DP?=
 =?us-ascii?Q?8WSS0S7E0SJgg5A652WsYUCz0p1GthOj+vUdcvQAO2Vc9RofcOsXMmtaOGL5?=
 =?us-ascii?Q?1Fcbv+dPSSobmfRhk62VRb1DbOi+M8LHhlNmVUlXRv5e10MkT+w/2M0A/Bia?=
 =?us-ascii?Q?fZh0TwsrocWRWIXMeFZWfAl+E28uTjwzzSFO5CJI7KDx19RgOjUX9jHbRFT6?=
 =?us-ascii?Q?hKQvjMkk+VM7NNOgFOb15T4qi2LSlkWvg1iiqwI6yAtiSiCosIYDeLTv1x/z?=
 =?us-ascii?Q?IdL5ZeiP1aLc9575nJtk24ZA6LarotyPoBC5z1iahOMhqGcKZV5r7TmlPhPn?=
 =?us-ascii?Q?RcIH/NP/T6C2s8Nvs92Rg7lVanAX3d/FJOVJaAr/yGlZGz9gF/QsBLElcXaE?=
 =?us-ascii?Q?T+v0I4W0t+U/m9h8bD+gkF+BQvHc6lUd1fT0H3lE62uW/O6UyVzaEMjz1yMu?=
 =?us-ascii?Q?KIkONKsuCA1+pZ6JtY9w7oLe5CQt7tOSFfRF7w8+W80NpUAc3qP2On4d9V4n?=
 =?us-ascii?Q?q7LisWK5mvuT/fm+RZdCwm8JeQqwpzy/dIi+/drYtzQmJ32TQeyyKZbyYIdX?=
 =?us-ascii?Q?42DY6MBhlsTpz+zhj/7XMv+jYsBiqdVs2ElDTIYh6tko+resV7c55804/yXb?=
 =?us-ascii?Q?DSpDn25FSZQlTP8DO5//o3JhVJbCqS4/xEsCtbd/jOaQJlOkJp0trhm9S6AV?=
 =?us-ascii?Q?8A2NZaTaOesNbxJYt5GsNlyLpSFdZCbpo4WsNmc3iQ5QSNrsz4PsfNEEeIxp?=
 =?us-ascii?Q?v/RLFialHwKCujIgTY120VJIZsTWE6NzgQytLewPN6MZhJLTsfBX+PrrmdBt?=
 =?us-ascii?Q?DDlHSciEHeTz/gvBiiOQqxk0zfE90bmcJ5C9j5wcXzheprByNuzXUi/BBmnd?=
 =?us-ascii?Q?d3x9bOZFWcT5KJy+xHdgVMMexXW42Mv5zkbppJ27Ugq4gtWlREciG/iKb0ij?=
 =?us-ascii?Q?c25O5deUoa3cYWgs4zEVyDoS/mCe1w69nzUz9FLPx5ShYySJqmwuTrIMFXTp?=
 =?us-ascii?Q?mYXeeztihgxScsxH/umtnElqpWyS75HXwcWxzS9DUWdjYMPyALSiHCS1AjM5?=
 =?us-ascii?Q?GhNqKFWOgu4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:36:57.0110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a2b934-8db6-4843-91f5-08dd3558eae9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594

Cadence TTC timer can be configured as clocksource/clockevent or PWM
device.Specific TTC device would be configured as PWM device, if
pwm-cells property is present in the device tree node.

In case of Zynq, ZynqMP and Versal SoC's, each TTC device has 3
timers/counters, so maximum 3 PWM channels can be configured for each TTC
IP instance. Also, output of 0th PWM channel of each TTC device can be
routed to MIO or EMIO, and output of 2nd and 3rd PWM channel can be
routed only to EMIO.

Period for given PWM channel is configured through interval timer and
duty cycle through match counter.

Details for cadence TTC IP can be found in Zynq UltraScale+ TRM.

Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
---
Refer link given below for Zynq UltraScale+ TRM
https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm

Changes for v4:
 Configure it as part of TTC clocksource/clockevent driver
 drivers/clocksource/timer-cadence-ttc.c.
 Move probe/remove function to timer-cadence-ttc.c.
Changes for v3:
 None
Changes for v2:
 Use maybe_unused attribute for ttc_pwm_of_match_driver structure
 Add new function ttc_pwm_set_polarity
 Removed calls to pwm_get_state
 Replace DIV_ROUNF_CLOSEST with mul_u64_u64_div_u64
 Modify ttc_pwm_apply to remove while loop in prescalar logic
 and avoid glitch
 Calculate rate in probe and add it to private structure for further
 Drop ttc_pwm_of_xlate
 Replace of_clk_get with devm_clk_get_enabled
 Drop _OFFSET and _MASK from definitions
 Keep Kconfig and Makefile changes alphabetically sorted
 Use remove_new instead of remove
 Document limitations in driver file
---
 drivers/pwm/Kconfig               |  10 +
 drivers/pwm/Makefile              |   1 +
 drivers/pwm/pwm-cadence.c         | 323 ++++++++++++++++++++++++++++++
 include/linux/timer-cadence-ttc.h |  22 +-
 4 files changed, 355 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pwm/pwm-cadence.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..b418e5d8fa42 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -202,6 +202,16 @@ config PWM_CROS_EC
 	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
 	  Controller.
 
+config PWM_CADENCE
+	bool "Cadence TTC PWM driver"
+	depends on CADENCE_TTC_TIMER
+	help
+	  Generic PWM framework driver for cadence TTC IP found on
+          Xilinx Zynq/ZynqMP/Versal SOCs. Each TTC device has 3 PWM
+          channels. Output of 0th PWM channel of each TTC device can
+          be routed to MIO or EMIO, and output of 1st and 2nd PWM
+          channels can be routed only to EMIO.
+
 config PWM_DWC_CORE
 	tristate
 	depends on HAS_IOMEM
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9081e0c0e9e0..246380391a63 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
 obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
+obj-$(CONFIG_PWM_CADENCE)	+= pwm-cadence.o
 obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
diff --git a/drivers/pwm/pwm-cadence.c b/drivers/pwm/pwm-cadence.c
new file mode 100644
index 000000000000..e7c337fe956b
--- /dev/null
+++ b/drivers/pwm/pwm-cadence.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver to configure cadence TTC timer as PWM
+ * generator
+ *
+ * Limitations:
+ * - When PWM is stopped, timer counter gets stopped immediately. This
+ *   doesn't allow the current PWM period to complete and stops abruptly.
+ * - Disabled PWM emits inactive level.
+ * - When user requests a change in  any parameter of PWM (period/duty cycle/polarity)
+ *   while PWM is in enabled state:
+ *	- PWM is stopped abruptly.
+ *	- Requested parameter is changed.
+ *	- Fresh PWM cycle is started.
+ *
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/of_address.h>
+#include <linux/timer-cadence-ttc.h>
+
+/**
+ * struct ttc_pwm_priv - Private data for TTC PWM drivers
+ * @chip:	PWM chip structure representing PWM controller
+ * @clk:	TTC input clock
+ * @rate:	TTC input clock rate
+ * @max:	Maximum value of the counters
+ * @base:	Base address of TTC instance
+ */
+struct ttc_pwm_priv {
+	struct pwm_chip chip;
+	struct clk *clk;
+	unsigned long rate;
+	u32 max;
+	void __iomem *base;
+};
+
+static inline u32 ttc_pwm_readl(struct ttc_pwm_priv *priv,
+				unsigned long offset)
+{
+	return readl_relaxed(priv->base + offset);
+}
+
+static inline void ttc_pwm_writel(struct ttc_pwm_priv *priv,
+				  unsigned long offset,
+				  unsigned long val)
+{
+	writel_relaxed(val, priv->base + offset);
+}
+
+static inline u32 ttc_pwm_ch_readl(struct ttc_pwm_priv *priv,
+				   unsigned int chnum,
+				   unsigned long offset)
+{
+	unsigned long pwm_ch_offset = offset +
+				       (TTC_PWM_CHANNEL * chnum);
+
+	return ttc_pwm_readl(priv, pwm_ch_offset);
+}
+
+static inline void ttc_pwm_ch_writel(struct ttc_pwm_priv *priv,
+				     unsigned int chnum,
+				     unsigned long offset,
+				     unsigned long val)
+{
+	unsigned long pwm_ch_offset = offset +
+				       (TTC_PWM_CHANNEL * chnum);
+
+	ttc_pwm_writel(priv, pwm_ch_offset, val);
+}
+
+static inline struct ttc_pwm_priv *xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static void ttc_pwm_enable(struct ttc_pwm_priv *priv, struct pwm_device *pwm)
+{
+	u32 ctrl_reg;
+
+	ctrl_reg = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg |= (TTC_CNTR_CTRL_INTR_MODE_EN
+				 | TTC_CNTR_CTRL_MATCH_MODE_EN | TTC_CNTR_CTRL_RST);
+	ctrl_reg &= ~(TTC_CNTR_CTRL_DIS | TTC_CNTR_CTRL_WAVE_EN);
+	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);
+}
+
+static void ttc_pwm_disable(struct ttc_pwm_priv *priv, struct pwm_device *pwm)
+{
+	u32 ctrl_reg;
+
+	ctrl_reg = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg |= TTC_CNTR_CTRL_DIS;
+
+	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);
+}
+
+static void ttc_pwm_set_polarity(struct ttc_pwm_priv *priv, struct pwm_device *pwm,
+				 enum pwm_polarity polarity)
+{
+	u32 ctrl_reg;
+
+	ctrl_reg = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET);
+
+	if (polarity == PWM_POLARITY_NORMAL)
+		ctrl_reg |= TTC_CNTR_CTRL_WAVE_POL;
+	else
+		ctrl_reg &= (~TTC_CNTR_CTRL_WAVE_POL);
+
+	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);
+}
+
+static void ttc_pwm_set_counters(struct ttc_pwm_priv *priv,
+				 struct pwm_device *pwm,
+				 u32 period_cycles,
+				 u32 duty_cycles)
+{
+	/* Set up period */
+	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_INTR_VAL_OFFSET, period_cycles);
+
+	/* Set up duty cycle */
+	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_MATCH_CNT_VAL_OFFSET, duty_cycles);
+}
+
+static void ttc_pwm_set_prescalar(struct ttc_pwm_priv *priv,
+				  struct pwm_device *pwm,
+				  u32 div, bool is_enable)
+{
+	u32 clk_reg;
+
+	if (is_enable) {
+		/* Set up prescalar */
+		clk_reg = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL_OFFSET);
+		clk_reg &= ~TTC_CLK_CNTRL_PSV_MASK;
+		clk_reg |= (div << TTC_CNTR_CTRL_PRESCALE_SHIFT);
+		clk_reg |= TTC_CLK_CNTRL_PS_EN;
+		ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CLK_CNTRL_OFFSET, clk_reg);
+	} else {
+		/* Disable prescalar */
+		clk_reg = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL_OFFSET);
+		clk_reg &= ~TTC_CLK_CNTRL_PS_EN;
+		ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CLK_CNTRL_OFFSET, clk_reg);
+	}
+}
+
+static int ttc_pwm_apply(struct pwm_chip *chip,
+			 struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct ttc_pwm_priv *priv = xilinx_pwm_chip_to_priv(chip);
+	u64 duty_cycles, period_cycles;
+	struct pwm_state cstate;
+	unsigned long rate;
+	bool flag = false;
+	u32 div = 0;
+
+	cstate = pwm->state;
+
+	if (state->polarity != cstate.polarity) {
+		if (cstate.enabled)
+			ttc_pwm_disable(priv, pwm);
+
+		ttc_pwm_set_polarity(priv, pwm, state->polarity);
+	}
+
+	rate = priv->rate;
+
+	/* Prevent overflow by limiting to the maximum possible period */
+	period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
+	period_cycles = mul_u64_u64_div_u64(period_cycles, rate, NSEC_PER_SEC);
+
+	if (period_cycles > priv->max) {
+		/*
+		 * Prescale frequency to fit requested period cycles within limit.
+		 * Prescalar divides input clock by 2^(prescale_value + 1). Maximum
+		 * supported prescalar value is 15.
+		 */
+		div = mul_u64_u64_div_u64(state->period, rate, (NSEC_PER_SEC * priv->max));
+		div = order_base_2(div);
+		if (div)
+			div -= 1;
+
+		if (div > 15)
+			return -ERANGE;
+
+		rate = DIV_ROUND_CLOSEST(rate, BIT(div + 1));
+		period_cycles = mul_u64_u64_div_u64(state->period, rate,
+						    NSEC_PER_SEC);
+		flag = true;
+	}
+
+	if (cstate.enabled)
+		ttc_pwm_disable(priv, pwm);
+
+	duty_cycles = mul_u64_u64_div_u64(state->duty_cycle, rate,
+					  NSEC_PER_SEC);
+	ttc_pwm_set_counters(priv, pwm, period_cycles, duty_cycles);
+
+	ttc_pwm_set_prescalar(priv, pwm, div, flag);
+
+	if (state->enabled)
+		ttc_pwm_enable(priv, pwm);
+	else
+		ttc_pwm_disable(priv, pwm);
+
+	return 0;
+}
+
+static int ttc_pwm_get_state(struct pwm_chip *chip,
+			     struct pwm_device *pwm,
+			     struct pwm_state *state)
+{
+	struct ttc_pwm_priv *priv = xilinx_pwm_chip_to_priv(chip);
+	u32 value, pres_en, pres = 1;
+	unsigned long rate;
+	u64 tmp;
+
+	value = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET);
+
+	if (value & TTC_CNTR_CTRL_WAVE_POL)
+		state->polarity = PWM_POLARITY_NORMAL;
+	else
+		state->polarity = PWM_POLARITY_INVERSED;
+
+	if (value & TTC_CNTR_CTRL_DIS)
+		state->enabled = false;
+	else
+		state->enabled = true;
+
+	rate = priv->rate;
+
+	pres_en = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL_OFFSET);
+	pres_en	&= TTC_CLK_CNTRL_PS_EN;
+
+	if (pres_en) {
+		pres = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL_OFFSET)
+					& TTC_CLK_CNTRL_PSV_MASK;
+		pres >>= TTC_CNTR_CTRL_PRESCALE_SHIFT;
+		/* If prescale is enabled, the count rate is divided by 2^(pres + 1) */
+		pres = BIT(pres + 1);
+	}
+
+	tmp = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_INTR_VAL_OFFSET);
+	tmp *= pres;
+	state->period = DIV64_U64_ROUND_UP(tmp * NSEC_PER_SEC, rate);
+
+	tmp = ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_MATCH_CNT_VAL_OFFSET);
+	tmp *= pres;
+	state->duty_cycle = DIV64_U64_ROUND_UP(tmp * NSEC_PER_SEC, rate);
+
+	return 0;
+}
+
+static const struct pwm_ops ttc_pwm_ops = {
+	.apply = ttc_pwm_apply,
+	.get_state = ttc_pwm_get_state,
+};
+
+int ttc_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct ttc_pwm_priv *priv;
+	struct pwm_chip *chip;
+	u32 timer_width;
+	int ret;
+
+	ret = of_property_read_u32(np, "timer-width", &timer_width);
+	if (ret)
+		timer_width = 16;
+
+	chip = devm_pwmchip_alloc(dev, TTC_PWM_MAX_CH, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	priv = xilinx_pwm_chip_to_priv(chip);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->max = BIT(timer_width) - 1;
+
+	priv->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "ERROR: timer input clock not found\n");
+	}
+
+	priv->rate = clk_get_rate(priv->clk);
+
+	clk_rate_exclusive_get(priv->clk);
+
+	chip->ops = &ttc_pwm_ops;
+	chip->npwm = TTC_PWM_MAX_CH;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret) {
+		clk_rate_exclusive_put(priv->clk);
+		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
+	}
+
+	platform_set_drvdata(pdev, priv);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ttc_pwm_probe);
+
+void ttc_pwm_remove(struct platform_device *pdev)
+{
+	struct ttc_pwm_priv *priv = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&priv->chip);
+	clk_rate_exclusive_put(priv->clk);
+}
+EXPORT_SYMBOL_GPL(ttc_pwm_remove);
+
+MODULE_AUTHOR("Mubin Sayyed <mubin.sayyed@amd.com>");
+MODULE_DESCRIPTION("Cadence TTC PWM driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/timer-cadence-ttc.h b/include/linux/timer-cadence-ttc.h
index d938991371e5..6b6135d0ba0c 100644
--- a/include/linux/timer-cadence-ttc.h
+++ b/include/linux/timer-cadence-ttc.h
@@ -12,13 +12,14 @@
 #define TTC_CNT_CNTRL_OFFSET            0x0C /* Counter Control Reg, RW */
 #define TTC_COUNT_VAL_OFFSET            0x18 /* Counter Value Reg, RO */
 #define TTC_INTR_VAL_OFFSET             0x24 /* Interval Count Reg, RW */
+#define TTC_MATCH_CNT_VAL_OFFSET        0x30 /* Match Count Reg, RW */
 #define TTC_ISR_OFFSET          0x54 /* Interrupt Status Reg, RO */
 #define TTC_IER_OFFSET          0x60 /* Interrupt Enable Reg, RW */
 
 #define TTC_CNT_CNTRL_DISABLE_MASK      0x1
 
 #define TTC_CLK_CNTRL_CSRC_MASK         (1 << 5)        /* clock source */
-#define TTC_CLK_CNTRL_PSV_MASK          0x1e
+#define TTC_CLK_CNTRL_PSV_MASK		0x1e
 #define TTC_CLK_CNTRL_PSV_SHIFT         1
 
 /*
@@ -33,3 +34,22 @@
 
 #define MAX_F_ERR 50
 
+#define TTC_PWM_CHANNEL         0x4
+
+#define TTC_CLK_CNTRL_CSRC              BIT(5)
+#define TTC_CLK_CNTRL_PS_EN             BIT(0)
+#define TTC_CNTR_CTRL_DIS               BIT(0)
+#define TTC_CNTR_CTRL_INTR_MODE_EN      BIT(1)
+#define TTC_CNTR_CTRL_MATCH_MODE_EN     BIT(3)
+#define TTC_CNTR_CTRL_RST               BIT(4)
+#define TTC_CNTR_CTRL_WAVE_EN   BIT(5)
+#define TTC_CNTR_CTRL_WAVE_POL  BIT(6)
+#define TTC_CNTR_CTRL_WAVE_POL_SHIFT    6
+#define TTC_CNTR_CTRL_PRESCALE_SHIFT    1
+#define TTC_PWM_MAX_CH	3
+
+#if defined(CONFIG_PWM_CADENCE)
+int ttc_pwm_probe(struct platform_device *pdev);
+void ttc_pwm_remove(struct platform_device *pdev);
+#endif
+
-- 
2.25.1


