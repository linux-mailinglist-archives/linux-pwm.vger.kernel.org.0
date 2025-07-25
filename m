Return-Path: <linux-pwm+bounces-6888-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE7BB12130
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6223A957E
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38634235BEE;
	Fri, 25 Jul 2025 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wGKHTzNw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA32EE97E
	for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458349; cv=none; b=FL8Sm/HBSTBNow10ywoOakZEikx4yr2A1LFRNYCNwP0MUuZLsa8Pnek5xqXqPCwuEO8tKilaqeiYWUqoJuPAJsRDoc/wV2vweb9Mh+F79zTYX3+ZApVll/vo3iK7Mm7cUKeLsvL+sYajcBFE7jXQve8ZaEBUVg6aHXP3G3J1kVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458349; c=relaxed/simple;
	bh=h4C6mJ+6piC2VWvbn8TbcJZ1IdLRPgjUr4EY1wWAjGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+h/Fh1JXl7S2ZPqS8pdWA/GnJi/+c8VTUHnLx9Y7hhq5LgvCJQL8lcyaEX5/ANX814qrPCFhPmffFYnmO4BKz5VTZxo2++/Yix/SkHHyEWMYN7WL3DGxsjL7J5xwmDPoRySWHXfxBj7yuKenrQTiMhHXfb987zFu5NZrm9nmvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wGKHTzNw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b776d57656so734648f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753458345; x=1754063145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpMv/YidPhET2ZnB4avevT5/yZnoFF98t+d9v4dctnU=;
        b=wGKHTzNwjJUNZCLZtkTtQm7UXaj/p3EpsaaRGOcbPa2IFjsHjhn5bUdQuAPmX+Ou4Y
         WWz4UUktjFtFn2jz8Qr6UyEuzaL8vz+j2JWW57wHZ90WsMFuj8jyuNUYYxyfJeXyVt3Y
         I1WFEHFFk6biG0VS0SV7O8rN1wKvVvspPa1e7ASqHd3oL2dPpa3DmXKehVPA0OavXYq/
         efM6UeF20X+Jonk5A+sg3DjH0m9l5+fh8j7bTILQeaTthigOwQUQtXzFEQUpeUVEnGz8
         Iz+UQnH/I6zQJx+Nw9MSGGOEjpaU75sHEuwMhekQjE1jtGUUA67jC8AkvNpGZhonPBga
         SJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753458345; x=1754063145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpMv/YidPhET2ZnB4avevT5/yZnoFF98t+d9v4dctnU=;
        b=KsaCXG+dNCvDzYJwjn4oziG+JzZpTwSJvP6yTNhAcIUw6EIOhdtohTdgsiqnY4trih
         6JkwAm/rsFCml0reVoK122gYYn3Shh1woKe4iMZebiD9d4AwCmZo9XPQbS4pMGnYc2UZ
         ugvpn4gyuSAvcDRm60SpbtoqjZjDVIeU3RM9JhOztJXsExoF70f6q/rIvHunaonqbz8x
         tDW2Cm/Oxk60ARm9GTDaatRlXBk33iPaxdLHrr+tYLVZS+bKt2gfvhb23pYILc6eFpul
         jSc/vdKoM7+MzF7Qi7dUXZkGYbk/kWYTDSrPbV1RdiPQN17OJwjlmPPfA3rMnrl7rkFY
         vuCA==
X-Gm-Message-State: AOJu0YxADMtI0BkGBrkxEj04K+ZnMAPNMcqST27BIhAgp8Py7Ju3mdef
	dfUQk0uJXhgGF9TWutKOem+elLbR8HV740Z2QOgZEZ9WCnlWXLRKWbhHIdplPYPnRQs=
X-Gm-Gg: ASbGncvkKMID08aa5+xt2pTH8Sq0hF5lv/lJgipPIW96uCebedI1riweA2RxxToxzEg
	MmLcnWGwHWstoJioTHIHFGUZ8p23cWyTlNWpyZL4kZMotbveee7mx4dyoWxTG34J9UGYDYKT0qW
	+gKFNlnIWvvkHICrMkbOf5wfxpD8/9y61b2mHawMlCSra/8BZFbjr7/DnsPb484bS4EeFFG6N0s
	cCaCnoA4xLP1xSRBB5KfEZfZSuqjbIYrXrcq5bW4WVs2yEVf85I5OqYO7rweS491tg0MADr1byR
	M93OdkHv8o9ie4DeuXsbtvpUAeoF9SIp6Jg8ZHVECTScqCfb+dVFT5gehj8duIvFc/HpZvVidYa
	D3Z8T6PN3EKgS3RpMeCqTEWx0LK1ggDLmbhy2Ce293z4Jd+1Xj/JvzyygprjVTzq8
X-Google-Smtp-Source: AGHT+IGCVEfrJiPwphHDH1kVjEgnoFgj+gabfrl3qoD7SE6yk6VjRY5CANy9aiWHLYWruZAR8hkG9g==
X-Received: by 2002:a05:6000:1448:b0:3b3:9c56:49bf with SMTP id ffacd0b85a97d-3b77668f23emr2158022f8f.56.1753458345142;
        Fri, 25 Jul 2025 08:45:45 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4587abc273asm1440555e9.4.2025.07.25.08.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:45:44 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 4/8] pwm: mediatek: Initialize clks when the hardware is enabled at probe time
Date: Fri, 25 Jul 2025 17:45:08 +0200
Message-ID: <20250725154506.2610172-14-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=h4C6mJ+6piC2VWvbn8TbcJZ1IdLRPgjUr4EY1wWAjGg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBog6aOq0zddg0lRZ8kq4jJ4TGS7WGa6Vop+MNSf zuzJ7uKUSeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIOmjgAKCRCPgPtYfRL+ Tk02B/9cdR2DsEiX1JpyqyVLI+PAHhGbf1/6BAPibHuJh7ncfqBV5Fy3KKtoV1ToHfCAKPZ8p95 uFZ8f60PEMgdNCQTvao4q5Pt5FQQtM6bnVdew5sgp3ywAa/FGTWtFIKNd4Fo1ECx8PMNeiSSbdC tt3KjRdJK71C9ZD4exwVBR1ZxkfFYpkN+to+QytRWrhVQkkeJpHNuYrijK7yWGAPkLsu+taI8IH laxCH0Nsa3N/zioCxU/EL5mNyFZMbW8Co9I7VQjQTd6Mvw8vLGKimQZzONDC+YCBtE1p+1lRZ4J Z5zs9y27kMvoVA19HLBRnVgij8VYHokLHjrblLXNH+1uz/3t
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When a PWM is already configured by the bootloader (e.g. to power a
backlight), the clk enable count must be increased to keep clock usage
balanced. So check which PWMs are enabled during probe and enable the
respective clocks.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 47 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 16ea42be4c18..7d0a6f41d671 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -235,6 +235,49 @@ static const struct pwm_ops pwm_mediatek_ops = {
 	.apply = pwm_mediatek_apply,
 };
 
+static int pwm_mediatek_init_used_clks(struct pwm_mediatek_chip *pc)
+{
+	const struct pwm_mediatek_of_data *soc = pc->soc;
+	unsigned int hwpwm;
+	u32 enabled, handled = 0;
+	int ret;
+
+	ret = clk_prepare_enable(pc->clk_top);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(pc->clk_main);
+	if (ret)
+		goto err_enable_main;
+
+	enabled = readl(pc->regs) & GENMASK(soc->num_pwms - 1, 0);
+
+	while (enabled & ~handled) {
+		hwpwm = ilog2(enabled & ~handled);
+
+		ret = pwm_mediatek_clk_enable(pc, hwpwm);
+		if (ret) {
+			while (handled) {
+				hwpwm = ilog2(handled);
+
+				pwm_mediatek_clk_disable(pc, hwpwm);
+				handled &= ~BIT(hwpwm);
+			}
+
+			break;
+		}
+
+		handled |= BIT(hwpwm);
+	}
+
+	clk_disable_unprepare(pc->clk_main);
+err_enable_main:
+
+	clk_disable_unprepare(pc->clk_top);
+
+	return ret;
+}
+
 static int pwm_mediatek_probe(struct platform_device *pdev)
 {
 	struct pwm_chip *chip;
@@ -282,6 +325,10 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 					     "Failed to get %s clock\n", name);
 	}
 
+	ret = pwm_mediatek_init_used_clks(pc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to initialize used clocks\n");
+
 	chip->ops = &pwm_mediatek_ops;
 
 	ret = devm_pwmchip_add(&pdev->dev, chip);
-- 
2.50.0


