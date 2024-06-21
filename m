Return-Path: <linux-pwm+bounces-2579-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F6911C23
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2024 08:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854AA283D96
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2024 06:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55DB12C801;
	Fri, 21 Jun 2024 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RCWS5O0e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47912BEBE
	for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952882; cv=none; b=T7IcCaS47tPyss8/pVJoW2+sLm6VjwrxbzfjY/dea+pPWIlY0vV6Zi6fMOAdyIJD0lEAwMHN6KO69ATZ0e6sMFtbsoDfVAnlnf4ujDX6AWxiV5EIHz5bROqGb/WGh6dkTMaG2n9vDzGfyr8PFT6BJjDPeB4GZZiJi0SiS6TvAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952882; c=relaxed/simple;
	bh=MXCWIEHjZagT0uCOJ+g+R76lwVk/kK6hKx6erlJbECU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=caUTG9GnoM+F3ZtFE5JdiBj7+Kyu7pCazHkN64FusNS5CzsSm3The3xoWSQ+01hmkq/4d6XN2Sj73DYuMvNNhi3me8Bf3LSHa7NG/yLfk1vmHHqJVpk9n3crSXsXb04nHTzcB5oSliplpdNUEfFqGuEFz54UHc5Yi6wT/69Or/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RCWS5O0e; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d1d45ba34so1775589a12.3
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jun 2024 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718952876; x=1719557676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eTkDcANmcuZleL0PmBZXzJ8dQlOYVbwGmUQGEpaTcvk=;
        b=RCWS5O0ezI1KNsgTd5y1omuWUWtxYAJrtcbcbYkde2UYouQQCaT2KbQO/Hbg/x9Yvn
         iqxhM4CH+BC/QrTCMa5ktJhttri4+C8U6TTIHwOdra+7a2rOIFwOuV7JVTgkbKdJ7s4T
         fx6DQ0WBdRSSxLGvhQCMVMhHTU6e7F3vpu7G3FSsXtZLIHkV1qEG4yPhFH5Y1+8unZIe
         bN1JSgAjwq+U+vZ/MmAXHPLKtV70HtW4PIE15KlKW9dfYk6kecPSpa1t6e1sKDESkA7Q
         hizfet0TBBxqjyK46CLPz1Lpxu+iY0LNrhmNdW+h5FS8uK4vnJ5hrobhX9+ZgrrLSxFq
         LElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718952876; x=1719557676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTkDcANmcuZleL0PmBZXzJ8dQlOYVbwGmUQGEpaTcvk=;
        b=szts03BkE5/2lecP87o4pXRLjLqrhZrIrNO/qbHKe6SnXsriWDluCe4jvpOlF7x4B6
         JgT22gXiPOVw4po6kFPU7xx7ap681G+5A10eTm5ASMIkKBHyahwOaJuBQ9aFoLniB+vW
         fM0RpjkyGt0tgeJaGMYMP9WpOVbpHWomVZCqP2z6H7oKW5ypO7tyIFWj6LxrOzWalp0/
         EQWpru66RnQeQnJqM56ySkIXszYH2XByickvSMkq2rD6y2/ef2jeffMqc8ie8qLwGL5W
         NaR3ruZ8GyaTPJ6GRsaSVupdWGAgqzvCqjmRJw3xikQLR0MQ8yYvRQNWBoWeuGQS9Yif
         3OvA==
X-Gm-Message-State: AOJu0YzlDJelkb8TBuwnmZOwn7bCt9sy//F8IOIjcVDwLIMxs5oNu+Qg
	ANcZxej16wGnoi//yjQjtbOZMGQ3eCBahgEpPgwfnB0gb3CsvLop5Xzw6j2fmqY=
X-Google-Smtp-Source: AGHT+IGLODE/V4p7R0sIIFSMmoxTGUJxgRGk7dfcAmBtIMl5OqgZ3hMha7NpDNa9+6zqYk6YZBDHJA==
X-Received: by 2002:a50:9e67:0:b0:57d:57c:ce99 with SMTP id 4fb4d7f45d1cf-57d07e68e29mr3936219a12.2.1718952876161;
        Thu, 20 Jun 2024 23:54:36 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d305351dbsm505883a12.77.2024.06.20.23.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:54:35 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: stm32: Fix error message to not describe the previous error path
Date: Fri, 21 Jun 2024 08:54:17 +0200
Message-ID: <20240621065418.2760898-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=MXCWIEHjZagT0uCOJ+g+R76lwVk/kK6hKx6erlJbECU=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrRS5VkZv/vvcYVeZVioJNofXpqyzyvx0aLf/HEbjYSFk 4oFcyd1MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRwmvsf8U/hJ0+0+pcp5Uy JyauT9m0xWb3D1+LVr7k3g3df/OzTvMZ3u70vb05oqni++uKclH3Ni32GrEdT2M1lJ5cfHCoQ+H SCu9LcZlNR+XmN9x2PL55l6rP+u+61hcexK9L0vSVmbDl97Pf8xY09b42nX58aqobY6qX0EXWnx uqarZsmLfBqrZP9vhmGcGTj9W2vchstLyy7uFPv+3sncVuCwT73gdPKW7hzzRi+y6769j/qXyWm iz9fzX75vX0zjyl+14+v+PpneVLOvY0vLvLyvYwrUfPQLxwlxKf7wFpjgnuLQ5R2y6n3uAM5ba3 ldQt54lO6V/XmyDQ5bOu8lDxg90sX59O2pl+I8jfeEEiAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

"Failed to lock the clock" is an appropriate error message for
clk_rate_exclusive_get() failing, but not for the clock running too
fast for the driver's calculations.

Adapt the error message accordingly.

Fixes: d44d635635a7 ("pwm: stm32: Fix for settings using period > UINT32_MAX")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I just found this issue while preparing a PR including the two pwm-stm32
fixes available at
https://lore.kernel.org/all/cover.1718788826.git.u.kleine-koenig@baylibre.com/ .

This patch being trivial and useful I'll send it along with the other
two. So when you notice this patch it's probably already to late to send
a review :-)

d44d635635a7 was only included in v6.10-rc1, so no stable tag necessary.

Best regards
Uwe

 drivers/pwm/pwm-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index a2f231d13a9f..cd7245183360 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -673,7 +673,8 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	 * .apply() won't overflow.
 	 */
 	if (clk_get_rate(priv->clk) > 1000000000)
-		return dev_err_probe(dev, -EINVAL, "Failed to lock clock\n");
+		return dev_err_probe(dev, -EINVAL, "Clock freq too high (%lu)\n",
+				     clk_get_rate(priv->clk));
 
 	chip->ops = &stm32pwm_ops;
 

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.43.0


