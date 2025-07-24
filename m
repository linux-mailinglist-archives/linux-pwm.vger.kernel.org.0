Return-Path: <linux-pwm+bounces-6877-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4006CB107F7
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jul 2025 12:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA7C1CE3B18
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jul 2025 10:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2199267AF6;
	Thu, 24 Jul 2025 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqwGgk95"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BCA268C40;
	Thu, 24 Jul 2025 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353744; cv=none; b=aqaKI2vBFyLRh+7sKzhu/53MREMBLi2wlI+I5byIiBm3p71CN+IwkdxR4X+ZPZvYLYm8bPZdLbUu3T2bBjB9vekOdA/9oLiQrK3pjENArP0+amKM5Pgtc0jEPKdO9cxqTCloJNO6jdmZEgAGDadc0NZYPN+duoVhbqgImAPz1e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353744; c=relaxed/simple;
	bh=0GnIrdQuiuwk9twORjmOjMFrGFzq+9BtHPC//Q+r62c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lDm6qOHTIO9Y5zPraWEPpAYRfKbkLDzF5ShTTCspnh2kq3QonE8vBAJhH8cSBT/eJEIgrE0i2moX7adgaSFKd9Ynb+f9264nm1RqMBv8HjUoDHnvPR+XPd/2mJUdhrawNkUS6kAtlLGxmy9FNjuhC7ZFGdNo6TlW3HRkAfZdq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqwGgk95; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so565441f8f.1;
        Thu, 24 Jul 2025 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753353741; x=1753958541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwEsZFOMTw79B2T0J76TXkguQ2wD82TQyZlu19uUWbk=;
        b=fqwGgk95goqZaXK/FRCwqVn/zsJwBUDC0x6T148G2d+PWFAK3DsdxigUiWQ4bSZuiN
         HIff8ra4HOsq2nrOu/zzI7C0nyOz/UC0Q37aQT66yEiH2Xt1PVat27XyNPs+ABzPuMGE
         HYkjdAMbKIxMiWESMgE4lMBAjSKOTINOOkeQbqfeZuq9mioy1Q/aDBWhzXughucK2xuA
         WRT1QAh8RdICxGjbT70R4XEVLpv+1nelW6tcMHL0ipSsy6vSmxLExFzd2Ib7AuliPRgE
         2eYMTg0irZ466chgcjqrYTrzm1gocfRMrLlgkAqgX4+rl80gy+bcq0DRK2HlldYoW4te
         csqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753353741; x=1753958541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwEsZFOMTw79B2T0J76TXkguQ2wD82TQyZlu19uUWbk=;
        b=wQ765GZt+FSvbjlWCbpnT0uX0GRl9L0zFiIpII1usk2G8yf0V51N5E5IuqfW0SDqL0
         ttMD7ZN+ZYRUxeU4bpBV39f3cze1c15O5tX0YSclWi/xGu9SPjgC4znUIUF3senKy8UT
         dBApgso/65rB3gC7OD0+XWLWZ680mwVoxpTrJqxjEfi1UzYJwHPhn+ZWbct3EPCfTlZt
         jIMyUu4ERP2JCQW0zJVwQEcB8FqwG03lod1S0pqZYmvxKkgwiTsgjR5PC0h8dvOzOTjV
         C+9ggi01SwFqZBbO4oBtvTyvRMWcKBp8hk2F9JsUTBNp0irIdrZsQ18hbO6iYC6+xpqJ
         Hs/w==
X-Forwarded-Encrypted: i=1; AJvYcCU1lwZ94w8pDRo1Z8cBJzjxycOfgPoc1b91inI2rxmWB6n24X82tG2FCYpZwIezQPgM9XTCd5mAuAjW@vger.kernel.org, AJvYcCWZKedRc3UCiS9SW5CMw5HUvkiP/Y+dBfwww6FuDvHjNgjqKVQ/l052feg/lb7/jxOohPaBvIZ9fDp0OA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwM9lYGjFUexSU0c66rWM6pqCXDjAJNabZLGLh4UCTu2XQn0LD
	D97xgursV9O3GLG0W+jloa71CiS50KvFUmpWm9GRxxi/q0DfWsnlpQzj
X-Gm-Gg: ASbGncuHPxmNBObkv+f9Wh5RIWHWhjMujLSTE89aqdv+QmNWJ7mGWGDoWzA3V37vWeH
	+xUWo/3bYSUVgsZaC0jAda2TjzMvL1oiI+mzHcfV1glqZWNKcLSgfaO/ZZ41J/zABXaS8gNm5a0
	y5BclIBkRPTjuEX5JSsDIganM9CA319nzZwX4/CGZgjq1IOska+J9zV1IGZzqKzydbWA2cAwhpQ
	5Wz0BJ9RSwvf1ZzMAdKlUAC4DQ8zFo1eMQgZRxi3kIcK8WKW0T5+h8iXOYZF3Yz6/IV75tPmkTS
	0AGZlIoga7pTslKMst4RdEi2DouHfaqhNb8chAPhcJo1hWlSmryLzX1qNaPGk9VMMX7v8Y8yzXD
	Xz5u02yDuaHf4/uMwZRK4
X-Google-Smtp-Source: AGHT+IHf3nO+l8p3t3jJ6EhFc37IiUngwM81Ph85vosyw4NmVeGOHyyAy8bPU+XlWIEPNHmM/awr/w==
X-Received: by 2002:a05:6000:22c6:b0:3a4:f7af:db9c with SMTP id ffacd0b85a97d-3b768f16051mr4156342f8f.59.1753353740987;
        Thu, 24 Jul 2025 03:42:20 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4587054f27dsm15463795e9.11.2025.07.24.03.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 03:42:20 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] pwm: Fix spelling mistake "Firwmware" -> "Firmware"
Date: Thu, 24 Jul 2025 11:41:48 +0100
Message-ID: <20250724104148.139559-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in the PWM_RASPBERRYPI_POE Kconfig,
fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 3ef1757502eb..e84f7981df7c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -535,7 +535,7 @@ config PWM_PXA
 	  will be called pwm-pxa.
 
 config PWM_RASPBERRYPI_POE
-	tristate "Raspberry Pi Firwmware PoE Hat PWM support"
+	tristate "Raspberry Pi Firmware PoE Hat PWM support"
 	# Make sure not 'y' when RASPBERRYPI_FIRMWARE is 'm'. This can only
 	# happen when COMPILE_TEST=y, hence the added !RASPBERRYPI_FIRMWARE.
 	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
-- 
2.50.0


