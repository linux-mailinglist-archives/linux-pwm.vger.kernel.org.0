Return-Path: <linux-pwm+bounces-6510-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AA3AE6E6C
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 20:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F56A3A7E9E
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E051C2E7624;
	Tue, 24 Jun 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v7WmyU1G"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF900293C6C
	for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788981; cv=none; b=aa1H5M6px+Ilzz1/A5cQ+wBp/eP8Nuc2u2GtKzqti8reSTmXq6kCkPAZ0+kmSJ8rgYUO61AIl3D0iiNilwmChbhopMYafewJYw8Es9vKZtk8cOEsIxUkPxY1OJDDsl0klVCeZM8PYVp9KlWgDdY2+3/YVqwPUR6TJuaoVJxVeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788981; c=relaxed/simple;
	bh=S8bWVrtohU804TFCIPr4aot/z07tET4jFwVUKYqLlZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VU/Q/wi7qPxjIFaBktCXeh4muNh66AUXoOkQO0M9fXz/iZqch00P5mESGMR1v14A/XFD6eHJp3ObbQBpsk0MaGH7sK+VGlotEhTWWAbnti2Vo2/zU46EAb3pG0sCzpcyMAv7QbJ+PodRgjMNeKI0tsTldKDTgDyKpw/xgvWZSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v7WmyU1G; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-adb2bb25105so910061366b.0
        for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750788977; x=1751393777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VnpSnkfgkUADh3xBII6BavGc953e/khu2q4B6DDX498=;
        b=v7WmyU1GTYzoTDwpJmHXR79mXCHAjiREAHakCxQG1zyc2bQvRADcoyooIMtKtHcgtS
         cT+sOT2kU9keJrSc7KEG+ifSL4I6Vt3pOfsznRKsWR4eZTuhgpsZ7Oe+V+W4cFpxefF+
         JPDR5EJXEK7tyikOGrQwsYmht8AypU92sp0z5nGhs41iwWRh4aC9ZcEONPJDb/0aQ0/E
         wPtilAIVhUNXLvtQaA1QU3gWW6z2K+Gy5a81SMTzJjgwJQFwlV0+LKHEERHg9DOWzx8M
         uG4znuU/l0I4VfIIRi6LfyuQ3bObr9RwLNNZ5+qhAQ5Lt5j7qsdz5uz4f6QrSk9DpY1T
         cBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750788977; x=1751393777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnpSnkfgkUADh3xBII6BavGc953e/khu2q4B6DDX498=;
        b=UO8yDxUIuhYJ9dCUAysUkvDU6IVcqkqym48/IkEo3RuMEefp9uiBHpjM1pvH3AqxjT
         dmFlR3kG8dSkcYEpJCtHYIvAyaYasieZX287yQLdKw2Ks7DPYFtD+vi2JP203a42aOnL
         rADbV6Em0GYbIFsK7ACBTE4Cb47IvWSEVnZLct09xXxO6C0uyVqxnQkmwZCyFyxesDhf
         NtO7n8V1jUIrs5wdVYSmFRf1fnnebozbImcCpPw9eTUGc0ra2n2JrR5dKZxpNJaFtnzo
         4+7JED0MlSjEeWjh+7h1dLjEMlxIToyVfqwtUaqLNdsmwOZAPjdfFr9M1xSbUfjvGVv0
         ySFQ==
X-Gm-Message-State: AOJu0Yyx33fenQ4bnXtso0WRudiW7uYeAVM9u4mx0tdmshklVeEcMcRu
	uwt1W3koyBorMQZFKKot97v+DSIccmXJtqzW0h1jxFacjrpTTHO/Ho8qfBX5P7CLjC/KzmNYb/Z
	YwWgJ
X-Gm-Gg: ASbGncsfBF9Nb3VmklebKrN/M0g8meGEtd/jIUaJCiGc7ZzfxHDtEpwn3+t9Myd7+IV
	UYMLXXcbkuclqkjDPP5McZguLB8TvrElvoX3qU4YItOHzB/JfZp53EFH5wkpNSenx3mQgYv/EEp
	rAXJKTPhhpLetsXLkMTyVPJfwFiwdbtzzY3DLid5lqsIooPGNBlubgxO9+/h6OWJQaupNDP6LJH
	2q4EKt76SC0lHqx8ZwQSswTMNiZ2T8TlyhmFsthu1oaI+S6o3CpiJyaf09owl11viUw+8aMbMAO
	cR1IFi8St7KyZer9yanEC6lwo8VyeEmGjJohCTlYtZNvkcTir+Veomp0hxktWTiyl40=
X-Google-Smtp-Source: AGHT+IETySV/NwwqbbDLqMU7Mh5iub1oxToadv0ZxFROQaZJtAgApSrTnuto7oLvvORtd6L1Dbo99A==
X-Received: by 2002:a17:906:c314:b0:ae0:635c:a400 with SMTP id a640c23a62f3a-ae0beb0531fmr22317666b.51.1750788977207;
        Tue, 24 Jun 2025 11:16:17 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae053ecbda9sm905954066b.48.2025.06.24.11.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 11:16:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Zapolskiy <vz@mleia.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-riscv@lists.infradead.org,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 0/8] pwm: Drop local locking in several drivers
Date: Tue, 24 Jun 2025 20:15:36 +0200
Message-ID: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=S8bWVrtohU804TFCIPr4aot/z07tET4jFwVUKYqLlZ0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoWutKdlfvI7KIzHJ+KN9OasXDBe9Ets/iGGJT3 I980PyuD9GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaFrrSgAKCRCPgPtYfRL+ ThL9B/wNCs36L/ISd4BA7zNBxQj5xBfjauGisVwporrJNf6qsKCwNrXQzidhknNvp946kr9gTj/ 3GZpj2d+UbQZ3AVgOMPIGsP4KkUomd8bCzxxuV8vCYvqB3oaXo4u7MUMI0/Y6JSmjh9RdLL2nz4 svG2I8ba2XHL8nWHRPNDbvQEPjsDTkU4/z536VcFjQXP1gSTOa/+Yh1JnyezwiP1gcGOBLeUj3P guQ2ykm0AKCku7biNbXTJzIkI1Mzz8P3Tso4jJGZ6a7mquAzUpmue2SbYP1gMV/nm416ULVDwW3 gxd2zphLoM96KFKamXLTbVyKW7sNAeHWRXFVNMiUH+EJF2Kx
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

some time ago the pwm core implemented additional locking to protect
lowlevel driver callbacks against driver removal. A side effect is that
.apply() and .get_state() are serialized. This allows to drop some
locking that is now superfluous due to the core's locking.

I identified a few drivers that are affected; these are cleaned up
accordingly here.

Best regards
Uwe

Uwe Kleine-König (8):
  pwm: atmel: Drop driver local locking
  pwm: clps711x: Drop driver local locking
  pwm: fsl-ftm: Drop driver local locking
  pwm: lpc18xx-sct: Drop driver local locking
  pwm: microchip-core: Drop driver local locking
  pwm: sti: Drop driver local locking
  pwm: sun4i: Drop driver local locking
  pwm: twl-led: Drop driver local locking

 drivers/pwm/pwm-atmel.c          | 12 --------
 drivers/pwm/pwm-clps711x.c       |  8 ------
 drivers/pwm/pwm-fsl-ftm.c        | 28 +++++-------------
 drivers/pwm/pwm-lpc18xx-sct.c    | 14 ---------
 drivers/pwm/pwm-microchip-core.c | 17 +----------
 drivers/pwm/pwm-sti.c            | 23 ++++-----------
 drivers/pwm/pwm-sun4i.c          | 10 -------
 drivers/pwm/pwm-twl-led.c        | 49 +++++---------------------------
 8 files changed, 21 insertions(+), 140 deletions(-)

base-commit: f817b6dd2b62d921a6cdc0a3ac599cd1851f343c
-- 
2.49.0


