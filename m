Return-Path: <linux-pwm+bounces-1418-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE58545EF
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274AD1F2E06D
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF01AACE;
	Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E91946C
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903285; cv=none; b=CXaME1f0IirwD6GvYN929xzOdbM2gXmY5Rgjr20tLFuWHC6/r7vpiKbj5SOMCMxB7/quT5NkGcmHPk3uBnf+52oOFs8scCpOTW1eo5jI6BRuYjJlCUnhRDszd5gkJsbHRHLnDW2mhKX0WAJeO/iAPi1ppOHpoNN7eQa0TmV4PLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903285; c=relaxed/simple;
	bh=z54OT4HfwryX4EuuwgZHmmy9s7fo49dQ0R8lFoRKd9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SK810GEa+oE07JfwNUeyDneC/mPMp0hwr/Wx/IZjNk5lUYIWcJx65m6sfUKrWkJayQv6l5oaPMXanCHD42fp9WCnOboLABZKL4pxSyRJWdjGfeE0XDs8D8Ro4giy/mIXjYWZAqWYskWrW7FKixHQOxMZWi1ei+CMC1ymE+N7yzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-0005fj-DZ; Wed, 14 Feb 2024 10:34:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-000fFU-Lh; Wed, 14 Feb 2024 10:34:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-004Y7A-1v;
	Wed, 14 Feb 2024 10:34:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 109/164] pwm: sprd: Drop duplicated tracking of the parent device
Date: Wed, 14 Feb 2024 10:32:36 +0100
Message-ID:  <f85771f4bf659c0fdee30cf117b87fd877bad5e4.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=z54OT4HfwryX4EuuwgZHmmy9s7fo49dQ0R8lFoRKd9E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjI40AGwoCrXZXOiR2m9dkNKyBcoooFFU4Yk kqffYtkaGmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIyAAKCRCPgPtYfRL+ Ts2RCACnm2VbAKAmRmRcs7zGe9TDOt5bS3qiHxkbSFXb9vUfw00qeJ6Gpbj0i1jXoCCXsAu8kSp Qrb3rCieazEftJsdwJttE/rxi6Atqh+bwQ4YRYwMegLKStkdjz8ruhw45Th4j8kc5ICK6nsZKjZ E8oelb3Cb4lBmldAQFDXIMZKHCY8k3qdpEXcft5D9cRaq6UVCltpfevS5GMsNFIf0i1Yy4EntuU suUf+1b6hbGGjudxZTPNMc4AXfJXmF/oOIyPruPSHOmvFiXR7ziwsDBUsGjSskO4RUOR5a76vNd nUraOHi5boijeTTSxtjVd2V5o4YsrmwUG5kTJcGFh+GXJnZo
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The pwmchip stores a pointer to the parent device, so there is no need
to store another copy in driver private data. Drop struct
sprd_pwm_chip::dev and use the pwm_chip's parent pointer instead.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sprd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index 2e87666ad2b9..a38f50c3dc00 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -34,7 +34,6 @@ struct sprd_pwm_chn {
 
 struct sprd_pwm_chip {
 	void __iomem *base;
-	struct device *dev;
 	struct pwm_chip chip;
 	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
 };
@@ -85,7 +84,7 @@ static int sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	ret = clk_bulk_prepare_enable(SPRD_PWM_CHN_CLKS_NUM, chn->clks);
 	if (ret) {
-		dev_err(spc->dev, "failed to enable pwm%u clocks\n",
+		dev_err(pwmchip_parent(chip), "failed to enable pwm%u clocks\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -182,7 +181,7 @@ static int sprd_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			ret = clk_bulk_prepare_enable(SPRD_PWM_CHN_CLKS_NUM,
 						      chn->clks);
 			if (ret) {
-				dev_err(spc->dev,
+				dev_err(pwmchip_parent(chip),
 					"failed to enable pwm%u clocks\n",
 					pwm->hwpwm);
 				return ret;
@@ -265,7 +264,6 @@ static int sprd_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(spc->base))
 		return PTR_ERR(spc->base);
 
-	spc->dev = &pdev->dev;
 	memcpy(spc->chn, chn, sizeof(chn));
 
 	spc->chip.dev = &pdev->dev;
-- 
2.43.0


