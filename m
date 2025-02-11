Return-Path: <linux-pwm+bounces-4845-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE6DA30B39
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 13:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE927A1959
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 12:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A714213240;
	Tue, 11 Feb 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="09VUB9Gq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E61FDE35
	for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275809; cv=none; b=VFS5f+HQQi4nwf5lO/e+SmQm2R9fhhMC1udEfPZ0RgzX1kU6ReCAPoc2aSw0xz1kdtgcQv35inlV/eQqoua6qnxUdR36gK203+wSnvNxw41WyC0Aq0Y42Ec989ptoLhYV81lo1GP2PIMjL+BTic4uCOIJLfQcBK4MoO1hO6WC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275809; c=relaxed/simple;
	bh=caKhfxtRFMp/EYZR8ylZh3Qlurb7Wy9UqMcdz0OG2as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lzeZQGJPv2vvalQ3imMmGWx2dCiCQTPbNCofQvckIAP20wnXY0gcQmCr7JoTZiBnKokepAn/qMRcu9c3eUYeJyIY4VcfhiAmWqQbCrT1KO1T/icrpFw4QUOjKTUp4csFKsOaCy7pIoQMmpMfWHP4/OX6LYZZF0HWIOXxapgb8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=09VUB9Gq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38dc6d9b292so2298885f8f.2
        for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 04:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739275805; x=1739880605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YB5pK+oicJDwPB8Q0nFLhIRVf54jMTA5bcMsE6iZ+04=;
        b=09VUB9GqdzNkKIr2xORY+cZ+vFaigKWdkg2V+alYu0mFG0rViMoheV6DX7TE/0UxCR
         hLyPoaAp5gO8Yi3PwjRMBW+5OuvI6ujfNGx0yyaYxYGRaamIdZbRHYNiUE0ybE1Tm8+Y
         l/ngD6YHIGa6ciMSA73voMmRK0AOL9XOEBc9Jj2i3lnODlhUin7NtyOtvr3I8jz1gxzU
         3k6w5114GB021WP5qziSgf+N1iGjMW2AOl5KPj2O+sJjNhIDPwSeCR3qBv4sc+mLXVCV
         M6a+vwaFOCbV87KehRyFTUkGeKaQ3QiRdVpEFIFHIIn+xy5DYJGdjHU4qVgPf8qYW9sg
         YGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275805; x=1739880605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YB5pK+oicJDwPB8Q0nFLhIRVf54jMTA5bcMsE6iZ+04=;
        b=Qza3HqXWrbod5r2qANj45RWnfb3hQNhjYrJvKlWT2Y9lBBYvlRCzobTqwaI0wfAc0O
         ivZLlb3iEqmAxqNmBacgG8HR+SOlUcuriqk4lcweipYiP7rkvmNxK347ug3ngx3GGZx3
         VxxhEndbSJwunc8adkwSNOGlj2xcLXG3vaj/GIOai1E4szZlxkUZy8RzdxynT4O+qj3r
         /luzFdt9Pgb12l4uy8kiiC/rqlenfeEypOobAZdQgIRn/XIO1ZD6gvxDvoSNP3HYYHAQ
         E5SDA2CswCX/HLql6Ughnqr4fJMhtfx/Xk0Oi8J1+HZ0qK5auhPnTMOUpvc8C/fb6nNI
         Qf6A==
X-Forwarded-Encrypted: i=1; AJvYcCVeyQoH/+V5PoBl/qe5W7UYYxq/+P8xfxv0ZrhR71D8Nx5XRIK1IHeWXeiMmiq6B0lZ1vlXN00rFxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1R0vrhjMPGkklH+8TIBEVR3LmOrHrqS5ATdqYUGcH/Y9p6kbe
	nriEAEy2M6tboZffkMYqkK0ebvD8rL2VpN8Va+rrFs5B3W8JNO1zwqOUDsXmdlCUAcDLUtq10ha
	3c7I=
X-Gm-Gg: ASbGncv71kwq0d3ZdDKaf6Gr/NZ7NFws3/mpqTqwrlHyi1a+93n90kWnYAjMqGJCFZb
	UkFppN+PjYLsJk12Kan4U10Vz9eG3c73QHP/7QhDvTDwilAK2njf/zFda+I0t/Tfe8XzXZ7UoQ6
	sQ8Q7ISW7GogQILY8Rq9SQO3mc7b5nzTywHSt2KzeUt3OEtUAv9ZOSbDDbN0u1z01CL/2zgz+/g
	gb38nXCEHBdr+bYmVGJ70y1H0xgMvjC5Qr19ETRksa1m+jqw9ej9ndql7wiJcYthwPN3Z/wTzXf
	audsn2I=
X-Google-Smtp-Source: AGHT+IHYHO39FYN9fqzxuulSr07JHo1uzefPIt87F1jvA2dDEDL04bAJrSOp1VwnvFvuELyXPcAF8g==
X-Received: by 2002:a5d:5887:0:b0:385:e429:e59e with SMTP id ffacd0b85a97d-38de41c608bmr2481781f8f.52.1739275805525;
        Tue, 11 Feb 2025 04:10:05 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4342502sm9152327f8f.26.2025.02.11.04.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:10:05 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 13:09:38 +0100
Subject: [PATCH 04/14] gpiolib: introduce gpio_chip setters that return
 values
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-gpio-set-retval-v1-4-52d3d613d7d3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3651;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=PqwP4DdGtYYvgPMEjhHMWkD10+jKqk8KGLWSnN3SmPc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqz4W3+44nQ16vPqyxAePOsKaJyxohjnqd0KpT
 NuNoYQsnFOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6s+FgAKCRARpy6gFHHX
 chgfEACzRCcnf+4m5DpSw182YLXuZErPrxL0A62O8H7l8svfDNzjQJiWI995glAAgJDKRyX9YFZ
 wC67eV1f25gGJbelW8EsQDfnTRQ9xF+MeQ9KuwyiTzFKynPPG+0ADusMK99YZgX3LiWZptryiNY
 J4qmtw4Yw2Q7EGIJoDxW1RvyO0QsV2YU/+YeUuTwfMA0ax/rl/7skgYhnatYv1oUFjmhMFTMDaY
 ohiUWQHczNS6Di8c7JdxqiZpE1FjgKGXgLNYLw1aSuAEQzEn4tErp8+snpfQ4IflYHkjF3PcDa0
 43IzeuTvqAW16p/TV41sMQMLK9EJCdlUYRMIcDWVBD5SYHenZkgQNguX/h+XewNbClO/15nqZgR
 v+JyOxCaXi44Vzpx3g9jU27XtaVNtF/RJG6UC9LM3YsYA9QJiChYhTZ2a93xmLWIg4fN/b8kqaP
 TAKroL0sQgaD7OCISNstYXxUL9OFZtwJ5I7z3lHFNT28Lxyd3iP1+4kXgTYb1dIjlKJPn3S/p7n
 UrDNEsm2Svti0jVMoX/sGpX7n97oFT1Sp2U83iN2MHHRFWisttHXm9n7ow4I9OEWXQZjVw9DPdf
 LXEoQ7ULJtSZS4+2aci/n4zgVqfNLF7E003IooHaW/yZSrReVTfz5Q4++15HttkhesFpI2HofOQ
 Li1fGOyaUEQBWYw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add new variants of the set() and set_multiple() callbacks that have
integer return values allowing to indicate failures to users of the GPIO
consumer API. Until we convert all GPIO providers treewide to using
them, they will live in parallel to the existing ones.

Make sure that providers cannot define both. Prefer the new ones and
only use the old ones as fallback.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c      | 28 ++++++++++++++++++++++++++--
 include/linux/gpio/driver.h | 10 ++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1f078a20ce3d..5f3a8f1b7757 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -926,6 +926,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	int base = 0;
 	int ret = 0;
 
+	/* Only allow one set() and one set_multiple(). */
+	if ((gc->set && gc->set_rv) ||
+	    (gc->set_multiple && gc->set_multiple_rv))
+		return -EINVAL;
+
 	/*
 	 * First: allocate and populate the internal stat container, and
 	 * set up the struct device.
@@ -2749,11 +2754,21 @@ int gpiod_direction_input_nonotify(struct gpio_desc *desc)
 
 static int gpiochip_set(struct gpio_chip *gc, unsigned int offset, int value)
 {
+	int ret;
+
 	lockdep_assert_held(&gc->gpiodev->srcu);
 
-	if (WARN_ON(unlikely(!gc->set)))
+	if (WARN_ON(unlikely(!gc->set && !gc->set_rv)))
 		return -EOPNOTSUPP;
 
+	if (gc->set_rv) {
+		ret = gc->set_rv(gc, offset, value);
+		if (ret > 0)
+			ret = -EBADE;
+
+		return ret;
+	}
+
 	gc->set(gc, offset, value);
 	return 0;
 }
@@ -3475,12 +3490,21 @@ static int gpiochip_set_multiple(struct gpio_chip *gc,
 				 unsigned long *mask, unsigned long *bits)
 {
 	unsigned int i;
+	int ret;
 
 	lockdep_assert_held(&gc->gpiodev->srcu);
 
-	if (WARN_ON(unlikely(!gc->set_multiple && !gc->set)))
+	if (WARN_ON(unlikely(!gc->set_multiple && !gc->set_multiple_rv)))
 		return -EOPNOTSUPP;
 
+	if (gc->set_multiple_rv) {
+		ret = gc->set_multiple_rv(gc, mask, bits);
+		if (ret > 0)
+			ret = -EBADE;
+
+		return ret;
+	}
+
 	if (gc->set_multiple) {
 		gc->set_multiple(gc, mask, bits);
 		return 0;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 2dd7cb9cc270..ac42f0164d5f 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -346,6 +346,10 @@ struct gpio_irq_chip {
  *	stores them in "bits", returns 0 on success or negative error
  * @set: assigns output value for signal "offset"
  * @set_multiple: assigns output values for multiple signals defined by "mask"
+ * @set_rv: assigns output value for signal "offset", returns 0 on success or
+ *          negative error value
+ * @set_multiple_rv: assigns output values for multiple signals defined by
+ *                   "mask", returns 0 on success or negative error value
  * @set_config: optional hook for all kinds of settings. Uses the same
  *	packed config format as generic pinconf.
  * @to_irq: optional hook supporting non-static gpiod_to_irq() mappings;
@@ -441,6 +445,12 @@ struct gpio_chip {
 	void			(*set_multiple)(struct gpio_chip *gc,
 						unsigned long *mask,
 						unsigned long *bits);
+	int			(*set_rv)(struct gpio_chip *gc,
+					  unsigned int offset,
+					  int value);
+	int			(*set_multiple_rv)(struct gpio_chip *gc,
+						   unsigned long *mask,
+						   unsigned long *bits);
 	int			(*set_config)(struct gpio_chip *gc,
 					      unsigned int offset,
 					      unsigned long config);

-- 
2.45.2


