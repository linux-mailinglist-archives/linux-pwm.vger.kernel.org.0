Return-Path: <linux-pwm+bounces-2373-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063308FFE43
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 10:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691411F272C5
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CE715CD47;
	Fri,  7 Jun 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w4m3BL4B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3215B964
	for <linux-pwm@vger.kernel.org>; Fri,  7 Jun 2024 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749895; cv=none; b=TD39dmxbttrXTyLhIwcRtm95sT++ce/ZbL84RrWtEo70byj3iqf227r7Yju4k/Bmxn3QrniIoqmSVpkqK1KfNvWNmXEom/uEiEfQKw/ZKPdDzR5vYuSLgOBmZf07EFWIo3DzMqvfmcIl/c1uEli8AK/V/0yHvxLxKLfKpuvZvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749895; c=relaxed/simple;
	bh=pYHQOtcajlYkO2UvuypDcCFMuwwUrbjcEVKx/JUgZzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B63YJBbhz8GNVk+HJ7W3sf2HhB9bRgpUYalW+5tRyTD2jA0grMkyXqAaw3H3Y+CxYKi0zWfcF5uz1uHgc4HdnDuxM9Iu3htVuJUMp1uJxiBcWJa1jU5CfTRwrjFA+CGCrpSB5DEkcSt2BZnw9Fy2bkgkVhNGU4UkrVoDeEoTW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w4m3BL4B; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42108856c33so17374755e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 07 Jun 2024 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717749891; x=1718354691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJ12BO1Q3zqF+jbfOVF1AOWg2ZgELy6bEhZ4o0FIEbs=;
        b=w4m3BL4BfRhRcDleFpxxX/fntOvM5UPXs+rb21CDZIXGZ7DjTUurRHp+by1mahPdRO
         gmt3uC/XD1eB7iXwp8YhiTUiYI9amKO38XPoRAfqem7JTvCfGOQ6AXNMDztygIF9a0PY
         YhEsAtVETWdgkkm1oWQ4IffNqsrTeQgYks91lu4sbZa61Sv8F8R6xNCyC9GrdU5giW0l
         Vy1Tx/Nr6BBnU3IC/POAsJuio6FPU0QjO31YDy8ls9DNFuZdgjp/BCbb8Q6i6bqWFP+0
         4cDC4Q+x6eqOfi8+wFXwOKfUzk/q9YtqVkMUYE6KJCtP3hYoThPoUKOK7U6Nz+4OOhoQ
         mSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749891; x=1718354691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJ12BO1Q3zqF+jbfOVF1AOWg2ZgELy6bEhZ4o0FIEbs=;
        b=Rp76C8lYvf7SpAFH+mtVOoTXrHoETlvpTd0LeYOS88VLQ+80C3f/2WMXp9FWIMZSZk
         ywnrTVPL3Pze7D4EaKjWGPVL1myF51ei8DoowV+G3Fjn5UEZp3N7+b1wI4zRv39HT84e
         Couw+hauI2/1U6XaAQsp/HXEcjpA0pEailQQTRYpbTLl1Zx6KxuiZ6hpz9cdar51gKEW
         fvDpgQFQBTA+cR9VlRhMmZV46rSLElIQajRs9I6fI49Q3YiD6Ikl7HOm4jB3E5NJxiAz
         Q35Y2Bp7cVWnb2Eu2ywUT77LhkLZ1kQxAcRaO9xKkDjCNNwpUp+MlPmxVvby0GLQIy8e
         /anA==
X-Forwarded-Encrypted: i=1; AJvYcCVPpNlZsfI85Rt31udWtxd6BhBJfbCiUnl3H9pXGXo1wWw9x8iE094dp2XKyr6CbJBMtdHJQJ2XU+H1Jlrodt36Ms/1GruDq88g
X-Gm-Message-State: AOJu0Yxc3HGC0wJM1N2Z0X0h0/ZJvbsCO1dEBNZueojCdWipkyC5uhGz
	TnFKtKhkgmxX0r7BQhtoPDGI+iQUK1t6eCSw29V/PpRgTgtruLDXBOVFWrpnNMU=
X-Google-Smtp-Source: AGHT+IGh+kuwHiLuK1bBWArmsRsE8afQG4h3QaPIej4FO6gC44YuXramv8tXWjYamNgw2BeRjMBf3g==
X-Received: by 2002:a5d:6d05:0:b0:351:ce05:7a33 with SMTP id ffacd0b85a97d-35efea5f084mr2365877f8f.24.1717749891224;
        Fri, 07 Jun 2024 01:44:51 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29df7sm3489453f8f.15.2024.06.07.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 01:44:50 -0700 (PDT)
From: "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pwm: Make pwm_request_from_chip() private to the core
Date: Fri,  7 Jun 2024 10:44:17 +0200
Message-ID: <20240607084416.897777-8-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
References: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2393; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=pYHQOtcajlYkO2UvuypDcCFMuwwUrbjcEVKx/JUgZzA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmYshtQF5fPNcDJuPUg0vnYZs3ok++9svfh1Uqo mX/jnRq9OKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmLIbQAKCRCPgPtYfRL+ Tk9XB/9zXuL9wQM2r1dDBlKHUbAlzqxNseCpsdYJQ/3XPf3g3SZi98SghVxrfer0cZIT7i27Q+f vqlOJTkg5J+EsS04l+IWs28TWnwQDFQY3vrD73nlfZETANSqWtfHXLs7dRy6WK8GCi/b+EzCIQ1 oFD40pBPwZJReo4CTtggqIpBsiHXoJ8CQB164ERUe8uRDEOTvqe6XEh14lzdEFlwf/Df8Bveakj 2adlrP3rG0/OjNDG9HS2FZ6OxhX0hYq8QTUohTgAzqKhFH9wxQMnTKEjKOCI6AlrlKolfFQZKRX N0U7mdlPhEFR7mlubRCeRxPAkf7AlaEsxBWS/CoWhTv0vKVH
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The last user of this function outside of core.c is gone, so it can be
made static.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c  |  8 +++-----
 include/linux/pwm.h | 12 ------------
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 18574857641e..76969d5052af 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -394,9 +394,9 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
  * chip. A negative error code is returned if the index is not valid for the
  * specified PWM chip or if the PWM device cannot be requested.
  */
-struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
-					 unsigned int index,
-					 const char *label)
+static struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
+						unsigned int index,
+						const char *label)
 {
 	struct pwm_device *pwm;
 	int err;
@@ -414,8 +414,6 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 	mutex_unlock(&pwm_lock);
 	return pwm;
 }
-EXPORT_SYMBOL_GPL(pwm_request_from_chip);
-
 
 struct pwm_device *
 of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *args)
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 60b92c2c75ef..3ac1a04acc0e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -407,10 +407,6 @@ void pwmchip_remove(struct pwm_chip *chip);
 int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct module *owner);
 #define devm_pwmchip_add(dev, chip) __devm_pwmchip_add(dev, chip, THIS_MODULE)
 
-struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
-					 unsigned int index,
-					 const char *label);
-
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *chip,
 		const struct of_phandle_args *args);
 struct pwm_device *of_pwm_single_xlate(struct pwm_chip *chip,
@@ -505,14 +501,6 @@ static inline int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip)
 	return -EINVAL;
 }
 
-static inline struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
-						       unsigned int index,
-						       const char *label)
-{
-	might_sleep();
-	return ERR_PTR(-ENODEV);
-}
-
 static inline struct pwm_device *pwm_get(struct device *dev,
 					 const char *consumer)
 {
-- 
2.43.0


