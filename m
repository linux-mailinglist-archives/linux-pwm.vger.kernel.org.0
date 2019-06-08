Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB153A115
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfFHSHV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:07:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44540 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfFHSGl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id b17so5195462wrq.11;
        Sat, 08 Jun 2019 11:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ULxtsw8dujAsYVt5zC7SDOdydkdqEp/VduAIrsjyFQE=;
        b=SBHxrcDiscWsMPlgUe1eue3IB7jYsIcP8LOxKnBLi/mcoN0HQC0c4nr5sRBPn+qmQM
         HQnASudTpyUH2PPAOdA5RAnqmEKhS69NmcTqDzT44DZrxcP533fDz4mFEKQtvzW5bk++
         a+wuFcmv24SnXfkCFwObZfODttniBC8DNtWs9pxov4CzBcUZWO9YnFCUGQP1PvmHtV1y
         3HE7Qo1bZXlX/hsv45hdM/CITvIsAzcYcM8C7/5OH0YtynfhfrEx2TAtQqhdVYw6IHVU
         y62BsUxGetOMUdms3Xu7E8NxIpaBj90SC6YPtntZO9aOJujrK5dVYn+uFlkZAiw7RjR1
         zIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ULxtsw8dujAsYVt5zC7SDOdydkdqEp/VduAIrsjyFQE=;
        b=Kva1VPCW2qtq1nR8Sx0c92vuxNeAPDzd/l7bTqMVrb4hGsGwXsQ7W4sW6JNZvoypy3
         DU9NH6pTLzThsu2dJP0sYoHPQaZ6CZI89ixkKlduaFvWtXQijB7NzlBIND/WgVxHfho8
         5cJhUarylhPbF2EvfzEuN4lm84sbugkgTRtVaJHVMN2nan30j2kKcvHHyxYOUQ3h/GDM
         xIR6tNvi8eWSu6KwOy483i/0xiJzqBXacHzYcq8Q/MF3VsYiaghzAEfCuXtFbiYYwPUe
         ado1CtvEfN+5fqJRaGDUmZQe4/mkpwlHwVZud9Rbc8HUpunPcaJK7fMKznXBEzF6UpCP
         zm2A==
X-Gm-Message-State: APjAAAX0VIhh2hgtLIu34bF/VRe3TYx5HOv05zIpLT2H+Z7TvtJe9OLb
        cys95trDT4/xcDoG9I43Jeg=
X-Google-Smtp-Source: APXvYqwpgkhDaAIFoY4aTBBevnRJflkVdXiiIro0E7UPi1OhSmsgF91My8rGM24/7ZxDIpgiuELmag==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr36157030wrp.149.1560017200358;
        Sat, 08 Jun 2019 11:06:40 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:39 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 06/14] pwm: meson: pass struct pwm_device to meson_pwm_calc()
Date:   Sat,  8 Jun 2019 20:06:18 +0200
Message-Id: <20190608180626.30589-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
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
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

