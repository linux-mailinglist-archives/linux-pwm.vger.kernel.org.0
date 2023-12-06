Return-Path: <linux-pwm+bounces-323-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0D806E70
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3626B20E00
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADCA34CFC;
	Wed,  6 Dec 2023 11:48:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7463BD53
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO9-0006GW-90; Wed, 06 Dec 2023 12:48:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO8-00Dwsq-J2; Wed, 06 Dec 2023 12:48:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO8-00FQxz-A6; Wed, 06 Dec 2023 12:48:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 024/115] pwm: mtk-disp: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:38 +0100
Message-ID:  <93ee3518cd35dd9ec88b83b9657c9857e7be58e3.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=vXuY2V8WhGS3JT93BuIQZEPRXMh4TZPOCFwd/uY3uho=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF58mdlTqGe/5tEN+95CriSc4xxiMsWOGLVtc 9feixsE7E6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBefAAKCRCPgPtYfRL+ TpFZCAC4QtiSBvKJjI0hvUgSNMcdzTy2tDb5uIvhxo4XOk2P/eTuYw/U+aEJ2FOPQHJov/OuXsz xUy6ZyeWBaqIPm7hRLBP04NfYYHgJiMT4tJDoJejISfNNXPZL0ETUWgxSu+BgknrCxHwPzPZ8N5 4qmzzO/jy7CnsavXOW1/KZRAQrwO52VT1cY6bZdPuAXc0kWetvSrhXS01OFxiA8f/LB3nfwD8N9 8LAU9or4c5XArj1tAzzBpYIpqdK8uL7dYIxYzohAMta29ick0wu/cBNUba2BH3wkloqFX8ZYp7I a3RhldNpNw8U76romVxIrq+rft1pUY+QgoajqgFws0u/bTHL
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
 drivers/pwm/pwm-mtk-disp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index a72f7be36996..186aa5c04435 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -91,14 +91,14 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!mdp->enabled) {
 		err = clk_prepare_enable(mdp->clk_main);
 		if (err < 0) {
-			dev_err(chip->dev, "Can't enable mdp->clk_main: %pe\n",
+			dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_main: %pe\n",
 				ERR_PTR(err));
 			return err;
 		}
 
 		err = clk_prepare_enable(mdp->clk_mm);
 		if (err < 0) {
-			dev_err(chip->dev, "Can't enable mdp->clk_mm: %pe\n",
+			dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_mm: %pe\n",
 				ERR_PTR(err));
 			clk_disable_unprepare(mdp->clk_main);
 			return err;
@@ -181,13 +181,13 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
 
 	err = clk_prepare_enable(mdp->clk_main);
 	if (err < 0) {
-		dev_err(chip->dev, "Can't enable mdp->clk_main: %pe\n", ERR_PTR(err));
+		dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_main: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
 	err = clk_prepare_enable(mdp->clk_mm);
 	if (err < 0) {
-		dev_err(chip->dev, "Can't enable mdp->clk_mm: %pe\n", ERR_PTR(err));
+		dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_mm: %pe\n", ERR_PTR(err));
 		clk_disable_unprepare(mdp->clk_main);
 		return err;
 	}
-- 
2.42.0


