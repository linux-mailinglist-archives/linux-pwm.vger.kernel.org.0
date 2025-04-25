Return-Path: <linux-pwm+bounces-5714-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC0EA9C966
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 14:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BE24C6944
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE4824E4A6;
	Fri, 25 Apr 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Upudl8zA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A5024C067;
	Fri, 25 Apr 2025 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585453; cv=none; b=GpeVdwOuZ8d/PQEZdtNAq/xENnwK1fxPWvQFNS1t+5Ku12ktE0Lq1nlvsqLM7yJcC7RjnweGNw5eAuMqVplX2gq9t2a61w9whE6xBiXpQ2pCjbm03gFND2G+kx9eSPOrTI1m0qkYc4Sn16bsakNMYs77y7qYNJgB+bzgR1Y94jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585453; c=relaxed/simple;
	bh=zs/V748ZSIq4PTlOdJi2Ovg+C2A8X5dJcTE+Ofrt1zw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuJSMSkahcgYCt06vIQsK7tlNne2ZhP9/y9To1MFl+63CGrHbIC/hJq/w6QQ8fP9Ma4lQU58aMArvuBIY2u4OW+bJN9GgI5lu/VmOTqZmjF1Wus173pvPh7HNT0D7cPcAPCK7RPbz8sn6Lz9sDHSxKliomTAQHHEuA0OZliSyPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Upudl8zA; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P7RfCO009028;
	Fri, 25 Apr 2025 14:50:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	HOmtL5hvq8AIvU12GCg5bFAbpSwFxaW2vqAjynWZVng=; b=Upudl8zAd9iwhJLd
	7/adp1nH2Zr3y8E1bgPfPOWKsmE6mnQZIsOkLrrMFua7ZcQ4Pm8uqOz2+SNgW5FI
	kXprsdP1qpT8SkYcHqi5xVyTSvjXzQwS4QcmTYLhworQMuaJeAFqyo2yktxPiDNB
	o+TMAQ64pMHIAK56qY/3QwfRyCl9KIpdMTIRNZlMHiHSVhghLtHGEbobzZIQdzA+
	3+6XVH4sub++vTAm+pht18pRTzulRaNgg6j3ipLkYJa2XWAJ3EU/q5yqsQWExEdq
	Arx3G2rYYhMvyJBD2/2kpBX8Nt2v3xswsm1A5gayWORcnamY5T2l3hfWT5GDffos
	6kJtDA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jjxm5td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:50:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 440724005F;
	Fri, 25 Apr 2025 14:49:16 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8851DA09568;
	Fri, 25 Apr 2025 14:48:07 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 14:48:07 +0200
Received: from localhost (10.252.15.6) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 14:48:07 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <ukleinek@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jic23@kernel.org>, <robh@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <devicetree@vger.kernel.org>, <wbg@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v5 3/7] clocksource: stm32-lptimer: add support for stm32mp25
Date: Fri, 25 Apr 2025 14:47:51 +0200
Message-ID: <20250425124755.166193-4-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250425124755.166193-1-fabrice.gasnier@foss.st.com>
References: <20250425124755.166193-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01

On stm32mp25, DIER (former IER) must only be modified when the lptimer
is enabled. On earlier SoCs, it must be only be modified when it is
disabled. There's also a new DIEROK flag, to ensure register access
has completed.
Add a new "set_evt" routine to be used on stm32mp25, called depending
on the version register, read by the MFD core (LPTIM_VERR).

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in V5:
- Added a delay after timer enable, it needs two clock cycles.
Changes in V4:
- Daniel suggests to encapsulate IER write into a separate function
  that manages the enabling/disabling of the LP timer. In addition,
  DIEROK and ARROK flags checks have been added. So adopt a new routine
  to set the event into ARR register and enable the interrupt.
Changes in V2:
- rely on fallback compatible as no specific .data is associated to the
  driver. Use version data from MFD core.
- Added interrupt enable register access update in (missed in V1)
---
 drivers/clocksource/timer-stm32-lp.c | 60 ++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index 928da2f6de69..a214ff6edbae 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -27,6 +27,7 @@ struct stm32_lp_private {
 	u32 psc;
 	struct device *dev;
 	struct clk *clk;
+	u32 version;
 };
 
 static struct stm32_lp_private*
@@ -47,12 +48,46 @@ static int stm32_clkevent_lp_shutdown(struct clock_event_device *clkevt)
 	return 0;
 }
 
-static int stm32_clkevent_lp_set_timer(unsigned long evt,
-				       struct clock_event_device *clkevt,
-				       int is_periodic)
+static int stm32mp25_clkevent_lp_set_evt(struct stm32_lp_private *priv, unsigned long evt)
 {
-	struct stm32_lp_private *priv = to_priv(clkevt);
+	int ret;
+	u32 val;
+
+	regmap_read(priv->reg, STM32_LPTIM_CR, &val);
+	if (!val & STM32_LPTIM_ENABLE) {
+		/* Enable LPTIMER to be able to write into IER and ARR registers */
+		regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
+		/*
+		 * After setting the ENABLE bit, a delay of two counter clock cycles is needed
+		 * before the LPTIM is actually enabled. For 32KHz rate, this makes approximately
+		 * 62.5 micro-seconds, round it up.
+		 */
+		udelay(63);
+	}
+	/* set next event counter */
+	regmap_write(priv->reg, STM32_LPTIM_ARR, evt);
+	/* enable ARR interrupt */
+	regmap_write(priv->reg, STM32_LPTIM_IER, STM32_LPTIM_ARRMIE);
+
+	/* Poll DIEROK and ARROK to ensure register access has completed */
+	ret = regmap_read_poll_timeout_atomic(priv->reg, STM32_LPTIM_ISR, val,
+					      (val & STM32_LPTIM_DIEROK_ARROK) ==
+					      STM32_LPTIM_DIEROK_ARROK,
+					      10, 500);
+	if (ret) {
+		dev_err(priv->dev, "access to LPTIM timed out\n");
+		/* Disable LPTIMER */
+		regmap_write(priv->reg, STM32_LPTIM_CR, 0);
+		return ret;
+	}
+	/* Clear DIEROK and ARROK flags */
+	regmap_write(priv->reg, STM32_LPTIM_ICR, STM32_LPTIM_DIEROKCF_ARROKCF);
 
+	return 0;
+}
+
+static void stm32_clkevent_lp_set_evt(struct stm32_lp_private *priv, unsigned long evt)
+{
 	/* disable LPTIMER to be able to write into IER register*/
 	regmap_write(priv->reg, STM32_LPTIM_CR, 0);
 	/* enable ARR interrupt */
@@ -61,6 +96,22 @@ static int stm32_clkevent_lp_set_timer(unsigned long evt,
 	regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
 	/* set next event counter */
 	regmap_write(priv->reg, STM32_LPTIM_ARR, evt);
+}
+
+static int stm32_clkevent_lp_set_timer(unsigned long evt,
+				       struct clock_event_device *clkevt,
+				       int is_periodic)
+{
+	struct stm32_lp_private *priv = to_priv(clkevt);
+	int ret;
+
+	if (priv->version == STM32_LPTIM_VERR_23) {
+		ret = stm32mp25_clkevent_lp_set_evt(priv, evt);
+		if (ret)
+			return ret;
+	} else {
+		stm32_clkevent_lp_set_evt(priv, evt);
+	}
 
 	/* start counter */
 	if (is_periodic)
@@ -176,6 +227,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->reg = ddata->regmap;
+	priv->version = ddata->version;
 	priv->clk = ddata->clk;
 	ret = clk_prepare_enable(priv->clk);
 	if (ret)
-- 
2.25.1


