Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27D13BA66
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jan 2020 08:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgAOHkE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Jan 2020 02:40:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42775 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbgAOHkE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Jan 2020 02:40:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id y4so17376023ljj.9;
        Tue, 14 Jan 2020 23:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qf+dl2KRqoOZC7hVj/drFe6KbmmX/jS0ZDQZCpfZUrw=;
        b=Q6VKajxYsp9prAOt0LJ8gS1Y7dRU6ONsqqmOjGTgU4T2rFsGuW16ld0Ste3ZNGYnje
         o3yD3kiIdAu2DrMVTGuKbTG9r+3p7A6ifv28KrUNke6CXKBrURQbO7IeM1Kr3XBLoTBF
         X2qHBXfkJt8ktq4LQcz5hvAsCqUGSZmhpkNPRpOGsZQG6lIbREN/ymIVLecCZdlGbWiE
         MIkIK6k9s2BkD0oPBEttZAmyyqmvuG+KqFfb8JQpcdd2OKfkd+qcdrJDpong4TBhFC4+
         gv4xmZtu/0B6PL2yUMN8uCHf8gBnTkvcMZ4UPIba8nKi0MpuvtuZM4J43XkqMmq7Kjxq
         ceLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qf+dl2KRqoOZC7hVj/drFe6KbmmX/jS0ZDQZCpfZUrw=;
        b=AjsV/sarMWetHPQ7KkUoJ5++rJ5xyoDcKQMXZyShqelQ2AgmlTf7lOMddGNzA/ByDw
         sP3eAVc32hYXudihOdLQcD89VYCyNpPeob/ZIFe09/fv6XAwu9ihJEJGsOWJ2CnGEbl4
         UclG5t7FZjX6vYTLEPGTuQtER5MqqxJV+5Amk7y71Pa8vG2vR25c9/ZIVLjW1gmeTX0R
         gmR4oYSXT+Hedn7EmkT4m+o/CUmAtlHy0uofblDYoAKpIkoALJU6NTwGvIljpXvlY2pT
         MOQ94/XXJIFGHo+AySWNy3b027Z4KqO+JfeQDoACWkNHGyT2i7iIHd+dVcenQ3JLLdD2
         M3lw==
X-Gm-Message-State: APjAAAUOouLsWUQnP9iWhTOiR8A+0gza0+GjICm9s8WNVYV0jnw0jVxT
        rmfqfgawnWJI/gS8XOPDFaY=
X-Google-Smtp-Source: APXvYqyN0c/ZdA8ZEYIpDF2VOIKy66QHFjWzA82CgfnmipQp/CsLIT4dfat63gVv34n8Kiu6uTMBTg==
X-Received: by 2002:a2e:b55c:: with SMTP id a28mr911954ljn.260.1579074002029;
        Tue, 14 Jan 2020 23:40:02 -0800 (PST)
Received: from localhost.localdomain ([185.6.236.169])
        by smtp.googlemail.com with ESMTPSA id x23sm8388855lff.24.2020.01.14.23.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 23:40:01 -0800 (PST)
From:   Maxim <bigunclemax@gmail.com>
Cc:     bigunclemax@gmail.com, Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: mvebu: clear irq in edge cause register before unmask edge irq
Date:   Wed, 15 Jan 2020 10:38:11 +0300
Message-Id: <20200115073811.24438-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Maxim Kiselev <bigunclemax@gmail.com>

When input GPIO set from 0 to 1, the interrupt bit asserted in the GPIO
Interrupt Cause Register (ICR) even if the corresponding interrupt
masked in the GPIO Interrupt Mask Register.

Because interrupt mask register only affects assertion of the interrupt
bits in Main Interrupt Cause Register and it does not affect the
setting of bits in the GPIO ICR.

So, there is problem, when we unmask interrupt with already
asserted bit in the GPIO ICR, then false interrupt immediately occurs
even if GPIO don't change their value since last unmask.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
---
 drivers/gpio/gpio-mvebu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 993bbeb3c006..bdae0c08f239 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -432,6 +432,7 @@ static void mvebu_gpio_edge_irq_unmask(struct irq_data *d)
 	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
+	mvebu_gpio_write_edge_cause(mvchip, ~mask);
 	ct->mask_cache_priv |= mask;
 	mvebu_gpio_write_edge_mask(mvchip, ct->mask_cache_priv);
 	irq_gc_unlock(gc);
-- 
2.24.1

