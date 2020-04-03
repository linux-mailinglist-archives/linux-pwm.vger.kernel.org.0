Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D5519E192
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Apr 2020 01:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgDCXx3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Apr 2020 19:53:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34896 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgDCXx3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 19:53:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id k13so10067926qki.2;
        Fri, 03 Apr 2020 16:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ybaTpFfXn+LxmLPmE6oKCLBK1aHCu6fnDl0UMen+FlQ=;
        b=c+WwfWnOklwmjmATtt9PNjWRluiTClyYp0jcstMXvu/qdAut4CGP9x02z61LxH7M3i
         PtPUsAPcCc704lQFMf5323rEJBO1nohLgnzhGarL0ULJuYJgvR4lQB+vwHso2W3oOI6z
         Dfyj3zM/xpBVy7Wk/0Z82xsof4atcTG9GBwRRHimkSIm6VghfgXi8N7cxdmjmuvRq7zT
         KBGJTnu0slPw65DkF+gngJ2UIp4c4e/4sp52KI9r7r7xuHagqEXVvKD/VrBq1zloBiSS
         0jo099Yb7hQsxPUlXKMgZbN9crlMd+29e1VsF/FuEUC5Xny9KX6+85RjkDGzkbSK22/+
         BKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ybaTpFfXn+LxmLPmE6oKCLBK1aHCu6fnDl0UMen+FlQ=;
        b=P+0vpRfZR/4dkDliFZ5xcUcan+sKoA0XtDIMrVXZrQg3EiEPzssi6NoCiknz6o6fIV
         +1B1x4MX5dedqBcAffcYO4tK6TW9Uai/teQsQarqKGzOul0r8dVYIU0SlAw+hciheJIV
         nkaDd4dacYMDwTK+HVr9FxmwwETwKKvrlzgp4RP7+eFlIXJQ5JwIM3zxuaSlJgkkwojq
         kBDK65gku+ezZhJjsUfk0OZFCWfhn7ykiWHpbLRX8H4pML4y5RIniseNp/945YVg0oar
         kqSl6ecN10zYTrdtEl5ktnftPxGYeHSEDKiojPMN/mHcKgadqmQ3LbUOmAz6ulaVczxM
         jDIg==
X-Gm-Message-State: AGi0Pub+AHTSziPQyl7foG+hiyW5FNDXmImdkyTPLzU+rkpr1KaKu7t3
        PsL3kGOy2Qdqv7YNaMibRAc=
X-Google-Smtp-Source: APiQypJhlhIVUJkqW3E89aT/gcxK/cLzNXagxiAuUlk5eOo5HS1C0vdojyWJbZ65rZyK/gr/LKoA9g==
X-Received: by 2002:a37:9dc9:: with SMTP id g192mr11860484qke.50.1585958007869;
        Fri, 03 Apr 2020 16:53:27 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id p186sm2143388qkb.71.2020.04.03.16.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 16:53:27 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] pwm: pca9685: re-enable active pwm channels on pwm period change
Date:   Fri,  3 Apr 2020 19:53:24 -0400
Message-Id: <20200403235324.27437-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In order to change the pwm period, this chip must be put in sleep
mode. However, when coming out of sleep mode, the pwm channel
state is not completely restored: all pwm channels are off by
default.

This results in a bug in this driver: when the pwm period is changed
on a pwm channel, all other pwm channels will be deactivated.

Fix by clearing the RESTART bit when coming out of sleep mode - this
will restore all pwm channels to their pre-sleep on/off state.

Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com/
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

I no longer have access to pca9685 hardware, so I'm unable to test:
- if this is indeed a bug
- if this patch fixes it

Made against:
Tree-repo: git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
Tree-branch: for-next
Tree-git-id: 9cc5f232a4b6a0ef6e9b57876d61b88f61bdd7c2

 drivers/pwm/pwm-pca9685.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 76cd22bd6614..0a16f0122e0e 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -59,6 +59,7 @@
 
 #define LED_FULL		(1 << 4)
 #define MODE1_SLEEP		(1 << 4)
+#define MODE1_RESTART		(1 << 7)
 #define MODE2_INVRT		(1 << 4)
 #define MODE2_OUTDRV		(1 << 2)
 
@@ -271,6 +272,15 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			/* Wake the chip up */
 			pca9685_set_sleep_mode(pca, false);
 
+			/* If any pwm channels were active when the chip was put
+			 * in sleep mode, re-activate them.
+			 */
+			if (!regmap_read(pca->regmap, PCA9685_MODE1, &reg) &&
+			    reg & MODE1_RESTART)
+				regmap_update_bits(pca->regmap, PCA9685_MODE1,
+						   MODE1_RESTART,
+						   MODE1_RESTART);
+
 			pca->period_ns = period_ns;
 		} else {
 			dev_err(chip->dev,
-- 
2.17.1

