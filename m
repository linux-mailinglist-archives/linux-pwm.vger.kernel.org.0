Return-Path: <linux-pwm+bounces-4357-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7299F26DB
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Dec 2024 23:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21420164484
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Dec 2024 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7B81D5143;
	Sun, 15 Dec 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOxdURlf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582341D47AD;
	Sun, 15 Dec 2024 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734302685; cv=none; b=QrNe7G2n4L7wKKvBaRmNvubtpXB76NcUfdG20daeQ99KizMwLPTeGNLR5/yJcIWxWSYngi7CWF/+09KHIfHM6tYUAQyneQWRahL8WpHd64hr2pLAxC9ftI2y1Eoh8FBodjqctUPKkd+cpA/CuVPiKf0HiZJ0Pr5Sc+qXx10nw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734302685; c=relaxed/simple;
	bh=rGF8wKJU+4QzLEOp7G8BuLkKysHRkIm5MWdmIf8RgDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lDas7rRfQxDsyuT6r8qgDXl1HMz0ZkoiC1XR1t8qLcc6Jnadog4uun+KtKY5xXcYZW42/TJG5GjcJHtl/bQ00sfGbJpv0BbKFSVzVZC5akBCy/9dDwRZzS087plukieSXUJpSkx17hayeAVGuCHRiLT9gN81xadMTeQnXpfaeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOxdURlf; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a77980fe3aso11402015ab.0;
        Sun, 15 Dec 2024 14:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734302682; x=1734907482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYZguq+bOqaLBNmT5LzVDxT3aVxG2gbJEu2POu819ug=;
        b=XOxdURlfJatZNoQ0hLl5uutPh0oW/9QsQSpFdbn4lav0WH/Y4MBgekc2caO+XrPkoy
         ZLF5i7YqS+kwn66kUW5W/iXUQq6eXIIqQkzT8Ou2xdjdK156sJbOUY+b6Gk4shhiIg5T
         XA3pO/VJCrF+dbVb1XdKjdiO6wEmwyRd3F2dWF55UCATAwUrwQCrAuFJbsd3c5BSPA6V
         tvVZk8y/VdVMoLZ0mtspbK9RNqZvoXo4DI7pzIt8TzPR1mLfrT/2Z51eqvEmczkxe9QB
         pCmuGJv4yuZNP9KMirBNE7OKGSQPWbu/MolTSrtfDUMNTlv+d9MTY2UYyOUmepc+dhdl
         sWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734302682; x=1734907482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYZguq+bOqaLBNmT5LzVDxT3aVxG2gbJEu2POu819ug=;
        b=EvHB/XuKePcqGHDO3+8TPJnADLkbOiOxLXTycB2CbI3rKfi3c9XNoYl4esjvH7wynt
         ymTC4B+XWNVBgH5loZNpiZFcaw1PH2yfnkyxivpGeQk24i6j6dYVG/9pNEjC2NzkykW7
         p+mEATi1w7Cub/zXR+FDNNgGFQPzfZpk47gSAG6GckyQqy/3yPJQQi8StfXXc/LLAsRZ
         PDqp2+5ES+1fjWcSFyadRXGuMOXnzbrQkXAlsAwXqvw6nGoGBmuKqQ22U9Q4wwG0PtY7
         Ng4TG3XwB7VsB1MjbE/0KdABUPTSbFHJkqy/GzlG5brbl8pYS0h7QmWjafg+jQkCZWS3
         WuCA==
X-Forwarded-Encrypted: i=1; AJvYcCV6iJbl8o/R8O03gssJB5s7tFAkpJkSIHS8942X3CYFZfvb9DJaaovoKGVICQfsDxXLfShdGORsZc949ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNs5eD23dh4ms6kLSJCvn/YeRvMuYysLSAGfDkNAhhke7TizZU
	9HRcyVCWf6TxnqpN8rpu+V03Uq8dKylqDIO2+PupNStFenn31lM8
X-Gm-Gg: ASbGncs0+xQCP/RJbenJGurSeR2hCRdNoV0XCLl4L1x0OTkrjhIioRsnmo2IZAU7XbL
	1weSKGfv1nA+FAbgiY0Er5l+kZrUmyEH1VWmx7A630mZNx6kqVotDvtD50sylPexmNXqN+yfXpx
	+FW2lUB+fd0lWav5mY5fcMt8FBH6EVeupjJMEPveZphAqvcGiDu1v8DTxZaAhYtkRFBv4hUO6Ry
	LC5c/CGmgFXQwSJVZB4anthZiV72ARy7Z2ILvhdaBkxUdODgCXSsdzTqHopcXsI3zBQ
X-Google-Smtp-Source: AGHT+IGePq+VdOyJwC/DP6nHlG7iOFgBuuD/YTZRBrTEMTV7bz9Y/zOVCSArMUyH99zVjxlIVgJnKw==
X-Received: by 2002:a05:6e02:198d:b0:3a7:cf61:ded7 with SMTP id e9e14a558f8ab-3b02e0383f4mr90832675ab.10.1734302682348;
        Sun, 15 Dec 2024 14:44:42 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2475af2d9sm12349775ab.14.2024.12.15.14.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 14:44:41 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: fabrice.gasnier@foss.st.com,
	ukleinek@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thierry.reding@gmail.com,
	p.zabel@pengutronix.de
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] pwm: stm32: Add check for clk_enable()
Date: Sun, 15 Dec 2024 17:47:52 -0500
Message-Id: <20241215224752.220318-1-zmw12306@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() to catch the potential
error.

Fixes: 19f1016ea960 ("pwm: stm32: Fix enable count for clk in .probe()")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/pwm/pwm-stm32.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index b889e64522c3..b94d186e3c0c 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -858,8 +858,11 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	chip->ops = &stm32pwm_ops;
 
 	/* Initialize clock refcount to number of enabled PWM channels. */
-	for (i = 0; i < num_enabled; i++)
-		clk_enable(priv->clk);
+	for (i = 0; i < num_enabled; i++) {
+		ret = clk_enable(priv->clk);
+		if (ret)
+			return ret;
+	}
 
 	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
-- 
2.34.1


