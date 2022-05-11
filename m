Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AF2522DC3
	for <lists+linux-pwm@lfdr.de>; Wed, 11 May 2022 09:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiEKH7H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 May 2022 03:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbiEKH7G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 May 2022 03:59:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD4B5EBEE
        for <linux-pwm@vger.kernel.org>; Wed, 11 May 2022 00:59:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nohFO-0006pO-9l; Wed, 11 May 2022 09:59:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nohFO-001dzg-3h; Wed, 11 May 2022 09:59:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nohFM-008ypb-02; Wed, 11 May 2022 09:59:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] gpio: mvebu/pwm: Refuse requests with inverted polarity
Date:   Wed, 11 May 2022 09:58:56 +0200
Message-Id: <20220511075856.88687-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; h=from:subject; bh=HBEt5W+SrsDNrhlDJ08tggzLHVh/CnWH0sjZDkBwU+A=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBie2y8Akxk1Bj8B0wRBI4VWhPtIk5mMQneAwXhHvaf 1nGue+OJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYntsvAAKCRDB/BR4rcrsCdZGB/ 9Q7MW+awqwOUgWfvh7EyKpx4L+H1pmxgD9k0SGjoQGIr6USn8eSg0k9NGdSB7E5EareryD6cZ2BCM1 IzFc0pw4qQPRL/Rh2wsXzzNN8Sf4JyJAitEVUKRp5O50YFZbWf0kVdJTx+WnVFu33eVex5MboDYCYz PchB6ur9n/M8m/+ZpYh9mLutkQDRyiiVwRoHIgXzE7F86aPfyKUenzFvltHiGCHIWAKc59BPOP2Rpc wQYLQk2N/1aG31BOxCVutWmbaVhq84FhY+FRO+LKsFWADy9cu5i7e77brbK+T/SEVUKvrKiozqBqHB VgDrR9EXOKUCWVNNKZGYt5XS+l1NLp
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

The driver doesn't take struct pwm_state::polarity into account when
configuring the hardware, so refuse requests for inverted polarity.

Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-mvebu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 4c1f9e1091b7..92ecaea2d5d4 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -707,6 +707,9 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long flags;
 	unsigned int on, off;
 
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
 	val = (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
 	do_div(val, NSEC_PER_SEC);
 	if (val > UINT_MAX + 1ULL)

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

