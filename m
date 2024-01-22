Return-Path: <linux-pwm+bounces-872-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5023E835C71
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jan 2024 09:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CCA283C62
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jan 2024 08:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8381520DDE;
	Mon, 22 Jan 2024 08:19:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4820DEB
	for <linux-pwm@vger.kernel.org>; Mon, 22 Jan 2024 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705911589; cv=none; b=FkzGFoHr3jACt0uEwJcbW7x23fys3J/jjnd3kkMCvnI6cQGCQUUIxwSQ3aHBXE2xgSbrKabL5c3mIoh8UZCHYpUSD5pXrWS0yCY9foy4nYgBrm2TC/rGa/e2ebA9f/st7OD1k4YSS4NKSX3ZgZqFAIqAqOgVJepS+yVrBLH7Gfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705911589; c=relaxed/simple;
	bh=r5yH1TaiCnUCBJprvitoDlf5mXdrpFFc3uvABTt2tEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/4KwLP9xfyq4xm9eP5FfqastKUM7N+oOV1rHdN6CcbwnWwDg3V7lUfSZZM2ipLzC8m/Axcf2TDs+6Ojh2pUQQm9c9LsL0mhb8hJJHwzZR4pkKeAKOOw1ZiRHWi2BB6a5qrOWGh/ZOz5TKkrjJ0Zzfb/spS6p/AVk7sGW6buyXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40M8I5t6055439;
	Mon, 22 Jan 2024 16:18:05 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJNFf5R23z2Rb68H;
	Mon, 22 Jan 2024 16:10:46 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 22 Jan
 2024 16:18:03 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, wenhua lin
	<wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu
	<xiongpeng.wu@unisoc.com>,
        zhaochen su <zhaochen.su29@gmail.com>,
        Zhaochen Su
	<Zhaochen.Su@unisoc.com>,
        Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Subject: [PATCH 3/6] pwm: sprd: Optimize the calculation method of duty
Date: Mon, 22 Jan 2024 16:17:51 +0800
Message-ID: <20240122081754.17058-4-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240122081754.17058-1-Wenhua.Lin@unisoc.com>
References: <20240122081754.17058-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 40M8I5t6055439

Use DIV_ROUND_CLOSEST_ULL to avoid overflow and improve accuracy
when calculating duty.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/pwm/pwm-sprd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index 411e91891c6d..22793e2b8707 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -156,7 +156,8 @@ static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
 	 * given settings (MOD and input clock).
 	 */
 	mod = spc->mod[pwm->hwpwm];
-	duty = duty_ns * mod / period_ns;
+	tmp = (u64)duty_ns * mod;
+	duty = DIV_ROUND_CLOSEST_ULL(tmp, period_ns);
 
 	tmp = (u64)chn->clk_rate * period_ns;
 	do_div(tmp, NSEC_PER_SEC);
-- 
2.17.1


