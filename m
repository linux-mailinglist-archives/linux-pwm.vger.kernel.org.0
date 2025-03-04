Return-Path: <linux-pwm+bounces-5082-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6C0A4EA7F
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 19:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41F2422BF8
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 18:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804E229B208;
	Tue,  4 Mar 2025 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vhe7W4Pz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D12206F1F;
	Tue,  4 Mar 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110037; cv=none; b=UbcQhUXWn8Y/uTMIh0+l2j0fZEvG8kl1zSgXzCP0QmPH3Se9NSRlSn80uDyyaw1Do8dcs+DlT/IUdTTF6gZh9zkgSxeCF42mvZ4wf7iX4oPsuO2ZD7KrzE3ZEXhqOjR8kQIYYs+xxFLCDbkn+uy+OWwwaP1XS81r0BkdMWtEJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110037; c=relaxed/simple;
	bh=Ao1aKPW3vEWx4uR7ROBAZX3xBu16tubOsT1HZcYlW+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4HHE3vCW46A1LICu82YBdD6cp0iU8XPiY6Ts0SUR9eFyhyjRYkigknvEXaHeiJ8NSAQ3wJNIpgUTE+pq6jusnIQfeWpQNpzdba340GPPYXHM9aqNH16UMyOZdKulxIXPCcJKRT2+9qeET9jYy0WKxgv7wbAFHghkC+XVfVry6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vhe7W4Pz; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524FVO27015326;
	Tue, 4 Mar 2025 18:39:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	jlmPKQF+2mG+ZL188MgmNIlgYEpG3hohOD8Tk6PCGxk=; b=vhe7W4PzPmnsL2LH
	FJlme5NRroDCHIm11j/ACFzPxPDPrmO4nxBLu8alit93+RL0w6qRAAL0+DUir9N3
	g8zFzRudwdH84zqP9/kzMYIw6d1qKXYCu9sm9Dl+tWJm3rY/OMWUF65thXUEddtI
	AhNaoORmckZtLn9lIefjl3npl8KghXjUPreqiXAFpyIpfxgfUd8VK0svEQCSlp1z
	ZeXK6pmdcI4Ri05nWo5YaTRFQcDSiW+n3Q4QjmVjyms8DDBAaz3h+i+ylqE/CKlz
	7mf2iuC/MBtCdaS66nQZxoh4YUACD3zHTLSAW86DyCqHH3GWm1yBWbePiQjhboow
	rvr0Lw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 453tf5nsfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 18:39:59 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 276F4400A3;
	Tue,  4 Mar 2025 18:38:40 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 60349594855;
	Tue,  4 Mar 2025 18:32:49 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 18:32:49 +0100
Received: from localhost (10.252.16.143) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 18:32:49 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jic23@kernel.org>, <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <wbg@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 4/8] clocksource: stm32-lptimer: add support for stm32mp25
Date: Tue, 4 Mar 2025 18:32:25 +0100
Message-ID: <20250304173229.3215445-5-fabrice.gasnier@foss.st.com>
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


