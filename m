Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A207C72B3
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379580AbjJLQbG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379593AbjJLQa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA90E5
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaN-0004pr-At; Thu, 12 Oct 2023 18:30:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaM-001C6V-MI; Thu, 12 Oct 2023 18:30:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaM-00F5NN-Ct; Thu, 12 Oct 2023 18:30:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 020/109] pwm: mtk-disp: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:48 +0200
Message-ID: <20231012162827.1002444-131-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vXuY2V8WhGS3JT93BuIQZEPRXMh4TZPOCFwd/uY3uho=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7DpmciHYDGaF8RcGwUUJ/u2okGSHJrESNdf BC27Yt35V+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgewwAKCRCPgPtYfRL+ Tk4VB/4zdLWkDOPn9/U0I9PpKjgo6PZ4aEBsBQmkc2f9bumw3qq7t6Byi2jGZzpWwL0e/d49CEI hWO36yIjUAXhoMga3UnYTXndR43/NEKR9J6FUvuJOHmQnduOaZapmxM0VhYuk6k0wo9ECGprCfi zdzbsBhTMuUvbnL29V1SX9a13hgRLJrfsCK2lQwsrROxfSTJHbdBSd0wRiJ8jRhF5ypqrPRSy3A 7fMTlwxzgu+9fYWn9OQraQvzDNaDu/5JopglorRtygnHM7NKFBikJHyr9vb0bOukaldsRBqw2/1 OTY6lu0NYMO8HScBW8hnR0npvurjyORp6JyZPmJ+tO/a90KN
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

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

