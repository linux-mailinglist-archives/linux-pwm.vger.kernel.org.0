Return-Path: <linux-pwm+bounces-977-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A620783C1CF
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EA31F230FB
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184C44502A;
	Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945E36122
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184653; cv=none; b=aIIogvpjFc0i9Ylv5eRNYqQenZq0ytMupQeFIOaud+QPgAvq5PEmsHeBUMCVooWGLdn6wxMyzDpNugAsHdFt4UMcs9NiJgLXBPtpFGFgZWezDsH1u7TiNNEnyH3szEcKuuqL5Yrf/k74b1qG8SlMu5LvsUSv0Keyy+ZKIGzhCYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184653; c=relaxed/simple;
	bh=R0A2TBkigVAXX6l0bS4SRqsBBfHioDPkY0cSpEpNdDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwtrN2Y138sFDwN9s7aC7oqaurYdoROEN9lT9ImL24VNlZB31c8cKv5bi2QJQIOwgN+mf4Gk9tjeOYH/LRCosrBVjwDp+sC6XgcRS2ZMTPjYknwwM4xE+eXOGURUXdqGvrWuY5Nq+XOFWPebOsp5/TwUUqd2jaM2KkYxk/bu7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZF-00049x-DM; Thu, 25 Jan 2024 13:10:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZE-002HRJ-7E; Thu, 25 Jan 2024 13:10:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZE-007n0t-0S;
	Thu, 25 Jan 2024 13:10:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 041/111] pwm: ab8500: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:03 +0100
Message-ID:  <4e50d440963cf53c62eedf3567ff6eb847ecac1c.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=R0A2TBkigVAXX6l0bS4SRqsBBfHioDPkY0cSpEpNdDM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9p9gMmPtPDY6XeQF+l06zmsWbexCR8wzGGe Thfnn1UeWCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPaQAKCRCPgPtYfRL+ ThLlB/9zuTk/m1sEHPadbtA27dD3WZNfUklRIE6lZvotKyXHROTNoTJlUfWaC/41GopejCrt+Ik vWO3Qtrkep2hUN+fklDB3eEhg6084VTbhn7djJKEKYFiPmsh0hFg35QbpqNnJXEzJOZkLXzxkWZ V6WTnRDdMC3VqcXwyOmQD3zXJticzbukT/3B1E5I97GIlIWAKXdms1DGmJMr4jibcUWbSePNqn3 UJ6FOYTBt5vljCJfrHQG4KS11l4LnwYufkzWMPWMaHAFCeSR6cSrjDYz5w/ratOnvRSprnFCi55 T+roBmvavUbDlHkSfDRucq33ft5KEGfg4aotCUsxSXgsu03i
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-ab8500 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 719e4ccf1800..f000adab85b0 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -24,13 +24,12 @@
 #define AB8500_PWM_CLKRATE 9600000
 
 struct ab8500_pwm_chip {
-	struct pwm_chip chip;
 	unsigned int hwid;
 };
 
 static struct ab8500_pwm_chip *ab8500_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ab8500_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -185,6 +184,7 @@ static const struct pwm_ops ab8500_pwm_ops = {
 
 static int ab8500_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct ab8500_pwm_chip *ab8500;
 	int err;
 
@@ -195,16 +195,16 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	 * Nothing to be done in probe, this is required to get the
 	 * device which is required for ab8500 read and write
 	 */
-	ab8500 = devm_kzalloc(&pdev->dev, sizeof(*ab8500), GFP_KERNEL);
-	if (ab8500 == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*ab8500));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
-	ab8500->chip.dev = &pdev->dev;
-	ab8500->chip.ops = &ab8500_pwm_ops;
-	ab8500->chip.npwm = 1;
+	ab8500 = ab8500_pwm_from_chip(chip);
+
+	chip->ops = &ab8500_pwm_ops;
 	ab8500->hwid = pdev->id - 1;
 
-	err = devm_pwmchip_add(&pdev->dev, &ab8500->chip);
+	err = devm_pwmchip_add(&pdev->dev, chip);
 	if (err < 0)
 		return dev_err_probe(&pdev->dev, err, "Failed to add pwm chip\n");
 
-- 
2.43.0


