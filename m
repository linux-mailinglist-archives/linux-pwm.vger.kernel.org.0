Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54154700F18
	for <lists+linux-pwm@lfdr.de>; Fri, 12 May 2023 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbjELS42 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 May 2023 14:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbjELS41 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 May 2023 14:56:27 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73B21FD6;
        Fri, 12 May 2023 11:56:24 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F3A3C8211B;
        Fri, 12 May 2023 20:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683917782;
        bh=EFgjGS6yn7yt3zzPfunuZPbfDaSQXS7ttxv6AqLjd84=;
        h=From:To:Cc:Subject:Date:From;
        b=YET+UuXszkX9+KhCYAWLqcNUH7pqoe72CMwE76I7tu9D89ofn/dI1TZXKfH4tOQZP
         xXxWsBpg9kSVHKso+xaZ26kBJ8+YFggvBM+SmkCoj7DQu9nH+xF3hY7JVI6u6cIpT3
         nxvb1jnCTzGtopfZQ4iVIbelx0qWATXmnhseVUJKd0WHobt/cpqizw8Z8Lfk15Mdoy
         abHX+QeDYCg0tYwk4o/69GqnxhyeG2t0EQo9bxNtx5Wk/qWw60rFiSZ8F5M5v8xOYb
         8jAVMs21vSvP2KauohqIYZ+pjNhH1Szw9GC6OdRDPAAKU56eYXX1RLC3yUkZHuhIrH
         YlOKxDhEJw+jQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-input@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Date:   Fri, 12 May 2023 20:55:51 +0200
Message-Id: <20230512185551.183049-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM beeper volume can be controlled by adjusting the PWM duty cycle,
expose volume setting via sysfs, so users can make the beeper quieter.
This patch adds sysfs attribute 'volume' in range 0..50000, i.e. from 0
to 50% in 1/1000th of percent steps, this resolution should be sufficient.

The reason for 50000 cap on volume or PWM duty cycle is because duty cycle
above 50% again reduces the loudness, the PWM wave form is inverted wave
form of the one for duty cycle below 50% and the beeper gets quieter the
closer the setting is to 100% . Hence, 50% cap where the wave form yields
the loudest result.

Signed-off-by: Marek Vasut <marex@denx.de>
---
An alternative option would be to extend the userspace input ABI, e.g. by
using SND_TONE top 16bits to encode the duty cycle in 0..50000 range, and
bottom 16bit to encode the existing frequency in Hz . Since frequency in
Hz is likely to be below some 25 kHz for audible bell, this fits in 16bits
just fine. Thoughts ?
---
NOTE: This uses approach similar to [1], except it is much simpler.
      [1] https://patchwork.kernel.org/project/linux-input/cover/20230201152128.614439-1-manuel.traut@mt.com/
---
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Manuel Traut <manuel.traut@mt.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
---
 drivers/input/misc/pwm-beeper.c | 58 ++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 3cf1812384e6a..f63d0ebbaf573 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -21,6 +21,7 @@ struct pwm_beeper {
 	struct regulator *amplifier;
 	struct work_struct work;
 	unsigned long period;
+	unsigned long duty_cycle;
 	unsigned int bell_frequency;
 	bool suspended;
 	bool amplifier_on;
@@ -37,7 +38,7 @@ static int pwm_beeper_on(struct pwm_beeper *beeper, unsigned long period)
 
 	state.enabled = true;
 	state.period = period;
-	pwm_set_relative_duty_cycle(&state, 50, 100);
+	pwm_set_relative_duty_cycle(&state, beeper->duty_cycle, 100000);
 
 	error = pwm_apply_state(beeper->pwm, &state);
 	if (error)
@@ -119,6 +120,53 @@ static void pwm_beeper_close(struct input_dev *input)
 	pwm_beeper_stop(beeper);
 }
 
+static ssize_t volume_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct pwm_beeper *beeper = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%ld\n", beeper->duty_cycle);
+}
+
+static ssize_t volume_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct pwm_beeper *beeper = dev_get_drvdata(dev);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	/*
+	 * Volume is really PWM duty cycle in pcm (per cent mille, 1/1000th
+	 * of percent). This value therefore ranges from 0 to 50000 . Duty
+	 * cycle of 50% = 50000pcm is the maximum volume .
+	 */
+	val = clamp(val, 0UL, 50000UL);
+	/* No change in current settings, do nothing. */
+	if (val == beeper->duty_cycle)
+		return count;
+
+	/* Update current settings and apply to PWM chip. */
+	beeper->duty_cycle = val;
+	if (!beeper->suspended)
+		schedule_work(&beeper->work);
+
+	return count;
+}
+static DEVICE_ATTR_RW(volume);
+
+static struct attribute *pwm_beeper_dev_attrs[] = {
+	&dev_attr_volume.attr,
+	NULL
+};
+
+static const struct attribute_group pwm_beeper_attr_group = {
+	.attrs = pwm_beeper_dev_attrs,
+};
+
 static int pwm_beeper_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -192,6 +240,14 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	input_set_drvdata(beeper->input, beeper);
 
+	beeper->duty_cycle = 50000;
+	error = devm_device_add_group(dev, &pwm_beeper_attr_group);
+	if (error) {
+		dev_err(dev, "Unable to create sysfs attributes: %d\n",
+			error);
+		return error;
+	}
+
 	error = input_register_device(beeper->input);
 	if (error) {
 		dev_err(dev, "Failed to register input device: %d\n", error);
-- 
2.39.2

