Return-Path: <linux-pwm+bounces-6778-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DFCAFD523
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033CB3AE524
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC32019EED3;
	Tue,  8 Jul 2025 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BKuiLEDD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B32E5403
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995109; cv=none; b=swLtB2LdVmhod5OrSp/zsNv8xCcV1nl58wqeIeBNxtIZ2xeow8oTrlxpcEufSD7G8eWBjkvYqAbaPxIvx/NkiyPyQqb2qtlxi9TeWmy2IaepB3QhCSvgeT7DxE/yZVnbCPxndMBOxugObbPiHbyn/3igrIhmwLekN1OEBnZWrKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995109; c=relaxed/simple;
	bh=4WAjuKoFlHGhpLkog8/sT9dD5IHdOK9dAhBXtuvSV8o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coUD7ZsOIcZ6Ba+0rUtlpEeIvbjdXV5r0ihmWPhs5O51glbsLXW9lAAJ3QFPojt1DdJ63Xj0L6q7oIXNw2Xiqgppufz6PKw96+w5O5SsGq53PNFnuFprTVRkhK4lBBPORZxwzxe8nj/W+DUK4cboO4P1WsEWC+8UCke4Gxe+my4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BKuiLEDD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso7732203a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995105; x=1752599905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMafdEAcut7XLeM8CQK/z5XPsr7iXz0+mJ6gSgWEW00=;
        b=BKuiLEDDD1BBfQEMLLNkNCMbCK5csDieMvQBt/6UclV5BgyBRw2HjQlBrwnpI8t49C
         Y6wfvjE70Oc6mkXEvARG2mB6KCQBXNxchT/2pJXaw+Lq268zhOvbilMCn/e7krF9XiHr
         lqZnimODyI0bvW7tur7gp8dC9VdPPbjpec4XcEO+biEuIJywq3m8kC7q9Zvjsk7e4vmx
         X1zv398wROjeCIfmxDPt+Hy886NzmCzu9Y/nm5Bu7iom/2sEpdjD8iXFxbHgImbbZcPA
         TmS+oaW9jSFfNYEG9G9CtCJxPxhJFc39SnoBrwAkY3cmquIGOVsN6E/NGqMvkEsPeGE/
         pgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995105; x=1752599905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMafdEAcut7XLeM8CQK/z5XPsr7iXz0+mJ6gSgWEW00=;
        b=ekuiQ6XbupTnsDBCLqWc5yZYxGbsRXBXnLxOdEPqaV+y9HaciC0EVE6EVlQctKdTXL
         9jdgR9jAp21GzwiZqrVMxfI6Ychte7AozdMlc9leXkt515+dSW+/nmK1EW9VfEg0IHmn
         /0o+G2XyocdK9x0jXp/p/pq7XL6wVYQNYJDK4gsH1AqA0VAeT7KAf+LbtdSE03pFU7KS
         V5uNqQlS+KgmqS9sW0WSXzItYr8+k6IwdFw2E+2rtCavpYGSB3M7h+FiC4YDF19yVEA0
         rJrVg3n5+uMiiH5sNwHF0sHuRt1tstiVb4wM5dCw1urI98Cho6G9ivICIIdKmPSnTQiW
         moqw==
X-Gm-Message-State: AOJu0YyKpRojVi+AOy2nAfA5kGI0cdRwcZO9ZYN4neRZV3LkExRiPpBP
	tp1VRpa0jHpPGqGfUqrOOGMuNVE9IERYjPk9F5DwM99ViJUopwc3Uv3O/YWGXKpmGJhDkUwLx9r
	FBcCb
X-Gm-Gg: ASbGncsiijGc+VJ5FbFe/M3biBzHzu9u2MJz9EQd+xEDMkuB4t8aR2P0N6QFkPhwIc7
	/qHHep5Ow8Z0mvOJOOiksBEQpxKgF9hP7mMWLa/aCKQ7l+OE2j1d6M/QR6SRiyzdJD9MkycJPYL
	ERag5DMpJEvlf4hAKYBAlZJ7YU+LH3qVgdBigH2EBcVa+kCKLJ+66++NATilHHz495WlU4kUO7y
	mc4QgpSJ//orVhJMXuzamg4sjuFzvX2MLi61aJL4U7lIEs0ci7DwYfd87GHk2yWGXp3+weNpAgK
	UntAtJxOXY+C4+oaV1TofsE8EeBb7HCra9L0rK3E2nU2wGwT+OOOgx/hKzIBVqP0t+sDrIn0imM
	2XIdjWFBDG7q2nTym4md5CUAoW4tJ
X-Google-Smtp-Source: AGHT+IFo7bTY0CgCapftp5ux+NvGF257y60x8x7Ve9JZqMyXy32MrsfU+jLHRvLOPra3Fk2mjZLHUg==
X-Received: by 2002:a50:ab19:0:b0:60e:f46:326d with SMTP id 4fb4d7f45d1cf-60fd35d678bmr11453958a12.33.1751995104943;
        Tue, 08 Jul 2025 10:18:24 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60fca9bc54asm7449500a12.33.2025.07.08.10.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:18:24 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 2/2] pwm: Check actual period and duty_cycle for ignored polarity test
Date: Tue,  8 Jul 2025 19:18:01 +0200
Message-ID:  <bc511c0250ea2f6390e4209ab1ea9c08a3c18612.1751994988.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751994988.git.u.kleine-koenig@baylibre.com>
References: <cover.1751994988.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=4WAjuKoFlHGhpLkog8/sT9dD5IHdOK9dAhBXtuvSV8o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVLP1bg1DhWxbGZ1gvSX2Wps0Sq+hIxjIU3tB cEN2CY86uiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1SzwAKCRCPgPtYfRL+ TtLpB/wKK+78T/MUGKB4Px3WSWz82dK14N/qQ/e92wRbHe+Rb3Dtlvn99gZK8PRG2t9J27z8nQ3 agmQRVJkXf1xwlR6OczJzu/V3VgHxpkuMdLX3syMSsoUabOnB7nExJRjpCO8pui2KKKqS9vLCUi FZi/+/njigr6Yol3jP0gfOjT/6nlnX0drWqugfPfngbeDtrWrbdjwG5oXqanDQWM3lyaopY67qR dHN9fJiNjlC27Umkh6Lfv/UHAQCXODBnsqnO71h65+VGwlvKlEvjm3zXn7k7IakNCQ706QFM2I0 +/AzunaY7+vUvpDhYBYHWyOtLeJI6cpqyxiNWCX/r/KFPVW8
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When a lowlevel driver configures the wrong period that might
(historically) be ok if the emitted signal has a 100% relative duty_cycle
as that just corresponds to rounding down the duty_cycle to 0 which is an
allowed thing to do for a lowlevel driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index d9d9badf7a8e..cc043a49c7d9 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -536,7 +536,7 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 	}
 
 	if (s2.polarity != state->polarity &&
-	    state->duty_cycle < state->period)
+	    s2.duty_cycle < s2.period)
 		dev_warn(pwmchip_parent(chip), ".apply ignored .polarity\n");
 
 	if (last->polarity == state->polarity &&
-- 
2.49.0


