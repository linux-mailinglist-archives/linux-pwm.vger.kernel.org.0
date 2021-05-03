Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1537229F
	for <lists+linux-pwm@lfdr.de>; Mon,  3 May 2021 23:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhECVp1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 May 2021 17:45:27 -0400
Received: from mail-db8eur05on2041.outbound.protection.outlook.com ([40.107.20.41]:41569
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229499AbhECVp0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 3 May 2021 17:45:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bW2WqkDkoLklIJ11SM0XB0dKVhnq7jIHAuzyFdMkdKZZbdOXhlhSyHZFO46kJJPkKwRNmqoIO9+M23JMKyAKWtlPKa+0kHp/zzVDtJVIWDu7dZ7r/tMjcZWwkOWd/VOzlDqc8zlbxQ5wZr20qEmRmqDIMDweHyooPmOQDFDGha7bW2+DWy+SsfkgJrMkpcjc73glqa3T51qMUvODZ1cQb/3Ahn894f1CGX7GiZaLF8qCtZLUtgLx5GTySWKawbO7GbbC9wjhZjasiXjqiSqtPsM2n5ZyAtsMaTzbpFri5eqk3GMm7Gh+O7r4l52eyRK8ekHaBhe0dL4P92QUCKnefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXCVqm/S7dCuak2dS+LiOG2n7JZRATSsDVG6QKy2BX8=;
 b=goOIFpATof17Y5/D+3izTshPwuW1v/3rHkk+rcIGTq7thp5fOb12cweOlGeDJYguNOTd4W0WBqs+49UJxo1TJQtmQVZArXCWtFs/ECoiskXSfuw7BdeJdmVbV0cgNHYVM5VJjZF8Adr91a0bOt9kRDbSdIz5BguFTOacR+byS9vvjoJUXNhwNk8iiAEqZQlFlXbTD0sFxDNKL0p+lXwgvcz30YCAjZoMUQoaLt8IKuwapnzlPxrWaZZBY9Iy1nyOuMBqezEeVkwRgNpvyZiioLNp4orrS0LuInj+Oq5r4sQjdA3hSU+qDicH+lK04PqZlEXNlwzG1FLilRvS/16sdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXCVqm/S7dCuak2dS+LiOG2n7JZRATSsDVG6QKy2BX8=;
 b=h/a9/0BrcyqkTgVr9gEnOdfk830ZEtmUcvT4NfgGOJdT0xAvGhnTTfi0KceGbp0R6lvoNlRisb0/YwK9aizQtawXZc/fBMl3HUDQSvgIOH0VAYNZxMf3ZesaaZosGL+hxBGq5cZ8CQx7SHxTsWLq+DB3IcYTrzo4dNC+oU+CuFc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6201.eurprd03.prod.outlook.com (2603:10a6:10:13f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39; Mon, 3 May
 2021 21:44:30 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 21:44:30 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@xilinx.com, Sean Anderson <sean.anderson@seco.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] pwm: Add support for Xilinx AXI Timer
Date:   Mon,  3 May 2021 17:44:13 -0400
Message-Id: <20210503214413.3145015-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503214413.3145015-1-sean.anderson@seco.com>
References: <20210503214413.3145015-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::36) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:208:1b4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 21:44:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84109644-c88d-4a5a-ec39-08d90e7ca1fc
X-MS-TrafficTypeDiagnostic: DB8PR03MB6201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR03MB6201A5DB8B0C70A84C0FD025965B9@DB8PR03MB6201.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPZeQjjETR/lXOzGb8ry58hJim4FzXCQDBfOpUQWKK5cfX3uU+JV5rpyNxTAAHzPdqctpoUq9P12kp3l4r2kZ6yrrfnUIi05Ojs9wgkrbDbiBlDfcFEHL9ULlkxvcGzBV5M0G813Lb0jE0n0mngxaIXecS569/JKRZD85xKEeMb8nQkQnAJX8o98NojQei6yASc6hc1s26v/KIep13y9LdflzDoOgBcd54olH/+1LrvdCXFuDUT0K+rEqzR4MMNIYpXw28sjy0EV/Fy5VxH9QtwgLfT/k465mG0e195Q2MMGzoZqMCnFS3gLRIOI+VSNn4voRjR9UtwwBRLiV8EPOLmBNNT6DsFy72LF7E96imJVN8dqlwuF2h/rVZaylRKtBL/5PEevzeF6OQCW7UxqrLmiOOccV0ztBzte7yZUfkMPEjho42oQD4ivR7ONFYO4d2tRmtwQaVedyPUPEhs344kaSFbOXUwKxUpaHFCWVQmmzYK6s/dxRishUHwQzapyPd79bJmDYnz7BcIj5znnwcz5YMfbev8Hh6PwWKRbzNNb/Owof9TST7pLS2XaMZWXi2b9UNMGZ3n/PcpX+YN6mtYjUIZoXIqGD6ppld2mub3n4oQXcbP1L0M6sMHMDfqwLcm7MOI04E8i1QXLzeSZB4D1DKmAOCmo9YBj+PWIcsWBkc/a1OCDOZRrm9+Q7SXdMb3BtPANAh6ZnQSGbOSz7dRjC/bWe8kfsm3r51YdEKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(8676002)(44832011)(1076003)(66556008)(66946007)(2906002)(54906003)(186003)(38350700002)(66476007)(38100700002)(83380400001)(6512007)(36756003)(30864003)(26005)(16526019)(52116002)(5660300002)(4326008)(6506007)(6486002)(8936002)(508600001)(6666004)(956004)(86362001)(2616005)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VzNuWHp5MnBNVDZvWVA5WENtR3lmaGVWTjJiR29WRjFlM3Y1RSs4ckR4NzBM?=
 =?utf-8?B?QnJJWWxVRWplVjZZOW80NEZGVnRRZHVzL0FtTWpIYWxWQlRIZVBoTVhBV1Fw?=
 =?utf-8?B?VWlXSUpSSFk4c1p1VGpjVWdNRlFLWkwrM1JFZndXZXFaRGNydUl5WVJUSnhS?=
 =?utf-8?B?ZXJoWVFIWm1pUS9rYTMzT3lxWEJBR0p0U1poUXNxdGVmNDFJUjd1MnkwQTMv?=
 =?utf-8?B?a0FwMGF2MEJBL0xteVdCYVFYQXlNLzJURnZOYzNucVVQWjVLRmFEcHRrelBy?=
 =?utf-8?B?YnBBZ1RSTzBsUmxrMUtONENJRG1PZzR3ck1sUGJoaWZJM0JyMWhFTW1mYURH?=
 =?utf-8?B?SlNwajd1R1ZvQnFHNm9OZm9EeHhXTEpOK1BTQkdESFJoV2tJVitrZHRrTmxS?=
 =?utf-8?B?TVVabFZ0VFMvVmhUc2p4Q3M2MnZPSVNvdGQvSmNQZHJoa3kxYUlhVE5aeUJO?=
 =?utf-8?B?djRod0U2U055RGdCRjRMSlB0VDZqS2JsMmg5WmhwcExZSjIvcXBwR0FzTTE4?=
 =?utf-8?B?dVA1VWo3OFpjMllvNlVYQnA4M2tjaEVFcG1wSCs2V2hYWERHVVU5Z3BMOW1B?=
 =?utf-8?B?RkZ3UTVSUU1vcm50U3Nkb2UxTXRRS3VzZ3JUTDR5aEpScW1JbXM5ZitFTnhr?=
 =?utf-8?B?ZG4zWVE2WTR0Yk93N2J3RzdENld5KzRDbDJBWjJSWCtpMkU0TG9pY3ptSndM?=
 =?utf-8?B?ZXpMZld1dGNPS29NUUh1Mm4wWkE1N0RZRHlPcEZVOFJhLzdPN0pIVW9wM3J1?=
 =?utf-8?B?MmdaRWhRZ3JSQ2l0MVlVbXJWU282RjIwOUN3QS8zbkR0MklvZ1JBUjVXeElR?=
 =?utf-8?B?Ymo2U3NhUSs1bTlXWGczWTlpeHdmSVFuSnJMcFdPTkJjdVlKdjdrVTAxSkhx?=
 =?utf-8?B?bnJGdlhsTmRqZGxPLy96dVhrTkZLNDVibkNqSXVxVkNnS0RJWUtiaHNFSi9K?=
 =?utf-8?B?R0tVaFFLN0Fhbkg4aWw4akQ3QWJhSDBoSTFBU0hxUm4rcUZYRTdzMi9WdGtC?=
 =?utf-8?B?cmN1YURUbTVGaCt4VVVkYjZXSmtDajlWVnFkb2RlSXJwbWpqa3Y4dDlFeGNr?=
 =?utf-8?B?NDNtVnJ3OXZGampqYjQ0cm9OSEVpdkZicW5XTUIvazVrdUwrcm52VDJ3RS9p?=
 =?utf-8?B?WGpZTDBOOGNTcklJNzBOVjJtVTFueUE4NGFxTmRVV0VIRXEvbmlCQjdhekIv?=
 =?utf-8?B?QVdnWjdGanBEcm84WkdnbE11NDlWdWxUZWRUcUd6eHRsVUltVjhIMXJEZ0xy?=
 =?utf-8?B?cG80cFNvNnZvRXJBTlVxcnpzSG85b0ZWMi9Fa2VERk1nLzg2UTRQc09KUFNq?=
 =?utf-8?B?RllPdUJmRjY0V0o0amVuWU1MQXhKV3hmTTh4WkRQUWdFSDFjOUlhdlpJYjFm?=
 =?utf-8?B?cENuYllCclZ1R3RKb3E1ZUdwTjRDaG8xMGtxUHpzMFdrakl4SURmZ2RJbVZ3?=
 =?utf-8?B?MGYwU3N0a3E3NmRVbjhKa29jck9CYW5YWlZBR1IxWkIyd2JJeHYzdXJ6a0Zo?=
 =?utf-8?B?dkM0ekxRa213ZkxxeHNTcmtwMnBlb25mRENmY0NuL0xQSUJsM1crSUI3K0Yv?=
 =?utf-8?B?L2U1bU5vMXFmTHpJamI1QkhndUYzUVdzSzJGdjR1QkdZUFh2Uys1OW13UkZH?=
 =?utf-8?B?Y1FZeC8xRmVna3JIWTE0ekJreGFwWVkyWFpBQy9PNHdnNk5uR2ZkL0JGWG5q?=
 =?utf-8?B?WWQydEFyamNxMTc3K25qbFdMMVdoakZqU0FnOWdNRzdUTlcyQ1FqT3d3TGhn?=
 =?utf-8?Q?AfgJbgFZB0nHHmdAH2HtEBMC/XHvw/smKJeAbGQ?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84109644-c88d-4a5a-ec39-08d90e7ca1fc
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 21:44:30.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0g6cU2NBgNqRIGK14KdsGcrWWbcZlZ3yJLTeGuMdJgpTrakaKuPKdXgXaftbquVFOhBa9VKP4TXaukMChijJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6201
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
found on Xilinx FPGAs. There is another driver for this device located
at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
This driver was written with reference to Xilinx DS764 for v1.03.a [1].

[1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf

Signed-off-by: Sean Anderson <sean.anderson@seco.com>

---

 arch/arm64/configs/defconfig |   1 +
 drivers/pwm/Kconfig          |  11 ++
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-xilinx.c     | 322 +++++++++++++++++++++++++++++++++++
 4 files changed, 335 insertions(+)
 create mode 100644 drivers/pwm/pwm-xilinx.c

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 08c6f769df9a..81794209f287 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1083,6 +1083,7 @@ CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
 CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
+CONFIG_PWM_XILINX=m
 CONFIG_SL28CPLD_INTC=y
 CONFIG_QCOM_PDC=y
 CONFIG_RESET_IMX7=y
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index d3371ac7b871..01e62928f4bf 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -628,4 +628,15 @@ config PWM_VT8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-vt8500.
 
+config PWM_XILINX
+	tristate "Xilinx AXI Timer PWM support"
+	depends on !MICROBLAZE
+	help
+	  PWM framework driver for Xilinx LogiCORE IP AXI Timers. This
+	  timer is typically a soft core which may be present in Xilinx
+	  FPGAs. If you don't have this IP in your design, choose N.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-xilinx.
+
 endif
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index d3879619bd76..fc1bd6ccc9ed 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
 obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
+obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
new file mode 100644
index 000000000000..240bd2993f97
--- /dev/null
+++ b/drivers/pwm/pwm-xilinx.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ */
+#include <asm/io.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define TCSR0	0x00
+#define TLR0	0x04
+#define TCR0	0x08
+#define TCSR1	0x10
+#define TLR1	0x14
+#define TCR1	0x18
+
+#define TCSR_MDT	BIT(0)
+#define TCSR_UDT	BIT(1)
+#define TCSR_GENT	BIT(2)
+#define TCSR_CAPT	BIT(3)
+#define TCSR_ARHT	BIT(4)
+#define TCSR_LOAD	BIT(5)
+#define TCSR_ENIT	BIT(6)
+#define TCSR_ENT	BIT(7)
+#define TCSR_TINT	BIT(8)
+#define TCSR_PWMA	BIT(9)
+#define TCSR_ENALL	BIT(10)
+#define TCSR_CASC	BIT(11)
+
+/* Bits we need to set/clear to enable PWM mode, not including CASC */
+#define TCSR_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
+#define TCSR_CLEAR (TCSR_MDT | TCSR_LOAD)
+
+#define NSEC_PER_SEC_ULL 1000000000ULL
+
+/**
+ * struct xilinx_pwm_device - Driver data for Xilinx AXI timer PWM driver
+ * @chip: PWM controller chip
+ * @clk: Parent clock
+ * @regs: Base address of this device
+ * @width: Width of the counters, in bits
+ */
+struct xilinx_pwm_device {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *regs;
+	unsigned int width;
+};
+
+static inline struct xilinx_pwm_device *xilinx_pwm_chip_to_device(struct pwm_chip *chip)
+{
+	return container_of(chip, struct xilinx_pwm_device, chip);
+}
+
+static bool xilinx_pwm_is_enabled(u32 tcsr0, u32 tcsr1)
+{
+	return !(~tcsr0 & TCSR_SET || tcsr0 & (TCSR_CLEAR | TCSR_CASC) ||
+		 ~tcsr1 & TCSR_SET || tcsr1 & TCSR_CLEAR);
+}
+
+static u32 xilinx_pwm_calc_tlr(struct xilinx_pwm_device *pwm, u32 tcsr,
+			       unsigned int period)
+{
+	u64 cycles = DIV_ROUND_DOWN_ULL(period * clk_get_rate(pwm->clk),
+					NSEC_PER_SEC_ULL);
+
+	if (tcsr & TCSR_UDT)
+		return cycles - 2;
+	else
+		return (BIT_ULL(pwm->width) - 1) - cycles + 2;
+}
+
+static unsigned int xilinx_pwm_get_period(struct xilinx_pwm_device *pwm,
+					  u32 tlr, u32 tcsr)
+{
+	u64 cycles;
+
+	if (tcsr & TCSR_UDT)
+		cycles = tlr + 2;
+	else
+		cycles = (BIT_ULL(pwm->width) - 1) - tlr + 2;
+
+	return DIV_ROUND_DOWN_ULL(cycles * NSEC_PER_SEC_ULL,
+				  clk_get_rate(pwm->clk));
+}
+
+static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
+			    const struct pwm_state *state)
+{
+	struct xilinx_pwm_device *pwm = xilinx_pwm_chip_to_device(chip);
+	u32 tlr0, tlr1;
+	u32 tcsr0 = readl(pwm->regs + TCSR0);
+	u32 tcsr1 = readl(pwm->regs + TCSR1);
+	bool enabled = xilinx_pwm_is_enabled(tcsr0, tcsr1);
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!enabled && state->enabled)
+		clk_rate_exclusive_get(pwm->clk);
+
+	tlr0 = xilinx_pwm_calc_tlr(pwm, tcsr0, state->period);
+	tlr1 = xilinx_pwm_calc_tlr(pwm, tcsr1, state->duty_cycle);
+	writel(tlr0, pwm->regs + TLR0);
+	writel(tlr1, pwm->regs + TLR1);
+
+	if (state->enabled) {
+		/* Only touch the TCSRs if we aren't already running */
+		if (!enabled) {
+			/* Load TLR into TCR */
+			writel(tcsr0 | TCSR_LOAD, pwm->regs + TCSR0);
+			writel(tcsr1 | TCSR_LOAD, pwm->regs + TCSR1);
+			/* Enable timers all at once with ENALL */
+			tcsr0 = (TCSR_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
+			tcsr1 = TCSR_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
+			writel(tcsr0, pwm->regs + TCSR0);
+			writel(tcsr1, pwm->regs + TCSR1);
+		}
+	} else {
+		writel(tcsr0 & ~TCSR_ENT, pwm->regs + TCSR0);
+		writel(tcsr1 & ~TCSR_ENT, pwm->regs + TCSR1);
+	}
+
+	if (enabled && !state->enabled)
+		clk_rate_exclusive_put(pwm->clk);
+
+	return 0;
+}
+
+static void xilinx_pwm_get_state(struct pwm_chip *chip,
+				 struct pwm_device *unused,
+				 struct pwm_state *state)
+{
+	struct xilinx_pwm_device *pwm = xilinx_pwm_chip_to_device(chip);
+	u32 tlr0, tlr1, tcsr0, tcsr1;
+
+	tlr0 = readl(pwm->regs + TLR0);
+	tlr1 = readl(pwm->regs + TLR1);
+	tcsr0 = readl(pwm->regs + TCSR0);
+	tcsr1 = readl(pwm->regs + TCSR1);
+
+	state->period = xilinx_pwm_get_period(pwm, tlr0, tcsr0);
+	state->duty_cycle = xilinx_pwm_get_period(pwm, tlr1, tcsr1);
+	state->enabled = xilinx_pwm_is_enabled(tcsr0, tcsr1);
+	state->polarity = PWM_POLARITY_NORMAL;
+}
+
+static const struct pwm_ops xilinx_pwm_ops = {
+	.apply = xilinx_pwm_apply,
+	.get_state = xilinx_pwm_get_state,
+};
+
+static struct dentry *debug_dir;
+
+#define DEBUG_REG(reg) { .name = #reg, .offset = (reg), }
+static struct debugfs_reg32 xilinx_pwm_reg32[] = {
+	DEBUG_REG(TCSR0),
+	DEBUG_REG(TLR0),
+	DEBUG_REG(TCR0),
+	DEBUG_REG(TCSR1),
+	DEBUG_REG(TLR1),
+	DEBUG_REG(TCR1),
+};
+
+static int xilinx_pwm_debug_create(struct xilinx_pwm_device *pwm)
+{
+	struct debugfs_regset32 *regset;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return 0;
+
+	regset = devm_kzalloc(pwm->chip.dev, sizeof(*regset), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	regset->regs = xilinx_pwm_reg32;
+	regset->nregs = ARRAY_SIZE(xilinx_pwm_reg32);
+	regset->base = pwm->regs;
+
+	debugfs_create_regset32(dev_name(pwm->chip.dev), 0400, debug_dir,
+				regset);
+	return 0;
+}
+
+static int xilinx_pwm_probe(struct platform_device *pdev)
+{
+	bool enabled;
+	int i, ret;
+	struct device *dev = &pdev->dev;
+	struct xilinx_pwm_device *pwm;
+	u32 one_timer;
+
+	ret = of_property_read_u32(dev->of_node, "xlnx,one-timer-only",
+				   &one_timer);
+	if (ret || one_timer) {
+		dev_err(dev, "two timers are needed for PWM mode\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < 2; i++) {
+		char fmt[] = "xlnx,gen%u-assert";
+		char buf[sizeof(fmt)];
+		u32 gen;
+
+		snprintf(buf, sizeof(buf), fmt, i);
+		ret = of_property_read_u32(dev->of_node, buf, &gen);
+		if (ret || !gen) {
+			dev_err(dev, "generateout%u must be active high\n", i);
+			return -EINVAL;
+		}
+	}
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, pwm);
+
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &xilinx_pwm_ops;
+	pwm->chip.base = -1;
+	pwm->chip.npwm = 1;
+
+	pwm->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pwm->regs))
+		return PTR_ERR(pwm->regs);
+
+	ret = of_property_read_u32(dev->of_node, "xlnx,count-width", &pwm->width);
+	if (ret) {
+		dev_err(dev, "missing counter width\n");
+		return -EINVAL;
+	}
+
+	pwm->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pwm->clk))
+		return dev_err_probe(dev, PTR_ERR(pwm->clk), "missing clock\n");
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret) {
+		dev_err(dev, "clock enable failed\n");
+		return ret;
+	}
+
+	ret = xilinx_pwm_debug_create(pwm);
+	if (ret) {
+		clk_disable_unprepare(pwm->clk);
+		return ret;
+	}
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret) {
+		clk_disable_unprepare(pwm->clk);
+		return ret;
+	}
+
+	enabled = xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
+					readl(pwm->regs + TCSR1));
+	if (enabled)
+		clk_rate_exclusive_get(pwm->clk);
+
+	return ret;
+}
+
+static int xilinx_pwm_remove(struct platform_device *pdev)
+{
+	struct xilinx_pwm_device *pwm = platform_get_drvdata(pdev);
+	bool enabled = xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
+					     readl(pwm->regs + TCSR1));
+
+	if (enabled)
+		clk_rate_exclusive_put(pwm->clk);
+	clk_disable_unprepare(pwm->clk);
+	return pwmchip_remove(&pwm->chip);
+}
+
+static const struct of_device_id xilinx_pwm_of_match[] = {
+	{ .compatible = "xlnx,xps-timer-1.00.a" },
+	{ .compatible = "xlnx,axi-timer-2.0" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xilinx_pwm_of_match);
+
+static struct platform_driver xilinx_pwm_driver = {
+	.probe = xilinx_pwm_probe,
+	.remove = xilinx_pwm_remove,
+	.driver = {
+		.name = "xilinx-pwm",
+		.of_match_table = of_match_ptr(xilinx_pwm_of_match),
+	},
+};
+
+static int __init xilinx_pwm_init(void)
+{
+	int ret = platform_driver_register(&xilinx_pwm_driver);
+
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		debug_dir = debugfs_create_dir(xilinx_pwm_driver.driver.name, NULL);
+		if (IS_ERR(debug_dir)) {
+			platform_driver_unregister(&xilinx_pwm_driver);
+			return PTR_ERR(debug_dir);
+		}
+	}
+	return 0;
+}
+module_init(xilinx_pwm_init);
+
+static void __exit xilinx_pwm_exit(void)
+{
+	platform_driver_unregister(&xilinx_pwm_driver);
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		debugfs_remove_recursive(debug_dir);
+}
+module_exit(xilinx_pwm_exit);
+
+MODULE_ALIAS("platform:xilinx-pwm");
+MODULE_DESCRIPTION("Xilinx LogiCORE IP AXI Timer PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

