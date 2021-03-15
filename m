Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5D33B0B9
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Mar 2021 12:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhCOLLx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Mar 2021 07:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCOLL2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Mar 2021 07:11:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87769C061762
        for <linux-pwm@vger.kernel.org>; Mon, 15 Mar 2021 04:11:28 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lLl8A-0006Y5-Ih; Mon, 15 Mar 2021 12:11:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lLl8A-00033E-8u; Mon, 15 Mar 2021 12:11:26 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/4] pwm: Autodetect default value for of_pwm_n_cells from device tree
Date:   Mon, 15 Mar 2021 12:11:23 +0100
Message-Id: <20210315111124.2475274-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
References: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This allows to simplify all drivers that use three pwm-cells.
The only ugly side effect is that if a driver specified of_pwm_n_cells = 2
it suddenly supports device trees that use #pwm-cells = <3>. This however
isn't a bad thing because the driver doesn't need explicit support for
three cells as the core handles all the details. Also there is no such
in-tree driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 806d818d913f..399652f01eeb 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -157,8 +157,14 @@ static void of_pwmchip_add(struct pwm_chip *chip)
 		return;
 
 	if (!chip->of_xlate) {
+		u32 pwm_cells;
+
+		if (of_property_read_u32(chip->dev->of_node, "#pwm-cells",
+					 &pwm_cells))
+			pwm_cells = 2;
+
 		chip->of_xlate = of_pwm_xlate_with_flags;
-		chip->of_pwm_n_cells = 2;
+		chip->of_pwm_n_cells = pwm_cells;
 	}
 
 	of_node_get(chip->dev->of_node);
-- 
2.30.1

