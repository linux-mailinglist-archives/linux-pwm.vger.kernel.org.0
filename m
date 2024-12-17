Return-Path: <linux-pwm+bounces-4381-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257CF9F4ED1
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 16:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A9618967AE
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC71F7086;
	Tue, 17 Dec 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NUN1FDnT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4411F6690;
	Tue, 17 Dec 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447747; cv=none; b=jIRpeRjgwWP1KbRS6NxIkmkzI77nF/yoLsysO8/Dixs2QV7aofFfOpf/+ro7WDMv63JdRPvP4CPEqS40ZrenD6OGc1mLXdy1hAdg9KfuzAVI8xAIv7tyqT8TdT686RNOY7BC549nt/wkUF0UGtuouMNTi288nKuO0xy36+hg0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447747; c=relaxed/simple;
	bh=Cq0ojv7gA2KWxo8/iShO6NX6ctPHC5kxhWP2lfhE/YE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cWcKN6MvoUOP+MsQxXdFpottJuymBMuG0wEGgc2cXlNDPg8JrA+UNMk4ixj4v3xb7eKsxNypQmERcqSmEu8+qFgU8pPgs1JuY4Zt6xQ7FuQh/jix2spOzchHGAl+g4WCqCHnU8bV2GPZB2HaceCRzLA9ib1nsxjC09AzOXd2qB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NUN1FDnT; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHDCT19020655;
	Tue, 17 Dec 2024 16:02:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=SykAPbdT9Bxh/XN2cwTtfy
	OFKxm8MvNOlBJR/xt+HXc=; b=NUN1FDnTHPaBMDjtMJ99rycVqvNClpey4FEnhw
	21CMwgO38ncdfS5ViO5jG9M5+oPBwvRnSBBPGXoMQLFmTJeQ5AVP2GPOw5XtCcDG
	7g6qGQOlmYCsY4idVXpoTO3vJ2yK4d93COYCETwRS3dp6iyIPP/j9FTLlu69QmRC
	GxgjQrYfgR6YFU0hLUsx1IohN+HcZ7xbzPazirZBr+db/hlzrK1st7E/xCON/WX5
	slMw8vUe6rS5ZAQqz67SxtnrO67cOIk6XNEg+ZNODj3B3+hjEwe9XSOt95yduTUF
	RYPuijPAV6ugYft7DXJ/pilVNWyK+EKHWLjKRux7+z8MZxHA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43k5dgtaq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 16:02:05 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4DED440046;
	Tue, 17 Dec 2024 16:01:16 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1A8AB27C23C;
	Tue, 17 Dec 2024 16:00:54 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 17 Dec
 2024 16:00:53 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 17 Dec
 2024 16:00:53 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <ukleinek@kernel.org>
CC: <alexandre.torgue@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <olivier.moysan@foss.st.com>
Subject: [PATCH] pwm: stm32: fix complementary output in round_waveform_tohw
Date: Tue, 17 Dec 2024 16:00:21 +0100
Message-ID: <20241217150021.2030213-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
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

When the timer supports complementary output, the enable bit is
overridden. It should be OR'ed. This makes all PWM channels for
such timer not to work.

Fixes: deaba9cff809 ("pwm: stm32: Implementation of the waveform callbacks")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/pwm/pwm-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index b889e64522c3..17e591f61efb 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -84,7 +84,7 @@ static int stm32_pwm_round_waveform_tohw(struct pwm_chip *chip,
 
 	wfhw->ccer = TIM_CCER_CCxE(ch + 1);
 	if (priv->have_complementary_output)
-		wfhw->ccer = TIM_CCER_CCxNE(ch + 1);
+		wfhw->ccer |= TIM_CCER_CCxNE(ch + 1);
 
 	rate = clk_get_rate(priv->clk);
 
-- 
2.25.1


