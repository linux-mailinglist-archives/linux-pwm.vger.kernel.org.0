Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917786DBDDF
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Apr 2023 00:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDHWuO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Apr 2023 18:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHWuN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Apr 2023 18:50:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD412D7C
        for <linux-pwm@vger.kernel.org>; Sat,  8 Apr 2023 15:50:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9476e2fa157so236889766b.3
        for <linux-pwm@vger.kernel.org>; Sat, 08 Apr 2023 15:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680994211; x=1683586211;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgROFqHHrF+sHdSvsr6ZitI9bmKISd+icEs8t3mjLho=;
        b=gQ1FPxQLSoDt2Fg4pUNjPfNb5O6Zc5rkK3vwWPZln/FD7B0qZUoN4rNjgaX02hkYkR
         N/QnNPWxX3C5I8hLSgUfZm0nnEljoJkAwObftbjZuz14nI7FS/tZkykBU30ImA2O7UO0
         FTDaOiEn9Vnp2xjPkSEoe2cIrHEyXix/qfDXxBr2ez91O2GxqWoooFmvI7h8iWXx97bh
         L0nm2fS3gdFku/57aWUUVQK5rlXkP4mjg/jHcBeTbbUhYgFHsC629Vif12zuSRnuMAot
         ydQOnjZj1Ro3vje2KCXmzHNwmLbogVPsWIJlmQ8qOCc6aoab2uQ5/mMNE/jRNm44NJW6
         TKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680994211; x=1683586211;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VgROFqHHrF+sHdSvsr6ZitI9bmKISd+icEs8t3mjLho=;
        b=zVdM/TnITdwKOOcUWH/m3VuZGTnmSlBNFWO1AsqVVmZDmAs4nF1JRzeN2+BrlQrSFF
         Om1hrZ68b5Qi6XSyVubwFZYzRte8e6stIy4XG/pOiSphqHuLlTg57YHs78Qzvu4wc7xP
         YqGmpADs6x4xBlTIq6SAzbPliCFKxjtrQOBJpXdFxgPPPebgOpG2jQST4hWGdT3UEKSS
         k3t5KYozF28l0E9KNvHL3hmgq9Yt5JJkkIyz2avaJxtflT1xHynW6Dlcp9nkQxtjTSWd
         JixCOsxDbVc/hRgraRKR69rZtM8eFy2D2H/+CQqPMxDm+odqSlww/Z2pegqWcVFHgMGj
         6y4g==
X-Gm-Message-State: AAQBX9dd/5rmtkIPWxLAljqeuOGAuASXtZDV067zcaVYYts8GHc1OANG
        hVUVgV1XwNQ9Q9PyeGRVrXM=
X-Google-Smtp-Source: AKy350Z4S9+mVq2oQP+4xl2jZQEsurFq1RLGvU8tVfU6QJIIYh3e93XfNjIINDJTBzhYnij2GukRMA==
X-Received: by 2002:a05:6402:b09:b0:501:cde5:4cc9 with SMTP id bm9-20020a0564020b0900b00501cde54cc9mr5298550edb.39.1680994210766;
        Sat, 08 Apr 2023 15:50:10 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c57c:9500:b062:7c54:caa1:b5c1? (dynamic-2a01-0c23-c57c-9500-b062-7c54-caa1-b5c1.c23.pool.telefonica.de. [2a01:c23:c57c:9500:b062:7c54:caa1:b5c1])
        by smtp.googlemail.com with ESMTPSA id u6-20020a50d506000000b004c13fe8fabfsm3317332edi.84.2023.04.08.15.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 15:50:10 -0700 (PDT)
Message-ID: <e7a95baf-5f9d-be56-93dc-82ca83b69c7a@gmail.com>
Date:   Sun, 9 Apr 2023 00:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] pwm: meson: fix axg ao mux parent order
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

This fix is basically the same as 9bce02ef0dfa ("pwm: meson: Fix the
G12A AO clock parents order"). Vendor driver referenced there has
xtal as first parent also for axg ao. Mux parents for g12_ao_ab
are now the same as for axg ao, so we can remove the entry.

Fixes: bccaa3f917c9 ("pwm: meson: Add clock source configuration for Meson-AXG")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index b5c746fab..2cafec827 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -381,7 +381,7 @@ static const struct meson_pwm_data pwm_axg_ee_data = {
 };
 
 static const char * const pwm_axg_ao_parent_names[] = {
-	"aoclk81", "xtal", "fclk_div4", "fclk_div5"
+	"xtal", "aoclk81", "fclk_div4", "fclk_div5"
 };
 
 static const struct meson_pwm_data pwm_axg_ao_data = {
@@ -389,15 +389,6 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
 	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
 };
 
-static const char * const pwm_g12a_ao_ab_parent_names[] = {
-	"xtal", "aoclk81", "fclk_div4", "fclk_div5"
-};
-
-static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
-	.parent_names = pwm_g12a_ao_ab_parent_names,
-	.num_parents = ARRAY_SIZE(pwm_g12a_ao_ab_parent_names),
-};
-
 static const char * const pwm_g12a_ao_cd_parent_names[] = {
 	"xtal", "aoclk81",
 };
@@ -434,7 +425,7 @@ static const struct of_device_id meson_pwm_matches[] = {
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
-		.data = &pwm_g12a_ao_ab_data
+		.data = &pwm_axg_ao_data
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
-- 
2.40.0

