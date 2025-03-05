Return-Path: <linux-pwm+bounces-5094-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE9EA4FABC
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 10:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0913AE282
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498C52063DA;
	Wed,  5 Mar 2025 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KYjSlZtb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED4205E3E;
	Wed,  5 Mar 2025 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168451; cv=none; b=mAx2VKMyHqtK89WWibqdBkDvt7xjGna2YuYFvaK0Pg5hKsZsyQ4C/8JxhOXX570VWFaE/KJ1GPFXoyjuBJyZcIuAByUfjI0PsSm/p4k2v08sT922chE1sKxJAWKTjhOzdoMcc9M1AwcZykWkiPG16rBWV7UwMeFncFFjl2jy81I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168451; c=relaxed/simple;
	bh=PSmo29bGDx2stGyxYXTw4rtfkca1ql/D7P88lAoVikk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjQ2oqUs1o6/e6SsbbIVRn599OOkT1OLVCm/dGsD41bms0jgzmOOyzCGQJKjLlZ58y1CalZBEtCr125/DLacwzC2lgPy1DjzKrvRvDCRV2/NFa/31kqzf//S6lr1QPHRLYWrJabtuhY/CeL8K6UEXrTd4jaaXtsZtsPWlghCO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KYjSlZtb; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5259B9cB015089;
	Wed, 5 Mar 2025 10:53:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	7uA/kzsyL4bjC6IvsZ+YR8eSD63QBoHyAq5BR60Y4KQ=; b=KYjSlZtbq6SpDovP
	7lBv2y9HZHILzhMV8lYeVOpGfLzOA7PMNCChI1PyD8K92HCV0eTZS53rEsfUOsf/
	Pb2PZtGO75yFFukVIinmwl75M7U1bqEtDgG/aKnV5hll4oikeoxBjJ/6x9vUsFa6
	D2xiIufBCDyreHLClQZqxElNSeaqr14YaBtWBcirsOGto+eybz0ypzGkBCd8BmmZ
	tD92Vu6M+5YDhD1yDvyI0dVktLy5WRXB7II4eBXIiSDQLozPqA77w61yUOEBiQyr
	9s5+EC7Xtd/Oy+Ooet20mSkebSJVFA7Smatkk0l+Az4PVD2KOcZmE7erYaPeLXNj
	TqdsKg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 456krt8b9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 10:53:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ED17E40085;
	Wed,  5 Mar 2025 10:52:45 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 013E55A5ABD;
	Wed,  5 Mar 2025 10:49:53 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 10:49:52 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 10:49:52 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jic23@kernel.org>, <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <wbg@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v3 3/8] iio: trigger: stm32-lptimer: add support for stm32mp25
Date: Wed, 5 Mar 2025 10:49:30 +0100
Message-ID: <20250305094935.595667-4-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305094935.595667-1-fabrice.gasnier@foss.st.com>
References: <20250305094935.595667-1-fabrice.gasnier@foss.st.com>
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
 definitions=2025-03-05_03,2025-03-05_01,2024-11-22_01

From: Olivier Moysan <olivier.moysan@foss.st.com>

Add support for STM32MP25 SoC. Use newly introduced compatible to handle
this new HW variant. Add new trigger definitions that can be used by the
stm32 analog-to-digital converter. Use compatible data to identify them.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/trigger/stm32-lptimer-trigger.c   | 109 +++++++++++++++---
 include/linux/iio/timer/stm32-lptim-trigger.h |   9 ++
 2 files changed, 99 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
index f1e18913236a..995234c1e7d5 100644
--- a/drivers/iio/trigger/stm32-lptimer-trigger.c
+++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
@@ -16,16 +16,44 @@
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
+	struct list_head tr_list;
 };
 
 static int stm32_lptim_validate_device(struct iio_trigger *trig,
@@ -54,25 +82,49 @@ bool is_stm32_lptim_trigger(struct iio_trigger *trig)
 }
 EXPORT_SYMBOL(is_stm32_lptim_trigger);
 
-static int stm32_lptim_setup_trig(struct stm32_lptim_trigger *priv)
+static void stm32_lptim_unregister_triggers(struct stm32_lptim_trigger *priv)
 {
-	struct iio_trigger *trig;
+	struct iio_trigger *tr;
 
-	trig = devm_iio_trigger_alloc(priv->dev, "%s", priv->trg);
-	if  (!trig)
-		return -ENOMEM;
+	list_for_each_entry(tr, &priv->tr_list, alloc_list)
+		iio_trigger_unregister(tr);
+}
+
+static int stm32_lptim_register_triggers(struct stm32_lptim_trigger *priv)
+{
+	const char * const *cur = priv->triggers;
+	int ret;
 
-	trig->dev.parent = priv->dev->parent;
-	trig->ops = &stm32_lptim_trigger_ops;
-	iio_trigger_set_drvdata(trig, priv);
+	INIT_LIST_HEAD(&priv->tr_list);
 
-	return devm_iio_trigger_register(priv->dev, trig);
+	while (cur && *cur) {
+		struct iio_trigger *trig;
+
+		trig = devm_iio_trigger_alloc(priv->dev, "%s", *cur);
+		if  (!trig)
+			return -ENOMEM;
+
+		trig->dev.parent = priv->dev->parent;
+		trig->ops = &stm32_lptim_trigger_ops;
+		iio_trigger_set_drvdata(trig, priv);
+
+		ret = iio_trigger_register(trig);
+		if (ret)
+			return ret;
+
+		list_add_tail(&trig->alloc_list, &priv->tr_list);
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
+	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -81,23 +133,42 @@ static int stm32_lptim_trigger_probe(struct platform_device *pdev)
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
+
+	ret = stm32_lptim_register_triggers(priv);
+	if (ret) {
+		stm32_lptim_unregister_triggers(priv);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static void stm32_lptim_trigger_remove(struct platform_device *pdev)
+{
+	struct stm32_lptim_trigger *priv = platform_get_drvdata(pdev);
 
-	return stm32_lptim_setup_trig(priv);
+	stm32_lptim_unregister_triggers(priv);
 }
 
 static const struct of_device_id stm32_lptim_trig_of_match[] = {
-	{ .compatible = "st,stm32-lptimer-trigger", },
+	{ .compatible = "st,stm32-lptimer-trigger", .data = (void *)&stm32mp15_lptim_cfg },
+	{ .compatible = "st,stm32mp25-lptimer-trigger", .data = (void *)&stm32mp25_lptim_cfg},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_lptim_trig_of_match);
 
 static struct platform_driver stm32_lptim_trigger_driver = {
 	.probe = stm32_lptim_trigger_probe,
+	.remove = stm32_lptim_trigger_remove,
 	.driver = {
 		.name = "stm32-lptimer-trigger",
 		.of_match_table = stm32_lptim_trig_of_match,
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


