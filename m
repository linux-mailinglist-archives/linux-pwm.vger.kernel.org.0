Return-Path: <linux-pwm+bounces-6851-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7E5B09040
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Jul 2025 17:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA053A30FA
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Jul 2025 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E442ED142;
	Thu, 17 Jul 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nPPKuhF5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE902D3A7D
	for <linux-pwm@vger.kernel.org>; Thu, 17 Jul 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765093; cv=none; b=GN4HfIen5jUhu1thZ7jYsJb3YAsHYItxMCSQ0L3/K/IaErPqGbHhavN9m0z6vKCkmZQiFOXz8nmuw/bproL8YwXxIjjTx/qtEOLYmNEVccFu6irvw/tfwQ56eKEjmu2g00dqeqFtJlo8UXT9BW285MBhX9lDo/IqyfdAVg9nUXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765093; c=relaxed/simple;
	bh=DxA7Uo2bgydq066TA4BQ4nfW+avkOMLq4UqXbccFa6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bhAp8Hj/Zg79ddg+tMi+RBVrGsMeE+VOEQzaCvjNZIhUiMNWb3mtMkDCkqCYWCB/yHKYr1un5Q3OY0N8FqAGWj5XXboYq/FSZ1bICrM+/6j25Nq+rWvmJfvaZBctuULA1NqQ+iDZLPEuvXoGibIZV/ZriWI7BamkFcG87WJMJVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nPPKuhF5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-612b34ef0c2so1114226a12.0
        for <linux-pwm@vger.kernel.org>; Thu, 17 Jul 2025 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752765088; x=1753369888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkGzIpKY/tGSwl5AOjdyjMvkHhU6MR0YhLrgC1nQA3U=;
        b=nPPKuhF5hCbyxVAt3erR94aq+B7go01qyIFTsILmqC9nMWU4CM66hJETJUVua2B3Zx
         mVS2tObDODqgu8+SgAkmduHaVcT8HATd3jcOXvLVQKPG4zJpe+Oc7eoilQBDawk7gViI
         GpSlORe2R6/3Q2+ytX/l9uDinwOUC8QyAVcVuKr7nZj+xKVe8Be/h5jiqVUxcvgfbemF
         yWo7rH9S9tyqYVYPpbTrkgMYrKul5bgwnX/igci8l2eABqqoR48IQtMbhlEe84AfhiVN
         UHmw3hwK2r8qTOWlAoYiaDYD6ZKkCwgIt2ylp865J/v50DzQEJjo/CjcN3O/0MSGyKr7
         UyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765088; x=1753369888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkGzIpKY/tGSwl5AOjdyjMvkHhU6MR0YhLrgC1nQA3U=;
        b=HyoDF2iz0p0H6Ol0sRUsbWg0LuIimqQ4ZU9H2646oRYJHvOmxzwiTgFAxobSksLGRX
         Fg74d3aMhezt/OF4YTDGWOZXWE8hRW8BW+M42XiNpiBICVmAONqXR2sAvxZAk8P8duVu
         WOErvIhlNXh1fuhLX2dVwAUXVCkbaV27aFd3wqj5GHkfOnk4dQdZUQ6YOFvu3A+7ZtBv
         SEENG1tZ3P0ccUQ8kG5RaiDvvCdwOcPA7+77QvY4QwBCttIjtqoCShfPSC7bctmO/jnc
         G9nC+sRwsMd3uUH/Bbxe7uNCBbPFa5khqI7LnvUCWSvsFXU2ArKl56eYLrCUvbiX9MA+
         E3Hg==
X-Gm-Message-State: AOJu0YwGkgiareYfI+bKjX671w+mdZ/uKW9zatL6cm5mKQ5IfzqVkY7F
	0LwKjmAMzuSTac6KIxehFRzVddJ6WTmR5k5jHOsXYScse/ECPD3IqMcT772w2wSnkKYvgVLRo5T
	9fPpE
X-Gm-Gg: ASbGncv+9i8yWBdLKAfczp98LEDXQAQut1wnNYGEcitSTYOgwiccD1b31f0OWf07wBi
	VI8z+cVkGbddY/72bIIGkgLWxfB4Sc0YA9hs5H+E7iXjr9xTGdYyS3RVl81Xww509T/Tb6oZVas
	y5OM7FwPXKH+N7XSbxr9EtkJPbYS0oNhVZp7AuVHKaQXBp1duEvVI0mMpEHt5iF8xfrjD9RhIld
	mLmn0xe4aUD/ivlSQUSrTU1iK4xEqF3iqW19HMzjX+4Jx+niWpdnLWVvRgTImXIorVKym3arLLB
	IP5AhkGfYLdsaS7kS/wiQOxCTlSzJJJ+UyhRgIi11GQ4McVeVqNwYAI2X4QR4y9z3bhvIp5LVta
	6WoZc2A4AiMXhAvh7+3AAE6PiIjk=
X-Google-Smtp-Source: AGHT+IERPOIfyj7l1DEQPuZgN4vpBbXC9zNBzCJL1cwLdUtzmxru1RTSZe0XV/KnmctwihuJVpetBA==
X-Received: by 2002:a17:906:f747:b0:ae0:d38e:5852 with SMTP id a640c23a62f3a-aec4fc40f88mr253516466b.39.1752765087329;
        Thu, 17 Jul 2025 08:11:27 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-611f6f3be91sm8609102a12.26.2025.07.17.08.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:11:24 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-gpio@vger.kernel.org
Subject: [PATCH v2] pwm: Provide a gpio device for waveform drivers
Date: Thu, 17 Jul 2025 17:11:16 +0200
Message-ID: <20250717151117.1828585-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4853; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=DxA7Uo2bgydq066TA4BQ4nfW+avkOMLq4UqXbccFa6I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoeRKWi1khA7pl7JyL6cWX1b5KvPfEX8STf/qSD sAfMGtVpLeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaHkSlgAKCRCPgPtYfRL+ TmaiCACzSm6y/xKhbqHL35wb7I/ShaU7Py+TAyBgg/mW0UhigIZmutc4ATd2HFiOgn6wJZsX9lB 78lDtGH5VI4lGG8osqTnMeKzoRxj2Iqk8m7bdxDu3Z0Z3MUqsS5Gni2KMovbze1UXd2fc9F7uug BpGd1GPSxDuxyAuFECYs1Y5vDfzfaLqx6pyVCs1RHjlhpdPGfdAsRWnSX3pdeZwgX8gB0ich4i8 q6/h9MeH6XbA94aS7BcpDT1xUD5uOxv8Hv4cz8SJQFsJhmTyCRjBCQI0OD36LS5h4hwvf6ItI8n reCh+nuio90eYSos1Mb/QditIyd98m5Rta+fqtN1tCWwTAXL
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

A PWM is a more general concept than an output-only GPIO. When using
duty_length = period_length the PWM looks like an active GPIO, with
duty_length = 0 like an inactive GPIO. With the waveform abstraction
there is enough control over the configuration to ensure that PWMs that
cannot generate a constant signal at both levels error out.

The pwm-pca9685 driver already provides a gpio chip. When this driver is
converted to the waveform callbacks, the gpio part can just be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I found some uncommitted changes in my tree that belong in this patch.
This v2 actually compiles ...

Best regards
Uwe

 drivers/pwm/Kconfig |  9 ++++++
 drivers/pwm/core.c  | 72 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h |  2 ++
 3 files changed, 83 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 3ef1757502eb..778168e71055 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -38,6 +38,15 @@ config PWM_DEBUG
 	  It is expected to introduce some runtime overhead and diagnostic
 	  output to the kernel log, so only enable while working on a driver.
 
+config PWM_PROVIDE_GPIO
+	bool "Provide a GPIO chip for each PWM chip"
+	depends on GPIOLIB
+	help
+	  Most PWMs can emit both a constant active high and a constant active
+	  low signal and so they can be used as GPIO. Say Y here to let each
+	  PWM chip provide a GPIO chip and so be easily plugged into consumers
+	  that know how to handle GPIOs but not PWMs.
+
 config PWM_AB8500
 	tristate "AB8500 PWM support"
 	depends on AB8500_CORE && ARCH_U8500
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 0d66376a83ec..7f048e09b3ce 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2383,6 +2383,51 @@ static const struct file_operations pwm_cdev_fileops = {
 
 static dev_t pwm_devt;
 
+static int pwm_gpio_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct pwm_chip *chip = gpiochip_get_data(gc);
+	struct pwm_device *pwm;
+
+	pwm = pwm_request_from_chip(chip, offset, "pwm-gpio");
+	if (IS_ERR(pwm))
+		return PTR_ERR(pwm);
+
+	return 0;
+}
+
+static void pwm_gpio_free(struct gpio_chip *gc, unsigned int offset)
+{
+	struct pwm_chip *chip = gpiochip_get_data(gc);
+
+	pwm_put(&chip->pwms[offset]);
+}
+
+static int pwm_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int pwm_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct pwm_chip *chip = gpiochip_get_data(gc);
+	struct pwm_device *pwm = &chip->pwms[offset];
+	int ret;
+	struct pwm_waveform wf = {
+		.period_length_ns = 1,
+	};
+
+	ret = pwm_round_waveform_might_sleep(pwm, &wf);
+	if (ret < 0)
+		return ret;
+
+	if (value)
+		wf.duty_length_ns = wf.period_length_ns;
+	else
+		wf.duty_length_ns = 0;
+
+	return pwm_set_waveform_might_sleep(pwm, &wf, true);
+}
+
 /**
  * __pwmchip_add() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -2449,9 +2494,33 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (ret)
 		goto err_device_add;
 
+	if (IS_ENABLED(CONFIG_PWM_PROVIDE_GPIO) && chip->ops->write_waveform) {
+		struct device *parent = pwmchip_parent(chip);
+
+		chip->gpio = (typeof(chip->gpio)){
+			.label = dev_name(parent),
+			.parent = parent,
+			.request = pwm_gpio_request,
+			.free = pwm_gpio_free,
+			.get_direction = pwm_gpio_get_direction,
+			.set_rv = pwm_gpio_set,
+			.base = -1,
+			.ngpio = chip->npwm,
+			.can_sleep = true,
+		};
+
+		ret = gpiochip_add_data(&chip->gpio, chip);
+		if (ret)
+			goto err_gpiochip_add;
+	}
+
 	return 0;
 
+err_gpiochip_add:
+
+	cdev_device_del(&chip->cdev, &chip->dev);
 err_device_add:
+
 	scoped_guard(pwmchip, chip)
 		chip->operational = false;
 
@@ -2472,6 +2541,9 @@ EXPORT_SYMBOL_GPL(__pwmchip_add);
  */
 void pwmchip_remove(struct pwm_chip *chip)
 {
+	if (IS_ENABLED(CONFIG_PWM_PROVIDE_GPIO) && chip->ops->write_waveform)
+		gpiochip_remove(&chip->gpio);
+
 	pwmchip_sysfs_unexport(chip);
 
 	scoped_guard(mutex, &pwm_lock) {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 8cafc483db53..6e7d02c24991 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -5,6 +5,7 @@
 #include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -340,6 +341,7 @@ struct pwm_chip {
 	bool atomic;
 
 	/* only used internally by the PWM framework */
+	struct gpio_chip gpio;
 	bool uses_pwmchip_alloc;
 	bool operational;
 	union {

base-commit: a582469541a3f39bed452c50c5d2744620b6db02
-- 
2.50.0


