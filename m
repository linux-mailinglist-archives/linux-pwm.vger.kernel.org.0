Return-Path: <linux-pwm+bounces-4917-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F0DA36341
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 17:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AB11896005
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 16:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0E82676DF;
	Fri, 14 Feb 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lXQJbv4D"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7579266EE1
	for <linux-pwm@vger.kernel.org>; Fri, 14 Feb 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550905; cv=none; b=rtNN6ZBLNcU56zcBHNVm4VjfYXuRgFX52lCFsQsuiw6tynvYnjngl/mzUXpojO6yUKOe5N0czWAIWWJsb15zyl/dMTbVPhCKJuFNTiYx/td7rx1LsrTrNiCpJ+pm9kHx3bstG0qLE89IvVlbeiNnygi7fcqsRkh3UgsvraoKvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550905; c=relaxed/simple;
	bh=4nnLvcYtIwwsBUnYwVJaT81gdGfgqczxUSHuHeUAn4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OWxu0PPTtcL5FbSwAxJjxufIglEvKMUSi87jcpZa/LO5J7gFNHalhRg1vAdhlLcYRX2KXsfEk/9YT7vNb5ShBjM2sOh4602G6Pc5Xw4d3VcZXW+m3rw0TxbOlTn+yMVezBmsnOSnxfVaRQ7jDAQrElHnFBYitju0TgJn5GSmX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lXQJbv4D; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso1210705f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 14 Feb 2025 08:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739550900; x=1740155700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gIR0AdSggEhgWpMCtVYqLC2S9tpi2gmKnvd/bPSBRfk=;
        b=lXQJbv4D9COk52Jl7E3DsQgKYa+Zqq1jxbOAKqJvY6fzNMZ1ubt2S+JTol6RBq41iS
         0FYUm61zrDTETLIXdmnUOBrpRBfPMSlJUlMnaAb0usoNnh6TLLhWrS3p0tx25o3GG699
         NFHqCcfLsZuksPSpZUK5ZysD7Nt2rWHUzZOVvdjnu6NbTnbLOxk9Zw4DzDl/Y/690uT4
         Q9LuQo5ZJF2KzAenZPW8q9HPRmtGuyLSI8Z6kfDh9fZ/iivYHfAyOlpU7bXn6h+Nxlap
         ayXWYIJcDhekSCNBCh35PAtl0jr4keCzx13MNy/UiKw2KAVathXxrI/4+jmMgRfTO4tO
         75eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550900; x=1740155700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIR0AdSggEhgWpMCtVYqLC2S9tpi2gmKnvd/bPSBRfk=;
        b=oGgc0KHDPOuxHQJegXmilajFAjA1MyJ7meDOWJHmnkJZ595hMwWqBmROh2UhBSsiaa
         NEOc/A/kOzmZl6Fg2Zz/eoTRFhAmQjvJqZgb65K8u9iKwyeQJg18jFuAyT9d1o6NZhcR
         pCQP0EL9E2/4V7vrlFaHZo54YWRt84Dv9Dt2eQpKOqGpHW1bacGSjbUPR1Fm3Go/Br8Z
         s/aLG4OLYzZxRR9yy08n5rEFewoVaeaDfOwyDCxyZ/FVcQwcOQMecdwp8x/cQCo455Cj
         bKgfPH3vYuYFGghFt/Vj16hZeCWkbMzw8pgprIt6dda1EujV6WMp6s3mhGMgpSaeESrw
         QeRQ==
X-Gm-Message-State: AOJu0YxPFt7V/MaQP5DAIcJjY0yMaP8mpf0lT9FTWWuyex2/PeoKw4+N
	dMZnOqEyImDRbXhdAiCaT1s/8cuzZ/KCoc+xvoHdidcSadMZoQYoxLA6yljaZnErowJULy6Z7t3
	FNU5OdA==
X-Gm-Gg: ASbGncsn+X/5AHQfXpO9gOFIqkMs66iME5hmDYB81nT7Z6LjRHC+EdaaoY5Y/mQxZku
	Y0wFm1Jo8/5ugdmTmzY3vYOhF8moNlc0ormu3D750XuBI1nyHJpTy7/Yv87DoYOI4NoMdFdTTIy
	V/5znWbBpOYxGVPjipK0OzWiDfL0YAW/2Ns1ojKSnvlgcmlJqoAyGxujm1RBlk9+DOqjk+QatbS
	CUJSbvku7X4uuzp4YuHck2T98gqs86LR3DtMtgTLo/SvAibq41BbHdboyGbYMmtGz6OVYiupKB+
	ie4igfBqLYYDAzxFlJgGBfvhEg+O/dKp8YrroIEZnMKGnzo6ly0V/vyJkA==
X-Google-Smtp-Source: AGHT+IEMCdXyv0s4XDmuQOjYDPxcnYbsYJNf2NW1B+uWl0/9ePfEAn3vi4ArakFnU8g8DP+8vQOBGw==
X-Received: by 2002:a05:6000:144e:b0:38f:2847:f5d4 with SMTP id ffacd0b85a97d-38f2847f702mr8619632f8f.28.1739550900149;
        Fri, 14 Feb 2025 08:35:00 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2591570esm5111371f8f.59.2025.02.14.08.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:34:57 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: clps711x: Drop of_match_ptr() usage for .of_match_table
Date: Fri, 14 Feb 2025 17:34:42 +0100
Message-ID: <20250214163442.192006-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=4nnLvcYtIwwsBUnYwVJaT81gdGfgqczxUSHuHeUAn4c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnr3Cj9X55rnU9bMvi2/DXD1ODz9JH/bAkEqBmE Q9bTYrwZ1iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ69wowAKCRCPgPtYfRL+ TunCCACR8VD3rkxhMiVVhtr0J0Izfxqx6SxRr//tRHgOZs77QV7M63StxkzLLxm2PklQmE/a63U MrIqkSS+N9bTle6bw0iY3b1sAwc3QbmShWtsYsUn0X+QQhaVt3AnRe1Qwt+2NDrmBzcbzpc2uj/ SR6zL0igt9fC0AWsY/Rz/gV3+SuTLnroSJ+Sc3dz9UHzvnAO4L/dqaSXawylNUyXaizDCqCm8SQ HUFdFkPdKXwGZ3nrYhpYJWbGPR662cCI5MSCC/d8n/hXsN19AjkvnSM5WBmWOK+hnIvDrOs/ygT iYMxmiJIWbno4qE8ahMU+uyxn7QukYdX/RTQXvE2gIRwj5Jv
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The pwm-clps711x driver depends on ARCH_CLPS711X || COMPILE_TEST. With
the former being an ARCH_MULTI_V4T platform, there is always OF=y when
ARCH_CLPS711X=y, so in practise clps711x_pwm_dt_ids[] is always used.
(And in the case COMPILE_TEST=y + OF=n this only increases the driver
size a bit but still compiles.)

So drop the usage of of_match_ptr().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

inspired by Andy's patch that does a similar thing for pwm-pca9685;
see
https://lore.kernel.org/r/20250214154031.3395014-1-andriy.shevchenko@linux.intel.com.

Best regards
Uwe

 drivers/pwm/pwm-clps711x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index c950e1dbd2b8..04559a9de718 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -98,7 +98,7 @@ static int clps711x_pwm_probe(struct platform_device *pdev)
 	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
-static const struct of_device_id __maybe_unused clps711x_pwm_dt_ids[] = {
+static const struct of_device_id clps711x_pwm_dt_ids[] = {
 	{ .compatible = "cirrus,ep7209-pwm", },
 	{ }
 };
@@ -107,7 +107,7 @@ MODULE_DEVICE_TABLE(of, clps711x_pwm_dt_ids);
 static struct platform_driver clps711x_pwm_driver = {
 	.driver = {
 		.name = "clps711x-pwm",
-		.of_match_table = of_match_ptr(clps711x_pwm_dt_ids),
+		.of_match_table = clps711x_pwm_dt_ids,
 	},
 	.probe = clps711x_pwm_probe,
 };

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.47.1


