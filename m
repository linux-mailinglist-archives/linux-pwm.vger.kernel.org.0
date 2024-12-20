Return-Path: <linux-pwm+bounces-4425-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ECF9F8FA8
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 11:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDFF1889814
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05781C1F2C;
	Fri, 20 Dec 2024 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wsPKB8Is"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552361A840A;
	Fri, 20 Dec 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688957; cv=none; b=Qh3aGKlygFtpWb3TNjEdL0IYX8A5KgLXUvQmKaiwVztiXJPCueKGGUGaOr51Y59WmDrEi3NqP85RPN4L4YR8g5/zDWz8lDMBfspq3xWTNnKSX2Ax4lCNGV+z6xWB1SnzlxE3qP0G9sbq3fvvuEn7Q1C2OEOAE/aLtQ/s9/XvHp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688957; c=relaxed/simple;
	bh=vuKucuHNiBZWdvLoBJ2PXzYnadT/vBiXaqrFBybaqeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiriMdWjms+5vEhP8YwFuOXgKdDaiB+EdZhyZ1mlgfjJy/EQRBQ2guwf0++nY4Y+65HtlGvjiT/o+erlLIEcealFD3WzCL7L4yX18HSAtpfaDio2eNRNS7lnkBPy9sBrbkkLbMcR6lZVOdC8r82nqv741EHQ0V4qdTb2M5WaA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wsPKB8Is; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK9vSX3021487;
	Fri, 20 Dec 2024 11:02:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	D8xaHAiUI650qyQPwQru2ZW+j7rrthJZ6/9X0gNFWL0=; b=wsPKB8Is/rtsT3oP
	17RCPVyVGn//LDjoltk94NBNJg7tYTxQa+m3mQ0vXrox2lXLm8G8VSr+RP9tvLrr
	EGVClCDAKDRGPnRWDHhvv6xwS7VT9NyM3wCdlO1NtfMmzCBCjGfbBuMe3qwn4+K0
	7pC0N9jkkywQdBZTJHIJnwBnvfNCTSbqWo7Hpy/9gZ6JMQV7GTOlPLH7FTh89hkE
	JbC9+y2Vow0QXd0EbrOHYn7DpCgGyp19bDqzs5KalWgjwa+Ssa9L2lhv97srjL6n
	khSxXKgM5/CTDDHqxxGbl1FJhLnpyomNHa0Ou5LvIRLwbfLxyQhq29o49c/9zfaD
	w6X/Lw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43n6dcr0q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 11:02:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 492A84005F;
	Fri, 20 Dec 2024 11:01:09 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D97525F1F6;
	Fri, 20 Dec 2024 11:00:08 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 20 Dec
 2024 11:00:08 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 20 Dec
 2024 11:00:08 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alexandre.torgue@foss.st.com>,
        <wbg@kernel.org>, <jic23@kernel.org>, <ukleinek@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
Subject: [PATCH v2 2/9] mfd: stm32-timers: add support for stm32mp25
Date: Fri, 20 Dec 2024 10:59:20 +0100
Message-ID: <20241220095927.1122782-3-fabrice.gasnier@foss.st.com>
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


