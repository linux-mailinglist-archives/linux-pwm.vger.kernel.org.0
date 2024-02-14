Return-Path: <linux-pwm+bounces-1358-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75418545AB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FB0288F54
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027B7168B9;
	Wed, 14 Feb 2024 09:34:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118A18638
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903271; cv=none; b=EF47nSsvPbDRcFKv2iIlOMfBcLxl0PicBCRov/FkvU3AhW7dhQcsWpfS6eXazsoV4+LnAWwOsrDXEtB3CcyqYdvam6E6Zp8PoAzzuQWiaktgLUMPd6FgiMlfD+WWBTisy7o0voulHG0f1Gxs0lfjiEBcnyd+uTUGTkEi60xwSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903271; c=relaxed/simple;
	bh=RuNDzuLdvJRxR0ckpJ+3ys/tCVKtgBXKMYvbIUdoyZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/OeWk0n0c35Q1tIfOJNyfPZOvj8Mf6C92dwvDvXaxyTIOx7jzW69sI77Xvi80ZJr6/UTVlqNaRgdnwHi0EaLFvYi218cEEHubGmIlmx9Q+0pCN7Kp3+qn4Pt3T51UCaz3tWP9B8y6iNKOE3rGXBRstmKw9d4tJlBvNrS6T8Qa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-0004jL-Uu; Wed, 14 Feb 2024 10:34:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-000fBp-Al; Wed, 14 Feb 2024 10:34:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-004Y2v-0m;
	Wed, 14 Feb 2024 10:34:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-pwm@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 048/164] pwm: imx27: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:35 +0100
Message-ID:  <a8e3e3b3ea0684c9b289999c6f09eedbc2520f54.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=RuNDzuLdvJRxR0ckpJ+3ys/tCVKtgBXKMYvbIUdoyZg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiBZ0q35U/jB2Oz5eygTO2iXNMY+QWm/6azQ ShvztQDekKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIgQAKCRCPgPtYfRL+ TjIjCACeZlXTYvp10oOet167MF9Mb7oGaPaSnHl6Xj/Pdp2HT2IrmANnlQNDwI5qE4oYBKa4t/D IRRTLwy0eOOTYsQOfgx9CT9Hx+gRDtjv4fG7yU7sLd8WHoKwFvK0PAxrDwPF86tFnIaJzYvxkVR RJNiQiIvIsScfUSS8phZ3Ff2Lp5DWQnmXdz7DmpfeuxOiQlPmlmT/4NsVIxdR+DIZ/QOQYXyHpB 8q/nXK9wafiZSY2dwgCvg5P2uLXQJPVi/KMY5lrnmr8B0Yw2X1EBdiwF8OZ0Y03RftP18jZE3pB gOcdcsN1ttMUOBuJ2oDkf6IrPLPazZbGa8Ls3w3OZTnFfDqS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the accessor
function provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 7d9bc43f12b0..5d796453519a 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -145,7 +145,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 		state->polarity = PWM_POLARITY_INVERSED;
 		break;
 	default:
-		dev_warn(chip->dev, "can't set polarity, output disconnected");
+		dev_warn(pwmchip_parent(chip), "can't set polarity, output disconnected");
 	}
 
 	prescaler = MX3_PWMCR_PRESCALER_GET(val);
@@ -177,7 +177,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 static void pwm_imx27_sw_reset(struct pwm_chip *chip)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	int wait_count = 0;
 	u32 cr;
 
@@ -196,7 +196,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 				     struct pwm_device *pwm)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	unsigned int period_ms;
 	int fifoav;
 	u32 sr;
-- 
2.43.0


