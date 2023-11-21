Return-Path: <linux-pwm+bounces-37-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7952E7F2F74
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F179B21286
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453FD537FA;
	Tue, 21 Nov 2023 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D8BD6A
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAN-0005NP-99; Tue, 21 Nov 2023 14:51:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-00AayH-RO; Tue, 21 Nov 2023 14:51:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-004xcc-II; Tue, 21 Nov 2023 14:51:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v3 030/108] pwm: sun4i: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:32 +0100
Message-ID: <20231121134901.208535-31-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=HIZLcG7Ck3uCiidtWYoYqHxm8CIohmV/VYBLbN2MIts=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVuyiiNmFtagV2g0fYhFlWynZouKX4MBIGgM sZcuTgldECJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1bgAKCRCPgPtYfRL+ TizyB/41CLuE2bjDxJ7eCj2PXqDk1/R2wjA6zCvT9/9xhD3hmkrUbYoJCPj0ZMGQ273f5E5Wg3U jQVGzGHMyMRT0iUYhRgarUKyFWzK2F8ibEg8h4ud8BX9DfW1io5XuybmOsX7ALLxDwA96E8x3+T nwiQXGAmSDZB5yetz29+BjXFb3HFGi04bazPWiwJibsAILtACz4xqdHdrvMwGaJJPpsegqfkVDq VQC7RdqF87F3eCvJmNepL2bTNdgEHjyzC3VEfJlwu7yWrWkk7DRQ/+HE2Jd0UeMa7kmQOsIiGxj pIasQ+8/T5+nziD3JbsZQhZgBX2TY7N63Edv9jIhBZms9+8O
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
 drivers/pwm/pwm-sun4i.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1a439025540d..44edf1ce5739 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -245,7 +245,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!cstate.enabled) {
 		ret = clk_prepare_enable(sun4i_pwm->clk);
 		if (ret) {
-			dev_err(chip->dev, "failed to enable PWM clock\n");
+			dev_err(pwmchip_parent(chip), "failed to enable PWM clock\n");
 			return ret;
 		}
 	}
@@ -253,7 +253,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
 				  &bypass);
 	if (ret) {
-		dev_err(chip->dev, "period exceeds the maximum value\n");
+		dev_err(pwmchip_parent(chip), "period exceeds the maximum value\n");
 		if (!cstate.enabled)
 			clk_disable_unprepare(sun4i_pwm->clk);
 		return ret;
-- 
2.42.0


