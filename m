Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8671B7B9D
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2019 16:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbfISOGe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Sep 2019 10:06:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39136 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388616AbfISOGd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Sep 2019 10:06:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so2345597ljj.6
        for <linux-pwm@vger.kernel.org>; Thu, 19 Sep 2019 07:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4SJ+eSfjSAP63ushly3GU0Efl4ebkKBMuWTSOkSqS8=;
        b=W4FhrPJAR9Dqgs5qFA5Pl22WVgeXGbokdSlE6Xjl8ev+AwkvtlovQkmnKhocbnMFdS
         81B7iYoNdsvMs2yQlsvxAdJGvvAKDR0FvjYPLiSIbpwUt9AMKu8kvddB2vIg68Gs3TZA
         XspHxRzEPQhGFNCyXRy2eUNIWhGekZOWx5Sfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4SJ+eSfjSAP63ushly3GU0Efl4ebkKBMuWTSOkSqS8=;
        b=PPotHfpfymbdMZRL3becqc0cF2mJ+L/NC9hCUxGFD5LEjztjFD8RHGJ5HUF8aaF1Zc
         YwQe6iwj2oKpMLHvLj2AZ+kbmD/zOqThx9nK9aqWJm6fXhXoZntWTzp82EJ/4iVrBhG2
         iwlL0gv/DYc5dGBy9VUsIH2JoKFADIuyHOLikLJlNeXgq9KqBWRj1u2oOuNEv8Qelh6d
         4sNvhYNQshc+Ctqdr+U9yp4Es6cDaEVrpxCPyEpRV319Act8KSBbsAMco1w7dEEqfUxH
         TB2EsNXDCP9x2jPkAAWO0Wpq/Kykeewrffx51NosDfWyW6l96SEoS+Zw2ISt/vQ0XROw
         xKkA==
X-Gm-Message-State: APjAAAUlf1mBVZnvz5slOKmaDcLJqo6ic6jVgUSzePfpFsR0bx4XFA+Y
        ID1kvHHXGyKviRf1XD9tDZcpx4QfgsRslFOB
X-Google-Smtp-Source: APXvYqzlHJRhLqL82K2xKbtjAXAMpinhzWwpvMBA7qVfJ7tNQ26aw9X0BviaTA3hpMKKf3q8cAewtQ==
X-Received: by 2002:a2e:934f:: with SMTP id m15mr5586940ljh.101.1568901991526;
        Thu, 19 Sep 2019 07:06:31 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h3sm1687886ljf.12.2019.09.19.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 07:06:31 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] backlight: pwm_bl: drop use of int_pow()
Date:   Thu, 19 Sep 2019 16:06:18 +0200
Message-Id: <20190919140620.32407-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The scheduler uses a (currently private) fixed_power_int() in its load
average computation for computing powers of numbers 0 < x < 1
expressed as fixed-point numbers, which is also what we want here. But
that requires the scale to be a power-of-2.

We could (and a following patch will) change to use a power-of-2 scale,
but for a fixed small exponent of 3, there's no advantage in using
repeated squaring.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 9252d51f31b9..aee6839e024a 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -179,7 +179,8 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
 	if (lightness <= (8 * scale)) {
 		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
 	} else {
-		retval = int_pow((lightness + (16 * scale)) / 116, 3);
+		retval = (lightness + (16 * scale)) / 116;
+		retval *= retval * retval;
 		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
 	}
 
-- 
2.20.1

