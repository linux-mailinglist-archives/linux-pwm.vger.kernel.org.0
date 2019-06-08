Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9BD3A102
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfFHSGj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:06:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35920 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfFHSGh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so5232770wrs.3;
        Sat, 08 Jun 2019 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j4V8vgCJVg/njbmSFVRp0iLM1h1qXkuf92IBeudet/c=;
        b=WF5dn0oasdN+mFWoBOpnUgH/KnarBw3oCbrB3A0idRFqoMs7KQ+opX0vq8msbM7wfy
         SHDsJf2bKShpd021tazmsHMlLvhjsRoylhfo2ourzUpM4MIzrObBvgVSXrDYspTW+HsU
         D7xPWdwBWsgaVhEmud3PS3ChBz2H2g34vm2hoc1DKnVO5qF5iI8GbMHYSH8ul0NkF+dd
         O8kZidm6zeLYKpoz3Xa8Hfyn51G5NfEp2OVGPUrhU5Szyf9Hs6XrCP6iENHYx5OipotD
         HQiscxjatLSMCjeeUFqu04wCnplCwjXI1sVYojj1ZjID7Ag0yt7a60XWO9zWmTcUTp1l
         vxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j4V8vgCJVg/njbmSFVRp0iLM1h1qXkuf92IBeudet/c=;
        b=J+uCQVnWfeU8wWZS9zsJFMyQ4rnFXG6SZA/zsy6UlQDMIk7Z7rA32wnxM3Y5nPdLqv
         joEv5G4MZIfLoNTIsgIEUn2zX49cIiNGJo1T9//EVQoLH8elchSM2ZEtbXKoKu90plK4
         GALnENOTPkhNwV0n9gT8gIlPlEZUhEngOBC/9l/BEZdM3TlHtl/YY//nKHANlupkXEW4
         sRlSUWTIoUeApN55bELPEr08FnCJIZzyUDYKLU/w58qKGqIQpLN1fYKEhMubEyU4TqSS
         xYl0UKB06yt5I49+0a9R3oeOA+JiA4JYRsuW3rTK6ykY8gN8KLhMPgboC7stdApiKcWe
         NsLg==
X-Gm-Message-State: APjAAAW1zPMyPFO3T9iYas8aJo9ul+HLNerXkn6crNvTYam7uribTeQD
        CXbsNUjmcwyCUwQaOFHaDU0=
X-Google-Smtp-Source: APXvYqxpJU5Y5i3iuyLyZt4VfVAQkfSDbpbie+roqNN1I3umOMeAwrV3a0DVRSN0jgq7heZqmsG6Qw==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr36393638wrm.174.1560017195983;
        Sat, 08 Jun 2019 11:06:35 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:35 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 02/14] pwm: meson: use devm_clk_get_optional() to get the input clock
Date:   Sat,  8 Jun 2019 20:06:14 +0200
Message-Id: <20190608180626.30589-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Simplify the code which fetches the input clock for a PWM channel by
using devm_clk_get_optional().
This comes with a small functional change: previously all errors except
EPROBE_DEFER were ignored. Now all other errors are also treated as
errors. If no input clock is present devm_clk_get_optional() will return
NULL instead of an error which matches the behavior of the old code.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 3fbbc4128ce8..35b38c7201c3 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -474,14 +474,9 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
 
 		snprintf(name, sizeof(name), "clkin%u", i);
 
-		channel->clk_parent = devm_clk_get(dev, name);
-		if (IS_ERR(channel->clk_parent)) {
-			err = PTR_ERR(channel->clk_parent);
-			if (err == -EPROBE_DEFER)
-				return err;
-
-			channel->clk_parent = NULL;
-		}
+		channel->clk_parent = devm_clk_get_optional(dev, name);
+		if (IS_ERR(channel->clk_parent))
+			return PTR_ERR(channel->clk_parent);
 	}
 
 	return 0;
-- 
2.21.0

