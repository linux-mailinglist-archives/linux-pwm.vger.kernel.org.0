Return-Path: <linux-pwm+bounces-6903-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04856B14C48
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 12:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7D7545C54
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D156288C35;
	Tue, 29 Jul 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yNwA2w5u"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2AC2882A5
	for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785396; cv=none; b=kQ6kwMM7ExgfX2J2K6SB1aa3wVqdkufYtSUnbgmIlGmDP3YiMVQG9I29sJr4eVW26FqF+TSSZ+H83SGc0ckroHpJDvnbxVfnwSk0+LiNagyhSwWzS1FWxVJEC8+COuEZoUNrzPlf1WhY/9sZ5ovaH41/Pt/BORoS/YRc6DsUXRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785396; c=relaxed/simple;
	bh=JkOOl1qHh8wPHce4AVCasFuw0+R40eyw5LBg2HuecrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G5QqHVPaFVqHEsfN1wKunETirHhPS4opTfaGyGdaDPW0lqC8a4PYy9bHK2tFlm0keQO2WtAk3Q5b4QVpj7K1ljNQwnNDL/LQEmMv/H5bKu7ydedOQafF0o60tzeyPaL9NCCCHRRJj3JOCMaFX5GEXbRoz/nru1wNuhyBMyZdwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yNwA2w5u; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so690601f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753785391; x=1754390191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5SlpVvwQN3dO1/Sw/WT9GrsHCvzTZlBS1ya2qhGGj2M=;
        b=yNwA2w5uXyUqKA2rOlr/a49zxtJfBlSW9Z3V0y2tHZMRGdtlly46dK4LpY9N1qCif4
         yuIvq9pOCtVvtctqu7+yPcGVkTg5myFfPPZFXjyzr4YrztTjxXAzh0OwBUZ1JXbj4GU6
         auBCl1K4ddJku2zTdKKoVqMMMr2+wzLm0h0LlAIvuprzAfB40SByo5UE051YQPkVl/qq
         E98CLf4ccNa36xT8SNecqA/XVArjgB7XCN0OG9uPYdG9VhwraZEEUWl2vqcyiz539X4w
         MV2Gc5f1fRCefhQ388GXrnTiUW+5YI9U+SlHrgCKvfVVDY4LP9uBeo/SB9xnCLcFt/GP
         yu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785391; x=1754390191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SlpVvwQN3dO1/Sw/WT9GrsHCvzTZlBS1ya2qhGGj2M=;
        b=oMFl6ZSIAoQ5GCvhEVjTqhFARRCfdbXddZH5gs0qpF1x5yw1hRdci0Q4tg1S1iB0HX
         TskSqti5gwtIXkUyiADPBMdRFtmdLu0s/c+cbbPWBj/ksGDOwcVI3SC0U+RXfPYmUO3M
         YOSVr8jtlk12Qh4enHRcMvbFfG1+O/fpeakJ2tQhlILmruBz0I7ZdGlEqWR1wTVvnusg
         s708jUuxNmaGA3kHOrAeJvwEnTvWGxhBKX09rk94QHaN6JlG098Y3hOrln1yZb76AxHr
         fnFdTxtRU92LEO9Lj8vSlVOc7pkp+jky3ScBsV53Yo16EDcNIW9SGFCJFjPXYGuKIU4x
         2tEw==
X-Gm-Message-State: AOJu0Yw9Uwil7sD6DZ3NASKQEraff7c5l63BUjGeyHWAX07Et2DchL+K
	RrPJaEoOzkCG21OhXeBDj1fW6TCHCtoMQ1IJx3P3dzjk7QQMVkka9ycyzKGzwF2CXnuqy+gWkMw
	ZgSiU
X-Gm-Gg: ASbGncuH4FOSxGsv9r2oYEsyVW3FuOlWdX7CHsPpDliiFG20qRJaxkN8OVn2EK6rDNo
	jupF7cyIqn7eGyXDtrdKn/1gWwojNe+1WCL653qWt7Wy9WqLARcLtRr4isXzbl0txjJ0ol+PMqk
	LleK6AZhLFQimTg2tNRgr2jfQ1yXrIV/MQbsm12cAZ6OUoXDTEFmfVgnQxG9FgXynEPrVKrjXKt
	5Jx9+BmB7TVqnZqDdM5UuywDPGlPNg9VCXx/DAWQaBVlbOxFHZVJzwceKH6x6ExUK6rxeOgnEWS
	Wazs8ma4B4KraPXlRf5ZC0CFS7wQmYoskEcddTTKhqXa3Mi3iyU/EYfuDHyViyNAq2712eIldeU
	Nh66veoQyg0lHzqSj12A4YL0AIAAwwKqqm/gZZqcYG7SK1UxqWK7S3Y74oNBLIZc1
X-Google-Smtp-Source: AGHT+IGzeWX+Xnx1WFxojWPmyuVy1qNE5mfB/5ypGs8kFSziF/qB8m1k3GfOBoFqnttO2zo8LLpWpg==
X-Received: by 2002:a05:6000:230c:b0:3a5:2b1d:7889 with SMTP id ffacd0b85a97d-3b77667470bmr11089986f8f.43.1753785390605;
        Tue, 29 Jul 2025 03:36:30 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458705bcb96sm198733475e9.21.2025.07.29.03.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:36:30 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Jander <david@protonic.nl>,
	Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] pwm: pca9586: Convert to waveform API
Date: Tue, 29 Jul 2025 12:35:59 +0200
Message-ID: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=JkOOl1qHh8wPHce4AVCasFuw0+R40eyw5LBg2HuecrI=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBoiKQPca6C/vrx+meTg+nZPyEslSZIGN74SFQB9 XEl5jm5XtSJATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIikDwAKCRCPgPtYfRL+ Th8pB/YyHv5/fmuidPs6QqWuBfe0NAgkVUTVTbg81DDBnaxEEXVeC1axU8ZFkw66Dua20PH+vKM V+yS+8EFFR6hSO5PQi2DY+gGo19Abp5mVsawNd7HRpKem9wP19IdLq4cv8dOgxk+ZLKsuLikM7h BxlQ+h9iBY9zCCqRnZpOG0uiwegVulH357205tLbhjYgNaG4MsGbbtb1pVSnWHoCL6VNGbeTZ0x 1MKDMjhU+vzDHGhAkpLzGIKXj57+/5lO5VtMjmUSlqtfDhSg/aUBfiTlkUN70V8aNarx0snn+7z cIGrhkdN3ce8NdWmYbtlmKLiJa3TnaXZp21dOZUzIgu3qHs=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series eventually converts the pca9685 driver to the new waveform
callbacks. It starts with a few minor fixes and cleanups before the
actual conversion.

Note that this driver was the only one that supported the usage_power
flag and when it was set increased the duty_offset. Now duty_offset is
under control of the consumer, so no functionallity is lost.

Patch #4 drops GPIO support. Though the internal details differ a bit,
this is superseded by patch
https://lore.kernel.org/linux-pwm/20250717151117.1828585-2-u.kleine-koenig@baylibre.com
which provides generic GPIO support for waveform PWM chips.

Best regards
Uwe

Uwe Kleine-König (5):
  pwm: pca9685: Don't disable hardware in .free()
  pwm: pca9685: Use bulk write to atomicially update registers
  pwm: pca9685: Make use of register caching in regmap
  pwm: pca9685: Drop GPIO support
  pwm: pca9586: Convert to waveform API

 drivers/pwm/pwm-pca9685.c | 555 ++++++++++++++++----------------------
 1 file changed, 229 insertions(+), 326 deletions(-)


base-commit: 68b9272ca7ac948b71aba482ef8244dee8032f46
prerequisite-patch-id: 917be1150626d7632f99929ac9f7dc1449864979
-- 
2.50.0


