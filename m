Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E001774410
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjHHSOy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjHHSO2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA4975876
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-0007gX-GF; Tue, 08 Aug 2023 19:20:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-00229m-O1; Tue, 08 Aug 2023 19:20:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNC-00BTFS-Oe; Tue, 08 Aug 2023 19:19:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 082/101] pwm: meson: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:12 +0200
Message-Id: <20230808171931.944154-83-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3237; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SwWyqb++p2ajcHGRI9WjglpZQwGjVFtgWe7qRRl09fg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkNwZhL+tq6ziC29GIARF/K2SJOEtjyioipS Kj8qUnVfj6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5DQAKCRCPgPtYfRL+ Tn7sCACv2M+t+CMdXdKiCOjVKjrvXB+xPhDgADdeU0weBWUqjCmz42/eXJIonMlNa/KX4gKsx2z u/F7wgDsCBkqlausOwskmjnHCDLiyMq+xqlp0IKsaXJfDM19GAi6aRnmyIqUdOqZL5EVPvyPJkQ jlOXDr1n1RjTsxHgPguu50daJ+9EpfEzjchG7H6EUN9bJz3PxwMunakQ8qUXg6AXuBrfz49Wf5A 2YHJIa028InK4adOARf1wcernInz911zGwtiE/ezBI3x6rgZUdQP7PofYz3yc/gfhnsapitt6L5 /N0+yMy0pImc3OyY6ijPhY9AZ3E7UFeRZ9vC94aaN9wgSHli
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

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, store a pointer to
the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-meson.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 3b6a8c9466a2..52cf7ca5aa7f 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -102,6 +102,7 @@ struct meson_pwm_data {
 };
 
 struct meson_pwm {
+	struct device *parent;
 	const struct meson_pwm_data *data;
 	struct meson_pwm_channel channels[MESON_NUM_PWMS];
 	void __iomem *base;
@@ -121,7 +122,7 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	struct device *dev = chip->dev;
+	struct device *dev = meson->parent;
 	int err;
 
 	err = clk_prepare_enable(channel->clk);
@@ -169,19 +170,19 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	fin_freq = clk_round_rate(channel->clk, freq);
 	if (fin_freq == 0) {
-		dev_err(chip->dev, "invalid source clock frequency\n");
+		dev_err(meson->parent, "invalid source clock frequency\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(chip->dev, "fin_freq: %lu Hz\n", fin_freq);
+	dev_dbg(meson->parent, "fin_freq: %lu Hz\n", fin_freq);
 
 	cnt = div_u64(fin_freq * period, NSEC_PER_SEC);
 	if (cnt > 0xffff) {
-		dev_err(chip->dev, "unable to get period cnt\n");
+		dev_err(meson->parent, "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(chip->dev, "period=%llu cnt=%u\n", period, cnt);
+	dev_dbg(meson->parent, "period=%llu cnt=%u\n", period, cnt);
 
 	if (duty == period) {
 		channel->hi = cnt;
@@ -192,7 +193,7 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 	} else {
 		duty_cnt = div_u64(fin_freq * duty, NSEC_PER_SEC);
 
-		dev_dbg(chip->dev, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
+		dev_dbg(meson->parent, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
 
 		channel->hi = duty_cnt;
 		channel->lo = cnt - duty_cnt;
@@ -216,7 +217,7 @@ static void meson_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	err = clk_set_rate(channel->clk, channel->rate);
 	if (err)
-		dev_err(chip->dev, "setting clock rate failed\n");
+		dev_err(meson->parent, "setting clock rate failed\n");
 
 	spin_lock_irqsave(&meson->lock, flags);
 
@@ -438,7 +439,7 @@ static int meson_pwm_init_channels(struct pwm_chip *chip)
 {
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct clk_parent_data mux_parent_data[MESON_MAX_MUX_PARENTS] = {};
-	struct device *dev = chip->dev;
+	struct device *dev = meson->parent;
 	unsigned int i;
 	char name[255];
 	int err;
@@ -543,6 +544,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	meson = to_meson_pwm(chip);
 
+	meson->parent = &pdev->dev;
 	meson->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(meson->base))
 		return PTR_ERR(meson->base);
-- 
2.40.1

