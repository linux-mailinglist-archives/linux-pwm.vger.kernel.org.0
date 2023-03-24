Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9706C8849
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Mar 2023 23:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjCXWXn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Mar 2023 18:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjCXWXh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Mar 2023 18:23:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985B3CDDA
        for <linux-pwm@vger.kernel.org>; Fri, 24 Mar 2023 15:23:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n19so1930885wms.0
        for <linux-pwm@vger.kernel.org>; Fri, 24 Mar 2023 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679696603;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rb6cLGwAhVU00J8l+qGq5/4WEL4UbFMyoyqigSKqaVI=;
        b=E3/i93Ram4veQfWYWy/Db48ZY7e+JzpuLHODyfLsQ+w1I48Lz4CkWF9oOCr/amyegz
         P9k/D4q861z3qM15pdHjeEiRhtbKKTXiT7DaGaM3WFLjiMnAETvDO6qQiXaUApY1/LA2
         KbDcxKSS9bdFijZ/pF/06OSVqkS/4WjiqvAS4OfTgnKSpvf7hFzqPbBj82SAMutT5sl6
         FPaABa0S1v+/FtGTGqP4xdN50mxRgbmijQc+QKAkbPHIw992qMCGB0yIViyK9mjSGW0D
         J7txJcjVnlX72apuTeVCbayXAIP6EegGZ0tkMZHfHXNQvM8jTZ3XunZ+QRX9ZUWdQHoq
         lSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679696603;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rb6cLGwAhVU00J8l+qGq5/4WEL4UbFMyoyqigSKqaVI=;
        b=n6oOXo+Stg8EBo67CostW9Ltiig6/xC6dBjUYa3Z3tyRdxfCfueV5YxH9d1VdMgCoR
         u31EnhYMahIIFgdz3eaQQXtaxbsedDBxsMwVOp/qTIeFujglUXKZvhiJRSyIGsVBobhR
         nxvLMorMYgJ00GDZ30VpvTWmsKOWmA8B+lJF6LBdoWUHueiBSSN4enCzWkRLe+JGDAhi
         rzqe82n7K1E4vXBfjAv2/PbmSCMZNi8Jb9iP/fFtFTMTHy8OIYAbuO4XXQ6iv7//joZ8
         BD/nkyOkl3U5aECKQCplDnxCCJYH23sBpmZxoxR/6ifEX75m60m7ld+Sz4SosaYz1GbQ
         pBpg==
X-Gm-Message-State: AO0yUKWKkoyei9NX43gPcvawNAZdWi0QIwmxQ6vxXXlVz1G1kywUgG2D
        ATNEHQUg9jNp52YoOJBtUMQ=
X-Google-Smtp-Source: AK7set/tPWYOvSzI2PNLiRVAgbMprgirpJ/Vl3FX0JHs3AyE/C/7/zGmSk/qdVivqlP6z8hot1iZMw==
X-Received: by 2002:a7b:cb93:0:b0:3ee:814b:9c39 with SMTP id m19-20020a7bcb93000000b003ee814b9c39mr3574790wmi.18.1679696603097;
        Fri, 24 Mar 2023 15:23:23 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b926:df00:a161:16e2:f237:a7d4? (dynamic-2a01-0c23-b926-df00-a161-16e2-f237-a7d4.c23.pool.telefonica.de. [2a01:c23:b926:df00:a161:16e2:f237:a7d4])
        by smtp.googlemail.com with ESMTPSA id j36-20020a05600c1c2400b003ebf73acf9asm12553045wms.3.2023.03.24.15.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 15:23:22 -0700 (PDT)
Message-ID: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
Date:   Fri, 24 Mar 2023 23:23:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-pwm@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] pwm: meson: add support for S4 chip family
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds pwm support for (at least) the s4 chip family. The extension
is based on the vendor driver that can be found at [0]. There the
version with the new clock handling is called meson-v2-pwm.
Central change is that the clock is now fully provided by the SoC clock
core. The multiplexer isn't any longer part of the pwm block.

This was tested on a sc2-based system that uses the same pwm block.

[0] https://github.com/khadas/linux/blob/khadas-vims-5.4.y/drivers/pwm/pwm-meson.c

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
Adding the amlogic,meson-s4-pwm compatible to the documentation was part
of the yaml conversion already.
---
 drivers/pwm/pwm-meson.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 16d79ca5d..7a93fdada 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -98,6 +98,7 @@ struct meson_pwm_channel {
 struct meson_pwm_data {
 	const char * const *parent_names;
 	unsigned int num_parents;
+	unsigned int ext_clk:1;
 };
 
 struct meson_pwm {
@@ -158,6 +159,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	unsigned int duty, period, pre_div, cnt, duty_cnt;
 	unsigned long fin_freq;
+	int err;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -165,6 +167,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	if (state->polarity == PWM_POLARITY_INVERSED)
 		duty = period - duty;
 
+	if (meson->data->ext_clk) {
+		err = clk_set_rate(channel->clk, 0xffffUL * NSEC_PER_SEC / period);
+		if (err) {
+			dev_err(meson->chip.dev, "failed to set pwm clock rate\n");
+			return err;
+		}
+	}
+
 	fin_freq = clk_get_rate(channel->clk);
 	if (fin_freq == 0) {
 		dev_err(meson->chip.dev, "invalid source clock frequency\n");
@@ -173,10 +183,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
 
-	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
-	if (pre_div > MISC_CLK_DIV_MASK) {
-		dev_err(meson->chip.dev, "unable to get period pre_div\n");
-		return -EINVAL;
+	if (meson->data->ext_clk) {
+		pre_div = 0;
+	} else {
+		pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
+		if (pre_div > MISC_CLK_DIV_MASK) {
+			dev_err(meson->chip.dev, "unable to get period pre_div\n");
+			return -EINVAL;
+		}
 	}
 
 	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
@@ -445,6 +459,10 @@ static const struct meson_pwm_data pwm_g12a_ee_data = {
 	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
 };
 
+static const struct meson_pwm_data pwm_s4_data = {
+	.ext_clk = 1,
+};
+
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8b-pwm",
@@ -478,6 +496,10 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
 		.data = &pwm_g12a_ao_cd_data
 	},
+	{
+		.compatible = "amlogic,meson-s4-pwm",
+		.data = &pwm_s4_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
@@ -493,6 +515,14 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 	for (i = 0; i < meson->chip.npwm; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
 
+		if (meson->data->ext_clk) {
+			snprintf(name, sizeof(name), "clkin%u", i);
+			channel->clk = devm_clk_get(dev, name);
+			if (IS_ERR(channel->clk))
+				return PTR_ERR(channel->clk);
+			continue;
+		}
+
 		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
 
 		init.name = name;
-- 
2.40.0

