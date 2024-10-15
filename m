Return-Path: <linux-pwm+bounces-3662-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F899FC09
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 01:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644921C23AF2
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 23:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95DD18A6D8;
	Tue, 15 Oct 2024 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1KyWrNg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D521E3C3;
	Tue, 15 Oct 2024 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033594; cv=none; b=ZwXEtdTb2Eoih/1ZWcpQBcm9t+Df8Dm3x1oFEpeypfSyWXrPHVX0N/FV+v7PZ0i0aBro5AV9WviglH3LxtwPyQ1cqLEjnBXGJiqKVHcOJ17d31tZJko/UOge2Y1hZJa0lzz3RVnPxhmU/AKUb9iYSdPa6lEbMEbgKgGOUuh1Y4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033594; c=relaxed/simple;
	bh=c1cFwrRSKEj8jKOSk9WgJ/l04JHjabgqH6wMKYWXjGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e2we8PrOyLhr/m+RLY+2iiU5A209Pj1kTZvfA0yKzcnKcJivQa7eun0eFVtxBYaWCOLPNsDQCwGeGElN4qKxKFTXmANtz/sEu8XVCYyc86YHHv8/YT4bycjYAPosExb0GdLOLgcQwRJqtRMnZt/xO2Mg/j4qZVon9pDE63UlvF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1KyWrNg; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4603b835a1cso57098401cf.0;
        Tue, 15 Oct 2024 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729033592; x=1729638392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfFZUPp0XV4kx5ltz6qNvKwXCzwJIgOrmeDZF/8jtLo=;
        b=Q1KyWrNgCaqkcsM3yWDpsCDQPGWu7W1QmiAfjnzAzdU9RgoDPhGlCSjdQZpXJsPI9u
         3f6c+bdlkCUWxGo3tUeieGHTd/3BCZ756VjyY40NZoYVYEAWj+pgqtf0KPFedP4eejQ7
         BsrjpomyhtIkxrmxtiEc6+bZ8pmhVa96O/AG7x4fjyldQdB3o70ITXgLsSzyxljvVWAZ
         /Yt/qQ62tDxw5Yw1HlY8rnnd0z2bl0HzzeAfwiPQh64D+Kb8TsIqVQ8OnBt522wgz50y
         qdqHJu6Gz7keRzaCNIjRXzZ6+hz0MgcgjYahmuukfklfMJaNie7l8rOiwaqjHwRsAYXg
         xiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729033592; x=1729638392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfFZUPp0XV4kx5ltz6qNvKwXCzwJIgOrmeDZF/8jtLo=;
        b=BaYhvjtUUjXeKGGSSYi0dIDLcMzfp0GOzJp1O8+KtxxLdTTDEBKlHLNVX865up+A77
         WLgdxlBRi7jklTJyapw2kgLkWwr9eFm6WK8FWwHiS3xjRV1XCrkb6vvPGP37L4fUSM0/
         LvDIwx0THF4MH3Ar2HRybgmWxge8qmIup78h6WQlBsrlvMcFPm9r2AIgwjeeeQPOgr+I
         z2RF0WgxkCkfLi8F76/l7No8+HE28N+qXJa1eevHnpnoTEfJr1HD9OGfR4pP26rtZrr8
         Mpirtjp9JnzZkkqUJL77ikn5kKwL9bYFkNU5x4nTr1OGzYbHpflZ5OrwA6jDOCiYbOGt
         s9NA==
X-Forwarded-Encrypted: i=1; AJvYcCU4N7H0qxushOEjvCz7XRXkZUU6L2MkQfKygKTpsqPenLQwTsyXMKDlMqp9OMKYYt7C0kIbBUgun+Ry@vger.kernel.org, AJvYcCVrYSIBeH9vXaRlhKAya9/e5ai1mZ24SUi69bohwPUM3x3QwYJGl3XNJVAnzqZ79ogn55lNtvqYeeYH@vger.kernel.org, AJvYcCW+IqWq+lTVBf4sHltCjtqhmV6UaPcPnj50Vv2m36eLX6ejD4U73s8n6R7P10+ykDTlK3lIit6+nCqaplsn@vger.kernel.org
X-Gm-Message-State: AOJu0YwopJxW6KhQF9wehINNyzYAde13BQG+La3pGJ4gakpn6Zd8SobX
	MDQg+mzndkJUcNOJOhN02phLMweeum/Sv00D8lvsB8x1QIt3YZxP
X-Google-Smtp-Source: AGHT+IHQmnfERjVbgde4xoS7Xg3Nee7eeqn8iqFraPmTdAJTJEW9Gmg9baMjNSv4pjmJ+IhQhYfR1A==
X-Received: by 2002:a05:622a:1aa6:b0:458:34df:1e6a with SMTP id d75a77b69052e-4608a515378mr29032821cf.48.1729033591775;
        Tue, 15 Oct 2024 16:06:31 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0e407esm11224641cf.27.2024.10.15.16.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 16:06:30 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: u.kleine-koenig@baylibre.com,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	David Lechner <david@lechnology.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v11 0/2] Add driver for Sharp Memory LCD
Date: Tue, 15 Oct 2024 19:05:42 -0400
Message-ID: <20241015230617.3020230-1-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Changes in v11:
- Replace drm_fbdev_dma_setup with new drm_client_setup interface

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
 drivers/gpu/drm/tiny/Kconfig                  |  21 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/sharp-memory.c           | 671 ++++++++++++++++++
 5 files changed, 791 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
 create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c

-- 
2.47.0


