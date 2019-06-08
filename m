Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49CCD3A0FD
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfFHSGm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:06:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40945 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfFHSGj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so4681404wmj.5;
        Sat, 08 Jun 2019 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rd/V19A4tSe1xba1SSV3IvSkkngIMc8S68pgolsK8gQ=;
        b=SGwW5Qi1PzRumMlS2QqA1j7twYoUlovyZOMWknzDn6pTP82HtWJ/uWCOPFFY5efuii
         mldnIc38SrCgMBVVcFztt9gliqC7yT8waUWd+5PUYUkxcNRESshBHykogWpLcK/7oQwf
         tLufn2777HA1t+shj1qLcVYNZ8Y9TaxQ+RDm0nQXWyz8InSesskey0ficmQ8msPq/WJV
         /Q8YiM41p5ThKp6nM3+Y4Hn5pXdvl1p7g7AsUQLtiDGuD9i88IWVkmliGoWkAiN6IV9q
         V2ff8upHjPtccfR2sAsdb1ZXTm742aJ/8QvcVbP5OTjmIxeJAV8dwRz7mkCA8zB3zHYX
         dhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rd/V19A4tSe1xba1SSV3IvSkkngIMc8S68pgolsK8gQ=;
        b=j/eKeCv9AIj+vnkE0mwkO/A/pxCRk5bTdQo/k3WlKPQpDaZyfr994iZrYu8iMrDHXZ
         HZxZghYyGwQSUe+Jelum/s9L0iPUvAm6mSRVxlLgswNTgKpT6ZAMAjXkg6BO0q5EcZEy
         sqVFPyKxLU+T5/AIX9WhVIe/9fUHSTOIBE5Gx+YK5NFTO7jBtFPMmrIc0lcg3xldvqXt
         OGOBgDKRHz+cWlEUu1AQc08rjzdS+IYd6tBDkmw0JhH9fGxbJNETBz3IlKyeutw9S35c
         ijm9Kj11qdF6FivwOxbSHhMAbeLibGCFsK7qtlqm+o/177w/AhId5bYFnvkR+YfpwNZL
         fGTg==
X-Gm-Message-State: APjAAAVVAc/QTUrlQ+kVYcq+o0a7Uo3xNUbkiwGoziSh17pY0cINvP10
        z9QeFzJug+h/3lv3wrt0aXQ=
X-Google-Smtp-Source: APXvYqzfJ3Inv2tkqe5fNSbVH0w39sIKZ3WEIMfS5tKr2+3pHXqvYD+oKzvYSwXsaNvRbuHQh1DYSw==
X-Received: by 2002:a1c:39d6:: with SMTP id g205mr7273666wma.85.1560017197987;
        Sat, 08 Jun 2019 11:06:37 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:37 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
Date:   Sat,  8 Jun 2019 20:06:16 +0200
Message-Id: <20190608180626.30589-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

MISC_CLK_SEL_WIDTH is only used in one place where it's converted into
a bit-mask. Rename and change the macro to be a bit-mask so that
conversion is not needed anymore. No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index c62a3ac924d0..84b28ba0f903 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -33,7 +33,7 @@
 #define MISC_A_CLK_DIV_SHIFT	8
 #define MISC_B_CLK_SEL_SHIFT	6
 #define MISC_A_CLK_SEL_SHIFT	4
-#define MISC_CLK_SEL_WIDTH	2
+#define MISC_CLK_SEL_MASK	0x3
 #define MISC_B_EN		BIT(1)
 #define MISC_A_EN		BIT(0)
 
@@ -463,7 +463,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
 
 		channel->mux.reg = meson->base + REG_MISC_AB;
 		channel->mux.shift = mux_reg_shifts[i];
-		channel->mux.mask = BIT(MISC_CLK_SEL_WIDTH) - 1;
+		channel->mux.mask = MISC_CLK_SEL_MASK;
 		channel->mux.flags = 0;
 		channel->mux.lock = &meson->lock;
 		channel->mux.table = NULL;
-- 
2.21.0

