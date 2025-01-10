Return-Path: <linux-pwm+bounces-4570-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AE3A08BC8
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 10:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B3F169FC3
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884C020C465;
	Fri, 10 Jan 2025 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nDji/mW/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF620C038;
	Fri, 10 Jan 2025 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500938; cv=none; b=U6Up0IchwbR1exk3S1QExvAjD6VeXMRewC46NzgBO0jZ1LRx041k7z3O0b5kIcn9Qr7r4gENO/PDqQizF1Ne0nUEeSxJBC59gN9bis/EX3FYRgcJABbyuyLw/yWrq1hfng55ZlEIiBZNKPIzq7+Mao5J3AehdNyAOHPCCrqJpmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500938; c=relaxed/simple;
	bh=WwvIg9Cmt18RYee+/QUqe5qozU9odvXlhFuEBV1U2Vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9FiNYn5fGhQZBLtUtOfzvSl0pkJYKg96DCmaBSO3uuxAQPmMb9rQmWDVDmOMi8Kb85jYt27B563sQXeqeQivxk+7N4HoAOD2vFhi7Pr4qzaM64XmqGZwiS0lc9JxmdoH0jexpUU5LvRrW12s6AgbfGAdUenAOlnS+0LsAnj3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nDji/mW/; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A8DlBH000357;
	Fri, 10 Jan 2025 10:21:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	h6ab+x6Ynx/O74V+SfsXYwAL7nLhG88cwarhkjj6DpE=; b=nDji/mW/AuPMid5J
	aoKDXsEF0VSGsNnbjL53ztfvRBa6mPsGcYdAqD2HQAqIg5yF47WOEszIV9k5RkT6
	Y9Ou0mc7dpg4TUwSrM48ZW1evbpnw9+20HM/DmG3tNp0IsBpDdANURGgIbT8lduD
	69zzx5Gl0EN1mSx49s1qmc/sOrJw4zrkBjFP559t3a89YzIpMmXhMJcV85bi7QPz
	pE8TcPH7wyQ1dJnIkHCgqyhF41F4WdKE+d8u5MfQdmzrDwZ6rTNzNss4uJ15qN8I
	++du5Tr9GAWKKqnO3CCuVQNO7BCmdR4diVoOwDwrWM3joMzxk4WtGuYB9kVhsOzU
	pSefXg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 442q2dhyvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 10:21:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D33AA40052;
	Fri, 10 Jan 2025 10:21:01 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D50F28A669;
	Fri, 10 Jan 2025 10:20:02 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 10 Jan
 2025 10:20:01 +0100
Received: from localhost (10.252.28.64) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 10 Jan
 2025 10:20:01 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <wbg@kernel.org>, <jic23@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v3 3/8] counter: stm32-timer-cnt: add support for stm32mp25
Date: Fri, 10 Jan 2025 10:19:17 +0100
Message-ID: <20250110091922.980627-4-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
References: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add support for STM32MP25 SoC. There are new counter modes that may be
implemented in later. Still, use newly introduced compatible to handle
this new HW variant and avoid being blocked with existing compatible
in SoC dtsi file. Modes supported currently still remains compatible.
New timer 20 has encoder capability, add it to the list.

Acked-by: William Breathitt Gray <wbg@kernel.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/counter/stm32-timer-cnt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index e75b69476a00..3d3384cbea87 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -669,12 +669,14 @@ static void stm32_timer_cnt_detect_channels(struct device *dev,
 	dev_dbg(dev, "has %d cc channels\n", priv->nchannels);
 }
 
-/* encoder supported on TIM1 TIM2 TIM3 TIM4 TIM5 TIM8 */
-#define STM32_TIM_ENCODER_SUPPORTED	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(7))
+/* encoder supported on TIM1 TIM2 TIM3 TIM4 TIM5 TIM8 TIM20 */
+#define STM32_TIM_ENCODER_SUPPORTED	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(7) | \
+					 BIT(19))
 
 static const char * const stm32_timer_trigger_compat[] = {
 	"st,stm32-timer-trigger",
 	"st,stm32h7-timer-trigger",
+	"st,stm32mp25-timer-trigger",
 };
 
 static int stm32_timer_cnt_probe_encoder(struct device *dev,
@@ -846,6 +848,7 @@ static SIMPLE_DEV_PM_OPS(stm32_timer_cnt_pm_ops, stm32_timer_cnt_suspend,
 
 static const struct of_device_id stm32_timer_cnt_of_match[] = {
 	{ .compatible = "st,stm32-timer-counter", },
+	{ .compatible = "st,stm32mp25-timer-counter", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_timer_cnt_of_match);
-- 
2.25.1


