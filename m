Return-Path: <linux-pwm+bounces-5192-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA22A617EF
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 18:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E0C885FE1
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0CE2046AA;
	Fri, 14 Mar 2025 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="itp+4B3r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCAF202F6D;
	Fri, 14 Mar 2025 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973684; cv=none; b=qftIKIDq9ztCoH12xW1ggTA0/a8c6ET4OpdQHMWB1O+sHnkFrEdNRrORdNLcUK1+Pks8cJ4ck0bCRw5bCLoQmpBZPH3Bfl+Ps6z1jRl7+gO4pYn7K5ZCli7ikj35rE6LBIQmvhJeDBkC0TzeIMphaSqPs8UGq+F5xBV3qR5AcIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973684; c=relaxed/simple;
	bh=9FU/7m3L6w46a3y3tZQoZf0uV5nbJVVfFNXKFyOuXOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sjj3KV+ki6dTNXHwOUvso4mib1ydz7PW8rrhb+E4EFiSc1imxZ73dbe+GoU1qKXO0OPAzz8/1yB1SWVbPYVRflE+hJzTJd3mZbz6gzusBu4AEX/Q4EXQdgP/uEhEuS6QyaeYAbR1v2XBAdXSy3EIVV4K0yFrGEJ25p6kJcwmrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=itp+4B3r; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EF9wIc000641;
	Fri, 14 Mar 2025 18:34:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	HPWXN7XU6ij/VILhA4L2prDYWt4HSSzxWCxw+iSrXQ4=; b=itp+4B3r9rKo4hwC
	HNzlLq7jgA4uFFDPQmVojOmqSclbeZ6R7I6P+LyoIq8q4xFXqrO4fTUCjftg/NOL
	loD7xKhuMlwHYAj+KQz9ieDdOwzqF7dj6MGxGT3bi8a7YInOaC+y9PTsIG5nXlFF
	08ELdOeHXfOZ1v4si4LOaGqJ058oK8l+9VIjaca13SvrBId7XTYppObOvnzV8O+6
	7svBrf0piKsFylfhKfj00h4eUXGzhljwmnvFfi4HSth1MLnihYkyUFweRot1vHJ0
	PjMFntVokKbHhy9AjBA/9Gjt94HLsZUbwwvMtGshRClEvl8vSFtZOscuZV2sFgBQ
	Ymr3pw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45c2pkn7y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 18:34:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4568940063;
	Fri, 14 Mar 2025 18:33:04 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E436C6D8E8C;
	Fri, 14 Mar 2025 18:15:08 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 18:15:08 +0100
Received: from localhost (10.252.1.141) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 18:15:08 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jic23@kernel.org>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <robh@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>, <wbg@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v4 6/8] arm64: defconfig: enable STM32 LP timer clockevent driver
Date: Fri, 14 Mar 2025 18:14:49 +0100
Message-ID: <20250314171451.3497789-7-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
References: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
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
 definitions=2025-03-14_06,2025-03-14_01,2024-11-22_01

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
index 1f25423de383..b29b2350ae27 100644
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
-- 
2.25.1


