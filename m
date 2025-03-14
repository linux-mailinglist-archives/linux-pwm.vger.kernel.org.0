Return-Path: <linux-pwm+bounces-5198-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A787A61808
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 18:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D08F1B62FB1
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49AF205E0D;
	Fri, 14 Mar 2025 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RXR41HGI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A35E204C1F;
	Fri, 14 Mar 2025 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973689; cv=none; b=BIOl7klgfjhPc+VEFQEaNpq8LquM257nA2Xj4q/fG/K6gHvGt42dcO/fNHwByVEep5Xnd+L7FXxwhrqCetv9un10+c4cT0bHhHtmJlAESLtjN3pTMNeaICCuV5NqKmjtJp51ZJkIuJBaqOqjE9q4M5XqEbLMgjzf3sPQJf+4Qps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973689; c=relaxed/simple;
	bh=5smBgsmhlFXVPAMELup/d2eBnYKdmHwOUDgUP0bXgRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H71Jnxy7ZKNij6ft+u+nApOVWRGOQ0LOpcz30T2F2CC9D6JMXbv8U5rKnX1ywqEpJaAuoXRv3JpVKtAt0HwW6ZSXhv6mUFq5q/S6fMadP1r+4hZj17mblotQOGngYaUiNhT9NpW6TMxJavzkHmuEe9scZWM1tJIRxDJkpDoX8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RXR41HGI; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EF9COC003789;
	Fri, 14 Mar 2025 18:34:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	gezTHsVlAbOOGNmXRsSZoPC1L0mktoTM+MvlRK4ol90=; b=RXR41HGIO3F/xr6H
	rRaV8lX2yPYPdkOeuNbonUw5ZjAUyoRi9Lw9H+Bi843eaXBo+2jcBXCLqNHhW6Gx
	edIZgTjtCV2O+EfU6ehlc6yNOquQFV84AItFDVxa/04Z0FTlkmIRsP0fIlANX295
	I8cAiLXgqHdKw0iiXdPX8vYxMbf2dV7ZQOyMjlRsiQFrRQ7b/kTRYj/jLX3+s+fM
	3llPObQIWOesiZFQUkQtu/mUqMm/lASx0TXtE9Ay4PIq4nWC4OYru6SMpF6vngsV
	95VDAGPwGIjL5cqI68SPRPvT+ZdWosZAhCqWD52FCDrMp/0hPAAbuI2f/UjimxZM
	aRNmZg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45c2pf5eet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 18:34:29 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5061840068;
	Fri, 14 Mar 2025 18:33:05 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6BABE6D07BA;
	Fri, 14 Mar 2025 18:15:06 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 18:15:06 +0100
Received: from localhost (10.252.1.141) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 18:15:06 +0100
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
Subject: [PATCH v4 3/8] iio: trigger: stm32-lptimer: add support for stm32mp25
Date: Fri, 14 Mar 2025 18:14:46 +0100
Message-ID: <20250314171451.3497789-4-fabrice.gasnier@foss.st.com>
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

From: Olivier Moysan <olivier.moysan@foss.st.com>

Add support for STM32MP25 SoC. Use newly introduced compatible to handle
this new HW variant. Add new trigger definitions that can be used by the
stm32 analog-to-digital converter. Use compatible data to identify them.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Jonathan's comment: simplify infrastructure by keeping
  devm_iio_trigger_register. Don't need to cast compatible data.
---
 drivers/iio/trigger/stm32-lptimer-trigger.c   | 75 ++++++++++++++-----
 include/linux/iio/timer/stm32-lptim-trigger.h |  9 +++
 2 files changed, 67 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
index f1e18913236a..3dcc8d2fe093 100644
--- a/drivers/iio/trigger/stm32-lptimer-trigger.c
+++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
@@ -16,16 +16,43 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
-/* List Low-Power Timer triggers */
-static const char * const stm32_lptim_triggers[] = {
-	LPTIM1_OUT,
-	LPTIM2_OUT,
-	LPTIM3_OUT,
+/* Maximum triggers + one trailing null entry to indicate the end of array */
+#define MAX_TRIGGERS 3
+
+struct stm32_lptim_cfg {
+	const char * const (*triggers)[MAX_TRIGGERS];
+	unsigned int nb_triggers;
+};
+
+/* List Low-Power Timer triggers for H7, MP13, MP15 */
+static const char * const stm32_lptim_triggers[][MAX_TRIGGERS] = {
+	{ LPTIM1_OUT,},
+	{ LPTIM2_OUT,},
+	{ LPTIM3_OUT,},
+};
+
+/* List Low-Power Timer triggers for STM32MP25 */
+static const char * const stm32mp25_lptim_triggers[][MAX_TRIGGERS] = {
+	{ LPTIM1_CH1, LPTIM1_CH2, },
+	{ LPTIM2_CH1, LPTIM2_CH2, },
+	{ LPTIM3_CH1,},
+	{ LPTIM4_CH1,},
+	{ LPTIM5_OUT,},
+};
+
+static const struct stm32_lptim_cfg stm32mp15_lptim_cfg = {
+	.triggers = stm32_lptim_triggers,
+	.nb_triggers = ARRAY_SIZE(stm32_lptim_triggers),
+};
+
+static const struct stm32_lptim_cfg stm32mp25_lptim_cfg = {
+	.triggers = stm32mp25_lptim_triggers,
+	.nb_triggers = ARRAY_SIZE(stm32mp25_lptim_triggers),
 };
 
 struct stm32_lptim_trigger {
 	struct device *dev;
-	const char *trg;
+	const char * const *triggers;
 };
 
 static int stm32_lptim_validate_device(struct iio_trigger *trig,
@@ -56,22 +83,33 @@ EXPORT_SYMBOL(is_stm32_lptim_trigger);
 
 static int stm32_lptim_setup_trig(struct stm32_lptim_trigger *priv)
 {
-	struct iio_trigger *trig;
+	const char * const *cur = priv->triggers;
+	int ret;
 
-	trig = devm_iio_trigger_alloc(priv->dev, "%s", priv->trg);
-	if  (!trig)
-		return -ENOMEM;
+	while (cur && *cur) {
+		struct iio_trigger *trig;
 
-	trig->dev.parent = priv->dev->parent;
-	trig->ops = &stm32_lptim_trigger_ops;
-	iio_trigger_set_drvdata(trig, priv);
+		trig = devm_iio_trigger_alloc(priv->dev, "%s", *cur);
+		if  (!trig)
+			return -ENOMEM;
 
-	return devm_iio_trigger_register(priv->dev, trig);
+		trig->dev.parent = priv->dev->parent;
+		trig->ops = &stm32_lptim_trigger_ops;
+		iio_trigger_set_drvdata(trig, priv);
+
+		ret = devm_iio_trigger_register(priv->dev, trig);
+		if (ret)
+			return ret;
+		cur++;
+	}
+
+	return 0;
 }
 
 static int stm32_lptim_trigger_probe(struct platform_device *pdev)
 {
 	struct stm32_lptim_trigger *priv;
+	struct stm32_lptim_cfg const *lptim_cfg;
 	u32 index;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -81,17 +119,20 @@ static int stm32_lptim_trigger_probe(struct platform_device *pdev)
 	if (device_property_read_u32(&pdev->dev, "reg", &index))
 		return -EINVAL;
 
-	if (index >= ARRAY_SIZE(stm32_lptim_triggers))
+	lptim_cfg = device_get_match_data(&pdev->dev);
+
+	if (index >= lptim_cfg->nb_triggers)
 		return -EINVAL;
 
 	priv->dev = &pdev->dev;
-	priv->trg = stm32_lptim_triggers[index];
+	priv->triggers = lptim_cfg->triggers[index];
 
 	return stm32_lptim_setup_trig(priv);
 }
 
 static const struct of_device_id stm32_lptim_trig_of_match[] = {
-	{ .compatible = "st,stm32-lptimer-trigger", },
+	{ .compatible = "st,stm32-lptimer-trigger", .data = &stm32mp15_lptim_cfg },
+	{ .compatible = "st,stm32mp25-lptimer-trigger", .data = &stm32mp25_lptim_cfg},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_lptim_trig_of_match);
diff --git a/include/linux/iio/timer/stm32-lptim-trigger.h b/include/linux/iio/timer/stm32-lptim-trigger.h
index a34dcf6a6001..ce3cf0addb2e 100644
--- a/include/linux/iio/timer/stm32-lptim-trigger.h
+++ b/include/linux/iio/timer/stm32-lptim-trigger.h
@@ -14,6 +14,15 @@
 #define LPTIM1_OUT	"lptim1_out"
 #define LPTIM2_OUT	"lptim2_out"
 #define LPTIM3_OUT	"lptim3_out"
+#define LPTIM4_OUT	"lptim4_out"
+#define LPTIM5_OUT	"lptim5_out"
+
+#define LPTIM1_CH1	"lptim1_ch1"
+#define LPTIM1_CH2	"lptim1_ch2"
+#define LPTIM2_CH1	"lptim2_ch1"
+#define LPTIM2_CH2	"lptim2_ch2"
+#define LPTIM3_CH1	"lptim3_ch1"
+#define LPTIM4_CH1	"lptim4_ch1"
 
 #if IS_REACHABLE(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
 bool is_stm32_lptim_trigger(struct iio_trigger *trig);
-- 
2.25.1


