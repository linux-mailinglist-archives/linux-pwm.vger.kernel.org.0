Return-Path: <linux-pwm+bounces-4281-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E789E7B2B
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 22:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D052169914
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 21:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A52195FCE;
	Fri,  6 Dec 2024 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ99r94O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE722C6C3;
	Fri,  6 Dec 2024 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733521805; cv=none; b=RqxoBJe9t8NfdJHu2vLOX/1DA2zxhV78jbhtXkz9ZrJo+XwkIHq2mpZ51IMWesbeQbspib1HsvfU4T7WVUQcJ4gF2rKlDgna5MBfIPqMf8xdPa5TfujNGUIHLeFvxvOXqT5dU8GMDNlay067trY8Pnl5dAmBku0N4BpBMy13xNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733521805; c=relaxed/simple;
	bh=f6z/Sl1nAkpxIQ0iQJAn3H9zinLys7sOQ9Nk8Q/ysts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LuQoBGTRiZQH6g0fR129+Y8Rec1XEoTDQz8gQ6kyIjaXbPA48xLGSY2FlH7XVJKpIVcTufBOujytm7f/1Subgi1ZsF0HPRE/DFfAs6FO7JKNGdbUPB5yuMVXBN7L6iGopmEE9kKz/FFDSJTf4scQPH7ydMOlCj1mtvARQBa50lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZ99r94O; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e39841c8fd6so2748108276.3;
        Fri, 06 Dec 2024 13:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733521803; x=1734126603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E1ATQ+hwSVg06F/3XJmwp6Pc51et8mTf/y94acpTuzc=;
        b=gZ99r94OI6YN8+Uvxc1jZDEW9no0eYWbFf3jC+hET+XG+F8eTp4FL0RM3gn7OXJ2zd
         q99+3eoNjvCpzyMj0z+EKVBWtYjY4FCffl0wW2uPWdb5gTUl//mj2uV7ubbzMlrB+qZF
         4vBfIFTh1rv+E+tnOVzDSEb7jRCBD6QfxU4cXBaq8REYaHRckubyIyAs/FQRAH+TSZmi
         9g1FKvu349NS4ao7DpypAtxEecbsPtKqgK1WJeqMkno3PVcZJAkNdRB7uxvzFso5s/ay
         bmEYkSYVV6WDLYgNGaacJpVXY9520OF864NQVFJLg3ZDabJ5CsOMOGTlZt1c8z2iGtiY
         c/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733521803; x=1734126603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1ATQ+hwSVg06F/3XJmwp6Pc51et8mTf/y94acpTuzc=;
        b=cFj999SVt/DoB+c0+6AuKICjLFc1L2zXjHE6rYSLb9pUD+xzcUuQzWLaALtpZeaRTN
         1v7bv511soAqEzp1MBUshiat04blni8kJbgqdUsMcNVxN0XFHp34MkCAV/w6QlZbY/PI
         0Oao7M9UkCPfV3SLTijk79RC5hA4o9Gx82VWJ7U0HDIak+fMhN3t/67XYyBFIdrliGuk
         0FWW0r5wjT7Q6LOMh/giTjlVp7KFdrgux5KoSviCBHqUlUALPM9tKp5QI2bnRm6rmrjl
         aohWLsxDMZbhOAoC47PfN7rhemOsPLNTj0fZU8IuenD+/IWIIrZbHdtckCNx1QfMtGQY
         K5eA==
X-Forwarded-Encrypted: i=1; AJvYcCWYlTh7RIwRixnnRUETnB9+8i8waL0gv51Kx++ZpM3gsmfET/tSlGD3eoO4jqtv+Y1ymJPfBKrI852V@vger.kernel.org, AJvYcCX2DXXSJTxcELQL+DdKkPV0L/SkiXow2aRF2TUBXcvjFZLL3Aj+qTXZSzsHEC2nkt7Y9XerdJunfpySa08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuGYtYJydcPukMXtGupIELLa9xsm6t8Ey2FdfBYZkkPJAPxHal
	/9qMlu4wI68mBI7hnhhaJwWE+KisWoxh88yYOYRaDMQy64d1y7TB
X-Gm-Gg: ASbGncuwRwAbwem5jjnVZSe0Ojzntio/8be4oqlu/zrGrnNY9wSKK+tBulJeeKEAFdW
	/izQhbu//hcl5e6Fd+CwZ1ZYDVMnKgsxFMIfQggua/aagrmJ74mig1tzxPPWg61cVE/lVto4UBz
	uuxXi2NIRsSw6QaPngQF/wHEQkPTneACXFfNV03ztmODJUTuR95wwI0aI3FjaSJJWnBez4P2UO/
	tDjSmL9mbFVD6zITgvDKEVYP+tElscX+5oPhDkLwVS5kZyxeO2POnqpvwb5BA==
X-Google-Smtp-Source: AGHT+IHkD9Ci5WOwSKQRn4HpRXLx7B5Rbt64C1MzXq6No2+Ek1WnLIKvhB0xUCl9WeQHCE1aUg0ICQ==
X-Received: by 2002:a05:6902:2b88:b0:e39:a3d9:48eb with SMTP id 3f1490d57ef6-e3a0b133286mr5243945276.26.1733521802732;
        Fri, 06 Dec 2024 13:50:02 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296f2d0bsm25474161cf.39.2024.12.06.13.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:50:01 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: ukleinek@kernel.org
Cc: fabrice.gasnier@foss.st.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	hierry.reding@gmail.com,
	lee@kernel.org,
	linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH v3] pwm: stm32-lp: Add check for clk_enable()
Date: Fri,  6 Dec 2024 16:53:18 -0500
Message-Id: <20241206215318.3402860-1-zmw12306@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() to catch the potential
error.
We used APP-Miner to find it.

Fixes: e70a540b4e02 ("pwm: Add STM32 LPTimer PWM driver")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v2 -> v3:

1. Add tool name in the commit log.

v1 -> v2:

1. Move int ret declaration into if block.
---
 drivers/pwm/pwm-stm32-lp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 989731256f50..f09d097d6284 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -167,8 +167,12 @@ static int stm32_pwm_lp_get_state(struct pwm_chip *chip,
 	regmap_read(priv->regmap, STM32_LPTIM_CR, &val);
 	state->enabled = !!FIELD_GET(STM32_LPTIM_ENABLE, val);
 	/* Keep PWM counter clock refcount in sync with PWM initial state */
-	if (state->enabled)
-		clk_enable(priv->clk);
+	if (state->enabled) {
+		int ret = clk_enable(priv->clk);
+
+		if (ret)
+			return ret;
+	}
 
 	regmap_read(priv->regmap, STM32_LPTIM_CFGR, &val);
 	presc = FIELD_GET(STM32_LPTIM_PRESC, val);
-- 
2.34.1


