Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A742A652
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2019 20:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfEYSMz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 May 2019 14:12:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56201 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfEYSLw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 May 2019 14:11:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so12311714wmb.5;
        Sat, 25 May 2019 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kfVYlUJeQCHL5cSID78tPPaL8HnCS71jyLT/qQfWE0Y=;
        b=VptW1X7hURBN1YVC+q/LsurDbH+RmvNxxvli4gffs5StELw6dPFuEs3zWZrY11MakN
         CCRB5f63eRtJyiOYYObTObWvoPpRsHUO9rg1bROPf/+zVY7z2Pwd2qBAM4Gc0n1GaXWl
         vo4pUu86XALwiBqJG6WLQgHjHxljWQ61BOuO7cMOE90lJXPXZbulRkD0enpBM/BqwKL8
         w+IF3LMyeHS+AkS4l8UP0lLB3JYXH3k795MWzp/t88hYUQ1eTj+rf/9Ox8TUXnbHmDch
         xEWedKpQ3/pLpso5MK7QqSSmLMLirFzT7SSXiDi/axfVhFrZvou3DWEaiyLVEgZ/EvxI
         c+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kfVYlUJeQCHL5cSID78tPPaL8HnCS71jyLT/qQfWE0Y=;
        b=qxCc8BumK6iyNhX47VBw5a6i+hNcljyCLH1vs1zYAHH5Ci4JdEiI3iWUNNxwX9AB8D
         V8WoUKR2Y4IJZq5J8OYTsXPtgJWAsEOSev1kMj791JAycI97j8GECKGgByg3PGnxJjJf
         hjineG5r+r22L1WSxNrA3pn0xqtqVwR5cR+n7J1If6B/Lq4LUczWRkvIAZXYsnfH5nLM
         1QBikMaC5ABAMj8aW79Okw6glkU9A74MDgYqrEnSfIVgqq4LDq66FS24yCGKJdb6Jy29
         Q7oWACoooBxN3NfKsJoBdiUpHdhs4OSGeaGh5RJP1udLRDYnCDMihe/uVQ3o+sgi7TfP
         Aejg==
X-Gm-Message-State: APjAAAUL0mH3RJGxlgc7EVIhW8tKhZRyxtBHBZbbUQvv7M/bqZzq3uhN
        vTyV6iDf5kFgxAYco+1+eFWuKmoY
X-Google-Smtp-Source: APXvYqznM6UHLbHru14wH4QS6FkAKOANEzuRiTO0Lt36ObeG66JwdGsGb35NNstOPe7Tshf+VUKKWQ==
X-Received: by 2002:a1c:be03:: with SMTP id o3mr3208464wmf.139.1558807910263;
        Sat, 25 May 2019 11:11:50 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:49 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 06/14] pwm: meson: pass struct pwm_device to meson_pwm_calc()
Date:   Sat, 25 May 2019 20:11:25 +0200
Message-Id: <20190525181133.4875-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

meson_pwm_calc() is the last function that accepts a struct
meson_pwm_channel. meson_pwm_enable(), meson_pwm_disable() and
meson_pwm_apply() for example are all taking a struct pwm_device as
parameter. When they need the struct meson_pwm_channel these functions
simply call pwm_get_chip_data() internally.

Make meson_pwm_calc() consistent with the other functions in the
meson-pwm driver by passing struct pwm_device to it as well. The value
of the "id" parameter is actually pwm->hwpwm, but the driver never read
the "id" parameter, which is why there's no replacement for it in the
new code.

No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 39ea119add7b..d6eb4d04d5c9 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -114,10 +114,10 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 		clk_disable_unprepare(channel->clk);
 }
 
-static int meson_pwm_calc(struct meson_pwm *meson,
-			  struct meson_pwm_channel *channel,
+static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  struct pwm_state *state)
 {
+	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	unsigned int duty, period, pre_div, cnt, duty_cnt;
 	unsigned long fin_freq = -1;
 	u64 fin_ps;
@@ -280,7 +280,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->period != channel->state.period ||
 	    state->duty_cycle != channel->state.duty_cycle ||
 	    state->polarity != channel->state.polarity) {
-		err = meson_pwm_calc(meson, channel, state);
+		err = meson_pwm_calc(meson, pwm, state);
 		if (err < 0)
 			return err;
 
-- 
2.21.0

