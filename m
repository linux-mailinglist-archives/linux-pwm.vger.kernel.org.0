Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031306E83C9
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Apr 2023 23:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDSVb3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Apr 2023 17:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDSVbW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Apr 2023 17:31:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82050A5C8
        for <linux-pwm@vger.kernel.org>; Wed, 19 Apr 2023 14:31:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ud9so1704345ejc.7
        for <linux-pwm@vger.kernel.org>; Wed, 19 Apr 2023 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681939862; x=1684531862;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdlVVXg/ZDVV5S2Y7DqG2qcaIisv4Xg/5TG8KpoazMI=;
        b=Mksh8Hgb6Cu6CSOGNzvfNY33gkMQvzctZxYJ+oI0EmzpEOiH61SRTQbI6b+y8um2tE
         a6F0mCIaqrOT/o/q40jLcjvbAaJaSyihDMx/2nyAdcF9yI87Yu8gBWUu1d45ZGbRz4lO
         VuXdPxzCeKjQCpE5TPhpLR5J9G6Aj77H4T3pfgQE8pwO1rxFlWVREvX731MPHVOcDoCN
         TXvfgFNvX52/60wfiHd8XeB8ndEZd4UBZaQqNH61oP/ZbQfCSJJBaP7uLe4dUrudt2wc
         RY5xsgevQtwSRhdp8Iaw/Xn0hQRGVYrcqUwvzGi1n9ELtlxvdAmLp79518L1y5GKsqz/
         vt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939862; x=1684531862;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MdlVVXg/ZDVV5S2Y7DqG2qcaIisv4Xg/5TG8KpoazMI=;
        b=gmrxnyePR0lByJ15/OHQTrJNFRfDGhmccY5GnjlLEkVzLSzD1hxJIKelD/Abn4zqBK
         Z/fofMIqH3VAz9KxOq03jnWkuB2vELI6qYEMpq+XkTz1pUs3p0V0u2ezpFfnfcWiz4+b
         G1VTiTqE8zR8ZpCtIq4Mu/yWAsR/LWFgQgRDvbR4CpnOIrOZ1O7iMI51mv314j8+mIXt
         vl/BmLgT3CvD0KlQNmd2Dv9geTkZ8HB5SJ3wxnRDY0MBBnu8GNcAiS07Tp13GxKI7n96
         yzs3LOBGf0NXeTQ+ssDlIUb/mD1A/ELi44cM3obRksyGVqoBub32qQqH8ISnqFj/FoUs
         u6QQ==
X-Gm-Message-State: AAQBX9cIj4Vvau/EHB6ibHCwqhrbMa9RcE/SgKxiDSUrlx7VZtz6BBuK
        zkJkGTva2tkGWzP5zzhb6NQ=
X-Google-Smtp-Source: AKy350ZleavQgkE/Gu30oz7ELytf+JQ1woNamGjopo1D5tmuCezKZMrWw904ZpcaQrn3VlUlejRPPw==
X-Received: by 2002:a17:906:4e55:b0:921:7e42:2777 with SMTP id g21-20020a1709064e5500b009217e422777mr18918154ejw.69.1681939861834;
        Wed, 19 Apr 2023 14:31:01 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9499:ff00:939:7c23:9a91:9bcd? (dynamic-2a02-3100-9499-ff00-0939-7c23-9a91-9bcd.310.pool.telefonica.de. [2a02:3100:9499:ff00:939:7c23:9a91:9bcd])
        by smtp.googlemail.com with ESMTPSA id bf18-20020a0564021a5200b00506b88e4f17sm11009edb.68.2023.04.19.14.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 14:31:01 -0700 (PDT)
Message-ID: <5a5920db-4c32-25e8-d1e3-bd2f724dd242@gmail.com>
Date:   Wed, 19 Apr 2023 23:30:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
        linux-pwm@vger.kernel.org
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] pwm: meson: simplify calculation in meson_pwm_get_state
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

I don't see a reason why we should treat the case lo < hi that
different and return 0 as period and duty_cycle. Let's handle it as
normal use case and also remove the optimization for lo == 0.
I think the improved readability is worth it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5732300eb..3865538dd 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -351,18 +351,8 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
 	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
 
-	if (channel->lo == 0) {
-		state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
-		state->duty_cycle = state->period;
-	} else if (channel->lo >= channel->hi) {
-		state->period = meson_pwm_cnt_to_ns(chip, pwm,
-						    channel->lo + channel->hi);
-		state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm,
-							channel->hi);
-	} else {
-		state->period = 0;
-		state->duty_cycle = 0;
-	}
+	state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
+	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
 
 	state->polarity = PWM_POLARITY_NORMAL;
 
-- 
2.40.0

