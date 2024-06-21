Return-Path: <linux-pwm+bounces-2582-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BAB9127FE
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2024 16:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33D91C25A8E
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2024 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D252A374C3;
	Fri, 21 Jun 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D/9BwsFU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F02C6BB
	for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980663; cv=none; b=c9qYxCjwFaBgGNy57DvGXkd4txT+kHDpZYF1SEQnG2H8TDfGI2EGbjWVkXvGL0N0pX/JQxb1KX3c9I98cJiGEL4CnLiLXpZLbbA8zpIDUxWkJ/c6EuPYoH5qy9LcQvPqGYLWnZBsB0OOd0+g6AlUcqAGVvOe8gO2Iv+KJZKIgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980663; c=relaxed/simple;
	bh=2s2QMeRsz59n4HUKQa1LkEGYXgnYnEKBgDahMGwGihs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iGbb2zUugCNqJ8lSfspTuQ51HKVORoe+wSIt9iRZmsu8xbJlwVcrqTpRVaxRbw9pVg4381CEgsU93EmxHjfoFTkTduO1dL6SbdQBVsHZcBIwO3A8zAmV5aJFHMDUnu+BjrlcR1O0UX3iFDqFnUM8Gb6NOjXnx6c8XzbDnJidYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D/9BwsFU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d044aa5beso2338332a12.2
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2024 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718980659; x=1719585459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sCbJNOTuJGsqKdB7zNbbdfijNKNOI3FnRNRi5W5pqIQ=;
        b=D/9BwsFUqtETt2SlHVDIw7HJDQsoMUZpdK12ScWscGKTifkkni4DHSVBYxo4crqBg5
         wpAJfMnqIr5087kIwBVQVNlzZD7rwVWzvpWq8iawoi9en4JOVNYFp65+gOPx4vBCznZJ
         3/T8Fb75VPdSMsHRVDSpchVjpgDkcKMqRW8RM0m51YzNgkcTIb+aiZ+YE02p3lA7lpgb
         S9VdiNVQOi8uVlkMSG+p5kRpsn+5dNPfRsflPhVeZNCRFC0mmYo8NrwZX21nb6IGJfkG
         5iV0oeXvF0FZtntZyBH6zSJDq34Fyomfq95EUcO7dF4jv5W4Pkl2wH8+4n8OctonAQWi
         w7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980659; x=1719585459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCbJNOTuJGsqKdB7zNbbdfijNKNOI3FnRNRi5W5pqIQ=;
        b=gFFZezv85exXg9z/PveKvLOwW61Su6jeNusaTz4DLGO2sLiKfgeAk+D9zMy4KZ+wal
         9E/a1F0iw7S5AEg+w/zwVDNfEy3GfJMDec3tHZlbaLxJkai3uVzvSxa7G4qm99ZTqng/
         JjRy3LAL9vJw/55UUhMoQqXuZkgcREwvtaycJRnERxYmtNCPoij5uOGywZBtCcsO/bSB
         YPVQz/dGMdbYoVEpCBmeca9Lscxb5+PNiD6ZtT0e0uCFky7L/SCNyS33kh8H1dH5Lm98
         HR876u03KIbyn3Jo8n1+V4ipeH1UMaXmhsaxC5SXRdSKyOXcjlmSOI76tZMmeYYXMnS3
         8fFA==
X-Gm-Message-State: AOJu0YzNxmSRG9IsWvqxKLxJ2aQZomUQE48WfEwk7l3ygWsp0Y+53l/i
	nVapkSkLRmOsLO+krneJMBdp9KBT2uaq2VKiUqibXt0OCf1oWrQ7oD6cVq/AVqI=
X-Google-Smtp-Source: AGHT+IGj+a5jR9jmqLTqTUfmbBqHYLSyfqY+3cZmxYKiY8quiqSK3c+KV6fBId1CTMhvmSdp7zLT5A==
X-Received: by 2002:a50:d60b:0:b0:57c:9ccd:c626 with SMTP id 4fb4d7f45d1cf-57d07ebe975mr5731033a12.39.1718980658914;
        Fri, 21 Jun 2024 07:37:38 -0700 (PDT)
Received: from localhost (p5091583d.dip0.t-ipconnect.de. [80.145.88.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042d2d0sm1020881a12.41.2024.06.21.07.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:37:38 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 0/3] pwm: stm32: Three fixes
Date: Fri, 21 Jun 2024 16:37:11 +0200
Message-ID: <cover.1718979150.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2071; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=2s2QMeRsz59n4HUKQa1LkEGYXgnYnEKBgDahMGwGihs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmdZAYvhSvoLAkKPad0LU83EOCUebiVuN7fzmCa r6nzz22pAqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnWQGAAKCRCPgPtYfRL+ TjVAB/9K/UDQBSIaQ/z44a28qmTh8/ejQ1KhruJna+3pbACeUiHNQ0j9e2dQ2F1lhI+0bJlbh5L sqPK7tbTCBm+Qb4rq8M0XTBxlpFVywDWMyCnkwzkRBd6QaDMJP7nPHrS89Ym5kmah0FXF6X2dB1 FaxENqn4dqfKIOvylAq+0MbD3FsOcQQdssfDN0Kij9VKtGXmt1leVRaSD4QmT9ihTWjSpwalkNP HVbCdRQVQRuEZhexX18oy36Kl5kownOxOij7RqIsSWLmFEidg2bhkUeCeeJ1OPZqU07TgPKFRCh oGIIbMTv0vtC9gAmdWOnCNhCVDwWYs/PGDAfWp5cefuUsj9o
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series contains two fixes for the .apply() callback and a trivial
change to fix an error message in probe.

(Implicit) v1 can be found at
https://lore.kernel.org/linux-pwm/cover.1718788826.git.u.kleine-koenig@baylibre.com
Changes since then:

 - Improve working of the commit log of patch #2 (as noticed by myself
   after submission of v1)
 - Drop Cc: stable on patch #2, as the faulty commit isn't in a release
   yet.
 - patch #3 is new (but was sent out already separately)
 - Fix .apply in patch #2 for some more corner cases.
 - Added Trevor's Reviewed-by for patch #1. (I didn't apply it to patch
   #2 as this changed since then.)

The issue in patch #2 was found with CONFIG_PWM_DEBUG enabled. The
problematic setting was period = 941244 ns with input clk rate =
208877930 Hz. For this setting these hardware register values were
calculated:

	PSC = 3
	ARR = 0xbffe

resulting in a real period of 941238.741689943 ns. However a request for
941239 ns resulted in

	PSC = 2
	ARR = 0xfffd

which corresponds to 941229.1667195285 Hz. My error in reasoning was
that I thought I'd need

        period_ns * clkrate
   ------------------------------ ≤ max_arr
   NSEC_PER_SEC * (prescaler + 1)

but in fact the necessary equation is

        period_ns * clkrate
   ------------------------------ < max_arr + 1
   NSEC_PER_SEC * (prescaler + 1)

The value of the LHS fraction for the above mentioned request
(period = 941244 ns, clk rate = 208877930) with PSC = 2 is

	941244 * 208877930 / (1000000000 * 3) = 65535.03278164 > 0xffff = max_arr

But as it's still rounded down to 65535 it's a valid configuration.

Best regards
Uwe

Uwe Kleine-König (3):
  pwm: stm32: Refuse too small period requests
  pwm: stm32: Fix calculation of prescaler
  pwm: stm32: Fix error message to not describe the previous error path

 drivers/pwm/pwm-stm32.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.43.0


