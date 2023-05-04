Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED456F6474
	for <lists+linux-pwm@lfdr.de>; Thu,  4 May 2023 07:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEDFgD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 May 2023 01:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDFgC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 May 2023 01:36:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35971BFA
        for <linux-pwm@vger.kernel.org>; Wed,  3 May 2023 22:36:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96598a7c5e0so3691266b.3
        for <linux-pwm@vger.kernel.org>; Wed, 03 May 2023 22:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683178559; x=1685770559;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B0t5YGI0IKM6eJmALhq9Gwt5nHb+W20+Of1xihS5tU=;
        b=CwILioX0YQcUeq9+Eli1Hmp2zaY8kTSpsMSQhAfhkU+sNv5U947J2jYAg6jqzFl4d/
         ZTRAhIsGHAR0UYT2ym2Lf3L6sP3R9RUE0485DEr9p7vgRL+u71GLkZx+aCCCi5CJaywS
         1KcbB+QYRBDqBUeOYZc30PMXEi0pJORquK9u7wTzQuuKXwOsEGb6nQQxU7lyLWizXw+C
         n4ixejUlzJp576TWcpb1xBKLxu4ZxEzmPnUB7HcgTishIGyHWFDFD6hxaqruxeINe945
         LAiPzlsalTFyrPhfmtLDHhhuxr1+bpVHS3gvGj5HJA4JHA10ld3fK0NZfdOv2jN0DpcK
         hs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683178559; x=1685770559;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2B0t5YGI0IKM6eJmALhq9Gwt5nHb+W20+Of1xihS5tU=;
        b=ExwtKu13i5UVsoGxasljOPaHObcrTfwaI6icgr8nQ2w1SzrBkuQkbxN+BrgAAcwbQ5
         dlmQ25jHqRHRtk9eqvgMLtgyXmWkdoIL9oXumdJzqSdhsHjd2Lzj75j0JAFzOAtrjpPI
         BaJAZO3vAKngD7rdsVGVapqVm/mac78sFpA31dziu/bfB1yOvFkb2sd9c5Z8/uccV4mD
         viOfeyR1SBGpkjYM7ncFN1GfWW44hhUn5X2A/APYrNddWRccuVFuGJM1yzWwT1q4OD8i
         6y0ogHEejZMZp7vcDI6Deu/QXcLWF1deOy+dmvo2MRovqzac7gqBrRAlQSGW1sKUEyF5
         rr1Q==
X-Gm-Message-State: AC+VfDxVU2QA8tG3PgOio2HceoPucw/WghrJHnTYQaufRAftDY+2MOOE
        nuNSc+EqF1c6GTKCKgDsFVI=
X-Google-Smtp-Source: ACHHUZ5FtRAYDi71Gl+BLlzVhBBkGmjcV75ZWWjXELJJn89EBnz0Q1Ap2oGatIcuHtImFMJU5FLkPA==
X-Received: by 2002:a17:907:70b:b0:94f:296d:75d0 with SMTP id xb11-20020a170907070b00b0094f296d75d0mr5134611ejb.30.1683178559131;
        Wed, 03 May 2023 22:35:59 -0700 (PDT)
Received: from ?IPV6:2a01:c22:77ba:7e00:1ea:4329:c109:e987? (dynamic-2a01-0c22-77ba-7e00-01ea-4329-c109-e987.c22.pool.telefonica.de. [2a01:c22:77ba:7e00:1ea:4329:c109:e987])
        by smtp.googlemail.com with ESMTPSA id sb21-20020a170906edd500b0094f4d2d81d9sm18226897ejb.94.2023.05.03.22.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 22:35:58 -0700 (PDT)
Message-ID: <d2aa9fa6-4513-c3e8-493a-3a34d5a1143b@gmail.com>
Date:   Thu, 4 May 2023 07:35:55 +0200
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
Subject: [PATCH] pwm: pwm-meson: remove not needed check in meson_pwm_calc
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

duty <= period implies that duty_cnt <= cnt. We verified before
that cnt <= 0xffff, therefore we can omit the check here.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
Note: Applies only after "pwm: pwm-meson: fix handling of period/duty if greater than UINT_MAX"
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

