Return-Path: <linux-pwm+bounces-6914-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6234B15A1F
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jul 2025 10:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014CD3AEC8B
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jul 2025 08:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBF22236EB;
	Wed, 30 Jul 2025 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OQoEY3/P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31E1D54F7
	for <linux-pwm@vger.kernel.org>; Wed, 30 Jul 2025 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862553; cv=none; b=pQaRfwVTZho26dJA8amZ3huwjnFHXRdHfUSDLv4ptKtM+1bO+a/cpVSsSc6D/1TipsRT9ZVns3mLDRuRHYnvqu1zaZ5BM+z2LLeocUpZdIJQDcAvcv2KqoiVbqEqtduB4kG0nrDuormF9OLfdxIAcnNIcxl1Sf/++sm0kLC14BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862553; c=relaxed/simple;
	bh=agfyIII4mp97ONNwlinO6Lmb2Evn27byCFYiuZZKV7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rzp1H2Bofx6yGILW4qFGjZPeTiFI2JHdEUKQzvu2fewTD2qPxdK10iojuL7RnnbBfagKU0BofIMZPQEem0GGsIJVXRCILkdzqQL1zc8+cXpHWaiVkoPJ/N67/PTIvTtc49bn2xcx/eHM+idvDH88OEyDGc+j+fmMrHGNAAnNqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OQoEY3/P; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b783d851e6so3400782f8f.0
        for <linux-pwm@vger.kernel.org>; Wed, 30 Jul 2025 01:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753862548; x=1754467348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+iuNBYez4oTUNiURS3VsPhFHa4QuwFczr9t3CnaQEU=;
        b=OQoEY3/PP1E81fQ572htz7sYRo8h0YFxR/8HOokNu3NfVpqIxstOCXNaqrnGFL2hvh
         Xnwu0BpAtwCyVPi70EN1n4kSIDARAfqphoIAZ9xE9TVGb2ic1VSlhmmugKhfxRmB8fDg
         6IHUyPzhNI409PPb3p5aJ9lIeZ1Qpgwa0nZ2ohW22m4z/uc/cLHz2vYnHjniYwV06CfI
         zdSPajFtuR1HJCYl0rWX1DnDOHvm5pkardl8GnNJ/DEBmmQ2O0kRwsJEvObdNXjxRBCH
         NkXK34l3e3C9ZNxJauMeIF/AtIWH39agU5YR1xb0LXAccbKEaYgM8p9OxPh1ocrQdH3P
         ZoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753862548; x=1754467348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+iuNBYez4oTUNiURS3VsPhFHa4QuwFczr9t3CnaQEU=;
        b=JV1WqHUxvfR8B+0jh6bLYLtXPna+4yD5sffdfvE9NNXX+4S21QeJN1BWIsWf7gRJkv
         YtJOunIA7WYwLvh2I+TXPlSXX5FRYNtRMCJZgUA3dPMpcdT60+zFVrOa/pgC9/4H47tO
         OtWS77BCi7pAmVQAUy5CGfAjd8FSUePH0m2ad6E/PCRSODu1OsNARM5tgYzvSqjBR4aq
         tK5Fxa7yefKzBEJEygdlrGJeEjeNB/HjE2pylUeh21HreQrWKQCprwuEEYl0Gdzn+7wd
         bARaJMPXg7qCTHrbEjgf71K8WjpEgL4mb+NUjxqgX6U+lNhyptmTpVJ+OCRD8wo1QXQu
         OJ9g==
X-Gm-Message-State: AOJu0YwFH+c+ujEOEYQg/LTG0JePzCeobuPrW0kjOFwx2+4V6WCU0Etn
	1Yurbct1DGghB8CWwMOpNcIvy+Xal+1GYNPeNHbZsQggdZAEhKhgQBNxPbt4RJ7BI4mm2pY6MDd
	drKg2
X-Gm-Gg: ASbGncsVenwRJreGAdjzxrDHwx4O1m75nOZZN158v0WZ1NboL88RG0fqhR9qOTfi+Eg
	K9pA33ue6VosdSh3+dKO2uBIwB3TWvtBR/1mpmMdnfSsC6WAqCb92DJe+yAdpwac09CY0r4uFjh
	ilyN0BPclnjMngiG6RJNeS7H/STIN1fnmxpwPXOpxO6IoKBCKYhlcLZ8zLMBT7aeieB/YJw9CzR
	9aftJ86QnaJFMR4k+QvjejOioFr3k1licqzCtM3dcW7P1i7Lp6QvA9Nk9s22mtdCQTHjghc76+u
	9jX1ukT/Fc+NFWxr/GymPI3nkCL3grrgGsuLokOcIwufUEZWbTHvspJ3timHipnH7wjyRweJxmI
	FBFiYsZUO8LvNFyk9sznYnqnXs+yuZL4aECOeiEJkYPfyOBbstsLc6NvLFn3MelG3
X-Google-Smtp-Source: AGHT+IFC7q72MpVtFG8Aanjwe/vGxnqFgVTnH+lzwRsgXhxpSe2HsSTZCv1ofOSgZ9HtFx/ajFZ62A==
X-Received: by 2002:a05:6000:2004:b0:3b7:89a2:bb8c with SMTP id ffacd0b85a97d-3b794fd73b1mr1936111f8f.16.1753862548520;
        Wed, 30 Jul 2025 01:02:28 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778f034a6sm15060922f8f.47.2025.07.30.01.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:02:28 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <david@lechnology.com>
Subject: [PATCH] pwm: tiecap: Document behaviour of hardware disable
Date: Wed, 30 Jul 2025 10:02:20 +0200
Message-ID: <20250730080219.183181-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=agfyIII4mp97ONNwlinO6Lmb2Evn27byCFYiuZZKV7A=; b=owGbwMvMwMXY3/A7olbonx/jabUkhozOi9235UpzvB5bMKrJWm29dK67Z8KC254x2+4bsquvy 1zK1jK5k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJpCzlYNheElv/9OqO18uT DB7UWii2Ghh/kf1W0x3RxaJlYfxIb/LCZv9T0ikvmdYaOSYr+v+r/isl/FE/4++8sM/MHX1ngha 1CQi5GSu/kVmx6BtT8DG3NUIvV+x+miCx7H2GsLykeNPFmVqbuCNyhXutjI6e+mXjffbpwl4Vu7 X8qZqV9w2uGXwW37NsUdQS+dhZH08knVzpM2NpR4m/dOfnh0nOLXtvvO2/ttbCt6hsQesurRlSO 2rk9zOk7W9/6979cP2aqxXHt35/XqPluSDa+99NbyF3T/1KfQ/ZZqn/GfJfvASzlps7dTWqp5rJ b5JQexJ4ZULGOtcVrlrPt7G2/PtxP5bjY+SdJx2P2WrqAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

According to David Lechner[1] disabling a tiecap PWM makes the PWM pin
an input. The reported problem is fixed in commit deaeeda2051f
("backlight: pwm_bl: Don't rely on a disabled PWM emiting inactive
state"). Document the behaviour in the driver for future reference.

[1] https://lore.kernel.org/linux-pwm/39a472c0-ba24-de7b-8783-a16a71b172cd@lechnology.com

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

found David's old mail while archiving stuff from my inbox ... :-)

Best regards
Uwe

 drivers/pwm/pwm-tiecap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index d91b2bdc88fc..67cc5e8bdb0e 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -3,6 +3,10 @@
  * ECAP PWM driver
  *
  * Copyright (C) 2012 Texas Instruments, Inc. - https://www.ti.com/
+ *
+ * Hardware properties:
+ * - On disable the PWM pin becomes an input, so the behaviour depends on
+ *   external wiring.
  */
 
 #include <linux/module.h>

base-commit: 54efec8782214652b331c50646013f8526570e8d
-- 
2.50.0

