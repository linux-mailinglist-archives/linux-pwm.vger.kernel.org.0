Return-Path: <linux-pwm+bounces-5594-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C401A946F2
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 09:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BFD9189723F
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 07:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343DC1D7999;
	Sun, 20 Apr 2025 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ds6SLhtd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E411D63D8
	for <linux-pwm@vger.kernel.org>; Sun, 20 Apr 2025 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132757; cv=none; b=dqsU7ndd+uf05PUkrYXLH4xUFdBGgN64APBrXlF/7B0Ir6RHF6aryAVepWTTPnwa7V3cO5tQUGZx5gaOeesTe5JCnbylFQcUWE2BjumFBFjo/yAg0feSwLKGbK7S7PoJLIzjS+Geq6lIbhgbvgL+ACxJv3Meqhea7WYd7Xf8sCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132757; c=relaxed/simple;
	bh=naU+Nm6I+OWCRU692DlZpNGwp9uIvhKLLXB6jext1Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYBGKeOVyY/V8D+azyL3ItHJB7y/R/B/h31in18VZdd4cXaWTfXonq5ZzCDCa1cMGHzUS4pinqyx34lkU3hj8lXZN26RbSJ/4/jyz65yqGt/QsCHlYfZKUMO8K8yWMBcSETKVgpCbt3XmUlcoWou4KsyQV2KxGBNR1+bP7hUhmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ds6SLhtd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-739525d4e12so2536244b3a.3
        for <linux-pwm@vger.kernel.org>; Sun, 20 Apr 2025 00:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745132755; x=1745737555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82p2hGF43l3nHL3xd1lQgBU5B0CP4KmhX25rKqULFWk=;
        b=ds6SLhtdBs+dZkHyP321JSs2pMtIxje9edOKxL9iI9qIzVqUAoKUgNHT2MmxQ0CgDr
         VxvmJv8pmofcIUwEm0TlBIztezhIYlJVtFyQHBywgirmClymDz1W+CWhXgNdluj+T2eT
         P5p+e5yjQuO0kWKxAetx7Yy8IGOJyHR+CdItp7HL0UdJilRLrBfGL1LXUCy9tuQFWR32
         2ajZ24KKkcPqeklJ0o0lhG8WrJ3/EnAqkdppowt15K81O6hOeo4TDILAjJc18hywZa7j
         gyjbV0NSNpb9F28qadAvk4wzMvX61izXVuJvblroSwUIXDYcTNCaqnIKmMS5HgdVnWE1
         +2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745132755; x=1745737555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82p2hGF43l3nHL3xd1lQgBU5B0CP4KmhX25rKqULFWk=;
        b=TT9vXEho+EYna0sM6R1+TUZau+UEvWHAvxRbDQZQLLz73pD/9WnN4u1ZPt8nFxFbTu
         tR1m37i6wq1blRsV7QH94zYSUH4Gqm9IBvWUvv0o1ATTn+GS7vG+/s/mAbeyzWNuvvja
         kfEI+TjHGZpHfnQADzHNchjB3DDKdjDBQRgK9E4N60sHx5EpDUob3f553Uf3lOff+Y7I
         th/Gad/chFBY4yPVakIZ5XDQ8+MEGt/9t4c0Dqhrho86vze4FDqDT5oE6CUbglD1K/gQ
         InA6SKJ5qn6Fk5E6+Z1pAgLCe6TJHE9lBkb76WwDSY0W11Ue8/aV6V8IjriinVYiC+hh
         hMJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC/Z8+l3nOwlwlsEA6eMiWAM0+uuHYuqt+iL0iRFTlSs3oWE+Yz6eps3CObAJ9jcK0ASDof2TsUiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOUzfnyi3J7p4Vir6najx5Rm+whOsJ+F3gmlJeaZh4Dop9uHja
	M2ZUgG8/5KF9XvOUnzv0fky1TbSBd5jYzGABiFt/vSu3WLhY7Yj6HlicBX1Y358=
X-Gm-Gg: ASbGncsH2aEqlIAHKwU64Hz49/fi382SvQJSCrK/H30RuORo7+BQAmtH6JjnYsx4eCg
	J20bxwaziQSkwnie2qgDrqPzkgEbDYOchiTXwjoDaewj9x24SAhUb25GIszze7vIzTT0zqIhkRc
	1avhzJFFQpCa/aoEGGyeTCOL/6me539GStflrC/hVoyG7jCJ409SryYGUA+4uGnueO7x5Mz4y6K
	GRXThdVTawLs1967vT7D8DwhlDXHaYFlGsCeNyyQtYSz4V/smK3whE1kQof2p1Cm2KYV1KPiWoN
	rRv81wJH4EwDup1dam/+Bang0UNz8Q==
X-Google-Smtp-Source: AGHT+IGlKkNRMGUbwKmTBceKff072Fm/DzOacdnjFvDMw7BvjtUfzlAQ7rY/VZVOV3UNRwKeqrDsWw==
X-Received: by 2002:a05:6a20:6f92:b0:1f3:4427:74ae with SMTP id adf61e73a8af0-203cbc75495mr11575555637.25.1745132754866;
        Sun, 20 Apr 2025 00:05:54 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::40b3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db12743afsm3742626a12.16.2025.04.20.00.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 00:05:54 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	heylenay@4d2.org,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr
Cc: elder@riscstar.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	guodong@riscstar.com
Subject: [PATCH v2 5/6] pwm: Kconfig: add depends on ARCH_SPACEMIT to PWM_PXA
Date: Sun, 20 Apr 2025 15:02:50 +0800
Message-ID: <20250420070251.378950-6-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420070251.378950-1-guodong@riscstar.com>
References: <20250420070251.378950-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC uses PWM_PXA driver.

Update the Kconfig file for the PWM_PXA driver to allow
the SpacemiT K1 SoC to use it.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: No change

 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4731d5b90d7e..6731669e724e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -493,7 +493,7 @@ config PWM_PCA9685
 
 config PWM_PXA
 	tristate "PXA PWM support"
-	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
+	depends on ARCH_PXA || ARCH_MMP || ARCH_SPACEMIT || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for PXA.
-- 
2.43.0


