Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1727F25C4F3
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Sep 2020 17:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgICPVA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Sep 2020 11:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728508AbgICLYo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Sep 2020 07:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599132282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BihA1BpHNAPbZmr7utm+7lcBoH9ReI2g/yHAfDzPOZk=;
        b=OYQFpV4uJalEEn2AIyB5Gh9cWlkZFZYA3z1SclVSjAeyWD34QzQ8L90vch0l4B8KsYZ7Oz
        onsl7sb07KdRFBXVgGy9V3tv3ikPEwRYKmBVHl70qLXtMNaTd7zP98mimFrmZu7RWSFC+o
        jBmklVYktPaHwFbMlzDP90z3yWWRYu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-EHjOs5jPN_eBJa0VFXdbgA-1; Thu, 03 Sep 2020 07:24:40 -0400
X-MC-Unique: EHjOs5jPN_eBJa0VFXdbgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D353910ABDD1;
        Thu,  3 Sep 2020 11:24:35 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-3.ams2.redhat.com [10.36.113.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B8FF5C1C2;
        Thu,  3 Sep 2020 11:24:32 +0000 (UTC)
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
Subject: [PATCH v10 13/17] pwm: crc: Implement get_state() method
Date:   Thu,  3 Sep 2020 13:23:33 +0200
Message-Id: <20200903112337.4113-14-hdegoede@redhat.com>
In-Reply-To: <20200903112337.4113-1-hdegoede@redhat.com>
References: <20200903112337.4113-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Implement the pwm_ops.get_state() method to complete the support for the
new atomic PWM API.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
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

