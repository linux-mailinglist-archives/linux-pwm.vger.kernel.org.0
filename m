Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE070FEC3
	for <lists+linux-pwm@lfdr.de>; Wed, 24 May 2023 21:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjEXTwp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 May 2023 15:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEXTwo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 May 2023 15:52:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A04C0
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 12:52:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso2669237a12.2
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684957961; x=1687549961;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=huiHW4dncLR47flGGAupi0WrSV1QYNNVKtZqQryUTzY=;
        b=dsrlahShI+oOFmQGiaxR6DL1/8uRWGER0QU0YNaZMN0E84+iFYiQAjqDVpxTPe6ymI
         C9JJIySL6OJj3yOF9TrvuEMiL08h1tANYfc2EEUce4QDUgl/WBh2flHOsPrWK9HKA4sO
         m+BNKNFRpHUjVGREE+Ja70P5Dk7oid7btIO9Avy47mFNMcv/6Eskinmyxoa4riz2xpZb
         nXlUbPJae8kmsvcjy9IuRIX7Qvz+ffAXKLbONIQX2NTlWxCIteBerkHgSQZPSgDf9TsI
         2bduq9qoZe/7RnK4Si7rt4eZPs1RApQq5qHAxAtsq7hqbyWa02L7vnVXD7riM1DYbdIE
         U8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957961; x=1687549961;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huiHW4dncLR47flGGAupi0WrSV1QYNNVKtZqQryUTzY=;
        b=iZ/n9itF8ISrcePZma9IPR1GB1Q7MZouqVop3Mdcmv9sfxNVWaVc58IEKDnR6VWp02
         F49xHiLItWB09RqadszpZsMdRxeFDrsT+IBUbuTyf7oDfCzZf8fb2Ppsx8gl1/wI/rYn
         scj/pRw97Y0oqYrmcTzzlYhyDef2fKvbYeRD7SBsRc2oPzRQQaaUIhbdfTmSDM8PBU8+
         /bdchHWzqjLpaqiAhKPGCUFux/KN1jwJ85CEBw5fh8CbKvsOeRTTew5EWPC6hHHAogj2
         xUHZgZAJoRfiO490/Qo4yk4dK61jTUmnxvqU5kNUaYE4ZFsD670GYjrVaKGvFxMTdQxW
         iHdg==
X-Gm-Message-State: AC+VfDwmmfyybapjITiROf0H3YjPWnLuL8HQeJZjaypQFx9NnvIKQxE4
        HYtuZ4dWbsImwxaCEEDXr9Y=
X-Google-Smtp-Source: ACHHUZ5R3W40IgcQ1r4eOjPc+CNdCENjaL837ZQ/cOoRzFvhp9Lo1Fu9x7WUx6yT7JP3w8IPi8KeEA==
X-Received: by 2002:aa7:df0d:0:b0:510:b636:4073 with SMTP id c13-20020aa7df0d000000b00510b6364073mr2698727edy.3.1684957961621;
        Wed, 24 May 2023 12:52:41 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c519:9c00:cd4b:d130:35c7:5e08? (dynamic-2a01-0c23-c519-9c00-cd4b-d130-35c7-5e08.c23.pool.telefonica.de. [2a01:c23:c519:9c00:cd4b:d130:35c7:5e08])
        by smtp.googlemail.com with ESMTPSA id d8-20020aa7c1c8000000b0050bc6983041sm236985edp.96.2023.05.24.12.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 12:52:41 -0700 (PDT)
Message-ID: <c6d59480-df25-9244-82ec-fcd26dbe5022@gmail.com>
Date:   Wed, 24 May 2023 21:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [PATCH v5 RESEND 3/6] pwm: meson: remove not needed check in
 meson_pwm_calc
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

period >= duty implies that cnt >= duty_cnt. We verified before
that cnt <= 0xffff, therefore we can omit the check here.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 33107204a..aad4a0ed3 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -204,12 +204,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		channel->hi = 0;
 		channel->lo = cnt;
 	} else {
-		/* Then check is we can have the duty with the same pre_div */
 		duty_cnt = div64_u64(fin_freq * duty, NSEC_PER_SEC * (pre_div + 1));
-		if (duty_cnt > 0xffff) {
-			dev_err(meson->chip.dev, "unable to get duty cycle\n");
-			return -EINVAL;
-		}
 
 		dev_dbg(meson->chip.dev, "duty=%llu pre_div=%u duty_cnt=%u\n",
 			duty, pre_div, duty_cnt);
-- 
2.40.1


