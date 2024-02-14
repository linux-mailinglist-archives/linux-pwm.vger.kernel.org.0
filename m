Return-Path: <linux-pwm+bounces-1393-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7228545D3
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59311F2E0F8
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068F17C6D;
	Wed, 14 Feb 2024 09:34:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBCF1865A
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903281; cv=none; b=mcyWmwiISSIq3Ce9aHF1lKVI7On2UnC5orf6Gfm2IDzA1GGcR+inwBpn99/pHy09AIUvK0jRKDolgaGK86uyCNGf46Oq42MnkZR1v//cqS/QofhgFbQ2K+KP3X8zVMafFKeqNgc4joGY/26Xv5vXW5ByQ/ylUF05ys7RSENs03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903281; c=relaxed/simple;
	bh=4P3TlvIe/L1BKUKq76/SkdYyiuy7//Cg55EQQXgJBtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMjlJzuFAoJYylVKLv1Tkh4vXyOklDikXsaeKH0v32JOd75D1g1ena05c+Z5o/+cE0/CKpIP2LHLxSMk3liXJLq0ijZJhCQb8YBOXVLO8kFdYCqh4ewgi4ZupofArg78SBCSm8zd/GbMnI/H0RcKy5u+nfdKLpzKJl9XuiICZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-0005CK-8S; Wed, 14 Feb 2024 10:34:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBev-000fDW-TV; Wed, 14 Feb 2024 10:34:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBev-004Y4x-2i;
	Wed, 14 Feb 2024 10:34:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 077/164] pwm: ntxec: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:04 +0100
Message-ID:  <c0c9d6cb3a6662268e660f4f6c89b32268ecf019.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=4P3TlvIe/L1BKUKq76/SkdYyiuy7//Cg55EQQXgJBtQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIijBWA/DsnikPqJSdWLwbQFF59n7KU2gmPg/ 74/Efv+WkKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIowAKCRCPgPtYfRL+ Tg49CACGqVqmhKiU3nsAqqA2eW0kJv/5NiMFp7WWKnK7z1CLTAwcqFL3df4iLIMt6eCtyb1yrl+ QKcL98o0p9t0aT78VAZDLH+I76FQCg/cbIVlQU2A+zwLCXr5C8Tm1Hj/dGy/n4WFKryEJSoKqnd juQT8T+T4RZACl6LOiDtO9nupCxrtefBoo93zdmPqRw0mLw3ws+iBU2nFQDl4dBZ6zMdeUBHM5d 6JUh+FbYB6fsHl+x4TlJM4o0PD/Dpp3T4K7ro47LdcyK277MiYbh1QT7F6jvpv4ywoOmxiSY7LI GsHIKdKplXKkKlxKxBJzOM6szSBcOOGA+HsJ7iZPY6+ZNRVf
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-ntxec driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ntxec.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ntxec.c b/drivers/pwm/pwm-ntxec.c
index 78606039eda2..28d1c2e5a98f 100644
--- a/drivers/pwm/pwm-ntxec.c
+++ b/drivers/pwm/pwm-ntxec.c
@@ -25,12 +25,11 @@
 
 struct ntxec_pwm {
 	struct ntxec *ec;
-	struct pwm_chip chip;
 };
 
 static struct ntxec_pwm *ntxec_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ntxec_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 #define NTXEC_REG_AUTO_OFF_HI	0xa1
@@ -141,16 +140,13 @@ static int ntxec_pwm_probe(struct platform_device *pdev)
 
 	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = ntxec_pwm_from_chip(chip);
 
 	priv->ec = ec;
-
-	chip = &priv->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &ntxec_pwm_ops;
-	chip->npwm = 1;
 
 	return devm_pwmchip_add(&pdev->dev, chip);
 }
-- 
2.43.0


