Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3B060243A
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Oct 2022 08:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJRGRk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Oct 2022 02:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJRGRj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Oct 2022 02:17:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085D8A50D1
        for <linux-pwm@vger.kernel.org>; Mon, 17 Oct 2022 23:17:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1okfux-000501-SZ; Tue, 18 Oct 2022 08:17:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1okfuw-002DxI-Ji; Tue, 18 Oct 2022 08:17:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1okfuv-008jlz-Oo; Tue, 18 Oct 2022 08:17:33 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: sifive: Call pwm_sifive_update_clock() while mutex is held
Date:   Tue, 18 Oct 2022 08:16:56 +0200
Message-Id: <20221018061656.1428111-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=EqhtnN4dhUSa5vE1/ENmddEpyj5PwBBNDxq6u1T2qY8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjTkTUKcWLu0bcmdBRlxryTFBYd1aA916fGqsRTbNy Cp84lhaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY05E1AAKCRDB/BR4rcrsCcjCB/ 4/JTx9RJn9p/wFmzNtdirOAu02U7a9/iaU7Nzsx0pOS2IOpnUl16uQIKYNIg5jjm79kE1r7Xt75BK6 bbalVJIJalrs3N8SRG9J/RhYZGTbfgprxO4bK8T0ARFRFNOHwZkcSgUhlWj3eOqWvpgObOuQSHQXWr ww+30C34GxsmtWTnHQnQzB9BvakH5oAkDn1G8dafkSS4rQpQB5S+WW26doVV0xds+c+WBh+Mhi1Hpz R7SxROo2bhL9vARWxacZzKlfV2M4m5Ow81u/PKxhXeHPHXD/EGGCOs0SfSFQyJS8PPhBiqGT5LP9xK j5nvCLxbCm0+26O8S0jzDF6GzHo8/f
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

As was documented in commit 0f02f491b786 ("pwm: sifive: Reduce time the
controller lock is held") a caller of pwm_sifive_update_clock() must
hold the mutex. So fix pwm_sifive_clock_notifier() to grab the lock.

While this necessity was only documented later, the race exists since
the driver was introduced.

Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 2d4fa5e5fdd4..bb7239313401 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -204,8 +204,11 @@ static int pwm_sifive_clock_notifier(struct notifier_block *nb,
 	struct pwm_sifive_ddata *ddata =
 		container_of(nb, struct pwm_sifive_ddata, notifier);
 
-	if (event == POST_RATE_CHANGE)
+	if (event == POST_RATE_CHANGE) {
+		mutex_lock(&ddata->lock);
 		pwm_sifive_update_clock(ddata, ndata->new_rate);
+		mutex_unlock(&ddata->lock);
+	}
 
 	return NOTIFY_OK;
 }

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.37.2

