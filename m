Return-Path: <linux-pwm+bounces-2210-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D351D8CB46D
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 21:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763481F23053
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 19:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826D11494A2;
	Tue, 21 May 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NGK0mFdV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA4B50A6C
	for <linux-pwm@vger.kernel.org>; Tue, 21 May 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320962; cv=none; b=J6fJ3/yy94TweneoDvZAs7tSza4XaemROZZoQL1700ITp3ab+b8z9SDD/xBDaMpP6qzKHw2C4k3tJR9vhAylnx8Bx2HSrSnlvh2nSE5N3DGiFD9jvEJ/Qyd3lXt35/6W9kuprm/utKNf3qNWskFKKCKWHu764fFxHNaOLot+2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320962; c=relaxed/simple;
	bh=/k9i+bfVHQ5K3f/3wFoNG5mKxEPQIrinng8NftWO7uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVje/8IAX7iDA6zH2ayjgUwXUsWaMkQvW/B7E1Y5lzCMMvYzvZL0nHCOzOI5Mexu8WSzNfjRu2TZhUPGdCG48pWa3UU5SWJ7ywAhaOlCgU0ZrH8NQCpvzCFb6WLhk0KLuUh1hlZN16JWOyL3dK09bxrMd0hXqb/Y2otjFWj93S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NGK0mFdV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-792bf1a4f75so378846285a.2
        for <linux-pwm@vger.kernel.org>; Tue, 21 May 2024 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716320958; x=1716925758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Omfjln/bi5kI4Iv+VFCzVDHJ4DQuTKFJqorBA/dp30=;
        b=NGK0mFdVmX7ocouW8/mnvxK23K1NNx26fmGEj5RNcMDJtmfZa2GD7tTHlbyLDlmSNv
         bTM3zcqcYiFnFSo0MmgcWqOhgFSQXfXSRMWeAaskcruSAL0wuew37EVpBQbOF8Exvj1m
         FUjRaDW6ob/imo8efxV0AIqqriNYlQsOqZVAgObfK47ivh+IpKLP+3BkF5zvZQurzSr4
         sgIDif5mXWgN1FVpw513qw5FkcCRN5FW7716s/jxSxTt/L3XtdC51Tq4TfOTnm6f1xYk
         yeVyjxjG3+igwdIxRF8RTvPUMG4FZnQmHYc7iogRQpMsvZGldya9ToP58KWF5eSqjE0G
         YcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716320958; x=1716925758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Omfjln/bi5kI4Iv+VFCzVDHJ4DQuTKFJqorBA/dp30=;
        b=GduB3Aj1oekAQHl6UAtShhabJAYCEbmsLW/VR2demxhq5B4CBZ3AOw5n3VsWqHj5PE
         ivKlNUzhA48Ki+mSTgIGUbbeI0Euh8tXdHUMYeCqGBJ/1q0gWBXAWZBp4rzdVFdjiG9T
         +jDLGugqHqRUJ04pzZCHo0MevPBnO7QG91EwFNDqn90oytX3+/hWmQGXSO/fwPGoVloi
         qX41CvbJPUsR9nOuu8PgHeLH38TbjcUXcQyBzjjaHrhn8cFkEL0fn2YdHTuYHSe0BSjk
         mvo1+21V9hcgFWtn/PwAHyWyKk3OZrqr+NI4Ns5cF8LjhXiqVytFOckMiM6fntEZ7JWa
         ByYA==
X-Gm-Message-State: AOJu0Yy0VQfn+pMwAJ89zhRozZtSOsH+vt6huUYr0OeAneMv9cuOCi3U
	hSwrIJFUpesQyr3J7Nfw6GWCgQXhYmIiv+JLvWphd3Cz99OgVzg30olawJhB0ZOCzsj8Vx/BM1j
	h
X-Google-Smtp-Source: AGHT+IHc4cDmfckFWlq+FyC07M3DyfM4aXioOiHBE6E7Qe1Oh791SLEDE6cXopgwbpDJ02CqXuS3lQ==
X-Received: by 2002:a05:620a:4610:b0:793:343:6dba with SMTP id af79cd13be357-79303437183mr2084584485a.2.1716320958445;
        Tue, 21 May 2024 12:49:18 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54d85a0sm161723611cf.23.2024.05.21.12.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:49:18 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [PATCH 0/2 v3] pwm: add support for duty_offset
Date: Tue, 21 May 2024 15:49:14 -0400
Message-ID: <20240521194916.1897909-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the PWM subsystem to support the duty_offset feature
found on some PWM devices. It includes a patch to enable this feature
for the axi-pwmgen driver, which can also serve as an example of how to
implement it for other devices.

The series was tested on actual hardware using a Zedboard. An
oscilloscope was used to validate that the generated PWM signals matched
the requested ones. 

Note that in addition to the other patches in this series, the changes
to the axi-pwmgen driver rely on [1], which hasn't been picked up yet.

[1] https://lore.kernel.org/linux-pwm/20240424125850.4189116-1-tgamblin@baylibre.com/

---
v3 changes:
* rebased on top of latest pwm/for-next
* removed changes related to cdev to match current pwm tree
* fixed minor whitespace issue caught by checkpatch

Link to v2: https://lore.kernel.org/linux-pwm/20240409174126.1296318-1-tgamblin@baylibre.com/

v2 changes:
* Address feedback for driver in v1:
  * Remove supports_offset flag in pwm_chip struct, and references to it
    in the axi-pwmgen driver patch
  * Drop pwm_config_full patch entirely
  * Don't return EINVAL when state->duty_offset + state->duty_cycle >
    state->period in __pwm_apply(), since this is valid as long as
    neither is greater than state->period on its own
  * Add a check to disallow setting the PWM signal as inverse and a
    nonzero duty_offset at the same time in __pwm_apply(), with a
    comment explaining why

Link to v1 (RFC): https://lore.kernel.org/linux-pwm/20240405003025.739603-1-tgamblin@baylibre.com/

Trevor Gamblin (2):
  pwm: add duty offset support
  pwm: axi-pwmgen: add duty offset support

 drivers/pwm/core.c           | 79 +++++++++++++++++++++++++++++++++---
 drivers/pwm/pwm-axi-pwmgen.c | 20 ++++++++-
 include/linux/pwm.h          | 15 +++++++
 include/trace/events/pwm.h   |  6 ++-
 4 files changed, 112 insertions(+), 8 deletions(-)

-- 
2.45.1


