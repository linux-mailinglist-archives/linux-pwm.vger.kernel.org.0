Return-Path: <linux-pwm+bounces-1434-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC68545FC
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8A11F2E0E6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF8A1B968;
	Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4221A286
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903289; cv=none; b=t9PBQvbexK8sIwY4GfSm/snH0hg62vh8/Fwfin3cgt+fYbN9kTBBtYTM1U5shFk4zjIU9A/ymwvecLYNIj9B2J5WTyoXiqwn9ZlZQJxntWmomdNaFT0PZU1AZBIAIxYQsMhnhT7c1OytF/KukGjEG7D+Atd5gPGiYN+HLB1BoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903289; c=relaxed/simple;
	bh=mRVaVzxOuHc8/iADtJONL+ijTkKUJ56s+MALA1iYH+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1ElaIRITrA+/NNJvuxmL8CMjpDx8rT86ZkIzLkgkGBIqM+pRJIuyuixn9RQ2SL4nasqxBxMDqskuSni+QEttRTo8tCh6mC4DndMDqTNBxcu96SMMgpu/HhR2QHUlu3HBsOc5eJ8kOJqCa9G+ppRcbySZEpEPQt2FitMsNAAZHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-0005W0-9f; Wed, 14 Feb 2024 10:34:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-000fEx-7y; Wed, 14 Feb 2024 10:34:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-004Y6R-0Y;
	Wed, 14 Feb 2024 10:34:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pwm@vger.kernel.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 100/164] pwm: samsung: Simplify using dev_err_probe()
Date: Wed, 14 Feb 2024 10:32:27 +0100
Message-ID:  <27a55fc05eb13802c9eddc600d0460e279388999.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=mRVaVzxOuHc8/iADtJONL+ijTkKUJ56s+MALA1iYH+A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIi+D0n05TAovcPWo0WShbw+vCNK1F8jTDUqD VLx1zSxmbiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIvgAKCRCPgPtYfRL+ TpCFB/0WucM+81bYSS61dW50ExWjOJcYGSvOPnQh86vjDP2FsfAuR6/MnBbxOuWV1aQgw4UGKTO JhdTTmA3lyMwhIqjQhFy1j9XUmAYP2DA41As7r96QCRauDEZ4ZHvneHWID/YgNIhsYhKC5AiPWW HoxKRcFryR23chuKQ4KvbMx9oQE7KKbd6J97dhEwHn16DdHN+BgZEbNqnxMlxV7JHekTJFZBO0h B8MYZDYDFa86cQX8HkHIERN/2EKeFeF75yXmrEMSOSr5PKDx776N3D654B7j9fg8b2euxdPNMAD CoI/fmjmjjlQPJfX8Hyx5UyIJAJiG5XPqfXh72tvt046zXen
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

dev_err_probe() simplifies and improves the idiom "emit error message +
return error code". Apply it accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 81a2e66e927e..d3dc9b5b80d6 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -564,10 +564,9 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 	} else {
-		if (!pdev->dev.platform_data) {
-			dev_err(&pdev->dev, "no platform data specified\n");
-			return -EINVAL;
-		}
+		if (!pdev->dev.platform_data)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "no platform data specified\n");
 
 		memcpy(&our_chip->variant, pdev->dev.platform_data,
 							sizeof(our_chip->variant));
@@ -578,10 +577,9 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 		return PTR_ERR(our_chip->base);
 
 	our_chip->base_clk = devm_clk_get_enabled(&pdev->dev, "timers");
-	if (IS_ERR(our_chip->base_clk)) {
-		dev_err(dev, "failed to get timer base clk\n");
-		return PTR_ERR(our_chip->base_clk);
-	}
+	if (IS_ERR(our_chip->base_clk))
+		return dev_err_probe(dev, PTR_ERR(our_chip->base_clk),
+				     "failed to get timer base clk\n");
 
 	for (chan = 0; chan < SAMSUNG_PWM_NUM; ++chan)
 		if (our_chip->variant.output_mask & BIT(chan))
@@ -594,10 +592,8 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, chip);
 
 	ret = devm_pwmchip_add(&pdev->dev, chip);
-	if (ret < 0) {
-		dev_err(dev, "failed to register PWM chip\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
 
 	dev_dbg(dev, "base_clk at %lu, tclk0 at %lu, tclk1 at %lu\n",
 		clk_get_rate(our_chip->base_clk),
-- 
2.43.0


