Return-Path: <linux-pwm+bounces-2789-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF83A92FF9E
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 19:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F48A1F24448
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A877E17BA5;
	Fri, 12 Jul 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bt89M4ga"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A5E168C4
	for <linux-pwm@vger.kernel.org>; Fri, 12 Jul 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804721; cv=none; b=uRS/Bqh1mSOiOgM8eZFMlbt6XgAtdlrGobTWNkQePedWqduErgO9t2eqqItvja5w5PltZdhkjXk6/8x+4WIKrCRVSbIIonz3P9zhJOVSw0m4dCoL9UwoxFg60Tx63Wbp14YKaAmun+fZPyVcJb1ME/oNBJ1lG4hsLQj/Wl5NFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804721; c=relaxed/simple;
	bh=DavxXSgtTKIj7Wj0N0B6xREjQg7zBZ8aghEfL+5yfXA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dZvtwp5fszCj8PO3WQ483cKzvm4gNbImAUzOa+/kXG8YGqsAB1yoZkadX7rC7aMVIJFKKbNsbcsf5JmM3h9ZtTydCvryMECRjl40rWYZ6dhPEaJYkIWWKEPipmAezWCz/sUICjo1N8Jlb/2DIL1t8gHpZdgaSh8xDlO7fZ2Fe2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bt89M4ga; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38027so2505449a12.1
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jul 2024 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720804716; x=1721409516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo4vk60oQjkbik7sNv+iDUJvMXo16zshJsPjcGFrel8=;
        b=bt89M4gaSrFh8pEntYIATvQQlVqmcvCJafpRuPJE/t3bGXW6HVY77aXmHBkyAOI5xI
         d5LuQCsW87VCqmdjll351To3Me9FQ8saRmoloj10mlXe1nt2Lnjr9Ul33SCHMqb0tPwa
         RgMlj0Ktjp3qok5dW1sZRu26Fsg78PscfdIKH5kUmF7tcECQJ0xFD/KBC1yzmV5oghVO
         tK01CGls8WMV2nnmNLjY5CDdVJB9LZaYtDuTzB4Kn0tyToaddYshmUsBBbIx4T5apI3q
         HtpkUKSMAofmL5ILffi09etPRnYBnUU1I9D3DVCJmO+TnbWSaADnt0PRSZLkxbNfG0Wm
         N2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720804716; x=1721409516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo4vk60oQjkbik7sNv+iDUJvMXo16zshJsPjcGFrel8=;
        b=EPfU2yWJdKMaJ2duweyDtwvdFFLDLPjkiWuO+9So4KXavIQhdBr2lqm/fZPmg7fbBn
         De3Ch0/kiwidoK+xP4LrlX9w8Bo7WItz8HmOh7flnwkMIt7rmChla6SYxoDRRINh9eLd
         8Dyi0tldzCIhvVOgC2R/hdjSjN1knTKsV9cxUqJi6KsqUQyOiLysG7KoqySUYn8K4jvZ
         GaBwnCfGYyliZ/dl+TVFqZmz/hes5hSIfLpGGIztny9nGNCC7fINL5zjZD9dDP8fzPwl
         MRsmCxezVpTRDR4VnKqverH8pitx+xrFj0uHsdVBA2SsBI+gP+l5ADmMtZd74/TmEmx4
         hNBA==
X-Gm-Message-State: AOJu0YxaKgdGQdJ+Q7rE4e9tP17lTkBNleU8QZJ744DS2jUh7eAKGhXH
	mw/8JjHC09DefeHZus/0it+2ymleqt5a45zVOnsfRqCZilmSeTHxJxWsVya/XFw7tDCRa9WM/3T
	w
X-Google-Smtp-Source: AGHT+IHIXPFwyaQmg28iUc0vDyKA4Q5ID8ZvnX5etMx79rt0PNzVgigF9QTPrLMQcxQgUF9wG3diuw==
X-Received: by 2002:a17:906:245a:b0:a72:518e:7c8b with SMTP id a640c23a62f3a-a780b689fb3mr923812566b.11.1720804716207;
        Fri, 12 Jul 2024 10:18:36 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a854203sm367397866b.145.2024.07.12.10.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 10:18:35 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Don't export pwm_capture()
Date: Fri, 12 Jul 2024 19:18:20 +0200
Message-ID: <20240712171821.1470833-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=DavxXSgtTKIj7Wj0N0B6xREjQg7zBZ8aghEfL+5yfXA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmkWVey7S6Lcj4EFGn99lBjffoqUuuAtXrh8Y3H ZrkIzGp1JmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZpFlXgAKCRCPgPtYfRL+ TlDIB/94RkUE4GjKOkDCR6ej5TJz76EHBkW5X80W+rJ7ApAKWtdKT7dZ0C09FwUWKXSTfqbtzF/ aLr1HZy9wwmVpW6ahv/exM9lkBYe8TDJ3PwCQG44XXxAu/DXbgIZ5Xhr5hcDlJLlNUYRvaHzH/z Csw+r9XU0BiymOuZpft/LcEAr7pLU+Z5/3jmCFZ/Y2n1CtN/M0srBtfkfZor8l0xtgvNKPAzvOl xCZwxwkgaHgqUoUKzFlcncX4aP8twN3OQaamn6P2JCOSOffHSKokk7YYjCf/OoPc9KQZbRo0V3N +FHM4xn8YJdgmAryQyMkwquAr4LU7YTlEK8CbYINRs9ExcQv
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There is only a single caller of this function, and that's in
drivers/pwm/core.c itself. So don't export the function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c  |  5 ++---
 include/linux/pwm.h | 10 ----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 8acbcf5b6673..56d91c11f0d4 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -325,8 +325,8 @@ EXPORT_SYMBOL_GPL(pwm_adjust_config);
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
-		unsigned long timeout)
+static int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
+		       unsigned long timeout)
 {
 	if (!pwm || !pwm->chip->ops)
 		return -EINVAL;
@@ -338,7 +338,6 @@ int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 
 	return pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
 }
-EXPORT_SYMBOL_GPL(pwm_capture);
 
 static struct pwm_chip *pwmchip_find_by_name(const char *name)
 {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index f8c2dc12dbd3..8acd60b53f58 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -394,9 +394,6 @@ static inline bool pwm_might_sleep(struct pwm_device *pwm)
 }
 
 /* PWM provider APIs */
-int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
-		unsigned long timeout);
-
 void pwmchip_put(struct pwm_chip *chip);
 struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv);
 struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv);
@@ -462,13 +459,6 @@ static inline void pwm_disable(struct pwm_device *pwm)
 	might_sleep();
 }
 
-static inline int pwm_capture(struct pwm_device *pwm,
-			      struct pwm_capture *result,
-			      unsigned long timeout)
-{
-	return -EINVAL;
-}
-
 static inline void pwmchip_put(struct pwm_chip *chip)
 {
 }

base-commit: 3fe121b622825ff8cc995a1e6b026181c48188db
-- 
2.43.0


