Return-Path: <linux-pwm+bounces-2763-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48F92E6CA
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 13:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C60B2A719
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE321684B9;
	Thu, 11 Jul 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r0C3YnWX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC313C3D5
	for <linux-pwm@vger.kernel.org>; Thu, 11 Jul 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697293; cv=none; b=WfXC+8W2Nz+Bqbb0tudeTerqDpmknc5U/YraWMUF4WDy97yDBc+NYHwH7nmxiA8TA5EGQenEJKORYi6mIBVPAJZYocU9T9hVUsY/iXnvE3DhfpvPt29vA9QVkGqlsmaYyn0/VK1r6C07xC9wDcpgEqDaZFJ1i8MYl1b7vR/m1MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697293; c=relaxed/simple;
	bh=ue/D6aaMj20smtKi2jAbMVRAEMMLERO+XAiZ94XCja4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MauJmMJRfX9us6ea4RIKBxUPYg9xLAYVCbyUwIaENcZL+YxbJOfXwtXVx04fpVYodT73aUqfj0AZe58k8aPhSmhUXQc8G0MJfcdcdraGsifVD2ZrPctL0RMHH1EDyNq59xOkwIaMAvsZW/xZfwX0H+o1Fxm8dQJRCeH8gdKEbbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r0C3YnWX; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-48ff6336bbbso272407137.0
        for <linux-pwm@vger.kernel.org>; Thu, 11 Jul 2024 04:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720697289; x=1721302089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4IagqgBEWB1oo5Cqg5iaPlJgTTeYOkk6mC1e1sE7v8=;
        b=r0C3YnWXAJsxJkmItfRo5ybrRyuMf29JIRjN3bMrW9xlXMrtswSLUSom17XDNtRzH9
         LmtPZ8BBn1rHmF6lDTts+a0M2QsxbFHONkc9efTku7unyMx4zZnSNAI8INo94D8RchbU
         QeWaq/lrez2BxqO/WbFJXma/TRhVmalOHJfgUOTyBEMzpZEOIOmpFkSSR3I5fjwipDqg
         V4dNccCRMMt0jlGi/RyUdcIcHajUEKAWrvWFHY0jVse+zgHCwD30tYb886vIThPWG/Vf
         yWd3hO5IwugiPdYai51yqYEFqNRzxkpyElLz35sVHSUiZmjKAqn2E5jkM2a4v60cjj3c
         AiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720697289; x=1721302089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4IagqgBEWB1oo5Cqg5iaPlJgTTeYOkk6mC1e1sE7v8=;
        b=qFmNKqFleYldrsHh1YAvFZbXLLg4rrIwdJEIPheCsVDomekEaWQP2S9PRQtV1PrGFE
         hM7zB2nWC8z3fAcrHT798ecZ/JwWfryrRhqRd2IzJ+ShmhCwPpCKQNWqmnUlG0H1SFwl
         gu6wXBG727aG0Nr1jjrgL2W7MXv/R3MtN5i4yLw10QrIkiwXkU3fUElPIVKuDtgCeCHh
         E5551PctTgt5a1Gig0OY39vTkeTlyT2gtt7axzpNDJrI6YBYBbVwmW7aEJeOg8nnCft5
         Fnnq6QsYruSrx00HIaJ2zQrIiKoyQdeVrQ7HQwumII4hy9c9u9jp9fQ9gWADtqTFT2gg
         esVA==
X-Forwarded-Encrypted: i=1; AJvYcCVogSTJoAhjGPGtJlVy0CMah3V+qwj3Iq7O1B/3CZkzHOq9nwmtdJ0XwnY72dWIBBribi8+iSLNw3FFf9Bli9tZ+96ed899WDKA
X-Gm-Message-State: AOJu0YxLzPAV3JE82g0VbftD2BMs/SEmsgAdLVlC0/ZCh078n0OxGkdT
	SDs7UmwSHHq5frid3M1l2G8lhoIgRliDSaSMXlN2XkiTQiKQeqf6XxVI9liaFqo=
X-Google-Smtp-Source: AGHT+IE64NYEOMzUTR1HNV/M/f92iVl/wBjraeYffY438wDyec46/vZDcyXmkgrZkYcLIj4zwnmaVA==
X-Received: by 2002:a05:6102:38c6:b0:48f:9751:198b with SMTP id ada2fe7eead31-490321f8006mr9003557137.23.1720697289268;
        Thu, 11 Jul 2024 04:28:09 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b3d293sm29021281cf.25.2024.07.11.04.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:28:09 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: axi-pwmgen: add .max_register to regmap
Date: Thu, 11 Jul 2024 07:28:02 -0400
Message-ID: <20240711112803.3942189-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711112803.3942189-1-tgamblin@baylibre.com>
References: <20240711112803.3942189-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was missed in the basic driver and is useful for debug, so add it.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index aac4f395497b..3ad60edf20a5 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -51,6 +51,7 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.max_register = 0xFC,
 };
 
 static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.45.2


