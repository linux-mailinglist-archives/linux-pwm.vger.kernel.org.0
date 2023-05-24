Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E7570FEC4
	for <lists+linux-pwm@lfdr.de>; Wed, 24 May 2023 21:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbjEXTwq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 May 2023 15:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEXTwp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 May 2023 15:52:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D2BB
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 12:52:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso2895337a12.0
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684957963; x=1687549963;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3eG2syH0BhFk7l81W2r9jp4pFx0n58Jnrg59ebu1LHI=;
        b=c9xjDb20x9sv/xOAq5qD7rkWgjz4K3MhMe0d0o10cron/fCjhkbanF0ArSKeX54RC3
         hQTerh7+l8ePSNg16oIX7ibcLUedyB4vrDRz3H1E7qJS3oWXbZZCliBEU5xmOCNklSLA
         eLb0dFycCcsg/SfbqfhHC2Fqshhda3JwRuZASoOIaZ5GKF3HE0aEV1hgKwLiQHTNQpzu
         xHamvoUMqFVViyaaTzsQ62XC3z6Jg6108OC2jfSWYQNxixu/WgSzmkhwD6TO+N4fesJC
         121or4KTfn2fPU0ecGiCD9pAtuQhJDMnuR3vH5LYBWwdFNqyY8SIAbEz06T8elQ48W2a
         z+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957963; x=1687549963;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eG2syH0BhFk7l81W2r9jp4pFx0n58Jnrg59ebu1LHI=;
        b=Ffx0viNFIc1KLbx37JxYA3XoCkmNFblaj0KQAJQnZj7YOltvz3ZTCkr7d4mUax+5cT
         phNyvXhqvHCfbRwyqC7GNYlJ3cuT4jJgQ5pu/KAzGFVx0w3dOLILfuuw/qQ72XhuMbF5
         8PT9bF/8bfC1F+aweX5Itvb5pSeu0zGBrGo5holg4GFLwcNnpsoanBj1fj/mHkMutalz
         ndvAM8WoIDIhhspP+guQcdznyNnsAJOs4XyY0hiQTClV9zHJ68w7u4lav8vXfAuUDUXR
         Vq+RYI1H4hmHkKUF2+NXVnPyPrRp+dgpEd/egvAIIE4SgJ8NZcuO0jAVTRIe3RR1V+BS
         ijVw==
X-Gm-Message-State: AC+VfDxkIU30aG5Q28C2IJ85r5NGxKwTjFHZsxlKx0qjJ0tF7x/P/3m1
        8cn5Fl7NGqqBz0vESMCtB+I=
X-Google-Smtp-Source: ACHHUZ5o4LbgBZPqSOoHI0mb/Xd2/MbyIzIlwOY6bt7Na5w8qSFaO2NGBSYPsfqGeLYhssYHMbq94Q==
X-Received: by 2002:aa7:dd10:0:b0:510:82b4:844d with SMTP id i16-20020aa7dd10000000b0051082b4844dmr2740318edv.2.1684957962851;
        Wed, 24 May 2023 12:52:42 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c519:9c00:cd4b:d130:35c7:5e08? (dynamic-2a01-0c23-c519-9c00-cd4b-d130-35c7-5e08.c23.pool.telefonica.de. [2a01:c23:c519:9c00:cd4b:d130:35c7:5e08])
        by smtp.googlemail.com with ESMTPSA id o2-20020a056402038200b00506987c5c71sm233641edv.70.2023.05.24.12.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 12:52:42 -0700 (PDT)
Message-ID: <63e33220-0765-0e04-ef34-fea81e8fa347@gmail.com>
Date:   Wed, 24 May 2023 21:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [PATCH v5 4/6] pwm: meson: switch to using struct clk_parent_data for
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
        linux-pwm@vger.kernel.org,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
References: <aa498590-261c-4ada-63ff-8d7aaeec0932@gmail.com>
In-Reply-To: <aa498590-261c-4ada-63ff-8d7aaeec0932@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index aad4a0ed3..1654fdbb0 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -61,6 +61,7 @@
 #define MISC_A_EN		BIT(0)
 
 #define MESON_NUM_PWMS		2
+#define MESON_MAX_MUX_PARENTS	4
 
 static struct meson_pwm_channel_data {
 	u8		reg_offset;
@@ -477,21 +478,27 @@ MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 
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
2.40.1


