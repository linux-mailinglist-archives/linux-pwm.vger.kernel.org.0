Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2357063D930
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Nov 2022 16:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiK3PWD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 10:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiK3PWC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 10:22:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C37CAA9
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 07:22:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuN-0000AX-07; Wed, 30 Nov 2022 16:21:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuL-001Le0-J5; Wed, 30 Nov 2022 16:21:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuL-001Vr4-Ld; Wed, 30 Nov 2022 16:21:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 09/11] pwm: rockchip: Propagate errors in .get_state() to the caller
Date:   Wed, 30 Nov 2022 16:21:46 +0100
Message-Id: <20221130152148.2769768-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=730; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pKEsqqELf8pqmyD4QAsi9Xpc86tdi7pQt9Er7E+Nu3o=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjh3T/bN1g1kVNiJ/v8SIOIucUrMidx7s9Upuf1Iv8 Q3S2XXCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY4d0/wAKCRDB/BR4rcrsCVcQB/ 4o6RgFb19BY0wEs5wjZVFmTdgVeuclNrg1zVXaXOSCV6pNPDgj0IHt6CKqbCzd9BJq/yKEo3daI3Wr UhT78i6koC8btpmDDh7thoNUUlSayy1WTaOjxLgsqJ90PKjyG3oAIdIe8Fe3QT3P0mUDQKUUbc2x6M QxXDQpNH5NsetybZts2hi1OraEycQTiEO2Ff9fkUXAzuWBZ3nDp6eXiLN9ChkFuN6Q5M0Ir15DxvzC +iDh4mjN9H3LoLruxRGZt8uBb99fJ1uvv6SZu+5vPPcw8+amktlXtxxFN5NIY/HdvdxbGFUh1js227 sadEba0dTaPgZNjUj2pRzmF4jFBnv6
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
 drivers/pwm/pwm-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 3ec7d1756903..7f084eb34092 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -70,11 +70,11 @@ static int rockchip_pwm_get_state(struct pwm_chip *chip,
 
 	ret = clk_enable(pc->pclk);
 	if (ret)
-		return 0;
+		return ret;
 
 	ret = clk_enable(pc->clk);
 	if (ret)
-		return 0;
+		return ret;
 
 	clk_rate = clk_get_rate(pc->clk);
 
-- 
2.38.1

