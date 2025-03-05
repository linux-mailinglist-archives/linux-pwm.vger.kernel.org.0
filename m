Return-Path: <linux-pwm+bounces-5098-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1195A4FAD6
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 10:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20ABC3ACF07
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC03C207A37;
	Wed,  5 Mar 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Fjq5kxiQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2400205AD4;
	Wed,  5 Mar 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168466; cv=none; b=fGNNOVq2rpeq1zOPzUaPN1fUQgX6qPvp1m9CrQdEl3qqXfIpiUe6/fsYZHub1Vng/IHmpFeyoEsKj1dpAEjfCjHxQYMOVaSML5FDjOE2kyO7+XokYNYsgLLx9lSPLqP1ofZRXQ3nFlPCjwNfCrIMxOsuMRGfxIuq551dPw3xaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168466; c=relaxed/simple;
	bh=Ao1aKPW3vEWx4uR7ROBAZX3xBu16tubOsT1HZcYlW+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGnzIFLW3X5cAXwE2zYWrnuXaBd+aWK8fRTQKgs3cG2sqooLORPUdOpyWpShk41qWrgKH16S7R7NoxadCPtyDG8L/lhtPPGOsnCo4hHVnxH4+9Xfs9wHUmxqUnrEuTzfnY73EbCawZvf0HMG2YvIBsf22/sKbNJ83IE7IMf0wmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Fjq5kxiQ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5258Xamf011442;
	Wed, 5 Mar 2025 10:53:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	jlmPKQF+2mG+ZL188MgmNIlgYEpG3hohOD8Tk6PCGxk=; b=Fjq5kxiQxSlriRIW
	A+MZ7h0Si2K215csBhtSZJJADLjwQNdFpTjmi9nuZ7odJtZEPjp7xJY6k5XxIAm2
	6S5wuK40wYryGQRuB1SRaZTPwvElSe+graKdJZJ9jGYICOnxPg1BcqGIh+gv2EHn
	knpOZlBu9hoq2y3u8hAf91PAsQbZcESa3W+qCMoFm+y0+LAGaPy8Rlbe50FeINzT
	fMo8Jrqpw+6ejWXVIlvVwRMbI4/ZBsi0b/eP6KD+DoZ288QSwnkkbgtx8U7xHaFr
	rn0IkPtKDoiGHf5sgqcltVLCtsGjfYavXFKZ/wtM3XGhm0PWi7ltIgnao7GTsdGR
	pgGWgg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 455wbht7y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 10:53:55 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 399D840086;
	Wed,  5 Mar 2025 10:52:46 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EAF365A5D6A;
	Wed,  5 Mar 2025 10:49:53 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 10:49:53 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 10:49:53 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jic23@kernel.org>, <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <wbg@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v3 4/8] clocksource: stm32-lptimer: add support for stm32mp25
Date: Wed, 5 Mar 2025 10:49:31 +0100
Message-ID: <20250305094935.595667-5-fabrice.gasnier@foss.st.com>
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

On stm32mp25, DIER (former IER) must only be modified when the lptimer
is enabled. On earlier SoCs, it must be only be modified when it is
disabled. Read the LPTIM_VERR register to properly manage the enable
state, before accessing IER.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in V2:
- rely on fallback compatible as no specific .data is associated to the
  driver. Use version data from MFD core.
- Added interrupt enable register access update in (missed in V1)
---
 drivers/clocksource/timer-stm32-lp.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index a4c95161cb22..96d975adf7a4 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -25,6 +25,7 @@ struct stm32_lp_private {
 	struct clock_event_device clkevt;
 	unsigned long period;
 	struct device *dev;
+	bool ier_wr_enabled;	/* Enables LPTIMER before writing into IER register */
 };
 
 static struct stm32_lp_private*
@@ -37,8 +38,15 @@ static int stm32_clkevent_lp_shutdown(struct clock_event_device *clkevt)
 {
 	struct stm32_lp_private *priv = to_priv(clkevt);
 
-	regmap_write(priv->reg, STM32_LPTIM_CR, 0);
+	/* Disable LPTIMER either before or after writing IER register (else, keep it enabled) */
+	if (!priv->ier_wr_enabled)
+		regmap_write(priv->reg, STM32_LPTIM_CR, 0);
+
 	regmap_write(priv->reg, STM32_LPTIM_IER, 0);
+
+	if (priv->ier_wr_enabled)
+		regmap_write(priv->reg, STM32_LPTIM_CR, 0);
+
 	/* clear pending flags */
 	regmap_write(priv->reg, STM32_LPTIM_ICR, STM32_LPTIM_ARRMCF);
 
@@ -51,12 +59,21 @@ static int stm32_clkevent_lp_set_timer(unsigned long evt,
 {
 	struct stm32_lp_private *priv = to_priv(clkevt);
 
-	/* disable LPTIMER to be able to write into IER register*/
-	regmap_write(priv->reg, STM32_LPTIM_CR, 0);
+	if (!priv->ier_wr_enabled) {
+		/* Disable LPTIMER to be able to write into IER register */
+		regmap_write(priv->reg, STM32_LPTIM_CR, 0);
+	} else {
+		/* Enable LPTIMER to be able to write into IER register */
+		regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
+	}
+
 	/* enable ARR interrupt */
 	regmap_write(priv->reg, STM32_LPTIM_IER, STM32_LPTIM_ARRMIE);
+
 	/* enable LPTIMER to be able to write into ARR register */
-	regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
+	if (!priv->ier_wr_enabled)
+		regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
+
 	/* set next event counter */
 	regmap_write(priv->reg, STM32_LPTIM_ARR, evt);
 
@@ -151,6 +168,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->reg = ddata->regmap;
+	priv->ier_wr_enabled = ddata->version == STM32_LPTIM_VERR_23;
 	ret = clk_prepare_enable(ddata->clk);
 	if (ret)
 		return -EINVAL;
-- 
2.25.1


