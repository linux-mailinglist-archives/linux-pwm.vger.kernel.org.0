Return-Path: <linux-pwm+bounces-4853-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4179FA30B55
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 13:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EFA3A8A16
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B760C1FE44D;
	Tue, 11 Feb 2025 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oq6wrCJn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D45B1FCCEB
	for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275816; cv=none; b=t08k83VezTqE9738+Syl4+PtBXhOiJHD8xnLNDiNgyhU9FXXdB+ILYCXewsibkI8jYN0TU4RHwvWRuvvo3dC1bZC26NkfqR3bfBw1HqhhLSk4P4LceY03gi2RT3Uq9SCmYijWNS9Cb+Ri8AeRzW7isV3KZ7KiXHnSmQCw9JYmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275816; c=relaxed/simple;
	bh=/iCqyNtOnVMnbbHM/gy8ix4eEtzaJskfGUpAc2pSNTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAqOnif3H/vcSrdWd+UoLTOz0idR59DI2z+j0tTFbOcBtJRGhrLc6V4py5Up5ZtUfw++1RUupSJRjuFSI/C9eL4qb8C+5REN2h7bYqolw/l2KCloT52G5KwXixwjbB6nZxCovSGb6YcisJer5EUjwW/y1T921bXqajA5pS+4t3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oq6wrCJn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439473da55aso12432525e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 04:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739275812; x=1739880612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTYoMr8LVW6oql9XQW/RHXmZcd/4RwEHGY1djKLQY6g=;
        b=oq6wrCJnQ7o0qF64Kkguipp4CjnhpaC6ESDxSOia6H/G+Ww4m8I2O6RhS8XkDGHvwd
         rVHyS3kBCye4/gRwGntpG/RwxnrAHaBjtMx7Ils2LB5T2UjQGCo4PLIMTXJhv5GenVZD
         Sr3yvimFvbAoduEoCkhyo+e8xf32hIKLDK5mH9hLGz1XNWpwEkhmBMMcE66sRO6jRy1l
         pKmV5t5MjXwMf81ZOjVvw1piRtkF9+vpFs3F26zKgPlDms8Ff3Q+8YClsVEscQgSmE+R
         YBWhXTvXTpXOwt8fdR2nI05RB8/Y2TEasHjDsVTmfIkvZthvvdEsFi2E4WN3cSWufK78
         xLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275812; x=1739880612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTYoMr8LVW6oql9XQW/RHXmZcd/4RwEHGY1djKLQY6g=;
        b=FRH6wlXTUJYeZYeVsu+n5GTjTgfoctOlVY5AzflT/IH/VakCZCQqhBGJahHxwGC/gb
         P73KDtvQzzx71DLYJtWWW9RZ5KA3In9Dh29cNVSuY7z6vrZVvKaeovY4hr1jJZFFppZJ
         +30NyzFqC0OdeK6BqIVB71FdvBh6UctnyIGkXgsyhkNZNXf/9g2riUFbB6GGt9P4L6IX
         cP78sihn31t1PWXCpp6IwGMifDYP0RTLXFN5IQNQDKygP8/N9PM4p4fSjZ5myEY0cQJl
         j5wzHVw26gKtxrtjGCKWsx2gdzA3wQ4H2DjlB+RVmC88xnH2CLDziaQKP0eaWGzonYa/
         1f8w==
X-Forwarded-Encrypted: i=1; AJvYcCXCzlPF3M51Q+Y+eKM8xjmUkMk6yLFKZrk155FcYhw3tVp/jiC45iJ9GKBqA6Sn9Rj1vtbUgfHPIS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kwWIV+z7Ubb7okgdpl6bYP7nS2wrtArzVqiBzMxudscaq4O6
	mYy5otulwYSzOSVVfRNiEgEaYRgnUgzBVafauZTNfmXvmTD+iKau8JyjAV0mEJs=
X-Gm-Gg: ASbGnctb15CV4yxfls9p//EyZ2PQFQe8k7v6MgeQ4QtrFQOJBXkBJFZrC0uae6LXZgv
	waKnzttI7Bxe2/DoIWMlDzua49Za8JZTbCLa7jUofmNNH5zZWojmpPrsQ069hwmKyEwA/uwG1Lf
	WsteVUACBV4ckvGLTC1fmsJJPgXD6bUTFtDvr+EPGxKCSVbyJjRpMrVTCCWDtrRWYnaWoXee8Qr
	r+HSOD7UAr8hDSdpcO9MOVtVA2N2giEtk+/CFP8kc6kw4/lD6hTGAvzJADbLKHS83OhLMLiICO3
	XdW09vo=
X-Google-Smtp-Source: AGHT+IG7wcpRxpYqNTSatf+2VHR59C3o2yV9oqJ8QNDyjYyiCGKyAQj9OAlTJV+OD1flLjJBjZ1EcA==
X-Received: by 2002:a05:600c:458e:b0:434:9f81:76d5 with SMTP id 5b1f17b1804b1-439249abc43mr135309205e9.22.1739275812541;
        Tue, 11 Feb 2025 04:10:12 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4342502sm9152327f8f.26.2025.02.11.04.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:10:12 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 13:09:45 +0100
Subject: [PATCH 11/14] gpio: latch: use lock guards
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-gpio-set-retval-v1-11-52d3d613d7d3@linaro.org>
References: <20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org>
In-Reply-To: <20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>, 
 Bamvor Jian Zhang <bamv2005@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=h+cWYBz24KdzBpvy5VJxnnE3YDAW9zbdVpnPgLfhLXs=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqz4XmMjvRWj0VIMHiQ2Plb6LzU0Rt2YzZJCyM
 O9agC5YB7KJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6s+FwAKCRARpy6gFHHX
 ciSFEACmHs+cc7n0U2drgKwPJN5BRA36H3RTLy+b8s1iKC99BlEktOi67G1rUJA+b1fff0TqzIv
 smAu9c6tzmEpnvAMNDUZCrw4JpCdRuzGQGZ2E0Gxd/42V4aFeFGpsXur/ah/PCdhmTHdb+JASPe
 MGwcy7D0bRei1p1yQv3dWA60H4l4svOXh1tWK/XG1vYM5+AVj9IRmK3NO3/7BJLv13J4EMT2OqQ
 Ck9X468FsXxfBaS7Qv/JX0njiYfgw8Qc7sgMq6FtpqN+JUh2bQK22nY7mV45mUBpybLAyt/J3Gd
 N9X1Otv0xTqoc7bAs7QAJBw2taGRqbaOVZErbgYfL8dpjhx6dWNnV2N+9wyNNevq2p1TGn3eNAA
 mhtqGnjvRj1pbGkuaPPqQABqSkXvIqpuwyKrghqQOqka3rL19diU3mKaB5G/surlnGztcpDTTs8
 8YqbHI0MKhDNtm9WYcjEdwz4n1loQeP7jLU5tzALYvehZCpOfbpwFnYlB2byi+LoE2Gs4tslKaJ
 9G78E6mPs1g1c5Zw1N+FlgXKHYqD7eNXwHcwodQ+eIGr5bHSeTOfwI354KEvVZcb88roh7fQAly
 1D9bxWsZvoMtmUMWGBvvDWB0zqYoCZf5TXrOdMjvWneAZM+Im1Tuvd2uv+thdPbvrW0M6VhRI8A
 dY6ClfQ2mYQv9uQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use lock guards from linux/cleanup.h. This will make the subsequent
commit that switches to using value returning GPIO line setters much
simpler as we'll be able to return values without caring about releasing
the locks.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-latch.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-latch.c b/drivers/gpio/gpio-latch.c
index e935b3b34117..d5d3817eea67 100644
--- a/drivers/gpio/gpio-latch.c
+++ b/drivers/gpio/gpio-latch.c
@@ -38,6 +38,7 @@
  * in the corresponding device tree properties.
  */
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
@@ -93,24 +94,19 @@ static void gpio_latch_set_unlocked(struct gpio_latch_priv *priv,
 static void gpio_latch_set(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->spinlock, flags);
+	guard(spinlock_irqsave)(&priv->spinlock);
 
 	gpio_latch_set_unlocked(priv, gpiod_set_value, offset, val);
-
-	spin_unlock_irqrestore(&priv->spinlock, flags);
 }
 
 static void gpio_latch_set_can_sleep(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
 
-	mutex_lock(&priv->mutex);
+	guard(mutex)(&priv->mutex);
 
 	gpio_latch_set_unlocked(priv, gpiod_set_value_cansleep, offset, val);
-
-	mutex_unlock(&priv->mutex);
 }
 
 static bool gpio_latch_can_sleep(struct gpio_latch_priv *priv, unsigned int n_latches)

-- 
2.45.2


