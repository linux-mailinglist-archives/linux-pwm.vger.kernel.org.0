Return-Path: <linux-pwm+bounces-3224-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BDB976989
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 14:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50341C21312
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 12:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE6F1A0BD0;
	Thu, 12 Sep 2024 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enYq9NjR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E11A2628;
	Thu, 12 Sep 2024 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145400; cv=none; b=Ug8BgF4+KhJwGpmJTNA3coi2V8VLgeMBMf4kcBMas4di0uKQIOaj2hHdhYvkakdRhmeAKL+xhrv1vDIqbnr5qIhevEUkvD9tJ7Od/B356UwfWDF/SlUJs/jE25jC4vJHifDdjITc4kAS+eXx0MO+LaaBGim3y17Cf3wvRC7iD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145400; c=relaxed/simple;
	bh=/r1meR3OD22lCHhrentm3sSSOvpaOvQAWYGgS5cs9zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTf6oCKZ8sSTIrz5R4XeVzfiYmUqSY6SLRCsScbbQCzM92SdUaPvR1j4y6gxTR9lLt4LVDkNIyR4X3Hx2dQsSnxZPIUmAojuizvnOG4fLWxoeRq3P1BbAm4x+/ZG9AoiyMxo8Njm0Ep+42reecsPbC7bGyMiQZGT4F7Ccqz3hDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enYq9NjR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso8082865e9.1;
        Thu, 12 Sep 2024 05:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726145397; x=1726750197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3rp8VVpH/dfJ3MmMbT8/Q3u0ccTN+30a/lu2S0UiEGQ=;
        b=enYq9NjRlxSLb6B29cmnwnhfDVSfoVQKLisxUtIO1Zu22etoL/fCw2c8WyxBJVqkdS
         2qyjls+WQzjqUByKZFd4B+JBJuSanV61lou+Hr9mrH1Q4d4UjD5GogUiWaRKn/LoLz7S
         mcgoMRb0wDYUgwCOnKBIhvBqBH96bP15uoF9LFC7zEtyuNsg4zD42AOMvemR59yILnpg
         Wr3hA9TtyvGLWa3ko6cqp/GhmtTTPQaBf1OmADueL/2bXJAehux49hgfxoEEuisPu/ot
         I4KomRsZB3a7j1uawAB7pcbd2ko5EU+ixVN9aGEzxymeHxyHcUEnVf9SH8BeO1ocTe0C
         sqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726145397; x=1726750197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rp8VVpH/dfJ3MmMbT8/Q3u0ccTN+30a/lu2S0UiEGQ=;
        b=bHWtfcXY6JLs8pZ9wTdNdQeQ9A3FSCVuSa+i4GirkQ/Jm9tR79tBudzW+voKtMT315
         ajrd+j92iXlJn58/Do8e4gacTvEMHVSF9uT5ZyWq5e2nBbhjOMCMrP7dYc+cKk1jGbSf
         j09aQmluzeEJ7gaW6sDMLNQQfO7BupOFJQFt/i1Omyes8BLAOGehGDX/7MOsUHqgAqfv
         WXV2HBjuHGb+zUkhNtP/sqd5ewCgfffCIRdBnnwnXHPwhJ1lF25GxFAJ9dRYK+5xa93+
         GbuHH7EMK7eyWXlkairICKDiYThvXJ8auXht7dPU9v/UBpClLc6ViRJ2VSwf+/5V513O
         QbiA==
X-Forwarded-Encrypted: i=1; AJvYcCU1sWuQRrbgFKrYbN/4GE8EXrCTHHOTXIe9Np/xtvbPA8Sm1/n8xrFgpkdpA+uFV/qrvW5NP4Ygb7/Wb+SaElY=@vger.kernel.org, AJvYcCWGRpqXC70bLpohTfche80C0BAkJfW53sumwJ1haMhR7KbWPdtFa9V/SeNuxDdH0ODKNI/R6IOhusp2pqtP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx68u4pufOFAhQDQ1nTnl8OWurOzP2RMdeL9DlM3yH4kyNIn6++
	0jeZhOFASZ7+ym/L4CoAD/ZqzoqSZ3uu2hlwdhHyeyKNLntLfNOmzzq7tDrH
X-Google-Smtp-Source: AGHT+IHvi+LdQatFb0FXKtNS+8padGl4YLk4uDGuOprj1zEkd8AriHOoq/BcAdcDtYHdudFTCHDnHA==
X-Received: by 2002:a05:600c:3581:b0:42c:c401:6d67 with SMTP id 5b1f17b1804b1-42cdb4e6966mr20929535e9.6.1726145396696;
        Thu, 12 Sep 2024 05:49:56 -0700 (PDT)
Received: from void.void ([141.226.9.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb5affb16sm148200105e9.37.2024.09.12.05.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 05:49:56 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] pwm: stm32: Fix a typo
Date: Thu, 12 Sep 2024 15:49:34 +0300
Message-ID: <20240912124944.43284-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/pwm/pwm-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index f85eb41cb084..eb24054f9729 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -222,7 +222,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		scale = max_arr / min(max_arr, raw_prd);
 	} else {
-		scale = priv->max_arr; /* bellow resolution, use max scale */
+		scale = priv->max_arr; /* below resolution, use max scale */
 	}
 
 	if (psc && scale > 1) {
-- 
2.46.0


