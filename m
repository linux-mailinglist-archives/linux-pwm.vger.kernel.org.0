Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEED25161E
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 12:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgHYKCN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 06:02:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36987 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729779AbgHYKCK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Aug 2020 06:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598349728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pl9KVfD+7YlWJlLk8Ot+a3gHE/6VBv99WiVsPiXEvhY=;
        b=D+6DBR2foRkS7HOH5i+VRe4/e6kiHjeXpdrMCYv/Cd8CmT1wjXqDGFWz+jpQL9670UQFZt
        ro8SWZbOTx9zfgd5eOexnB58wztxjc11F8w4O4lsA9TDz6WAzeEp28sKCSoGlgp30dYuTB
        F0ydixHk1pjM6aqYsuMoh1tcPpUoxrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-eV0e5_5PPgaflE7LNxcLCw-1; Tue, 25 Aug 2020 06:02:06 -0400
X-MC-Unique: eV0e5_5PPgaflE7LNxcLCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90D2B81F03A;
        Tue, 25 Aug 2020 10:02:04 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-132.ams2.redhat.com [10.36.114.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF00B80954;
        Tue, 25 Aug 2020 10:01:58 +0000 (UTC)
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
Subject: [PATCH v7 12/16] pwm: crc: Implement get_state() method
Date:   Tue, 25 Aug 2020 12:01:02 +0200
Message-Id: <20200825100106.61941-13-hdegoede@redhat.com>
In-Reply-To: <20200825100106.61941-1-hdegoede@redhat.com>
References: <20200825100106.61941-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Implement the pwm_ops.get_state() method to complete the support for the
new atomic PWM API.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v6:
- Rebase on 5.9-rc1
- Use DIV_ROUND_UP_ULL because pwm_state.period and .duty_cycle are now u64

Changes in v5:
- Fix an indentation issue

Changes in v4:
- Use DIV_ROUND_UP when calculating the period and duty_cycle from the
  controller's register values

Changes in v3:
- Add Andy's Reviewed-by tag
- Remove extra whitespace to align some code after assignments (requested by
  Uwe Kleine-König)
---
 drivers/pwm/pwm-crc.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 27dc30882424..ecfdfac0c2d9 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -121,8 +121,39 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static void crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
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
+	state->period =
+		DIV_ROUND_UP(clk_div * NSEC_PER_USEC * 256, PWM_BASE_CLK_MHZ);
+	state->duty_cycle =
+		DIV_ROUND_UP_ULL(duty_cycle_reg * state->period, PWM_MAX_LEVEL);
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
2.28.0

