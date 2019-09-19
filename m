Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABA8B7B98
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2019 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbfISOGa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Sep 2019 10:06:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34348 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388616AbfISOGa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Sep 2019 10:06:30 -0400
Received: by mail-lf1-f66.google.com with SMTP id r22so2487151lfm.1
        for <linux-pwm@vger.kernel.org>; Thu, 19 Sep 2019 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jGZhci6ir2QQxaMaZ4RPKwsW6VmlML93zQ3UVVvLVc=;
        b=OCn3gIYj+wUYxAtXas8eOyf4fSEWhP2JZywuNcvWhoXd2re/NpOYXHVgx+ktYyP5cV
         f+T9+6Yleq+jPzmdljsDSTYYkv0hRJ4OXI6VngwNHBQhZ+MPKG8XvWun3Tnm4NO4agx6
         jyhuQWbNOO26WlFgyizU4iA2+osQUAPnhKYiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jGZhci6ir2QQxaMaZ4RPKwsW6VmlML93zQ3UVVvLVc=;
        b=VZjcoyP4/3Qq/M1Uob/hQn35D0h3kxFifidzvDZPT6y71abDlFmI42gBoNp5SLQtBC
         BI1fXnJyg8zTtwkBr7dP8bxV8F8mBXZYieIBY7fgwPcjS95VjBxSEaEAd9YDV5MUCvwe
         /hDEAIFCkfpfHt6HHx+wznsENhm36SGAjKQ4jdxyMM6DrBzLd0s4LdHAzeA52yKWk46L
         a+etoSYDqa3Ln0FMDKUII9sPtp33QdPpw7Jcr7eaCxspfjagcYsZGwjKgISq5oIvrVpK
         zNsBDf5SHsq90/ohY0+w6wodHQ9d9RfzqDm9f5v9tghNYlDbsL7ZdjlkTuCpPfGmAmgy
         ZMwg==
X-Gm-Message-State: APjAAAV8VPHqwQJpxUcQyhfmM9AJstWPeXs/ZjzB5Ld6/VizJvkts/d7
        azjL0eU3tY1sa+jQgRncM8wQMg==
X-Google-Smtp-Source: APXvYqx94tejJIy0k7sD7BxbdRz2nLUSrH5aFo9cmoMdLo9lK0ILNVQtax9BnK0daUvVanbqCyRpiw==
X-Received: by 2002:ac2:51a7:: with SMTP id f7mr5064133lfk.119.1568901989001;
        Thu, 19 Sep 2019 07:06:29 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h3sm1687886ljf.12.2019.09.19.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 07:06:28 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] backlight: pwm_bl: fix cie1913 comments and constant
Date:   Thu, 19 Sep 2019 16:06:16 +0200
Message-Id: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The "break-even" point for the two formulas is L==8, which is also
what the code actually implements. [Incidentally, at that point one
has Y=0.008856, not 0.08856].

Moreover, all the sources I can find say the linear factor is 903.3
rather than 902.3, which makes sense since then the formulas agree at
L==8, both yielding the 0.008856 figure to four significant digits.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/backlight/pwm_bl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 2201b8c78641..be36be1cacb7 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -155,8 +155,8 @@ static const struct backlight_ops pwm_backlight_ops = {
  *
  * The CIE 1931 lightness formula is what actually describes how we perceive
  * light:
- *          Y = (L* / 902.3)           if L* ≤ 0.08856
- *          Y = ((L* + 16) / 116)^3    if L* > 0.08856
+ *          Y = (L* / 903.3)           if L* ≤ 8
+ *          Y = ((L* + 16) / 116)^3    if L* > 8
  *
  * Where Y is the luminance, the amount of light coming out of the screen, and
  * is a number between 0.0 and 1.0; and L* is the lightness, how bright a human
@@ -169,9 +169,15 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
 {
 	u64 retval;
 
+	/*
+	 * @lightness is given as a number between 0 and 1, expressed
+	 * as a fixed-point number in scale @scale. Convert to a
+	 * percentage, still expressed as a fixed-point number, so the
+	 * above formulas can be applied.
+	 */
 	lightness *= 100;
 	if (lightness <= (8 * scale)) {
-		retval = DIV_ROUND_CLOSEST_ULL(lightness * 10, 9023);
+		retval = DIV_ROUND_CLOSEST_ULL(lightness * 10, 9033);
 	} else {
 		retval = int_pow((lightness + (16 * scale)) / 116, 3);
 		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
-- 
2.20.1

