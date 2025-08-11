Return-Path: <linux-pwm+bounces-6995-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96655B21159
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 18:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761BB684E9B
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 16:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC82E611A;
	Mon, 11 Aug 2025 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gd2Qf7Gy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC262E2854
	for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928086; cv=none; b=QMaYatM93p3yvFKdO4QN4NBQPXVbpFuZqm/+3O3DKKnA3ovibqVLq8GkC1B3SvtwOtoeq8TnrCYZSyBubgAx75aowWho3T+wGwKeTVSuj98Tzf1A6hc3/YjzMJCKlWaa+0ESvFoAXMpAc0FGW9DWWMSAMKHVbwXq6hWsb736ftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928086; c=relaxed/simple;
	bh=zay19iYm6NMSWgRS+7E5cZwyAGmnEYcR/uyYSz4NivA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UGHSiG9cb6xVfp9WzMqRxXgKfSvfGDaFoVBKF7Fgmzl2rjnDOW8wVLMC2AZhpDztFZldZIFHhe3uGyuGN5mIrK+bJd/BO7RFYPnfGtYws7bPErZnwK/wmJ8gkKfK4+KfkgYIwRhcXpzBIzYLZBktC/gMeqS/4anZ7K0LFv0wD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gd2Qf7Gy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459e794b331so27474895e9.3
        for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754928082; x=1755532882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORRxdRP7aP5k6dJUsipICX27J0AtrLQA5lHeaqD+luE=;
        b=gd2Qf7GyAugnNYPJDD+kZgC6s1quOi9zmlSHwEImGJ3C8qlpMWljBpy2qbIpoZ/Joq
         We/h6O12JctqFUUPYLY8BZa+K3vpJlyroif0ESJGhORDIHOYZ883FUfA09Z4JhAOMB24
         Fqy2T77tbozkkZyn/5mRnfMIBYAZh+eyyC+bfypEMP5zJBHGNs8Fyimj6/l0K/AgeTOH
         z7Iqym0/CLmbpn8YH3jL1E5YrkLNwMxmRHIXa1S6Vd24zfV5hCLTvnX6MiayZBJSKyaa
         RBNpq6ljfecuxMMUwYLGjC5IfmnbQjBUiQF4hbkfS64zcxjy2csopmU0cJZnYxXjoG8+
         JEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928082; x=1755532882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORRxdRP7aP5k6dJUsipICX27J0AtrLQA5lHeaqD+luE=;
        b=va4A4z1oDJlyzslVAUuIY8h2VfoAfxH2y2xVDxNKiOvwk1rfgbMkCdDVzFKsQImLh0
         KaXEpBwYxIEySsMxNhUVEgYCK+FlGuTZCabfa5N2a+nI2v9nKG8LIgC8kWYGTDtbWHfB
         56nYVWoyKEw8nberE83nc7g2qheezhZpR+uPGXGyIgI+ocNtBkjmFToXPMQXoexNhgqb
         wd1TLj5QT1U+VxKwZm8OQ5qV7EhvXf1Zqh/tKbZ+6FvxRMVUMbYFj/pVwIekxAHHjwKw
         +t/MxSY1pAtpDeFHMLjhpO5Jo8Pr2o+zMhDkvg7pFAGco+9hkiEaE4pWC4nNAu+FAPSj
         +rPw==
X-Gm-Message-State: AOJu0YxtIEblvfj48/Lfxy+ZYMMtQC8jyu9ew1jw4oPBlCBJa8Xk1vMx
	Eh+tPRB0oXA6MSiOOrngpzrdrVaJdmGD/VnDScVMCbN1/g6LbP7NpMq78ZVZUPeRwB+nyno8T7n
	/nz0U
X-Gm-Gg: ASbGncvgGs8jgJCv1gaPdEQdPm+/a2j7i8sGDMMDyQ/rrmKbr0f2KaATJactl2q07BX
	9dMveWbOYFZezDTZZB7OXf2yL6gw43MuSWyoNOSpXHYeg1iJ9wZG95iq9Fsqhd+QjHyt/c83RPg
	wls3Kn0gcZPlIe97ikxD214Hj+3TYycRuXNf3ywXbEmXLF4mLdJzzNrcB0/k8BM/+xVk5XnV+Eo
	TQejqFIQyvg2NqKy3ek0rs7tYM+Sw9yd49aKnQ5NPYt/EnXcRaom3CbyfDyrk81gbdqApv5AQkV
	9Geyb1ITfdRlkuFgSIMvZNaI/6nuwSWPslB9gNeauNAgpkqbOWBjfI1qJFhvBC5+fpUuUmdZ4+4
	qPuy9scS6iGIpLkb9kfDx56YQJAFq+G+NzLSrg1Cpqq1mbsmr745bmsu5WpYbgWqt
X-Google-Smtp-Source: AGHT+IHQA1OWoK1SkfnYgc98TFudK7TyLlDNgchXQOSMfsw33DlygavImMHgms6CN2HibATxp0joVw==
X-Received: by 2002:a05:600c:1908:b0:456:1e5a:885e with SMTP id 5b1f17b1804b1-459f4eaa7a9mr123453645e9.3.1754928080284;
        Mon, 11 Aug 2025 09:01:20 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459dbba5210sm332699905e9.2.2025.08.11.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:01:18 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: "Philip, Avinash" <avinashphilip@ti.com>,
	Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 0/4] pwm: tiehrpwm: various fixes
Date: Mon, 11 Aug 2025 18:00:58 +0200
Message-ID: <cover.1754927682.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=zay19iYm6NMSWgRS+7E5cZwyAGmnEYcR/uyYSz4NivA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBomhO7wzoYq490hEczeT9frLUXhhzUef+dNK6OS rPdfuWva4eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaJoTuwAKCRCPgPtYfRL+ Tg+KB/9RmsPeJp25HDL+Ow2pAwveAYZgHefwPcKnglmxvauxZDZcCP58QYLRRzoAMhVlsB0NaU7 /gVrxMq48S0lcan27OU9yaqn/EcWv3qMpxIue+BzojxNEPV/WkZRTzMali++2alp8MiGkOY6mt3 YfnqRS4uvQnUpmWHnxwDTqkJHXRCMEH3bwmET5QX9gqGGyb5Kx5dgt9LdkBWJe8T+EiD/sKg7vl PSV5mprtUGMgEUa///dmOps9kPsqmpHZs+DCYTYZmOztn6d4VUX+nsER6dP3FkWRwWjSAkLfbNu RECNx2Lk4UfF5DOaQ5sWTmHIrc47jinRCn7h/mLcmadVOmWv
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

I setup the PWM device on a beaglebone black with the intention to
convert this driver to the waveform API. Before getting to that though,
I found various issues that are addressed here. The problems fixed are
all quite old, they all exist since 2012, so I think there is no urge to
get them in and I tend to let them stay in next for a while.

Best regards
Uwe

Uwe Kleine-König (4):
  pwm: tiehrpwm: Don't drop runtime PM reference in .free()
  pwm: tiehrpwm: Make code comment in .free() more useful
  pwm: tiehrpwm: Fix various off-by-one errors in duty-cycle calculation
  pwm: tiehrpwm: Fix corner case in clock divisor calculation

 drivers/pwm/pwm-tiehrpwm.c | 154 +++++++++++++++----------------------
 1 file changed, 61 insertions(+), 93 deletions(-)

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


