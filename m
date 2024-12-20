Return-Path: <linux-pwm+bounces-4420-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FC69F8F93
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 11:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD531889E31
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7971BD007;
	Fri, 20 Dec 2024 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WoltuoB8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716801AAA3D;
	Fri, 20 Dec 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688956; cv=none; b=BatpoA3txCzoTNm9zNfGtuXD7FNRrjD0H//KRxHBf5As4X7ktZm6uJSGLZPomn7OH4oIkOVe2XReaD3G6Rvla6x6qsS6lcU2wfxJpsv3quqA9tAGtpDHBVReonEm+ImlGPBI1i7Mx0gDzmrO/TCG/9HNQuS9NAYBeuU3Yn1rd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688956; c=relaxed/simple;
	bh=WwvIg9Cmt18RYee+/QUqe5qozU9odvXlhFuEBV1U2Vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRdMJqWXTWT/9u9Qb/U2mH/95vV6q0cjQNE57Mhbn1zoMqYw4J5E5Mp5XPgonVMLQX0ut3Oc+KyIjFfuWIVF2RhTF1Frcp1bBpCi4MEnGTercGXTxKJVrAF8bc4xpRQCbOmJ5kHB7qcEInSHCG3vXcPuLjuXjJnlFQ/QjO9GY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WoltuoB8; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK89FH3005122;
	Fri, 20 Dec 2024 11:02:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	h6ab+x6Ynx/O74V+SfsXYwAL7nLhG88cwarhkjj6DpE=; b=WoltuoB82zYIyGVh
	3+t1Bv4bA+yUhTDdAeEueRcA/O54JL7OAnEgjp57Slzk1PGiijVV8NdJEeg9hfmH
	OrheVwHS/0jYOjc3lCyERXkWOvo1WPEOQWrTS42zFjbSIExzjrfKlnu2/+TsHNNu
	bc2F75Ct8ayq6Yc1TWwSsKvzh9ZEButgMGGBYgf25iKRc+PQkLrojDSgmDiGzh4q
	KaA16SWPtfbJDYAJKWw7pVYweVuXx651uwqS1Y7wBIUqq1BpmGlrQebFwcSHiiU4
	vU3d+NwX5SgsklHPV+Ncb60J9s8+BQ06QH3KLyJeeLOixTl1mlPq8w4zRI2arQdm
	BHaNfg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43n4c80np0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 11:02:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CDEFB4004B;
	Fri, 20 Dec 2024 11:01:13 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A3AB258D86;
	Fri, 20 Dec 2024 11:00:10 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 20 Dec
 2024 11:00:09 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 20 Dec
 2024 11:00:09 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alexandre.torgue@foss.st.com>,
        <wbg@kernel.org>, <jic23@kernel.org>, <ukleinek@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
Subject: [PATCH v2 4/9] counter: stm32-timer-cnt: add support for stm32mp25
Date: Fri, 20 Dec 2024 10:59:22 +0100
Message-ID: <20241220095927.1122782-5-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241220095927.1122782-1-fabrice.gasnier@foss.st.com>
References: <20241220095927.1122782-1-fabrice.gasnier@foss.st.com>
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


