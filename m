Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582486A9FAE
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCCSzV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCCSzR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827201F486
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYX-0006Jp-Qw; Fri, 03 Mar 2023 19:55:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYX-001cUH-3U; Fri, 03 Mar 2023 19:55:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYW-001ukT-0z; Fri, 03 Mar 2023 19:55:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH 14/30] pwm: lpss-platform: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:29 +0100
Message-Id: <20230303185445.2112695-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=DCfRfCawQ0VrxGHGJvbekjnnbJdDyOLgZDpEoWvn2HM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkIX0QkQbOLDQ/anxPYD26vimf0TyWFuiwlQp 3aFOUzAR0mJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCFwAKCRDB/BR4rcrs CQD1CACYWrD3ftz3vX3rLVZNIOzaeOxXsjR/vD8FW39TC7T7crLHB8eLt9IaEoC6Udeilx6cBJJ 6Vqczu38SyKOgFr72iWSc8240XvYpaK8eAGWwTGRKpPvJuGgIRF1F/Y9kNNY37LRq4XpaQ/8pY9 2VjVyfMZT4D++o4Rs3UJ+AKfRdu7FiYqMhNxG0SmI6sVolPej255wPSxwNLx7KBuwYqNmX+kbwr v/twrHpUhpT7fJ8USQ/rKSBDlFblgMDg8VqhEwdL8qkHBsVsl4+GSvReYeGtm6aGC8Nin2i7z2k XQDZM7wSbXS76Sfmswc6UjV6CnP8v2S28tPFjd3ThdAvzbfu
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpss-platform.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index f350607e28bd..319809aac2c4 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -62,10 +62,9 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 	return 0;
 }
 
-static int pwm_lpss_remove_platform(struct platform_device *pdev)
+static void pwm_lpss_remove_platform(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
@@ -83,7 +82,7 @@ static struct platform_driver pwm_lpss_driver_platform = {
 		.acpi_match_table = pwm_lpss_acpi_match,
 	},
 	.probe = pwm_lpss_probe_platform,
-	.remove = pwm_lpss_remove_platform,
+	.remove_new = pwm_lpss_remove_platform,
 };
 module_platform_driver(pwm_lpss_driver_platform);
 
-- 
2.39.1

