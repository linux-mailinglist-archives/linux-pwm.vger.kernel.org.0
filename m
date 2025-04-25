Return-Path: <linux-pwm+bounces-5710-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF16A9C956
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 14:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6804E350E
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF22522B5;
	Fri, 25 Apr 2025 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="p/lPAPcJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1CC232369;
	Fri, 25 Apr 2025 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585429; cv=none; b=uluH8wDAXTPSnABER7qiRSJPKWc9SwIC5HHBqRhTketmHMxnhDoyXjd/uWqH1pkguOnGQ15cn6qE6CnF7p0voW8ofVu9fj64WXaiL3vMDvv55cRX6HVfP2oN2+aOm/DFhkFHeAjFGZrX1ct58qcPJh1i8/NyXcFFeqwXBZLGG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585429; c=relaxed/simple;
	bh=pSgyMyO+6NdvGJb/3PCYahO4sbYNutrYAsAdKDVc0TQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJ0l/LajJ09rHcDBdLAMGt6zuyZ9mYqiON3BgOuVEbc04ftQaZCtglEGb9KrBH1dw++PRQpMXXRQ8LwPZs+LEmMk3iARU3wHmPH3WfnZabFebZHjY+RLmfhMA2ySMe3eATNh3gGJ5qzKjDadyR2h/YLoJfWazMTybezuOMhTWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=p/lPAPcJ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8Fv5T009034;
	Fri, 25 Apr 2025 14:50:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	/Etz2e5JwOfdvpR/r973gOFgQ/rV50weJX1P1VEC9tU=; b=p/lPAPcJbCtQfVZm
	dNtSXtsDIZ3ofDf8gaex+w5N7Zo7p/rhyb6Gw5RjyyyD86az+lW9wubYBiQI/+09
	ZKHXHk5ZEBxDN6Fg2sCtbufCtE6UVhjio4T7jM3nnv6cTdgHuVU+5Nb4Tw2/f+9T
	GqIEvyE7MMnx5p2z3+KOHmqwcLkovsSuEOWar9AG6X6Nlf/39KScMPYnPUhq84sp
	Rrzr0zPw0Xm2FZk3MqYT07IIl+KzaiIkf2arYVdGl4jK2RENYPuIN3TDd5ZOIDnX
	z1jzaPAF6ytTBA3aUpWREu0cwVJcFaa7yx2GcMpwIG0mdfKbzBU6ZXKe7colYwMR
	jNn7ew==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jjxm5s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:50:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ABC184004D;
	Fri, 25 Apr 2025 14:49:15 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 48F41A087A4;
	Fri, 25 Apr 2025 14:48:09 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 14:48:09 +0200
Received: from localhost (10.252.15.6) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 14:48:08 +0200
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
Subject: [PATCH v5 5/7] arm64: defconfig: enable STM32 LP timer clockevent driver
Date: Fri, 25 Apr 2025 14:47:53 +0200
Message-ID: <20250425124755.166193-6-fabrice.gasnier@foss.st.com>
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

Enable the STM32 LP timer MFD core and clockevent drivers used on
STM32MP257F-EV1 board, for PSCI OSI.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- dropped unused IIO trigger, PWM and counter driver unused on upstream
board currently, as advised by Krzysztof
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5bb8f09422a2..d106cdac05fa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -777,6 +777,7 @@ CONFIG_MFD_TI_LP873X=m
 CONFIG_MFD_TPS65219=y
 CONFIG_MFD_TPS6594_I2C=m
 CONFIG_MFD_ROHM_BD718XX=y
+CONFIG_MFD_STM32_LPTIMER=m
 CONFIG_MFD_WCD934X=m
 CONFIG_MFD_KHADAS_MCU=m
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -1414,6 +1415,7 @@ CONFIG_CLK_RENESAS_VBATTB=m
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_TEGRA186_TIMER=y
+CONFIG_CLKSRC_STM32_LP=y
 CONFIG_RENESAS_OSTM=y
 CONFIG_ARM_MHU=y
 CONFIG_IMX_MBOX=y
-- 
2.25.1


