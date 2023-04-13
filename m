Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10766E0693
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 07:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDMFzR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 01:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDMFzQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 01:55:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73D24ED8
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 22:55:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94e102534d6so186007166b.2
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 22:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681365314; x=1683957314;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8NswKnCbOdRsUceWkVVSA/1Vuid+dbN+D3gtyr4zCs=;
        b=G5OuamML2e2k2PBZmSqIPjldSRvz5DISmAjF4XfMVNm/ILZbJLWmpk8lH31W5WuIHs
         INC90/UdTi9b1ZfwrGzPJ4uHFRQXFbsReeCvNAR5hegwlvazs4PBJkW5z+c8NiEkZ1Bk
         eLlrDULpPmXH34ncIabbWxtdzIn5OfrD4C5+bkeytavYkziNO+AIkkooAXtNAWYtRHrX
         iHWlgxtyCY8b9EZ0CQiyzok00viM8NEgnPwBzLm4Ba5rXAo3Ei5eRPk/NYPOBNMca9o/
         SHKpwSHQ5Qkv1Ovkc8A8Exsk3m1WN9B7n1hDX1WN0PzEg4dt4Y7zXyEnER27V220S4MH
         WrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681365314; x=1683957314;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8NswKnCbOdRsUceWkVVSA/1Vuid+dbN+D3gtyr4zCs=;
        b=E6NEecr8P0uIu9fRzx3Cg9JFl0krvbE0g33M/UATX3wNGGCpM73Id21q6QEakpKoiW
         O95tCY61qoCIuzj8a+F9YfSOI+bqFe2kq8sHl6oYWbMFY8nHXs0pwuYUAncUuwfDHRNb
         BJw9My0QoR/0NV2yU37sU/+7gOjwJkMd9ZjFOhu5vz3OUCZJPCYMYRR3SHVnPsdbspZm
         2gboBedcRgbFYezIQ9x96AisIrq8b1rW/lP573BkYStGdytJ49b0u0Pge5oz/oxY71UZ
         jDVse1t8ijgY9cF1fQAnbR0pYaATGn1VG/3arPjs0j3IOG/aG6fyh4MXW5oFsvYBw8zD
         SJyw==
X-Gm-Message-State: AAQBX9cM+MUO6cHtNPkSCyaXj8tQ3XFqqA/mToNXmwopREZDyGZXoM/8
        pOyU167Bn06s9c28XXGj4wc=
X-Google-Smtp-Source: AKy350YjmHMOR5Hjn7mH/FbFFzlgAUBBWmQNc4XPLT0P2ICLxhln8QaWVhwY8vIi747hOBiblHnnyA==
X-Received: by 2002:a05:6402:4d9:b0:504:b177:3eee with SMTP id n25-20020a05640204d900b00504b1773eeemr1107791edw.33.1681365313955;
        Wed, 12 Apr 2023 22:55:13 -0700 (PDT)
Received: from ?IPV6:2a01:c22:738e:4400:9dd0:adc5:d6d8:61d8? (dynamic-2a01-0c22-738e-4400-9dd0-adc5-d6d8-61d8.c22.pool.telefonica.de. [2a01:c22:738e:4400:9dd0:adc5:d6d8:61d8])
        by smtp.googlemail.com with ESMTPSA id y2-20020aa7ccc2000000b004c2158e87e6sm337648edt.97.2023.04.12.22.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 22:55:13 -0700 (PDT)
Message-ID: <71ae7fd9-f2da-c483-fd64-bf397c6f7bb3@gmail.com>
Date:   Thu, 13 Apr 2023 07:50:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: [PATCH v4 2/4] pwm: meson: don't use hdmi/video clock as mux parent
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The meson_vclk code from the display driver may change the rate of the
video clock. Therefore better don't use it as pwm mux parent.
After removing this clock from the parent list pwm_gxbb_data and
pwm_g12a_ee_data are the same as pwm_meson8b_data. So we can remove
them.

Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v4:
- improve commit message
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


