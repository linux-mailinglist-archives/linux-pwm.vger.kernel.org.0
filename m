Return-Path: <linux-pwm+bounces-3424-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB1F98CB90
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 05:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4ECF283434
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 03:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05A91078F;
	Wed,  2 Oct 2024 03:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFqnoT5x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC9101E6;
	Wed,  2 Oct 2024 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727840312; cv=none; b=PV9ec0XQSSmYBIjiJVnOf6UaAN8Y5P2ZGvTdwxxIUiqU8SlM05h43lDLjN3ZUAIDZkET+U+AOsoFaqZpjIu+K+F6yAgdQaqQznNbF+mtyfZ3Hx1EjipArz5BPEF0g+Zd9iV4pBgr2p9eBGOYtmselvJoGomnjKQdbR5cnj6rPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727840312; c=relaxed/simple;
	bh=ubntFyn+U170UHY/EMBXcg7nDyc7ap8EztnP7A+f/oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/FYv/XD9zhBhGJ5XCRwtqKLT2f/Qe8k73Ex7OoGG1jJ6UB+/wUk5/J6NjOcUp73McFm3l9TkQE+oZ38+29gzGW5DfdaAjwZhXVEXlvopSfvl1tdkWqI9iU6EkIiYX+PIwyPO0+JrA+XujYUwcjo/88opseqSXpz4BzYzV53X3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFqnoT5x; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cb7f5f9fb7so7608876d6.1;
        Tue, 01 Oct 2024 20:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727840310; x=1728445110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iUOKiBUXnpsFTZ5jMqyjR0K9mCXZ+ssrPBDzZNi8o+w=;
        b=CFqnoT5xRGA6F8mbb8BDXdpa2iQeKYMLsSehG6dEkclE36gBe6LC/j+MxjEtPl/nSi
         nYiLw+PwbGOY18/OUvUYxSX/PL0rtE2Fyrze+31ODFO4CKQGj4pBV182grVPNTzTPcgV
         zdVLZpF41cALAq+26VfNIpYuNwkbXAUBoq1Z6RiC05kmI27vBODTmNvIwOSXRyDwil5w
         GkKe6KJAyduIe9T6t4lkqOakrt33LclIdQhTveGR5clyJEzvss3IGfAlsBJgDKT/pEoo
         o7MEjWVH6jbF+sWY8XRLOauEJ5Ub2+5oYVUfwEF6BaC/HCo36qXzFIix7FhqMuMj/3nE
         8+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727840310; x=1728445110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUOKiBUXnpsFTZ5jMqyjR0K9mCXZ+ssrPBDzZNi8o+w=;
        b=ca6crqI7X536p6FuDj6HD6JL4uz2xl62GTQG7q3udZJPyJDpTvOo5SZJfgWkuQ0dOx
         N0FdAHkITk8/4eSpI08SMhS92RMCU7tiJLj05FJVUuy1Ejp95W0B9ZXnJD5XJj2T9R28
         s9Lse5Yv7r63Yb1GWFfbnWp/wpfx3DE8uvIfbeELM0KvqH9FAFPzGXV5QoB1+Xzmp1iH
         iN3rX1v3NUgd54yZNCrw/BqLa12u2WKzScwjh3+LdjQ2YNJtXLatWxIZ5tknl9vuwuM9
         LSEHPDRDhBSs3K25cg29YXtgVva24XUGZqcZJlaXpGnxdkLIOQ3DrAavt329I/wMoiim
         SDtA==
X-Forwarded-Encrypted: i=1; AJvYcCUhxDIbxUB9xx2bsTq4OkSHpGYg0Ve8dl2BuiF0VDE5y7L1ZMYgrCEjcAO9RbPNX5A6hhJcxLvqslmj@vger.kernel.org, AJvYcCVR+cj5gFvDsl4s3Jtci6mwpDOLNurCl2LoXTA5tV9LZY7AAVFSSKMoF8h9zLL+1+dbSvWCDXHa16dX@vger.kernel.org, AJvYcCXqI6gin2XH0IrDAAxKfaVvesVkI3VM1wYGGkfbtdfWRtE2puvx10Dc1jA62pHhxUN/Ghds6f84J8mrfWNC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cxD6akYpUpIxKGxaoe/di4axJnB1C1SZHf7KOFjOOsKxZ1KV
	qIKMCbEbaf+j719AGKMOOunF/7AVpyc2ZaWgDaYSR7348diO/GfW
X-Google-Smtp-Source: AGHT+IFB3Rfsz3+Lfr4kTvzv/Vj1epWm/jyj0EIrItSKQRLruClkbfn6m+DM4X6WPN4Ew4cmQ35Y1A==
X-Received: by 2002:a05:6214:41a0:b0:6cb:3a7b:96b9 with SMTP id 6a1803df08f44-6cb81a05676mr22602866d6.15.1727840309742;
        Tue, 01 Oct 2024 20:38:29 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b62d9e6sm55640446d6.69.2024.10.01.20.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 20:38:28 -0700 (PDT)
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
Subject: [PATCH v8 0/2] Add driver for Sharp Memory LCD
Date: Tue,  1 Oct 2024 23:37:35 -0400
Message-ID: <20241002033807.682177-1-lanzano.alex@gmail.com>
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
 drivers/gpu/drm/tiny/sharp-memory.c           | 681 ++++++++++++++++++
 5 files changed, 800 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
 create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c

-- 
2.46.2


