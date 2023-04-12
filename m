Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4E6DFEAA
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 21:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDLTXg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 15:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDLTXf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 15:23:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE166181
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 12:23:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dm2so31658589ejc.8
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 12:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681327413; x=1683919413;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ruCafjyH/3zlOeY8HIt23X9tT9LTYcm24amx/aCjHg=;
        b=NInJHmo5GJ6LGF0P5Ez+b8s/XEnq2XPkad46wmzQwZ6PTlPpTzifRfDv5RUShBT8vR
         +ZCpzsFt+zmm3gY4xPr67LIaxTRan2Cw0w/+boQKu0m25t7oJgVQ8TpTvNt+YbE431J9
         nzMvyXURMKrxVgoBETjFiiDSxQUhWo+kiJpFbx//d9ZXZ05lmOT1mDbRNUpun5jncRla
         VoUa8vewPb19Qsc/mukFUat+KzJHJ558lSjQLhdbhKf6CxrWPp05kQKKjRi9HXWnHwr9
         AwbJGiRGJ6+HkIt/cCa/Cs7eM6PdrW7iqQnxxhIdsfToplUf4S8d7vyx0HFYmXsZMZpS
         en0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681327413; x=1683919413;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ruCafjyH/3zlOeY8HIt23X9tT9LTYcm24amx/aCjHg=;
        b=chztOo8kQQmRmT9TXagAztM1Ysgs9kDULVrKSOSbGhavs5YJpR6cJnLHYxOj6VQkwh
         lQTZROgwYLps5elVp6r/OkD7GFsh+WCHrl/BEGyTRElTXZmIxQ3dolcmMPdSGZkaDEz/
         Aqx9Yk/c8RfS1WWDkB9JP9ei9D34jLIDMnmvSx5+HwQ2S58nBJaLgd/MHa8HiQAtu2pj
         xO0mDhiu+k+/URT1obDDjhHT1QmVkv45nTmtASzt3xR27nSdx+OJlxptcG0lBumDe0tt
         63EVAyyn8o6btK3QTX1EU0vix/VCe5ns+JsTWkxJQJ0IBf3NMbOw8eIFUwmXNjLM7QEP
         wSSQ==
X-Gm-Message-State: AAQBX9e31kS/SRG7PQ5EpUPYKCVcvkpd5WG92m1TZuzQvIzhvZ227Omo
        ZCCeQM4NZ0nezHolbjAGaoU=
X-Google-Smtp-Source: AKy350ZaNzltKbVwQY5y4mdYzMETZFU620vKj2YBlg94g4V/1DYLl3tl/r9TkM4CqIyvyd5EOY4aXQ==
X-Received: by 2002:a17:906:c78a:b0:947:eafc:a738 with SMTP id cw10-20020a170906c78a00b00947eafca738mr7066559ejb.60.1681327412903;
        Wed, 12 Apr 2023 12:23:32 -0700 (PDT)
Received: from ?IPV6:2a02:3100:903d:3d00:b0e7:6bd7:f613:784b? (dynamic-2a02-3100-903d-3d00-b0e7-6bd7-f613-784b.310.pool.telefonica.de. [2a02:3100:903d:3d00:b0e7:6bd7:f613:784b])
        by smtp.googlemail.com with ESMTPSA id f17-20020a170906739100b0094e5679dd2csm1134210ejl.165.2023.04.12.12.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 12:23:32 -0700 (PDT)
Message-ID: <8a7c067d-b121-3bd0-b587-f53861b52bd5@gmail.com>
Date:   Wed, 12 Apr 2023 21:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: [PATCH v3 1/4] pwm: meson: switch to using struct clk_parent_data for
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
References: <29973c8a-2b14-3d0c-bee8-8aff36c265e3@gmail.com>
In-Reply-To: <29973c8a-2b14-3d0c-bee8-8aff36c265e3@gmail.com>
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


