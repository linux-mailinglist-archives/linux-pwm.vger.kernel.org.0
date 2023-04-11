Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000CB6DE4ED
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 21:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDKT0g (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Apr 2023 15:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKT0f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2023 15:26:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF8312B
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:26:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s2so5389047wra.7
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681241193; x=1683833193;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+z8YpC2eOejAdzfjBHEwDRl9Fr5MgCbUHcvYTd3HmNY=;
        b=aoQupWLGNf4cLI0OgUlJMqZu0kloECrUcXOvi3XOP8Psft1XBcIYdvkJ6U8S2WRfXW
         43V6+2lWgYbQ8Oy96dCdWQAaACs1o0LBbLMzErqucQtDKLzai9Xmo1vnviHDlZ7VKFFa
         Y/WGHSV7Df+9d8jeFsXiY6SY9aiz9p29p+FgwfyjWTqBnbo/pegKw4nccSd0PFtlRCcH
         eS5cH8ZIjrddgo9zFNTFIFoIdRmVT7TJ9JLTt8NkJ8pXwnmA/5bM2dqJ2krGLc8K+UTz
         PVMhe1rqQ5De5sVoh3nZtSuTeiWs4FpDUfiWARX7XC8/vcK+p1oc3daMT1g6QiBUvtJj
         qKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681241193; x=1683833193;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+z8YpC2eOejAdzfjBHEwDRl9Fr5MgCbUHcvYTd3HmNY=;
        b=VWa8gFufxVp4gNgakGrGRZx8+L7f/REcZ2HC/2v6vg6SS82B5MeKUr1b50f6J5nR5r
         Ex7plY+xkh7v4650MdbwkTFBqPBptcTkCwQBU1pRKHiiyTpq9zR/6g4h6+fU360RQmOf
         D6QkSBXkTeXUTBn1Tf5UdfY6cV3wu22PnO3Kgzxi6BCitWd9/reCCMjSe+uVrTOqm15w
         e0a9o3qpSrEfRtDu/UfwW7VR5wO3pP8Dh5mJuEWseH+7Tg0vpeVyKPJogpBFBV/k7Wa2
         esu2qOYgaEhefbN4TM/PC0uIDJUzMc4TgLKlgUn23uJeBPAfifxLEGvy9/RCVcLiv0F3
         1eug==
X-Gm-Message-State: AAQBX9c1MmS5EQ8d8toNCol5RzsRURentU/Mh6yA9iU1IR4Xq4jcA8tP
        JIxsJP2MC27xytmkzzKECso=
X-Google-Smtp-Source: AKy350bOAxztOgN2CwmM2wYn4R8YGgKVKJjv7V726pbvbhBozS+/RaKpacGtWcfjjjjtdkWGsAGSzQ==
X-Received: by 2002:adf:f146:0:b0:2cf:e3d0:2a43 with SMTP id y6-20020adff146000000b002cfe3d02a43mr169952wro.4.1681241193048;
        Tue, 11 Apr 2023 12:26:33 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c4bb:c200:90e3:4731:63e4:d333? (dynamic-2a01-0c23-c4bb-c200-90e3-4731-63e4-d333.c23.pool.telefonica.de. [2a01:c23:c4bb:c200:90e3:4731:63e4:d333])
        by smtp.googlemail.com with ESMTPSA id fm7-20020a05600c0c0700b003f063a709dbsm3898839wmb.2.2023.04.11.12.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 12:26:32 -0700 (PDT)
Message-ID: <d4394f13-b481-ca2e-3ce5-737a7bbc0e3d@gmail.com>
Date:   Tue, 11 Apr 2023 21:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: [PATCH v2 2/4] pwm: meson: don't use hdmi/video clock as mux parent
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

meson_vclk may change the rate of the video clock. Therefore better
don't use it as pwm mux parent. After removing this clock from the
parent list pwm_gxbb_data and pwm_g12a_ee_data are the same as
pwm_meson8b_data. So we can remove them.

Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 52a2104f0..931cf14ca 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -371,7 +371,7 @@ static const struct pwm_ops meson_pwm_ops = {
 };
 
 static const char * const pwm_meson8b_parent_names[] = {
-	"xtal", "vid_pll", "fclk_div4", "fclk_div3"
+	"xtal", NULL, "fclk_div4", "fclk_div3"
 };
 
 static const struct meson_pwm_data pwm_meson8b_data = {
@@ -379,15 +379,6 @@ static const struct meson_pwm_data pwm_meson8b_data = {
 	.num_parents = ARRAY_SIZE(pwm_meson8b_parent_names),
 };
 
-static const char * const pwm_gxbb_parent_names[] = {
-	"xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
-};
-
-static const struct meson_pwm_data pwm_gxbb_data = {
-	.parent_names = pwm_gxbb_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_gxbb_parent_names),
-};
-
 /*
  * Only the 2 first inputs of the GXBB AO PWMs are valid
  * The last 2 are grounded
@@ -437,15 +428,6 @@ static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
 	.num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
 };
 
-static const char * const pwm_g12a_ee_parent_names[] = {
-	"xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
-};
-
-static const struct meson_pwm_data pwm_g12a_ee_data = {
-	.parent_names = pwm_g12a_ee_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
-};
-
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8b-pwm",
@@ -453,7 +435,7 @@ static const struct of_device_id meson_pwm_matches[] = {
 	},
 	{
 		.compatible = "amlogic,meson-gxbb-pwm",
-		.data = &pwm_gxbb_data
+		.data = &pwm_meson8b_data
 	},
 	{
 		.compatible = "amlogic,meson-gxbb-ao-pwm",
@@ -469,7 +451,7 @@ static const struct of_device_id meson_pwm_matches[] = {
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ee-pwm",
-		.data = &pwm_g12a_ee_data
+		.data = &pwm_meson8b_data
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
-- 
2.40.0


