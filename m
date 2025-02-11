Return-Path: <linux-pwm+bounces-4844-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD70AA30B37
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 13:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C283A42CE
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 12:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D076820B81B;
	Tue, 11 Feb 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Rkr0OOAl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643AB1FDA94
	for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275808; cv=none; b=CitLm0XknaTGKGYNSkAwjnsew7iWIdVnNYHq6rOdTITB0xivuv2nrmSiQ8CsyU0vPD6iOrMzd98x4Q/D2N+r1qAQMiR1urTufz50gvZQAASabraDlzalhswkpdw3sCgG/Pbpp9gkegltdEpoI0hEuDNYBwvizApnamuMaFMf9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275808; c=relaxed/simple;
	bh=B8vjA07aGlepGS0i+Pd6WcAWx2f5Mn3tNczFpPj4Lw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gfSk4sv7/xzyb0lf3zzGiHGcNtTFeGpYGlXbH/ULH9Y5IKtCP69o3r1k5xiEbp9dFnUohJsSoJHrGg6S1wu1SFMvLjPy6ztMmm5M1T1Jt3O1AZ/ylGy/60U4Jdo2Z1MeRAG9hAjn4zaf1/AJBAclry4+ZabS0RyyRk8ld5WPBhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Rkr0OOAl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394820123dso11587295e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 04:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739275804; x=1739880604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+BbFMd7n+K+mqNfr4cyQYVRFXSPQTKkfNEUIIhkMJo=;
        b=Rkr0OOAlrX//Ewa3iGjLIrG0U+ckTg3SHYJhYv9l16dKIO0E2UoIRoFBBSQjPMiVJ5
         esWGLEhowL4igZr9n0UgxwLvfJ9G11iQHDuyQbzN3KAsc6+KTkIthRG0lc+nH8sI3YB1
         oC0gbqspQLn6ncCvMSj4jBybrwd8Lah3Mb4NQVglOq8nj7TqwIl7cbLs9E9h7cYiOEaE
         7XvS3+z5exDjsFX3HctwaymjB5WdmcraJ5DHE0CjmArTzs60y4+zqh9kNiBrfeGOdaHF
         MwBa/iHedpfCuHVXza+NdlV5wOK1wmtBK4K/DfXt+pzp4CQvyLKogOl2UvWHH2lSUvjW
         prNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275804; x=1739880604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+BbFMd7n+K+mqNfr4cyQYVRFXSPQTKkfNEUIIhkMJo=;
        b=xRMcM4ZUjQFOqKTQgiTjK/z9+CjPbiCsXKFaTWDfCPxiXolFNUowRmAqd7FMFn4laf
         3cU3WdM+w/pl+gxpsWg9TE0+OCY194TATlZqVwgFFEuG0XWus7cuDhv7YMlbJsEM97Op
         F99GRQpTvTtDYYX0tXh9RZcmHxeUg4PUSC6qWbnNeIbL1XrbVvdbDMQv9O3a74z74yhT
         hmMm+zTvP5GmR9ixazqBXArP4GaI9YCyzLcmD/A5DYUdM3wkjwyYhFfXxtts4NEuvfOU
         fANekh7wFj+DhDCGv/d5CWDFItr7plMpV5C4CvNODkMPIdjl0JCzkIF8LPi1bFPkN4RA
         5shw==
X-Forwarded-Encrypted: i=1; AJvYcCUGPL9W8HDbpSMD5bqNoKNmk8/fwR9jzNbLEko+gWewtyeMtDvfs4AIet5rcgc4aR6w9lusDj+PvwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvfSENPoW+IeO2j5nKxIEhHjY7j2DDElGSb2EHOJ68xQOVtL1
	aNbpe3CUS9vVGcLNmfsFIkvts8+yvuIy8Gb61CHMddc19k9crpfcWz+tZbvHtpU=
X-Gm-Gg: ASbGncv4z6pyo5TxmAf/m/lwrGqrfIbN3+wNmGf8gqFK+qD/uzFXRrvTK1xLw2g570N
	L8Q8OYZPN+dtezYL1pzEmXLkcSWyzl9zsFs8os4sr4j2hqR8KQBBgE2civ+IqPSEsdZXwAsgRMG
	Go6rWsOS0fD/QlknvpN8HQpkY5IW9grFd4cAE0iYDxhRBwDJJoyBvIU98WY8E0Hp7zCHmpKbZTI
	/dxsxTOv8Qft1u9cdUFwMhvyQAyV9ZRMECGPINtlQFe8zG3kI2VisXimHFWV0NdIFfxIE0uKseo
	tR3GTNI=
X-Google-Smtp-Source: AGHT+IEMOSwVAR4KDth9NgRCckPxsc14pAzy1Ly+pQWy5/SYHWyjS0Tny1smiur+oksg1bAgl4QksA==
X-Received: by 2002:a05:600c:4754:b0:434:9e46:5bc with SMTP id 5b1f17b1804b1-4392498ac55mr159173485e9.10.1739275803591;
        Tue, 11 Feb 2025 04:10:03 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4342502sm9152327f8f.26.2025.02.11.04.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:10:03 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 13:09:36 +0100
Subject: [PATCH 02/14] gpiolib: wrap gpio_chip::set()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-gpio-set-retval-v1-2-52d3d613d7d3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=mUYillua396qTpKVAHzLY6KYpt0/yytGd3oRzjdo/zU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqz4VVFl+RrrC3Le01DvDprJsAWF06daXfViIm
 8D6OIwU+HmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6s+FQAKCRARpy6gFHHX
 co2lD/9YmNWa2vCgSb+a5q1W7hneYy5sCN/lxxqxi9h6PHVGFNkgM+O01EX0x5ugFpujDda8g5B
 1MHXxUYpOlOxh/Fecy9M1audvEcJrtoJJJvzKngGAPV4abSAt7wTiExk73+bhFfFiwrE2tNZNsE
 FXI38XZU/VGuQqO/xWVmkPeO9LuUrgsil/Lt3HhpsYFsw56JeZfzzpm/OOvzBhzmP2SQihaoTvm
 bCRG5ObmxcLS1us6hmr2LDvwTciWp87gKfRT0MOmtSwn2purP54d/rghqEkTcaeu1QaOdAu89bP
 AL/FfbXZgdE5bEZdbL4JFSuD5NJcb14qBq2SJ/y004ZE01lP4tZ+yyQydkgYl2iuegCGGBQwqOw
 vrXlPqrHEoBWLFQOq6sNvHl464BcxGM+kRufiIfuzAB5niHC04Lk9kvzyltpl9G+GNh7zO6E2CX
 PFVbfoFPHfRPDXrdmwLjNly/7wdS6yLa2X41DLbdSExxPXWF//+TDOzqwaC2Fe3SwAWJdalo/fv
 dIZdw84jaweMHTbCqqgCHL6VfeYnQANCDgvzi3m7tpaySMgt/2BVZIw/YqbSADEkxa/vuWL8Os8
 EgkztChReNSK9YZ1co43MzazR22QSa5dlX5g2hwJ+YCbzUiXrbJ0GIyHhsC66Lw5F1WKwWh7Ez2
 tAu296INMZ+5VuA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have three places where we dereference the gpio_chip::set() callback.
In order to make it easier to incorporate the upcoming new variant of
this callback (one returning an integer value), wrap it in a helper so
that the dereferencing only happens once.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f31c1ed905c0..7826bfb72104 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2747,6 +2747,17 @@ int gpiod_direction_input_nonotify(struct gpio_desc *desc)
 	return ret;
 }
 
+static int gpiochip_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	lockdep_assert_held(&gc->gpiodev->srcu);
+
+	if (WARN_ON(unlikely(!gc->set)))
+		return -EOPNOTSUPP;
+
+	gc->set(gc, offset, value);
+	return 0;
+}
+
 static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 {
 	int val = !!value, ret = 0;
@@ -2783,7 +2794,9 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 		 * If we can't actively set the direction, we are some
 		 * output-only chip, so just drive the output as desired.
 		 */
-		guard.gc->set(guard.gc, gpio_chip_hwgpio(desc), val);
+		ret = gpiochip_set(guard.gc, gpio_chip_hwgpio(desc), val);
+		if (ret)
+			return ret;
 	}
 
 	if (!ret)
@@ -3443,9 +3456,7 @@ static int gpiod_set_raw_value_commit(struct gpio_desc *desc, bool value)
 		return -ENODEV;
 
 	trace_gpio_value(desc_to_gpio(desc), 0, value);
-	guard.gc->set(guard.gc, gpio_chip_hwgpio(desc), value);
-
-	return 0;
+	return gpiochip_set(guard.gc, gpio_chip_hwgpio(desc), value);
 }
 
 /*
@@ -3468,7 +3479,7 @@ static void gpio_chip_set_multiple(struct gpio_chip *gc,
 
 		/* set outputs if the corresponding mask bit is set */
 		for_each_set_bit(i, mask, gc->ngpio)
-			gc->set(gc, i, test_bit(i, bits));
+			gpiochip_set(gc, i, test_bit(i, bits));
 	}
 }
 

-- 
2.45.2


