Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFAB6F5F82
	for <lists+linux-pwm@lfdr.de>; Wed,  3 May 2023 21:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjECT6X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 May 2023 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjECT6W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 May 2023 15:58:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8EA4C29
        for <linux-pwm@vger.kernel.org>; Wed,  3 May 2023 12:58:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so5460183a12.1
        for <linux-pwm@vger.kernel.org>; Wed, 03 May 2023 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683143900; x=1685735900;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwruGZFr/+VxvRHZ7yoTbI/FMSH+WcULSX9JkVPhf6I=;
        b=LZzEDGQBdN0Ba4ItabfKCKinA6jrql6QSKIWGlE4TnmU/20Lfq9hcqaU2kE75LIHdV
         wuLaFv1b6fKVPXvJ7f6pVNOP0Sy688l7nZYCK9Ye19Ecd3SNYtuEhFIMoPVl8RI+xauw
         c2lhU+BZbPfmxMsPFpWSvdTBVwWx3qdZ1jyajVmKurty/xp7FxbR4wH7cIZdHgdF/7/f
         j0quAh0w7Fpl9z8M0rBeABgqpISTajGv0f86ICak+zFzrC22HdkRY8Oy9H4C+NJxWi81
         0BzwZjzQdHhozMSnTuMfnwZGryinrV1+qNFDVtvXmzvzqHtoHYrDjpB+xX2gyehngUU2
         lU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683143900; x=1685735900;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SwruGZFr/+VxvRHZ7yoTbI/FMSH+WcULSX9JkVPhf6I=;
        b=GvAkWw6nuPsrPjHPWXRGovsg/ByKcg3EUsg/MSZzvjfYUaB/+TNqJs94BJfaQjKAfO
         AvuX6Nm4pKddNXd1WZRWXmkPG+DBUcxUK9g7xcwWQPleShgaR1hxLEMvTY+pnqYuPq/A
         vIUQT+p7eZGTQWk2BjCDw4rQ97dl8pLzd6gB9k5P62KDZabPfjEX/bwfVPjLdurDbYx2
         33pIid/ft/lSXTsda09c2MluiLUEz/85jbmiMhv3NaCTYW4vgwQBUz5FFEiTDVe+xsu0
         FAiknPQj0n9Ex1F+9athhyMSCpFzFX7Kn1Mmis3CFatW++03sgdOU32YvppjBMP4b3Wn
         GiGw==
X-Gm-Message-State: AC+VfDyOlv+Mdk7itMCNcw7ypuNc9F4GJKoJL0vuIKaPO0IYMiFQu3EG
        XS+sOo9Xf6GccfDJDQgqHsbaM+YUS5g=
X-Google-Smtp-Source: ACHHUZ5UwFn6M+NdYUwjvdBLmLzJCzCqZCqLFidH7kTshROl2xAOI5Z97rE2fesMcCV1t98Bf0iGTw==
X-Received: by 2002:aa7:c849:0:b0:506:83e7:8c6c with SMTP id g9-20020aa7c849000000b0050683e78c6cmr11577422edt.10.1683143899499;
        Wed, 03 May 2023 12:58:19 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7b1d:3100:e5d3:5790:75fc:741b? (dynamic-2a01-0c22-7b1d-3100-e5d3-5790-75fc-741b.c22.pool.telefonica.de. [2a01:c22:7b1d:3100:e5d3:5790:75fc:741b])
        by smtp.googlemail.com with ESMTPSA id e6-20020aa7d7c6000000b004af6c5f1805sm1048055eds.52.2023.05.03.12.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 12:58:18 -0700 (PDT)
Message-ID: <1d1a8ede-e789-bc4d-2dcd-9d06d2df4061@gmail.com>
Date:   Wed, 3 May 2023 21:58:17 +0200
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
Subject: [PATCH] pwm: pwm-meson: fix handling of period/duty if greater than
 UINT_MAX
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

state->period/duty are of type u64, and if their value is greater than
UINT_MAX, then the cast to uint will cause problems. Fix this by
changing the type of the respective local variables to u64.

Fixes: b79c3670e120 ("pwm: meson: Don't duplicate the polarity internally")
Cc: stable@vger.kernel.org
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 3865538dd..33107204a 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -156,8 +156,9 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	unsigned int duty, period, pre_div, cnt, duty_cnt;
+	unsigned int pre_div, cnt, duty_cnt;
 	unsigned long fin_freq;
+	u64 duty, period;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -179,19 +180,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
 
-	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
+	pre_div = div64_u64(fin_freq * period, NSEC_PER_SEC * 0xffffLL);
 	if (pre_div > MISC_CLK_DIV_MASK) {
 		dev_err(meson->chip.dev, "unable to get period pre_div\n");
 		return -EINVAL;
 	}
 
-	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
+	cnt = div64_u64(fin_freq * period, NSEC_PER_SEC * (pre_div + 1));
 	if (cnt > 0xffff) {
 		dev_err(meson->chip.dev, "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
+	dev_dbg(meson->chip.dev, "period=%llu pre_div=%u cnt=%u\n", period,
 		pre_div, cnt);
 
 	if (duty == period) {
@@ -204,14 +205,13 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		channel->lo = cnt;
 	} else {
 		/* Then check is we can have the duty with the same pre_div */
-		duty_cnt = div64_u64(fin_freq * (u64)duty,
-				     NSEC_PER_SEC * (pre_div + 1));
+		duty_cnt = div64_u64(fin_freq * duty, NSEC_PER_SEC * (pre_div + 1));
 		if (duty_cnt > 0xffff) {
 			dev_err(meson->chip.dev, "unable to get duty cycle\n");
 			return -EINVAL;
 		}
 
-		dev_dbg(meson->chip.dev, "duty=%u pre_div=%u duty_cnt=%u\n",
+		dev_dbg(meson->chip.dev, "duty=%llu pre_div=%u duty_cnt=%u\n",
 			duty, pre_div, duty_cnt);
 
 		channel->pre_div = pre_div;
-- 
2.40.1

