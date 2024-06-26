Return-Path: <linux-pwm+bounces-2620-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A78919A9B
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 00:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5031C21CCF
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2024 22:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FEA16EB40;
	Wed, 26 Jun 2024 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JEcAI9tZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5869953364
	for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2024 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719440758; cv=none; b=Oi0iepktEE8MIhRha6IOPJ2atR1+0ONXrMPTeetBYM68BfZU5uMzZQF3EIIUpwRUgEQ+CP42sWQMja3Q+mbeFWhllSjy+S/2+90hyZ4wd5ivPD6Hcd+Am/y1cS6s98jgFCrjsKkR1svCHCA05lvSwtrJObTptRnLHG5QeLjtkAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719440758; c=relaxed/simple;
	bh=J1XVyEOCM9D/QPBBfY3apTjdu9KutPPVWZNpdioMHM8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BVH2Mvz89w0sqGHznDtY+VaZ3I8hQZTU/QVPXyIxBMLO3IuAe2u4PieI1a2pbKgjoLNZ7Rj/5/xM2pdDcnFwp6ARXyYGWzmjkL5QXnTxXVCbms5s5Mz7W9i9BZQptLht1I0iR2U4UUn5ajgZI74DFdn2e2yseyQx6bU8HK2P24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JEcAI9tZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d07673185so1017029a12.1
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2024 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719440752; x=1720045552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wYuZf5Z2NC7R7+vrIBjbDYF0Tmp3wM8zb645VDrs6O8=;
        b=JEcAI9tZZiqI07FkYpJCZ/esLahSuMStFFmXIfFuf01ecbZCF/UKm5pK2L/Y+LGf+K
         ZvU+dRdPot+0PbePUMhMvBTDNGIf0soAan8/jfUk/oQ6gPWToWbusUsB49Pdf3CoGffE
         plDwdlGNPjET5whCikZaC2eGuLGyD9+rKTVbzoHG/Lmu7OyhrxKEjBDd0GPIVfi+Su/9
         ugeWM5ppcwQMPdoe0v3ZnGwprievlziq2DZ+WJIwswlLU3L8zec7P64eII6mYUZN7vn7
         HUTPGs+4MS7LLUZEw68dX3k3dJCQUNvJFsYT5Cz8Xtww2jOWSxqqgKLw6/40yZNxbD5o
         rHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719440752; x=1720045552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYuZf5Z2NC7R7+vrIBjbDYF0Tmp3wM8zb645VDrs6O8=;
        b=ccLp2JXIhWayZEeLR1JaPDJgR2kX++9SQJaY3yfoLDVDSVJFcexMFH8CvgGyCKf0Vg
         IKlRPg7yWG2GKtDb6u45s0uBSMeb9lDoTqCEtgRg6N9y23OW40to0zBjHbknw5vy4gxS
         n1kPDWZ21HfAksSZCWYIOKmkkC7nLE5JCQpHCPg0L6VADh18Wghlq+9swECh2llkbNAJ
         2G36Tq3YcqrQ3n5+DCSszd4tF+3sDO0yMSYNNQB5c+x/TIqepVDoePe//EY4P1g0zpzZ
         naDYNxNRkFH5QWwSTJh43boowBijD2iG+XEaQCKyfIqYy7eRmqTfx5n6Scxtv2iraH44
         Gu3A==
X-Gm-Message-State: AOJu0Yyib07EYUx67joeBFnfgdgpapTi/R9fPe1WjMCPbEFgu15Km6ji
	G3TlVpFoHefRA85GNDUzdjGnCCJxgP+nEtlMfRXhSnT6IY6VuK3VhWKKSGaevuKI8QIrdxuMD/y
	2EzQ=
X-Google-Smtp-Source: AGHT+IFDFIUXuttI89JCJAxYOKHIzuPHed7dJzLiqWIDFtr4bi+BRmmffNQgoYuW8J0icg4hF93HVw==
X-Received: by 2002:a50:f607:0:b0:57d:49b:ee06 with SMTP id 4fb4d7f45d1cf-57d4a281f1emr8563587a12.16.1719440752315;
        Wed, 26 Jun 2024 15:25:52 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d2c591edsm48140a12.79.2024.06.26.15.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 15:25:52 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Register debugfs operations after the pwm class
Date: Thu, 27 Jun 2024 00:25:27 +0200
Message-ID: <20240626222529.2901200-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=J1XVyEOCM9D/QPBBfY3apTjdu9KutPPVWZNpdioMHM8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmfJVZ0GhHnt91PBslpzXWOCjsdKIdVZSfV0rv0 oc5c0LkKhiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnyVWQAKCRCPgPtYfRL+ TtR1B/9V7Ok/25HqurXpo2aKuXrTmdLKwVxMzgJW8vSp7AzyFH3hJKrUYlaBgaIJJZoSlOeapgo tn8SDJ1+gRzZiOcGhMlGtXnpTmuo88UWNbu8MAn1djrSXunlA28BbUHasV04rLlZHZ7phiOh4QW LIVSK0/kUZilLA/DH2igcZ0sasQwzkAVwtWgrk3R7VHm3D1WjyIv2KANWgR6s0Ig3lEP6UX5rJY /V7z8oi/ibDZVbL+lJyaiqx/6vHwheGDSm5Kif5S72jbOeyzLwZ4JyRRVtNL5NWwrVFI6BkZ3Wx KSvmdgJHJhuYt9cNHftydXJFjSiQCHBF6teTttum339DyaON
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While the debugfs operations don't technically depend on an initialized
class, they loop over the idr that only can get entries when the class
is properly initialized.

This also fixes the ugly (but harmless) corner case that the debugfs
file stays around after the pwm class failed to initialize.

While at it, add an appropriate error message when class initialization
fails.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 5c1d20985148..84ca846120a2 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1705,9 +1705,17 @@ DEFINE_SEQ_ATTRIBUTE(pwm_debugfs);
 
 static int __init pwm_init(void)
 {
+	int ret;
+
+	ret = class_register(&pwm_class);
+	if (ret) {
+		pr_err("Failed to initialize PWM class (%pe)\n", ERR_PTR(ret));
+		return ret;
+	}
+
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		debugfs_create_file("pwm", 0444, NULL, NULL, &pwm_debugfs_fops);
 
-	return class_register(&pwm_class);
+	return 0;
 }
 subsys_initcall(pwm_init);

base-commit: 888564d8d708d1c91900ed3a11761f46297fd748
-- 
2.43.0


