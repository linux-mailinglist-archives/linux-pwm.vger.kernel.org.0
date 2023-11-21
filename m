Return-Path: <linux-pwm+bounces-19-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C697F2F5D
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1611C217E9
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9854F80;
	Tue, 21 Nov 2023 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5D10DD
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAL-0005B4-Mk; Tue, 21 Nov 2023 14:51:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAK-00AaxY-Oj; Tue, 21 Nov 2023 14:51:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAK-004xbv-FS; Tue, 21 Nov 2023 14:51:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 019/108] pwm: mtk-disp: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:21 +0100
Message-ID: <20231121134901.208535-20-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vXuY2V8WhGS3JT93BuIQZEPRXMh4TZPOCFwd/uY3uho=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVipmciHYDGaF8RcGwUUJ/u2okGSHJrESNdf BC27Yt35V+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1YgAKCRCPgPtYfRL+ TosSB/9yc8dWIzHhCey4fNCL41mB52wWSK74QHEibGPuMw/8T9d0c6U7MXQQrtK+VGk5rkyRyAw JeClOZoNpQj4GllXiNQjSFMWDxKWU/Oh2lHfPkdn7JFJnO/2a716tJBeEf1FuSDycAJFF52QrmZ mjK0LrT/mNYYBXnCRDLrecIilFR0P/eSc02ag0tEhrwOzPrfmCifvEpkADtVn5hruYAiJH1hzr6 g9d10tnAAiVogf0SY2uHgzeNGUDmKebmDr4YLX178bcaytyuWKob26pF9wdYT+pi+tnVVRIrC+7 scHneEE+GihLtXD57sy2x4MiP0r5K2NSdq5BjylKvZTvpbec
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


