Return-Path: <linux-pwm+bounces-2366-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 434648FF2BA
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Jun 2024 18:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55F11F22C0D
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Jun 2024 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7255198A16;
	Thu,  6 Jun 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Us9ufERw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD0198A17
	for <linux-pwm@vger.kernel.org>; Thu,  6 Jun 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692080; cv=none; b=G2AyxXgbbG8SHgbr1m6RAd3ajRV1WY3yJFFZjgYwTnF/8zwpaTCcTjvCgLbc4MDTyii+WdkaBpQwAIb2IDX+itnFHkPqU4HUcN66dJF/nvSTFZrQYBK+IqocjCHc3WT/E8hlIr1b4YrRzYszjag36MOthmu/71s3F8coVuM6SNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692080; c=relaxed/simple;
	bh=ANfZJ6Gb5AMFeylo0L3ArIzK7QR9DQ1sQt+nXXAsgPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYJmoaV92fsVPt1gT3d3qETtlDEt4EojYkiSY1+fHn6NSV1Qea+a/rTKpB553jkiwfs/8TgVMc9YCVpzABNgJ6pB1NRzsG+pzOUjXoMdrbbDRE0JabC1JAnPzAOW3Q6sUXXkf5zzsKwcvJUS3LrCdcDQhPLTeQj1lQIjyyIz0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Us9ufERw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35dc04717a1so877137f8f.2
        for <linux-pwm@vger.kernel.org>; Thu, 06 Jun 2024 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717692077; x=1718296877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYi9O81DxTRzwWjZjIwhHRJKesnYYlNWXsv+CHDsXXo=;
        b=Us9ufERwbvdhl40MWqeze739t4DSSHXt6OlxWE65BNL60RfmutZiJQtTNKqIxOHXSv
         D9iHWQhNnnJfvvn8YuSqurg11eGIOC4orSmPbblz1namxmXCBSNJ6MNQ8w4tGZktDqWb
         QGS6g6U/ZNzHk66hCUR66yZTsvxPVoKt8RP4k63blw2ayCEkAymSI0pN7f2jrBoU2uYM
         ynhKXKuhzOZ7tiC4mJgGrryDaUQe05y1Zh7a95WYzyl3wnYwpD+3bHoBmWFDMSePwmn9
         w7W2yXOOv64w93ivjBEfPGqqBzXWCQLxkgqVw0q/qC4ymUu4nrVa0A+PoMPbI1pBYRcP
         ufnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692077; x=1718296877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYi9O81DxTRzwWjZjIwhHRJKesnYYlNWXsv+CHDsXXo=;
        b=UgVnYLHqbGyaVAXLfeWMGjMlGmde+NGnpWeg905ocyI0OGaNOQwCkVgXLE2819ylFO
         TVUB6405Y1wK0oyX30I3tugPYEbIHH70cI2SiHBALOUkuP2IWQ8Jy5uHBMivWpCjIM0s
         bG6wJV8QsxxdfeWExS258ouf5LO83Haau0nark2poQL+2SzrTf64hO5qAxqIhjqVBWWQ
         6TuPZlt5OpHhw2eDgYDFCpVHCBUYZWmDmoXwlyXr6RV9ks+mAuHD4xtF16KvdoyiIgzM
         GSlUaoRKGC4bYOAmRBz8KjHO4qbGZCCFjaxdCsYCGwPR/SKL8PDwcJnAn4vi7NDpmdvO
         xvgg==
X-Forwarded-Encrypted: i=1; AJvYcCVF3ltdq6WArvi64U7i6Big7bKAW3V4d9SsqH9v0GkvnLBYbIt+5Mcpsc3BJA2bWuxosZ9ZeTjFVB5JmQeaTSQGHs1BR9NCGFNA
X-Gm-Message-State: AOJu0YzGLvD1uU66unmGejOIvgXJTKf5ZzsSoPeAKdgsQ1Q8a/zM0ARs
	fFf3BGiRK2os9YePeKFf4JTJXOzm1FBzFp0i6qpr5UtPX4UtMrG7qnUb4iRucOg=
X-Google-Smtp-Source: AGHT+IEIATcbtzxW+BWTDktuGLQow75vq382t0AZk3CvBdL7Z63lES+Gg+U7nDxjTIZVpRLR+QyjFw==
X-Received: by 2002:adf:f986:0:b0:355:1759:db18 with SMTP id ffacd0b85a97d-35efed50ea2mr132787f8f.29.1717692077296;
        Thu, 06 Jun 2024 09:41:17 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29afasm1993079f8f.13.2024.06.06.09.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:41:16 -0700 (PDT)
From: "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-pwm@vger.kernel.org
Subject: [PATCH 2/2] pwm: axi-pwmgen: Make use of regmap_clear_bits()
Date: Thu,  6 Jun 2024 18:40:47 +0200
Message-ID: <20240606164047.534741-6-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
References: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=787; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=ANfZJ6Gb5AMFeylo0L3ArIzK7QR9DQ1sQt+nXXAsgPw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmYeaYHoVCK3Uxm24v5EBMm2zbH8AkQCXBedkS5 bmqnhr6oXiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmHmmAAKCRCPgPtYfRL+ Tit2B/9hc+vsGNC8ZGn1D7jBo+TJOLgnWHHhLqRKufsQxVfl1NOXTRzkz4KbclnqY/4SGcjeIIx GWGf5U0srEFpLfmuPwlcgXz8C8z5t8k7Mjh14mjqgmigiV6DpFWEkZV60pSHKJjajfiZVQahf6K o0dCSRyeYg1FauOIiNm6MbfjshgRBlscX9mPA+QhhEjE31aKvd/oQSFq3OsyLnaI7trZayDkmUs 3Jt4XqneUD8GwIY7XBV34CUOJoMTqPtJZAJo/cTX3krPvpnBBZxxFSNePtWPAUFKSqY9MomIu3Y hZzI3tev7yABFKI9PutXWnuQ5TX6iqePIEAb/keGQSCSsOXK
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Instead of using regmap_update_bits() and passing val=0, better use
regmap_clear_bits().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 1bd4150e0158..aac4f395497b 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -156,7 +156,7 @@ static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
 	}
 
 	/* Enable the core */
-	ret = regmap_update_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_REG_CONFIG_RESET, 0);
+	ret = regmap_clear_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_REG_CONFIG_RESET);
 	if (ret)
 		return ret;
 
-- 
2.43.0


