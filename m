Return-Path: <linux-pwm+bounces-6730-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017DBAF99A3
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 19:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2971BC7531
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4434C207E03;
	Fri,  4 Jul 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="urPNg31e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C71F2C45
	for <linux-pwm@vger.kernel.org>; Fri,  4 Jul 2025 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650064; cv=none; b=O0aEOFuY+JVIhhiZnDNVHT2rqhO6iTXdohQ/H0Fxn8F+RCjPkxcD0elXHewFGLSRgzL/xv5cS/OZuIaZnNR7F/vv2E+2ZdQyDo+cZ2wwW58nyCDusWPWG15/jZvc8/NejwIng93tpwyvRVJ7eVugdy5LavcMaLQy/uYcOSUJ0DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650064; c=relaxed/simple;
	bh=5T8lLq8LRw7v7jY52F738fYrCCvGVLO6R+VQ2/Gu59s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XO1ehjyvq3hRdyE5MLGY9pxeIx6ptK0gKqnw8Er6hVhAndIZwU8xaEg48HPq8jmlPigMhFEexvwZKh51irY4ITcdbswrm0QG7qaTug9J9K6SQ1vV71Gltm6TragR2nQanxHlV/BZekbmsZsXYtXS+KaaEHKGHrnsYCrACEK7yrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=urPNg31e; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so8774675e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 04 Jul 2025 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751650060; x=1752254860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJ8+3kzijg+yQZlgXvqdx2kavqq2yHDf6k+bFmty+p8=;
        b=urPNg31eS6IrYbUfKBIznXUkVT6kiZg8eTnbE5KZ748gdFtyjG/YrzJgOFVh5fUpf+
         b9uCcloNQNYOvUtLelFR2OSYeSnbnvQYo8H5w/Rv0U6O7xXiYrLuWF6cd8QqiIHI60rN
         0UOXcS8pUiUG8WyI5BXTxpmLF9wI5rmVfcBzLDV0S7xhVTkOqm4EEJozVzXmw+pzN4r/
         x+PmTBoEJw8YeyLU+JjSFYYVqPaDaI0tN+jrmmOgm1vkK3T5+RMlXcVr9pIHnq7sdshi
         omw5X+g8dF+N9L7HKaFOzvuT7HWXKXIr1mUqR9KmCYDgbZv2WCWcxU5P/UdEJfHaOCdT
         iHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751650060; x=1752254860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJ8+3kzijg+yQZlgXvqdx2kavqq2yHDf6k+bFmty+p8=;
        b=aJEoB5vyA4JAPR78Mv8HwCfdMhkjm5JyUkky5zX/muXbzSn7pTyYofezEjUs1nRebD
         AG9gmrrA+3+YQicDNsbBB8h4FGHNYiOfFizRcMxSHkHUp3OD3Iu2tULOy5xkGkCjCuzP
         B9cEMPZWrzEOtN4CBtMscs17dboyQQmwC15WDb/ktGIGfUGRupG+OAqEQdiC/AjmAePJ
         Y77QFkLexp9eVY5j27QouJR2K76w4IkMDF4oQdY71SIGjl1NjyukHkcKd1IrTKNf9SIm
         RILv+fZzOmhFay3alZGbV5cQtjUSYOeiaCaWImuw7Y2voS08pNVwRksoAkKmQEZlySjH
         fqkA==
X-Gm-Message-State: AOJu0YwQLc9pAg6C4p6chtc16Y1wv6Z+eZp/0VfQtUiGxXqu07vNicxG
	ywbe6lISN/52LSIDjjYQxX1AlXJCJ6neDiZ3M77HO9LpUF5I/DDFuhLmfOe7MtUcZQI=
X-Gm-Gg: ASbGncsbjBTWiQUDkKM3kWtZKq+Y9LIKwOCK3D6JQp8jzYyXfOjN+WH5OQsYBXSU5js
	IE9uzdi2fzbTIDzzwBaBN33JQFFMw2SVSLvO16enntcCNEsEANntOSzJI/a8DuYJojuslQoRbSO
	QDiAdY4ux9vQaQtie+QEYDMaPZg94Td+22rhilWuA0sYG5ZZs/VBAaHp6MRqyCcg448yiFNwfXv
	c62Ip1wYeNiRINgfppOTYycS7EUx52GKQ1TBdaItHZsmj/QwAlzZlB9AktJLbe924xboe5nevyx
	PmHrv1BrG5UgEhVzQoGel6U2veowN2GmfbfRWIgOOpNbe7Wp090P68EgeZslEELXCbb43Jbt4aJ
	tFXdz2qWe9oHoyr+gWxBEA6oJmwPzHv5DRvKjE3I=
X-Google-Smtp-Source: AGHT+IGv5u997dndbYtn5LpnOeCgXKKeiNmL+umfIlNuz+5mm9d73N+p5qkNg3C/k7JLAiqbd72qUA==
X-Received: by 2002:a05:600c:8b6f:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-454b30b4d40mr39282915e9.14.1751650059765;
        Fri, 04 Jul 2025 10:27:39 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454b188d8e6sm31455575e9.36.2025.07.04.10.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:27:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] pwm: mediatek: Ensure to disable clocks in error path
Date: Fri,  4 Jul 2025 19:27:27 +0200
Message-ID: <20250704172728.626815-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=5T8lLq8LRw7v7jY52F738fYrCCvGVLO6R+VQ2/Gu59s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoaA8A/CID8YoVzALS6o+3ioPferch7DY1qIofp Ikg+oeQkkWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaGgPAAAKCRCPgPtYfRL+ Tu4JB/9jcS5cvb4dOI+tfyL8GO5FMte/UYZykJQsMUX7mAS214vqglz9KOtmyfbXkf5ZK2otSml ZterLv8gcmhJLJYofdE1y8S1shMqNIRin7NZ6eaaN0C+ptF9sF31aiWXPRnEoFsKYdueGyZ9ov9 Is9qaX7rZA4/Gjgtw4k9aaUamznd5q5xpJu26xUog599gwS+WLuPU3l5A9xaP7TjTs21pTuf0u5 FswUA9k93WAL8h96F3jnP/n08LX3anvstsmbBG32/n8Pqwm1SxMR2oV8cPPqXVHozul4z+RkpEs pzFPczoCywlbdJmrRuCT6XY7KYD9g56e7O0TaYAXdkq3ayHZ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After enabling the clocks each error path must disable the clocks again.
One of them failed to do so. Unify the error paths to use goto to make it
harder for future changes to add a similar bug.

Fixes: 7ca59947b5fc ("pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 7eaab5831499..33d3554b9197 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -130,8 +130,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 
 	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
-	if (!clk_rate)
-		return -EINVAL;
+	if (!clk_rate) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->has_ck_26m_sel)
@@ -150,9 +152,9 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
-		pwm_mediatek_clk_disable(chip, pwm);
 		dev_err(pwmchip_parent(chip), "period of %d ns not supported\n", period_ns);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
@@ -169,9 +171,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
+out:
 	pwm_mediatek_clk_disable(chip, pwm);
 
-	return 0;
+	return ret;
 }
 
 static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.49.0

