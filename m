Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C72C25BF9C
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Sep 2020 12:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgICKwT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Sep 2020 06:52:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38389 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728382AbgICKwG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Sep 2020 06:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599130325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ssaDmZ3q4kks75jcoGrHn3rdUGB2JCDdcC8N/xAd3GA=;
        b=UYQgxJRc/3T0GxTpGqNKxWjAOs4oWG6tdcLxuaHMH4y1kCtakrQc5lJTqab2CoSAefTZUH
        9r9sF99GbNLGKfhpUUVgH6/Fvx4T7pX1pVbdNf8SChgj26lQ5RbumY8S6iLkQBjJu4CjId
        +X6zPODEGI9jOC+OBblLJDKrax1m2JQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-mT2uZSLLMG-IONlR5rewyA-1; Thu, 03 Sep 2020 06:52:01 -0400
X-MC-Unique: mT2uZSLLMG-IONlR5rewyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C1D518A2264;
        Thu,  3 Sep 2020 10:51:59 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-4.ams2.redhat.com [10.36.115.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9D387EEAE;
        Thu,  3 Sep 2020 10:51:56 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v9 12/17] pwm: crc: Implement apply() method to support the new atomic PWM API
Date:   Thu,  3 Sep 2020 12:51:09 +0200
Message-Id: <20200903105114.9969-13-hdegoede@redhat.com>
In-Reply-To: <20200903105114.9969-1-hdegoede@redhat.com>
References: <20200903105114.9969-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Replace the enable, disable and config pwm_ops with an apply op,
to support the new atomic PWM API.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v6:
- Rebase on 5.9-rc1
- Use do_div when calculating level because pwm_state.period and .duty_cycle are now u64

Changes in v3:
- Keep crc_pwm_calc_clk_div() helper to avoid needless churn
---
 drivers/pwm/pwm-crc.c | 89 ++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index b72008c9b072..27dc30882424 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -51,59 +51,78 @@ static int crc_pwm_calc_clk_div(int period_ns)
 	return clk_div;
 }
 
-static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
+static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
 {
-	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
-	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
+	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
+	struct device *dev = crc_pwm->chip.dev;
+	int err;
 
-	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div | PWM_OUTPUT_ENABLE);
-	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 1);
+	if (state->period > PWM_MAX_PERIOD_NS) {
+		dev_err(dev, "un-supported period_ns\n");
+		return -EINVAL;
+	}
 
-	return 0;
-}
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EOPNOTSUPP;
 
-static void crc_pwm_disable(struct pwm_chip *c, struct pwm_device *pwm)
-{
-	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
-	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
+	if (pwm_is_enabled(pwm) && !state->enabled) {
+		err = regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
+		if (err) {
+			dev_err(dev, "Error writing BACKLIGHT_EN %d\n", err);
+			return err;
+		}
+	}
 
-	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
-	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div);
-}
+	if (pwm_get_duty_cycle(pwm) != state->duty_cycle ||
+	    pwm_get_period(pwm) != state->period) {
+		u64 level = state->duty_cycle * PWM_MAX_LEVEL;
 
-static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
-			  int duty_ns, int period_ns)
-{
-	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
-	struct device *dev = crc_pwm->chip.dev;
-	int level;
+		do_div(level, state->period);
 
-	if (period_ns > PWM_MAX_PERIOD_NS) {
-		dev_err(dev, "un-supported period_ns\n");
-		return -EINVAL;
+		err = regmap_write(crc_pwm->regmap, PWM0_DUTY_CYCLE, level);
+		if (err) {
+			dev_err(dev, "Error writing PWM0_DUTY_CYCLE %d\n", err);
+			return err;
+		}
 	}
 
-	if (pwm_get_period(pwm) != period_ns) {
-		int clk_div = crc_pwm_calc_clk_div(period_ns);
-
+	if (pwm_is_enabled(pwm) && state->enabled &&
+	    pwm_get_period(pwm) != state->period) {
 		/* changing the clk divisor, clear PWM_OUTPUT_ENABLE first */
-		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, 0);
+		err = regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, 0);
+		if (err) {
+			dev_err(dev, "Error writing PWM0_CLK_DIV %d\n", err);
+			return err;
+		}
+	}
 
-		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
-					clk_div | PWM_OUTPUT_ENABLE);
+	if (pwm_get_period(pwm) != state->period ||
+	    pwm_is_enabled(pwm) != state->enabled) {
+		int clk_div = crc_pwm_calc_clk_div(state->period);
+		int pwm_output_enable = state->enabled ? PWM_OUTPUT_ENABLE : 0;
+
+		err = regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
+				   clk_div | pwm_output_enable);
+		if (err) {
+			dev_err(dev, "Error writing PWM0_CLK_DIV %d\n", err);
+			return err;
+		}
 	}
 
-	/* change the pwm duty cycle */
-	level = duty_ns * PWM_MAX_LEVEL / period_ns;
-	regmap_write(crc_pwm->regmap, PWM0_DUTY_CYCLE, level);
+	if (!pwm_is_enabled(pwm) && state->enabled) {
+		err = regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 1);
+		if (err) {
+			dev_err(dev, "Error writing BACKLIGHT_EN %d\n", err);
+			return err;
+		}
+	}
 
 	return 0;
 }
 
 static const struct pwm_ops crc_pwm_ops = {
-	.config = crc_pwm_config,
-	.enable = crc_pwm_enable,
-	.disable = crc_pwm_disable,
+	.apply = crc_pwm_apply,
 };
 
 static int crystalcove_pwm_probe(struct platform_device *pdev)
-- 
2.28.0

