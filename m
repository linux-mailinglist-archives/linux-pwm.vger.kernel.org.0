Return-Path: <linux-pwm+bounces-3341-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B1797EBBE
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBF91F20EDA
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 12:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12EE8120D;
	Mon, 23 Sep 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aS7BgPCr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED0196C86
	for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2024 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096071; cv=none; b=rXKvvlTH4u4hYE8nu28nufFMs67LJPRoOohd44zssQ89WLGYUEfdNSmyQdXTqRxBrnpSTDjwsw6kHyeXPZYhM3cekbOG71RLdFwUr0M7oyGMA2ZtFu0MEEX0RaaDpqcUWsrsmE4s4DNbXqtrroAlGd7FYrkW9sihUdNmnMOMI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096071; c=relaxed/simple;
	bh=fkdX2qdyVa8XQQhzqRNN1qcWXCIclow1HT74EdiUjeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G+BlCXnh3PwnJH/6iLyElOfO/OEwEurH155C2ev4eNQQK537qrVBET4LYjcQNuLBuoaTKj5tfQjZ0+k7V9T3kvKjGUkQkfBFBkdV85eRWN7siczkeRW39QkguByf1SKh0BYahD+Hbqmn0hjx+r8smkCzK50tvesgH3fFQWhJ5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aS7BgPCr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso36121535e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2024 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727096068; x=1727700868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yh4YI8MDFswPwJ6paWfDgj1WYX5E3EtWwUyMI7c8GPQ=;
        b=aS7BgPCrJcDRZQp03LMTlv3F0/pM3Bb18+BsxlnyCmlinZN4W7CWafWt2Pg7445Lmi
         tvJ/juLHsVS0DLQ15/SK7S+19lggm8CQ8FyYNx0Otc53vZXQV2R5B2ICPJa7p5aoXesX
         Q0OdGwwFjRhlED368hzfmMdW2iNRkORvE2jpnWRUFyGGWRVY4qOF2w6XiR0qU3DCdWfR
         n4/YZu2wCetL5PTuQsZNZV7mSfVUX6GfuT5pwjqfWIrzs8oZZk/h48KuuuwLLubpQnzf
         SZLA2E/xbOGG8Kr/W3QauI475WRkUEKChpD9RkOZo2V61w1CtcGAm5g2YgRR3k9LnbzX
         eQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727096068; x=1727700868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yh4YI8MDFswPwJ6paWfDgj1WYX5E3EtWwUyMI7c8GPQ=;
        b=F4aKizMMMdkOpp47hwGUoKqk9T2u8fbhVeDQMw/zfAcWx9Q/ep95mMliWJJrYN7+zK
         WAuZycFANALnzD1ooSPzKiaEw84mvfG+dSfLDsIGe8kk6qcxBCTvtSJyJLBxJTTi4ZQV
         +YCVIxgAX8fJh39VsHP13SyDk6G21mLBvflz0pBIgz/86jde7xUd7gJ2tzUvgCS+JswY
         YX4NA3qt8TsD5kVLInr4GYRam4Ep5hVj2i9FpsvEIR25ocs7JzC9SD8BO4ad+8zTOKhq
         pkfqfz5CR9OJJVKJmMfL3xO4teaH8aY/Ljcn7GZWA51pgR7oeVQHHhzwxswSIVqVbgCb
         UsMA==
X-Gm-Message-State: AOJu0YyX/wpIoF8eSKU21yxXcbdZV6JEJox4r2YxR+5jE02t6d1ug5Na
	tnu/2hmqOIFU40gtLHmZtLEjo+EQWWKdkMprU7UT3qu0c3Yy1Q0xEYoDpLSs6kc=
X-Google-Smtp-Source: AGHT+IEGjHnkFit7841GhvucGBCyOMPhgxDoJaHn3olb9xYhfSmxpIa8Gv9DhOgOBkQI3ZssiQhLEA==
X-Received: by 2002:a05:600c:3b17:b0:426:6710:223c with SMTP id 5b1f17b1804b1-42e7abe7aebmr68934555e9.9.1727096068218;
        Mon, 23 Sep 2024 05:54:28 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afe0eedsm99915575e9.32.2024.09.23.05.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:54:27 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: axi-pwmgen: Create a dedicated function for getting driver data from a chip
Date: Mon, 23 Sep 2024 14:54:17 +0200
Message-ID: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=fkdX2qdyVa8XQQhzqRNN1qcWXCIclow1HT74EdiUjeM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm8WT6GLZcnl7+/Dbek9vYcq0NDZ6OZ+9vGCh2L fVSWiWN0F+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZvFk+gAKCRCPgPtYfRL+ Tjx0CAC5dIROdFpnwfRFTaMHpxjFJrdpb8KiHiTUt+tKQBjnnAWkzrnyZVb2D1hIJnk/+58ZpYH 4IADiG5ZGZXZz+AyeoYWqive6E7E7ykF2RKLs+IkAyd95hraALaSXDK1Ly3LTSwUfZaTclUxm3/ qgj0cbZOXYrqQacDSulF3tJ3kWoncKqcTiSNreuuz9KTTk2Q98OZOGjK5r4iGpKgFJH3koroaBY YpDAj54qFn8LcqCtBM5nM4EwF/aN9tqzadJz4FoIFndTMX6LbuxKSEJ9fqOXFEz1AZosVq76ith i4deDt0LOp0KleJYdFwBSmi/5r+i5nhacVQrRobAFKcJo4ah
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Compared to direct calls to pwmchip_get_drvdata() a dedicated function
has two upsides: A better name and the right type. So the code becomes
easier to read and the new function is harder to use wrongly.

Another side effect (which is the secret motivation for this patch, but
shhh) is that the driver becomes a bit easier to backport to kernel
versions that don't have devm_pwmchip_alloc() yet.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index b5477659ba18..e5162f3e511e 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -53,10 +53,15 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
 	.max_register = 0xFC,
 };
 
+static struct axi_pwmgen_ddata axi_pwmgen_ddata_from_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
 static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
-	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
+	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
 	unsigned int ch = pwm->hwpwm;
 	struct regmap *regmap = ddata->regmap;
 	u64 period_cnt, duty_cnt;
@@ -100,7 +105,7 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				struct pwm_state *state)
 {
-	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
+	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
 	struct regmap *regmap = ddata->regmap;
 	unsigned int ch = pwm->hwpwm;
 	u32 cnt;

base-commit: 62f92d634458a1e308bb699986b9147a6d670457
-- 
2.45.2


