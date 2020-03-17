Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C98E188FA1
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 21:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCQUvn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 16:51:43 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:59981 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgCQUuz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 16:50:55 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 23FB023E62;
        Tue, 17 Mar 2020 21:50:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1584478252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4g351ZXp/jflpBK37qnXyNw2RDGRC4xBHLB3Avbv3U=;
        b=kXyRwtVEDZog2sn6iZ6Wbu9Jgt/q8UA+RLZ8ee7kCsr1LgmU9BCr4yGlXezPYx55g30LMx
        QsPHIIkW7eN3q9gpLkxR79uq2H4Tg6p8lU/sc0ggYA5KyU3fYPJBhZsxG6hRT4kd4vt6Et
        Obr+pnAqXHtf6UDkzlgf3hgSFkv7eb0=
From:   Michael Walle <michael@walle.cc>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Subject: [PATCH 07/18] dt-bindings: watchdog: Add bindings for sl28cpld watchdog
Date:   Tue, 17 Mar 2020 21:50:06 +0100
Message-Id: <20200317205017.28280-8-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317205017.28280-1-michael@walle.cc>
References: <20200317205017.28280-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: 23FB023E62
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM(0.00)[0.604];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[22];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         FREEMAIL_CC(0.00)[linaro.org,baylibre.com,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,walle.cc];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds device tree bindings for the watchdog of the sl28cpld
management controller.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../watchdog/kontron,sl28cpld-wdt.yaml        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml b/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
new file mode 100644
index 000000000000..f446372fce34
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/kontron,sl28cpld-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Watchdog driver for the sl28cpld board management controller
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description: |
+  This module is part of the sl28cpld multi-function device. For more
+  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    const: kontron,sl28cpld-wdt
+
+  reg:
+    maxItems: 1
+    description: Instance number of the watchdog
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.20.1

