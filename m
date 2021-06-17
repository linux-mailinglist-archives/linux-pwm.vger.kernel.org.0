Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E993AB04E
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Jun 2021 11:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFQJyH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Jun 2021 05:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhFQJyH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Jun 2021 05:54:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE08C06175F
        for <linux-pwm@vger.kernel.org>; Thu, 17 Jun 2021 02:51:59 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogn-0007Pc-II; Thu, 17 Jun 2021 11:51:57 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogn-0005Nr-7p; Thu, 17 Jun 2021 11:51:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v1 5/6] pwm: tegra: Implement .apply callback
Date:   Thu, 17 Jun 2021 11:51:44 +0200
Message-Id: <20210617095145.163694-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
References: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=K6KVBkTeP5hAgNNbKWZsznHPIIGOLWBeHs1qVs+eIyA=; m=xgQO1Ntz4XetZEdy5d5jKawyUPr55/tFRo2qZPphYWE=; p=N9tPnDo3jRNkdLmvTZNMjFvJir7WivltqpvI+x3jG8Y=; g=2a8af462da08e4416d682fb4de411bb28da4ddaf
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDLGvwACgkQwfwUeK3K7AkCYwf9Hof YSacF9e0jQgO2kP/1RL9ykMAjrdHkSnGuRP0Os2IsTVP4uL+/rAyzu3Ta+5QH7pqwMy/y74ZlYEWq g4HXeXU8vqa7aN+VW7h/BUroLKxs5Vdtk5+GaV81RIHoYihmHnTy2MVey8rRD6N21FvEWPp7crJ7O H2QgupX2tww3kS63bMZib7IuVApNkdT68dhv5DwRPCmdQJ6NeOwhKc5dErx5eE7wwf/lW12DKbjDI WstZUzWTi1kN/5zUMPJ2eayGxrwlP5cW9b/CtLhRN5OmMNJuJMZsBGDBeUJ/6ylR/4zW1DKVnfXdV j2AuhaYstnBPh2CspqbiZE8IPN4yE9g==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

To ease review this reuses the formerly implemented callbacks.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tegra.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 11a10b575ace..1161c6323e60 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -227,10 +227,36 @@ static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(pc->clk);
 }
 
+static int tegra_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			tegra_pwm_disable(chip, pwm);
+		return 0;
+	}
+
+	if (state->period != pwm->state.period ||
+	    state->duty_cycle != pwm->state.duty_cycle) {
+		err = tegra_pwm_config(pwm->chip, pwm, (int)state->duty_cycle,
+				       (int)state->period);
+		if (err)
+			return err;
+	}
+
+	if (!pwm->state.enabled)
+		return tegra_pwm_enable(chip, pwm);
+
+	return 0;
+}
+
 static const struct pwm_ops tegra_pwm_ops = {
-	.config = tegra_pwm_config,
-	.enable = tegra_pwm_enable,
-	.disable = tegra_pwm_disable,
+	.apply = tegra_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.30.2

