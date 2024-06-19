Return-Path: <linux-pwm+bounces-2543-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FAE90E6F6
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 11:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45BD1C20AE5
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A6480026;
	Wed, 19 Jun 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G6SHsUyt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AAB7EEFD
	for <linux-pwm@vger.kernel.org>; Wed, 19 Jun 2024 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789208; cv=none; b=RXolmPeQ5Zl6FjVyIuyFsCICozdA3cJ7FVExpyizx/cjBJpZH2uksGnnGx9qAwp5UKWWE4Wj8v1PqIKzvDjexosihKsj9BbvWGz/NU3oDUEqUEcTuXE1JFPmE0KDN/bdY3zBXFK8jyd+BoWh7ns1Lcu2sGsNUtDDb7hftKXMusE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789208; c=relaxed/simple;
	bh=8K+WjM34MR24mhU/bzCFPG1mWsgoIklGhckomjtcqZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fyIwXS4sm3TSMUQq48wHxZDkOsWrYXDqqN1MtKRrTuxxCtuGjgwVGd2D9vrw9GL28a1wGpDTFMsm8/dxLMlv7meYfWuUcnaZmUG4zYKLogwRLzLkgq6QJGQyDyKM5FEXuUKgU06L3wve0HwvOahd3xMYMAbDR+F2GPs2HPRbOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=G6SHsUyt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f1dc4ab9aso5201031f8f.3
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jun 2024 02:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718789203; x=1719394003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezQRRIlNxNy2QrCPuAEV8Oyb8ctHh+po983NuDBnwzw=;
        b=G6SHsUyttCTVp2pNawddnHzZHrhxuaFcX9X22TnZPhXacIQiaEEAkGfg2ByVxEJK2D
         qNKbJFlgoogaqyz5orS91nBlcPvmTgnhS37A2e48BL3Eu2PHW5DfqLZcRv41weega2XB
         TRIiW0P8XUy/VMpUiOgmeeEJIUfE9K3HUw6V2I0/eFBSK0Psl3zDqhyEgAsSWCdIyp6E
         JT29AepIWtB9Tq6igIdVxXWhALuVMWt1ePQfAqdzK6ObucspaPV2/KAo8NmNr0mbhQZT
         Pmnn6oR7D8WzF5tqxOkr2v/mfSqF8l7wR6nqg8YlzSKBnqtOWz9X2coCoW7DbfKBiZTB
         EZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718789203; x=1719394003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezQRRIlNxNy2QrCPuAEV8Oyb8ctHh+po983NuDBnwzw=;
        b=OVOmnrNo8+SnhFfzBs7mkXa5QWS4+uSIw5Q4xt4QI0VadOTAIBOgk8J0ygcU8QQcmo
         R6VUB7rFHuSYvOXUBM8ZxBfamgfYewDHZP0o3rOo5KYxFwJrwiwIZL2rkblsVnlTqmM6
         LSbgsUIHGDHe1q2mB6fXCaIU8Vh5ZzaCRmbqK5WiU60BqMKeZZeRV8kI2OYpWrLxEBa9
         zOMdIbTNykueuCC5txVAG5gHNOlTpAc+pJ2R/V/tLZi2vFryoqtw4flhBG0xLcTzo7WT
         q81qmE3EaX2KELzVkoj9E7w/LOexHLlLt72jAU2izwucQLAIrImclBmQkF/b39U27jFL
         AjtQ==
X-Gm-Message-State: AOJu0YzHVxNMJaCWz2sO1QnTTNR2Wgvv97qlU7J7Wb2awY5NTXO3oC0d
	5ox0lismWzd2cWurwlzq3AJ7O2QcahMX5C6dlaD1uvSIbpMm0eh2OUg3OGv4dr8=
X-Google-Smtp-Source: AGHT+IGgDsBMEJLdwNAcDw3PcY77JcN2xEZg75HuwFgkVWJfFOmTXqt3HCQbJEJog+YJjnIQltEwEg==
X-Received: by 2002:adf:ed47:0:b0:35f:1bb2:4354 with SMTP id ffacd0b85a97d-36317b7909bmr1476123f8f.35.1718789203528;
        Wed, 19 Jun 2024 02:26:43 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-363e110ea83sm580059f8f.113.2024.06.19.02.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 02:26:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lee Jones <lee@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] pwm: stm32: Two fixes
Date: Wed, 19 Jun 2024 11:26:23 +0200
Message-ID: <cover.1718788826.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=533; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=8K+WjM34MR24mhU/bzCFPG1mWsgoIklGhckomjtcqZk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmcqRBygtncZJsb5+PFhsyNusHwI7zYAGBSK0ow /sCo8fwWMWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnKkQQAKCRCPgPtYfRL+ Ti+yB/4mxgOvo+OmLwR8PCMpp2jnM2ClElhsnuSSTMyl5UN4h5GkJDjmONpNy3bsxwB7117/6k1 Q9AX6/lRsmtxQGS7IMlXosAFM9qk28M+pwZj/egzcD6HRW4hGQ7N1JpyI7v24WrAIZfoj9/eRkQ mCjDkuF+Er8mzuXcd0FFdAb+N1OgS6fLlgy67yROfMaFEWMORwf3+SipVd3yyA+d9jM6gwq40Lk JbtwsR49cCGABdieBl1IAaOxQhsu3qe0a7o+cpiAucRu3z9pyuEnn/phsBcsH0eOw2xSCNSacxF luZ+roIox0Y4FKoHg1lJpeoYae7clhPM25eg453uqWW7aEOU
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series contains two fixes for the .apply() callback where bogous
periods were calculated.

I intend to send these to Linus before v6.10, so please if you have
concerns don't hesitate to express them.

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: stm32: Refuse too small period requests
  pwm: stm32: Fix calculation of prescaler

 drivers/pwm/pwm-stm32.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.43.0


