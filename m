Return-Path: <linux-pwm+bounces-2762-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89AB92E6BB
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 13:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E10F284C66
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 11:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702B015ECCF;
	Thu, 11 Jul 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B2kumLOo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07CD156F5D
	for <linux-pwm@vger.kernel.org>; Thu, 11 Jul 2024 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697290; cv=none; b=Ir3n6HcdGlQEN9oK41ASF9o99luSv+0eo7PufKis7krZKh7YoDlJcMrxiOUgATD0vEcCOyqIziwX5pMnPlw4U4sS4DtygJTjJObRNJtr1ZSo+nMozfh+Bf/wxPE8sMGo3QA/1aY18aZRNcVq+0pppuXS4/HiOWz5U6Ex/zZlsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697290; c=relaxed/simple;
	bh=ue/D6aaMj20smtKi2jAbMVRAEMMLERO+XAiZ94XCja4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oaHV48Mzp6t61/uJWcx4EgHMXB8HyRCX4aRSNjegVPWgyJn+ueZ+jQH3WQE2ukTf4Dnzy7R+zx6w6vbBDXaOn+UA+D7XaewVzoO8ez/YjIXzNluB7CYf93wkZry4CR0H5b8LXvcuk1DhPg7oPWYXNhtS475IbgBUYh0eHePAr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B2kumLOo; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-446883be273so4815301cf.1
        for <linux-pwm@vger.kernel.org>; Thu, 11 Jul 2024 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720697286; x=1721302086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4IagqgBEWB1oo5Cqg5iaPlJgTTeYOkk6mC1e1sE7v8=;
        b=B2kumLOoBZfQagH4WlbhIsn9jGu5A1BZzCWcEW/vunpuURyNNk+6+a6b2BDitqk8Uk
         Vx6sL7JUYuphwYkssiTDthhCRzgKmB1ED69ZcE5sRfDs3Dx6TKddhStqkna/1jp66L1h
         Yz2y2xz79H9CW42YAzbgMCg9rBUsmsXQG2PwYL6kp5TolIR8j3Zd0M7qWA1gEiY8soDV
         ur4QEFIvEGYjtuRmEWFH0XPu3eElYrHIWzNRHwYGT7dikNOKdMeI8AkWdxSm/MLfZH4q
         RbXXZS0206wWcHSzjKi7xuceR8HKVJHM3VlUOk2VBxB35q2lffge5I0APCsl/DbO372U
         XOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720697286; x=1721302086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4IagqgBEWB1oo5Cqg5iaPlJgTTeYOkk6mC1e1sE7v8=;
        b=FHMbFhK5/s4RSlwfKhOO14mK60tfDEtc9FBgC1KMr4Jk4+nvTz9ieTtsI5Ep0DkJGh
         U1c+WRf93HnOlOyepb7pynGdas2h3zueyGcAVFcGscOEDquC7P4R6oCviD7RUYg57gLK
         L+sQdbXojaHEA8nz+cah+LtO6jHNRtzHu+/rmHuFKhFkJzQmw44TfBWC6alOmFotuzUF
         vEBXpgVaBFwCUq1/GiutQ75yZ+gz9yujmT2GVpcl7ipHNwlRZbDGsWSVLW/Xm2RxztIx
         QOOTFOn5b7dNKfwcM0BqPDPl5eJXs2LOTvuh0KmbO5flEKIFprtHLvo2EwLkrLwLVEdp
         jZNA==
X-Forwarded-Encrypted: i=1; AJvYcCUMTh7VwbXsfumnppFu2Td72+Z7R5y/DAR+Tu+lSZ5PNuy4qRmOXn2AJ1a/jFebLYW2X9tEa/hmI9jA1zh5Hh/9QdV7QGXdCacl
X-Gm-Message-State: AOJu0Yzpo2+QOUiPWvmkw8GvxCEyssI9e10IVNhqwRPQpQb4tcFfM7FA
	QAEulwHHwQJdpIvXOmEyHFUJelyo/fybJbQMIc7XjAGbBVaM7El4qOG2DR+SWS8=
X-Google-Smtp-Source: AGHT+IGWL63JOeSzdCwUk8BUGlsc844oQVV8aJNmtUwKqG3hECJfCelzieYR6PSvclWPksawC9mUZA==
X-Received: by 2002:ac8:5910:0:b0:447:bf9c:3ea8 with SMTP id d75a77b69052e-447faadc5dbmr90068481cf.65.1720697286688;
        Thu, 11 Jul 2024 04:28:06 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b3d293sm29021281cf.25.2024.07.11.04.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:28:06 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: axi-pwmgen: add .max_register to regmap
Date: Thu, 11 Jul 2024 07:28:01 -0400
Message-ID: <20240711112803.3942189-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was missed in the basic driver and is useful for debug, so add it.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index aac4f395497b..3ad60edf20a5 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -51,6 +51,7 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.max_register = 0xFC,
 };
 
 static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.45.2


