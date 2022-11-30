Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B8163D934
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Nov 2022 16:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiK3PWG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 10:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiK3PWC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 10:22:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8783C7E406
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 07:22:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuN-0000AW-0c; Wed, 30 Nov 2022 16:21:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuL-001Ldw-I8; Wed, 30 Nov 2022 16:21:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuL-001Vr1-DG; Wed, 30 Nov 2022 16:21:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 08/11] pwm: mtk-disp: Propagate errors in .get_state() to the caller
Date:   Wed, 30 Nov 2022 16:21:45 +0100
Message-Id: <20221130152148.2769768-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Oif9jO/ANaV2n8mI1Wq5VGoWZKNoCZbLOMG3XU4Hj2w=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjh3T7YqPl7JZhWa8Pa2lUKahY1hm5Te0uFIv3uqcp pRHSC+SJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY4d0+wAKCRDB/BR4rcrsCc8fB/ 47kl5AVu6pGuHI/CsRRxJJS4Dskp2blmJE5duNo9j12Cpt3gsaP2ZuE7z4Lu0nwEQL/Ak6JBUkDrvl 0Ka3WDtNz8PRWRowPY1oqoi6s7hn/4zwBaMOks7f4qJvUyBtitXgDCA/8jgQ4KZyla8XhwnLAyncCq vK7iRM7lq4hurTEtxtzu0yY2ReLKJ1tk27EMBSo53Wv3HzbjnKEaluegwUcSnmlpiiZgjk1Oj1hFQt LR43Bne71SZH96jscnRGgSwh191M8po5Zcp22LHIreoGGSsPWtEAmd5SxuQl6WxnQL/Mp9dY7nTk7r QCx73jbJyahSah2nbNjRHy5aoXSqGi
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

.get_state() can return an error indication. Make use of it to propagate
failing hardware accesses.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mtk-disp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 9a6bb334a31b..67e5799dd157 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -184,14 +184,14 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
 	err = clk_prepare_enable(mdp->clk_main);
 	if (err < 0) {
 		dev_err(chip->dev, "Can't enable mdp->clk_main: %pe\n", ERR_PTR(err));
-		return 0;
+		return err;
 	}
 
 	err = clk_prepare_enable(mdp->clk_mm);
 	if (err < 0) {
 		dev_err(chip->dev, "Can't enable mdp->clk_mm: %pe\n", ERR_PTR(err));
 		clk_disable_unprepare(mdp->clk_main);
-		return 0;
+		return err;
 	}
 
 	rate = clk_get_rate(mdp->clk_main);
-- 
2.38.1

