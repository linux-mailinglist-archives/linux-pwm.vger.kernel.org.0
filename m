Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71347543FF
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jul 2023 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjGNU4h (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jul 2023 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjGNU4f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jul 2023 16:56:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F066A2690
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jul 2023 13:56:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq5-00084K-A7; Fri, 14 Jul 2023 22:56:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq4-00EQSU-LV; Fri, 14 Jul 2023 22:56:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq3-004u3w-QK; Fri, 14 Jul 2023 22:56:31 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 04/10] pwm: crc: Consistenly name pwm_chip variables "chip"
Date:   Fri, 14 Jul 2023 22:56:17 +0200
Message-Id: <20230714205623.2496590-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=DGpagzOQQWScVSMO2FdGrPGN0r3oXGpCrthVu6NG7Jg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBksbZrnDfEZdoR8Jrb3nlwnC5fS1ZGuCo5CDNF7 Irb3v+YECKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLG2awAKCRCPgPtYfRL+ TnHqB/9g+rOWCGctg4MbC7ylrd6oTb98Vv51bkRiEhM4je9shI8sWpF+z9LBzMzaTQoKcWbeQ+o 3Wh+Fto9KzLsYNOI26gpj6VQl6h0woCjiekX/yRGFCo4xiI9oqgi/En9ZrFWP8OJsqpJvvDvH+T dOKkoUlXsiVbvwlsEwYuKnCxW2TqgxXF8lLUGX/rZFAtNFECbpNzTHNgKkyItGN31OeuDsfCoi4 q7TOILNNp1qOPMeAcKA3j5c8cZVdfMyAq/8CS42Vn8W1nxDw745bLCcDq00UtTN4MPsTCGVIZrI +xkR96Xb+HMc1v3A9fyup0AgTOkC9mCSreIQveoOMYDAXrDO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Most variables holding a pointer to a pwm_chip are called "chip" which
is also the usual name in most other pwm drivers. Rename the single
variable that have a different name to be called "chip", too, for
consistency.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 4703b4a0b6e4..b9f063dc6b5f 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -34,9 +34,9 @@ struct crystalcove_pwm {
 	struct regmap *regmap;
 };
 
-static inline struct crystalcove_pwm *to_crc_pwm(struct pwm_chip *pc)
+static inline struct crystalcove_pwm *to_crc_pwm(struct pwm_chip *chip)
 {
-	return container_of(pc, struct crystalcove_pwm, chip);
+	return container_of(chip, struct crystalcove_pwm, chip);
 }
 
 static int crc_pwm_calc_clk_div(int period_ns)
-- 
2.39.2

