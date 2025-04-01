Return-Path: <linux-pwm+bounces-5315-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82BDA778D0
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 12:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7247716A294
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196921F0E2C;
	Tue,  1 Apr 2025 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bVX2faVZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78136DF60
	for <linux-pwm@vger.kernel.org>; Tue,  1 Apr 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503366; cv=none; b=dXAqTJvQ0ze7YakO/jG9SDWeS0sugP0znXevqr0nAzHgt6MEMBLZaOvmFa31qjSVeAOxss0PjzStasdS//9TBc4xznDlWg6ySiA49yz962NagwPSYJZF9FziFnNHX9XnhmpZ5SJ3G5e9LdYwMrsxf5cgodRR8QdaQKK/9e3BGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503366; c=relaxed/simple;
	bh=k35u2EHomx5KhPtDUzNnrpfLz4tm2XgwgswH3kk6XHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YPOFtExH5E/mEKKkoTrkWI94AE+i0k1zfwoCu8/bLCqUdUeX3Jz2o8wFCSne9gPIuHoHULqjkI20X4Ee38kFXc6bTnVwTFqCbQRLbciwGEx7hxoPjtemk8F4cnpDm0uUNzTCX5RGhGNVDQ74TXHMc0DplQZomU81D55kLVyLvQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bVX2faVZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394036c0efso35870065e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 01 Apr 2025 03:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743503362; x=1744108162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0PfzpCMr5r3+GX/b1ckWGTmdB14j6hf4mNGcJLZXjI=;
        b=bVX2faVZCeIiUHiwoMOK7OSOgCP2SdDvrP5wglJ7KfxY8C/CKMTEy7bYDC9t/5CXox
         /fohVHNMYBg4hPOeeht7Q8TYZttxZh/HXE71E0tAifCuwW3ztQtOAGfNxC5uLyHjsBsX
         WWneGkXGwYx4EIoBahEl8AkWr7dh6jA8G5lGVEdbcgVjpOdwGXE5G6uOnHlEVga3aSwr
         wgDdKBNv6bGDKtuuRfGT5I5h4iz8ZlRvgs6lvBEO0w/x6HfrBs8qnWvGMBXWnYgFM9sJ
         jqtarURPR1w6B69euBCV8B50KWFoqBDNwdCdvNUrXoeYebbRM2EmEOhyCJYrj+xJOs+1
         zaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743503362; x=1744108162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0PfzpCMr5r3+GX/b1ckWGTmdB14j6hf4mNGcJLZXjI=;
        b=pr5BiZDSAnCcfhx0GQTlWzcDP2kgr2W68nWE32TAlSRDOTz4JjXZtdDhp8YFqVPdxK
         rCr+VmYtHIJCtO6/84Qtw4T1E3XXXuI4isbzY/RtP7lGK0+6ln4MSszyJzvfKnN1xKzu
         9EWmqW2TrdTw5KqHrFC+wizSwmPMJvPRliyxyIEPSSvaweu7Cmeqc0P4nv1YBB6ISJxm
         KtTvS1IydDZLqzaJkWlEjEIY5we7Xbnh8OUKGG6AT7+nSSVwyUEhhCVbkW9wkrch12dC
         o0y9GwmoVsg0odTop+6ARBGjtRZNaUjzfo2roJ5FjyFhMcgmofsXB6jmzMXDeUbenKoT
         vZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCUq+tnrGhq+s0w1c3LEcXdrMjFZjPjj13rWoE4/vijdPOA9glpthjcGGJvU7rvB4EPu4d0TF9vWCEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf0lALRxyU6DeC3cZofVwj3cQvXu0ekzCkjUj6o5/cKjcAlIjq
	1pvpW8CYXJ4mG75/teScHHpg46+6xfvIq0MIifXAUTy6v9B9EhULgUcYL67vrXnDK+WE4IelaFd
	M
X-Gm-Gg: ASbGnctXjlpmF6bKALRHECoc1F245f1qz21je5RMB7vG+nMsQXzMnjcDR8ka2ZHYofz
	xdVbI4v779SXlJvPb2YPC7txJdhqyv+QKL9+p0TpoudjmMjMQSs1dC0uXm/yFzuoMMr36Gt4UpX
	mUJHdw9b+eMiKodCat9ylCx8j0/m2KIjzkGlJpIuXBSR/5hM9tvoq8kk1Zxh0j685FdiavwJMzk
	+I4EmXHtKNpMw4sLJv1Y0wVTIner/0Q5VIbyQJiGx4VdXAVxp5QYBoLAkO3IxLHU3c67W4lGuxK
	jiJ72rj35/pWiUSX0rFB2MWcy7Z/99MyzDjlpTsf6GEGBUtFytfJ+SDg8M5vO0u41d07+ig9vtk
	5bzZpezJWcBE=
X-Google-Smtp-Source: AGHT+IGN/8xtmvsR7BrUAKwR9bwciAz3ATDbeXewiQ0x0Dm4mfRj6ANi/gUvbdb/jQ4tFiVRD9OXlA==
X-Received: by 2002:a05:600c:470f:b0:43c:fc04:6d34 with SMTP id 5b1f17b1804b1-43db628b92fmr101141745e9.20.1743503361776;
        Tue, 01 Apr 2025 03:29:21 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b79e097sm13519539f8f.80.2025.04.01.03.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:29:21 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Patrick Havelange <patrick.havelange@essensium.com>,
	John Crispin <john@phrozen.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 0/3] pwm: Fix division by 0 issues
Date: Tue,  1 Apr 2025 12:28:58 +0200
Message-ID: <cover.1743501688.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=k35u2EHomx5KhPtDUzNnrpfLz4tm2XgwgswH3kk6XHQ=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvTX+19/r5C6V2VsrFdyu6nCI97D7WLUi7BiU3a9cP9PY sm++1I6GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZjIrlb2f2YFmhpltmbrfn6N qvb/tTlRo4737k99bQf1P8u8V7J9kehXm7L/umDdQ43AMIlGE73uss372p/+/3xYVyiw+C/b2di UqqTOArf7XkH1HxT67VtPLitWu7XZ/6/x1d3Pt7fU8uaxFfz+/X41e3a2TumEQxEnfkyWW74vVf ymQcjsmfrquh4FkhUpr26rVfo3PNKYnzO1vaFxC4ebwe3i1cypO65c5b712+Z3ZvjDhsePVU/Ft P/Z87Rkw6RDpqetCkv7wwINGfrScwJ3nusvV/0ZrayjyV9lt2baZNPtzhcU/4rPMn85v372apnH x9Yej2FTTXhz2ag/8dylgM+51d2dH488YnT/s/W/W40tAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

triggered by Josh Poimboeuf's patch to fix a warning by objtool due to a
division by zero in the pwm-mediatek driver, I reviewed all pwm drivers
for similar issues.

Josh's patch is resent here, the two additional patches are new. objtool
didn't warn about these even though these are quite similar divisions by
zero. I didn't debug why these were not catched by clang/objtool.

I haven't made up my mind yet if I'll send them for inclusion in
6.15 given that they are new and only build-tested so far. Also the
commits that introduced these problems are already old (v4.12-rc1,
v4.4-rc1 and v5.3-rc1 respectively) and there is no indication this
problem triggers on real hardware.

I'll put them in my for-next branch anyhow for wider exposure. I happily
accept test reports to (hopefully) increase my confidence in these
patches.

Best regards
Uwe

Josh Poimboeuf (1):
  pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()

Uwe Kleine-König (2):
  pwm: rcar: Improve register calculation
  pwm: fsl-ftm: Handle clk_get_rate() returning 0

 drivers/pwm/pwm-fsl-ftm.c  |  6 ++++++
 drivers/pwm/pwm-mediatek.c |  8 ++++++--
 drivers/pwm/pwm-rcar.c     | 23 ++++++++++++-----------
 3 files changed, 24 insertions(+), 13 deletions(-)


base-commit: 6df320abbb40654085d7258de33d78481e93ac8d
-- 
2.47.2

