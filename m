Return-Path: <linux-pwm+bounces-4850-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E647A30B48
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 13:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27F21679C9
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 12:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C49221D92;
	Tue, 11 Feb 2025 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LQ1N6gAF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407821772B
	for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275813; cv=none; b=Y8Uwmolt+QgAGoPH0y0yom74fG0nttyGzT/rOmvby8cT0BR9C1bhRDWQE08pBbJk7Uo/lMB3DHfafdPqp6NMf594R8VnSgDAox5ztp9eikyEeht4FjxmnKlXKTmOB5d2CNsP+WD4WeEBKcP17GQ8lsALbOJB4bppifvUCBKrXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275813; c=relaxed/simple;
	bh=W0ekafsbrVCouZpHE4eG0kXHeAxOvTBzf5r2BK5vEgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElkZKBwUw/kqwiygIHPc7BLkTaBOEXkv2gMchcj9CPMhO2uGzHfpLVUTNA/MgUGzp1Xq5b7GWw5/33vEhwDNbGa0EPlHFXSyHRxjvukEyCcb+nzc9JbeDUN/aVE1yYzUcRZjHjNxJf5Cfll7Uk8QVDwDsbtKb2tnnvQQb6t3zaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LQ1N6gAF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so2814097f8f.2
        for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 04:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739275809; x=1739880609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtZyccNtwz7GO7SMXFqCDx0hPJnftyCPvzbSn44YoNE=;
        b=LQ1N6gAF44G3i0RoMT2LSXypHBoyDWDAQSr5AbUGO2h0l+T1kFnpQKouEdFNKTznjl
         zVhOi/9/cSkRmcJKx7IBZU3Cg2SeCEPNjt1K4l2ThRhh1Sz7db2OFOfIaBgXlIihlZ8m
         DRFgwRXlRSfFd4QbDIEaj6qARbpxNk7ctPGIkknz8LakRMVtgXR+kExSop75zy2xdeFu
         MSYtDVO3UmelVfJPLk9BolpB6XF+G4BA9TdEN3LTFAgF8g/JyCqFXzu3luIaDOWEjhVY
         nbs2RDKw4S5niTvfpZNDSx3Ll4LlJPflTO0qHT9dql9tGgAt0sSG1G67CKE/gl3TNvbF
         ZRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275809; x=1739880609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtZyccNtwz7GO7SMXFqCDx0hPJnftyCPvzbSn44YoNE=;
        b=K8ptI3SLnTM8NYvE5fLPR2d8CyAduvdMR6IaIqXKOLs70n3gtXvGeChIi/PzfY5xJM
         HIp2GtntSaFP0Q43KMnTQCT2+RGDY1qxt/1pPoJU5Myn+yMY8lFnTWepaCWvRp5ceHbV
         JMNS/eB9ZYoHFEM6/z70tnbZj0Sb7Npdd5mSMITKt2xeTF8eL44W3m0ZRz72FaB4Ctz/
         QlwYlaHiPIB/PpApR+czrucTEhjgWxX9NqetoYRUwD0HIJAQMr7M9gUO+RRxrFrH5CfQ
         QD3NFqOayw5nJWBw0FWBA0nTcwhZlQLWqx3d8h3x4esgqpWC7CJcQtWgSl3bD/mrju0B
         tdrw==
X-Forwarded-Encrypted: i=1; AJvYcCVgGngXr/TNV9nbaR2QZN0+eNUCGDCXWg+FGBG/Z/p1yJGh5Gfaiz/pWbuB7DeRFO1f8pMjBk1bxac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVmUi//5KCTpKTs2iq8sgO9veMBF5LTvCvCfD4nq93XeozBUEo
	XmvFZfllEW2Z4TniqTis00/LYvOLsnw5sgsDOgku3+0Q514A/VEUt29j/21W3gc=
X-Gm-Gg: ASbGncsKMz4PHT6e1c+C+A8P+3d9ZVGjPsGkacIii/R5bXmZgMfh1YaYy3l3TQObVnv
	4MpcmTSycUzWoNgs2fc8F2FMUQk8j50KXhB5qWPr9lczVTGCYhzuPkL+1HflhFVLNPFTp769UdC
	X4inJFMJFazrzc8n2a60xDAFj7g5RJPJ6Xm6jRowloEhr33ozh+jKi+0IVUMkjo02YzTI1fBh9s
	c/l1AjkiTpUdCFD/oJklMd4kABb8naph7cNrEM/FN2hnLy9yeC0Wv5LVm/4SZGBjWMBnmzTHAMl
	me7+2I8=
X-Google-Smtp-Source: AGHT+IEnMvyoo/QZ56r8MZxIXYEgI1p/EiVTUGp+SJgZOcRGb6rK51NPgCINgZNfS+tUEAg8bAFofQ==
X-Received: by 2002:a5d:6151:0:b0:388:da10:ff13 with SMTP id ffacd0b85a97d-38dc8dcbedamr12335513f8f.21.1739275809307;
        Tue, 11 Feb 2025 04:10:09 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4342502sm9152327f8f.26.2025.02.11.04.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:10:08 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 13:09:42 +0100
Subject: [PATCH 08/14] gpio: mockup: use value returning setters
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-gpio-set-retval-v1-8-52d3d613d7d3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2141;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ZKO1P8iGSR8T/mvTR/tsiumsFS1ImUO8BGNiB+Z+36c=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqz4Xx8lzJ1ICR2vtBS4GXgsgBRjKJMCyceywC
 7CgiRlNo46JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6s+FwAKCRARpy6gFHHX
 cp1oEACzhDjjFDZacvqn5bV9RGmwJ9uZnfrey2XQS3uKQSrgo058tYNz+DeubiHU6KjXVtjzujb
 wOv5jfsozxQ44d/DdDyKsRfUo5Ya6a4iTpO/6jqs81QXhMzUxwu6Xjk9HoVe04CYx2cJrBQmBWs
 fTsbBYosqQQM58XIPEnfJpUiDDB8UNtdPdsuzhsc4vxST12HSsMQkUdKGGwW+8N0FU1utfBNFgr
 SUZlJO51yem9WmIpMbCrWvMi1DfJ+2H0nMxrSgjWHUaUPAG8pYxndyR1B85/xd/Htdpz/kf7a/6
 7IoctrQA6CETrtiKJ3y9YJTIoqzwwLm0j+ItcP9OSW90f+QBnk30JJmZ0/vfA48uUTDYQo1nmim
 PuxV4RmnmtPjm5lACx5TPSKJ4V6xhBDK7Jn7SXo0zXylkwDEqGGO7PKvTwpKHqOyv+/h5Q1liza
 yctgepn3XoT2ZIgQrnz6lus+p26+ar5/Occm58lizltZHsYkVnatwISuNPzaOCDaNLoCIbcMU+5
 IJfSwM4ZTK9r9NIpx86h5gJvWnAeTM3WimaIspzhNU0zkvg+4U07DD/2tHgpdMCCufllr4HbpsU
 Hxa/xECE+TXScoqq7UVOv++YwHX77gpiBYzpqAf4gwLfhfK3PflSSSpFGn1EvKaSY+9YdYgeqJQ
 uBqgEKb+uXW7YqQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mockup.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index d39c6618bade..266c0953d914 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -122,7 +122,7 @@ static void __gpio_mockup_set(struct gpio_mockup_chip *chip,
 	chip->lines[offset].value = !!value;
 }
 
-static void gpio_mockup_set(struct gpio_chip *gc,
+static int gpio_mockup_set(struct gpio_chip *gc,
 			   unsigned int offset, int value)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
@@ -130,10 +130,12 @@ static void gpio_mockup_set(struct gpio_chip *gc,
 	guard(mutex)(&chip->lock);
 
 	__gpio_mockup_set(chip, offset, value);
+
+	return 0;
 }
 
-static void gpio_mockup_set_multiple(struct gpio_chip *gc,
-				     unsigned long *mask, unsigned long *bits)
+static int gpio_mockup_set_multiple(struct gpio_chip *gc,
+				    unsigned long *mask, unsigned long *bits)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 	unsigned int bit;
@@ -142,6 +144,8 @@ static void gpio_mockup_set_multiple(struct gpio_chip *gc,
 
 	for_each_set_bit(bit, mask, gc->ngpio)
 		__gpio_mockup_set(chip, bit, test_bit(bit, bits));
+
+	return 0;
 }
 
 static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
@@ -445,9 +449,9 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	gc->owner = THIS_MODULE;
 	gc->parent = dev;
 	gc->get = gpio_mockup_get;
-	gc->set = gpio_mockup_set;
+	gc->set_rv = gpio_mockup_set;
 	gc->get_multiple = gpio_mockup_get_multiple;
-	gc->set_multiple = gpio_mockup_set_multiple;
+	gc->set_multiple_rv = gpio_mockup_set_multiple;
 	gc->direction_output = gpio_mockup_dirout;
 	gc->direction_input = gpio_mockup_dirin;
 	gc->get_direction = gpio_mockup_get_direction;

-- 
2.45.2


