Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF0257C901
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Jul 2022 12:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiGUKbn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Jul 2022 06:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiGUKbl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Jul 2022 06:31:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1671160506
        for <linux-pwm@vger.kernel.org>; Thu, 21 Jul 2022 03:31:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSz-0002W1-QS; Thu, 21 Jul 2022 12:31:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSy-002IMt-Ti; Thu, 21 Jul 2022 12:31:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSy-006ZIY-8Y; Thu, 21 Jul 2022 12:31:36 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>
Subject: [PATCH 7/7] pwm: sifive: Shut down hardware only after pwmchip_remove() completed
Date:   Thu, 21 Jul 2022 12:31:29 +0200
Message-Id: <20220721103129.304697-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
References: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; h=from:subject; bh=zQLWxgV295stqWE/56SMfwXF5tRzx6Wmb0QC4HH8Cw8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi2Sr+XeA/kTOnz7lLWTP39p9qGkAtgJshtXu2A/vv Td2ybxGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtkq/gAKCRDB/BR4rcrsCfIuB/ 4787jU2mMlX1tFBEAWmtDC1irHTvudx25tIFJeJWAZPkm9MasFS3qs8e2lDL3q4NXCOm49Z2IH4m6d rf9raH1+cAJxza7sO8LZnMp4YDaptnSFqKpJG6sqbPxwEKj0aZU1g2g+1Zg5AvrQGQgnwmptatgELU rAXNiH8Psm0aDLStJ5UHJtOBxlEIuQtw466jtcMF06/wMT3LfV36QKIYW8GXF+WwZOshuklCHu4xyS dMdvFn2RkGwyxwAM7fyLiOMDpMyxejx9cUHy3+KQN86EoJhAwHOtamHQAGqAGX8Xr8Bhq7RRSMZ8GA IHNDiElI3/fnq2H2oIyE6eJd9gMs7D
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

The PWMs are expected to be functional until pwmchip_remove() is called.
So disable the clks only afterwards.

Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index da40ade0ebdf..2d4fa5e5fdd4 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -308,6 +308,9 @@ static int pwm_sifive_remove(struct platform_device *dev)
 	struct pwm_device *pwm;
 	int ch;
 
+	pwmchip_remove(&ddata->chip);
+	clk_notifier_unregister(ddata->clk, &ddata->notifier);
+
 	for (ch = 0; ch < ddata->chip.npwm; ch++) {
 		pwm = &ddata->chip.pwms[ch];
 		if (pwm->state.enabled)
@@ -315,8 +318,6 @@ static int pwm_sifive_remove(struct platform_device *dev)
 	}
 
 	clk_unprepare(ddata->clk);
-	pwmchip_remove(&ddata->chip);
-	clk_notifier_unregister(ddata->clk, &ddata->notifier);
 
 	return 0;
 }
-- 
2.36.1

