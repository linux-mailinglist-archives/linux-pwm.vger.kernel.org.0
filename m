Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D530536A8D1
	for <lists+linux-pwm@lfdr.de>; Sun, 25 Apr 2021 20:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhDYSYw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 25 Apr 2021 14:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhDYSXx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 25 Apr 2021 14:23:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA0AC061574
        for <linux-pwm@vger.kernel.org>; Sun, 25 Apr 2021 11:23:12 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lajPS-0002S2-4f; Sun, 25 Apr 2021 20:23:10 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lajPR-0008Go-6E; Sun, 25 Apr 2021 20:23:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] pwm: pwx: Drop if with an always false condition
Date:   Sun, 25 Apr 2021 20:22:59 +0200
Message-Id: <20210425182300.2807668-1-u.kleine-koenig@pengutronix.de>
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

base-commit: 30d0031bd7cab931589e023149afc77739a4b175
-- 
2.30.2

