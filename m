Return-Path: <linux-pwm+bounces-5084-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23FCA4EA86
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 19:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE673188693A
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A3729C33F;
	Tue,  4 Mar 2025 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="js6Ia6v0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486F27BF89;
	Tue,  4 Mar 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110038; cv=none; b=bx6VkwqGkOtdwDVQ+jqEupbsp+bLiHMKgAI/NR3U6el0x1Dn63Fiw4heiKTLwMSY/CwikUBijldeRdnE9yH5a0pfIzjyz0J6KKPkmawZb6gTlpB7St61BAGgX7ZKYycmjzKpv5ogO5vGb3af//o8254NASxNxNFMs5eJj7DFwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110038; c=relaxed/simple;
	bh=fSxPBjRH4h6gBPl/RJgG33pFgulI5+NEcMQ0v6exYKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nypfwEjhaZMObcVY11wSm6vPP3aIOZVdnzvYFyUz4q1XnHbA5K8Q2f6HhTS6GELUuNMJvQ4deF0E0BKRf1O2aCyhXZvn2K7LRwV51rl9m7xTnFvZRziFWGtNVcRTGN15MSw3i775t1I+pGWTQddSMngjucvk4ppm4IKzQS0baD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=js6Ia6v0; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524FlZOw015142;
	Tue, 4 Mar 2025 18:40:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	58rBYpw4Z7sNK8BbzGqHO/foCjMOd37qPIMpapYzMJA=; b=js6Ia6v0jejZCERL
	v4PUE8obmSRD3PLEtzBGJLbS2d0rbXm07UOEHrCB6j/86gsrUSj/OhkGJCnhgSi5
	qVcnMR0naoQ0E0bWXdKUJ4iEGcUgDLpy4T98/8XOrBrhFZhcpBsdGh0TMo6DpwSl
	Vpz2iSE8n+a2DfmxTlzqJmByt64bMCEeLdKuA6zDKE43OnG2kPxp3K9qTM3GTBvv
	lWvMsneMNEl08tcctzZB73YAx8F8vKVjB+M8WL6eZ/fL5pcFOaVMvFeLFrnTmzQt
	FmyEiWOjGwLc+bYjC7hz0A7ZJylfR+UVuR9ey7/ur/Cs0xnTXhZm3OLEN0+A2+0o
	0GCCOA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 453tf5nsgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 18:40:09 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3995F40069;
	Tue,  4 Mar 2025 18:39:00 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B82A55944E4;
	Tue,  4 Mar 2025 18:32:47 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 18:32:47 +0100
Received: from localhost (10.252.16.143) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 18:32:47 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jic23@kernel.org>, <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <wbg@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 2/8] mfd: stm32-lptimer: add support for stm32mp25
Date: Tue, 4 Mar 2025 18:32:23 +0100
Message-ID: <20250304173229.3215445-3-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250304173229.3215445-1-fabrice.gasnier@foss.st.com>
References: <20250304173229.3215445-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01

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
Changes in V2:
- rely on fallback compatible as no specific .data is associated to the
  driver. Compatibility is added by reading hardware configuration
  registers.
- read version register, to be used by clockevent child driver
- rename register/bits definitions
---
 drivers/mfd/stm32-lptimer.c       | 33 ++++++++++++++++++++++++++++-
 include/linux/mfd/stm32-lptimer.h | 35 ++++++++++++++++++++++++++++---
 2 files changed, 64 insertions(+), 4 deletions(-)

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
index 06d3f11dc3c9..30ebd3152e1a 100644
--- a/include/linux/mfd/stm32-lptimer.h
+++ b/include/linux/mfd/stm32-lptimer.h
@@ -17,20 +17,28 @@
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
+#define STM32_LPTIM_CMP2_ARROK		(BIT(19) | BIT(4))
 #define STM32_LPTIM_CMPOK_ARROK		GENMASK(4, 3)
 #define STM32_LPTIM_ARROK		BIT(4)
 #define STM32_LPTIM_CMPOK		BIT(3)
 
 /* STM32_LPTIM_ICR - bit fields */
-#define STM32_LPTIM_ARRMCF		BIT(1)
+#define STM32_LPTIM_CMP2OKCF_ARROKCF	(BIT(19) | BIT(4))
 #define STM32_LPTIM_CMPOKCF_ARROKCF	GENMASK(4, 3)
+#define STM32_LPTIM_ARRMCF		BIT(1)
 
-/* STM32_LPTIM_IER - bit flieds */
+/* STM32_LPTIM_IER - bit fields */
 #define STM32_LPTIM_ARRMIE	BIT(1)
 
 /* STM32_LPTIM_CR - bit fields */
@@ -53,16 +61,37 @@
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


