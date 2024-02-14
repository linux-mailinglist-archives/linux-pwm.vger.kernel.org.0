Return-Path: <linux-pwm+bounces-1368-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487378545C2
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4483B226C6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C8416419;
	Wed, 14 Feb 2024 09:34:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B68168A9
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903275; cv=none; b=YjGNz2SRazEMkVtIVLI6ZsPUTtboWWT7eiK6E6PgYWZ31OO+RT+H2Cyq6rlSgWiHh7EcKLxMfgpnlu1UdT2GgAoLO6VuVcdzX/k22eFEPHWFdpw47HXjxZKlpBqBQSb8LRhm12R6DZuzkFVx5cHWN0CYw1NDfh03OWkrdci6xGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903275; c=relaxed/simple;
	bh=u5R3Ra7KCyLP1nvm327Vj4y7z15C1PMVhnhgLe4+nlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiFj7oHyudgQ8isJDg4hnZXFcZoXwWWxG8ubdEqw7dJuNduvBshwK+PR3y15bhx8w+7zM4KZ2/asTsivg+BzN+PKuTQXRiYQ7UDaACUTvU5ELx/PfsveROcvMXsOormA4caugcqTjUaB6CNBPu4PBgEQnZF8tZ1btaDzZIw02RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-0004up-Jr; Wed, 14 Feb 2024 10:34:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-000fCS-WA; Wed, 14 Feb 2024 10:34:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-004Y3d-2z;
	Wed, 14 Feb 2024 10:34:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 059/164] pwm: lp3943: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:46 +0100
Message-ID:  <44a2d303bb511e49c6db8aaedd17986c3aedde44.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=u5R3Ra7KCyLP1nvm327Vj4y7z15C1PMVhnhgLe4+nlA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiO5oahUteuAN9PhUuu3pQsLQX0hSx4Q9x2i tuin95z7a6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIjgAKCRCPgPtYfRL+ TiahCACP8dEYAC+esHec4PzsfmGG98EVmntJaV0qT+M3u4Xc/KLLMVuWfeTLOiVU0xG34z06EHn N+G7o/7Aml99Qb2SQXp3ezt4O1CjZC8fJKYM2E202zXHBuWCM7GLp//lm+8+TFOqlKtCB/n2q8O 7YMAi+pbvB6jWzAuefPjbtd7FEfyMEcyNymEzIH/EEl5n3rh7lloFKFXf/7m6ojNmiuf8oRLzGj vEzhXphRs3yYaoDVG59zMUoKDWcEth6yKI8bQT5vRRNQwzMj1qLcQCH2/+Z+uC1Txa/FoJJglNm wA6hbLPpo+8IHKlZPNZ/SPRVzPiMbPGMpBgxEVG+61m1KRvh
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-lp3943 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lp3943.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 32350a357278..61189cea1046 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -20,7 +20,6 @@
 #define LP3943_MAX_PERIOD		1600000
 
 struct lp3943_pwm {
-	struct pwm_chip chip;
 	struct lp3943 *lp3943;
 	struct lp3943_platform_data *pdata;
 	struct lp3943_pwm_map pwm_map[LP3943_NUM_PWMS];
@@ -28,7 +27,7 @@ struct lp3943_pwm {
 
 static inline struct lp3943_pwm *to_lp3943_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lp3943_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static struct lp3943_pwm_map *
@@ -273,12 +272,14 @@ static int lp3943_pwm_parse_dt(struct device *dev,
 static int lp3943_pwm_probe(struct platform_device *pdev)
 {
 	struct lp3943 *lp3943 = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct lp3943_pwm *lp3943_pwm;
 	int ret;
 
-	lp3943_pwm = devm_kzalloc(&pdev->dev, sizeof(*lp3943_pwm), GFP_KERNEL);
-	if (!lp3943_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, LP3943_NUM_PWMS, sizeof(*lp3943_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	lp3943_pwm = to_lp3943_pwm(chip);
 
 	lp3943_pwm->pdata = lp3943->pdata;
 	if (!lp3943_pwm->pdata) {
@@ -292,11 +293,9 @@ static int lp3943_pwm_probe(struct platform_device *pdev)
 	}
 
 	lp3943_pwm->lp3943 = lp3943;
-	lp3943_pwm->chip.dev = &pdev->dev;
-	lp3943_pwm->chip.ops = &lp3943_pwm_ops;
-	lp3943_pwm->chip.npwm = LP3943_NUM_PWMS;
+	chip->ops = &lp3943_pwm_ops;
 
-	return devm_pwmchip_add(&pdev->dev, &lp3943_pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 #ifdef CONFIG_OF
-- 
2.43.0


