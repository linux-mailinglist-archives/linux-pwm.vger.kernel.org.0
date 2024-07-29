Return-Path: <linux-pwm+bounces-2923-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11A993F850
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC33D1C216ED
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844BC15B119;
	Mon, 29 Jul 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SwURyEuy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48EF155A59
	for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263710; cv=none; b=IZ1Ev/R5cEs8y3OB4ZIZlwRrz59UqjkxZXf4IX0y+KNLkVI1S9U+SlVTF6WP/iSA0qZ4JTJE3X6c4sPK8SC2rejfLoetBIbNv+Xr0wt8Wqre9jmc1ZBy2ihdCMDq6sp+hNctCQGo/bPnwrplaYNaAHMCGQ14Sjhu8kziEfMmiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263710; c=relaxed/simple;
	bh=G8RzSgzqE3b/YQkVUMRKktKZQUWUi0ZOXcwktYDJ6dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txOtzg7m9kmkK2W02M7XrzhCTCsmQCPpahonvpkHVKiX2S+MALWIC+Is0eNSVbN2nwNyMCssOA1+Zk/xhdxeO3Hc9kkcnRd5OO+CppwpPOTNASZ8f36VNP47cimTfyKp3RQdCdB5VnSSRzG8r9bFz8ZY8fUCEK3wIUwE9mX03xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SwURyEuy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36844375001so1292141f8f.0
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722263707; x=1722868507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Czqr3VJTl4Kc4YYcH1tRw4LJap/cuiBFRZk+Kq2Jw3s=;
        b=SwURyEuymjbLAzlJttPloASO9K01ONk4kFJFfdCIbmKs6QjNUw4s6+lC8dye/3emoJ
         aN90xkkHZ859Z0vzQ5i9qam5YuIudJnTXM92OOgoZibZb6MtqR+bNENww2M06rwbHaCG
         Tl5ky1DMSsUYs0t1Ay9mE3hqWucu0/sLAUI159OrEx2s8muLk9Zy6zJ/BZq4xA9d3V6o
         3Wx6o7xfBiqjCfAqhBT4VQz/NbGEkNfLct1v9rUpGrNYUlDtiqHBY8z7OlRvpbeIzhM0
         ChxMD/h9VcALfLBYx1QLgViE/yK4vVaFpVDsOU2bQ+qdlzIlmgvfGkp86lkUM6K7+4EK
         X95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263707; x=1722868507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Czqr3VJTl4Kc4YYcH1tRw4LJap/cuiBFRZk+Kq2Jw3s=;
        b=S1CaCFGyEZ9f4tTOCgbGolRzkeYKV/0nCnMtaQc2YkQIw2QYquhPG3vVFPkBJCDXz+
         bIzHiUQjvwvPjViwuXSXlkfYxtqDAknk+PFGOKWKDstOuiVoLjNbLbKosZpf6XIx6Dqv
         PupR0rOfiENekpCyAI9fIG3CxPZO7PwACgwrIKVnRv0WqcjXbHaVYe9/nI/1i5gYS0cG
         a+jkZJ1yeSFDQZsriUpSqxRqjWTV2BKndl0kKubyPGgoePqS1dwlm3+1W7HU99MnsFNl
         1UPdIftEAFUyFXWaytpC6/ZwJlITwMqrFXpjlZwBCiklm/HhGWIXy1APXwXhBX0uXa7Q
         3pIw==
X-Gm-Message-State: AOJu0YxZhJuP5PaE3RkHB+1taKOSkD/+YRFs4ezc50j0+IsO5OhppTtn
	RoavmOlBBUxXVpZ/2fK0nnFtv0TS3PvUyoWHxxsd5MqavltOb6YnKItuDS0+vQ6k5ff6VIBhu7d
	F
X-Google-Smtp-Source: AGHT+IHY7O/M+9SVL5JcH0T+2k2tGxsTtXE/FT7uTm1WEYrs1GBs89XK9ESYfBHKG4TQZ6f/8uKQTA==
X-Received: by 2002:a5d:5888:0:b0:368:4e86:14cc with SMTP id ffacd0b85a97d-36b5cefd6aemr7502357f8f.10.1722263707002;
        Mon, 29 Jul 2024 07:35:07 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:59dd:510e:47d0:643f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c093bsm12569716f8f.18.2024.07.29.07.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:35:06 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v3 1/8] pwm: Simplify pwm_capture()
Date: Mon, 29 Jul 2024 16:34:17 +0200
Message-ID:  <ee7b3322c7b3e28defdfb886a70b8ba40d298416.1722261050.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=G8RzSgzqE3b/YQkVUMRKktKZQUWUi0ZOXcwktYDJ6dI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmp6htSFOEhjeD3V/7VA9S3ARvLSX7hiOQRtuob z8MdQI9b9yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZqeobQAKCRCPgPtYfRL+ TsPOB/4vxC09yJKuDnTlShoGZN47mTAbKnQt10Z98J25uwJ+qTEDUbPnjOs9c4KD2STNnxpFBiC HvIzW8xC0T4jozo88ATYj0uma8JQK0EL1vO0/G6eQYmOgKRB5XfB1KcScKnfDG5PZ6TtB7aZP27 Bjt4b6AnNjW7jmlUpxZ0lCHBtV7loakAcZFzdgdwa4Ryq3tPHBrUT6ZOocTPQbfrRvJNpcUE0aH j7qsHE88wWoGFBf085pS0v/MBC3sfqglmEHqpQ0q3TmarOZvdG1byUrs7LkHwnkZYEbJHi8Rc7+ UOjFCTXcvDLeEJqE4JfU1U8Xli4oACB+enlkms/suRC8UlZ4
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When pwm_capture() is called, pwm is valid, so the checks for pwm and
pwm->chip->ops being NULL can be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 56d91c11f0d4..6e752e148b98 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -328,15 +328,15 @@ EXPORT_SYMBOL_GPL(pwm_adjust_config);
 static int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		       unsigned long timeout)
 {
-	if (!pwm || !pwm->chip->ops)
-		return -EINVAL;
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
 
-	if (!pwm->chip->ops->capture)
+	if (!ops->capture)
 		return -ENOSYS;
 
 	guard(mutex)(&pwm_lock);
 
-	return pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+	return ops->capture(chip, pwm, result, timeout);
 }
 
 static struct pwm_chip *pwmchip_find_by_name(const char *name)
-- 
2.43.0


