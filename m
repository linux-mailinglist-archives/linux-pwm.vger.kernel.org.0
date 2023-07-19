Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A65759E5D
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 21:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjGSTU3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 15:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjGSTU1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 15:20:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11CF1FEC
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 12:20:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCig-0000LX-8g; Wed, 19 Jul 2023 21:20:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCie-000fhk-Ur; Wed, 19 Jul 2023 21:20:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCie-006B2c-Ar; Wed, 19 Jul 2023 21:20:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 0/5] pwm: atmel-tcb: Some driver maintenance
Date:   Wed, 19 Jul 2023 21:20:08 +0200
Message-Id: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XvuAit+M16d7pdB721g4IBznB+J6lmlI6WpU+BDvjPY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkuDdkwwqutjRZQvqflhmCr6npioR38rvoIosGB hS8f+g+kZ2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLg3ZAAKCRCPgPtYfRL+ Tr3nB/9npHz/acM18ZCN0RAwQC2KEzZ0ljtRaJnlntIkc4OEJHYzf4V+UpndO5Xx+2yaq++FJ/U tJZGQOa5bjIYt3iw7jfvBJBx13NgdL4pO2l08z9pny4kMHMP3zAvjL0WzopUjVP89vOuATSWSTz tZonxn/Ptf1WVupdiGLMjeLQvpqqJQ+5W/CaT8/n+kY9DbZVhg1RftrGOWDMKDUVU8+is6lyhH5 xerTL/YLLfQgkxaxlCtGN5Jz2FCEuxzrMATt52kC7teicCk399+WgwbwMEzh6K/cTVJuO6mVTJE VYY/sOi4E2YEK0nxg2V4nfAutOJEAA6umwKvRbHxwY/HKLBd
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

here come some improvements to the pwm-atmel-tcb driver.

There are still a few opportunities to improve the driver. For example
.duty shouldn't be relevant for atmel_tcb_pwm_disable(). Also the driver
could be converted from of_clk_get_by_name to devm_clk_get() (and then
also devm_pwmchip_add()). Further more I think all members of
atmel_tcb_pwm_device could be dropped as they are all only used in
.apply() after they were assigned earlier in the same function; similar
to how I removed the polarity member. Maybe someone with the hardware
wants to chime in?

Best regards
Uwe

Uwe Kleine-König (5):
  pwm: atmel-tcb: Harmonize resource allocation order
  pwm: atmel-tcb: Fix resource freeing in error path and remove
  pwm: atmel-tcb: Put per-channel data into driver data
  pwm: atmel-tcb: Unroll atmel_tcb_pwm_set_polarity() into only caller
  pwm: atmel-tcb: Don't track polarity in driver data

 drivers/pwm/pwm-atmel-tcb.c | 120 ++++++++++++++----------------------
 1 file changed, 47 insertions(+), 73 deletions(-)

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2

