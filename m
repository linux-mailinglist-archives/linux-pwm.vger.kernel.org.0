Return-Path: <linux-pwm+bounces-6884-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806B1B1212A
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 17:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95E5173BAF
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229E32EF292;
	Fri, 25 Jul 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TPn3alxw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E152EE998
	for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458343; cv=none; b=WmYvxOIG7PJAmtPMsQJyGbAjsU9t6X/2LGK3+L/ew+XcXmC1MmCX+oP7TA/kzcCpA0DdAjpbOGlNNj8bY5knoUVmgS/fJX5NPNSf7taYnGlU1eI2hXZv5QwGacfXM/AP4u1olA0PzZwl/BaXECVx6eso4WaSohggh71rVgooHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458343; c=relaxed/simple;
	bh=i25yPyDYxImkVBf5DC1DPyGwN93bkwil5G8qHmo7mwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MKsHSJllbt0dF64CzmJ3wvKjzffOl4IHs90X3VyGD+q6XIFWHMApUtLZd6gzjtanadzUo+Ertyk0kXMVddD88/OiZgrCICPvPD++SzTbckNnB4ORLDyRaYH7HozlQUc4VNs+tYTCSDE6AexW6OUr3N0XOQxHLEFLUTonCKCtdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TPn3alxw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1644744f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753458338; x=1754063138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mleQXqvIgmr7vuLRWiAVnrArCWUQGYeMAk8tu5qFi14=;
        b=TPn3alxwMN8OA+FFEm3ot2A8Kmrs9oishX94EzLXb+k+mLK92QegAVEkVL9LO83Ihx
         59uG/XoSYFvWOvtE/adV3S9R3TT7iYSHO1WtJ4O1uqOKT9ED8cJHGLXXznlxReBDVg+A
         BpvNW4WJyxSBT5aGs3nvhC6dR7UHJ43opw8KAjICppnSUZhW/pKW40E0eg1+HGfWMjv6
         Eu6N9q7DckBCE3/em9eDkaFrP4C7nHFE2A4QkEq4/QZHM0uQHpMIYXE9YIKCNMYA53tE
         7yfqn5K2e1wsIkAvvr3wM2ZuwwCuEf6/MUQvSyCtMuE8A03gvhZXPLMga606lS5gfRLr
         7gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753458338; x=1754063138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mleQXqvIgmr7vuLRWiAVnrArCWUQGYeMAk8tu5qFi14=;
        b=KEfjhOEccxHhuNgKUy9H2WiYIpoXwwyqM0+ipJOo6A8nXhC63a3QZjQIv0ZtIllXmR
         WkDrR16cWKpgFqgGpC1QP+Fdzq+Q4zA16RVnE2fTcvZ96nwgrCZJTi9NJqfoAHmg3nOd
         SEJboWiG1vCezreowiCR9Bz99FNP22cBgIrEvTAzBrC/kQCAFYUB3gpXNcvStuedL+9j
         hogjqeea46i/OmZ2DHymzltm+Af+nx7r6vX7TzWEZ5zPLuf34TYj77tFV4AekTlBecQ2
         7pcB/cu3pUaLWUJc9cS9A97aKdG7/I2AfIKVD4ItgLFTmxaiu6e07eJWZd97oJozzNUB
         O/4Q==
X-Gm-Message-State: AOJu0Yynq3XMV/sTMyP/QtOyB6tvzdB4Wp2CzSCCipTVTyiTqP/Yj89P
	h4Ovk8fR8UGCzEYO5Li9FpDUkIPYN8a/5hiSdLTIAEQDORHDywmIDJzM+pFPo6GJDs1egArCS7q
	iWfza
X-Gm-Gg: ASbGncsIn7o3gIbCNt9lveoFk/BhzJ/NvcB163ItZz8wY2Zq5ZFAvJR1rumGYeQ1vPA
	dDqdqLxao/FqWG7xQh3BuVL/3YXAOFAbbEMRWkM8fGwakG8hU/50/YrnWoynEyooGXj+H/wrHGd
	k36VhDgVZWHQN3zHeDQAreJInrP+RxGwuTPD98mKi/JP4PQ3XLjS15gbuvaw5etJLt9eCUfFLqY
	EKFC/BtEvVTFU6QEj/hw4mgTFv2q0C62G5lLidEttDGKMaujcnlDNZTTyRgReauzspFB3k9+/Ym
	NS5UP/TyLBT3kD0+K3rduEkAjZzVLKuZ/QYzASuoNYWSYuydH9z4Gca4aTQZuOjwCQDRHNiA8eb
	laiT4vyvgYZYPQjPjn0kJsgVw4nkHv1MQiAcWdNF77nh3iIARUwlVD7b1nxh+2eHM
X-Google-Smtp-Source: AGHT+IF+Z8jEVkmX32G585PaBNthqQ5rTesPtNg3nHS9aHQXVJv4rFJcGdiunHYW1cmdEB9sybuEMQ==
X-Received: by 2002:a05:6000:4282:b0:3b6:deb:1b43 with SMTP id ffacd0b85a97d-3b77666a7e6mr1833864f8f.41.1753458337861;
        Fri, 25 Jul 2025 08:45:37 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778f106e9sm216675f8f.65.2025.07.25.08.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:45:37 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/8] pwm: mediatek: Convert to waveform API
Date: Fri, 25 Jul 2025 17:45:04 +0200
Message-ID: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=i25yPyDYxImkVBf5DC1DPyGwN93bkwil5G8qHmo7mwM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBog6aCn7lXpMFpj4nJUtawseBPtyk1rpuckaGTy 8/ihh5ZIQaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIOmggAKCRCPgPtYfRL+ TohQB/0bOXtYPsC8OuS08IRX2/7IZcy11cYkRTXW/3eSRFYwZkytdgmFcQMW1o5axhen+jOLYL7 93VmEllRWyUILSC57dfXRC/5OJgKhYUmZbTPE/7rx8QT3DFm6MOoGVjqZBQve+r+rRzk8gRyazT On9W7L1gKeKboz6WooyBaMkO9YckNei3+HiGZf2mO80DnibZg/VL8+B2UBz/mBImPPdz2Eztj1t xiG2JkGbK4pcyJj3PqyZ+k/QZyCM/ENI4hy8KYTD9CWXH8DR/4PDjbUjN2IW7sRuDD6XKm3jzFG 46qZnZXzwJG29lxfKavjdY9g/P3BXCIVEWX8Q0IbUhQUr1Km
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here comes v2 of my effort to convert the pwm-mediatek driver to the new
waveform API. Changes since (implicit) v1 (available at
https://lore.kernel.org/linux-pwm/cover.1751994509.git.u.kleine-koenig@baylibre.com/):

 - Rebase on top of the latest fix for period and duty setting
   (https://lore.kernel.org/linux-pwm/20250724210041.2513590-2-u.kleine-koenig@baylibre.com/)

 - Don't report a disabled PWM when the PWM is disabled. Though that
   seems counter intuitive, this is the only way to allow the consumer
   to query the minimal period. This wasn't necessary in v1 because back
   then the driver claimed to provide a non-disabled setting for
   duty_cycle=0 .

As before the patches in the middle don't serve a functional purpose
because the last patch removes the changes again. Still I consider it
useful because it reduces the last patch to what is needed in such a
conversion.

Best regards
Uwe

Uwe Kleine-König (8):
  pwm: mediatek: Simplify representation of channel offsets
  pwm: mediatek: Introduce and use a few more register defines
  pwm: mediatek: Rework parameters for clk helper function
  pwm: mediatek: Initialize clks when the hardware is enabled at probe
    time
  pwm: mediatek: Implement .get_state() callback
  pwm: mediatek: Fix various issues in the .apply() callback
  pwm: mediatek: Lock and cache clock rate
  pwm: mediatek: Convert to waveform API

 drivers/pwm/pwm-mediatek.c | 454 ++++++++++++++++++++++++++-----------
 1 file changed, 319 insertions(+), 135 deletions(-)


base-commit: 68b9272ca7ac948b71aba482ef8244dee8032f46
prerequisite-patch-id: ec97edc20a72c4e283e74cec97c8cc6036e2fd01
-- 
2.50.0


