Return-Path: <linux-pwm+bounces-2364-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA3D8FF2B6
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Jun 2024 18:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924A21C2540A
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Jun 2024 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70350198845;
	Thu,  6 Jun 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SN0u6ZAu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B10197A8A
	for <linux-pwm@vger.kernel.org>; Thu,  6 Jun 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692078; cv=none; b=hKuVFkZO7zK8NSAAaFppQDC+8wkGx6HmpNqy2tc0YtxsMJoaDWHztN1ok5NS5NrpXCTWBYDp+AOcSU55tR2yrTEu+jRRsRR5rMzhe2ceV4ez1wq18zO+OwpAYYzEiWHMb9hNKvyBGO6WcM+FkYyFZNwv//COdNFWNSumnkz2hrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692078; c=relaxed/simple;
	bh=NgEp4wJFP8OQoG1f967uwvuzPv7RniPGm3kP8chKzEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oxy6z7UG5ru1fOjEQi7yfZoEillMIKdLRZ//M67HjLzehrYJHFkV/9Gnbs9VdFUIUzY6sb5w8RlH8JhK2bzBQP5wOmWOLnNLqUsOGOsSIKsXB2NPqwaBY05kvjNz/RelLNJ4cJRiDL+99GL0xoL0BgzBZOfrQN78AfnPL79Lim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SN0u6ZAu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-421555a4454so11989605e9.3
        for <linux-pwm@vger.kernel.org>; Thu, 06 Jun 2024 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717692074; x=1718296874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFlvoUhHTBcZh8w8IJw3LmmJrN9QNxWkJzuoMzje6c8=;
        b=SN0u6ZAuirEKCRCWlNfFOB4qBS3pHE2uwEAC2DVYShVzHRNAFwMtdlF5XsXJ1c1urm
         NU0fiAGzlEAJma0SZ+sGt08mA+5rTGotO4zGiSumEixm7L3hSmfshlaKhhZrrml8uMW4
         WlHCbkaxyQGxMsamZeHBweI/Ho3R7Zx3pukM35j+zhzOxMqTDjhk2bEsnjzzV5eVuUuQ
         1Xv/400dySyhlejtHamTW0CnfY0DmURsvEvvK3GSf0YQDwtLHaIBn2jK6pxcctZVKoOX
         wgaNkCsOdMIgg80ArQmT5+S2OAJQhR9K2iP8Op4HtTrxZgJR8z9pmQszVuqvEk6IQFaE
         x5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692074; x=1718296874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFlvoUhHTBcZh8w8IJw3LmmJrN9QNxWkJzuoMzje6c8=;
        b=o8l85VoS801mUG2cPnv1UbZp1elhJGhb2DOoT8CqvcyPLN72FVB8Rfz40krsxrpR+T
         XIGWFKHdnzvPAPYfsIQb0jRbjDuz82hxO28sLj78PlQbrtfMNg3XWxFiKy0kaYYgi3NY
         8T6ZXTIn38/SjUt6Ku6WLgVQMrl9OGG8t9B/uZoUJhvD5+XcIxIThoepWW7i/RXOtuwg
         Dja+oluitxl1eh490Rj0su7SkVF8Y0EI8siXHBlb8mPiBqx6VLSyMQU7RgJcgV8Kl4Eu
         iZtUCv7+Na2yrEwOcb/HOZZmoSTmSED84GCJuNU7ftDVF9uZ3/wg0MyhHA+zBb+hi7Wu
         82VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2c9/YFhwcr9y3mpxZ/iKd/W1muYSF4toEZtHVG+i/oMn1hgrbfyvIulyENmYn7TitqJiWhZQowuQOblGvBIn5SdsE1RdDL1Mt
X-Gm-Message-State: AOJu0YyUhNuCCxXPI+aGbYZ1y/PEIFWk/QHgeWL1dhKq6Fj+gbgQKIz/
	HccwiHRWgW5pWX+Hi4FxVf7TMGn5mY3kwZYf2YkRB0V0O1SnUq/+t0VdTygjcwI=
X-Google-Smtp-Source: AGHT+IFI2CKQghwXxPOkm3Fd6QZzekxPjX0h8JBpBiwlKcaOKDJJpkDQTFN8JnYlJlnbpzb1YKSR/A==
X-Received: by 2002:a05:600c:a09:b0:421:494c:9e74 with SMTP id 5b1f17b1804b1-42164a07144mr1895225e9.23.1717692073932;
        Thu, 06 Jun 2024 09:41:13 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215810826csm62355245e9.17.2024.06.06.09.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:41:13 -0700 (PDT)
From: "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Paul Cercueil <paul@crapouillou.net>,
	Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-mips@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 0/2] pwm: Make use of regmap_{set,clear}_bits()
Date: Thu,  6 Jun 2024 18:40:45 +0200
Message-ID: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=581; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=NgEp4wJFP8OQoG1f967uwvuzPv7RniPGm3kP8chKzEk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmYeaPBInvQdNHM6Stx2iHKkOq3tnLNPTc0gBLD AC6QWIwbY6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmHmjwAKCRCPgPtYfRL+ TpJjB/4+OejqU6/wmRq8FxmCM+Ymr9bg7nRNHcxhOqBuUHgZwBejWrsZ74AjHPFHVJ39qnq+9ih iQTUV7UOjVjykTQF97eubsdy/Xvq12Y+O8i8RrRF0HBPuCCUX885Z5hnRe+mzJucpru4/QJQYYw HGN9lmoRaXEyodkTo8su7SVS4D3l8kNGPLDmqrBSTA3rhtKo+WK76srwusvNc7Fd6BvPW/eJJxV gF0v6GM965hZfqoXTnZqerEUy/+VWBHatQlQ+UOG/jSMUISBLtVGmIbSHFQAdMZ8weWMWPBRmbJ xERIGLVBkysqvwrfVCOR/bLMjZO9M3kdykY6N2xTvd0axGVp
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

during the final look over Trevor's axi-pwmgen patch I found an opportunity to
use regmap_clear_bits(). Looking through the other drivers I found another
patch opportunity in the jz4740 driver.

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: jz4740: Another few conversions to regmap_{set,clear}_bits()
  pwm: axi-pwmgen: Make use of regmap_clear_bits()

 drivers/pwm/pwm-axi-pwmgen.c | 2 +-
 drivers/pwm/pwm-jz4740.c     | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

base-commit: 7cf775737d4ec337e46bf8497882cb6a7650839a
-- 
2.43.0


