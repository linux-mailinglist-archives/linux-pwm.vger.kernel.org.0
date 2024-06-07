Return-Path: <linux-pwm+bounces-2370-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D598FFE3B
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 10:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFF7281E40
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 08:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4E15B13F;
	Fri,  7 Jun 2024 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BpWR2dzm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F815B120
	for <linux-pwm@vger.kernel.org>; Fri,  7 Jun 2024 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749890; cv=none; b=s4S4TS0SvhS/eXd7OSMm8ik3YNvFPyyKUEG+LrCaBk75sQSzdOtAm6Kg2yvb3aRmaRBzvQPNZpYfpH+IfsWU/ygeopU0msri7AHFU3Zn6Keq9SnSNP+Xh0Dgm+oEC6k+kjB6QS9rqqqYQAE7t982DsUBZyqHn+YTbX1ZlIz8xfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749890; c=relaxed/simple;
	bh=ihnvS0ABxYKrNQlZi5are9mu4sgy03wux49T4CEZWq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z3YRReBGrlqDaEphttNbHsFXqotWVbqQnSJPEwv5sQPuS4W+yIVcEOj68XqUd2Vl/COFghwfIzLPOxyjtXSEGPg2oxqVy7y02eFxNto+P+6O/8ZOWnLmjjnOPTr1PrOiFv9j4s+XxcwgRa+LFLqbmFkPlZJSC/AI3a1J/ljRkE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BpWR2dzm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4214f803606so18022415e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 07 Jun 2024 01:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717749886; x=1718354686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uszGwktNGOeuCgKmkGe8cHShTeyjdwaQQjy8GQU7bhE=;
        b=BpWR2dzmOzoP/oPKAgOJdkJee0jJEQL6ihJsvkGCFSAXiZvwehtLYh5kxh9o4jSU9e
         Rkpl+3L7o8NNxy+6Yp+IdY0PySgBllSqzdaCUUjdgYMwpQDbLzcuLrOD3wli0WYxhInb
         iFeSI2PgSUgATBMkCtIDm8pew0gR/cBkHBlUK5IIastfixi4iVl/SWMxAtcCrHyhn+WG
         pMVeHyq9ml0ZC+pnK+WYwbu4N6uj04C7jCIuQ6on5+eGwRNm44VYN70ZMNdcn1/xStwP
         TG6r5WOOUX7+9w9/GLvKLbjqJWKZTDjFiJxwjMtgKycMR4fv8iEK4ZeCtV9IhBiL6/us
         8yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749886; x=1718354686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uszGwktNGOeuCgKmkGe8cHShTeyjdwaQQjy8GQU7bhE=;
        b=ZRmSsDunWgfSxR/sKjJQX5OKfrC4jPgRQrXvIOMSrjgsf+UXA9jHIzi9/HEFqeezfI
         5MYteRz4ImXS1i2/hUqoMmhi3Di1OHXdzIn5WWp5C1UBJFtMPrrsWHV4+zkQcpwna4sH
         clmNOh3pwxD9RLF0kh0b/mFFzfs9y79zKujAiremwa5o7mrbXwEPtt5iTet+SyUWpRJ5
         0TVoij1yfcnYIEmFgTTaQQb2iIKWwakuUZYWrm6ev1PnftYiENLPjWaXlVw04wpKAhGA
         PiVe3upVZHkaIg87Ead7kpcCga7cysbhanlDNCTU5YaYI1gs0ui/tu8VeTSD5IHgQhro
         wn4A==
X-Forwarded-Encrypted: i=1; AJvYcCUEJlJS73tB+jyLMfUSr1fz9gEFqzG+ifAFGHRNR3F8VG/MTaJyxZDYpmGAzptaCGEYXbb+BejWvBg0+B95hGzSkbCE8ZxDnrjl
X-Gm-Message-State: AOJu0YwlNfbBxENSBSjqEvpyh10ImvxRrsn+vrcdort84LRqlA5OLh99
	UjEAjxuWzSHEiM06ygnh3jwtJJCjoTiY5GSnIQL+vkd4r9O152y4OrJBYkcPUCA=
X-Google-Smtp-Source: AGHT+IEEuakaAfwi0wDeNmgPeB1P1PPMZuFb9rASp+9zaA9reljK1tQ+qlJ6Gw8SQhgD2im8pe1oww==
X-Received: by 2002:a05:600c:1909:b0:41f:e959:9053 with SMTP id 5b1f17b1804b1-42164a48472mr18734225e9.38.1717749886214;
        Fri, 07 Jun 2024 01:44:46 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e97dsm46376265e9.5.2024.06.07.01.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 01:44:45 -0700 (PDT)
From: "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] pwm: cros-ec: Some simplifications
Date: Fri,  7 Jun 2024 10:44:14 +0200
Message-ID: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=ihnvS0ABxYKrNQlZi5are9mu4sgy03wux49T4CEZWq0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmYshhKfgLwp6JZ+frPV+nWgJhRibmVGfj45G7r E0kqRxcFBGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmLIYQAKCRCPgPtYfRL+ TuxGB/0VytZh0DBs7Vmgz/zYmyWJyYKCBl2yt15ghmLFeNvlrQ4oG7vqCAPxl90eZBrhc8ma9PD m46aaPW6/4fp3jlIvfhR1HQT6to6grtfcbICXJN2dS4U6Pw7Cm3yNHYh/mYocljAbgity20ljV1 RyRissSyS716GIQwKuGGfwsiUiO6BvJ3A/6zlrlQ4urfhhO8xbTYcRNWkU4LQi5HCc+LUWUhm+n 5eQ3IhIO+a0ujz0YRB0LAFlS7c3baftDHUF7PqdG1Nj/0PFP/RFDAFgMLudRmTyUvMi1dYWuzc6 iOLgoMZqu2FPSYt62q4AHBWhVe9tf31r2bp3duxUCM/09/DJ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here come some simplifications for the cros-ec PWM driver and a followup
change in the core. The latter was the motivator for me, as I intend to
work on some changes how PWM wave forms are represented and this reduces
the number of code locations I have to care for.

I claim in the commit log that the changes work just fine, however I
only build-test them, so a runtime test from someone with a cros-ec
device would be very welcome.

Best regards
Uwe

Uwe Kleine-König (3):
  pwm: cros-ec: Don't care about consumers in .get_state()
  pwm: cros-ec: Simplify device tree xlation
  pwm: Make pwm_request_from_chip() private to the core

 drivers/pwm/core.c        |  8 ++---
 drivers/pwm/pwm-cros-ec.c | 63 ++++++++-------------------------------
 include/linux/pwm.h       | 12 --------
 3 files changed, 15 insertions(+), 68 deletions(-)

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.43.0


