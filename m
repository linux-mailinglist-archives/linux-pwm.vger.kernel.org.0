Return-Path: <linux-pwm+bounces-4970-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C224BA42ADB
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2025 19:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B773AF766
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2025 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228C2266564;
	Mon, 24 Feb 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="pbvSrMwM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F33C266562;
	Mon, 24 Feb 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420853; cv=none; b=ttMudrIr6F2Hifgx2yXrYjfNEVcVg8lQZRQWay0nip9gW15QrLp8EGVFpgwpUDpJ3IjYTSJ5yLgSx84XNEfy4e5IiKDpr527YLErVLjXcNG0XsAhoNUQtPBmMt5n30kXpnbNafPRtRON/gG+xQZK35Enu5H5yUkyyk48cI1+TYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420853; c=relaxed/simple;
	bh=LWpxbiMlNMmW65WjMo5ytNfsRfFaUoimPW/eXLfU+nA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqK7F2T/Uf+nAisb7k1x2JlD5ezKlj2AeM2mQDoei/equrNDjhqswzGX61MX6F/AIrzaEqvcy7KC+ImO+GsJLDYh5n+6CZT7BFfyI0k++51aV5j8TM5sueu5qddhCxvYkUZaWyhE9xIs38beVuFBx4AAMRgMXbDkKWT2jeWf30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=pbvSrMwM; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OI5nFY016067;
	Mon, 24 Feb 2025 19:14:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	y1LfaKFPoTC4v1dxInK++vJm6Q2Kzbh+55LNQbh/FpA=; b=pbvSrMwMevvbdkcS
	fzpJVXUTL44W2zAbJr9RgovvNxNfZOCW7UcCDtLIxTNpT/zSqrZ/BVuoGpXf5dAP
	X1jYd3knN1uh7cjSwSSFIUhCUfCHVTWNTnU6r8sG2zkLp4wCEgJ3sIcvGIKTEwo6
	m2DQuEXOQ5LzIYyyJ9VHQ70IixJj1XM6JO+HUnZsDT3i6thlvF9lwvC793gdVrxC
	4TtE3+lguPx3EYCOL1wesd9LD//Txysx9spEAVCzR+4naeZtYtPKBHqxw6poB9v2
	EuUUmTw/Qe4A3Au+KnLJbged+1FpYctp8E4CYYWqqJTfrg+6w1Nuf8NBtHRsUvEM
	5aDj+Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44y4k80r9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 19:14:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E45A340076;
	Mon, 24 Feb 2025 19:12:29 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C70D35461C4;
	Mon, 24 Feb 2025 19:02:34 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 19:02:34 +0100
Received: from localhost (10.252.23.75) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 19:02:34 +0100
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
Subject: [PATCH 6/8] counter: stm32-lptimer-cnt: add support for stm32mp25
Date: Mon, 24 Feb 2025 19:01:48 +0100
Message-ID: <20250224180150.3689638-7-fabrice.gasnier@foss.st.com>
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

Add support for STM32MP25 SoC. Use newly introduced compatible to handle
this new HW variant, even if no major change is expected on the counter
driver.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/counter/stm32-lptimer-cnt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index b249c8647639..a5dce017c37b 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -508,6 +508,7 @@ static SIMPLE_DEV_PM_OPS(stm32_lptim_cnt_pm_ops, stm32_lptim_cnt_suspend,
 
 static const struct of_device_id stm32_lptim_cnt_of_match[] = {
 	{ .compatible = "st,stm32-lptimer-counter", },
+	{ .compatible = "st,stm32mp25-lptimer-counter", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_lptim_cnt_of_match);
-- 
2.25.1


