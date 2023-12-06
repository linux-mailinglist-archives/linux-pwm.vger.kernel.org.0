Return-Path: <linux-pwm+bounces-320-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BD7806E62
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBB21F215D4
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C8D34CDE;
	Wed,  6 Dec 2023 11:48:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E3ED4F
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO8-0006Ep-TL; Wed, 06 Dec 2023 12:48:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO8-00Dwsh-9C; Wed, 06 Dec 2023 12:48:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO8-00FQxr-0A; Wed, 06 Dec 2023 12:48:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 022/115] pwm: mediatek: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:36 +0100
Message-ID:  <028a566d671a9ef14ed8e79818bfd05b19a234cf.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=rTrJ+ySN/1myKTD4cdzDIS35z0aynWVLqSK1aIKD+6g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF51kfFJCnd66iQB3eAzapZvNuVGMkc8+JQFu 1+46KlAhPqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBedQAKCRCPgPtYfRL+ TgByB/wLeINwa1gPhUVtrcZ8wpIk0rHsuQflG6dGClx0sIlx/gtpew1ubrDrpboLyXc7Tsct5BE E7hKMr8bn9r4+Sje5ONHcUoAq+FFOJpg7LB+37XtB3997I7NcceobiUlbINRllTCZ3Wf6b9gX5K AzuRsS4fatLICal2o3YT5n1ZXUTBs7yiwFskmL4WqP3qIfQ0Q6UnpLUQ6HRgmgnH8Mwk4bFELgP W9BaZ2AIj6o2CZEPIS5cvPk+ID7WSd47MNX39tk4pCx0ohZNqH34TWuV/mmfT4cnl9U7TVhK27G uCk8myQ9S1Qs4mPQooqa93qFxkK5wsXM/UmlmKe3ENV59zKW
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
 drivers/pwm/pwm-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 17d290f847af..d7d1c326e8cf 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -150,7 +150,7 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
 		pwm_mediatek_clk_disable(chip, pwm);
-		dev_err(chip->dev, "period of %d ns not supported\n", period_ns);
+		dev_err(pwmchip_parent(chip), "period of %d ns not supported\n", period_ns);
 		return -EINVAL;
 	}
 
-- 
2.42.0


