Return-Path: <linux-pwm+bounces-627-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A0681C8E8
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Dec 2023 12:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F55D281EA1
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Dec 2023 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21BE15ACC;
	Fri, 22 Dec 2023 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NRUtbPMK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA91171C5
	for <linux-pwm@vger.kernel.org>; Fri, 22 Dec 2023 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3368fe4dcb1so611862f8f.1
        for <linux-pwm@vger.kernel.org>; Fri, 22 Dec 2023 03:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1703243842; x=1703848642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMtDAy1EXDszTwMTqqohVsilgzyKD7wGsQGS9hZLtqo=;
        b=NRUtbPMK2ZhT8F9ZGVPZftkoZUPHyEHEwIbn7dZUBBBBDbTO7W2RHlZPvZGMMfmo6g
         gwyyKj1J0JUVqLJ5SsRKjhmxX5FrWJDOTL7vo6uGTdK7zbwuSAnIdseXf//WLUVf8Qdu
         LrtSz1y3AZnYF5uO4aFzU8E1FCtBBhkE4dpjzZETvy/PJDf5ebvZZlf4uL8L6PXCaUE/
         BtFQ/xPovI6hjnB6WA2oowYUmDLCFK5IN59FjmKRvDxQHr8GBzLhUbd89OMGu3vT6YwL
         EkgoFyzo15BdUzu8ZSoIw9oHLnBWR65zfFk7noWuWGgPvGPc8hi1lX2+hqSD8bsSgzmm
         KwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703243842; x=1703848642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMtDAy1EXDszTwMTqqohVsilgzyKD7wGsQGS9hZLtqo=;
        b=SaeX6ppnIdohT8shw+VGgGl3Aa3Hg137Z9WcdjRJ9oKDzhXXuz2OyYyUsaUQzLmZwq
         3URLw1cCAeGNq9Ov5s5splkD1Q3KXrzwuOFTc9MTA3rdgSmVx0r8rCcG9Uj1LyEmVybl
         5/jnRjiWZdhR7hspCrKnvSeFqb8HDh/IjTEJkN6ipbFSS3i66qmw4jdjjDNxEU/0X3TA
         dZrYaykZXNeARKe1De78x2mSJo57g3L5Uz+/qbTVJ2D8ciOmqpsip29st/6YbhBXCDgj
         wrqiOhcNfHrvTdvq9J59DFVgoSOxbumGm1JqAPOpW96AQyDmZ+DNRjqcPcOM/Q9XLZmN
         9jrw==
X-Gm-Message-State: AOJu0YzYMoTOl+9eXBFNr6uOxW3pi3ITuqZVV1zuGNiy8h+uq5b4vzCy
	Q8s3GSTI0jf2qJHVuyicOT0H/sPqZN/xxw==
X-Google-Smtp-Source: AGHT+IGGUtKBAgABRxh1RQY1Fn8PPnFhYTQfQeBrQ50xlTgo3iXBsPVCM4jR12MyjYwvlX+3OKFDog==
X-Received: by 2002:a5d:4a45:0:b0:333:2fd2:8135 with SMTP id v5-20020a5d4a45000000b003332fd28135mr578985wrs.82.1703243841708;
        Fri, 22 Dec 2023 03:17:21 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:c099:e596:3179:b0fa])
        by smtp.googlemail.com with ESMTPSA id f8-20020adffcc8000000b003366b500047sm4054069wrs.50.2023.12.22.03.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:17:21 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH v4 0/6] pwm: meson: dt-bindings fixup
Date: Fri, 22 Dec 2023 12:16:48 +0100
Message-ID: <20231222111658.832167-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This patchset aims to:
* Fix the incorrect bindings for the s4 type of pwm that was introduced
  while converting the documentation from txt to yaml format.
* Introduce a new compatible for the existing PWMs to better describe the
  HW in DT, instead of describing driver settings.
* Make the introduction of a new pwm variant (s4) slightly easier.

Changes since v3 [3]:
 * Split first rework patch into 3 changes
 * Use dev_warn_once() to notify use of obsolete bindings
 * Rebased on Uwe dev_err_probe() change.

Changes since v2 [2]:
* Drop DTS changes. These will be re-submitted later on. Possibly after
  u-boot gets support for the new compatible to minimise conversion
  problems.
* Position deprecated property correctly in dt-bindings for the old
  meson8 type pwm bindings
* Reword commit description of patch #2 to make more obvious it does not
  introduce a new HW support but fixes a bad bindings.
* Dropped Rob's Reviewed-by on patch #2. It seemed appropriate considering
  the discussion on this change.

Changes since v1 [1]:
* Fix typo in the new binding compatible documentation
* Disallow clock-names for the new compatibles in the schema documenation

[1]: https://lore.kernel.org/linux-amlogic/20231106103259.703417-1-jbrunet@baylibre.com
[2]: https://lore.kernel.org/linux-amlogic/20231117125919.1696980-1-jbrunet@baylibre.com
[3]: https://lore.kernel.org/linux-amlogic/20231129134004.3642121-1-jbrunet@baylibre.com

Jerome Brunet (6):
  dt-bindings: pwm: amlogic: fix s4 bindings
  dt-bindings: pwm: amlogic: add new compatible for meson8 pwm type
  pwm: meson: generalize 4 inputs clock on meson8 pwm type
  pwm: meson: use device data to carry information around
  pwm: meson: don't carry internal clock elements around
  pwm: meson: add generic compatible for meson8 to sm1

 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 113 ++++++-
 drivers/pwm/pwm-meson.c                       | 291 +++++++++++-------
 2 files changed, 276 insertions(+), 128 deletions(-)

-- 
2.42.0


