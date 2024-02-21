Return-Path: <linux-pwm+bounces-1597-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8D785E09A
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 16:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8995C283A21
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F27780049;
	Wed, 21 Feb 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cLxbQz6y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E27FBD9
	for <linux-pwm@vger.kernel.org>; Wed, 21 Feb 2024 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528332; cv=none; b=t8L1W1PUPcs8GAn0+w3H7dHDuQf4WMNim+2OAQK2webLFlxYb5wQSnPWqmSFe/h+honu8GvHt+PYpB4azf+bMgT4kXFEI7250cFEz3zLu1nOYoaIqzZg2WDALEBnmwOOqVS555cRcvSPQc07L614DBpTch3jtQpJXvoeo0OaE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528332; c=relaxed/simple;
	bh=8MBWv4daSK/tAPnGOdgukRNPyIGRTHZS1yezb+YHTCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQ3mnUYhuUerXliuQit1gx6zXr7tGZ2mcB9qkMRdKxfWMaKCkz6TXWFax3QsmUzrfPatrqiKIjfXh+s2axBDDXuxhm9mzC1Nw49jGgtDIWH/3mHbRoTswTnMGy6jm1OisN1Yv3a7Z999VEuG1lCY4m71byhrSt4qr7uB2zQlHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cLxbQz6y; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412698cdd77so18329585e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 21 Feb 2024 07:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708528328; x=1709133128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3FBkTY4ktEOVpEo6YvXl49m3OViLG+BImsIBijiLHxg=;
        b=cLxbQz6ymcCXqZoV++mA7iXWCRoo1cVCN0C46/gFOZRVJrYijeeBd+ZjjraP8KKWe1
         D+78FOPxfFKAK0Vl02L6BYkt9nYWpToJdKw2a0lcY1aaDQmZTtbfqc99gkwGrb/kb1EN
         pozRg1Q25h5HhBfFyzL+/OGyzGFxUlyLKA1icqyv3+JZWxV+RiKuld/hqPR8Z4FFA7tE
         PQcb4r9lWDaSSiKXY5T/eW2MDHSZ/ecPJrM2SLMco0p5iW5jW5LwflQH8NLvHxM+Gh9n
         o6qOoitzP+FKcKpfT+79i8gk0R599CtDD/7jYeU0A8491kpyx/6yBQ4gJRGKRSLmA3bj
         zaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528328; x=1709133128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FBkTY4ktEOVpEo6YvXl49m3OViLG+BImsIBijiLHxg=;
        b=RsqGz7dC3AGmpxSH5/gVX4mOLCmSfIGETtgFh/fjQIY/F+UMcVYcEkH1sp5tPdjU4/
         P/VPDv0KYI7D5mdNg4gYIJGfxqQAoBh1f9sbadmxCKxBC7X9MkxjumfHTipd1fgEurfH
         JT+hwPTxo0+dgNBFYh2Q9kpA3LlMDwEJyvn2DZibHQwuexez8iFljyX821d3fF/b6dYA
         cv7MJZP5OiF6v5p3qyeqgXs/68AbPgHxgVL15ob/poJlRMT1mp5TH7Vf3Wi/6tKK6Mv9
         sFcx1ku7vQNi3rYwiibwVDPJoRhuGIdTl96J6Xbqc99CmYfz9LnDgFZ22hFbw8NAGtCD
         yRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFXboSgUMm6UbpMSoGvrD9IVXaI5aQiEIwrT80rWnRYSDm3Brweh4uRqddDyzfSuVOW4+Ix+qot4xW4P2YIMxwIFtYnMXmBMO0
X-Gm-Message-State: AOJu0YxjXun7/wfD3OQOOZ4CesPeEbpfWyxUqnLt34TdwsavcZo0YZRu
	QkPIUcv5GT9R7C+PAundzpydA0YenBcRimJPjdg+r/+p/hULWAn2skDts3WzMHA=
X-Google-Smtp-Source: AGHT+IEbPlqDTjSdZwcRLe9JlRyRaH1Pf7F4HirGnDZSwaq8u4fW6YZ7whK5ATYjJZ9SOJhon0VagA==
X-Received: by 2002:a05:600c:458d:b0:412:60f9:3fe3 with SMTP id r13-20020a05600c458d00b0041260f93fe3mr10011548wmo.1.1708528327447;
        Wed, 21 Feb 2024 07:12:07 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1b1a:d907:d735:9f9e])
        by smtp.googlemail.com with ESMTPSA id bg22-20020a05600c3c9600b0040fc56712e8sm18725342wmb.17.2024.02.21.07.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:12:07 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
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
Subject: [PATCH v5 0/5] pwm: meson: dt-bindings fixup
Date: Wed, 21 Feb 2024 16:11:46 +0100
Message-ID: <20240221151154.26452-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
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

Changes since v4 [4]:
 * Rebased on Uwe's pwm rework in pwm-next
 * Drop change to carry device data in drvdata
 * Make the length of parent name array fixed
 * Single allocation instead 3 for the internal clock elements
 * meson8-pwm-v2 and meson-pwm-s4 compatibles under an enum instead of
   2 const

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
[4]: https://lore.kernel.org/linux-amlogic/20231222111658.832167-1-jbrunet@baylibre.com

Jerome Brunet (5):
  dt-bindings: pwm: amlogic: fix s4 bindings
  dt-bindings: pwm: amlogic: Add a new binding for meson8 pwm types
  pwm: meson: generalize 4 inputs clock on meson8 pwm type
  pwm: meson: don't carry internal clock elements around
  pwm: meson: add generic compatible for meson8 to sm1

 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 115 ++++++-
 drivers/pwm/pwm-meson.c                       | 289 ++++++++++--------
 2 files changed, 260 insertions(+), 144 deletions(-)

-- 
2.43.0


