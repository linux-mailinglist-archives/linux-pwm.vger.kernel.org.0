Return-Path: <linux-pwm+bounces-1318-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FC385457F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32601C2172A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A8616436;
	Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9514004
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903265; cv=none; b=iuk2d4YQl8xVvkMBUKeozFMymEu6JSwyQEJTvoGmQELGqAFmL3gk/fgiAH31zsaq9b1ZHGwYGgx8tIjaY2zkD3lYvL+/6CKc/CvK+d+aoeHsZx3npvrvWAlY/my2JjoTfZE5Jepq/rYwy5JhkrxvK1I2VDG9kmc5m0ghJ/oAxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903265; c=relaxed/simple;
	bh=maEpnSL3Jn2wG/Z3f3FbK7j1aqH22vcv4Aw4htOsmOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h59TN/7417vlipke7BjkSL03J6B4fIWhgbkF3+dIYZYgFKHyZD6/MLQx/69j+PFKOUL0tkbK+Txk5c4NQase+CG71tA0soOqTayksS5NW1sUDUJ0fJrBtZIYfjwqrs3AzyOulLcc0mhN94lh3wWSLdRfSUU2pamzNQcbP/I8AAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-0004OD-Us; Wed, 14 Feb 2024 10:34:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-000f6f-IW; Wed, 14 Feb 2024 10:34:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-004Xzz-1b;
	Wed, 14 Feb 2024 10:34:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 005/164] pwm: ab8500: Introduce a local pwm_chip variable in .probe()
Date: Wed, 14 Feb 2024 10:30:52 +0100
Message-ID:  <7fae4833b97728abc8bd400663fdd331c86a761b.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=maEpnSL3Jn2wG/Z3f3FbK7j1aqH22vcv4Aw4htOsmOk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhQWA5LvB/bCV9km8IWrKfXwqX+rgrXc7K4/ TbbR4WdxVGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIUAAKCRCPgPtYfRL+ TmDWB/0apYL11cNiZTaLzrKglUNl1wwsZNkEFyqZNzaopgkiPcFNhqLiyrIVwnjjKlCH0fwjNRR PvYbK57OsTmVpvwnGNjl8uMYktbnSYrfgcRndeHWW8IHKFZoXatncUsrRHPPrQfnBBwAyowo3RQ LIy1ZrO+4JvDO7VgTjbKIvot10IKKoC+ccmF8JsgbbUDde3qnzt+Oy3xAPaL7yhpO0c8NuMUINd /a3Dxy5jOYF5p/kmytRnWpuj+fdvkLqDStqGZoB7VyldaoG0qxxNM0iaJL2IOzxfWMbGuCGP/qs SfCjMIX3l79Xd+TvGoAJgiIUlxmLtQkJLg6KeoWSnX6Ik0ph
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This simplifies converting the driver to pwmchip_alloc() as there is only
a single code line left that makes use of struct ab8500_pwm_chip::chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 719e4ccf1800..9043e5643f44 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -185,6 +185,7 @@ static const struct pwm_ops ab8500_pwm_ops = {
 
 static int ab8500_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct ab8500_pwm_chip *ab8500;
 	int err;
 
@@ -199,12 +200,13 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	if (ab8500 == NULL)
 		return -ENOMEM;
 
-	ab8500->chip.dev = &pdev->dev;
-	ab8500->chip.ops = &ab8500_pwm_ops;
-	ab8500->chip.npwm = 1;
+	chip = &ab8500->chip;
+	chip->dev = &pdev->dev;
+	chip->ops = &ab8500_pwm_ops;
+	chip->npwm = 1;
 	ab8500->hwid = pdev->id - 1;
 
-	err = devm_pwmchip_add(&pdev->dev, &ab8500->chip);
+	err = devm_pwmchip_add(&pdev->dev, chip);
 	if (err < 0)
 		return dev_err_probe(&pdev->dev, err, "Failed to add pwm chip\n");
 
-- 
2.43.0


