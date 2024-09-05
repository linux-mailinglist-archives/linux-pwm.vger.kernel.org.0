Return-Path: <linux-pwm+bounces-3100-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B38A96D937
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 14:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F86E1F252EC
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 12:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F97519EEBA;
	Thu,  5 Sep 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGIB67Fx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774821991A1;
	Thu,  5 Sep 2024 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540313; cv=none; b=rLlmvN/oXHydPfMKsvRvhNgruJbABJdqLCHelPyvOCpLhEh0DTnLOUsJ3w/KXvkv1qtnATjhvYvh5jkwL9jNZMtUfaXC9YAVNP0GR5DKjxhz+AdrC9YdVrYtXW2JKVyXGpLfOI/S7+WiPAVERHlp4antgqMeGIZwdQAPP/UWXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540313; c=relaxed/simple;
	bh=k7Yv9u0i7AU7jynMQig03r+dpq151Fiyf2XFLGE20+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6s6GfiQyl9+GWHh+NA4JcIM9LrxhtZhm6L7GadDowqc91iZ8bIYPV2kEYARIAm5g/FRqB/KYqOIaDazuUXuntZIM8Ku5Lh24e6sDs4/e2S3GJyve3GnDno+NERpNFR+x/MesxKgzid1Z7Iz9x+7Z03PBH54qMQ0ccMseREkU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGIB67Fx; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c353f2f954so3753566d6.3;
        Thu, 05 Sep 2024 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725540310; x=1726145110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNifTobjkTTnvVcDkJgjw0tLma/dAblGN8/he/0rCkU=;
        b=hGIB67FxxF8AvDJeHMoQqJ8xYR4SJ9so+HTm7DoDlSPjJV2DJEWC0KJiOvGhwEyOT1
         VIu0zDJWR2wQGcVONPVDmT0I+ar/UfjvVFrphe6SPs5a69AET8GxQxVBVtaXuPsJxt4k
         VFvz0gyjtEHvFbYWkC1bfjtq0PboVKvq3g/KGx0q8VBdSmWANpqmhcQk14ALmkWD4TVo
         EG7J3xBknqEZr2XG9+1lU1Xl+6k8N2VZmHug0vKRQN3ii0MivfCuBZy0aHPUOa4xtc/S
         rdI8M2/Dswl2USx31fBbVWUxKb4TWRZyI4h69eVyI5af5jbYWzx0aH5JYzl7LqVGKoP4
         iW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725540310; x=1726145110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNifTobjkTTnvVcDkJgjw0tLma/dAblGN8/he/0rCkU=;
        b=sJNsxybSNYKzXk6tsn6i3RdIbQ5Yw8A3fQ5ULxhJOBdIZtfsvqtJhYZeYc2ei69xaY
         RSkwb2nCN/DwTTN41GdCT9A2DZ2CXJiNkbmg7ZBPSFkr0YQMNV8SDOfoLt47rRMFvCEJ
         LuSyQSYMEh335tVihcgSgXyE4wvtqFBSHixvxMKQwCZsJ1F/AdZNnVuxUCsQ0KeptwOF
         aVO1iNUfmzESUY0wPGNVg8IhzHv5TYiyVinWnogSXlBobewL2wIMosoncgvmyCiOoIHy
         P57RBAfAM/2YpIcej5nxApq+ICfMU0uochUt1ibxud/nzZydJjaGXsD+tYSBbAktP2MF
         xWTA==
X-Forwarded-Encrypted: i=1; AJvYcCU2dYBjRpfNUCBz9EYt1Repk54mYpDxz0lFYya2ydGEqnjVEjSvVZwIhSkv7l1lvAZ9nINV0tGfqlEO@vger.kernel.org, AJvYcCUwAvgKWbgsd3RiVGCN6hjfx85RKJhQMu+7YPZUJ7jWn4PBFVaRgYI5OhZ5TnbedKmQzLln9xcrTmTeKyHI@vger.kernel.org, AJvYcCVHyOD8ivQ7AVk4/G+0OpqPRSjRFpLUg3fdODcIbLkYI/aC/eMPPbOVJgiTqUtuAB4prH6rVynhxLx7@vger.kernel.org
X-Gm-Message-State: AOJu0YwM682tV0Ac9IKgq2hAh8lITNGzZ51/i46UR7DzGXlmhsgxZdcL
	3K/PIfv9N3dPDG1xaNtkpMfJnzHQ2pEWVny8R99arqLi4UihL8UzS0Wsc/PU
X-Google-Smtp-Source: AGHT+IG7p0WnjbRxn0Qrk5yGfK//kB9E2+iJMfmbxwBj0xq25RtCAzhdKzlyComxlKzYmhWaK1nu0A==
X-Received: by 2002:a05:6214:3110:b0:6c5:13f0:2408 with SMTP id 6a1803df08f44-6c513f02bf9mr78599026d6.14.1725540310219;
        Thu, 05 Sep 2024 05:45:10 -0700 (PDT)
Received: from localhost.localdomain (140.sub-174-193-1.myvzw.com. [174.193.1.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c52041a00csm7161116d6.114.2024.09.05.05.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:45:09 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: christophe.jaillet@wanadoo.fr,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v6 0/2] Add driver for Sharp Memory LCD
Date: Thu,  5 Sep 2024 08:43:58 -0400
Message-ID: <20240905124432.834831-1-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
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
 drivers/gpu/drm/tiny/sharp-memory.c           | 682 ++++++++++++++++++
 5 files changed, 801 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
 create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c

-- 
2.46.0


