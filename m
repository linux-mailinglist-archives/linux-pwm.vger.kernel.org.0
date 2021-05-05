Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB238373F6F
	for <lists+linux-pwm@lfdr.de>; Wed,  5 May 2021 18:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhEEQUL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 May 2021 12:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbhEEQUK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 May 2021 12:20:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88477C061574
        for <linux-pwm@vger.kernel.org>; Wed,  5 May 2021 09:19:13 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1leKEx-0001D6-Fh; Wed, 05 May 2021 18:19:11 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1leKEw-0000s3-Fm; Wed, 05 May 2021 18:19:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 1/2] pwm: pxa: Drop if with an always false condition
Date:   Wed,  5 May 2021 18:19:08 +0200
Message-Id: <20210505161909.187452-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

The .remove() function is only called after .probe() returned
successfully. In this case platform_set_drvdata() was called with a
non-NULL argument and so platfrom_get_drvdata() returns the same
non-NULL value.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

only change since implicit v1: s/pwx/pxa/ in the Subject. Patch 2 is
unmodified.

Best regards
Uwe

 drivers/pwm/pwm-pxa.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index cfb683827d32..31752640dcf7 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -210,8 +210,6 @@ static int pwm_remove(struct platform_device *pdev)
 	struct pxa_pwm_chip *chip;
 
 	chip = platform_get_drvdata(pdev);
-	if (chip == NULL)
-		return -ENODEV;
 
 	return pwmchip_remove(&chip->chip);
 }

base-commit: a6efb35019d00f483a0e5f188747723371d659fe
-- 
2.30.2

