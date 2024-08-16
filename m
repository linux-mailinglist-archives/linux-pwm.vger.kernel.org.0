Return-Path: <linux-pwm+bounces-3027-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F15955004
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2024 19:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013591F23CFA
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2024 17:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28D175B1;
	Fri, 16 Aug 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="srUeYDKj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493822F43
	for <linux-pwm@vger.kernel.org>; Fri, 16 Aug 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829475; cv=none; b=o2MTwAX1x4AwdS/5oFVsOEPUxZaNbxx8rPQG2+qV39+ozOnc4kde7kaZK9CPeOTEyBW8jx7m4CA6EN0mpW2GowtNzlaafsYk6sNxBhNVeKZ8kLmUwf3KsfrTq92FGVs2ovAkMtn49iHBvNno7Y/mfAUtjm0eW6jXEa9wPv7yDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829475; c=relaxed/simple;
	bh=C4ChMrlmR4SCYUoSS51oOWEYKzN8OTpaOktFdHWEj/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hc7JMjfyPLHu8YqFsn34d+La6GmfuAce/qNRjV+g3hr36UuBzX7BWJOwwzZ338VUg/mGklPDp5hEN9d5YkcmNmMKJagz3wJy2lGQ7+dHSH70GyYBMUzbiktnj3y8/iTDRfwpP/pAWGn4OTprzCUUbxv1QL0ETKOPl2rbkCkZdsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=srUeYDKj; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5c324267aso1327727eaf.0
        for <linux-pwm@vger.kernel.org>; Fri, 16 Aug 2024 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723829472; x=1724434272; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c0btoFnPYk+qNzMwKHS5SY2OrE4TJjZMmUV+2C7SJP0=;
        b=srUeYDKj0rxVad704Nr/MKGdPTRFjCGw1u0ePsMbotLVBxKzqKgFxHEsvXFpisw3gb
         hDxXFdKOK2enlZ4oX4jhGxb0FZWaCBQTrWZBo3Z2zHQwirvk5edSkgVQuQKhyMUDoU+K
         3zSkhhZzFDrv1FoqvXNIiJz2/ew/g2z7s107p6S1i3yyw2aFbofjiHcwryTszXagaZdX
         dwWbSJ6daMNEEpMGBCwDptat6ZTdV2MFxpz39vVNBw/HienWcJWPy6mrbSOFmwTmvXpL
         vNFEa1Sj0HMnqJ39/sexTxFMeJvN4Yj5i1NWXogqKrQDDcGZJUzmT08TLrdJySGGl/Sl
         UcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723829472; x=1724434272;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0btoFnPYk+qNzMwKHS5SY2OrE4TJjZMmUV+2C7SJP0=;
        b=YnikLVmZDa1jVpj9reuaVzOUe1GCP1fW+jVBJqaq9kQhkqekv48+gpuyNEzIob1JW8
         wsAbngXrbva/EWe79gKhNmzl76AQm6MqKSF356l1IiMBiD2VXsec8ns755LH89xdRpz7
         V8TGp/OqdFiR+EVT6SPn7jGrLZ77WgknmpdmEbJ+wN68yQ+ijtDyCmIA3oAeujyZyp3J
         vdPpJ6iIF6EzH0EJ+KvHWeHOs9VwZghjgdUzzgMR9cTJsXoYfPLRSfXXV0a/YC+3/cv3
         c66G/2F1wXCgMhx3+ZdgaAM6hxY69GxWVZ86IjWXUO2P/PMv+/Dqi7aez1JdE3lvFLWN
         MggA==
X-Forwarded-Encrypted: i=1; AJvYcCUFm/1f/yLW8RBmq4Ip0Q+gbV3jNltrkNy/KYvPeKSAbRpNmUOnZkb+gexXvlfvsyvdeGWdHohCNXtQmoopg9Wy300LaeKVl8G+
X-Gm-Message-State: AOJu0Yxeu29rkieezUKOcfGNuaVnDMUI8cVkYM6zv1eOrmBSwSJSnJpo
	nF0E2UOVrapvQz1c7plRppQiS/7SrGFoTwMHrB3oz4ymaFCwESwTKqjThYzMS+zpkJVxrL9ssvE
	D
X-Google-Smtp-Source: AGHT+IHFUwh5sGqr/mezM8yIRxrOYMu7KqUUpC+VZEPvcRIv81ksTjrelEo8+qGrvG3cx3YCh4pYKQ==
X-Received: by 2002:a05:6820:514:b0:5d6:ae6:a852 with SMTP id 006d021491bc7-5da98052f1cmr4644034eaf.6.1723829472327;
        Fri, 16 Aug 2024 10:31:12 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5da8cd699dfsm759453eaf.5.2024.08.16.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:31:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 16 Aug 2024 12:30:58 -0500
Subject: [PATCH] pwm: axi-pwmgen: use shared macro for version reg
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-pwm-axi-pwmgen-use-shared-macro-v1-1-994153ebc3a7@baylibre.com>
X-B4-Tracking: v=1; b=H4sIANGMv2YC/x2NywqDMBAAf0X23IUkBh/9leIhmI3uwSi7tBXEf
 zd6GuYyc4CSMCm8qwOEfqy85iL2VcE4hzwRciwOzjhvOtvg9l8w7HxzooxfJdQ5CEVcwigr9nV
 vWp+8jS5BqWxCiffn8BnO8wLbn6HMcQAAAA==
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.0

The linux/fpga/adi-axi-common.h header already defines a macro for the
version register offset. Use this macro in the axi-pwmgen driver instead
of defining it again.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 3ad60edf20a5..b5477659ba18 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -29,7 +29,6 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#define AXI_PWMGEN_REG_CORE_VERSION	0x00
 #define AXI_PWMGEN_REG_ID		0x04
 #define AXI_PWMGEN_REG_SCRATCHPAD	0x08
 #define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
@@ -145,7 +144,7 @@ static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
 			"failed to read expected value from register: got %08x, expected %08x\n",
 			val, AXI_PWMGEN_REG_CORE_MAGIC_VAL);
 
-	ret = regmap_read(regmap, AXI_PWMGEN_REG_CORE_VERSION, &val);
+	ret = regmap_read(regmap, ADI_AXI_REG_VERSION, &val);
 	if (ret)
 		return ret;
 

---
base-commit: 861a4272660ac0ff51aa4e2dbfbc3276c06b35eb
change-id: 20240816-pwm-axi-pwmgen-use-shared-macro-939074f41d2f

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


