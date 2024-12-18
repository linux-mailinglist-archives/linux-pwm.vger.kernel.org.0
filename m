Return-Path: <linux-pwm+bounces-4384-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20769F60B3
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Dec 2024 10:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A7318879A6
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Dec 2024 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440761922F9;
	Wed, 18 Dec 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2lruwlNU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44426187862;
	Wed, 18 Dec 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512673; cv=none; b=lmw3fryQWy6fCiAj7guAqHLFbzIgOF5ZrZo2wTcuyeSb1O1yfLvMVfFDRWwnkBiEMFzRAK2rYA5MQKYv0S58CPJJEE415UNoyRZpTuujfLjxeHUhnDjZqTGrfvhaZIkVeWdgdl9NXpJxooYtUgcoMeZNOB0mWT5Eke05R873K24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512673; c=relaxed/simple;
	bh=cSZ5G1BDG6uk50+PgBtVRHcSSdxdOssKEClrgYoOts4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzzBWna8WUuo7KmZwLdqhqxIyGl+UuSd3ocnON3FEuicqYg1AaVSeJlVhMAa6eNbb4Y99m1DS5K559Hs1GTZ75FKwM3ucsJ0VCguRThg4uWii5OewK01Ki3R4C+hQ1fPwxkpQroessgW2t1QdEODg2puYulWZm0Tqm3LnEXDInQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2lruwlNU; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI6oHm4032719;
	Wed, 18 Dec 2024 10:04:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	vw1hITR1G9F1rVm3gpZWmkGDdDu1u0GyVrr+LvVm7wM=; b=2lruwlNU9Z9vXX7a
	OHARmeQ9XwCbK+7cF0s1WL3gwEUErY8vd8Ebv7A9Dh386YaEVWKvhWbgXCcmgOX8
	GHy7zby75MOVlG0vym9idrisWcLxKe9jOejrrHa7buehh/BchqP0UFZdU9Zpkis+
	+fjtHJhMGIr9x3wFio+cOM4Yk1t+qoOuaFKmYdAeZPVefl1kX8QwPbYuFwLU4yi8
	UczP7Gt4b0QWnMb2mLhzETdMCjjJKUNp80e/9Z038ooWOKJwcSwy4H1IpgE6a70j
	I6r7YmjUeNbtfT7Moi6LxYWp0xj3Rbu2G1rB8kBMaiuNe7aMkSQegsaE77V89szB
	BqWpAw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ksfrgh0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:04:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9D8D240052;
	Wed, 18 Dec 2024 10:03:04 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2193225FADC;
	Wed, 18 Dec 2024 10:02:57 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 10:02:56 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 10:02:56 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alexandre.torgue@foss.st.com>,
        <wbg@kernel.org>, <jic23@kernel.org>, <ukleinek@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
Subject: [PATCH 3/9] iio: trigger: stm32-timer: add support for stm32mp25
Date: Wed, 18 Dec 2024 10:01:47 +0100
Message-ID: <20241218090153.742869-4-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241218090153.742869-1-fabrice.gasnier@foss.st.com>
References: <20241218090153.742869-1-fabrice.gasnier@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add support for STM32MP25 SoC. Use newly introduced compatible to handle
this new HW variant. Add TIM20 trigger definitions that can be used by
the stm32 analog-to-digital converter. Use compatible data to identify
it.
As the counter framework is now superseding the deprecated IIO counter
interface (IIO_COUNT), don't support it. Only register IIO trigger
devices for ADC usage. So, make the valids_table a cfg option.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c     | 21 +++++++++++++++++--
 include/linux/iio/timer/stm32-timer-trigger.h |  6 ++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index bb60b2d7b2ec..8aaf3abf044e 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -38,6 +38,9 @@ static const void *triggers_table[][MAX_TRIGGERS] = {
 	{ TIM15_TRGO,},
 	{ TIM16_OC1,},
 	{ TIM17_OC1,},
+	{ }, /* timer 18 */
+	{ }, /* timer 19 */
+	{ TIM20_TRGO, TIM20_TRGO2, TIM20_OC1, TIM20_OC2, TIM20_OC3, },
 };
 
 /* List the triggers accepted by each timer */
@@ -781,7 +784,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	/* Create an IIO device only if we have triggers to be validated */
-	if (*cfg->valids_table[index])
+	if (cfg->valids_table && *cfg->valids_table[index])
 		priv = stm32_setup_counter_device(dev);
 	else
 		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -794,7 +797,8 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
 	priv->triggers = triggers_table[index];
-	priv->valids = cfg->valids_table[index];
+	if (cfg->valids_table && *cfg->valids_table[index])
+		priv->valids = cfg->valids_table[index];
 	stm32_timer_detect_trgo2(priv);
 	mutex_init(&priv->lock);
 
@@ -886,6 +890,16 @@ static const struct stm32_timer_trigger_cfg stm32h7_timer_trg_cfg = {
 	.num_valids_table = ARRAY_SIZE(stm32h7_valids_table),
 };
 
+static const struct stm32_timer_trigger_cfg stm32mp25_timer_trg_cfg = {
+	/*
+	 * valids_table not used: counter framework is now superseding the deprecated IIO
+	 * counter interface (IIO_COUNT), so don't support it. num_valids_table is only
+	 * kept here to register the IIO HW triggers. valids_table should be moved at some
+	 * point to the stm32-timer-cnt driver instead.
+	 */
+	.num_valids_table = ARRAY_SIZE(triggers_table),
+};
+
 static const struct of_device_id stm32_trig_of_match[] = {
 	{
 		.compatible = "st,stm32-timer-trigger",
@@ -893,6 +907,9 @@ static const struct of_device_id stm32_trig_of_match[] = {
 	}, {
 		.compatible = "st,stm32h7-timer-trigger",
 		.data = (void *)&stm32h7_timer_trg_cfg,
+	}, {
+		.compatible = "st,stm32mp25-timer-trigger",
+		.data = (void *)&stm32mp25_timer_trg_cfg,
 	},
 	{ /* end node */ },
 };
diff --git a/include/linux/iio/timer/stm32-timer-trigger.h b/include/linux/iio/timer/stm32-timer-trigger.h
index 37572e4dc73a..1ee237b56183 100644
--- a/include/linux/iio/timer/stm32-timer-trigger.h
+++ b/include/linux/iio/timer/stm32-timer-trigger.h
@@ -72,6 +72,12 @@
 
 #define TIM17_OC1	"tim17_oc1"
 
+#define TIM20_OC1	"tim20_oc1"
+#define TIM20_OC2	"tim20_oc2"
+#define TIM20_OC3	"tim20_oc3"
+#define TIM20_TRGO	"tim20_trgo"
+#define TIM20_TRGO2	"tim20_trgo2"
+
 #if IS_REACHABLE(CONFIG_IIO_STM32_TIMER_TRIGGER)
 bool is_stm32_timer_trigger(struct iio_trigger *trig);
 #else
-- 
2.25.1


