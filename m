Return-Path: <linux-pwm+bounces-3526-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E9A993D49
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 05:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F67282B37
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 03:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9B633993;
	Tue,  8 Oct 2024 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZWeEK+N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6428E37;
	Tue,  8 Oct 2024 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356693; cv=none; b=BlGMIprpOnAKro+G+HfArMvgLdPY3EzvqfaQJI4qmzAih7ScuG4Uuugih5JruJTFS4ZrSczR6e1PkJPQ2jdXohSREtkGArIVfgoQWFXZ891gvygBXJZUMSbtVI9kwHs3zpGAjNVZHuxmArLZUdcUZt5k0ThkK90W1DrBXyX0Cmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356693; c=relaxed/simple;
	bh=+aBbq3flXoKbzSexegYMj70l1IJBXlrUtdKER/ZxnbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DnkoO60ZRvbSgfEESd3Oynjzb0EAjO+J4N8XCKqOozAi9RRhEj/XmTbk2/+RY/F/OK16jhDQMacdnkBoQNAHemFDOZkqGPkYrmpLlX519EimPGMN31bAca9yiiVqNiF4Oa6isMlXkS/q9zySbr1maZTSCKKEQI+5gc8uowM7xp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZWeEK+N; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb2aac40faso51897376d6.1;
        Mon, 07 Oct 2024 20:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728356689; x=1728961489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QGhZ9VuDoP4GsoTXaMvOaT1WODV/aEdRH+9/FcI3aps=;
        b=CZWeEK+N5A5ct0m5whzuYJDcFZVV1cIfgiAgMpWvPiv7/h6U1Qi1Q7rJvhxxn8u5Wv
         UiBmv1cWakZmPnA+rKsZ1zrrXF92bGvykTzwdioI+2NLB7EpWDT4rYFH+3Vhp25WlzJS
         P9RnEHno5P0mWZ5zODfUXS7s8yIFnfw1mz+hXegQy2vb2A8hCrwvm7ZKIy5KCOeauj98
         ZBtLrfnmlNMfoLxL5O5lprILE0UfpAjuUE2jpRAc6cVYNBbGWj+9H5hzCsCFh2qzePrv
         dbvSdZVfLR9QEvYipvvYwo7y/iPGGSKBUMFmy9tTwuQVd874yDEaC2uEFK1vPbbmd8cN
         3X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728356689; x=1728961489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGhZ9VuDoP4GsoTXaMvOaT1WODV/aEdRH+9/FcI3aps=;
        b=E7XX9C4ZrqhJU7JkH6/Ro0mszAloD8TWeX3fa8zGinQWqbGa/U9/6Gb+AiMq9i+hiw
         peghdX+xVn5glxL+u8JGpsEOJJkn7A73HevoPbSi5Y4+IDHCrcsBi1czzCDGBoFArW1U
         E90IU+f7+9dm+SsbJG8VbB8CABH/RrCQjERvVpmX2GL57EZHz3Wfm3e475N7Vw+3zet6
         Nlo8ttRe9nS0lFT1qf573ReC4691xOlvB4WQffe88EysqQ0Ky98L9N6RyP0FzfhuHbGC
         mvoAL1IdKOCFfTf4qIq2DOSMgf4BPL9vqUFesHgilugIIPGPLzWtheysYkTyuQobOfb3
         M79w==
X-Forwarded-Encrypted: i=1; AJvYcCVGSXJpLrw74PATACS2UsP4YYq6Xt4tmgnCjAgQiUtjb96hNkzFXmNj+GFB5wnQYP4AOZs5sE2w3T1a@vger.kernel.org, AJvYcCVcFIr2d2KFc4POE1OAw4WDq8LY/u6CyVfhDsVNw36xSxqaZIL4LUfOLgh3YkzDFpgWJfap/U71wYkB@vger.kernel.org, AJvYcCXWMbvzaodvRW3EXmrS9VNT+Uhnse/f8klVJBHQCgnXK4eeL5xRtQgYISLyRBpn5yIuO5/zbmV9RqdpL46V@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8m1RbljMl2UySI816LGacZgZkbjvxxWUlc0FMi+kT8qpHgLd
	ofiVXN3zPNOXPdcZBAce8RoRWnpn4c0a5g7SLWNd+bHzEQ2+vA43
X-Google-Smtp-Source: AGHT+IEogcPxh7rtiPjTL7FYbzz/R9JCFjhQzfI0u9Q655Yju+TjjSDcnvCTZAxwaHKGj7/ldWfmCQ==
X-Received: by 2002:a05:6214:4291:b0:6cb:4835:b1bc with SMTP id 6a1803df08f44-6cbba921706mr41803976d6.4.1728356689370;
        Mon, 07 Oct 2024 20:04:49 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46f1912sm31107156d6.61.2024.10.07.20.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:04:48 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: u.kleine-koenig@baylibre.com,
	Alex Lanzano <lanzano.alex@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v10 0/2] Add driver for Sharp Memory LCD
Date: Mon,  7 Oct 2024 23:03:09 -0400
Message-ID: <20241008030341.329241-1-lanzano.alex@gmail.com>
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
Changes in v10:
- Address comments from from Uwe
    - Replaced -EINVAL with PTR_ERR
    - Error check pwm_apply_might_sleep function
    - Remove redundant error message

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
 drivers/gpu/drm/tiny/sharp-memory.c           | 669 ++++++++++++++++++
 5 files changed, 788 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
 create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c

-- 
2.46.2


