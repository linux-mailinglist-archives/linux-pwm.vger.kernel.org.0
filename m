Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517416DE4EC
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 21:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDKT0f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Apr 2023 15:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKT0e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2023 15:26:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E301125
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:26:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q29so8504982wrc.3
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681241192; x=1683833192;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxWZ3lc7cHgbqUIVxG2SqSCxtmOZkFcO8gtsNb4LbME=;
        b=kkHeH97+ArBF9/0zQysc+2G8LTCn28AvF+hDw4OwXHmtvpeaM4fTSo8zxfu95O/lCy
         dWrQE6QLdS+mnXvTlIy4dtXd9d3BWY9NxW5vnUxbjrKDhuna9QoiwfqbUQQU+nkNo3fo
         bJGFKe3cPzhtPR5YyNTQ41H9G/IuJZ1TNyDRRnT7DucdPVA+lsKBhzSjcrpfCLF056Q9
         oz3CzwUmV/FOxNc8bYKDx3XBF7EZvIvwRBCoYtnhFOOVEikmKIxpDs/l2TIfOks/dPkS
         Sqt+77if3p4ms5pO8SGVAPMm3sU0ixv1mLeOG3A8YCZLPLpGfbcO0+qZB0uChJV93aV7
         ytWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681241192; x=1683833192;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxWZ3lc7cHgbqUIVxG2SqSCxtmOZkFcO8gtsNb4LbME=;
        b=UYoLfTXQxqVwME9oM6iHQaWwMpIOf80aqssKBug0V6RiMD95apW9R3YV6ufFwTz6pY
         k1HMty27h43+qFLS/bHgVrFfHPmxNWOC+kj5T4c77EStFCmFgpC0wyLGo9LMmH6PSgv2
         9W2/W+cEwsNy2rD3onJ+UwYeRYwvg2UwiEClwRczrvp48/lyJDkFkJ6osiyRpvj49SrI
         rZafVlIRvY8CxrykSy6BLybmIvURd7O8nrlPAP5tZB4w7btTndougCDWxYv08Y9hJSrS
         tMcCAAUJUAhs8RIiSvamLL4jUwWXbLuwikhybGXZF/H0SRIueCjY/kCf0v/A/AYa7dfN
         qy3Q==
X-Gm-Message-State: AAQBX9ciKL61IVKhxhAJ0MCM/dcOtH7pkLcJk0wGb+hf+aF/kclt6dhX
        lYT6mYERh3noIy7zQ+Vh77I=
X-Google-Smtp-Source: AKy350Y8UGQNTb1QdJvRPlNvRx/fVmbzC3WA4YTp6Q2H2MzZRPxG1pqPqaNj8p9w7JNf4wE3vQJh3Q==
X-Received: by 2002:adf:e4c1:0:b0:2f4:fcd:98d2 with SMTP id v1-20020adfe4c1000000b002f40fcd98d2mr585544wrm.31.1681241191637;
        Tue, 11 Apr 2023 12:26:31 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c4bb:c200:90e3:4731:63e4:d333? (dynamic-2a01-0c23-c4bb-c200-90e3-4731-63e4-d333.c23.pool.telefonica.de. [2a01:c23:c4bb:c200:90e3:4731:63e4:d333])
        by smtp.googlemail.com with ESMTPSA id h7-20020a05600c314700b003f07ef4e3e0sm4158098wmo.0.2023.04.11.12.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 12:26:31 -0700 (PDT)
Message-ID: <2760498e-23a6-f787-bac2-0460566a995d@gmail.com>
Date:   Tue, 11 Apr 2023 21:22:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: [PATCH v2 1/4] pwm: meson: switch to using struct clk_parent_data for
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
References: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com>
In-Reply-To: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

We'll use struct clk_parent_data for mux/div/gate initialization in the
follow-up patches. As a first step switch the mux from using
parent_names to clk_parent_data.

Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 4e5605c9d..52a2104f0 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -61,6 +61,7 @@
 #define MISC_A_EN		BIT(0)
 
 #define MESON_NUM_PWMS		2
+#define MESON_MAX_MUX_PARENTS	4
 
 static struct meson_pwm_channel_data {
 	u8		reg_offset;
@@ -485,20 +486,27 @@ MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 static int meson_pwm_init_channels(struct meson_pwm *meson)
 {
 	struct device *dev = meson->chip.dev;
-	struct clk_init_data init;
 	unsigned int i;
 	char name[255];
 	int err;
 
 	for (i = 0; i < meson->chip.npwm; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
+		struct clk_parent_data mux_parent_data[MESON_MAX_MUX_PARENTS] = {};
+		struct clk_init_data init = {};
+		int j;
 
 		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
 
+		for (j = 0; j < meson->data->num_parents; j++) {
+			mux_parent_data[j].index = -1;
+			mux_parent_data[j].name = meson->data->parent_names[j];
+		}
+
 		init.name = name;
 		init.ops = &clk_mux_ops;
 		init.flags = 0;
-		init.parent_names = meson->data->parent_names;
+		init.parent_data = mux_parent_data;
 		init.num_parents = meson->data->num_parents;
 
 		channel->mux.reg = meson->base + REG_MISC_AB;
-- 
2.40.0


