Return-Path: <linux-pwm+bounces-3346-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D68B97EF1C
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 18:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E7C280F5B
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A87519E99C;
	Mon, 23 Sep 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTYLubTj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA32E823AC;
	Mon, 23 Sep 2024 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108558; cv=none; b=G3TjQ42QbagDSUMe8iE+WbhtZAGN4IY553wG1tfPwHB+h9yB2C1908sQ/00VYLSH+BHCvdj8N8xHf75k83rRpd/x9Oy3KN0EvGq4JAA4ULmVxDQVyXHsZXtBQIOE6R9xfMe4ynuDFKJdXE9AVkWfSrXQXmLKZVZrDq0QO7GeTpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108558; c=relaxed/simple;
	bh=VdkM75IQkxU7Lpd/F13lYAcYe/ObislY5V39DVe3lPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1RONPSfQNf1kRv7Fe//d9TsO1Sq3nLkpqT4nb9EwETC4/5lGWRbJRZL1MQduFhKSCclkJZvBuVsiN/jroxE90lA/JqbVeH2hDDNbXT9y9F035aEtFS9TP8JXhnBRg1LMAEKhURXwME3/xBu4X2jccDzf5lV/O396E5mYiGkt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTYLubTj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45821ebb4e6so36354711cf.2;
        Mon, 23 Sep 2024 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727108556; x=1727713356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xMAjUDxOyknWcICNvHoeRR5xLaaisNjKFQiCg/h7w/8=;
        b=jTYLubTjbnmldzO9E53MWvqB8r5o6t4M+pSfAZIPk0PS8gOXzAttLzz+MSYudhUQim
         VnlP5gMFqeJcvM0C1NvsUx/etqFQ+UaptSVMDDT1O902e0709x5Rrh5qOQrUH4CgVZY+
         iGHGuHlOHniCfV6e0aEhMEBqaK7RE23FUYTmzRkUgTvGKCiRVlbUTBjIiFF1O3bO9br2
         aizgaqu/QT+JpQ7eNBx40+MWrFmBn5fdYaBllsuivvLWV/qYwNNQay0ECSkM0wXgxJT7
         TmGpPbb/Zkxs2cy8gh/g0PakVHL1oXnSaV5WRIj9XuqH6VN03ZmNrcDoEJvCx8jPr/mZ
         /PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108556; x=1727713356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMAjUDxOyknWcICNvHoeRR5xLaaisNjKFQiCg/h7w/8=;
        b=Go61KG1eM/TZoDzac4C818immqCmgf7DE6qT9OsM1kv3vZ6Qcy6Sw2EzQywFQtYnhd
         9NoyrfZsiyD+UkbJ4th+fuoKcILXM+sc29LudHV3qN9DUESrG4H/Zdq2OZ8pzS5jDNIZ
         HGhSUSoBFb0JzXedB8cbFn1H1rhI5mZOFUJZnJquu3/rT7cduTiNIbSz8e/Ktn3e63j6
         RK2m7Hh7S8UrtIRIenNClKQu36KuDRU4qUjlWgtTAeTlFS+o3WDP2EPvIOnj1Fig9Izu
         hs8qcZVG5Lvl6wZ2lJPzR/vFaLLc7I4qmMxh67MtqlQAoRp7DPQY9g0k2UyK61/6IIqh
         6Heg==
X-Forwarded-Encrypted: i=1; AJvYcCVGMOQY3aMi4Lm3RTYDTCPw+w+fZ8BfdDM3LzFL+P1ZvbifsKzgSwdhLP1qaSYsn6g9eBe9JPq3//fJ@vger.kernel.org, AJvYcCWkhmr7qW7KguJHxBD0vn8/zj+SQ7JqVI9rtXS7W90plJAAQmdEwC3FX+G+hR0WeX5UCzQK8hZxklKNfM4S@vger.kernel.org, AJvYcCXxKa7JizGb+dhJGDXOTF7m2/xMiS8hNCgKgNAamQ3Fe2l+rmn2ws6dK8Zbf+IzhdpjSq9qb79hNQe5@vger.kernel.org
X-Gm-Message-State: AOJu0YwI3Dvxj08nswBwRTBFbw7PvDlEgVLil5CLdxBBcotogZO3ztxe
	5CifeRx9yZ/Tjki9zYsTI3+8C4AboDGLCYc6ejrCvJZ/x4EOifc3
X-Google-Smtp-Source: AGHT+IFCJxsI00ZrQnDdvugyIqeqvv9DQpGecgLpiot6gq0UD9k6CQSR8jxNdqQlbuJjiZbrcWW3uQ==
X-Received: by 2002:ac8:5d4a:0:b0:456:61f0:810d with SMTP id d75a77b69052e-45b226d1230mr220772381cf.10.1727108555440;
        Mon, 23 Sep 2024 09:22:35 -0700 (PDT)
Received: from VM-Arch.gst.l3harris.com ([208.127.73.102])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b17867fb0sm48587901cf.1.2024.09.23.09.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:22:34 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: dmitry.baryshkov@linaro.org,
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
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	christophe.jaillet@wanadoo.fr,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v7 0/2] Add driver for Sharp Memory LCD
Date: Mon, 23 Sep 2024 12:21:33 -0400
Message-ID: <20240923162205.55658-1-lanzano.alex@gmail.com>
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
 drivers/gpu/drm/tiny/sharp-memory.c           | 682 ++++++++++++++++++
 5 files changed, 801 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
 create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c

-- 
2.46.0


