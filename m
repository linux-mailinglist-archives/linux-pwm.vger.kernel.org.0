Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F42D6A9FC8
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjCCSzg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjCCSzY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8361C1688A
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYb-0006S0-My; Fri, 03 Mar 2023 19:55:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYa-001cVN-Bi; Fri, 03 Mar 2023 19:55:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-001ulC-8c; Fri, 03 Mar 2023 19:55:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 25/30] pwm: sun4i: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:40 +0100
Message-Id: <20230303185445.2112695-26-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qqKB30Zb0u7qkvQv7CPbZjgQNVuPqS9v4ZHSDKwKl6U=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkJaITp/oGccaWB7RDe+TbEFJgKhWLTAoy/MQ rqU9h801NmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCWgAKCRDB/BR4rcrs CQ2eB/0YJfejFWqfZ5CAt+9BRP0Rxjd8q1av3ex63FaJ1+nRuD9Gb1aV6/csWAhs9POqRy+t/bt RJY9JM5z+r5xYN9DokNNs0a24Kx6sJrBIeZQSMgA30zp4Z/IapsX8cCXrqM8Q8lfZ68zzG5q9h3 jmhY6ueFeTOOcYDKvYojBsY1h3X9WXUmcoSAAh/A4AdU/Nxt2ikAveQHUzak8TZbTYGyhoNTQNH AmIMp1mltxbmlKdrHt/wcOS9f532Ibp7je/bUsvVLgmgeMXI5b8HbW1DD+4iheNevk/vBXwdxHx s/BbqBWCRbBy0D99+4SjB2+h+D7giiyuYpATkcbCMoNBZW9y
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
 drivers/pwm/pwm-sun4i.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index b973da73e9ab..a8790a8fc53e 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -477,7 +477,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sun4i_pwm_remove(struct platform_device *pdev)
+static void sun4i_pwm_remove(struct platform_device *pdev)
 {
 	struct sun4i_pwm_chip *sun4ichip = platform_get_drvdata(pdev);
 
@@ -485,8 +485,6 @@ static int sun4i_pwm_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(sun4ichip->bus_clk);
 	reset_control_assert(sun4ichip->rst);
-
-	return 0;
 }
 
 static struct platform_driver sun4i_pwm_driver = {
@@ -495,7 +493,7 @@ static struct platform_driver sun4i_pwm_driver = {
 		.of_match_table = sun4i_pwm_dt_ids,
 	},
 	.probe = sun4i_pwm_probe,
-	.remove = sun4i_pwm_remove,
+	.remove_new = sun4i_pwm_remove,
 };
 module_platform_driver(sun4i_pwm_driver);
 
-- 
2.39.1

