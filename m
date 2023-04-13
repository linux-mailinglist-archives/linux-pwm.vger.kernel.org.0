Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF256E0692
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 07:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjDMFzQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 01:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMFzP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 01:55:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D60A526C
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 22:55:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id si1so4379872ejb.10
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 22:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681365313; x=1683957313;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3BFhesCPS3MCnxkJTTepkOi3pLCS6u2CIR+Btp0g80=;
        b=UY1rGz/BxN4bs6SUt0X6f+sigDkjYzLekFTOwQmYblqNMFcf9ywTlWupAQazCJS4ht
         0+EtcEkOO9cediAWSGfBau1cKYrst7Zfn9K3F8LIYjtXC+zNVCRFTBQzSac95VEfC0iP
         vN1XYHUXy3lK/TzKktKRrJhw5+4G9PNcDEeslUJCoTSwaw219tTF7I+zApa1Rsb68q3T
         +qqSXyXIffq0AGUTRbV0QIGutvLK4SxQ6eA9EMRYvwru2LsfVQysf7QnerHyCO+f6grG
         d/8Cx+rdkI618nK9z8GA9/atucNil8vh2BqbKkErV9EVYgy3rWEvnode9+KLPIVWiCa9
         f2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681365313; x=1683957313;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3BFhesCPS3MCnxkJTTepkOi3pLCS6u2CIR+Btp0g80=;
        b=SxAfRQJ8bp7dLkT01swlMfSE4DSoUUOWFXOICIX9idaXEK2m+WVl4krQEQ6P9nJ39t
         w+xJNGgymbcZ1DAmNfiUDehU0qOP81hTUyVtaQQ5Nxz6ofxaPYuVgCExAcZFyI2/rzLc
         Kd176sJBktexWz8ykszi06MlSTARpx5/IUAkGj6QhpP6sfw+jbX9CgcjqTtTShMXHbW8
         oxxR9zgdB0wVdkOiaY4B0SWVVZv56Z0UyjXoPY+ANpjOkiOsj/zoRLJJnYapszWWG+kf
         nqmXEziqpzfUD8YILOyf0Zs4TD0leqfK/dbNiqiZw7syWJhoyealSybadlNk85WyWKzn
         le3g==
X-Gm-Message-State: AAQBX9fSn9qF7dqr0y6Fy2EkRuWvFAIfE2H5NDZoOMnM16fQwUlBkU2W
        ZajzxEsgVpsBtbujqBR9PsE=
X-Google-Smtp-Source: AKy350YB9J4NKZVFJvWGgzYx30ujMRBfsZBaEiEi9bzs9Lr6CZJEwMHR8dREQTlb2E3m79eP8vwAlg==
X-Received: by 2002:a17:906:398e:b0:94a:97dd:aed9 with SMTP id h14-20020a170906398e00b0094a97ddaed9mr1823241eje.70.1681365312669;
        Wed, 12 Apr 2023 22:55:12 -0700 (PDT)
Received: from ?IPV6:2a01:c22:738e:4400:9dd0:adc5:d6d8:61d8? (dynamic-2a01-0c22-738e-4400-9dd0-adc5-d6d8-61d8.c22.pool.telefonica.de. [2a01:c22:738e:4400:9dd0:adc5:d6d8:61d8])
        by smtp.googlemail.com with ESMTPSA id i3-20020a1709061e4300b0092b8c1f41ebsm423589ejj.24.2023.04.12.22.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 22:55:12 -0700 (PDT)
Message-ID: <2727eab9-28bf-214e-c98d-f119eda20496@gmail.com>
Date:   Thu, 13 Apr 2023 07:49:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: [PATCH v4 1/4] pwm: meson: switch to using struct clk_parent_data for
 mux parents
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
In-Reply-To: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

We'll use struct clk_parent_data for mux/div/gate initialization in the
follow-up patches. As a first step switch the mux from using
parent_names to clk_parent_data.

Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v3:
- move setting mux parent data out of the loop
---
 drivers/pwm/pwm-meson.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 4e5605c9d..6a66d5d58 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -61,6 +61,7 @@
 #define MISC_A_EN		BIT(0)
 
 #define MESON_NUM_PWMS		2
+#define MESON_MAX_MUX_PARENTS	4
 
 static struct meson_pwm_channel_data {
 	u8		reg_offset;
@@ -484,21 +485,27 @@ MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 
 static int meson_pwm_init_channels(struct meson_pwm *meson)
 {
+	struct clk_parent_data mux_parent_data[MESON_MAX_MUX_PARENTS] = {};
 	struct device *dev = meson->chip.dev;
-	struct clk_init_data init;
 	unsigned int i;
 	char name[255];
 	int err;
 
+	for (i = 0; i < meson->data->num_parents; i++) {
+		mux_parent_data[i].index = -1;
+		mux_parent_data[i].name = meson->data->parent_names[i];
+	}
+
 	for (i = 0; i < meson->chip.npwm; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
+		struct clk_init_data init = {};
 
 		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
 
 		init.name = name;
 		init.ops = &clk_mux_ops;
 		init.flags = 0;
-		init.parent_names = meson->data->parent_names;
+		init.parent_data = mux_parent_data;
 		init.num_parents = meson->data->num_parents;
 
 		channel->mux.reg = meson->base + REG_MISC_AB;
-- 
2.40.0


