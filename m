Return-Path: <linux-pwm+bounces-7353-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF03BA4BA3
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Sep 2025 18:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435221C22810
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Sep 2025 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085923081A6;
	Fri, 26 Sep 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lpA2cIyj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290301C32FF
	for <linux-pwm@vger.kernel.org>; Fri, 26 Sep 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905889; cv=none; b=MOQXN8G/VmjnfOsQwneJP4p8+n6QxquwD5KKfpPmzHKBueTJmeG4n9rkYKDuEB/+UmZX2YztMyLOjQ8944YmDh0Cq79oKakFJ5rXCD1cUT6VmvRrZhj+plRdHJJBgi1E9v2Fil+wa5Yn6j9LJw0OVsCQhJ1mWsVgTBL/R7iIC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905889; c=relaxed/simple;
	bh=4CB1G4HR5ukBDJeGyUt6y0eR1OdGZ16a03vpsge1v6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CR6AMdHxLYb+ca+zz5noWth2ryEs8EVv9smK7+mp7Jhap6sNZBzTb4jlg3EqsxoKlhnbM/aHCEfAyeAJJk3/d88QrBD5Hud74cpwQxrNsM3D7sW1qaPX5+UT7Wvy7Jt/P8SX6Moc1BIM1ikf5LT161XL17iG7T9fa0w5LhuTb0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lpA2cIyj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso1992462f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 26 Sep 2025 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758905884; x=1759510684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKcKQ3pt+IJglyoGF4X4OioS/rc0UHKFt+d4m8rRYIw=;
        b=lpA2cIyj2RxieGzJEvB56jbhAllYywRqearrF1JAdQO+utsaiqlfRCd3lH7WeLphkv
         kK/jZZ3PgCbozFoNOU3bCx21TDsFxiQiip75ajK1HB2TkgP4DwOBKIo5jjls+XkM4Pev
         Ra9xtw92fkkBJjvoI0NIKj01/bGvmlL37rqOjzAoGq53H1owtg7hykIjqbBreuuDlwlM
         Cc3G0meevSgxY0DfZFeUeMLpSZBB9CaK4BHFVybIUcZ4Ute5wy0NiyUp3yhZbpvVENc7
         HIiNycE9t6RuERJyuZPcpTChB+s10Cn+t/PLGsJT7ec6GoheZjVsV/er5/e3bRBh9e24
         a34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758905884; x=1759510684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKcKQ3pt+IJglyoGF4X4OioS/rc0UHKFt+d4m8rRYIw=;
        b=KXp/83uEBEz3xxoHwHMNnZQwOPSUufl6oymBLiSzCbOGRZKAXZPtp/g/j1seUyqZsW
         GEfFW6Kpsh0ZAro+khE57JqOZ+fmUJ5v3AbygYacl3kVAic11Pk1261Jt3ssCO0cMWkS
         oc7KawRkh2RGCiZFkIdJwrWsMLritMzSSYreAP3ogqYuFzNjnRz3HVqXuYUjXkfcDg7m
         PzXSb+0FxOQlipCIyL0tZqcOjk+R1EzWKUAoFB7MI3WoiOxW8lIp7CWn4Yyaq2KUBI/2
         ceWvhgXoepgC/fdVN9M1acjOriLvyvx+BOpncw/T021eeKXDIzW0+Ktu0hSnLUkE8Yb4
         MDcQ==
X-Gm-Message-State: AOJu0YxJor9vmoGk8HM0zlHXXj5ZrdhBQiSM4qz4nVvJGNKCFFASr4Mq
	tJnEHwE1+XBJt4okCL0/btJMPPardTXeCe7/WX3Ur0qINRRJIm6VStcYCbcaUu+su8Gro0S8iNf
	Zpo29
X-Gm-Gg: ASbGnctYTvEjZv7vNRjY8S4LS4MvEtEuX5MaWLrRF/O6PNV4Nd336Q59F035WIrEyd8
	0nVVzWWNgrqx7HJNhtBZbSMi5n76IphzYQIhsuvtpvYwcxZ78SsOUBLZMdA4So3NVJurzMFT0X0
	uYxs5LMdS7XhdrMb0iwMayIaRObzJRld6kUncYfAROYFUNFmHWgnAFtoiS2ceNmO2Y1YAzcTvxg
	OlTB6ZcV9NQb+zsVipj90nTDiqeYKDYTfveW2un9qbDI9ZUg2+BPqdo6GYPRQrPZQ8Iel+beAMq
	Y/ECal1EBkr32kSw5BiDBAKRvNTjFuleQ3j8lnpau64dIbvAwyW+xe+xWdSFCVxCLGmZEifj4w3
	+wAbhC+JDa8LF0sFEIxyPOuIvGwD0i9dMbcn5ywHIUVADn1vYLG0v4nJRHFBaJDSn9ONdHur9pD
	c=
X-Google-Smtp-Source: AGHT+IG1l1bziAXw5VN8wgOvTAwQZTNQH7eFDEMnI0yzl9ioK4G72lFx/CCnsN205a/9l47OXbcx/w==
X-Received: by 2002:a5d:5d10:0:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-40f61a7b486mr7578178f8f.12.1758905884246;
        Fri, 26 Sep 2025 09:58:04 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc560338csm8024607f8f.41.2025.09.26.09.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:58:03 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] pwm: Simplify printf to emit chip->npwm in $debugfs/pwm
Date: Fri, 26 Sep 2025 18:57:03 +0200
Message-ID: <20250926165702.321514-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=4CB1G4HR5ukBDJeGyUt6y0eR1OdGZ16a03vpsge1v6Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBo1sXfwq3BiC9FoRQkwXAOoPk5e0ytrifUsvrfR nUE2At0nMuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaNbF3wAKCRCPgPtYfRL+ Tm3iB/9QLw30urZvHWDvkzuEWRax0QbvokygYFKAMWjVF7pJGUVYc3P7+f4qFJuips/9jx0N4Wb GcIqvlVxLmZYDH0QjyAcVWTMg+AHWEmiGd+wiGG6nHf/haQiLR6ONlfCh8SqsAVJLm1cP0jzrlF 8FA1Ea9MayotV+spkWc2VCoI60yaHmIPz/v11rxVhfZKH3Z2+FKsrQEJsvBIjDMgKKDGwwePfCq saZdEdoXDSRUVbdkt4d1cINR3Imp4kR6JK7Um3zse+JbgoA76/JLcHvf3Xyz3wW1uWIsroLKNLw /l/rWDlcT3rjlJzrKHx85t2n8YBhMmMmrEr/Ely9em3liOUd
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Instead of caring to correctly pluralize "PWM device(s)" using

	(chip->npwm != 1) ? "s" : ""

or

	str_plural(chip->npwm)

just simplify the format to not need a plural-s.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this implements the patch I mused about in
https://lore.kernel.org/linux-pwm/fol4hemfnbh7km5dfdkbrfxx3txc4wtv7jvdn4h2xlzxlcoyht@ax7ml3rq53zs/

Best regards
Uwe

 drivers/pwm/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ea2ccf42e814..5b75f4a08496 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2696,11 +2696,10 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 {
 	struct pwm_chip *chip = v;
 
-	seq_printf(s, "%s%d: %s/%s, %d PWM device%s\n",
+	seq_printf(s, "%s%d: %s/%s, npwm: %d\n",
 		   (char *)s->private, chip->id,
 		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no-bus",
-		   dev_name(pwmchip_parent(chip)), chip->npwm,
-		   (chip->npwm != 1) ? "s" : "");
+		   dev_name(pwmchip_parent(chip)), chip->npwm);
 
 	pwm_dbg_show(chip, s);
 

base-commit: 8f2689f194b8d1bff41150ae316abdfccf191309
-- 
2.51.0


