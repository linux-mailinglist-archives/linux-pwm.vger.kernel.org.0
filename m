Return-Path: <linux-pwm+bounces-3506-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1370C99229A
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 03:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52422B21C6F
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC529C8D7;
	Mon,  7 Oct 2024 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbCYIp59"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF6849C;
	Mon,  7 Oct 2024 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728264646; cv=none; b=bw76qJ/BaK5/+XE5vgenKIWYHiNITtsvN2ra9Ei1cip7iiZS1gQQ5F0SGFvh6Gc3kZgWQz03pYzyUJxwYIrh0wQwnQRSpdStqPayCua009AYd5dtub/DGXWIDMTw0sOTep9muBwCEZTe3lbU04WYskxmixgwp80/2PzAEUB+gYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728264646; c=relaxed/simple;
	bh=CnJ6EhrzDENcvUxAwCmy0yyNq4GGx+eeT/Ap9yxdkJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOedF55wbeAldMJFJV5FRriy+HJLeIeVShnxgKjQ/eYhhrTk7arF4f12CLTC+0tAfgl7M0j+QnhUMq5QJwQdnN/Dq+O8mJSY6lWqolP0L/Z1LI7nYP4ka8Lj6kurmENmcbQz7JFgftgXiomf/h7Ux7idnaGWdhuBPVsu7JSRXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbCYIp59; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9a30a045cso346892685a.2;
        Sun, 06 Oct 2024 18:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728264644; x=1728869444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4BL7q8zanMLPZgq1AZ71CIoIOsuiwDVh+BCfFx3B8I=;
        b=IbCYIp59hyFvrdHEcPpFWhpSguajB7XuEsyw17uPmBRQU5VP4+5zi0jSyMY8o1ud39
         DtyJ0g/bLiTw/4witeYS5QplOT1ZImepMTte8CwuIIlQoBSfEiE2y2ZedTv+43kJSeTy
         lDK4iL0KteVaqPqNWcGtccY+q43z6HSfVaD4kSo2bI533/dvUHktgRtEVGfLQK2+Bfw7
         BwBoTA6AmMq8WVgjmfS5NO6F5iZxW3ytxBzZzZJoSWLzCI5aDpIKVfze9usCe8W1EGSf
         JrsMNhALxWCTW05m6nKsor1JfbFD9jAiG34Uym7CaXK25yibcLFhtICPlgj0M8QQAtxM
         QNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728264644; x=1728869444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4BL7q8zanMLPZgq1AZ71CIoIOsuiwDVh+BCfFx3B8I=;
        b=EIEwZKGdG9NXBtgFS0edJqL2Apivm27aQPfMi/F2BdFKI58QZvkLjv/iYIKqkSdski
         5vjNuD167rYVr8OX7eYHTE9gfWopQLrvxg5k67RQdpdhGkq0WDvujOXHnAMSuABvZ9Ug
         e2pW5TjTjaDibreeVg/PmhcdeacPra1CsKSZxgpd6qTDWb6zYLGAYqUITASS1iF2YGBb
         p6X1RSR8N7Q1IDr+Fvjle8Wb5lmIYjwYgY8VW4lRBYi3j972f/SzxW/ncQOtlF70xzd4
         QrLE2iaGZsq73Qqgqyi6CtXZb7uZn5ypIiEKFcS9MVvQEdPct2a23tq7iPQcf9BwEBc8
         YLIw==
X-Forwarded-Encrypted: i=1; AJvYcCWrIkE1nB905v02LNnXu2gJt1zoF5e6wMTZRNCANjECsU9jTWvjFft8ZxYIxEz1T9r2k65kUsMp6hliiwby@vger.kernel.org, AJvYcCWsDvtYxMBbtL277ntutRpMoJrlC60ZPsJPuJDRaCN13FRxmwH4fJbkjht2HwPc92sXw5nlw+f6TYJ+@vger.kernel.org, AJvYcCXECZ35zCce0KVULFn5U/ipXju0/DXR3TIh65J2YMHyLnIccmOC7BF0QwVOgvum0RXeawRpuglmKage@vger.kernel.org
X-Gm-Message-State: AOJu0YyYyPL79LLqW+uEJ7AC3Rm+haIGbXevPKiuW8fDc3Zda8h+Mot3
	E6ChEPhISAmU2hdBM8OWZre7QFNK+PWPqMi6mrFjGB+1Mm6zfh+A
X-Google-Smtp-Source: AGHT+IEUwTDUTwHQPPMnXkL2oBBF20EQpAtzbYg+OHDr2onQw1DYJTSZ7x3HJKuUZql/yUpw2OUU6A==
X-Received: by 2002:a05:620a:31a5:b0:7a9:c610:99fd with SMTP id af79cd13be357-7ae6f4a696cmr1503155585a.56.1728264644003;
        Sun, 06 Oct 2024 18:30:44 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae757627fdsm207326985a.100.2024.10.06.18.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 18:30:43 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: u.kleine-koenig@baylibre.com,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v9 0/2] Add driver for Sharp Memory LCD
Date: Sun,  6 Oct 2024 21:30:04 -0400
Message-ID: <20241007013036.3104877-1-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series add support for the monochrome Sharp Memory LCD
panels. This series is based off of the work done by Mehdi Djait.

References:
https://lore.kernel.org/dri-devel/71a9dbf4609dbba46026a31f60261830163a0b99.1701267411.git.mehdi.djait@bootlin.com/
https://www.sharpsde.com/fileadmin/products/Displays/2016_SDE_App_Note_for_Memory_LCD_programming_V1.3.pdf

Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
---
Changes in v9:
- Move pwm and software VCOM generation to probe/remove functions instead of crtc enable/disable functions.
  pwd_disable will suffice on driver removal.
- Change comment format to match Linux Kernel style.

Changes in v8:
- Addressed review comments from Uwe
    - Replace pwm_get_state with pwm_init_state
    - Use pwm_set_relative_duty_cycle instead of manually setting period and duty cycle

Changes in v7:
- Add Reviewed-by tag back to dt-binding patch

Changes in v6:
- Rebase off latest drm-misc-next
- Replace pwm_apply_state with pwm_apply_might_sleep

Changes in v5:
- Address minor style issues in sharp-memory.c

Changes in v4:
- Remove redundant dev_err

Changes in v3:
- Fix file path in MAINTAINERS file
- Address review comments
- Simplify mode selection based on match data instead of model

Changes in v2:
- Credited Mehdi Djait in commit messages
- Renamed sharp,sharp-memory.yaml to sharp,ls010b7dh04.yaml
- Using strings instead of int for vcom-mode in dt-binding
- Fixed indentation of binding example
- Removed binding header
- Removed extra whitespace in sharp-memory.c
- Fixed error handling in sharp-memory.c
- Added match data to of_device_id table to be in-sync with spi_device_id table
- Replaced redundant function with spi_get_device_match_data
- Sorted header files in sharp-memory.c
---

Alex Lanzano (2):
  dt-bindings: display: Add Sharp Memory LCD bindings
  drm/tiny: Add driver for Sharp Memory LCD

 .../bindings/display/sharp,ls010b7dh04.yaml   |  92 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  20 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/sharp-memory.c           | 666 ++++++++++++++++++
 5 files changed, 785 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
 create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c

-- 
2.46.2


