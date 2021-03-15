Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C05133B0BC
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Mar 2021 12:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhCOLLx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Mar 2021 07:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhCOLL2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Mar 2021 07:11:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ABCC06175F
        for <linux-pwm@vger.kernel.org>; Mon, 15 Mar 2021 04:11:28 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lLl8A-0006Xu-7g; Mon, 15 Mar 2021 12:11:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lLl89-000338-L7; Mon, 15 Mar 2021 12:11:25 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/4] pwm: Make of_pwm_xlate_with_flags() work with #pwm-cells = <2>
Date:   Mon, 15 Mar 2021 12:11:21 +0100
Message-Id: <20210315111124.2475274-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
References: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index b1adf3bb8508..39b0ad506bdd 100644
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
@@ -144,7 +143,8 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 	pwm->args.period = args->args[1];
 	pwm->args.polarity = PWM_POLARITY_NORMAL;
 
-	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
+	if (pc->of_pwm_n_cells >= 3 && args->args_count > 2 &&
+	    args->args[2] & PWM_POLARITY_INVERTED)
 		pwm->args.polarity = PWM_POLARITY_INVERSED;
 
 	return pwm;
-- 
2.30.1

