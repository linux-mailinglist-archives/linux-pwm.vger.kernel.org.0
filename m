Return-Path: <linux-pwm+bounces-2446-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880169085B6
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 10:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108F02898D1
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 08:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADB314D29B;
	Fri, 14 Jun 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uf49o4YU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BCE1487E7
	for <linux-pwm@vger.kernel.org>; Fri, 14 Jun 2024 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352643; cv=none; b=TZdCu2WqMcobqdCzAWq/hU8xzemk6y/oUOU0I37AZqJt4qG9SIGKwta0cdPIFYoGWLIhb4vC3h+MQsAw3sCM1fOtCAoKH52/th2UxVYw7N/DzfasCwU6VV1MJd1W39BTXJlQT77KYXi3N/94ZKlYi9TWYcmT+rj8AeZAHlQwUR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352643; c=relaxed/simple;
	bh=XtY06yQNqFNmqjsRt6dtXpp7Ga45DKbLPLwoxJXu+Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NJVUaZSGY99E1uIgmKyTis6lUPK+j9zDbErcdV2JlLk3KDTEB956axAetgY9OXcSYKlffSRrUikT6CVTelMs67FhdrpwEP2+J51xRFzEGJF1D6qpGFxUhkpoma5hs+7JVZoQeE90y/GpRAY64onfi/UpNR5gmkpn/8xyfJ2XVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uf49o4YU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00b97so409470a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jun 2024 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718352639; x=1718957439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dQuauHWW6Nhu7VIVhyecgZ9pWHe1Gm4RQ6VrtSN+/jk=;
        b=uf49o4YUdtYRC1cuqd6I16NAWak3ezlI4cAE146EJbpl/BVrXJeSgOFS62OQQVW50x
         gebiV6kpFAZsaJHGU9oXcqXKlxSxvC3ZS8sJURtvAp3gDbDbhxuYxJBM1f3w7wSrpLEU
         Pf7foYSk0RMA4zsQqIjlJrsd2Q+eep0myrxeot6iMIP/8tkKTsbsc+PpTbHRLNCr161Q
         rlYElRqPr8Yl/D78q5OE7kPADRdLxtXnHqiGbfmgvTm11h/3SDaqPrWUJ8r0D2pCBsIw
         R4TWlyLn7s0WcMxaewb6eZRli6ob7eyNGrcsNZp6DMX+m4lNJd5VSsfeqOAYDLU2JTpJ
         sVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352639; x=1718957439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQuauHWW6Nhu7VIVhyecgZ9pWHe1Gm4RQ6VrtSN+/jk=;
        b=LaRElavf0KmZ7VZTCcswtOs2WippUAyIXwEgrrLgHtTAYaw/hjRhKxXQkGr+4eK0l7
         iiEV610p0QCiWiOAVjGz41Q7gJmnZ9ymZpq2pHvSqdZIT23I/jqZyApTqdJEpeoTBsLr
         kC+97CMGVmBvclGAPA/012RPLfWo/elUiWNLHxrjk4sKSi233o/DKnpr2YVrcYJhwWk8
         Ebu8gLzUI6XZvqkPYnwKbI3YTUACZRqMLWcdJX5QcfjnmfVl+alE0K2THI/qTH3kv8+z
         Qr9Q8hjfQwcyUcSd9HTIfh77PMAz7zyLG6IUux17KJzOlknEx0YvgUHbdVUYzhDdQ6zt
         Npjg==
X-Forwarded-Encrypted: i=1; AJvYcCWVj+5vSWDOQVxJ7cPXN/fvhe7d58bsrMQpnYAJVn4mPMza34gL01C2cJb3W0gdyGCrEI4qWFsJRxf5AkD/SG/ZU30OqNHSn+pf
X-Gm-Message-State: AOJu0Yx3BJVCmQKWlPvO/r/bdwcYHoLLivF7b8CA/4jAcjEsp3t7HwUq
	xr37UTAe8bmRO+3J72EgWhGjompxE8HUw+3hcaUVgs73rsaDb1DkExeY+PhcX4k=
X-Google-Smtp-Source: AGHT+IG4iAQVA130APkrQA/MPvG/bMQvQuYj4vQDeEupKxmjnm9Px/TgUM87w6xgfYjGLI7F60ewqw==
X-Received: by 2002:a17:906:138c:b0:a6f:2e28:4008 with SMTP id a640c23a62f3a-a6f60dc572cmr131844766b.54.1718352639612;
        Fri, 14 Jun 2024 01:10:39 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f988f9sm156627466b.197.2024.06.14.01.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:10:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mfd: stm32-timers: Make register definition more flexible
Date: Fri, 14 Jun 2024 10:10:10 +0200
Message-ID: <cover.1718352022.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=XtY06yQNqFNmqjsRt6dtXpp7Ga45DKbLPLwoxJXu+Kk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrTsX48f8qn9z6i3nvpq/lb/5wZuPQ5SHKzvz7qb9x8N2 OCYfYOpk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJSDBwMLTPlr2rVuUWNW+2 8t08vd2+dll7nn3JkzF4Uy+rPeVf0M0809/RBawrGJvKSvns6tS/l9gtbbgc/kcqjSnUaFKfDqP Lyikbf8Q+cd4sc/8VpyO7nf6mCX3zZkmYd3JJcxUocLjd4ngeHHTF2k28TLBdnf1JqfCj7L6mZv eEMxyTZpsHa6crfLSOuXp/6aFG5Yu+86r+GGfnrlh3145Jt/6gPXeju/zea76OlX3TZz1PNdj8N v9Eef4cFrkH27ffUTmXuH1vs3MN48tVeY8P7u15pW5/Lo7Hu8jgzJ6D1p7zP24JmNPb2KXcVDwp k/nZZ9N1mxmeeWj4sNi1H3nva3+p5aDdXJemjzuuF3MCAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

I'm not sure that everyone will agree the changes in here are
worthwhile, but I like them. One surprise is that this makes the
generated code for drivers/pwm/pwm-stm32.c more compact (see patch 4 for
a bloat-o-meter statistic). I'm surprised because it boils down to gcc
not noticing that

	mask = ((((1UL))) << (1 + 4 * ((1) - 1))) << (ch * 4);

is equivalent to

	mask = ((((1UL))) << (1 + 4 * ((ch + 1) - 1)));

.

I'm unsure what to suggest for how to merge this series. I have some
further changes on my agenda to drivers/pwm/pwm-stm32.c, so either
merging this via pwm or a stable branch would be great for me.

Best regards
Uwe

Uwe Kleine-König (4):
  mfd: stm32-timers: Unify alignment of register definition
  mfd: stm32-timers: Add some register definitions with a parameter
  mfd: stm32-timers: Drop TIM_DIER_CC_IE(x) in favour of
    TIM_DIER_CCxIE(x)
  pwm-stm32: Make use of parametrised register definitions

 drivers/counter/stm32-timer-cnt.c |   4 +-
 drivers/pwm/pwm-stm32.c           |  22 ++--
 include/linux/mfd/stm32-timers.h  | 179 ++++++++++++++++--------------
 3 files changed, 107 insertions(+), 98 deletions(-)

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.43.0


