Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2ADAE2AD8
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2019 09:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437880AbfJXHOV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Oct 2019 03:14:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50931 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437887AbfJXHOV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Oct 2019 03:14:21 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iNXK7-0001xG-6o; Thu, 24 Oct 2019 09:14:19 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iNXK6-000628-8H; Thu, 24 Oct 2019 09:14:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] pwm: rcar: Drop useless call to pwm_get_state
Date:   Thu, 24 Oct 2019 09:14:09 +0200
Message-Id: <20191024071410.30620-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwm_get_state has no side effects and the resulting pwm_state is unused.
So drop the call to pwm_get_state and the local variable from
rcar_pwm_apply().

The call was introduced in commit 7f68ce8287d3 ("pwm: rcar: Add support
"atomic" API") and already then was useless.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rcar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 852eb2347954..6fac8eb98d54 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -161,11 +161,9 @@ static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
-	struct pwm_state cur_state;
 	int div, ret;
 
 	/* This HW/driver only supports normal polarity */
-	pwm_get_state(pwm, &cur_state);
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -ENOTSUPP;
 
-- 
2.23.0

