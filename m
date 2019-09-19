Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1885B7B9B
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2019 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389056AbfISOGc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Sep 2019 10:06:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46383 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388616AbfISOGc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Sep 2019 10:06:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id e17so3683073ljf.13
        for <linux-pwm@vger.kernel.org>; Thu, 19 Sep 2019 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBTcMpOyl2bLXBXPvlZrHA8WBZZACi7gNqiyseLnytg=;
        b=A48WL858gPJVbFagBB2BTpTgHdTGMt1R9BC01trDu5z3ENfmhWS7RiqjnfWx20RoUY
         E0iQrrx0deYrkinYfpODZNFzuVCQBajUDYXy09Qkmb+GV1iPmOdfGkZktLbOEyqsuOiz
         8Rwokwielo8W6w7zis9sx6uJ5V5kHfsVwrS8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBTcMpOyl2bLXBXPvlZrHA8WBZZACi7gNqiyseLnytg=;
        b=BfgBLD9fz/As1hUpKa7Wm2WTL8ftzBmjIp0m3nNON4jYZdcVFU1XT8cbY1f9fZKg7A
         YVb/qIs5yjmH8OXmK44ICLk3y/AR8wy3GW+etiHRF4ZzukASG3QpWosHDbsU5RVtUdWf
         p1k3fCOqg+VuF+JmXG4o977kP7RdEujndDY2FQDTItE6+wh17WiWn3U4Vj/0gBzs7VOI
         8qkHQv2Mixgl89KdMcJim7e5vRMhy0nIMPaqvXfrA7V8bFyiHVhcz+84ZT0c3w7D66If
         wGVXKv1nf5Nf5U/wpLXutQLfks8oBcTBhjUhOFRvBRi/9NF3vfwteerZZ/+RP89y2r0e
         jOXw==
X-Gm-Message-State: APjAAAXgx8Z+MiiNckn8vuTHnRI9lfybY9b3psTz6O/FjPar9boU4l2F
        R7eHmjxmbziUuQs6gVoobdp0Gg==
X-Google-Smtp-Source: APXvYqz80XnBinuoIhjkWosIvpazzODW2CaBBl25zB2SkJzfe+uW+0Y8qIL/RSBMCTZSD3oY/92ueA==
X-Received: by 2002:a2e:6e18:: with SMTP id j24mr5534397ljc.158.1568901990286;
        Thu, 19 Sep 2019 07:06:30 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h3sm1687886ljf.12.2019.09.19.07.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 07:06:29 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] backlight: pwm_bl: eliminate a 64/32 division
Date:   Thu, 19 Sep 2019 16:06:17 +0200
Message-Id: <20190919140620.32407-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

lightness*1000 is nowhere near overflowing 32 bits, so we can just use
an ordinary 32/32 division, which is much cheaper than the 64/32 done
via do_div().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index be36be1cacb7..9252d51f31b9 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -177,7 +177,7 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
 	 */
 	lightness *= 100;
 	if (lightness <= (8 * scale)) {
-		retval = DIV_ROUND_CLOSEST_ULL(lightness * 10, 9033);
+		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
 	} else {
 		retval = int_pow((lightness + (16 * scale)) / 116, 3);
 		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
-- 
2.20.1

