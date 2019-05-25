Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4022A63F
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2019 20:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfEYSME (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 May 2019 14:12:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36806 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfEYSMC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 May 2019 14:12:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id v22so4816675wml.1;
        Sat, 25 May 2019 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nIoMcTrrivGWjqKFRKrQpbhTg0DwU0FAQEhN7ghOLBc=;
        b=YUJZFmlDDS9sV9t0FwAaA3uob1RJ1IKO64k1hx0VeZz++jx4eM8XoCSEP1HQUW5YCT
         Yg6X8OMcyRuAess6huRflmv0SgTKddbbEXVnjxBnlrmS5zgBf8Thu4QSXkel6JrF4gH6
         0Nh+RzfkXnEzfzWU7jlm6MI9ivRU911ji63yc4ZRaWY8W8NNaYsfPznlNTHwgwlJYYid
         YgWjrUYKMFuyG/odJ1p+d8OF7MrkrEenArWMUleMDXqjhnh9om7QZJr8agRXOjq1Ys/a
         pgBINls59AMYHNDXQ+tROISOkYdsCpFcSC9EKYw7kepQE4tjK/7VY8yu6O/Zm74+SovP
         uunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nIoMcTrrivGWjqKFRKrQpbhTg0DwU0FAQEhN7ghOLBc=;
        b=aDYYB2at/BSf5De0eZTwBq5TZ3LLf4UhMKo2ofeNzSXWrhsShFPXZgxhXJZaZsI3Xa
         7wAH4h+ui2TVD9RfyFSfTkPjDhAu/VStGQGyqe2emEEVq2J/WomVTW/vnQLHtbsi8PEp
         utpiY8zJn/Xa4sAzeRaXhBoCTLHI7ivmh8mDBb1PU4NVezeqD1GogEKviW2K7YJZpmWI
         EiK1M+SGdy/4cOmBb2bWPZ4NZzm5pN4RG7sv62q8xk3h8YkN6TTdGnxLKIdzjq6OHW1T
         jTRe3HpkC09T4U4t8CU6gxoG/4jUL20Bghv3H5h4f1LM20caEE136C4op+3+/NQcJRiA
         U9PA==
X-Gm-Message-State: APjAAAUGoAhUHoyoO2pwgJSN7ONR8E+Hn382gJX8nwJiUS8uTuQYS5mJ
        v39C96j1wgJX4Kous5mFoZE=
X-Google-Smtp-Source: APXvYqyu3Be/yKPBPoTWAwazVEJwspi1jbLIzkDvL+i+B9Xl8I2P+UA0mJcEPB3BnlTthJdpmkyPcQ==
X-Received: by 2002:a1c:a002:: with SMTP id j2mr20147153wme.131.1558807920083;
        Sat, 25 May 2019 11:12:00 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:59 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 14/14] pwm: meson: add documentation to the driver
Date:   Sat, 25 May 2019 20:11:33 +0200
Message-Id: <20190525181133.4875-15-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
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

