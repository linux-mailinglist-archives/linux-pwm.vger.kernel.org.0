Return-Path: <linux-pwm+bounces-1415-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 010EE8545F5
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9645CB22ECB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F6E199D9;
	Wed, 14 Feb 2024 09:34:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF518EA2
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903284; cv=none; b=R21CiGoMUFkgO/g6N8GhwboXahNkFy2MgJw3t1t/5zzty1PQJoJI5g4D6DoLbd2Gnn4FOzNjnpwTTywVklfti9yw5oh1nH/99vMifmcq31H5+stYyRpOECiHVtJWc+IrnT6iYnepdcImJ5RtJcG/wFR8KlSyhLTyBtBL8LW1a2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903284; c=relaxed/simple;
	bh=ZT24cNY8zcntUd8fq3XcZvAtJgt8sVdYfXzdEPOOObc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCuBGh93lZXRWYhOhSdHCVcw1suIinVX7WMm3AFovLOC4M5ympcpGwo8wvTQKFtOStTSpm60pXiTVumGsIZDmXJ1bEkG17a6QQZ2UHaXtxQS8DDh3nf07q13SpwWev7EVTYd4E7xbCPy7S1mWqumGyh/f2AL6cbBuweFChUg2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-0005ei-PT; Wed, 14 Feb 2024 10:34:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-000fFP-Fs; Wed, 14 Feb 2024 10:34:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-004Y77-1L;
	Wed, 14 Feb 2024 10:34:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 108/164] pwm: sprd: Rework how the available channels are counted
Date: Wed, 14 Feb 2024 10:32:35 +0100
Message-ID:  <682cbbafbfc4982383d66c3871bb9e52d4e03195.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2947; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ZT24cNY8zcntUd8fq3XcZvAtJgt8sVdYfXzdEPOOObc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjHap+GA3pD47vAHmo3bzmGjaGhkAT9wcv0N 65eOAQRU6qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIxwAKCRCPgPtYfRL+ TqAjB/9BOp5R5PUBi/gsmf9C1NmcpUsuGzPeAWMdkIQiKjPASjTdItyos33MTAr6+zk742gyHlt kYS5Q8bWKnZisyYcCg/vYyq0XgF7LGE/IowyxBiy+vVPpI9N/4Tjsid/GvYTXBpNL2h9ccjLmWo A2RJm+fa0OuoN5cAF3hqHnDb0eBENU1TLpelA6vtc1vC0KLMocG2yrIkbmwGy3IuDS/ue4Hqiln kv/vQkiaSi39nd82X2TvLRBE+jhJP9OzLoqW4Nf7znAKTUCe7zp7HWNBJu7gd1iMu149z1JF7ji CD3RAJXvqFROpBW2yjoCxiQ+t0EEwBODU4UffzW4w2q85taC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

To be able to convert the sprd driver to pwmchip_alloc() the number of
PWM channels must be known when the driver private data is allocated. So
make sprd_pwm_clk_init() not take a struct sprd_pwm_chip. On the plus
side this allows to drop a member of said driver private data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sprd.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index 77939e161006..2e87666ad2b9 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -36,7 +36,6 @@ struct sprd_pwm_chip {
 	void __iomem *base;
 	struct device *dev;
 	struct pwm_chip chip;
-	int num_pwms;
 	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
 };
 
@@ -215,45 +214,48 @@ static const struct pwm_ops sprd_pwm_ops = {
 	.get_state = sprd_pwm_get_state,
 };
 
-static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
+static int sprd_pwm_clk_init(struct device *dev,
+			     struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM])
 {
 	struct clk *clk_pwm;
 	int ret, i;
 
 	for (i = 0; i < SPRD_PWM_CHN_NUM; i++) {
-		struct sprd_pwm_chn *chn = &spc->chn[i];
 		int j;
 
 		for (j = 0; j < SPRD_PWM_CHN_CLKS_NUM; ++j)
-			chn->clks[j].id =
+			chn[i].clks[j].id =
 				sprd_pwm_clks[i * SPRD_PWM_CHN_CLKS_NUM + j];
 
-		ret = devm_clk_bulk_get(spc->dev, SPRD_PWM_CHN_CLKS_NUM,
-					chn->clks);
+		ret = devm_clk_bulk_get(dev, SPRD_PWM_CHN_CLKS_NUM,
+					chn[i].clks);
 		if (ret) {
 			if (ret == -ENOENT)
 				break;
 
-			return dev_err_probe(spc->dev, ret,
+			return dev_err_probe(dev, ret,
 					     "failed to get channel clocks\n");
 		}
 
-		clk_pwm = chn->clks[SPRD_PWM_CHN_OUTPUT_CLK].clk;
-		chn->clk_rate = clk_get_rate(clk_pwm);
+		clk_pwm = chn[i].clks[SPRD_PWM_CHN_OUTPUT_CLK].clk;
+		chn[i].clk_rate = clk_get_rate(clk_pwm);
 	}
 
 	if (!i)
-		return dev_err_probe(spc->dev, -ENODEV, "no available PWM channels\n");
+		return dev_err_probe(dev, -ENODEV, "no available PWM channels\n");
 
-	spc->num_pwms = i;
-
-	return 0;
+	return i;
 }
 
 static int sprd_pwm_probe(struct platform_device *pdev)
 {
 	struct sprd_pwm_chip *spc;
-	int ret;
+	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
+	int ret, npwm;
+
+	npwm = sprd_pwm_clk_init(&pdev->dev, chn);
+	if (npwm < 0)
+		return npwm;
 
 	spc = devm_kzalloc(&pdev->dev, sizeof(*spc), GFP_KERNEL);
 	if (!spc)
@@ -264,14 +266,11 @@ static int sprd_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(spc->base);
 
 	spc->dev = &pdev->dev;
-
-	ret = sprd_pwm_clk_init(spc);
-	if (ret)
-		return ret;
+	memcpy(spc->chn, chn, sizeof(chn));
 
 	spc->chip.dev = &pdev->dev;
 	spc->chip.ops = &sprd_pwm_ops;
-	spc->chip.npwm = spc->num_pwms;
+	spc->chip.npwm = npwm;
 
 	ret = devm_pwmchip_add(&pdev->dev, &spc->chip);
 	if (ret)
-- 
2.43.0


