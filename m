Return-Path: <linux-pwm+bounces-6788-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A3CAFD544
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6801C188BF86
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880F42E62B5;
	Tue,  8 Jul 2025 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QNeuVDz0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B02367CE
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995481; cv=none; b=f7bJ7zZlFSvc6LSpO8UkIVDxBzc0THNP/LTuWXg8C58TAvuMwcINvO8YVlRxfiY0FbKYF8V7I62MXsV9EnSpL35eDQuO1R2g/lzn1qmHCmLaq9d7Y4GtVyDoUiCkB2jPjvJ640ekelq2uGBR0kdZpUOxOFtTpb/131urhUEW82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995481; c=relaxed/simple;
	bh=27T+CH4JCy3LjoIgVtX1lspsGvvQNBComPrUmne9nk4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PdEjoKJc276eWn3+VJPwnXpJIb8ZkuZUANZHK/42FFDCFkplBpOLK4FFBt67OqbN2mci/oFjHOfLR9Kf4mSQuQnkKaZt6MsfN80qenUKJ5nqv7yWPbnSdqVpELF0UsDnTK6e3xSHy8S4zbWwtBlI5Zh/ZQN87xp7kOyLgOdLR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QNeuVDz0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acb5ec407b1so799660166b.1
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995477; x=1752600277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C91XbJcX5Si9Hj6AWmRlSb7hG364FXUxCuzC4r0uJEw=;
        b=QNeuVDz0EBGlMQdLVfiEFerPeifQzjPI0vnLSjIlLY/Nmza2KR5fiPmpdl9psq12s4
         yPELV3YR7YC3khqUBuSNMtqsJ67C5A5cgVuNiVfFpet7QsVnVDwW89LUxjlUz0ImJCx6
         FBfhLnjuuUp06zimo+/Y2eO4h5W4oKNUE1v4wc25jvrNGtqNQ5QcY6jiBlPM78E4enJN
         CuWFbtEtGCG7ruB9sbSI5hkv2L1VulylvEDx3c3ZLObPInmoOiR9U3UxFRt9eoMcxP4+
         pfjqVBoV/O7OGKU7LbYs5gLqVD+qzGfZKCyI+78VpWIB4jZAIvc9h5g3SXdFBac8/EPC
         BLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995477; x=1752600277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C91XbJcX5Si9Hj6AWmRlSb7hG364FXUxCuzC4r0uJEw=;
        b=E+bbwM7+tO3RCXzbEpphcLoTIwkhkk7M86cWQqZ8Wly85YkOYDLWFRAt6BIqS7lWCg
         4tcFbO/A3vjX07OHs/AQNq49ImUZluGwcAAR1uIHx5oOj3nNXozOIsNQ2bmUUy1fNf0F
         Xb1Da+64GdwBFOrkk7UP9u3VxEcOsdmd1Jmc2vMwFn3hiwKs1rApFTnmtpLT6c3aRUlA
         MhXakUI9wCzkrJy/sobpbplr4HQypTMlBsfiNGG78AcHZVrQSkXHIoSG2In2hCwEIbyi
         eQfRGXPHkl15GKpzgcZqFWzzghz93sUCyXjkRiGuy5TQPCiknQ154fcANcvYvV8pDoDN
         Uhnw==
X-Gm-Message-State: AOJu0YwFFFQj5oLEActqzDmPmFJWLC/iE2jHDIA/dlZXhnTzkfkxUSqW
	tmtLNm9EGxWsxRV0DbC6DTo98QvBmT8uBl0Cx5IKyB/tZyi/erWOYj0/xBXcyM+WMQnoqyWf6qS
	qKUoS
X-Gm-Gg: ASbGncsW51ihdZBdgfeR+6MAovKZ0NxOHk+Cxw0htaieGsHYYWsk6gntw9QsBv3ea6B
	+wfLSi0O+Bz5hUlbKMIIXAY4kMBLIcoQNIHF15OgyjL/fUoRLPD4gjyI9MCiyZDaAs0/0uUAHay
	PipFM5qroxPN3eTT1adwQ9O7tLwyzkk7Wo72WyPYFVO5P8SX9vrRpl2U2YjGHljM60O2AOHk19s
	bhvhxOTOSSsoGk2DUw0fO0NHlTaKxH3Gua9FS1KBo28Vl6HVZQ5VB93aYF00YSkdeE8a0SpXMs1
	QbiGAwQSvhamwwZvNZLiHFevxb+9fbsgMe2CmCgyhJu3UUoo4m0Xte2msWPWRCXQBoSnWeJ+I2Y
	+QoGYlXjNRj/FWly8JqC5fOnM2djI
X-Google-Smtp-Source: AGHT+IH8ZkWzQ+cMvkIhsfUL27qhTf34YfPtbqmon9GWsULM/9iBZPibI47Iz3jKmenXdYPN7jGqiA==
X-Received: by 2002:a17:907:8693:b0:ada:abf7:d0e1 with SMTP id a640c23a62f3a-ae3fbd13d08mr1688196666b.37.1751995477208;
        Tue, 08 Jul 2025 10:24:37 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f6b5e7d5sm926429066b.151.2025.07.08.10.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:24:36 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH libpwm 0/4] sysfs: Various fixes and an improvement
Date: Tue,  8 Jul 2025 19:24:12 +0200
Message-ID: <cover.1751995302.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=620; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=27T+CH4JCy3LjoIgVtX1lspsGvvQNBComPrUmne9nk4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVRA9gm332iry6IyJkETch+Qcdmd3pR6sXA/+ TO8tjvUf96JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1UQAAKCRCPgPtYfRL+ ThqmB/9JvxaI+kzuUVyllSmlpnISwszaqpmteJwsi99VxgVFHN0tGzFVB2icuPdKjELtCV3MPr7 CySGKox3T+pEFdDFmtZWA8wTBwpy56aS4e5GNiZxZxhv5mP97yQVZ3aNPScKt1v3XSurcbKTm5o GcCy3qPjx0mUo+nlRR/Ooc/H41TO6dn5rbkKfpvYxqmPpo1BZ8gc+DRLQPCccHWJmYglmtN8cz8 2EiTvf+Fqw1y1J9pmHgrZX4r+9DvNi2OvqQyul46KN6IjoUdcDnyDmypUP8vLAQK2DcYJcoD6kZ 5dKI+2vtuwreYCDMEHazYlTYszKqwN/rZss1hZszBDnU9uVB
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

while working on the pwm-mediatek driver I found a few corners in libpwm
that doesn't seem to have seen much testing before with a driver that
can only implement normal polarity.

Best regards
Uwe

Uwe Kleine-König (4):
  sysfs: Fix a wrong condition for duty_cycle writing
  sysfs: Fix polarity handling
  sysfs: Keep polarity for constant waveforms
  sysfs: Implement fine grained cache control

 sysfs.c | 134 +++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 30 deletions(-)


base-commit: 3a9a9d36d95e8aa5ed563590d53c1715285a5ffb
-- 
2.49.0


