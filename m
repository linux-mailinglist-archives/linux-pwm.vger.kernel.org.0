Return-Path: <linux-pwm+bounces-4734-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566DCA1D4CE
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 11:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A819C3A2A51
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 10:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CEE1FDA65;
	Mon, 27 Jan 2025 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aqy3O5Sj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814561D540
	for <linux-pwm@vger.kernel.org>; Mon, 27 Jan 2025 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737975019; cv=none; b=Jeri8pdGYf/DdaPXVrLU31hbNhnVQGPds08WoMsaGd1n79ybFsNqJXOeZ/qcB1z/Np459esS77M4k/VLwyeAOT4Ywf1qInAdnnwCjauphZedXjIb+nFANmI6QAGiZ9ZYqXcb2jYem3WA75C8cDrZIWRBhwlSSCUgCu0YUbpZOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737975019; c=relaxed/simple;
	bh=91Ysoi0XSMFKk2q6OR5ur+zCw8xY07DINvs++TomGyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y1QRRFR0RCQSyTnln4ks8VMtX3m27ZPd5TmGV2V8Ew6MNDbssKW0lG1supBQZXbL1qo93r3bHIG/mSSFoKHOF6wATKAkaiRe6itC0M2ZYA1SY0CQJG16yMo86tJffa5oNdSu5/SVg4ry3r0rGu6+96ycrvkf11CwxkJ8//6rPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aqy3O5Sj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so45408915e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jan 2025 02:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737975013; x=1738579813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fuVOZHrwuABxNs35BacCC496I5JiKTElWByt9dcR7l0=;
        b=aqy3O5Sj3T5mAKqZrfeUn59Vq8jERzEGga5jJ6FpJb5yIxum5JM3NwJuJDyZuAUJAn
         oI/wQO/VXyqCCX7UEJPoTYHxmyT+Ee1eC16JBfGWhEEXZC8t0kMERJUF+MxFmGFNUBfv
         0sn8zniOYABkcjXJfY2haeXySJ275tPnx6NqG3tiQMiK7dHo5IFyo9IHz1G89tpeuaMq
         0JNADRt99gSr8WibqVRA6qMxvUqevJFFJUS2/S6NsZ4vwKU9Tp4cMGoChNF/2Mlbq2DV
         JZMeXbjNfbnMGegMlKbNnD0PVHPi1SUxYufTGFi0fEPr1SgX5VMhx5fJ/DJ7xYIUIS1I
         14/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737975013; x=1738579813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuVOZHrwuABxNs35BacCC496I5JiKTElWByt9dcR7l0=;
        b=lY5ZMpVK7bjMEMPQwsorVq5XoxjLIyXH4oVXJ2ApgvZEwpi1ErHlJ5uSfS2KueU6h7
         aREN+oTkmY9OpVHJ77SYUElnHevw7L3GPZgFR43lmac8py54EEIgmFHtSyQXQGRRKFMR
         3UUHFLm81Qc5TM2GQWpfhRZQxGgzJ46c94H26OgLrHhVH7DozgUYWP3HjxKuHL1g3OOF
         gvWI7ksd9nHGPlyFO43QHAfYhnNo2NRAd0k1BugfzpQrNGuyhbOYrClqibFLCwtO9clE
         cBeGQGOMh11shjGtCl6GkKh9Pnlj+f44fKmdqQQzagx9svNrNjqnYzZNG8lwwJLdFTNw
         LNzg==
X-Gm-Message-State: AOJu0Yy0xqBO4svu8IbHeV9uaS0qGlaanFH7/LPvnvzFYrvrTsXeHjLU
	QlM9MSD+S6HnKua/K6w5XjyyjaivAoyz1eA7r4c7memrGVUqbbEt53pw+iYFLu0=
X-Gm-Gg: ASbGncvjBoxVRa4rwB/ThHclYDw5HDGxFMBFF0Fl+hZ2Kw11ztUEYvCXMHq7AbwPfMY
	K/jkEfBbb0P2dAEVJMotCmZUwerkvK0JDReWjJL60vcY8dnIudLHI+XQLIBFJeLfrUQPM+H20xU
	qN2tPJqTpZWYuIcxdw6aAk+jZlE1R3MWCkDr1prqVU4YxbWDJD+Gn+X0mJ3ZCqOOxjQWpzc1rfd
	nWdFoibZhxy5nE93Pt14AcmynqI/2Ku14Cdkr7cbbOOm1z+C0cpEDdECvThti7Xs1oQxbm53HXB
	3EBpJzYhOw==
X-Google-Smtp-Source: AGHT+IF8zXvRud3bxzKoETBM+MMw8ZUW8atexFFnZXnmo/DFoE45mb4c3Y2gv8eCVHkD9pzzKhfOaQ==
X-Received: by 2002:a5d:64e4:0:b0:385:e35e:9da8 with SMTP id ffacd0b85a97d-38bf56635bemr38024984f8f.18.1737975013606;
        Mon, 27 Jan 2025 02:50:13 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17640csm11104610f8f.18.2025.01.27.02.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:50:13 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] pwm: Strengthen dependency for PWM_SIFIVE
Date: Mon, 27 Jan 2025 11:50:01 +0100
Message-ID: <20250127105001.587610-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=91Ysoi0XSMFKk2q6OR5ur+zCw8xY07DINvs++TomGyI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnl2TaSzHKHgQt9mbyPx216MqJ/tGg/ldJNcXOf b71p9w9WQ+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ5dk2gAKCRCPgPtYfRL+ TqfJB/9GL+EBEuPmLlcmnUYzKCnqf8cQz+4aS7SYxfMOaIme+UedPpSJx7fguUIMM0VW2rDOq3n al1kAMVFDnMYUllGsC2CeJa2w/WfH2mF/6Kd6dcr0C4sNaN61m8Nn+jrftyPArId8mJOYXdIeGm keHKok25CDntHSM2jONUNlBpoEcxtyo1bJk1QNGU/qlA2iRvs6oRfSuB08HGgkCDB4KqA2YD8be +TqBukzlpYpRYyhqplSDVPHDuG46klk+BD/KGeHaf7uiW3Gr1AFWxGPbQ6rHijmZ9Af1aKYJJrR BKRsRSPYLWcDRc7/UvlqzAcCI+nBUclPhTxb1N46Hc4nrT+m
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Back when the sifive pwm driver was added there was no symbol for sifive
SoCs yet. Today there is ARCH_SIFIVE however. Let PWM_SIFIVE depend on
that to ensure the driver is only build for platforms where there is a
chance that the hardware is available.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

a quick grep suggests that the driver is only used on machines that include
arch/riscv/boot/dts/sifive/fu540-c000.dtsi or
arch/riscv/boot/dts/sifive/fu740-c000.dtsi and for these ARCH_SIFIVE is
enabled. So I'd guess this patch is fine. Still an ack from someone who
knows this arch better would be very welcome.

Best regards
Uwe

 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..be0db73003e4 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -567,7 +567,7 @@ config PWM_SIFIVE
 	tristate "SiFive PWM support"
 	depends on OF
 	depends on COMMON_CLK && HAS_IOMEM
-	depends on RISCV || COMPILE_TEST
+	depends on ARCH_SIFIVE || COMPILE_TEST
 	help
 	  Generic PWM framework driver for SiFive SoCs.
 
-- 
2.47.1


