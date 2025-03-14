Return-Path: <linux-pwm+bounces-5197-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BB6A61804
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 18:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345D51895811
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC853205AB5;
	Fri, 14 Mar 2025 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WGU9xbYa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E6204C1E;
	Fri, 14 Mar 2025 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973688; cv=none; b=LR34FnBxKanQJsJ9zhErNbeQCecs6DlqI4pu8GHL21FYtmuGoHEYugsbN4QyWQgR9j+yapEOPs+eWuSarKOtmEZmJQAdeD+lMnzwNu+v1R6sldiHU+yJbi95VlEf+MRXXqhXkG80vsGUGBbxk1JXGVJL1AVfSzZEMecZh4XptHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973688; c=relaxed/simple;
	bh=U5MMQFHxw78UV6NeufGa5RtZZATSDj5zBCoLHzxmYcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajAyzFd1I4VT2tXEs0m2g9Er30spf+IEQzVrD3WA60gd3NJe7zG2rvMNpt+IQLUvsvyH4nrdI8gXjjjbout9MF6V9lXL8GiBzUCX7IZIMriatHD2tl/rGZf1uacMEy0CH4EWD26iHC5s6qb3j0bnswPK3t1rWJoz/VdDxyRghJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WGU9xbYa; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EEjmbX003926;
	Fri, 14 Mar 2025 18:34:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Fxe+1BqeMw88KkIco0sHqplA8QMWdxh1ONHDTZ6Mzls=; b=WGU9xbYaKLNEOuGL
	y0U8qc7X8WjIIQDLmGl5di9XXmw9rMg2BSdHa6jsBVAJR2H1Tgb9ewnYBgtC1ie/
	xYVpFaQOSTX0O6u3NB6RqAaMwRV8Mf3FTC6MKv5tWQWitYMJASY5RsfMV6LAOBQZ
	6gjzIcNgtz9ixvX1BaEM2y1y6+ViAf7kTOtd18PWiiP4G9nEI8ftlhjVJJRCjkzm
	fijz7x1utZp5CD4GrUxKDRIVR8e0ghSOkfTpNOnsKcQGX0+4A379iLTL6s/yXEo8
	O/X7eI4JFC4T8SqRNpBdGLTtUXpU5KZwJObbivmu2HU9/dw3jeAsScWI+jCE5/TG
	IyPHfg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45c2pf5ee2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 18:34:13 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4560540062;
	Fri, 14 Mar 2025 18:33:04 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 94AAF6D8E74;
	Fri, 14 Mar 2025 18:15:05 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 18:15:05 +0100
Received: from localhost (10.252.1.141) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 18:15:05 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jic23@kernel.org>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <robh@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>, <wbg@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v4 2/8] mfd: stm32-lptimer: add support for stm32mp25
Date: Fri, 14 Mar 2025 18:14:45 +0100
Message-ID: <20250314171451.3497789-3-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
References: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_06,2025-03-14_01,2024-11-22_01

Add support for STM32MP25 SoC.
A new hardware configuration register (HWCFGR2) has been added, to gather
number of capture/compare channels, autonomous mode and input capture
capability. The full feature set is implemented in LPTIM1/2/3/4. LPTIM5
supports a smaller set of features. This can now be read from HWCFGR
registers.

Add new registers to the stm32-lptimer.h: CCMR1, CCR2, HWCFGR1/2 and VERR.
Update the stm32_lptimer data struct so signal the number of
capture/compare channels to the child devices.
Also Remove some unused bit masks (CMPOK_ARROK / CMPOKCF_ARROKCF).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in V4:
- Add DIEROK, ARROK status flags, and their clear flags.
Changes in V2:
- rely on fallback compatible as no specific .data is associated to the
  driver. Compatibility is added by reading hardware configuration
  registers.
- read version register, to be used by clockevent child driver
- rename register/bits definitions
---
 drivers/mfd/stm32-lptimer.c       | 33 ++++++++++++++++++++++++++-
 include/linux/mfd/stm32-lptimer.h | 37 ++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/stm32-lptimer.c b/drivers/mfd/stm32-lptimer.c
index b2704a9809c7..09073dbc9c80 100644
--- a/drivers/mfd/stm32-lptimer.c
+++ b/drivers/mfd/stm32-lptimer.c
@@ -6,6 +6,7 @@
  * Inspired by Benjamin Gaignard's stm32-timers driver
  */
 
+#include <linux/bitfield.h>
 #include <linux/mfd/stm32-lptimer.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -49,6 +50,36 @@ static int stm32_lptimer_detect_encoder(struct stm32_lptimer *ddata)
 	return 0;
 }
 
+static int stm32_lptimer_detect_hwcfgr(struct stm32_lptimer *ddata)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(ddata->regmap, STM32_LPTIM_VERR, &ddata->version);
+	if (ret)
+		return ret;
+
+	/* Try to guess parameters from HWCFGR: e.g. encoder mode (STM32MP15) */
+	ret = regmap_read(ddata->regmap, STM32_LPTIM_HWCFGR1, &val);
+	if (ret)
+		return ret;
+
+	/* Fallback to legacy init if HWCFGR isn't present */
+	if (!val)
+		return stm32_lptimer_detect_encoder(ddata);
+
+	ddata->has_encoder = FIELD_GET(STM32_LPTIM_HWCFGR1_ENCODER, val);
+
+	ret = regmap_read(ddata->regmap, STM32_LPTIM_HWCFGR2, &val);
+	if (ret)
+		return ret;
+
+	/* Number of capture/compare channels */
+	ddata->num_cc_chans = FIELD_GET(STM32_LPTIM_HWCFGR2_CHAN_NUM, val);
+
+	return 0;
+}
+
 static int stm32_lptimer_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -73,7 +104,7 @@ static int stm32_lptimer_probe(struct platform_device *pdev)
 	if (IS_ERR(ddata->clk))
 		return PTR_ERR(ddata->clk);
 
-	ret = stm32_lptimer_detect_encoder(ddata);
+	ret = stm32_lptimer_detect_hwcfgr(ddata);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mfd/stm32-lptimer.h b/include/linux/mfd/stm32-lptimer.h
index 06d3f11dc3c9..a592c8dc716d 100644
--- a/include/linux/mfd/stm32-lptimer.h
+++ b/include/linux/mfd/stm32-lptimer.h
@@ -17,20 +17,30 @@
 #define STM32_LPTIM_IER		0x08	/* Interrupt Enable Reg      */
 #define STM32_LPTIM_CFGR	0x0C	/* Configuration Reg         */
 #define STM32_LPTIM_CR		0x10	/* Control Reg               */
-#define STM32_LPTIM_CMP		0x14	/* Compare Reg               */
+#define STM32_LPTIM_CMP		0x14	/* Compare Reg (MP25 CCR1)   */
 #define STM32_LPTIM_ARR		0x18	/* Autoreload Reg            */
 #define STM32_LPTIM_CNT		0x1C	/* Counter Reg               */
+#define STM32_LPTIM_CCMR1	0x2C	/* Capture/Compare Mode MP25 */
+#define STM32_LPTIM_CCR2	0x34	/* Compare Reg2 MP25         */
+
+#define STM32_LPTIM_HWCFGR2	0x3EC	/* Hardware configuration register 2 - MP25 */
+#define STM32_LPTIM_HWCFGR1	0x3F0	/* Hardware configuration register 1 - MP15 */
+#define STM32_LPTIM_VERR	0x3F4	/* Version identification register - MP15 */
 
 /* STM32_LPTIM_ISR - bit fields */
+#define STM32_LPTIM_DIEROK_ARROK	(BIT(24) | BIT(4)) /* MP25 */
+#define STM32_LPTIM_CMP2_ARROK		(BIT(19) | BIT(4))
 #define STM32_LPTIM_CMPOK_ARROK		GENMASK(4, 3)
 #define STM32_LPTIM_ARROK		BIT(4)
 #define STM32_LPTIM_CMPOK		BIT(3)
 
 /* STM32_LPTIM_ICR - bit fields */
-#define STM32_LPTIM_ARRMCF		BIT(1)
+#define STM32_LPTIM_DIEROKCF_ARROKCF	(BIT(24) | BIT(4)) /* MP25 */
+#define STM32_LPTIM_CMP2OKCF_ARROKCF	(BIT(19) | BIT(4))
 #define STM32_LPTIM_CMPOKCF_ARROKCF	GENMASK(4, 3)
+#define STM32_LPTIM_ARRMCF		BIT(1)
 
-/* STM32_LPTIM_IER - bit flieds */
+/* STM32_LPTIM_IER - bit fields */
 #define STM32_LPTIM_ARRMIE	BIT(1)
 
 /* STM32_LPTIM_CR - bit fields */
@@ -53,16 +63,37 @@
 /* STM32_LPTIM_ARR */
 #define STM32_LPTIM_MAX_ARR	0xFFFF
 
+/* STM32_LPTIM_CCMR1 */
+#define STM32_LPTIM_CC2P	GENMASK(19, 18)
+#define STM32_LPTIM_CC2E	BIT(17)
+#define STM32_LPTIM_CC2SEL	BIT(16)
+#define STM32_LPTIM_CC1P	GENMASK(3, 2)
+#define STM32_LPTIM_CC1E	BIT(1)
+#define STM32_LPTIM_CC1SEL	BIT(0)
+
+/* STM32_LPTIM_HWCFGR1 */
+#define STM32_LPTIM_HWCFGR1_ENCODER	BIT(16)
+
+/* STM32_LPTIM_HWCFGR2 */
+#define STM32_LPTIM_HWCFGR2_CHAN_NUM	GENMASK(3, 0)
+
+/* STM32_LPTIM_VERR */
+#define STM32_LPTIM_VERR_23	0x23	/* STM32MP25 */
+
 /**
  * struct stm32_lptimer - STM32 Low-Power Timer data assigned by parent device
  * @clk: clock reference for this instance
  * @regmap: register map reference for this instance
  * @has_encoder: indicates this Low-Power Timer supports encoder mode
+ * @num_cc_chans: indicates the number of capture/compare channels
+ * @version: indicates the major and minor revision of the controller
  */
 struct stm32_lptimer {
 	struct clk *clk;
 	struct regmap *regmap;
 	bool has_encoder;
+	unsigned int num_cc_chans;
+	u32 version;
 };
 
 #endif
-- 
2.25.1


