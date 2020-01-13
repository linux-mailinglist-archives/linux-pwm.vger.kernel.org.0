Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABCDE138DA6
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2020 10:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgAMJX0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Jan 2020 04:23:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44241 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAMJXZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jan 2020 04:23:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so7718127wrm.11
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jan 2020 01:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSFpFoFsjn6jAy+TG53ImMMGFOcZFIAFPo+oRWA0h9k=;
        b=Y5wOa+B0jyEoz6U1WZodUBGbXQqMQa2YqaIfzm972UifoEOJggbkfkCjtd7AQDiFNB
         6K6dxLDAMzQXqhWnmwer7Y9EfOd2GFINKgaeQcYRCeJnOoh1IGIK20BsQOLRfXLUgGhn
         UaEj2ebcEU2wRuLKz/Ko6sPp/qK91G/voTiGWMUwN5oVOXC8gH6362WpUJPk7Z+LzjyH
         JbrvUaP8cBziF85X+TKhL/xKeQdnSSI8Vz+k+6x4HlY+939Z/NIHe0W+Dvda6IVEz2Zq
         sROWCixh5yCFPtYjUtK+vJuZVEOrijOWdEQd1YDls2WZ3WF4uTdtkuaqUMXgas9VMvtg
         3Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSFpFoFsjn6jAy+TG53ImMMGFOcZFIAFPo+oRWA0h9k=;
        b=G9mU2wDBHUx+gY+I67F8rxzT95T2XNr1cHbukZgfjSKSX1Z0W+puLi40VDztvENBHi
         KW1H4MiDlyE2olc9qbiXc6F9epXtUV/QzkdJ4RJvbSwn6QnH5InGbB33eqfaOrlVr+vw
         FDsW8ZFUrVl59FmLKoI7RjG7wi8udaEHVLXrA0G0Fl9zjFUHJr1O5rKUdKjyCK8JEUrh
         5GpePrZBAkwzQ0fAaDaXCSUVA96U4y8Ezay6hUdlmxStyUZjCxnKxXrNjJYX/NWGLomc
         ybfWVE0Gsd+u5n3c0hFhzxE3wk/FSis/9mr/rTFQ3+jsYe7zLGwS2A8NQGN+YMl/tfd2
         Yeng==
X-Gm-Message-State: APjAAAW4zUP3qJlnhaIzWnAyZNWfhHDc1LxrjUUMhSroTH2spTuuh90D
        ijhIDbLx/uQFvLNlPzFm0KM=
X-Google-Smtp-Source: APXvYqxRn+sRQafI02NF+bw/rFd9vEpLEBqvNZGoqkfz9ox3Xda2xz1Xoy4JcXW25lad3I8fAUWxhQ==
X-Received: by 2002:adf:fd84:: with SMTP id d4mr17281818wrr.211.1578907403581;
        Mon, 13 Jan 2020 01:23:23 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id p26sm13164466wmc.24.2020.01.13.01.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 01:23:23 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Alexander Finger <alex.mobigo@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2] pwm: sun4i: Move pwm_calculate() out of spin_lock()
Date:   Mon, 13 Jan 2020 10:23:13 +0100
Message-Id: <20200113092313.30382-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwm_calculate() calls clk_get_rate() while holding a spin_lock().

This create an issue as clk_get_rate() may sleep.

Move pwm_calculate() out of this spin_lock().

Fixes: c32c5c50d4fe ("pwm: sun4i: Switch to atomic PWM")
Reported-by: Alexander Finger <alex.mobigo@gmail.com>
Sugested-by: Vasily Khoruzhick <anarsoul@gmail.com>
Tested-by: Alexander Finger <alex.mobigo@gmail.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---

Changes since v1:
 - Fix Alexander in Reported-by tag
 - Add Uwe reviewed tag and Alex Tested-by tag 

 drivers/pwm/pwm-sun4i.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1afd41ebd3fd..6b230029dc49 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -248,19 +248,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	spin_lock(&sun4i_pwm->ctrl_lock);
-	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-
 	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
 				  &bypass);
 	if (ret) {
 		dev_err(chip->dev, "period exceeds the maximum value\n");
-		spin_unlock(&sun4i_pwm->ctrl_lock);
 		if (!cstate.enabled)
 			clk_disable_unprepare(sun4i_pwm->clk);
 		return ret;
 	}
 
+	spin_lock(&sun4i_pwm->ctrl_lock);
+	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+
 	if (sun4i_pwm->data->has_direct_mod_clk_output) {
 		if (bypass) {
 			ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
-- 
2.20.1

