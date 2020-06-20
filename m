Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBAA2023AD
	for <lists+linux-pwm@lfdr.de>; Sat, 20 Jun 2020 14:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgFTMTR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 08:19:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28124 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728111AbgFTMTQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 20 Jun 2020 08:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592655555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=erfNuDavLxnTtVjZ6+2hP+lNgUKAFKHBVKGsbAMBI4I=;
        b=ZJNwDfCzRf3nr758XG5u5yb3HQmEsMEXcMKQL7e3DrPQm1MUJ36mRd0JefFdjwBnF5+ZW9
        wj4xW40ZiTuOuxb+6asstQ6WOa9Ko2DAc2dZJcjJ/j3LKIT50Vl+ZrLtxtG/hXGdXf1Y5p
        +pg7RRZc9mMNB0bAHHFkz5kGGsrT7gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-NA83pny-MFWmNDcFyh1coA-1; Sat, 20 Jun 2020 08:19:12 -0400
X-MC-Unique: NA83pny-MFWmNDcFyh1coA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF0CC8017FB;
        Sat, 20 Jun 2020 12:19:09 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-42.ams2.redhat.com [10.36.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4180210021B3;
        Sat, 20 Jun 2020 12:19:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
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
Subject: [PATCH v3 11/15] pwm: crc: Implement get_state() method
Date:   Sat, 20 Jun 2020 14:17:54 +0200
Message-Id: <20200620121758.14836-12-hdegoede@redhat.com>
In-Reply-To: <20200620121758.14836-1-hdegoede@redhat.com>
References: <20200620121758.14836-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Implement the pwm_ops.get_state() method to complete the support for the
new atomic PWM API.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Add Andy's Reviewed-by tag
- Remove extra whitespace to align some code after assignments (requested by
  Uwe Kleine-König)
---
 drivers/pwm/pwm-crc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 8a7f4707279c..b311354d40a3 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -119,8 +119,37 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static void crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
+	struct device *dev = crc_pwm->chip.dev;
+	unsigned int clk_div, clk_div_reg, duty_cycle_reg;
+	int error;
+
+	error = regmap_read(crc_pwm->regmap, PWM0_CLK_DIV, &clk_div_reg);
+	if (error) {
+		dev_err(dev, "Error reading PWM0_CLK_DIV %d\n", error);
+		return;
+	}
+
+	error = regmap_read(crc_pwm->regmap, PWM0_DUTY_CYCLE, &duty_cycle_reg);
+	if (error) {
+		dev_err(dev, "Error reading PWM0_DUTY_CYCLE %d\n", error);
+		return;
+	}
+
+	clk_div = (clk_div_reg & ~PWM_OUTPUT_ENABLE) + 1;
+
+	state->period = clk_div * NSEC_PER_USEC * 256 / PWM_BASE_CLK_MHZ;
+	state->duty_cycle = duty_cycle_reg * state->period / PWM_MAX_LEVEL;
+	state->polarity = PWM_POLARITY_NORMAL;
+	state->enabled = !!(clk_div_reg & PWM_OUTPUT_ENABLE);
+}
+
 static const struct pwm_ops crc_pwm_ops = {
 	.apply = crc_pwm_apply,
+	.get_state = crc_pwm_get_state,
 };
 
 static int crystalcove_pwm_probe(struct platform_device *pdev)
-- 
2.26.2

