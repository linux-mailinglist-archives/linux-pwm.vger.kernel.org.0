Return-Path: <linux-pwm+bounces-6626-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3392BAEF32C
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 11:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6230916705E
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 09:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB57A26CE09;
	Tue,  1 Jul 2025 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N1EzFnS0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94623ABB5
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361770; cv=none; b=ibFAb0YS2QpNsJHsFXWcfRlpzdgda78ItAejeCD5zG3eNGUpIdtCN7XSubHqV7354Drfq+7WQq3O80C5NQ1d8X6mWE4xq8/R89LkI3GOQtaKxkRnIeDlS0p+s8fxgWpUkYAl1juTmEPD03vijyw+YeIFL+UbHO7HLX6nOqcooFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361770; c=relaxed/simple;
	bh=WDPcSd680guMHutePUo2sb9AXNvKsSjrdc95DntYIlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KB3vyCBFogLjRZRIHf5pZuy9FvzqqX+a4jCA9Pv6SJ/dakrE/LDDKCVUIuBl9dsA6c6WXBfac+HlECpMQ6UkfQZKRSxtmQJTbY+04O3tP2thkZi4YSUTXTdwKmKb9yzLbVFuw1HiuwdSc/X7f72d4nSVPFoe6Ma08T4MSZ8q7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N1EzFnS0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3b37207easo49576466b.2
        for <linux-pwm@vger.kernel.org>; Tue, 01 Jul 2025 02:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751361766; x=1751966566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVT1yFp/HjeLlfeB/7qCKoB0uF7blBioZl7s6S0+Lag=;
        b=N1EzFnS0LaghW1ukPNvkkSVCou8gUZJZI6q7MwMijiOaklGZWfrSCJaX5jSgNY8WFD
         W4vgrKLeLzyluaIifBwIPRPoaLGGdgNE7Rar3JOtVDtMaczQZdS+bEwjYXqePzvJsGls
         iroII/DNuZzSJp+/t3LU2hkxims+z0bKmG0tYCzP4c82S4UpWYZatYuw0uHrTc7sEI3u
         yKhYXvuiakUNJFHaDMMi10v4fybeO2SFNUTxfq3nMWMmigNfmMXaZj6r0haiNhghh/xu
         G/7PD73YnOni512vauW2wjuL0c/ISWpIdpJoB5q+LtWM08s+Q6QGohsKD0shoHAhzv+Y
         kQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361766; x=1751966566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVT1yFp/HjeLlfeB/7qCKoB0uF7blBioZl7s6S0+Lag=;
        b=rBQtX4i4Zz5yA5InvQIXyDN7PTZ147YSr2LB1DB85fuP4quQMXmCkFyKts07ANSNNr
         HyMVDZMEQIZrfJ6/GJhdOgV38WOfNI4Ru8Nn3x3EQKX5fGJjZEAxznKixeySiikmYz5U
         /Qgx/qyXgfJZyVghxJbltyRYyXsVhrREz5eYWZUMyr1qLPGRRIpAe8dcGdB4FkxP/GYH
         LKfh7EneeG1gz0+PucyBVEyB1lAjNb0Xkoy6FdLZqkoT87MJwkA73O5AUmccxZsAJvxO
         ZEpwnOAArEjR98tmPXX1OATLMqCXbihbhbwtiRmURrbwjKfbUHhL/Fy8paXcwNBw+4pu
         wVKg==
X-Forwarded-Encrypted: i=1; AJvYcCVhjJM6m86RuuXyik/XGMz3KjJDSQ2y74VMrPtpf79JgKFYgC88Y4KxWFEdCW+vAkkBFpem+F464KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXtiJLvp7Z84FLO6FLO2c2tn1VnQ507MWAt4mN8wcmiHjvNzE
	yu99bBFg49Es34zoqQmdYJHGfGvjbxoBUCftto9KVzT+cqjsUzhBUK0O9BtGjxnC+V4=
X-Gm-Gg: ASbGncvGDY1VvPSHNxy99m5viQ/cm1Sb8jJrW4zhCZEkObfDgIEskBwH+CyC6GOn13S
	SLBdECyWP116LeHTV0Sl04sxHp+aogJMZHHZ3VsI+2zpoXRRDBbkHLS4gIqHJvveCQgDnTD0vIU
	PGPH7s5Se8uLg0+k+tSAbRY0fC85+4XUSXAQDoEICNxfPgx9jUGSb53d9tcCrKg6zjlgiD3anHV
	k9wCGktE5Q3kffuJNo8pmVnzDZ2psXD5lH5ev7/caVaQkkhlOcLvtf/+3DLpqPToK6sR/qFmS2i
	w+8rHDk5BkomLkstbT2HxoCWS/n1Y8pTC9fVnduBWE9Gma9h8e52MOOHn/wpEy29xYk2ahlITPq
	SYQi/K0FkH+4ZWfDg6JC2FN3mQw/y
X-Google-Smtp-Source: AGHT+IFZdq1NZHDIulXPlQuX5XMNUcKGdnIBul8pqvsYdBp1L4Bvr5WiImxevKRjwpv/ZiS3cZkfeg==
X-Received: by 2002:a17:907:3f0b:b0:ae0:ab07:7bba with SMTP id a640c23a62f3a-ae35011ff9amr1638414666b.45.1751361765635;
        Tue, 01 Jul 2025 02:22:45 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae353c0138bsm824291866b.85.2025.07.01.02.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:22:45 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Flavio Suligoi <f.suligoi@asem.it>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 0/2] backlight: mp3309c: Drop pwm_apply_args()
Date: Tue,  1 Jul 2025 11:22:35 +0200
Message-ID: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=WDPcSd680guMHutePUo2sb9AXNvKsSjrdc95DntYIlA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoY6jbC5oB8EE9E9gtWZWsipYaB2TH8+5R6T5Kt 9AdMrVoRX6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaGOo2wAKCRCPgPtYfRL+ TrsqB/44H74MvsBOGODdUXEVTHE6B31qnZdJQ6m46uqyRYqAc1xTitz9fVs0tI7m8L/HO4vrsB9 xhCPKF+qTY4FcR+zLCU6xw5xhp3J9Bcv+EPE4Yv34FVz2CgN32mvEW1HbkxHCCLyQDs1/087Po8 9pJ0VkX2TRM27UKnNMo+EhZcmWzkfqaIF8MUaMDg8w9Y6DbyT0oaIiu4FlSgaccJEAAlFH2mn46 clrJgdUXGGti2vmDiOC2u8d/cIftt+RAcFS5WW7zfUqwn55w846+sUf4I9mhrAGCBR9qtkLIP4K ASli44fO0rEJPMvs1HLHq+PuLP3k79oGPwxJrXX8Ft0ZKSzn
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the first patch of this series is what I really care about: There are
hardly any drivers left that use pwm_apply_args(). When all of them are
converted to not use it any more, I intend to drop that function.

The 2nd patch is just a change that I noticed while editing the driver
that is IMHO nice. If you don't agree and only apply the first patch, I
won't argue. It's an alternative approach to what Daniel Thompson did in
commit 7ee6478d5aa9 ("backlight: mp3309c: Fully initialize
backlight_properties during probe").

Best regards
Uwe

Uwe Kleine-König (2):
  backlight: mp3309c: Drop pwm_apply_args()
  backlight: mp3309c: Initialize backlight properties without memset

 drivers/video/backlight/mp3309c.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


base-commit: 1343433ed38923a21425c602e92120a1f1db5f7a
-- 
2.49.0


