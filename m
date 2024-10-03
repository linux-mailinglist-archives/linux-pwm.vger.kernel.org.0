Return-Path: <linux-pwm+bounces-3445-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DE898EE59
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 13:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CF1DB227C5
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9147154C12;
	Thu,  3 Oct 2024 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EaquT9Rt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979D2154434
	for <linux-pwm@vger.kernel.org>; Thu,  3 Oct 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727955751; cv=none; b=h5pYi0cvZvyi/4PCOjWvVZYgJgATO00IO9yFDdnz+iCDyX9scrB8YC39ta4T83PsZsU2yd8+4N5b3Z0Mw85EB1g6opDLr51/GwjGYsMb6EU462YeZVpFbzYMJ0HdaKfKOtoLb5pHaVvexITiJkRLRHE4VVqhoNTAsYhyil9GxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727955751; c=relaxed/simple;
	bh=aJMTDVw522vqFJiKQiRuA8BQazzuOSU7HYYdtqVdS4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CIVLQ4wlQY2Dfjig2VmvtcRDb9pN+l8DpdxjaXYuDBBVva2Iai/u82s37W33ggXXoJEaw7h4ASSm1ByxiIEd23cqtu3mIaAOR4TfrDPem8rRnskF1o3rczQnBokw6YhTlKQvvN9xu4EXpH9GyGTosgmvtLMjxLJ6YaQ1j9GRDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EaquT9Rt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so6853585e9.3
        for <linux-pwm@vger.kernel.org>; Thu, 03 Oct 2024 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727955747; x=1728560547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAM+CNNBMtKqMq/G3+e1akEPoZRYDRtEdu2mqTUckdU=;
        b=EaquT9RtpMhb4kqSCvWfCxs/kOw1vsE9UfsOwT90pTRO2ZDNlMNa0vFdhf8Ye/UDKD
         /qPLSHimzejzaMAVWg74iOvAW0MpGWC80Gd6+23Y63LzLHdrIkhkZFW7QFd8nsSiMzJY
         ceDKZ090nssAShae4N6NrW4J8DFXDp/nfboEufj+oDdgcIX38sRgv+mwI97bgNS3IPEE
         qJGYHkN08bz5+Y1YDe7+6M+g3movznW8lVk3WhK0MKlRYrIFF7iSgYKgZFUy233Ti+tz
         8mh48YvvdyhdTgNGFozG+OU/PJ8ZK9luVY3EX5fehGxqOVFpOdBBXYxEEvEpsN6NhIRQ
         K54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727955747; x=1728560547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAM+CNNBMtKqMq/G3+e1akEPoZRYDRtEdu2mqTUckdU=;
        b=u76lOChOrcYzlThZdbZL3iIjjzROTnWKlWn95hTZu/M0sDkd/znvzL1G3HWNrp5W0k
         flNJbWD6bQ+Zc0mgqDkAIIcpT6a54jcft3kZrCK5wC1uFvoZ3zwxHB6nrH+VK9TP2BPw
         DTHwsIaKHyOtFCAr3pc5je8NDjH3bV2VEhWMtRh/RkEfRBIQH4SZMsUs0Pw3CSJBNbJ3
         +IVyflcQd+nT/Mq2dzrp2UWJ7xSF1NH+aSwo4uR9LL1V9PAv3s063wshjjOXtOvH8wrl
         EtA0gC+beKtmxMi3VlMUusCo/Or8e/JuOoFnnbSRCsnEqRBbzz7EgZR1Gkb49GAOmrKI
         rJTA==
X-Gm-Message-State: AOJu0Yy/FvhpalOXhWalmzg9XJkh87IIhtHEggVLZ+HwDfuwohmJyeiH
	sRtt7Pf2myGE5N3fj8XklWlFV8u+5+Fd0hcUe+Zx+7LpARabdcj+UUI7Zg1CP4M/qbkTSNllsry
	c
X-Google-Smtp-Source: AGHT+IE28EQOw63kYk0uIcE2XknhdSTrQQQqDoAhoSgvn00JpbYnKUFxsx4XYkP3J70p9HCT1MHThg==
X-Received: by 2002:a05:600c:1c8a:b0:42c:b3e5:f68c with SMTP id 5b1f17b1804b1-42f777b026fmr46308025e9.4.1727955746835;
        Thu, 03 Oct 2024 04:42:26 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:2ff6:7605:611f:dbab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1094113f8f.93.2024.10.03.04.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:42:26 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Kees Bakker <kees@ijzerbout.nl>
Subject: [PATCH] pwm: stm32: Fix error checking for a regmap_read() call
Date: Thu,  3 Oct 2024 13:42:17 +0200
Message-ID: <20241003114216.163715-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=aJMTDVw522vqFJiKQiRuA8BQazzuOSU7HYYdtqVdS4E=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrR/zRKrGfN/x9n9qSmMSup0Lb61z6uSzXLtV+59xtftO GwM3rh1MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRloXs/70LWj+qiNd55EXP u3R/o/SlGc23bqv31ssErV50naV6mQF7rUmjxTyOq2e9xJtPWsl0m6TumnOSdbvDKu19SybUrtL de5qJMXRhbKCNv5X5nEyLO/4uHFaL14ltWeUhnttqM3uWCdsj0exyqZ9GXtunJ+jl/2JaxaLGKX tcfs3h4xs0TX3WnvwlldJlcKzi8q+0lct4pknqHLPef6nDmE98pdSmymbmXNWZi5uT+N/Uhy1Te FN+r7Py2gH1dWdVJ23QDjp/jM8w4XvFsZm/JSfwBEmE30n5ZaYgV3h6tcz+0IjyRqdXbjvlpk/a sTiC/zrT+aZZcf9DY61ymjb8XpNWqRHt5z+tf4vZwhobAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Without first assigning ret, it always evaluates to zero because
otherwise this code isn't reached. So assign the return code of
regmap_read() to ret to make the following error path do something.

This issue was spotted by Coverity.

Reported-by: Kees Bakker <kees@ijzerbout.nl>
Link: https://lore.kernel.org/linux-pwm/b0199625-9dbb-414b-8948-26ad86fd2740@ijzerbout.nl
Fixes: deaba9cff809 ("pwm: stm32: Implementation of the waveform callbacks")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

the link to the Coverity report isn't easily accessible, so I kept the
mailing list post by Kees as the link to the report.

Best regards
Uwe

 drivers/pwm/pwm-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index d2c1085aee74..b889e64522c3 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -334,7 +334,7 @@ static int stm32_pwm_write_waveform(struct pwm_chip *chip,
 				goto out;
 			}
 
-			regmap_read(priv->regmap, TIM_ARR, &arr);
+			ret = regmap_read(priv->regmap, TIM_ARR, &arr);
 			if (ret)
 				goto out;
 

base-commit: dab9cd4b8e7f5fce4e7a0424991ec4714a780f3f
-- 
2.45.2


