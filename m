Return-Path: <linux-pwm+bounces-4266-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507939E635A
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 02:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0005D1884F05
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 01:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C8813AD2A;
	Fri,  6 Dec 2024 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDz3k436"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9A2F855;
	Fri,  6 Dec 2024 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733448191; cv=none; b=II8irkc8ktWcG06V8mslyuAWtuOS+mZ3eP7wrv8uGSk/FzHZZtwxIcw4GFWxJV3wWaS9hJ7u0UiHvZFF8hweJaXACweHdeMru56KKXai6oHhslFIxyOeBGnMlmXOpWcnqfgu2i/DS/DtTvs5vd0RYpWehklgqXIiObFwLBr7Mtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733448191; c=relaxed/simple;
	bh=OMrqL8n0yQjbg4LZ0kdKK0CVuLWxfh72+sH1AFu3zyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eB1JYd9omAixXVc5r94JhaQsVOHh0hJHT8YmaPpLRRclHV+hhGH62vHAbC2WsCRbJd8TApr0LRlYfcETnhfDGv5ZPL45tQlzgaG921bbYPTxQz1R+ejCcv2ELbDCWBsvKzEdmhCcIRBoAW6ftz7VOm+CaT/w2brcfieFkEys/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDz3k436; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4668983b04eso11045291cf.1;
        Thu, 05 Dec 2024 17:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733448188; x=1734052988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jvGV4uV7dd9ya0e1OrNzeXExW0G1jrTQiEOMfyJbCNQ=;
        b=RDz3k436FwcqarFgIsEqXxEHbrvY25/pH2YbGOPvrkoZAS+qUg+rJ11bXZNESkAxCJ
         Bgi3GQoJ+Hek3rkEznSjYRPj4Z7I0mDxK+h/WojfnQbnPNsbjK2WPvq8RkeoIlEuXTZv
         Z1gZiZtR7AXV40QlXMrJXfl6uQRx8YK98YtPKW0X9aYJ2Bxvz/52hLQoEU+8TW+zV2mc
         +qpaygBXEkuoMcgSFvaQd5e7LQvuajSOhPb0jbCaScQSfHFlm/d4dF3PkcG3lpA/JflM
         PrTZse5Ry1QOHqg5ghrmzQk1toL6zErzi8PicwXYYJr8WB3CZSx0TOfk73Av0TelpMkK
         Gipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733448188; x=1734052988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvGV4uV7dd9ya0e1OrNzeXExW0G1jrTQiEOMfyJbCNQ=;
        b=b8kLw0LB1bmNbv9gbRX1VUjIWM5tEEKHif3o0raoxT7uwmC2DaJiA4ZKJGAGX5HBaH
         EeD852lyFx7yXSwZpHHb4waqwX50nBNVRSlBQT9Z46Q2ujlOaB2pja7Sw2fCuO4Ysx9z
         kXdyK2xKLfjlI1kD/xALzVXNvuHuugPhRxhWYb5ljQ02mLCkvQ+Mwn9KL74CFbVbK9sh
         wLqD19XZ1GMNZqjmIWWpkAFvvIMMXQG13arb77YY3TpO7gzK/3vHZGQwbPKHs/NDgeJD
         GSnArkBwBxJYGoqUslkcf3CuS5Wv5YMF3tN+PNeB/U/5bZAxNgwLGsg7jyDJ2E6rcNhM
         1r+g==
X-Forwarded-Encrypted: i=1; AJvYcCX40zSsZWyQKNUiUJH+d9H9RyizjTHOf7+9WYu4FAESTyrXIfp2MeJ6MqLj7tcFAByczkTHVKEbwLoqiPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIl3ZjyaaqqNtYFEhDyjFgfDY33v5az4uyv8g1+iomkQLSZsbu
	WJktnPa8D8Vw6dZedRKa3h1rbLwYQMuLtho2eKQMeB27OfWKz6Y2
X-Gm-Gg: ASbGncsV7DS5j7S0kAEhYL8uyLdt5eoQPB2WD+7c6SRPRT9Kcs3FjV07ziB0JdIUpPQ
	QzcuSSEP7IJlHkcjxMLG11z094TbGaRlvRceXkyz69DK46D8TPVwnQxtaUKyvp1eiItSe3dV1vo
	spPNyAbQk93xUlXdt4BxEvvk61nrVzPcMHGtgikbqE7Oav4ODHEnQsmfbuMnYFgXCMMadgAHsBW
	KweydXWXsqbmYet9oTAIwwQT5G72oBxRdV8g/QVqsuG1SPQSywzIzTkO4kWSw==
X-Google-Smtp-Source: AGHT+IHK+wEHEpKWNH9K1+ZII620j8IfRKrpZnPMtL3z9CL/V1j63cap8ccn1cWykpj5ec/jt9vrgQ==
X-Received: by 2002:ac8:5d12:0:b0:461:1fc4:1016 with SMTP id d75a77b69052e-46734cbf6b3mr19416161cf.7.1733448188457;
        Thu, 05 Dec 2024 17:23:08 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296d4d42sm14619631cf.32.2024.12.05.17.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:23:07 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: fabrice.gasnier@foss.st.com,
	ukleinek@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	hierry.reding@gmail.com,
	lee@kernel.org
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH V2] pwm: stm32-lp: Add check for clk_enable()
Date: Thu,  5 Dec 2024 20:26:05 -0500
Message-Id: <20241206012605.2877412-1-zmw12306@gmail.com>
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

Fixes: e70a540b4e02 ("pwm: Add STM32 LPTimer PWM driver")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2

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


