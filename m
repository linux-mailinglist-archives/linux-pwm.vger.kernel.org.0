Return-Path: <linux-pwm+bounces-4948-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1081FA3D593
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 10:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D193AB1BD
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 09:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937E31F130E;
	Thu, 20 Feb 2025 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bcoSw5au"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C551F0E33
	for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045443; cv=none; b=KJknGJ3FqKTgbSfeWVmS5C8SCgfb8h03PvWs6eesyQfXTXvNUQnKvzWoWekkKoADROzGAE4xTjDa2vKtEiWriCNtGGgbpfQ7seYyvrLOxCtA5AhV2/bWXh/hPOEhZ6xJEsqXhJzv6vm2zaZbYws37eBZ1NFg5bUVwUKnvroLMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045443; c=relaxed/simple;
	bh=RNJNJ+PGyKQWS40w6Hglqc3fY+OmbLq4bUxyI0fU5t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3B8g5BgNNwFFa17J56FAHE3tllpPgQD6YtFEmADt/VpgH2RQo3ZsgO6wCjc5oh5gFBCvJzKngFheKSIebo7MmdYkxaT17ZU1F5/j0iaBhxtPk9lFwWr+4QYHY0v9X2fiukwQ16KUWJZYuiJjBPYTYdKoOKgFydpzELjHNVw+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bcoSw5au; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f403edb4eso379336f8f.3
        for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 01:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045439; x=1740650239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oK7z7kPUwbiYR8aIbiZmR8S1YTF2yDqL+/19TJNz4qU=;
        b=bcoSw5aunqwrL6ZajzVcVRxUXc5NcSS2kvRpzZtQbfOgXtL9HYJrW5Vfau2I9LWJoi
         67OP3og8RWFBii+bq3u3YyyF8BlQbQ/xEJk9oswHri9bd2/3U26LpP0lcQ/GNIN+adkj
         3ToZhhXQxrakU+06HsMmoV6u48RQFHjse4Th+pItxkqiUN2DCGuUEtdAanuSLO1YNQnW
         PfaQ9FCP8EW3q4kQeeTPz9yuvvVFjinLDvw2yeRdvsro/ZADYcJgO0TjOH9OowIkwtnF
         xdmVKA1bL8lyGfYvaS2m99jD5R7kADRJ6YS7TA2/GnSYR77f2R5Fxf5vQu+oXs1rYWy0
         XhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045439; x=1740650239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK7z7kPUwbiYR8aIbiZmR8S1YTF2yDqL+/19TJNz4qU=;
        b=fq2GY3OKgsHY32syginVK5HPpGUDt2UI+yQGbcWTjggg0WzRvQkJmXyZyoF4F+QRU2
         /9LuH4u9WwnuhNmbqadOh0F5VkojE6KD3lh51GLMOYnIgOP/qy7PPYJZvmUI73EjBf+q
         a43zHuzt+UhlDkLyzS8szYi8BecoURnrsBzwkWDBSXnr5X2WOYyynbW7XFSuNJ6g0UN9
         V/NO0csWC7Tn+0ZHlLAwMhKT+dQfHXbYrspXu2cfXX6u0uxcJcTnU7ip7d8o9mx2WuQc
         lR5PJTAfsfWQs++Q/SkhLt8TVrCjV6wIgqnhc5kRQ3W6iZ5RzyqcI8i3gIO84e4cfr10
         gkKA==
X-Forwarded-Encrypted: i=1; AJvYcCUfnPNZGF35uu5P/44+vk/93AmBMntXQcFnW0Mo9rqr8/e8SzniO0am3v6tNGLehH9AZ144F1J9gRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ywFgs9p3hCAw64Atb1WHgsdiH3P0yO87b1t1ePjmaLfZn/1j
	bK9gPjtKE/qGxOlQ2g37T7IR1HC/n76X8VZz82sVkcK88P5sgoVvw2x5VouRbOE=
X-Gm-Gg: ASbGncuCp/YU9GxopkCL7tLu/TcNl+LHPnIhdpzm0iHyDEACoQ+PKifEU0OEtdTKy7j
	H2ctd9ZiRRRtIgl0zB8r1mRlF7Dp9gOX5aSXFYziHSHUnEY32jXrgKwpTFIC+/NFkDX32+rpxVW
	v7n+LZSi5hLNd8rknjnSH05yvN5ca03YVuQz/sXmU6REQJ2d8vl0V+CCbtrHDarWuRTgAXCrJjP
	vTTKvogdXI6vmd/UK5cVAP0FiSYzhfmne9yWx5AeEFU66CDQgAD6jBwTGMrM2VCuur5dN8HNDDc
	tDD4TsU=
X-Google-Smtp-Source: AGHT+IHdxXE+wkntxsbZcPRj34UPFgSF33vvtbpTzksheLUargpon2xXaSy37ux13ny+vp77dBRVMg==
X-Received: by 2002:a5d:64e8:0:b0:38f:4308:e552 with SMTP id ffacd0b85a97d-38f4308ea65mr14863294f8f.14.1740045438946;
        Thu, 20 Feb 2025 01:57:18 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:18 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:57:01 +0100
Subject: [PATCH v2 04/15] gpiolib: rework the wrapper around
 gpio_chip::set_multiple()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-4-bc4cfd38dae3@linaro.org>
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
In-Reply-To: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>, 
 Bamvor Jian Zhang <bamv2005@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3176;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=/NIPd7ogpCDV54abkx+5Qvd5OSnBBOxjUL7k4561kEw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx2hTPlqMvIbDt8rrDsNS+Jz72qIvaMe3VD5
 07XlnC7QfaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8dgAKCRARpy6gFHHX
 cmmJEACdZa0JZ8nPMZNjF3M1FUSZMRLt4T/dfJhH1y3g6AJezAVkjz++qC6PaEhyC5iu4HiONj0
 TkLxXdykhwv3wbH6rzcwQFYp45F4ONns+8PAxRDGjJmuNUNObix/7BzDKGcR4vwz/HLAZsG6tzX
 4dciGqQ7ph1oXOzJOlCeETaPJ9JBI04kXW5GrKWK/FJ3UknnBf3h6Yzgj9PrGMuM5h1wn1pWgwx
 PkaAe0q9rnxo9uLZDEOwCvI5/2U3zqMrRedQKnCEFZw0cfUwIEC4JlLsPXkMthLPX+e8y/+9CAp
 pIuBYR/atk83zkrBFeIgpNgesPl8F7zvZaDi4A8KHZ9APBZnGY9el8xBAxgXqQjK0vy24c9BkQL
 aRO2XSWXAyCmyaa4LBMuv6ah68zrCaXyiEmjEZPaLpBnRNbisZXgh4N4CMbgU1A5AIVo1S31Tig
 IzMs8sy9Caw6Nhf0LxQggvBLayNSZiOW8Ix9Bhez3gz3rN+kgMBYJa8vg3qFowajuG7mbpBEaz7
 mzOCMsDqSLx0LJK7+JGjNpe14MYUvBycO3y4m/zF4jNENDspLWciqjGMuWxoSxmAqGc0Ry0eqrw
 KiG8IrckaPV0CiEhcLBbFWeVqjw1Ws9WQ9R/yrR+8Gs7+KQRJOGHlpBiYQNPBkxPlaWVTCmgImt
 dfU9MnqKzV2zD9A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Make the existing wrapper around gpio_chip::set_multiple() consistent
with the one for gpio_chip::set(): make it return int, add a lockdep
assertion, warn on missing set callback and move the code a bit for
better readability.

Add return value checks in all call places.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 040b4689eb8e..b1e7d368bc7d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3490,21 +3490,33 @@ static int gpiod_set_raw_value_commit(struct gpio_desc *desc, bool value)
  *        defines which outputs are to be changed
  * @bits: bit value array; one bit per output; BITS_PER_LONG bits per word
  *        defines the values the outputs specified by mask are to be set to
+ *
+ * Returns: 0 on success, negative error number on failure.
  */
-static void gpio_chip_set_multiple(struct gpio_chip *gc,
-				   unsigned long *mask, unsigned long *bits)
+static int gpiochip_set_multiple(struct gpio_chip *gc,
+				 unsigned long *mask, unsigned long *bits)
 {
+	unsigned int i;
+	int ret;
+
 	lockdep_assert_held(&gc->gpiodev->srcu);
 
+	if (WARN_ON(unlikely(!gc->set_multiple && !gc->set)))
+		return -EOPNOTSUPP;
+
 	if (gc->set_multiple) {
 		gc->set_multiple(gc, mask, bits);
-	} else {
-		unsigned int i;
-
-		/* set outputs if the corresponding mask bit is set */
-		for_each_set_bit(i, mask, gc->ngpio)
-			gpiochip_set(gc, i, test_bit(i, bits));
+		return 0;
 	}
+
+	/* set outputs if the corresponding mask bit is set */
+	for_each_set_bit(i, mask, gc->ngpio) {
+		ret = gpiochip_set(gc, i, test_bit(i, bits));
+		if (ret)
+			break;
+	}
+
+	return ret;
 }
 
 int gpiod_set_array_value_complex(bool raw, bool can_sleep,
@@ -3514,7 +3526,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				  unsigned long *value_bitmap)
 {
 	struct gpio_chip *gc;
-	int i = 0;
+	int i = 0, ret;
 
 	/*
 	 * Validate array_info against desc_array and its size.
@@ -3537,7 +3549,10 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 			bitmap_xor(value_bitmap, value_bitmap,
 				   array_info->invert_mask, array_size);
 
-		gpio_chip_set_multiple(gc, array_info->set_mask, value_bitmap);
+		ret = gpiochip_set_multiple(gc, array_info->set_mask,
+					    value_bitmap);
+		if (ret)
+			return ret;
 
 		i = find_first_zero_bit(array_info->set_mask, array_size);
 		if (i == array_size)
@@ -3614,8 +3629,11 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 		} while ((i < array_size) &&
 			 gpio_device_chip_cmp(desc_array[i]->gdev, guard.gc));
 		/* push collected bits to outputs */
-		if (count != 0)
-			gpio_chip_set_multiple(guard.gc, mask, bits);
+		if (count != 0) {
+			ret = gpiochip_set_multiple(guard.gc, mask, bits);
+			if (ret)
+				return ret;
+		}
 
 		if (mask != fastpath_mask)
 			bitmap_free(mask);

-- 
2.45.2


