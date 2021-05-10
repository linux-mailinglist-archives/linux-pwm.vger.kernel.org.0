Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84EB379143
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 16:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhEJOuD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbhEJOsv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 10:48:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FE5C06138D
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 07:06:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg6YU-0006xB-R3; Mon, 10 May 2021 16:06:42 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg6YU-0001sk-Ef; Mon, 10 May 2021 16:06:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 1/4] pwm: Make of_pwm_xlate_with_flags() work with #pwm-cells = <2>
Date:   Mon, 10 May 2021 16:06:37 +0200
Message-Id: <20210510140640.980100-2-u.kleine-koenig@pengutronix.de>
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

The two functions of_pwm_simple_xlate() and of_pwm_xlate_with_flags() are
quite similar. of_pwm_simple_xlate() only supports two pwm-cells while
of_pwm_xlate_with_flags() only support >= 3 pwm-cells. The latter can
easily be modified to behave identically to of_pwm_simple_xlate for two
pwm-cells. This is implemented here and allows to drop
of_pwm_simple_xlate() in the next commit.

There is a small detail that is different now between of_pwm_simple_xlate()
and of_pwm_xlate_with_flags() with pwm-cells = <2>: pwm->args.polarity is
unconditionally initialized to PWM_POLARITY_NORMAL in the latter. I didn't
find a case where this matters and doing that explicitly is the more
robust approach.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c4d5c0667137..c0cfed992ba4 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -126,8 +126,7 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
-	/* check, whether the driver supports a third cell for flags */
-	if (pc->of_pwm_n_cells < 3)
+	if (pc->of_pwm_n_cells < 2)
 		return ERR_PTR(-EINVAL);
 
 	/* flags in the third cell are optional */
@@ -144,8 +143,11 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 	pwm->args.period = args->args[1];
 	pwm->args.polarity = PWM_POLARITY_NORMAL;
 
-	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity = PWM_POLARITY_INVERSED;
+	if (pc->of_pwm_n_cells >= 3) {
+	       if (args->args_count > 2 &&
+		   args->args[2] & PWM_POLARITY_INVERTED)
+		       pwm->args.polarity = PWM_POLARITY_INVERSED;
+	}
 
 	return pwm;
 }
-- 
2.30.2

