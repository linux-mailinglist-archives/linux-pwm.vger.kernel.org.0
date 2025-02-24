Return-Path: <linux-pwm+bounces-4973-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312AFA42B0C
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2025 19:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D6E176195
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2025 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1C266B5A;
	Mon, 24 Feb 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HmSwivo2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CEE26659E;
	Mon, 24 Feb 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421181; cv=none; b=lwHY+2+JnwYqvtwKZyEmlGMI5oMZF+SH22lgp724f79bQ5Z08HqE9cGpoo+WaCcs0wNxZIKXYXsYWOeJQbK/c8nWZulZCg7fAHtD+XZyI1QSvmuhTjszOR0+t7/EgycIdk0ybbipYprWStTPIh2mnqUGXhie3kPjNEGAAmjtfjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421181; c=relaxed/simple;
	bh=gzgQdm+JmvR7MKlx7feYwCW2Y9SAYJHpvwy/wetQL4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N87H6zqF9cvP4Ub8Z/Far51cVmyLipj5Mn5qkkYtMMrn+L5xyOmqz/OHHHwzwMZYCUkKpBBsdZhYzwfg/XGqVId8LpT+BS5ErOaVftOCG+e03yMdHkzR+qszjbBYVSZW8tRbWUhQTAIkZkge2+vKjprh8fr7sf4ZbjBHQzqu9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=HmSwivo2; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ODQlVP012696;
	Mon, 24 Feb 2025 19:14:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	osiU9ANcAUpNcWXhI2xaSMZVYF5nDauriCTMslBkOmI=; b=HmSwivo2j8yGU+OD
	8CvXkxMFfO5N+oopQOWZ+3OvOWV2lwkMs9P+TV0dGKbS1xutovlmhIgUMC4MIVl6
	pXLTcG0x+LBBFE/SDLqOBmCsEMhvDbAZ6Yvvq7cY/UMTnUk2T70zH7VrWZRjjvRE
	tMANRs2l89fVQoihhQIZO5mcuEbHSaccQ/0QNU1lD2ZAZw6p3chl4g7RbDHgkxTL
	s789FLzbSAjlrlyzkloUwbBUiVo3XvjExkCruTRqqLI9TMMoVTWULgaVLyfTAuSD
	xOZAWjUvJ8YASwQkrtlZ+IvcCcNc1RUM2Otz7rTSmuvkhiARwoOqCmTyXVEhLpic
	w2oTPg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44y4vm10xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 19:14:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DA2FD4006D;
	Mon, 24 Feb 2025 19:12:29 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 22CBE5461C3;
	Mon, 24 Feb 2025 19:02:33 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 19:02:32 +0100
Received: from localhost (10.252.23.75) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 19:02:32 +0100
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
Subject: [PATCH 4/8] clocksource: stm32-lptimer: add stm32mp25 support
Date: Mon, 24 Feb 2025 19:01:46 +0100
Message-ID: <20250224180150.3689638-5-fabrice.gasnier@foss.st.com>
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Add the support of the new compatible for STM32MP25 SoC in driver, as
described in Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
and used in arch/arm64/boot/dts/st/stm32mp251.dtsi.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/clocksource/timer-stm32-lp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index a4c95161cb22..db055348e2cc 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -197,6 +197,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 
 static const struct of_device_id stm32_clkevent_lp_of_match[] = {
 	{ .compatible = "st,stm32-lptimer-timer", },
+	{ .compatible = "st,stm32mp25-lptimer-timer", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_clkevent_lp_of_match);
-- 
2.25.1


