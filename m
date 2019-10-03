Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA133CB137
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2019 23:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbfJCVfI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Oct 2019 17:35:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38300 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbfJCVfH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Oct 2019 17:35:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so2518794pgi.5
        for <linux-pwm@vger.kernel.org>; Thu, 03 Oct 2019 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7AHHcEKrWBM5y9wBFl/C7jzA4xtd9EY/YdeDi/hosms=;
        b=ASTwwcBDLKFauBJRi7fwuLBmPbFmPW/3m9tG2zvZzcpcFnfrephyeKAqsoDz/Gbc66
         sNU/cLXRpwM2QQGC5Tx0G9jDeC8pwZEfAnjhJVs59CzNawD20uQqRrHq58tGrC/fQblp
         hNqMsIa+vM2uuIefpEywLO5YYokaczyteqWGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7AHHcEKrWBM5y9wBFl/C7jzA4xtd9EY/YdeDi/hosms=;
        b=KSuYOUugrwz72mcbEh+lr7fC/B0UarhqHXbkUE4JEoCyuaN4qO+e/S80yWBgMLOBGf
         ZnCmtaxgi+eeKEFp6EaluRautbk9bzbcMG0U0kdh5cE3vwkZrq+RewIEW9ImgYLEzEk+
         ixB6K1pG84v1WMxUH8ma/sRKoiZstLMgKpPccGqd9zRHRrAul+66UhJ5+rPcjj89RHuy
         50YuzWQ+IwxLCervjYon6lreHN/i1DTx0UY09GKU5/w2cpJCM/kmzAmZUXLgXfWmsAYD
         pJ7VwI19NYSSYToVxfyQtHcddW5E4f9pswT4x7BkdiqN8H7lisuOWWAEDIof2um5Ey5Z
         k9JA==
X-Gm-Message-State: APjAAAUMLxX6Lviq0mrxQ3fD2TI3Lt2TGv8D+Tsy2gsvYIST71UlzPlG
        ZG8Sh49B30Ivmrm09BjLQqRPAg==
X-Google-Smtp-Source: APXvYqwzXDfyh4cXIWrG9bwfnxsIwKRIIusw5EU7eFwaLpQRN0oyj60CNEvRM3XFeIwxxnCXAkV7kA==
X-Received: by 2002:a63:4d4e:: with SMTP id n14mr11552757pgl.88.1570138505256;
        Thu, 03 Oct 2019 14:35:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 30sm3240647pjk.25.2019.10.03.14.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 14:35:04 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: pwm_bl: Add missing curly branches in else branch
Date:   Thu,  3 Oct 2019 14:35:02 -0700
Message-Id: <20191003213502.102110-1-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add curly braces to an 'else' branch in pwm_backlight_update_status()
to match the corresponding 'if' branch.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 746eebc411df..130abff2705f 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -125,8 +125,9 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 		state.duty_cycle = compute_duty_cycle(pb, brightness);
 		pwm_apply_state(pb->pwm, &state);
 		pwm_backlight_power_on(pb);
-	} else
+	} else {
 		pwm_backlight_power_off(pb);
+	}
 
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, brightness);
-- 
2.23.0.444.g18eeb5a265-goog

