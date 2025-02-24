Return-Path: <linux-pwm+bounces-4976-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56FEA42B3B
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2025 19:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694937A3654
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2025 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B341266EFA;
	Mon, 24 Feb 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="kmQx0XJW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5B265CCB;
	Mon, 24 Feb 2025 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421312; cv=none; b=HDktQKSvRpq2MH82QefCNr53Hz1wl/wcteb0+kwNEjuXwDUl1ZsHy63tb8P0gcrsk/PI7gYHHaSel8BKkd0+LwHy/ZTqu88kYZrVkYzoVgkSdiWZ9sUBvHnc87HfqnbkJi8BrDvrP7dNkq/QN6ViaF/M+7k1lLdHJxWdWN9vxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421312; c=relaxed/simple;
	bh=q7Lmek9HUIwkWj2qiofEolInzTq2lrU6YLwM9WjDNRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAiWN3MyLwRvjhX+36ub/4VKBvYZ5HLpXioAiVCMt9Skx3VLLGiliufQ0F19kVY2MtR2dFNTWB5+/thaHaFdyGHjiDZwV1umDTYkomJqydpkMJxAzHC6cIKDfDb0iV88RSDZWtEOZGedAqdTN4IzhOhXmSd6tATas7kr0tZgnZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=kmQx0XJW; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OE5Cxi010861;
	Mon, 24 Feb 2025 19:16:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	gsOzA2NrVZUJ3dT5idaHgkMXMJrvsF/zo/qXjaQqpvk=; b=kmQx0XJW3xk0u4AS
	6s7c/W+f6AoiBYe3pKOg+XAFOPZ4EJCX7lkwDIT1STljXG5EewuUwAJX/S3H6h0h
	ReGvXJDFhMOHoriooJl2F+ZtVrCFfPwJYPXlVfmzkbhm/0MIWMCDrR9Entafmk8h
	5xdFYOYSWJj8BvY6wkHnALk8i28C92ho7LfVD9svFD3u7S4cm5js4fD63jcvSyEV
	wBk7A+Cnct/UAVRMe3fiSkt/FA3kkImW88224D7QuOCeg+o9UtSVa4TmjHI3DQeB
	/W/dghmcW5bW2vsG90vlT+gG21tetiu7gn76d7Vysgl768iUkMwuyhQjAcmvTTb2
	jV/Qzw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44y6t20r40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 19:16:32 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EA81340078;
	Mon, 24 Feb 2025 19:12:29 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF5DB546D7A;
	Mon, 24 Feb 2025 19:02:35 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 19:02:35 +0100
Received: from localhost (10.252.23.75) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 19:02:35 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <wbg@kernel.org>, <jic23@kernel.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH 7/8] arm64: defconfig: enable STM32 LP timers drivers
Date: Mon, 24 Feb 2025 19:01:49 +0100
Message-ID: <20250224180150.3689638-8-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
References: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01

Enable the STM32 timer drivers: MFD, counter, PWM and trigger as modules.
Clocksource is a bool, hence set to y. These drivers can be used on
STM32MP25.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1f25423de383..952eee30f21c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -775,6 +775,7 @@ CONFIG_MFD_TI_LP873X=m
 CONFIG_MFD_TPS65219=y
 CONFIG_MFD_TPS6594_I2C=m
 CONFIG_MFD_ROHM_BD718XX=y
+CONFIG_MFD_STM32_LPTIMER=m
 CONFIG_MFD_WCD934X=m
 CONFIG_MFD_KHADAS_MCU=m
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -1401,6 +1402,7 @@ CONFIG_CLK_RENESAS_VBATTB=m
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_TEGRA186_TIMER=y
+CONFIG_CLKSRC_STM32_LP=y
 CONFIG_RENESAS_OSTM=y
 CONFIG_ARM_MHU=y
 CONFIG_IMX_MBOX=y
@@ -1526,6 +1528,7 @@ CONFIG_IIO_CROS_EC_LIGHT_PROX=m
 CONFIG_SENSORS_ISL29018=m
 CONFIG_VCNL4000=m
 CONFIG_IIO_ST_MAGN_3AXIS=m
+CONFIG_IIO_STM32_LPTIMER_TRIGGER=m
 CONFIG_IIO_CROS_EC_BARO=m
 CONFIG_MPL3115=m
 CONFIG_PWM=y
@@ -1543,6 +1546,7 @@ CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_RZ_MTU3=m
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
+CONFIG_PWM_STM32_LP=m
 CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
 CONFIG_PWM_TIECAP=m
@@ -1682,6 +1686,7 @@ CONFIG_INTERCONNECT_QCOM_SM8750=y
 CONFIG_INTERCONNECT_QCOM_X1E80100=y
 CONFIG_COUNTER=m
 CONFIG_RZ_MTU3_CNT=m
+CONFIG_STM32_LPTIMER_CNT=m
 CONFIG_HTE=y
 CONFIG_HTE_TEGRA194=y
 CONFIG_HTE_TEGRA194_TEST=m
-- 
2.25.1


