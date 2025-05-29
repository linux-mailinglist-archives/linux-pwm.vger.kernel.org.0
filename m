Return-Path: <linux-pwm+bounces-6178-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E936AC8143
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1ED4E58FA
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F43122F778;
	Thu, 29 May 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mB0TT5Fo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1C22DF9D
	for <linux-pwm@vger.kernel.org>; Thu, 29 May 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537637; cv=none; b=W8A/B1JvtGpNsswzPJtBe5vnCg899j3JJJXE9rI2OAbApkj24IQUdN1Vt9qIkgJVoMk8N/I7+SaDyhbpCPEqDgwn9N5ZIMrCu9zZHgL6mpdK0wk/YZrsrodFVPfW9lUEgNn061i8cn8u67hNRDPHpBzJaN5fTIRBdUq1Dvqj0q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537637; c=relaxed/simple;
	bh=G0kD6t6gDSKYtkY+t4W/ePId5jx6yl+y0aP7+XUduQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHpr44R8KkJC3nEec12MvabqWuD4GBjmjZXUKw7bj5rmhTTXoABUAWFshYpzmql9ffD9NAXgnz7+W2zPWVUkatTQtnAlgeulEguKRWGNmnvJJitJ6nwvr2RCB4b4UusEE3Whq5xbHCn7F9AtSfHSRDe8LjPFuyNkL8clznHwlC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mB0TT5Fo; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c13802133so332410a34.3
        for <linux-pwm@vger.kernel.org>; Thu, 29 May 2025 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748537634; x=1749142434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMyKKLxTWveDTcXUPGUHmdDenKXOe0zbluJHu4U+D1M=;
        b=mB0TT5Fo0rG5u60jfkFEsxnbQZJ1jtw4T2FOnTJuxw8ph1XdaUU9iIwETij8d1pMLx
         5fEN63frQX2SEheZE5nmhYbD97p7Xzlh2NUMvZvwyOJU/rKeUQUD+tRi160Q2epz9rSN
         QfxmJDCir9e7KYFUKZ+DE2heuvA+W9SzDs48LBsFZhF5tkea1wXxIwWJrVBHliHHe/KG
         Qyuex7NBOJJ1rl93FmCC5UswkqFrzOcua13GGEQYOZm5USnpiflxtCPcQoLKPO+ycu0g
         iCUWCopHuMNKierV78Yaih8wntPj7MCGGf5X7I92TT+/m2TMUVTgQEcOJUxtv6ZHAonZ
         tNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748537634; x=1749142434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMyKKLxTWveDTcXUPGUHmdDenKXOe0zbluJHu4U+D1M=;
        b=huqLIM5rZva4RinlEMx/sN1arM9fECbgpN/2Bd5KJM9tcq9pRrQZqi3dpVj2jgCzma
         ZfFvkEtEl+OTVx9XrwHqn3LAxBjJZhVYeCBXx9+HvEA1vv+ipUDKJf6ZqMSAIxmAC8NP
         wGL63Dnx7QlQbbEX/t68nznaAR7jMsMACbTkeOIZIycDvqscHHylw14dip3PcR2L6cAs
         JRTtFal7WcWN2xA+NL+kfQZisqvFpVqbTG03Y4LMerHXGjY5JhOZiFRzL56qIWFn4nsA
         0I14KBPWRhU91n8YThasMs5TXnBiAbcfgnq/8meu5BXbBlx6aW06AHC3Z4E/iWI/r4HU
         T3yw==
X-Gm-Message-State: AOJu0Ywy1cVjmYdmr5jy5rxUARnp8IUmwKbvr3HDr14Loy935s8Bdq+y
	XvsYPqtuc/q4jkDiD3qZBSDNk8Z8+/XvAEpmwuQJqck0ack/heey0QUJnZhWo6XhSYU=
X-Gm-Gg: ASbGnctgmv6m+MH0P+JCcSOrcHWO7eM1cevZCzIfzZzxli16YH5krycJYKEX2iXqX2d
	ARvcOe7TLJq1d17GH+zJ51V3fsfzkziky6PidmKoq5mx5VngJK8Y5B2QpsLgaZDDsaF7y1tGw6A
	htMYSZ+BXzgksNyKNn2ZFc7plc42WXXBLLYaYvGMeeHL9MVixdjaoYQzl3fOspuqo4yifoN+EMX
	ORkLZZ+BbkXaZPZ2oeLz/pW5dAMmGxbsTLZD4pOc04aKOgDKIScvuku+cJjxs9avzYED0OR0D1Y
	42HAwtgCX6BYyBddTeQgxn97cfXwp4GJSS3EnmmCb34b7+U8yMn6SM0Y
X-Google-Smtp-Source: AGHT+IHAT8+DwouqDB8LUWALROg5xM20WF7/3pIXPjXzi8VCpH/aISqfkYA39EKnMSkf4x6zkSIVow==
X-Received: by 2002:a05:6830:710e:b0:72b:8297:e988 with SMTP id 46e09a7af769-73670aa7913mr48655a34.25.1748537634261;
        Thu, 29 May 2025 09:53:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:928b:5d5c:6cd9:1a4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af82d2b8sm303265a34.3.2025.05.29.09.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 09:53:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 29 May 2025 11:53:20 -0500
Subject: [PATCH v3 3/3] pwm: axi-pwmgen: fix missing separate external
 clock
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250529-pwm-axi-pwmgen-add-external-clock-v3-3-5d8809a7da91@baylibre.com>
References: <20250529-pwm-axi-pwmgen-add-external-clock-v3-0-5d8809a7da91@baylibre.com>
In-Reply-To: <20250529-pwm-axi-pwmgen-add-external-clock-v3-0-5d8809a7da91@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2911; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=G0kD6t6gDSKYtkY+t4W/ePId5jx6yl+y0aP7+XUduQI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoOJEY1kyh8roAlPaq6uaIScxVfXPoyDYddPKpg
 Dt/ZTke2xGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaDiRGAAKCRDCzCAB/wGP
 wG9hB/9TR5yVVciLQpqx3iN4eP5P/uW9aXvfZm5egzkqiZwr3TqAWhUl704M7SiRuzvbZpMeGNy
 JVDSWKluM/YPVafExyt1yD3RyDJ9277XQV1loRkv2GfVwwyKExJyPPpwDXarsQPQBYSNpkxh5F6
 0T0infueBJ74Pt0MAKZJIxowVq5632XSJ0a8WYZyo2BzQhBAGpuzEYWWERmZQnC4pFkaQPvsy7U
 dSjhc26qTJyV7Ol29XwWErgErKum8a1M++sVJ1krYCpyWTiRvNthsFx+a4uZh1RebhYDtV00jkt
 4VtWfTFx+JLTOLROyK0+NhyEaq1HdvNWFQdMkEekMOzzNZux
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add proper support for external clock to the AXI PWM generator driver.

In most cases, the HDL for this IP block is compiled with the default
ASYNC_CLK_EN=1. With this option, there is a separate external clock
that drives the PWM output separate from the peripheral clock. So the
driver should be enabling the "axi" clock to power the peripheral and
the "ext" clock to drive the PWM output.

When ASYNC_CLK_EN=0, the "axi" clock is also used to drive the PWM
output and there is no "ext" clock.

Previously, if there was a separate external clock, users had to specify
only the external clock and (incorrectly) omit the AXI clock in order
to get the correct operating frequency for the PWM output.

The devicetree bindings are updated to fix this shortcoming and this
patch changes the driver to match the new bindings. To preserve
compatibility with any existing dtbs that specify only one clock, we
don't require the clock name on the first clock.

Cc: stable@vger.kernel.org
Fixes: 41814fe5c782 ("pwm: Add driver for AXI PWM generator")
Acked-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 4337c8f5acf055fc87dc134f2a70b99b0cb5ede6..60dcd354237316bced2d951b7f0b116c8291bb0d 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -257,7 +257,7 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct pwm_chip *chip;
 	struct axi_pwmgen_ddata *ddata;
-	struct clk *clk;
+	struct clk *axi_clk, *clk;
 	void __iomem *io_base;
 	int ret;
 
@@ -280,9 +280,26 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
 	ddata = pwmchip_get_drvdata(chip);
 	ddata->regmap = regmap;
 
-	clk = devm_clk_get_enabled(dev, NULL);
+	/*
+	 * Using NULL here instead of "axi" for backwards compatibility. There
+	 * are some dtbs that don't give clock-names and have the "ext" clock
+	 * as the one and only clock (due to mistake in the original bindings).
+	 */
+	axi_clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(axi_clk))
+		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get axi clock\n");
+
+	clk = devm_clk_get_optional_enabled(dev, "ext");
 	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get ext clock\n");
+
+	/*
+	 * If there is no "ext" clock, it means the HDL was compiled with
+	 * ASYNC_CLK_EN=0. In this case, the AXI clock is also used for the
+	 * PWM output clock.
+	 */
+	if (!clk)
+		clk = axi_clk;
 
 	ret = devm_clk_rate_exclusive_get(dev, clk);
 	if (ret)

-- 
2.43.0


