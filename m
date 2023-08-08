Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4150F77491B
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjHHTsq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjHHTsf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:48:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABE14DEBB
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 09:53:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTPxA-0002j6-U8; Tue, 08 Aug 2023 18:53:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTPxA-0021Yy-AB; Tue, 08 Aug 2023 18:53:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTPx9-00BSfp-AD; Tue, 08 Aug 2023 18:53:03 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: Mention PWM chip ID in /sys/kernel/debug/pwm
Date:   Tue,  8 Aug 2023 18:52:50 +0200
Message-Id: <20230808165250.942396-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808165250.942396-1-u.kleine-koenig@pengutronix.de>
References: <20230808165250.942396-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=a6PIxDuv/Hv/xfFM5o35Accwr7YR+tsAR0li8ifL4B4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nLewpX2kwdFDDHiAvz4i45LjKdG1+S5ZixTN p+pSFf0BEWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJy3gAKCRCPgPtYfRL+ TjSLB/9rrVzfU/qK0hZItHyOOEUdSZg0nNohYfqt9d0cbaELi1Kx9YiYLy7HilctO7/sWGv1RT0 8oQnP3Y3//4MKgjKTsI7ZeTur9s8bFY9I2bned6eiT5xStQ6WLbJMzJ674ZMEjny6+Ipg6mva22 9DJZlVngpNGanImuWcbZPuFJWAaiVC6JQMj+wxNDnjiAuG7NaAAPjh3iHY4UnP3TVR41gVz6us1 yp16DpjKqEvoWBeuoesHHcbIpWDVXfIu4PV6deGpQI0IFajc+zK7IfOj+iD/fF2jZ2DGVjiGder jOrF88msslVLSS8MLesiMrgf9zdwp9eYzU6BJ4RY/EEsEA79
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

While it's not hard to match the entries from /sys/kernel/debug/pwm to
the corresponding pwmchip in /sys/class/pwm, it's a bit simpler to have
the number mentioned in /sys/kernel/debug/pwm.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9b1eb37e2e73..2e16b7454c65 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1090,7 +1090,8 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 {
 	struct pwm_chip *chip = v;
 
-	seq_printf(s, "%s%s/%s, %d PWM device%s\n", (char *)s->private,
+	seq_printf(s, "%s%d: %s/%s, %d PWM device%s\n",
+		   (char *)s->private, chip->id,
 		   chip->dev->bus ? chip->dev->bus->name : "no-bus",
 		   dev_name(chip->dev), chip->npwm,
 		   (chip->npwm != 1) ? "s" : "");
-- 
2.40.1

