Return-Path: <linux-pwm+bounces-5145-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678D1A5ED02
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 08:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28083B302F
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 07:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947D81FBE9C;
	Thu, 13 Mar 2025 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sItV4KYE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66937225A50
	for <linux-pwm@vger.kernel.org>; Thu, 13 Mar 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850954; cv=none; b=bQedmw5to8RDGMEz1sdO4qlcmizPBZIoDk+t9E6OMmBl4oTktbIcb44HMdS/yrJgZMOMQh9+8DJ+vwmesSG/uw7z0CdrPP/D3HofP0vNaWqaYqXv26yvw4qzZSyR+jcwfVSowfLIi4wSaSzyTMTFRnTpf4D7e5l+GnBMBdpxZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850954; c=relaxed/simple;
	bh=9XJDzXpcqDahrmEtMCepuwbokqP/XCh8iGzQvE20SGw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qkNBQ+X37KFXSlpHaeT+WCB+NtckFvtoih3oD+pBZ+xcwoCS8tZC+jL1dCSLz68suguwDCRZow+YsJAUQQMX0O3K7or9MHUT0OzU18msI8NDzhP6mRGMjOKZgHKBAyDtgucxBin/4tkZLE5TrbvmdryNiSedZncTfN47gebuy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sItV4KYE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec61d0f65so123201066b.1
        for <linux-pwm@vger.kernel.org>; Thu, 13 Mar 2025 00:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741850949; x=1742455749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oj/2xNP3XsLA+mFSI6C+3+yBjVuExNmdlPFs4R0LtPs=;
        b=sItV4KYEJRr4ueWIqt8ey7sRKnIFZ90973kUbqRsKG2TroYdKuXI8aRunLdtjr0GyX
         bg9mngsR4pi0Pl4DCarn9BGliIyxU4ARX4aeqLfP1Z9Bu0FxBrXkgF2/4VHi2njBbNZy
         ZaBvt4rCS0S1BTjk7o+p/FatOQEPJEW8ChSpxfpFCBsYNLST1FglXc0+ECodiwKkUmRW
         StAN+ilLjBlWov2JZACdccdPDUj2XNEVsvDZTESkXzE2dHXXTAiBqWjeoY7rsuIRQkvO
         dNC7i6MubPV/EuamrEcb+3OuFESYTmjgVUIdzCG/4nSEafItpx6q3wA9AWefsVvxUzYu
         /tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850949; x=1742455749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oj/2xNP3XsLA+mFSI6C+3+yBjVuExNmdlPFs4R0LtPs=;
        b=k1rSNHTNgC8Z1NMBw8atnyMmmrHxPmzm1YoHDi490uuFqd66G3cVbTjvYHa611R7fY
         ePXWw2IVCe3+hJN3sesFYh0h9sAx5r49JkN0jU58EAOWfDcZpXg9fDWpdgVk1DLEc9Nj
         us5sMgkHOQJDb0fpG1eAWIqlx+SkgyTZM0dOIcUr4KybMOVRIc/AbYzocXnQ1f5NfquI
         BNjM+qSE8W3Woa8p4II+w4TmpyTz5bD5f794NEvJ7m07oD/9KdubKtr9FDJvfH+PUd0n
         L2zPdoUbYUNPJUQx5mbT8Tggg5S4pVnw0a7cA42d9CZxqxEWB2XwhbzzoHxj4QwKdeT+
         ggJw==
X-Gm-Message-State: AOJu0Yy6nYh+N90IUwAlYCNSKnLKgmnD8P2zmZFVeKKOIQ4Srd0XteEr
	GOvTDeh3WZxqFpjwa8gk4+UBeS3wjMUOVzLW4J68PKTw9s4xcG1BQyT7cE8oj/h651VRqIxAY3G
	j
X-Gm-Gg: ASbGncuPylNWjO2z84JJab8To8EoBaVQUzB92pMLAGLhzcQV8SQj6lddGDhZvHIKzMA
	Bbz5m/4YFWQcP8nho9nbYMNPPHYWcarBH9a8+WsK8mTSnQOnyUCfM0tq/l8J8hALQTmEOZ6Il4U
	S9nhExAQqnISjv46vIPWUzPRD5bNEXpOXIPqQ0+hLaTtWHgz8LejJpXFyapnt8cP1ChSd0HB8i/
	LQUP45i3cUxKJXGhM9YtiRfQHD7FU6rC8IW3Ws+h8d2gWdm++vg+f4ETE3KL444Z8H6xKAJMXXa
	1vOQlHfRVro5iIPLVBZTUP29zrYswjx7srU9gokG7SzHHdx18A==
X-Google-Smtp-Source: AGHT+IEm8lZfTX/ZIpt5wG/58WKd8PP6DN8BLzuXrxps9KKYpCX1DVeQNdLrPxqaF7hTgLQ7/eDw4Q==
X-Received: by 2002:a17:907:9494:b0:abf:6f87:670e with SMTP id a640c23a62f3a-ac25262f1d5mr2869633566b.22.1741850948576;
        Thu, 13 Mar 2025 00:29:08 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0b71sm47259066b.96.2025.03.13.00.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:29:08 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: pxa: Improve using dev_err_probe()
Date: Thu, 13 Mar 2025 08:28:55 +0100
Message-ID: <20250313072855.3360076-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=9XJDzXpcqDahrmEtMCepuwbokqP/XCh8iGzQvE20SGw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn0ok4a4lK7Htr+Nsx7I0wyJu5L7BBAIWQfQsmm IAbrGinhiyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ9KJOAAKCRCPgPtYfRL+ Tp7SB/93ibkDNJql2fwT7cAXY1KO55ycJN23MH6g0WxOVHp+uEoPzQ1xO+Rw5fUZnLGqu0lA57J sPjuUS25j8qDa3zt7TDUV1TMxQzhnm4z+vnDXRXOnt/PQJsOlomFX55zRvsi3b/7TXORuaIzJ/g a13Mbbf9orHz0nE3bTl8NRZw/DELvZojtTnUQmLi/8Qrpeh1ocKCFyDfpChbOI8uHMiF9xGOlHs qQgXBFoT+EpwsTcGfAulyMSQqj/B3YP1suZHhzB8vkR/jqk+v1nPm9tI894dEpgfFkHBdAUA/3c HssK28dgxKqjHoituHHb7qjDuLkBw62ihCEjNLZ3s3oJCHhG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Add a message to the error path of devm_clk_get() and simplify the error
path of devm_pwmchip_add() while improving the error message en passant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-pxa.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 430bd6a709e9..8a4a3d2df30d 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -160,24 +160,24 @@ static int pwm_probe(struct platform_device *pdev)
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct pwm_chip *chip;
 	struct pxa_pwm_chip *pc;
+	struct device *dev = &pdev->dev;
 	int ret = 0;
 
 	if (IS_ENABLED(CONFIG_OF) && id == NULL)
-		id = of_device_get_match_data(&pdev->dev);
+		id = of_device_get_match_data(dev);
 
 	if (id == NULL)
 		return -EINVAL;
 
-	chip = devm_pwmchip_alloc(&pdev->dev,
-				  (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1,
+	chip = devm_pwmchip_alloc(dev, (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1,
 				  sizeof(*pc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	pc = to_pxa_pwm_chip(chip);
 
-	pc->clk = devm_clk_get(&pdev->dev, NULL);
+	pc->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(pc->clk))
-		return PTR_ERR(pc->clk);
+		return dev_err_probe(dev, PTR_ERR(pc->clk), "Failed to get clock\n");
 
 	chip->ops = &pxa_pwm_ops;
 
@@ -188,11 +188,9 @@ static int pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->mmio_base))
 		return PTR_ERR(pc->mmio_base);
 
-	ret = devm_pwmchip_add(&pdev->dev, chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		return ret;
-	}
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "pwmchip_add() failed\n");
 
 	return 0;
 }

base-commit: 6df320abbb40654085d7258de33d78481e93ac8d
-- 
2.47.1


