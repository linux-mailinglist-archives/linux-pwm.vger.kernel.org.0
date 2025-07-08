Return-Path: <linux-pwm+bounces-6776-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68406AFD51A
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55764189F462
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5052E5413;
	Tue,  8 Jul 2025 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KoCch6fz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B729F9E8
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995107; cv=none; b=ekEO3rwB+9qZu1RJo1/GVf9pcqeHyApqU6vSDewwpedH8omPeRmPu8v9mGT5LzfZJfJY15lhuR4yn0t8YUDOZbwbHcB3cr7tPJ3f6XP1UcjWoz2G62urvGh5xqdVyyIAq4VFSGTTCj232oF8mc95iqmcux6Ugre2jQwUKgJx9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995107; c=relaxed/simple;
	bh=WAydfZPhfHcRMRi/ikoWZlEifJxtK2fObg0PZp+04Vg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ABQoE06JmLQvPMzRgjArTe5ADKsQWzrdgLkkm18RGSxnIAeuHWXRKe0Ui7j+BlkFMYPb36mE6LDF0z/T40Z8LocEcQ7gd23p45tKo1XUScnE0EZTf9ppPGjteDDrx+gzLc1E+G0Y76AlIwg9PAnZoRhBqLdpHMJewR2u4d5SZ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KoCch6fz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so228027a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995102; x=1752599902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZP1T4AqFEjmmDFckT57Z16oH1OdkUv/TVC4B0r0APw=;
        b=KoCch6fzMX5z5UNUPtV+aukEJlTsFQZJOoKOL7mM8pyCWz+a53nQWo7ZoNesF5tXm+
         KeTDQOv+nAxIR5QtV881bySrJdePt1SoXbEXmUxNldIC4m3gw4ltjPZE2JwsE2kN/GjO
         jo2LmSae1bCwhUD32MnJ5kbLwZS8C4c34G/s5QRwAkA30gu2Z9DqtHBnF81dfM+Tx+0W
         E1411RrGPF7IENsJWcE0vigG4SFpi84PTHosN5GjQZxBVxovOAdgu6tFLmSKZe3Xa0qT
         D3aVMjyoVw8ky/c1/rh+fCsrWblcd54kzeeP9ppIkhbisUQmhEqvhBpawgnq3Qooz/Km
         /48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995102; x=1752599902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZP1T4AqFEjmmDFckT57Z16oH1OdkUv/TVC4B0r0APw=;
        b=sNHhfCUmbrgQXvq6koiA3AxksXIjhTV92xj66hl23hNMidbQjR+uVj4NBE8NoR7+U8
         UMInoO0s6UL0ffSJ+jI4tT3BFSVRj2SbRVwYSwvKfy6+mUQpZC1JeKzqONHhViUUOUlS
         /N1Enww2Rk+ALBKGq718RERUWtQBjDOIlhwJqIWd7jNIt/rvaUL7DM9kNtbNglz85ODH
         R2Bu2zAywrjGYI/D0PFRMsE4XbilpbAeQ6DHkYxUg8JJguS+4tA4oK6f4J/OJeTr79A4
         oY5LK6AvmtOqavcgVNXLDmEmXIn3Masg7EPFY+LcJFbV530Tk1V8feuOX1hkOB6I636o
         e8Xw==
X-Gm-Message-State: AOJu0Ywagtr4C8REVHqTlN+yCaAYin/gV9QLWS5u8pZccMlLMKxlLn+L
	tuJKEvzdt18g0AuAIwNF7eC4GGPZQn27lhjjr7ZxotNF4J8fW4PHZnmCnOVRMQaIw0M+7A8eNme
	bDKcN
X-Gm-Gg: ASbGncsdF6l2P1oqbWj2AxLaHvuMmk5lkxPkPeo+37B92JsES02dL5dHprun/lKcL03
	Ntrn2aEwRNHXXKfr0AewMg/qWrvZtMsIBwNrsmeRL9mVY+gEXMCEgh07xrGHN4rv1lnibaYbSAa
	ATsPU8bFDqmUaM+vvtEZ3IKqJ2imnweFOogdwZKNcdwfVYpW7ZFhfEiE1uJIv2i39IQ/5fjhktw
	2NAZUX2PvxmzBTcxg/OrriCE8d9BxLZ1plp6YARnohVEHv+jSsBtG/PVEfO0VgTwU9HQAnbxOOT
	tECGa6T1Cw9C+ryL8mTuL1Jtz/JP/syEfihn40shuUf6FZaejezQu2/MJIq+rOgo61FULs6L4O7
	sAk7MJnbYhAFVTtTqsClaYg4WZIAH
X-Google-Smtp-Source: AGHT+IE7QRhnV3O1XsKW6cVBs61Hp3fA0P3DgIwM66iBG+5nLVtJzIsJoGWM7arVd0P4x6MZhcsT5Q==
X-Received: by 2002:a05:6402:4315:b0:608:199e:df25 with SMTP id 4fb4d7f45d1cf-6104bf177aamr3875406a12.2.1751995102298;
        Tue, 08 Jul 2025 10:18:22 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60fcb0c9236sm7567286a12.46.2025.07.08.10.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:18:21 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 0/2] pwm: Improvements for PWM_DEBUG checks
Date: Tue,  8 Jul 2025 19:17:59 +0200
Message-ID: <cover.1751994988.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=548; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=WAydfZPhfHcRMRi/ikoWZlEifJxtK2fObg0PZp+04Vg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVLIsK2YFEpRnKtheaW/gjMq9/wug7qm+tmVW 1mPThYbKhiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1SyAAKCRCPgPtYfRL+ Tgf3B/wNZ13mUHsVBYJ4+J30H05dwSuv9TNdZAI06eDcVCjUiHNm2bVU8WPwXqCfDzLFMOP4mU9 TIRpjpvLSHo5VIlMv5OVtslEMOmkRVk6TuIiJAnJBfXMXGz/pEv/efMNlCyoYXHAmFy+DVG+Qjs 20zPqu9PJWyvboIHtSTjesL9IJ0JQelt3EpBSh8Nmi2FrJhleYiQMuMC+VsiY98fggWv+q+jpbp qGW2IwDa7l4LEtfejho4EbtLwFQ4bdgchf3kn6jgPBuC92uUDH5F8xvE/ufkia/UklbcrH9Cpze PMH1w6F5HqT1HHFLLdfCtVlPs+KOG5BkI8AgvLQvIQ079dll
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

while working on the pwm-mediatek driver I found a few corners in the debug
checks that result in false positive diagnostics. Find the two resulting
patches in reply to this mail.

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: Disable PWM_DEBUG check for disabled states
  pwm: Check actual period and duty_cycle for ignored polarity test

 drivers/pwm/core.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)


base-commit: edd3bcb1801e1bb98f4f81485140e18c86406ced
-- 
2.49.0


