Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEBEF4309E
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390069AbfFLT7x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 15:59:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32975 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390167AbfFLT7r (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so18274425wru.0;
        Wed, 12 Jun 2019 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXhKgHiRKTDbq5+IaKGfsR6BmgG7q4N1qI/aWdYB6Q8=;
        b=hsWXPbeCUxn3AeVTaPkpWpYSU2rkvwPwmfSQhu5TejlCTxIevBFbCaEhNMeVV3Eadv
         iMEl6v4r1YDJGL+0c92HnsZAUK8z8U8zq9cd1BHn8Wjc0+q7JLDqkjYpVnQJR1NyUNmf
         lD+O+U7pAXvs3nKGVevnBnGsdqiV1HavIGsHSVU+ekgZxBBmLmwYfZGrLHH7SqvjgUDe
         7elnq0Keg1BIVERCnF7K2WnYAhfvHByXXd4k1xBS/JrA4FQmPERQyS4Qr5z358KOE/dH
         hqPQjLV5c/km5q7eVFSYRaiCxgMEAVLjM99fuQEjERJrVxg15VUSB1dw14m7kB6e5I1i
         n+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXhKgHiRKTDbq5+IaKGfsR6BmgG7q4N1qI/aWdYB6Q8=;
        b=l5TTFanvlh4ahqeRGqHnuQIJcJjZu5IKWBmxBB2xqyJfN/PJo1Wok8XJkLcpENx8O7
         7PU5+O7ntPHCz1mFQRGp7TbvpWGGqs981io4GIyj+jSNfpgTaNDRD0b5oFpFZWFrLumr
         7ShL08GacVclY37UojEOJr9QNT3PHdeh/Z+9Z/3BqAQmkF4KN+8ASPa38DYziaa+LBjk
         wZd/QQEs+/n3xguSFe1juoNziLB/3JVZJe443OlRsuIHM1G+AssWMgALWyNfhPct6oPV
         HHXyqr4+MyanJlbOENxTtyUoxNaO2+V32VoUhXjDQBqnFPncqBwHOg6tWFMfgtl/g7Fh
         ehiA==
X-Gm-Message-State: APjAAAWd+F1qsDAfqDBCNX3K0HPl2MRPC8Xs9MJy2Zmds0OJfmtqlCBR
        J9xBmNwGtn7VGvAooo5hmNs=
X-Google-Smtp-Source: APXvYqx8IAmX+s+7TK5qnozIRIA6bDm97DsRI8ndxcRI4R7vbPriPYONQXPZ8+lE0Itz0xkzmnsqoQ==
X-Received: by 2002:adf:f68f:: with SMTP id v15mr5871100wrp.4.1560369586066;
        Wed, 12 Jun 2019 12:59:46 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 14/14] pwm: meson: add documentation to the driver
Date:   Wed, 12 Jun 2019 21:59:11 +0200
Message-Id: <20190612195911.4442-15-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add links to the datasheet and a short summary how the hardware works.
The goal is to make it easier for other developers to understand why the
pwm-meson driver is implemented the way it is.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Co-authored-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index bb48ba85f756..31259026484c 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -1,5 +1,27 @@
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
+ * The public S912 (GXM) datasheet contains some documentation for this PWM
+ * controller starting on page 543:
+ * https://dl.khadas.com/Hardware/VIM2/Datasheet/S912_Datasheet_V0.220170314publicversion-Wesion.pdf
+ * An updated version of this IP block is found in S922X (G12B) SoCs. The
+ * datasheet contains the description for this IP block revision starting at
+ * page 1084:
+ * https://dn.odroid.com/S922X/ODROID-N2/Datasheet/S922X_Public_Datasheet_V0.2.pdf
+ *
  * Copyright (c) 2016 BayLibre, SAS.
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2014 Amlogic, Inc.
-- 
2.22.0

