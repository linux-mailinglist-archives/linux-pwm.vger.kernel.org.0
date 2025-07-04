Return-Path: <linux-pwm+bounces-6729-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8DAF999B
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 19:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02335567BB2
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 17:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8264A2E371F;
	Fri,  4 Jul 2025 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zWYg7bOT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA519C558
	for <linux-pwm@vger.kernel.org>; Fri,  4 Jul 2025 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751649868; cv=none; b=f88OpELKUdMt1itBVT9rDOzQWJ3FwCsbTXZKgUyOQtzP0/ZjUvWomdmwmC+7KNQbBA1zl5poxqj2pCAdYv+IK0dXYTBzxVGHvHus9IZE4VtDDcHttzZFTNfs62RjaXScMTmAoXFL2PPCI9odLqK0GuzPz5KwwzBWIqQgxsQAmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751649868; c=relaxed/simple;
	bh=EelHYSutC0e59vI2Eaw2tRMyB9r+P8/OqWRAGmVSufQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Taa0oBXZjwIYRpsS9umpLMzrglrTRCVQnQ1rcb+wmsb0rcwMwHq8HvB0qeKNxtiKppHqp9Ws//SrSMv6bjy8GqsMYPXw93BOcyTXWyjAK0PBs319QSwvCBsrPnA7dprqfz+eNP3DU8Td59uc0zX1UEdFe5AJWvUlDNaHmI8PhJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zWYg7bOT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae36e88a5daso246188866b.1
        for <linux-pwm@vger.kernel.org>; Fri, 04 Jul 2025 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751649863; x=1752254663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh4l10zDi8CF25jWWZmLvxmQIYP2hqbBJ4ReWwzP56g=;
        b=zWYg7bOTMuUwL3/iTZJo4kaOA5uSVQEcmeeEp9/LIOkbLTTlkJakDhhGYh/1MlyWW6
         hvkJONXgVBxEp9TxD4g9OrQOOJnVYrnJJ71eB1kITxClwOMWIBJkTOPXqr8gIY7AHNmE
         /BtfNKjJuKfvU9jUsHArQEpdOs7grNg7YHQHVg4ZsQYuVDxqW/9HGliKIvnr/cZLSLsY
         XugEMbsxH+19jKnGGsN5K8e5czPF3bmCXMzMwWhvPeLTBC5aOzjyAeSfIKs3/IzDk6od
         +IXzntcyf396MK158UwlLjJXIIWwj/qR++j5nh3r2TNTjpN0iOm8QCJSNSisLxHbtb6k
         l84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649863; x=1752254663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh4l10zDi8CF25jWWZmLvxmQIYP2hqbBJ4ReWwzP56g=;
        b=ZQ9k3NFugNnBEUs0p5SxgJ3LOJinFZzTPfBWj3mtN6bIDomPwVMwD2gaad3ka0OJ3G
         0xGiNK+AVYaGLfWWrU45EA1rOjdsy2xHByJrIuihhpcYxACGxYUuUbnbV4TlxGW2tQOX
         Fuq8/K8K/wHsZgC8K1oZSxSQU9tymZuNLgU2G+xvrxv3NpSsdg8n/rL1k+C0YbFDIDbN
         Xvivb/lBI8SyipLGjzQBlbCFOFvtp+QVg3pdOrBiEv1RX/H2Djp/bZKWfJrNHOwXTx/G
         UHF7LH9s4X1htz0sHUWGRjfDN2H0VL/DOD3BbET+Z70sZLEeDHAJDQ4q73OE2BE8YrFE
         o3Nw==
X-Gm-Message-State: AOJu0YznPbnVAMd6xriKE0wXd5vLLLofZcWMFuuTVj/qhNDhDARLOTbk
	mqLna8D/jlx/mqKhatUXAPTtM8f3xBCF6+KJ6ys/DKrjIaLlRlhYHiwZdpxWFlsy5dLI/bPXCJk
	SzM/W
X-Gm-Gg: ASbGncuVfafKfL6Ta7eu7hMlyD4Rru3VjTa4FK+VXH55LxWf9wWpfI5++8we6dqGSKC
	6eEx6KxVAXZt3FIAr9u4iyPrJhXi3RU7KRc1nPUicaKwUdDdfTdb02luvDerQo9SjT0a7snntjS
	dZCojZ12PcUp8ZI6+lzYU3Vu/xE9E8+SU5hEbh85QSiHQevVkE2NmZumgMWsn1K8iP1UMMmAivl
	juIOIpiCm7v0ubFRQ0jXMI7PIWoYZqSPwwh0PxajMS/+nF0O6OSskq+UpBAjHjc9CK1aBcx/qNi
	DvucmHqmdhhWfKVWhdri5LTtJb7+eo3D7X+054ve5Q5OIHdNqcTVVaibklmzwoflxlxe55tYtPC
	46oH86JNsN8olNGuEdJg0hteLCgthSzFYAQ6Awx0=
X-Google-Smtp-Source: AGHT+IHXUU5jGcH1iNoWVTPYyi/W3D+DafIM8UEHYBEJKffZQD0G4ComEuZPfg4ho+vF9meAkdmoPQ==
X-Received: by 2002:a17:906:4716:b0:ae0:d54d:2d0e with SMTP id a640c23a62f3a-ae3fbd8b42amr326102166b.38.1751649863320;
        Fri, 04 Jul 2025 10:24:23 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f6ac5fb9sm207497066b.94.2025.07.04.10.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:24:22 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Fix invalid state detection
Date: Fri,  4 Jul 2025 19:24:17 +0200
Message-ID: <20250704172416.626433-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=EelHYSutC0e59vI2Eaw2tRMyB9r+P8/OqWRAGmVSufQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoaA5A3pN8AbSig6l1jHtS33wAG1ATBfH9IHX7w 2GIe/PDr3yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaGgOQAAKCRCPgPtYfRL+ ThI7B/9fUtBaWobsKGLQ64tcBWU2JPTrUOmJ+6KE3h4mqISmEk6UJEV2P8UnKZ750PnB+fMYUTa sVxIGpqWzS/h2YCK6Q97+6EdKzc0tvRLLUmF7WAfl60mO8bvn2W0cnPqiMmy/1SCbusW9jZlt6I C8Zr+ffcbneXXFtOEBDI0VWMtkrL24Q59kC4Bm+MJ4W698wmeCcUzOBUYDgTETfDkMGZOs4JCR0 5ZATMLU02rae+G/Fn+AcHaOj7IZ1mbSzpywnCi0/XneZHumq5gQ0ZBYyycr4l6U3QXcCl6L6hDX 8P21xp8YrklJE1QCTDHcc0u4+Wu65UUhjdkE1HcpMRvnoL+0
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Commit 9dd42d019e63 ("pwm: Allow pwm state transitions from an invalid
state") intended to allow some state transitions that were not allowed
before. The idea is sane and back then I also got the code comment
right, but the check for enabled is bogus. This resulted in state
transitions for enabled states to be allowed to have invalid duty/period
settings and thus it can happen that low-level drivers get requests for
invalid states🙄.

Invert the check to allow state transitions for disabled states only.

Fixes: 9dd42d019e63 ("pwm: Allow pwm state transitions from an invalid state")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4d842c692194..edf776b8ad53 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -596,7 +596,7 @@ static bool pwm_state_valid(const struct pwm_state *state)
 	 * and supposed to be ignored. So also ignore any strange values and
 	 * consider the state ok.
 	 */
-	if (state->enabled)
+	if (!state->enabled)
 		return true;
 
 	if (!state->period)

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.49.0


