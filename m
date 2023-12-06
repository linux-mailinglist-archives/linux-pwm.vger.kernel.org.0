Return-Path: <linux-pwm+bounces-314-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD4E806E66
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB304B20E71
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF57347BD;
	Wed,  6 Dec 2023 11:48:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5A7D41
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00062O-0j; Wed, 06 Dec 2023 12:48:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00Dwrx-GX; Wed, 06 Dec 2023 12:48:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00FQx9-7H; Wed, 06 Dec 2023 12:48:22 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 011/115] pwm: bcm-kona: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:25 +0100
Message-ID:  <4808e4301d0967766e4aee8abe2933ca87aff274.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=AMMKgKT/gAi2Kt/43581VruF6VzIssXWvqp0d1kpwpQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5ejgP9Kk/2+tYFPzqv4u2+TwrOFvRObDi98 S0zhvYKRL2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeXgAKCRCPgPtYfRL+ ToqZB/0VamQVgvRX3gbcSKq3KY5xzfrdnnIpmXBdsWLH+iiIC/hN9b9S0SgVzH02NOLMFrwVT8R +GsbsDmwJhsg7y6Sc++7f+niqyYn4/1W2QqjGKW8VaBTDXBtaqZZCZ8GjorwKRc/ByrI23nYidZ oKVmXODukRKcZ6kXjSzyNhnop1sLDQc09Z0oMfJObgDUXgd/ZJTK2Bd9KW9OBuhErY9eX+vf7Gh MFBY2z/szSh2ItCZu+EUt2sa5+QGZV6hgP7VI9QQuveJeE60AkyXxaQ9F6K5wBpdpqkqyyfBcaR dfCemMxoZbaRgNBtvTmB0Eq4o3I0jBLL0XY88LzLmMlBXr7y
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-kona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 45046a5c20a5..47acae8d7478 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -164,7 +164,7 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = clk_prepare_enable(kp->clk);
 	if (ret < 0) {
-		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
+		dev_err(pwmchip_parent(chip), "failed to enable clock: %d\n", ret);
 		return ret;
 	}
 
@@ -193,7 +193,7 @@ static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = clk_prepare_enable(kp->clk);
 	if (ret < 0) {
-		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
+		dev_err(pwmchip_parent(chip), "failed to enable clock: %d\n", ret);
 		return ret;
 	}
 
-- 
2.42.0


