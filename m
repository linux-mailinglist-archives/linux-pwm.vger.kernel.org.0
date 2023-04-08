Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6386DBCFA
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Apr 2023 22:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjDHUoD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Apr 2023 16:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDHUoC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Apr 2023 16:44:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AF76188
        for <linux-pwm@vger.kernel.org>; Sat,  8 Apr 2023 13:44:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sg7so15639087ejc.9
        for <linux-pwm@vger.kernel.org>; Sat, 08 Apr 2023 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680986639; x=1683578639;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7eafkPVOocoktXz8vsbR8n0IOKWvGAP/Nz2b8qlhl4=;
        b=qpt8z+cFUm9GfNlmqH8F127hBYR+ZQcDTemrzh+Q5YApYzLG/nih+IJVTQVvs5Sww3
         iTRv6GmpRx7xJPVciDhsX3VxhFDkfeQyVLkJdGdgetrLYjpoOxumRTeUn/8DfpcQliXo
         gp5HkeDvE+R1Oh93YBibYlzao3vVmmX8RxbHqIqzLRpnxVG/XO1weKJnaKMIqtQnHknK
         /mTng/YJ6wMAL/JtA89aicuA/uRDuEUZav3vM9bbZVDet7Ih8tx6yJxkUN39OqJ+ntoF
         1+ugcc6xrHTpzRxCZJEwtYHSaBixFr0JLlLwZoA8NpJwB9ULvELT58jxnb6lm6Afa0pt
         WDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680986639; x=1683578639;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7eafkPVOocoktXz8vsbR8n0IOKWvGAP/Nz2b8qlhl4=;
        b=r0UPSVfSKV1uRg9RD8/9QdOk8+mSdv+5HoXYElvSqCxiyx/FvoXHp4T1bI2ogQH7L2
         KIKFuuowwe9FcUBxIOzij2MfI0FnvanK+Mg7gOsC1tbjOFefpvEkmiPb0ka7ZF51vAgC
         GfMEfwAM7HBvKquD52AWi1OXpifdOOp1s70LXV6mjQLtlz/f+Dtwki9siuiNIkwt4HZm
         6wh6dpIEUkbnK4V10ACvn6Ev7OfToOkK62i7omq3pCHuIxwu3yPw5Zr22gPsCGTocJvh
         vuIn6l7V8+LrNUkixUE29tMvTSOPQ33c/yv7pm+g3wyz3+eBCZ+Xw97vE2BV51GbKQ9a
         KRiQ==
X-Gm-Message-State: AAQBX9f5FraAERNHerMCC5wHRPv06Rf6g7SqYs1zgMUP0COZZW3DrQWH
        FgsWQwqWMRwurrHJZHmQBwA=
X-Google-Smtp-Source: AKy350abkQTtebQwFTHN6NO3HN0ZJfnYc2YmtKA6dvx8wYR/7TzlImVlrKoSpVzM9DgY3kJpOaQafw==
X-Received: by 2002:a17:906:4812:b0:947:79b3:c2fa with SMTP id w18-20020a170906481200b0094779b3c2famr3014123ejq.17.1680986639229;
        Sat, 08 Apr 2023 13:43:59 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c57c:9500:b062:7c54:caa1:b5c1? (dynamic-2a01-0c23-c57c-9500-b062-7c54-caa1-b5c1.c23.pool.telefonica.de. [2a01:c23:c57c:9500:b062:7c54:caa1:b5c1])
        by smtp.googlemail.com with ESMTPSA id s12-20020a17090699cc00b008ec4333fd65sm3429717ejn.188.2023.04.08.13.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 13:43:58 -0700 (PDT)
Message-ID: <a3fb613f-73d4-c9c7-f48f-ffd79fa654aa@gmail.com>
Date:   Sat, 8 Apr 2023 22:43:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: [PATCH 2/2] pwm: meson: omit video/hdmi clock as mux parent
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
References: <275c72a8-b9cb-e675-f1c0-4da658c3f98e@gmail.com>
In-Reply-To: <275c72a8-b9cb-e675-f1c0-4da658c3f98e@gmail.com>
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

meson_vclk may change the rate of the video clock. Therefore better
don't use it as pwm mux parent. After removing this clock from the
parent list pwm_gxbb_data and pwm_g12a_ee_data are the same as
pwm_meson8b_data. So we can remove them.

Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 9ec96c926..b5c746fab 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -99,6 +99,7 @@ struct meson_pwm_channel {
 struct meson_pwm_data {
 	const char * const *parent_names;
 	unsigned int num_parents;
+	bool omit_video_clock_parent;
 };
 
 struct meson_pwm {
@@ -348,21 +349,13 @@ static const struct pwm_ops meson_pwm_ops = {
 };
 
 static const char * const pwm_meson8b_parent_names[] = {
-	"xtal", "vid_pll", "fclk_div4", "fclk_div3"
+	"xtal", "fclk_div4", "fclk_div3"
 };
 
 static const struct meson_pwm_data pwm_meson8b_data = {
 	.parent_names = pwm_meson8b_parent_names,
 	.num_parents = ARRAY_SIZE(pwm_meson8b_parent_names),
-};
-
-static const char * const pwm_gxbb_parent_names[] = {
-	"xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
-};
-
-static const struct meson_pwm_data pwm_gxbb_data = {
-	.parent_names = pwm_gxbb_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_gxbb_parent_names),
+	.omit_video_clock_parent = true,
 };
 
 /*
@@ -414,15 +407,6 @@ static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
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
@@ -430,7 +414,7 @@ static const struct of_device_id meson_pwm_matches[] = {
 	},
 	{
 		.compatible = "amlogic,meson-gxbb-pwm",
-		.data = &pwm_gxbb_data
+		.data = &pwm_meson8b_data
 	},
 	{
 		.compatible = "amlogic,meson-gxbb-ao-pwm",
@@ -446,7 +430,7 @@ static const struct of_device_id meson_pwm_matches[] = {
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ee-pwm",
-		.data = &pwm_g12a_ee_data
+		.data = &pwm_meson8b_data
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
@@ -480,6 +464,9 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		init.parent_names = meson->data->parent_names;
 		init.num_parents = meson->data->num_parents;
 
+		if (meson->data->omit_video_clock_parent)
+			channel->mux.table = (u32[]){ 0, 2, 3 };
+
 		channel->mux.reg = meson->base + REG_MISC_AB;
 		channel->mux.shift =
 				meson_pwm_per_channel_data[i].clk_sel_shift;
-- 
2.40.0


