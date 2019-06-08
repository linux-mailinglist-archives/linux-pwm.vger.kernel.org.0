Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 065C43A108
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfFHSGv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:06:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40951 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfFHSGu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so4681626wmj.5;
        Sat, 08 Jun 2019 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcZp+XV+KTOIWOKJ0nzGbLimTWtElgIxN/UQOTUbAxg=;
        b=f/hhHhhEKLF/T8vWu/eNekD7NioNE5HDoSUFzP/gNeNrARsZr9Xi3ToPkymnMBNLZY
         APYc06sb5U4MeUqqXM/T7X5et0ZLwnLt1JMQKfD4h64GtQacBOHMVu/qioua03YGdzAQ
         tbC/HILGO4JMyS8X5FWZbOIVWroxO7/upi1lg3GJwdjBXOM1gTNzTB2pHX6zg72iJ8tu
         eMU9IbaZIQZ8Uzh9RCIvQhW+ULARcKPutH9Z5Ou4wvp4FV9RPuZFXvZ5fiMAjErb2dKx
         MvcRRw7C6tC8eff1mfHn7v9gaRkQTLx4hA06QqrqJR1RskuMmP8Vgty1wUuYFRz46qmZ
         fndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcZp+XV+KTOIWOKJ0nzGbLimTWtElgIxN/UQOTUbAxg=;
        b=Okv+QYOBvJj4M9kB9i4Z8Lwfv5tKYphuVgN//fyllslGL1PiRnK+227hl6tgOfK3ry
         2hkr3D7mqFfWZEva8i9UT5XLuc2ejm7WE+AZGHpZU0zZJd3+hjDPptLmO4jTBdbFLexj
         uyvzj/1oJZ3y28bhxt2gavAYkBSkITcpFBkD8sTudaKGFYcTBU2GJaAsjpC5ea3KhbWV
         ujrlW+daVAg0gEN/nSzjDE4SI3zxd8TYQVqyTttVvk7pDvgaVeMNyXicF6TOfitPIhVG
         9Kn2ztCDFlcvpkOpcta1SeRwa653xVsrdjbFb2T+MfGZOvvK3BON4mNu3lWGelfXuwQ4
         80dw==
X-Gm-Message-State: APjAAAX6cXXqAuOT8c5wgqUqVPi+9KLLRzzQkq6a8wg4crNz4NHjy1Uf
        XsKDBdYvjKVMf55hJp0Chdw=
X-Google-Smtp-Source: APXvYqySdvCrYqBKMKqzayv7pE9NT7Fh66b0snU+rte5qZ39fRD1bSiBGfxJQPh0JknCKLonuMpUDA==
X-Received: by 2002:a1c:7d13:: with SMTP id y19mr7493333wmc.21.1560017208453;
        Sat, 08 Jun 2019 11:06:48 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:47 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 14/14] pwm: meson: add documentation to the driver
Date:   Sat,  8 Jun 2019 20:06:26 +0200
Message-Id: <20190608180626.30589-15-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a link to the datasheet and a short summary how the hardware works.
The goal is to make it easier for other developers to understand why the
pwm-meson driver is implemented the way it is.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Co-authored-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index bb48ba85f756..6a978caba483 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -1,5 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
+ * PWM controller driver for Amlogic Meson SoCs.
+ *
+ * This PWM is only a set of Gates, Dividers and Counters:
+ * PWM output is achieved by calculating a clock that permits calculating
+ * two periods (low and high). The counter then has to be set to switch after
+ * N cycles for the first half period.
+ * The hardware has no "polarity" setting. This driver reverses the period
+ * cycles (the low length is inverted with the high length) for
+ * PWM_POLARITY_INVERSED. This means that .get_state cannot read the polarity
+ * from the hardware.
+ * Setting the duty cycle will disable and re-enable the PWM output.
+ * Disabling the PWM stops the output immediately (without waiting for the
+ * current period to complete first).
+ *
+ * The public S922X datasheet contains some documentation for this PWM
+ * controller starting on page 1084:
+ * https://dl.khadas.com/Hardware/VIM2/Datasheet/S912_Datasheet_V0.220170314publicversion-Wesion.pdf
+ *
  * Copyright (c) 2016 BayLibre, SAS.
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2014 Amlogic, Inc.
-- 
2.21.0

