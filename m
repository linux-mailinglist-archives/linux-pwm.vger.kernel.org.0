Return-Path: <linux-pwm+bounces-1391-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A4F8545CE
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E182289F3E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335CF179AE;
	Wed, 14 Feb 2024 09:34:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31739134A9
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903281; cv=none; b=mL7dxo1jxC0te4yE58y1AZ4Rw/l1LqfYvnk33SCoKlVhZEnvzfj4D4O7aZgffbg4VNCMVAVJKQEggSEQNvmnf4wEd872vh88FcQQkdUKJppKw5V5gjg8SFV3OHXOeq4UHhVNaqhBB56riJk5Sca8sS6CU34KUAyh+USWAU+mFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903281; c=relaxed/simple;
	bh=AQe1rrYsLMagO5qDh4FMXMJlD4K48r1sGjmHzwiedsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTw3bMbD2BvBfNM2jOrZ5l0FBENOWhmUqgfJebqWxft0tweowqzEQ6yIqHzLMLClc2iGkkKjdee26g/pKuE0dGVtYwijgmM2bD5Z5jKAyxNZkue4xU0beCUxZKpKQdKPcSSyTe9VPYTZ1xBOOA1BJM3QvI7xh6HbqO7t5JrlIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-0005M1-Bn; Wed, 14 Feb 2024 10:34:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-000fEC-Kn; Wed, 14 Feb 2024 10:34:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-004Y5i-1o;
	Wed, 14 Feb 2024 10:34:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 089/164] pwm: rcar: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:16 +0100
Message-ID:  <a37a167364366b6cbe2dd299dce02731706213b2.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=AQe1rrYsLMagO5qDh4FMXMJlD4K48r1sGjmHzwiedsU=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHRtbHzVEv9t/LW5qNp+jzCr+V2myG+pWtDPNf3Xlf NVum6hrnYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBMZM509t+sKu59tRe+73rD 3B1o9N0/6qc2W7ZN9WPDbJcNORobtFh6bYSYHgQk999LVNt88YWX4KRuzQPP19kWsfxX8XBi26m 3YP2hve8fP19aGLhE78THE4L/0+Ry4rtyK6x6bpZP+h20+tSUBxP5zBzWrWtL+vXur/7TZv6eGw yKAfdF0+sN+ffIMIgxhRXwR7ObsmUILhFI+PlfY5lEqk7lLeeTFhH3nq7c0qtxtYfV+/mSuR8kV WPrfhSX7dC2d+L59YWrjNlTU9tXhH+fw4xOoVXfn2QEtj/6Z+nYGWBizWkRyil2sL23ZD5f4Q2V dJcFAc0zt1lbrD+WEVVcJfl2uc3vNw8lcv9pNDMrXH8LAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-rcar driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rcar.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 1dfcc74efcfd..4cfecd88ede0 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -38,14 +38,13 @@
 #define  RCAR_PWMCNT_PH0_SHIFT	0
 
 struct rcar_pwm_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct rcar_pwm_chip *to_rcar_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct rcar_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void rcar_pwm_write(struct rcar_pwm_chip *rp, u32 data,
@@ -206,9 +205,10 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 	struct rcar_pwm_chip *rcar_pwm;
 	int ret;
 
-	rcar_pwm = devm_kzalloc(&pdev->dev, sizeof(*rcar_pwm), GFP_KERNEL);
-	if (rcar_pwm == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*rcar_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	rcar_pwm = to_rcar_pwm_chip(chip);
 
 	rcar_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rcar_pwm->base))
@@ -220,10 +220,7 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(rcar_pwm->clk);
 	}
 
-	chip = &rcar_pwm->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &rcar_pwm_ops;
-	chip->npwm = 1;
 
 	platform_set_drvdata(pdev, chip);
 
-- 
2.43.0


