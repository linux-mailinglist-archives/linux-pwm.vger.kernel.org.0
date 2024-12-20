Return-Path: <linux-pwm+bounces-4426-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469F49F8FAE
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 11:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF46916CD51
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 10:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BB01BD9C5;
	Fri, 20 Dec 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="g0Yh4hn+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF91C5CBA;
	Fri, 20 Dec 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688964; cv=none; b=RzOnFLkKyo/qqh0AhYpGr0o5c96SkWa86lclqU/Kwj0ASeSfASS8yA+E9JbWPVR9tCxevww2rLHQ9FxL7wwpSxAqiehP8ATW1uOhzzZAnpIiOckYi9L/aJrFeXpwhhzPbFnYDEEq1rxqXq2iR6Aftl01wq78UndMHqacaEq25Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688964; c=relaxed/simple;
	bh=U/lb0n0uNrONMtN9zsWFyxezB3dHpJpZGzQXzh7InuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLomQGEoCVt2SQByHtscq483/LuJXnHiru4LGifefqvsw9n60CJn7eUYg7xT3TPAGdxQWEzm2X2xW9G95KBP2ppID6CNCaQxJUVusrkW6yzOx2u0yccUvtDuQlkU65bCwFJUwQ9xQY+zfY8oa4iR5guMLxlE91gfAwLONrDTCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=g0Yh4hn+; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK89EJl001225;
	Fri, 20 Dec 2024 11:02:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	OjXTcsvIAL+4FtVS8P5fKPwNHbwBgsvtSCaYyw6ZUH0=; b=g0Yh4hn+nV7g7rQp
	8vFgC51gPbXJa0QZICP8Hw6WYjEwOiyBiFRVEiP2j5KOsRb3l97QIOhSdP8JTLCB
	91g4+9XFq8aZu8xgyfq1gilZS+ix5B7X+ANo6WttFHo4ylt6SHVDpPXLdeRZKZRM
	X9ikMPK0cTwJ3aPybIn62mBdir7oEOpBRR7gljHA4sfI5GhzplXkyU5nzUvA1hQJ
	vjs9tO1hEchwKhOkvfFjhIcNmqpYinUm4+HGG3xpWjiWNngX4SKp95OrVUThDLZj
	cyTYOGxJk3OpPqjLT6LgOoFoz/vbAviyGdhnwvSOE2EInaMyculxo1lacADg7LFs
	qlr5og==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43n4d88pkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 11:02:33 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 35A0540062;
	Fri, 20 Dec 2024 11:01:14 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 73E63262B05;
	Fri, 20 Dec 2024 11:00:11 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 20 Dec
 2024 11:00:11 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 20 Dec
 2024 11:00:11 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alexandre.torgue@foss.st.com>,
        <wbg@kernel.org>, <jic23@kernel.org>, <ukleinek@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
Subject: [PATCH v2 6/9] arm64: defconfig: enable STM32 timers drivers
Date: Fri, 20 Dec 2024 10:59:24 +0100
Message-ID: <20241220095927.1122782-7-fabrice.gasnier@foss.st.com>
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

Enable the STM32 timer drivers: MFD, counter, PWM and trigger as module.
These drivers can be used on STM32MP25.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c62831e61586..d6aabdc103d7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -764,6 +764,7 @@ CONFIG_MFD_TI_LP873X=m
 CONFIG_MFD_TPS65219=y
 CONFIG_MFD_TPS6594_I2C=m
 CONFIG_MFD_ROHM_BD718XX=y
+CONFIG_MFD_STM32_TIMERS=m
 CONFIG_MFD_WCD934X=m
 CONFIG_MFD_KHADAS_MCU=m
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -1499,6 +1500,7 @@ CONFIG_IIO_CROS_EC_LIGHT_PROX=m
 CONFIG_SENSORS_ISL29018=m
 CONFIG_VCNL4000=m
 CONFIG_IIO_ST_MAGN_3AXIS=m
+CONFIG_IIO_STM32_TIMER_TRIGGER=m
 CONFIG_IIO_CROS_EC_BARO=m
 CONFIG_MPL3115=m
 CONFIG_PWM=y
@@ -1516,6 +1518,7 @@ CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_RZ_MTU3=m
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
+CONFIG_PWM_STM32=m
 CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
 CONFIG_PWM_TIECAP=m
@@ -1650,6 +1653,7 @@ CONFIG_INTERCONNECT_QCOM_SM8650=y
 CONFIG_INTERCONNECT_QCOM_X1E80100=y
 CONFIG_COUNTER=m
 CONFIG_RZ_MTU3_CNT=m
+CONFIG_STM32_TIMER_CNT=m
 CONFIG_HTE=y
 CONFIG_HTE_TEGRA194=y
 CONFIG_HTE_TEGRA194_TEST=m
-- 
2.25.1


