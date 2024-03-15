Return-Path: <linux-pwm+bounces-1774-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013A587CF82
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Mar 2024 15:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 939BFB20BA9
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Mar 2024 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396B13A1B5;
	Fri, 15 Mar 2024 14:54:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED4425565
	for <linux-pwm@vger.kernel.org>; Fri, 15 Mar 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514493; cv=none; b=A5VPRqEPddoDrNJALPx95R4lTfeVVp6aqXtTI45mf4PQvOwt9kT/tBL2loss5cCGZLvgzVrW1ezLc5rU8GijSNoQ3cxc4MDvd2lo60th4WQUyXvjbnjp0qLqXJyf3ui6KoUKkB/jEwx4uIlKwHe2x/H/P2PtJSNsZZWCKSe011U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514493; c=relaxed/simple;
	bh=5xtuVME2bEVprkiCGWUVejqQHtDlCZ5J0Kbg7qpVECI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FrXzicwVbYfhKIwXYO9Bq1t6R2KTHR0iIwEYpTFhYHpvtTQNOcfN0v8UWygY2hUoFT8FMJikg3bb7wZsZ5erq1KqsYYS6DsJeTkCZ59H2r9e3tWD0/NA0UmTsvXCXkH6sIJo1QsRCDJh1a1CSr2lCAdFZWh32vyOgNy9rIHVVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rl8xM-0000Km-Lm; Fri, 15 Mar 2024 15:54:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rl8xL-006WVk-0w; Fri, 15 Mar 2024 15:54:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rl8xK-006kDD-31;
	Fri, 15 Mar 2024 15:54:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: stm32: Add error messages in .probe()'s error paths
Date: Fri, 15 Mar 2024 15:54:43 +0100
Message-ID: <20240315145443.982807-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5xtuVME2bEVprkiCGWUVejqQHtDlCZ5J0Kbg7qpVECI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl9GEzzgJmj7PhAFoXRTzvOnXpgcBkQwROOyhaP BADzsJi3pmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfRhMwAKCRCPgPtYfRL+ TmseCACAhdodC9zN62s3ZYGZYsReg94sGAqphWAr91MEB1mhmweD5B+kNl9HicbTmVf8mFz1sLu UcX1/Kzy7qtPM+upx/WHNpIJCHDyxTUau5354qEa5g8qBRmJ5RFNsGhbpIY0J8WtJxYQY5bAeDQ 08R1lTvei0MH1U+jJQivfo+lDmp8vrJDA/QXVFW2sdnuFyqkY8ohs5BqDu14mAf0feHx+OypEgk mnOFbBPir2F+cfIPYqolPNpkC0AZox2k6xftgjXQb7ifT4iRq1IpZqnsYz5Rw2rp5qbZX6e3n/d 9peF0jWsYkonm3KizXWLp9HclCw7jVe8BFKa/5u4S90VIadH
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Giving an indication about the problem if probing a device fails is a
nice move. Do that for the stm32 pwm driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 0c028d17c075..ffe572b76174 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -648,11 +648,13 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	priv->max_arr = ddata->max_arr;
 
 	if (!priv->regmap || !priv->clk)
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL, "Failed to get %s\n",
+				     priv->regmap ? "clk" : "regmap");
 
 	ret = stm32_pwm_probe_breakinputs(priv, np);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "Failed to configure breakinputs\n");
 
 	stm32_pwm_detect_complementary(priv);
 
@@ -664,7 +666,8 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 
 	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "Failed to register pwmchip\n");
 
 	platform_set_drvdata(pdev, chip);
 

base-commit: dd6c6d57ab61d496f6ff7d6ca38611062af142a1
-- 
2.43.0


