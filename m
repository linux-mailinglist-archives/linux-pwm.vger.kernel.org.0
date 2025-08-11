Return-Path: <linux-pwm+bounces-6997-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9693B21157
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1568B175785
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107429BD85;
	Mon, 11 Aug 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YboUvCxA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26729BD86
	for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928090; cv=none; b=C9c2dUZic7BXohbCChxTVSrHvD9o8zbJgP7flNmUMRkC1YMjcigiLyYobhcA35aB+nNNYx29gxmbfqnDBEu1CIC5ArPWPrOGyRxLrk+PghuEaS46mySp0eXUdRCRLRT6ZnJL+8RbEzStT3JSQSyDLlgLc6WGyiDE9S4XZrCsrK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928090; c=relaxed/simple;
	bh=8S4aYD1Qb7XRBNrN8dilWb3an2fEEn5pOenvejw1OkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poAYfLmlcHsV4GBUAI1i0bzzjeJo6KFuLKJSe58Ln9Oh9R1sotB5eakvLdSmk034mSfQvO0I2pnhigXF944LjCQ602akx1UKhUpRt9D8lv54Fa/4E8F4ebYGEmE/cCNrplXwuJj//0MyAkXIqyPOO8aXXBy+i3xjYzN06vODjxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YboUvCxA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a0feae86aso2487735e9.3
        for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754928086; x=1755532886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/UfBW7p0IAgLaUmqS1ddLPntfMkp5jysk0aAli6mJk=;
        b=YboUvCxApy/6yIaasEqyrRceO963PDWY58B5R4YXVZFQkKKG/5xl9IyfRH/lrxd1nI
         is7tX7rp2GlbBqaT6/loEs+i58lgtHuK8lnaxVtcBAf+yExQiHdP+Y67a7g8AfqRvhsZ
         76uwcy0BcQyCA3bGstLVetxqD2pihjEoQBXQACyNSVusbt6lGsHWrXOEb3Lwb4300vz9
         OieRoMn8RZ3MNH+eC12TonVBrAsppvs77PKoWB9+WPWQRft1Wqo5KJuMSgYg0brLHjud
         REXy/kd+b/TFmPoaIriiDO3E5TavcRBxVWsToU4fNuDvL12VcSqcW96J1p1XymG0811s
         8ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928086; x=1755532886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/UfBW7p0IAgLaUmqS1ddLPntfMkp5jysk0aAli6mJk=;
        b=UunS8Cn3A3fNSnn+DmB6PmSpFf/e/HG6ZNseNzpd2eWunJDZHuNmCPZ0CoI6RTKp8J
         yftPpoYVvEpDDZTyPuBPCaXsnftYm87CeM+2OY371CqiS4/0rFOHd4OxJPzN6rBut+Db
         ygRyoeP/J5ERYNc9wAFU6za/Lhpe30wUSKkUEgWx4NQcOLdIv6jpeXT8mkIHY/I3doTg
         Yqx0wQwhzthEWp1hIDs+9Dj0i9Aa3/u6Ozw+un6Fd8EO3LUiOH7KyBvxhNr4Kj400zzV
         3EsrdSY5bscrjR4th2Ykmws7kitRC52UqCNwPHcz3D2BuZ3f/zJFLXFZs/m7kwMtgmgN
         Iw7g==
X-Gm-Message-State: AOJu0YyDMxd6tufpvrEzhukUpnmNroxcc1Tdu4v9uLUD96lLRf9CxNZA
	qX1W39puUKc7v1yliw0h4NYYmlv/vikeE3xMZKMTV8Z2rdC78U8y/rWemHkPOoNZIfXGzmnP0uJ
	gm+L7
X-Gm-Gg: ASbGncv8ed6Kv4ISP2i9kPu3szgPZiBrANJPfmL3ONmuwHEpScVLDpoLoYto9Jva4ki
	8MMAVnb3jvFij7JE71/nxFBehCSMyLPAcAQ294Bt5aGcCpO4OEWy3bNiErjssX7hgOaiIe/keDg
	BDW7y/DZo/k1CIYH+4WSVlzyaaY2x+5iozxH6Wc3F3slP5WlfW4ROhGDKe5HQRhVbcXrz1g37hN
	E7pD4XIw2CaXo7z73LLuueCwgc3xn0dhN8bGc2R34hRBdjxMvvkxCyzQ9zcvSeg5Sdy5fSpDa1f
	mMgaOpJwMzrj8Bof4/iskDwfTotW2c+/KMG7m7rigmcMMPWLjNkRA63yw3UuBHEc2YGJ3fPQGom
	MIYWqiYRC2D0Gb1d9NG5yOByjGMyoRVyUxNhz40v1XPNZ7wzIp/a6JUOrNt5dFuYC
X-Google-Smtp-Source: AGHT+IFxJoW1NEhgSmv5AMe5t/lv48l9kQyikXaFxa2swN7G8W3bVfHL4XMOYjEUK09C0rbLktu3OA==
X-Received: by 2002:a05:600c:1c25:b0:458:bc3f:6a77 with SMTP id 5b1f17b1804b1-45a10b94f71mr2515165e9.2.1754928085875;
        Mon, 11 Aug 2025 09:01:25 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458b866392csm229857105e9.2.2025.08.11.09.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:01:25 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: "Philip, Avinash" <avinashphilip@ti.com>,
	Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 2/4] pwm: tiehrpwm: Make code comment in .free() more useful
Date: Mon, 11 Aug 2025 18:01:00 +0200
Message-ID:  <4c38dd119a77d7017115318a3f2c50bde62a6f21.1754927682.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754927682.git.u.kleine-koenig@baylibre.com>
References: <cover.1754927682.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=8S4aYD1Qb7XRBNrN8dilWb3an2fEEn5pOenvejw1OkY=; b=owGbwMvMwMXY3/A7olbonx/jabUkhoxZwgffXbSZ+OrVqYVlHo6Xzn78u7O63oL70PIdcaI5e Zxur/LedjIaszAwcjHIiimy2DeuybSqkovsXPvvMswgViaQKQxcnAIwEU4f9v/V17UP+6ga6315 pePqdytxU7ll8nWvdLMnoi92yu8S0/5gVJTrvv/94bjt03Q6buxR7dnx3L5XkitbYp52x5Lp+g0 eHdpuG10YOD2s0vzKtAtCiqaKuZxtvBGVf3P/8T3CchO+sXz3zZ30rCX88Hq3OsmdyeWnOeyneX SU7bmiphhm8H2HpoVMO+9/1mibHytNNZSdpNiUuOSu2TxI/Lzl1X+51GM23yweF70vcM/T2x80r +LG9uvlyxbpNkQGO4g3iF24ceLBirIJ1VU7BLmUo5S+Plx/NO5SZTXTXKPH+qt2sZ6K+hrlnKxX Xjw/uafAdtPi0/pWfhf5FKLPyKvHHXrffzG+OzdOi3MiAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Instead of explaining trivia to everyone who can read C describe the
higher-level effect of setting pc->period_cycles[pwm->hwpwm] to zero.

Fixes: 01b2d4536f02 ("pwm: pwm-tiehrpwm: Fix conflicting channel period setting")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 5e674a7bbf3b..a94b1e387b92 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -391,7 +391,7 @@ static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
-	/* set period value to zero on free */
+	/* Don't let a pwm without consumer block requests to the other channel */
 	pc->period_cycles[pwm->hwpwm] = 0;
 }
 
-- 
2.50.1


