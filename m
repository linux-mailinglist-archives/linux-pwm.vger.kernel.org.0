Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9D86DFEAB
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDLTXi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 15:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDLTXh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 15:23:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D46181
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 12:23:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q23so22076082ejz.3
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 12:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681327414; x=1683919414;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gzoR5eTjdX6x0tTj8Yg9Hg0mvL/Rg2ipc11h9oGPMg=;
        b=LnifDVanznGfp5EnwOx7zenvrF0sDNVcbMgrnopS6RNAw4RLaIh/r4M2FVUVebcw45
         PWNwif+mNd6fiildq6OyAeG7MLTY7wJdK6YkuSLBxT59ImqkmdpjxQSnDdAGRN3Mw1oy
         /OLgqkfHWVlDyoA7RgQoiVSfVMy9jW4fc15sJLKRnsfYHJpcwBNFtzhTwqzW1PZqpc+/
         8HE1Kwjg9UWWcxjnlzrlhk75xIQ0giBdsZ5C14P3RuKwtd2oe9u4pH44VMmkWM5AyoIa
         yaSLQRqCRTUllbAN5doEIVRMVf90SfVBls54O0rWaNyawChToDj9tDu16YRzdnm84QNm
         gTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681327414; x=1683919414;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gzoR5eTjdX6x0tTj8Yg9Hg0mvL/Rg2ipc11h9oGPMg=;
        b=grYB3mQzFFqrV8fiAytszjK/VH/UnS0b1ryJM69KHipOs/QGdCgpAE/8a3NUB4tYCy
         Kz9Agb0F6DHPv17yMMqTI2eettSVtnPMqmYaVxhp18qcJKu5RR8lAutJ2tbYoxzNyPTU
         MiF9NxB5KAZJSuOx9k4a/V8VTNeoXE7uaRCWdZ/xAtv7unCJ24kstsgK0uqIASDylbu5
         0vab8us+i/sct9s3DI2Au02HcatIX/T7zhGvbO3ndEEEphSIYustpnR96U9MiDcpXrGN
         Ba2RJP1LRoCJZMl8MYhzbRIsjSeATK60X89s2MYtaOM2bHcgsqPTnj7tx/krqrsX185I
         FLgg==
X-Gm-Message-State: AAQBX9ehJS5+rOr3OH9FYnXP+CzLEbSHlewKJbk7pPngrhsqcoMDJfOc
        dCgWJCzeq/DmNiXeg8/X3ZM=
X-Google-Smtp-Source: AKy350Z51bocLFO+NnEa5ejX6/IQ0VwXAA/I9gDLX46W1cmh+Jj2fQscv9ChmTeGyQ2XEsgLshUQbw==
X-Received: by 2002:a17:906:cc87:b0:948:d1af:3a11 with SMTP id oq7-20020a170906cc8700b00948d1af3a11mr7143768ejb.50.1681327414362;
        Wed, 12 Apr 2023 12:23:34 -0700 (PDT)
Received: from ?IPV6:2a02:3100:903d:3d00:b0e7:6bd7:f613:784b? (dynamic-2a02-3100-903d-3d00-b0e7-6bd7-f613-784b.310.pool.telefonica.de. [2a02:3100:903d:3d00:b0e7:6bd7:f613:784b])
        by smtp.googlemail.com with ESMTPSA id mb8-20020a170906eb0800b0094a9f434fc2sm3196299ejb.176.2023.04.12.12.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 12:23:33 -0700 (PDT)
Message-ID: <8c6ac288-a59d-7c51-aced-3dbcfa828cdd@gmail.com>
Date:   Wed, 12 Apr 2023 21:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: [PATCH v3 2/4] pwm: meson: don't use hdmi/video clock as mux parent
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
index 6a66d5d58..2a86867c1 100644
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


