Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08312F1102
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 12:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbhAKLTE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 06:19:04 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:43352 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbhAKLTE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Jan 2021 06:19:04 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 0119444083C;
        Mon, 11 Jan 2021 13:17:47 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] gpio: mvebu: document zero pwm duty cycle limitation
Date:   Mon, 11 Jan 2021 13:17:06 +0200
Message-Id: <fa809a148e2a008c124677d61ea4ecba55cea7d0.1610362661.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610362661.git.baruch@tkos.co.il>
References: <cover.1610362661.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a comment on why the code never sets the 'on' register to zero.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/gpio-mvebu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index eb7456fa6d86..4261e3b22b4e 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -706,6 +706,7 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = DIV_ROUND_UP_ULL(val, NSEC_PER_SEC);
 	if (val > UINT_MAX)
 		return -EINVAL;
+	/* zero 'on' value does not work as expected for some reason */
 	if (val)
 		on = val;
 	else
-- 
2.29.2

