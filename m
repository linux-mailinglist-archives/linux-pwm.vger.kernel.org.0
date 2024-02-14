Return-Path: <linux-pwm+bounces-1464-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F94854623
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EA61C220E4
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F315118EAD;
	Wed, 14 Feb 2024 09:34:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAAC134A9
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903292; cv=none; b=m0phq2kEtAbfMwMA97vqyThyQSi7orTDWZKsoEHczTOa2zR3BHGVBTWotiD1/Im1yel0/OnjKEqds2F49WJkublQD8NhsYfbfVjY3uvsRmgXeJ6lhYa2uZxwH9qvKFMbWo7xaCQ1ILhFuVtEJVhr0EZB1IKU6SGLbOmA/K1ganY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903292; c=relaxed/simple;
	bh=rxI43Yujypy77xT768quBIuTIJlQXuHWwYYfj97S0uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUIY2K31YjNndaTK9v+tUK/9EpyKfLWvsJ7LSFBphKjPkpZytP9GEZM+wXFNaYEo6KFGf49UdLIWF4Or9fbhvYOL0LQnt35pwFGMshdT+qUCldY6guspF1lXkWipT4b7MgQ9IZw963Zb9FL5t3BLezeHDpvFyHirMsqklZ+pooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf9-0006Ah-7n; Wed, 14 Feb 2024 10:34:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-000fI0-ID; Wed, 14 Feb 2024 10:34:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-004Y9r-1Z;
	Wed, 14 Feb 2024 10:34:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 148/164] pwm: vt8500: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:33:15 +0100
Message-ID:  <b203c4448db23ebad1165b7bce43ac41468c4e89.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=rxI43Yujypy77xT768quBIuTIJlQXuHWwYYfj97S0uo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIj02HTPmlqclJ16Q4aGRNjgVhgGhIukT5CBd BODoNDw2e6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI9AAKCRCPgPtYfRL+ TviBB/48ZsIKp9OAnWE7ctCnSaJJ/kLw4UNBCKROpduCVBputp1yAxuewPUOsi6camFoBBMBJif PAnE5YLLv39F+OgeQD0cShjLxOtFqo6mZUQGJqnHW61Pu4FppZvPMMbe6TbNF3sS9pa/RvvamA4 cIxMytdCpzPGGXX+4gsjEvX1xUvt/Wr63SDkxBAUwWc26QNF7l9wlHygC9tyC5+9UdnWGYd+npd znFyou/c4eney24KX/35FhxSe02CNz/ycQxBAHK4B4Vhgo8Z3UvJEXoF++U59jr4nFihdDbsDeY VKk1+1aZkGNqvLns8M+3QeQYWiV2AmZqBvrxcNPnf72mguse
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-vt8500 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Also convert the to_vt8500_chip() helper macro to a static inline to
get some type safety.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index fb4dbc88b0a3..016c82d65527 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -45,12 +45,14 @@
 #define STATUS_ALL_UPDATE	0x0F
 
 struct vt8500_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
-#define to_vt8500_chip(chip)	container_of(chip, struct vt8500_chip, chip)
+static inline struct vt8500_chip *to_vt8500_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 static inline void vt8500_pwm_busy_wait(struct pwm_chip *chip, int nr, u8 bitmask)
@@ -240,14 +242,12 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	if (!np)
 		return dev_err_probe(&pdev->dev, -EINVAL, "invalid devicetree node\n");
 
-	vt8500 = devm_kzalloc(&pdev->dev, sizeof(*vt8500), GFP_KERNEL);
-	if (vt8500 == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, VT8500_NR_PWMS, sizeof(*vt8500));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	vt8500 = to_vt8500_chip(chip);
 
-	chip = &vt8500->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &vt8500_pwm_ops;
-	chip->npwm = VT8500_NR_PWMS;
 
 	vt8500->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(vt8500->clk))
-- 
2.43.0


