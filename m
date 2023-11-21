Return-Path: <linux-pwm+bounces-17-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126537F2F59
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DF91C214EC
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F9C53803;
	Tue, 21 Nov 2023 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F5E10CB
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAL-00058V-FS; Tue, 21 Nov 2023 14:51:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAK-00AaxR-AD; Tue, 21 Nov 2023 14:51:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAK-004xbn-1B; Tue, 21 Nov 2023 14:51:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 017/108] pwm: mediatek: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:19 +0100
Message-ID: <20231121134901.208535-18-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=a0fld00DRbtpE+nAzc/C3ZVKGGdC7FMFewgxDZIK3tc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVg1QGhvji5+mYsaa+K87P5xVkOiCQ4hhY2w zOMCWiKs86JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1YAAKCRCPgPtYfRL+ TuefCACbZ8S7n0hsBaWKcAEkEtJqFkrjeqBLDHJ8PVrfwkrjKZocxqVUXrY0KCxuHfgnID5Gx5b ak8y+xDjEO7LNH+tWzRf9+taM42tbuNPwLCcU6WfG3G6PNdNbd2rhghGZB51QD6ydyqRGFNOBMn ZSN+c4R1+KzSlSADTDcj02zMW8YBGf5WtrDp1Kyhjht6nEe7KFUnB3LgilR5cRO4rIwuSwIKSYI pNddcY0q5AjobH649pDPwHcUizCyp0eq5PeGl07e8sXBHaYYfN/voCKut++eE/Mx+hiNQxKYogk JrQvv5sN//13a1xesG3rQ8izSbYG4IzvqYdOoUkBOQ0a7X71
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
index 373abfd25acb..ba76d9753f1b 100644
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


