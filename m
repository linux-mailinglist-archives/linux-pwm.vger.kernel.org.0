Return-Path: <linux-pwm+bounces-6512-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B29FAE6E6D
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 20:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28AD1657B7
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 18:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153D72E6D18;
	Tue, 24 Jun 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ojE7rb5y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050722E7645
	for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788986; cv=none; b=utEBy3El3R1MdzqHuIFDWtkt3Xao430a1+IF/rrtIf5PLAM5a2NHy3C4gaI5JzIpe8jE2lcULfgpk4PF1hbmbtHwXKQRRPg9Cku7/5v6Ktk/OIEpdUl3BB+bitxhooYT24VlUXsq6YgmvMh7BndZ9qUyqkvjmHE33ehckIIal34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788986; c=relaxed/simple;
	bh=NvQD3fXnLzPTvXsn679dpioaNFXD/aZRWpwOyI2eTcY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqJU0Kkpd1ZOYV5fglUuoNXrsr53RiodAHvQP52D9Oh+Ch4ab9ZhmmpUQzbilY3gllGMpsJbWX/qAw+3FRm6JOUL93r51qByuxSlw3MF6KWcsrkTHu5Fjc/tU1PVV8a+j77XfDvjLKvHMs1ICQ+6Hn6DZH5VEU0Ywzcnmw6RlFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ojE7rb5y; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so1234187a12.2
        for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750788982; x=1751393782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VSAWpgAYsBfVQtouoYH4OTDwZ+9xmDNPfP0wA2V8hY=;
        b=ojE7rb5yWloNxI7bFB2QFnNNwh0xtowlrDdyxk+QwO3T0eEKd7csWsWaHh6O+v4oiG
         cIUtTHHKbLhosWXhZz+jgZe7AFyPZz6qFD3zfxA4zZ9+Q58MT8aFJQlsxf0jmuu0Q940
         odkIqZHybm3hgFbLF97CA+FhRx0lIEOdfEvfc/S5oXsEbTmhEBFBLYGuwee9+BnLTCyM
         PZHjuopC2sWElhEGbaNU3QRC2QciTn093Vy1u5pL+d9992mxNN1JYh9nC86kGDlX39H3
         mAZd+m+zMH8sGFXgQrw+oedHiZoxhPSKnHRAX/fH+a+b/aOACIIowvhptTsxkBiymMc+
         g+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750788982; x=1751393782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VSAWpgAYsBfVQtouoYH4OTDwZ+9xmDNPfP0wA2V8hY=;
        b=fjG2mZlAc82x8I3PxHU7Ms95bPydylk5Eio7H9H3V3KG0KAI0tQdZs5wOPueOrm9SB
         QC6D0HcaM66g3V2d1wD6I1wU/M1ZaH8/Ye8OYM9HJyWGPL3zSelkzL16bgbegSUTtrZx
         rCwSFolV6CCaWZptXFpvvL6hsVD1BqnWksuDLjhDhzVCSfYDdNyNecljvRfFjS05ilRj
         t4sG7UYX8nqtsbtESTN/y1ML3cf7RkUu78KWKYLciIR2S8kVFOcg64C7oTV7i18+v09c
         nebg+1wHpXwKlqgDzB87YfC170QO/u9uIkHYOAdJYAZNId3j1c9EbFsQbNW2LUKxGcUT
         gdSQ==
X-Gm-Message-State: AOJu0YwVx/RdP8YGzTbT5mfV31FmebOu+FWqHxY7vueaasUYgc3+2hdy
	UZNbHoz3VgBDQJo+dI1y7qbrei4zGNQBm9B2+GP/XyRLOyKuglNNkv2kUXlmLlzpk78JsFvYNqj
	PE8nb
X-Gm-Gg: ASbGncsbJploAMsyhROEfMp1+PJzmr2pImeVssqq7NtkLCTgfQu9r5aOU0Z+PKhr+Rf
	iuugfidWAtnYVbVRUF3qT8KXoxI8hVPprdYi1omw2Irgzq24dT9Zk95thp/jT5ZDqTULTgd2DXw
	Zg76Qh2ddkygpGP7+0f+ccuUPvXPJg+Eu1WTVtqa5lHo78P7gzGg8iQYt0WK0BSWjhS5MRYcYMG
	xaJ1qa6P1WIo4Jb3NHBIuKjSZXgchtNGzsRb3J4T7Xzz9/enaIqWyIFMj0910pBW0UoW49pCyEL
	1sOTpQq+6aI5/vV5EPi9BzNSaoUEwlBb4kFkYH3se0eC2rNq4Wu/zWyz6rmbnszrGvo=
X-Google-Smtp-Source: AGHT+IGdCJem07FP7Iv2h5Qurxq6n5DpZLw4TIvTiZxKg5QEWDrkeJkNz0FJTnx3KZcXKVjWuh3V5g==
X-Received: by 2002:a05:6402:1d53:b0:607:32e8:652 with SMTP id 4fb4d7f45d1cf-60a1d165ff9mr18330371a12.19.1750788982332;
        Tue, 24 Jun 2025 11:16:22 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60c2f1ae7basm1348550a12.25.2025.06.24.11.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 11:16:21 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 2/8] pwm: clps711x: Drop driver local locking
Date: Tue, 24 Jun 2025 20:15:38 +0200
Message-ID:  <d4931dc0c0d657d80722cfe7d97cb4fb4ccec90e.1750788649.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
References: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=NvQD3fXnLzPTvXsn679dpioaNFXD/aZRWpwOyI2eTcY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoWutR61ps/+CrgWIHCWfNw0bnIgOZNY825amIR RZq6vY9r62JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaFrrUQAKCRCPgPtYfRL+ TrhiB/44DI/cYv/OHjSUIX4YW32eAe+ynOl/Xj5aduL2i7V/h/v4LlIel7+X9B1z6iHDMgAglM1 g3f1EiroyNvfFFmau6Iun3+QqzKFGDrDPibdOLnGO3yfvdky1gNDHm9DAzN2HCbCs1+kT5occ9R PJkPJN4nFX3LzpiWE2dEi/ru0z5gjqECMtzE2fwkfvI4+q9bVxnvlADqhmYkcHIkJunKdSoNWmt 0BFCrkx5goGGKhhzo5rTgybZe35I8RDT+3Crrvw8tLBEXT6DyP9YyMiv4u+ehjz6dC0T9AMXAwy fsAOHoyEW1vFspU8y4Tm/Jfk41Uxnu1LLThlUxe1zbTaz5fG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The pwm core serializes calls to .apply(), so the spinlock adds no
additional protection. Disabling the irq is also irrelevant as the driver
isn't an atomic one and so the callbacks cannot be called from atomic
context.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-clps711x.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 04559a9de718..2c92ce754872 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -14,7 +14,6 @@
 struct clps711x_chip {
 	void __iomem *pmpcon;
 	struct clk *clk;
-	spinlock_t lock;
 };
 
 static inline struct clps711x_chip *to_clps711x_chip(struct pwm_chip *chip)
@@ -42,7 +41,6 @@ static int clps711x_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct clps711x_chip *priv = to_clps711x_chip(chip);
 	/* PWM0 - bits 4..7, PWM1 - bits 8..11 */
 	u32 shift = (pwm->hwpwm + 1) * 4;
-	unsigned long flags;
 	u32 pmpcon, val;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
@@ -56,15 +54,11 @@ static int clps711x_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		val = 0;
 
-	spin_lock_irqsave(&priv->lock, flags);
-
 	pmpcon = readl(priv->pmpcon);
 	pmpcon &= ~(0xf << shift);
 	pmpcon |= val << shift;
 	writel(pmpcon, priv->pmpcon);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
-
 	return 0;
 }
 
@@ -93,8 +87,6 @@ static int clps711x_pwm_probe(struct platform_device *pdev)
 
 	chip->ops = &clps711x_pwm_ops;
 
-	spin_lock_init(&priv->lock);
-
 	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
-- 
2.49.0


