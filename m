Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52026EFAFB
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 11:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbfKEKYj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 05:24:39 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42113 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbfKEKYj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 05:24:39 -0500
Received: by mail-lj1-f195.google.com with SMTP id n5so10152908ljc.9;
        Tue, 05 Nov 2019 02:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bHPDrr3HiImPjNjg8bWMTYHlcggZ66/9TrLdtK5mAS4=;
        b=Op5fg1/UyCpjzEOZYxDCqmeU/YjTp70xoK3LZtOmCXG38Y+KkD/W79xQS4Asoo4J9+
         aOlGdt64pvPg0bPrCZzijTbssONcGwbKxj2Td/Y+c33ZWFQeAYTc1HVYDMpkCf7o6o1z
         OY/oeV29zD/PPfeuAtfGYzdX1fnfTKmBNB1Yw+RI83e5lLO7VdGAoKBs9LvuXyYrhNze
         AJQkLvnrRe7n+AzLvOMS8yjwkXMaKsmVsMOz1AwuxqcngRDkA17NEk7bJqlBciodpcVF
         XqFAycCY4mEtWwUcLl7OvFceVTIQ7+maP58HJF2DP4ZznjpZEHPPZxolfKasjgR+dIOo
         k0ng==
X-Gm-Message-State: APjAAAW9AKF/6nXs2LxQe1l+1h67Kv3kZfRvDnfy1Jm/rhczn61M8/f5
        mG+ZRiOdqVscswc9O6/pWPI=
X-Google-Smtp-Source: APXvYqw+ZGoOz3OiTd9yy3EqEwKGHGu7H0qfhS7OYfsTGPHGDgCtefUyk+bHnFzg2hW+fILf71btuw==
X-Received: by 2002:a2e:96c1:: with SMTP id d1mr23520531ljj.87.1572949476956;
        Tue, 05 Nov 2019 02:24:36 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id j8sm2302302lja.32.2019.11.05.02.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 02:24:36 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:24:27 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/62] gpio: gpio-mvebu: Use new GPIO_LINE_DIRECTION
Message-ID: <dc06a640f92c4b6c1ae68f5b3156130a6b8fac1f.1572945830.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1572945830.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572945830.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

It's hard for occasional GPIO code reader/writer to know if values 0/1
equal to IN or OUT. Use defined GPIO_LINE_DIRECTION_IN and
GPIO_LINE_DIRECTION_OUT to help them out.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/gpio/gpio-mvebu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 6c0687694341..9b2adf0ef880 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -384,7 +384,10 @@ static int mvebu_gpio_get_direction(struct gpio_chip *chip, unsigned int pin)
 
 	regmap_read(mvchip->regs, GPIO_IO_CONF_OFF + mvchip->offset, &u);
 
-	return !!(u & BIT(pin));
+	if (u & BIT(pin))
+		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_OUT;
 }
 
 static int mvebu_gpio_to_irq(struct gpio_chip *chip, unsigned int pin)
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
