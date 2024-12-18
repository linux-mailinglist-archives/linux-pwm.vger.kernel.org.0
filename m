Return-Path: <linux-pwm+bounces-4389-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9789F60D8
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Dec 2024 10:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4801895E8B
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Dec 2024 09:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718A419ABC3;
	Wed, 18 Dec 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SzeooxHI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312718858E;
	Wed, 18 Dec 2024 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512707; cv=none; b=G02zIXSRR+YCXAYrv8hDGUCKkVPCbsDzgMSOu7rTvbJH+oCU3mkdZGW82mnZhsJr5zuJTfW4uNC/+/zRYO0t2y9HRWzlzptYLpSUYxYAKZbgLQK3FtLYHiHBdbyuMhAg/UbuChvzh6a4cvYmg0iE8nfBQ4SRD2xNg5x+FGuviFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512707; c=relaxed/simple;
	bh=vuKucuHNiBZWdvLoBJ2PXzYnadT/vBiXaqrFBybaqeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dv8P0xUcmUjSl0ruDeR+V+dSe6M6ZpygOj8+1WSLcgL6fkmuHrdKd7KtXuhiWnVz6vkHBVfZB/M1ylGlvPx/0g00d78WLYrEUwy8pKVdlHozdjqGI6aFNP0EofnD4MtCMTRuzv/HTlbA+GUxU2/5PIWM04FKt1hQb9HHubL/nqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SzeooxHI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI60Lbd011674;
	Wed, 18 Dec 2024 10:04:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	D8xaHAiUI650qyQPwQru2ZW+j7rrthJZ6/9X0gNFWL0=; b=SzeooxHI8hzvCK4O
	aTeN4Nvt0lEfU8otzzQmKi/Zpc7jkPH7nQbAuSBfOwixPhRw/VYAXrFtFu7VkinP
	hhge+LCjtPdTJbQh4F6FWABHlk+/0/J8laQso+3Cacn7dVHmX1CQvGqorSUgAZzU
	k8e1mZeQSewEbG3X2Y2rDmqcJKDHLw7x28/UnOy3oLk9NQo9d48KTINd8uQysgVC
	Q61B0ffDtqCSa5+D+Yai6zslVXChhpgCJUycrhU4nxgwh3oRgbcYMFiAAkNd0veb
	GNgTkJt76ZLH272cWVLEwhO3H4m3f5/1k6WFyNyDQe9xVGWr3S1Y3FbRSOZK0mTh
	gFre2Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43krrcrnm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:04:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2777140077;
	Wed, 18 Dec 2024 10:03:58 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6AB6825FAD4;
	Wed, 18 Dec 2024 10:02:56 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 10:02:56 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 10:02:55 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alexandre.torgue@foss.st.com>,
        <wbg@kernel.org>, <jic23@kernel.org>, <ukleinek@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
Subject: [PATCH 2/9] mfd: stm32-timers: add support for stm32mp25
Date: Wed, 18 Dec 2024 10:01:46 +0100
Message-ID: <20241218090153.742869-3-fabrice.gasnier@foss.st.com>
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

Add support for STM32MP25 SoC. Use newly introduced compatible, to handle
new features.
Identification and hardware configuration registers allow to read the
timer version and capabilities (counter width, number of channels...).
So, rework the probe to avoid touching ARR register by simply read the
counter width when available. This may avoid messing with a possibly
running timer.
Also add useful bit fields to stm32-timers header file.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/mfd/stm32-timers.c       | 32 +++++++++++++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h |  9 +++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
index 650724e19b88..6f217c32482c 100644
--- a/drivers/mfd/stm32-timers.c
+++ b/drivers/mfd/stm32-timers.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 
 #define STM32_TIMERS_MAX_REGISTERS	0x3fc
@@ -173,6 +174,32 @@ static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
 	regmap_write(ddata->regmap, TIM_ARR, arr);
 }
 
+static int stm32_timers_probe_hwcfgr(struct device *dev, struct stm32_timers *ddata)
+{
+	u32 val;
+
+	ddata->ipidr = (uintptr_t)device_get_match_data(dev);
+	if (!ddata->ipidr) {
+		/* fallback to legacy method for probing counter width */
+		stm32_timers_get_arr_size(ddata);
+		return 0;
+	}
+
+	regmap_read(ddata->regmap, TIM_IPIDR, &val);
+	/* Sanity check on IP identification register */
+	if (val != ddata->ipidr) {
+		dev_err(dev, "Unexpected identification: %u\n", val);
+		return -EINVAL;
+	}
+
+	regmap_read(ddata->regmap, TIM_HWCFGR2, &val);
+	/* Counter width in bits, max reload value is BIT(width) - 1 */
+	ddata->max_arr = BIT(FIELD_GET(TIM_HWCFGR2_CNT_WIDTH, val)) - 1;
+	dev_dbg(dev, "TIM width: %ld\n", FIELD_GET(TIM_HWCFGR2_CNT_WIDTH, val));
+
+	return 0;
+}
+
 static int stm32_timers_dma_probe(struct device *dev,
 				   struct stm32_timers *ddata)
 {
@@ -285,7 +312,9 @@ static int stm32_timers_probe(struct platform_device *pdev)
 	if (IS_ERR(ddata->clk))
 		return PTR_ERR(ddata->clk);
 
-	stm32_timers_get_arr_size(ddata);
+	ret = stm32_timers_probe_hwcfgr(dev, ddata);
+	if (ret)
+		return ret;
 
 	ret = stm32_timers_irq_probe(pdev, ddata);
 	if (ret)
@@ -320,6 +349,7 @@ static void stm32_timers_remove(struct platform_device *pdev)
 
 static const struct of_device_id stm32_timers_of_match[] = {
 	{ .compatible = "st,stm32-timers", },
+	{ .compatible = "st,stm32mp25-timers", .data = (void *)STM32MP25_TIM_IPIDR },
 	{ /* end node */ },
 };
 MODULE_DEVICE_TABLE(of, stm32_timers_of_match);
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index f09ba598c97a..23b0cae4a9f8 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -33,6 +33,9 @@
 #define TIM_DCR		0x48			/* DMA control register			*/
 #define TIM_DMAR	0x4C			/* DMA register for transfer		*/
 #define TIM_TISEL	0x68			/* Input Selection			*/
+#define TIM_HWCFGR2	0x3EC			/* hardware configuration 2 Reg (MP25)	*/
+#define TIM_HWCFGR1	0x3F0			/* hardware configuration 1 Reg (MP25)	*/
+#define TIM_IPIDR	0x3F8			/* IP identification Reg (MP25)		*/
 
 #define TIM_CR1_CEN		BIT(0)					/* Counter Enable				*/
 #define TIM_CR1_DIR		BIT(4)					/* Counter Direction				*/
@@ -100,6 +103,9 @@
 #define TIM_BDTR_BKF(x)		(0xf << (16 + (x) * 4))
 #define TIM_DCR_DBA		GENMASK(4, 0)				/* DMA base addr				*/
 #define TIM_DCR_DBL		GENMASK(12, 8)				/* DMA burst len				*/
+#define TIM_HWCFGR1_NB_OF_CC	GENMASK(3, 0)				/* Capture/compare channels			*/
+#define TIM_HWCFGR1_NB_OF_DT	GENMASK(7, 4)				/* Complementary outputs & dead-time generators */
+#define TIM_HWCFGR2_CNT_WIDTH	GENMASK(15, 8)				/* Counter width				*/
 
 #define MAX_TIM_PSC				0xFFFF
 #define MAX_TIM_ICPSC				0x3
@@ -113,6 +119,8 @@
 #define TIM_BDTR_BKF_MASK			0xF
 #define TIM_BDTR_BKF_SHIFT(x)			(16 + (x) * 4)
 
+#define STM32MP25_TIM_IPIDR	0x00120002
+
 enum stm32_timers_dmas {
 	STM32_TIMERS_DMA_CH1,
 	STM32_TIMERS_DMA_CH2,
@@ -151,6 +159,7 @@ struct stm32_timers_dma {
 
 struct stm32_timers {
 	struct clk *clk;
+	u32 ipidr;
 	struct regmap *regmap;
 	u32 max_arr;
 	struct stm32_timers_dma dma; /* Only to be used by the parent */
-- 
2.25.1


