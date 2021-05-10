Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5957379142
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 16:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbhEJOuE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 10:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbhEJOsv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 10:48:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B0CC06138C
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 07:06:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg6YU-0006xC-Vg; Mon, 10 May 2021 16:06:42 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg6YU-0001sn-L2; Mon, 10 May 2021 16:06:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 2/4] pwm: Drop of_pwm_simple_xlate() in favour of of_pwm_xlate_with_flags()
Date:   Mon, 10 May 2021 16:06:38 +0200
Message-Id: <20210510140640.980100-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510140640.980100-1-u.kleine-koenig@pengutronix.de>
References: <20210510140640.980100-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the previous commit the latter function can do everything that the
former does. So simplify accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c0cfed992ba4..9eb7ab19dbfb 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -153,38 +153,13 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 }
 EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
 
-static struct pwm_device *
-of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
-{
-	struct pwm_device *pwm;
-
-	/* sanity check driver support */
-	if (pc->of_pwm_n_cells < 2)
-		return ERR_PTR(-EINVAL);
-
-	/* all cells are required */
-	if (args->args_count != pc->of_pwm_n_cells)
-		return ERR_PTR(-EINVAL);
-
-	if (args->args[0] >= pc->npwm)
-		return ERR_PTR(-EINVAL);
-
-	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
-	if (IS_ERR(pwm))
-		return pwm;
-
-	pwm->args.period = args->args[1];
-
-	return pwm;
-}
-
 static void of_pwmchip_add(struct pwm_chip *chip)
 {
 	if (!chip->dev || !chip->dev->of_node)
 		return;
 
 	if (!chip->of_xlate) {
-		chip->of_xlate = of_pwm_simple_xlate;
+		chip->of_xlate = of_pwm_xlate_with_flags;
 		chip->of_pwm_n_cells = 2;
 	}
 
-- 
2.30.2

