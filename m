Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9735E188FC2
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 21:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCQUuu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 16:50:50 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:43577 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCQUuu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 16:50:50 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 621F223E3D;
        Tue, 17 Mar 2020 21:50:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1584478247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHhnQloQUToDXGnXijKLNbDzOyKNXrK7+WubSxFsj34=;
        b=cSJm4OCHxSQfB3YX/PxFPSyx/Uz0UYF9kZtTPAU8l0ttDyB7LGY1VhFNo6DXRmKBOy34AQ
        h/PyXwOebr6/w8MwLxZzAiMLO881AAjr6KPE6IBw5tEEOBfYmPwuqC4cv8NE8GNbbFXUDo
        /+OZlquotM0LFYlAd31RL3wXpw2MXLM=
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
Subject: [PATCH 01/18] include/linux/ioport.h: add helper to define REG resource constructs
Date:   Tue, 17 Mar 2020 21:50:00 +0100
Message-Id: <20200317205017.28280-2-michael@walle.cc>
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
X-Rspamd-Queue-Id: 621F223E3D
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM(0.00)[0.496];
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

Similar to the existing helpers, add one for IORESOURCE_REG which comes
in handy for most common resource declarations.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 include/linux/ioport.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index a9b9170b5dd2..cdcceeec0f86 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -165,6 +165,11 @@ enum {
 #define DEFINE_RES_MEM(_start, _size)					\
 	DEFINE_RES_MEM_NAMED((_start), (_size), NULL)
 
+#define DEFINE_RES_REG_NAMED(_start, _size, _name)			\
+	DEFINE_RES_NAMED((_start), (_size), (_name), IORESOURCE_REG)
+#define DEFINE_RES_REG(_start, _size)					\
+	DEFINE_RES_REG_NAMED((_start), (_size), NULL)
+
 #define DEFINE_RES_IRQ_NAMED(_irq, _name)				\
 	DEFINE_RES_NAMED((_irq), 1, (_name), IORESOURCE_IRQ)
 #define DEFINE_RES_IRQ(_irq)						\
-- 
2.20.1

