Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C07328AF5
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Mar 2021 19:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbhCAS0I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Mar 2021 13:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbhCASXu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Mar 2021 13:23:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172DFC061756
        for <linux-pwm@vger.kernel.org>; Mon,  1 Mar 2021 10:23:11 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGnCH-0000dm-5H; Mon, 01 Mar 2021 19:23:09 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGnCG-0006B7-JX; Mon, 01 Mar 2021 19:23:08 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: Return -EINVAL for old-style drivers without .set_polarity callback
Date:   Mon,  1 Mar 2021 19:23:07 +0100
Message-Id: <20210301182307.1681548-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.0
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

Since commit 2b1c1a5d5148 ("pwm: Use -EINVAL for unsupported polarity")
all drivers implementing the apply callback are unified to return
-EINVAL if an unsupported polarity is requested. Do the same in the
compat code for old-style drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a8eff4b3ee36..8e1f97f2e049 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -607,7 +607,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 		 */
 		if (state->polarity != pwm->state.polarity) {
 			if (!chip->ops->set_polarity)
-				return -ENOTSUPP;
+				return -EINVAL;
 
 			/*
 			 * Changing the polarity of a running PWM is
-- 
2.30.0

