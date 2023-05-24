Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5376070FEC5
	for <lists+linux-pwm@lfdr.de>; Wed, 24 May 2023 21:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjEXTwr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 May 2023 15:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjEXTwq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 May 2023 15:52:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97143C0
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 12:52:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51403554f1dso2386838a12.1
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684957964; x=1687549964;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hl1kkCphfbJI88idtjaX2xpMK1X0udpSgx92Bt3FmGI=;
        b=XNoJlpcaIjo8XTFbt/plZPj0Rp3IRj1FYeVMJSveLP/W5C8Myo3bcizGstTbcWXfva
         7MwcHv/LKRD70PvWvDmBdt4auDSF99I334KYCWZlobNth1bz8qpZb1eBmjyjoI9ffPa/
         kj//sYFuiFD0ioI0MgW+V0mhdrJeRxCu7V9YRBDLDsONF7A6P8lu1+dUzyAfDM6lBRLg
         x7hilR8AY8WRm7H+CJADO1oYQybpqKltouEPJDPQ2LC3deg5ijFw67H6jmJNT7V3Ot9v
         lS4yai9ToxDUB7njcUZ/VUp+6wVltSphAOn6n593H76BldvLxipsydVOckOuXDg77jfI
         0LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957964; x=1687549964;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl1kkCphfbJI88idtjaX2xpMK1X0udpSgx92Bt3FmGI=;
        b=dlSKtMQHYphjqUxpDULnshD3BkUw9Hnf4wTOPeMmyg5hGz4bo/eoVOe8CZiff+u+X2
         ae8zc8lCdzcjwsGPxzphO16JO2h8n2Crw4mRnTxOx6beEKoQ8ZBfMdCQvIqs3ZRzai03
         ZeZiULujGdcpQPm7qMzRi0UQIa7hKJmG03b0a3TvMSsqmEmYXmczlwn3kIt1lHHefWyC
         dQo4qk0yxlkz8+bzSRHgWycHxx9SY4Xs9kcdr1qVVLn11yyB5BGLtGKqvC2hm6SVZbbE
         BqtOVDRIHcVZtAPr1OfqJIi9JTuoEY/dmACsIkC2dU1HgNiwe3FTlpMdIN6uhUmkUEm9
         cAGw==
X-Gm-Message-State: AC+VfDytZvDKtmBotDCg5I5GxutoOiGcxEYb6byaYEpyVfKxgBrm80d8
        kyu2e4kzQ+IYDGoZfsXKTfc=
X-Google-Smtp-Source: ACHHUZ7QEbGR8niAlZXQq9UvZeaSVO3i9pUfQXd4Kp36n2cr6kPDx+VAuUubCeIyrzEbJZrRbeH/tg==
X-Received: by 2002:a05:6402:1381:b0:504:8c1a:70db with SMTP id b1-20020a056402138100b005048c1a70dbmr2875364edv.32.1684957964006;
        Wed, 24 May 2023 12:52:44 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c519:9c00:cd4b:d130:35c7:5e08? (dynamic-2a01-0c23-c519-9c00-cd4b-d130-35c7-5e08.c23.pool.telefonica.de. [2a01:c23:c519:9c00:cd4b:d130:35c7:5e08])
        by smtp.googlemail.com with ESMTPSA id r14-20020aa7cb8e000000b005027d31615dsm232772edt.62.2023.05.24.12.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 12:52:43 -0700 (PDT)
Message-ID: <db973d29-1b8d-85f8-5e81-88e200def596@gmail.com>
Date:   Wed, 24 May 2023 21:51:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [PATCH v5 5/6] pwm: meson: don't use hdmi/video clock as mux parent
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
index 1654fdbb0..48dcc44df 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -364,7 +364,7 @@ static const struct pwm_ops meson_pwm_ops = {
 };
 
 static const char * const pwm_meson8b_parent_names[] = {
-	"xtal", "vid_pll", "fclk_div4", "fclk_div3"
+	"xtal", NULL, "fclk_div4", "fclk_div3"
 };
 
 static const struct meson_pwm_data pwm_meson8b_data = {
@@ -372,15 +372,6 @@ static const struct meson_pwm_data pwm_meson8b_data = {
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
@@ -430,15 +421,6 @@ static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
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
@@ -446,7 +428,7 @@ static const struct of_device_id meson_pwm_matches[] = {
 	},
 	{
 		.compatible = "amlogic,meson-gxbb-pwm",
-		.data = &pwm_gxbb_data
+		.data = &pwm_meson8b_data
 	},
 	{
 		.compatible = "amlogic,meson-gxbb-ao-pwm",
@@ -462,7 +444,7 @@ static const struct of_device_id meson_pwm_matches[] = {
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ee-pwm",
-		.data = &pwm_g12a_ee_data
+		.data = &pwm_meson8b_data
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
-- 
2.40.1


