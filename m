Return-Path: <linux-pwm+bounces-1369-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88D68545B8
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA6C1F2E0AB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687DF1803E;
	Wed, 14 Feb 2024 09:34:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CC168C4
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903275; cv=none; b=AgPGOeKL6DYkiahAVquI9e9EYmsWe9UZt3odtsz5UZ4ukoxni0E+60608loWsFfoiULHIWb2+M6IdEAze7FTtwaDIR+OG8S60o4fmE4FS0Y6d/kpCoI4keUfloQEE0fVszhSYFTdnqe3ZlehZ3sQWMTHHAmFw7xE4QIfxID1i28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903275; c=relaxed/simple;
	bh=YDTFgxPpr51UWO9J5V5J32JzwomS+rPJbEeNSQqkdnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArmNt11beT8vpVeN2p6y+ZEvmYcwi7uhWAfLyz7NI8ksa65IM6sgVRuFJxMnm3c/Kn8bQsx1xC8tjW3KSbkTNcQaUF7irWX1j8p4jhhDP9I6npPX6YFPMOwtmNGNyR1ewarITbcnzS/YZ6woEvZMrm4M3U1cK1O97QrMhyiIzCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBev-0004va-9z; Wed, 14 Feb 2024 10:34:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBet-000fCW-50; Wed, 14 Feb 2024 10:34:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBet-004Y3h-0F;
	Wed, 14 Feb 2024 10:34:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 060/164] pwm: lpc18xx-sct: Drop hardly used member from driver private data
Date: Wed, 14 Feb 2024 10:31:47 +0100
Message-ID:  <427a719a24dd7ff5ebbac3e260a1773c094c7489.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=YDTFgxPpr51UWO9J5V5J32JzwomS+rPJbEeNSQqkdnE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiPAl702P79APm18zuoqL+EetmK4EZ2kLZ4I UtEWnAZ6rGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIjwAKCRCPgPtYfRL+ TiuyCACk2zuyu3mfzN4HOMD+qXLtB9AblHyVUIO7uE7FTxniqdppYLttc/UXaC0fJTNj89LHJ5K IJHEjuOvH0pYJzmWjqdEo3tf+BqwERYKcdPdS3J9nIbsa1DJieB/vkwmEC+92Yj2KHupTHOZG6p Ib4QdS0kxriB1w9vP9dc1L+wR5GccFs2O2PQyZlJVSOCWI71fINw+O9GnUpPigwRIVTGzTaUNkc 0rXlDFhgjBrBDwTgywPTfD414XXut8kbF9ZjPJtgxszOez+0RgVp/ZRazPxIF3KrlPRASt/lUdV glAVqG1sS7qzlKhfXDlx40gATxamc/MfJXDL9gtB4E7eN3Ey
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The device pointer is only used once in lpc18xx_pwm_request(). There the
pwm_chip is available, too, which has a pointer to the same structure.
Replace the usage accordingly and drop the then write-only member
variable.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index fe891fa71a1d..754ea2c3f49b 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -92,7 +92,6 @@ struct lpc18xx_pwm_data {
 };
 
 struct lpc18xx_pwm_chip {
-	struct device *dev;
 	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *pwm_clk;
@@ -289,7 +288,7 @@ static int lpc18xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 				    LPC18XX_PWM_EVENT_MAX);
 
 	if (event >= LPC18XX_PWM_EVENT_MAX) {
-		dev_err(lpc18xx_pwm->dev,
+		dev_err(chip->dev,
 			"maximum number of simultaneous channels reached\n");
 		return -EBUSY;
 	}
@@ -358,8 +357,6 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	if (!lpc18xx_pwm)
 		return -ENOMEM;
 
-	lpc18xx_pwm->dev = &pdev->dev;
-
 	lpc18xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpc18xx_pwm->base))
 		return PTR_ERR(lpc18xx_pwm->base);
-- 
2.43.0


