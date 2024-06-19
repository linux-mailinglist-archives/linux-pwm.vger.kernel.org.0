Return-Path: <linux-pwm+bounces-2551-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5153E90E803
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 12:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68214282B07
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F89135A67;
	Wed, 19 Jun 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qmiFIqRM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB8812FF64
	for <linux-pwm@vger.kernel.org>; Wed, 19 Jun 2024 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791937; cv=none; b=LS5uTxmcWPLYyGgFt2yFtBZ4D6/ZOdlVKNblU1/sHXLlp4+vd7+/ZVPACsiepY+BFeIaaqQjczJD5cZRR2Tq6CdZz5BSNzS++8GSlWCBLgYMWajNCXHi5PEfp89lGgV+Z9wU0+JVfVaDOxc6aYRnv/J0GD4JMkm7+4SBtn4MHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791937; c=relaxed/simple;
	bh=zia9ohJCDf6pPTMCj3l2MlOJgs40Pm2zXv4CKnsKZ4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Az3vmaTj1tDkfqX9poNraNbrySWhL/9G2OOBd+Op7KimyMmQryffHCc4MNF//XhjATyKeE/Ym+dh8GauhwgiuKDz1LoIcNffKEswENMjKv/pohof5RWOoIuCCZRUuAoOy3fvtZocmLFc2D0hjfMEZ5n/B2c2FrkN6CyGg2XIxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qmiFIqRM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6ef8bf500dso727469266b.0
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jun 2024 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718791933; x=1719396733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi4aJYEUuIQ/V13fBIYhBcSSVZbkz2WHC3xkADAjAwY=;
        b=qmiFIqRMGFsNnMGiHeZsAMuNejOvSDqNWiMzfHAXiEObiQO3FCgLl4v9fIXwN8Itaq
         A/zE8PWaiWpZSKZEg7jroMwls3P/4m+pHuH27c5yX+2BbkgnuNeplfJyk4/iPDw2N79n
         8lxZ1UP/WFmhq9/YCDkfLE3SmgbUo6dw7rqi/kwLK4q4yvblx331zFtSlQqnx7ATiBNz
         GuV5r47mYuLQM/GdxoeIhpR8m3CmIustGP77/I8CCp79v9SPkkeoYP7e7bqAtXkm9Xzt
         1x9ja9qFjKATu3nQT5pzf60BYFuhPOq9PdeJvM2rRwCjGwrYDjcgmQcXWcn1V3ED5Ttv
         4Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718791933; x=1719396733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi4aJYEUuIQ/V13fBIYhBcSSVZbkz2WHC3xkADAjAwY=;
        b=MNFpSJsz93pZtofT0GjUiSeEzRB5m37MJmUgpSXsO/ceYtiBUcRBsDpkfQQAbEqre4
         EArnaLvchAuTxuRbBYdSaYuP8aimAGiKNeh98JJ/38uUmNmGlzIJskEYIEL7tqpMoOPD
         7NeWweyKXPfHLAHGYu0iOn57JIY+n0aGfVn/t01j84lDVzzzewFug3EbHkOoRMVOy5v0
         +h41I9ag7V8ypYiptnJ/PYPigUvlq7QH52n4i7usf3562iJLBfR9+ABPRTcCyQSqdCdK
         n+Y4I9t5PBmQrMt8P2g92dgIgQIowbeoNYExzhXvu1EIr3R+mbKO0Vp3ZzP5kTNGOfqH
         DmXA==
X-Gm-Message-State: AOJu0YwTx/Zb+hMLwkB+0e5oCgGCV7evfvCzLjz9fR0ZuAteWchr99Zx
	PAHgtNOrEgNsteqdXSEI1KGurkxv5abEdSR0uSAMY8IVX5/4wU6VQa+AnAS/yu4=
X-Google-Smtp-Source: AGHT+IEvkBeb1adtQps5uR2c9XR/Xi41EP+Gxj4qPXO+OoA/UyIlWg8yqWZ8kfEL9FPggix9HVnzKw==
X-Received: by 2002:a17:907:1682:b0:a6f:98b6:36e with SMTP id a640c23a62f3a-a6fab605048mr169655966b.11.1718791933291;
        Wed, 19 Jun 2024 03:12:13 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-363a23143dfsm1168204f8f.87.2024.06.19.03.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 03:12:13 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: [PATCH v2 4/5] mfd: stm32-timers: Drop unused TIM_DIER_CC_IE
Date: Wed, 19 Jun 2024 12:11:45 +0200
Message-ID:  <6c8fcc4ed159992a1dbb0796087e6ceb10c39c96.1718791090.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=zia9ohJCDf6pPTMCj3l2MlOJgs40Pm2zXv4CKnsKZ4Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmcq7oy8mveEdP8uq3o2jBR0yAiv7fDFKSJltQ4 YkOueb1NN2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnKu6AAKCRCPgPtYfRL+ TrX5B/0USVLFzo4MlcaT5z91XGN6knZpVjFtzoHUM0al+H/HJnjOPt2QItflEUYgFAJQzvuiGBb AZhX+KiO1s5etz6fLwixuy9K3rJ1JXcuBQ5FRDBf3PsZHXNKY3Htb4q3VYI34xmH8S8gLwCMk27 DoObyZ4OWbW++D14JjTSStR8wGDREHItW8erobR0HABTTDcP9K8n+HqNXDPyvgReo1fB+VlDwr/ IBtUTkomTjRAmLKMk0kQz6IzO6UmIpQC3VRx/R4fVBWGsq+gypGxPqP8kyoDhONcuf/bPJTt6C7 0rKidDi+2qnuyqmHz9QOjbqCFPs74jFe1MNyOrRuKdTNk/s8
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This macro is misleading as

	TIM_DIER_CC_IE(1) == TIM_DIER_CC2IE

. The only user was updated to use TIM_DIER_CCxIE() instead which
doesn't suffer from this mismatch, so TIM_DIER_CC_IE can be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/linux/mfd/stm32-timers.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 92b45a559656..f09ba598c97a 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -47,7 +47,6 @@
 #define TIM_DIER_CC2IE		TIM_DIER_CCxIE(2)			/* CC2 Interrupt Enable				*/
 #define TIM_DIER_CC3IE		TIM_DIER_CCxIE(3)			/* CC3 Interrupt Enable				*/
 #define TIM_DIER_CC4IE		TIM_DIER_CCxIE(4)			/* CC4 Interrupt Enable				*/
-#define TIM_DIER_CC_IE(x)	BIT((x) + 1)				/* CC1, CC2, CC3, CC4 interrupt enable		*/
 #define TIM_DIER_UDE		BIT(8)					/* Update DMA request Enable			*/
 #define TIM_DIER_CCxDE(x)	BIT(9 + ((x) - 1))			/* CCx DMA request Enable (x ∈ {1, .. 4})	*/
 #define TIM_DIER_CC1DE		TIM_DIER_CCxDE(1)			/* CC1 DMA request Enable			*/
-- 
2.43.0


