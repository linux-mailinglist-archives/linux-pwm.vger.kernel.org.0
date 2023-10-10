Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D30B7BF4C2
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 09:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442601AbjJJHv0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 03:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442596AbjJJHvV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 03:51:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4446A4
        for <linux-pwm@vger.kernel.org>; Tue, 10 Oct 2023 00:51:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-00085z-95; Tue, 10 Oct 2023 09:51:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WO-000bip-SK; Tue, 10 Oct 2023 09:51:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WO-00Cvmg-JA; Tue, 10 Oct 2023 09:51:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 03/11] pwm: berlin: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Tue, 10 Oct 2023 09:51:04 +0200
Message-Id: <20231010075112.755178-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zfGWpS9oo8nLfPi1jDjeJItP8caIKc4ZsthuOMwv3U8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlRVpviilh3z+GV1a64KNJ0ru7mAVVx67qmTGdOft/ycd 5vlhsjzTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmMimZ/X+51h6Hq9+6xfxe 8Gbc6BDrnLFRt0J4HpdzifVOzwy2q6+vpV+a2rFqCauaGt+0MxqV5mkbzY7ULYz4MbsxqrnwS6K NRvLv4Jz3eiE7Ojjyt+t/nu8QJhx93KZjW5hB9p2r8dLF023ly9e/n8F453nKm7IyoQ8L5E3tcy rKXasitrNyuk/epnnmOYfV2wvsN/8srDA/23n2B0OEoWLqqW1J+m8yb2bLC3/Rv2h070sP68Kjd 90Ly2O37qyYUvD4516H+dLRpboqOY6JEV9++oryPe+UTapgMVkUU6tvUBA884pByG4GGwPpjYHc ud3fU+5vV5Trbri0TbJgSkBIVX8V+7xtBZ82WdupHVgBAA==
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

This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
care about when the functions are actually used, so the corresponding
#ifdef can be dropped.

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-berlin.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 0971c666afd1..feb63ccdace1 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -260,7 +260,6 @@ static void berlin_pwm_remove(struct platform_device *pdev)
 	clk_disable_unprepare(bpc->clk);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int berlin_pwm_suspend(struct device *dev)
 {
 	struct berlin_pwm_chip *bpc = dev_get_drvdata(dev);
@@ -309,10 +308,9 @@ static int berlin_pwm_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(berlin_pwm_pm_ops, berlin_pwm_suspend,
-			 berlin_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(berlin_pwm_pm_ops, berlin_pwm_suspend,
+				berlin_pwm_resume);
 
 static struct platform_driver berlin_pwm_driver = {
 	.probe = berlin_pwm_probe,
@@ -320,7 +318,7 @@ static struct platform_driver berlin_pwm_driver = {
 	.driver = {
 		.name = "berlin-pwm",
 		.of_match_table = berlin_pwm_match,
-		.pm = &berlin_pwm_pm_ops,
+		.pm = pm_ptr(&berlin_pwm_pm_ops),
 	},
 };
 module_platform_driver(berlin_pwm_driver);
-- 
2.40.1

