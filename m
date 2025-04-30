Return-Path: <linux-pwm+bounces-5784-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D891CAA4A69
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 13:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0471C02D09
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E42580DE;
	Wed, 30 Apr 2025 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cmd+EBH6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB61B221557
	for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014185; cv=none; b=EvGexOXr+1abxkeYHmTnmVYjNJhGxCoqpYTy9UVMRSNlQWNS1kJk6zfA0E7epVjuRoAMlNmWAL5IagOxN7lmGx1ha5+vZjLmZ95/4mbnXQd7xokJoGas2D3tavqvWI8OngnbX9fpifEKODBpS9mz8VLCPCAcTNwiSijis2/It3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014185; c=relaxed/simple;
	bh=hyejLcti/TcNJx1m4d9G/GtC0oEJ7Qey4FsXMzEq1kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k30qvQJ4wcuzj7O5ypKo3gX/+wlSQiXYM6g75xKNxHjb3bK/8yXmWoz4f0nrXq/STDVJbSBWAbfIT5nvSU/x/YrvP9VPFaKhfeDKENb/O46O+4l2mMFPOrnbVcgycK7jYZ71bb9ZJS5L5nuJ77qrCaO1TZXzpSTnxdnkom4UP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cmd+EBH6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe574976so49759615e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 04:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746014181; x=1746618981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9zyhrEUi6nJJ+PGWbcpcUtk00EBlhKzJBA8nF+tlnE=;
        b=Cmd+EBH6KzksutEoo7mkFf6TTdtPYgI5jqylReWF8QgEU9TR2Y8z4TGL+v6wPiNOIx
         2Bo5Vx/JAO3AjS/ozbH8an8PrqqanoSBMWUCWgMzfAAtReANgP93p9a4K7ovQQsh8DfI
         QtyzpRjGYv+zYMFiFVkqwX3uBT4iqlXBglBQYY0KujyZxNY8Mvqhp44SgOjy9A33UENl
         qQjgybdSHYpLwAUMMGlu9wejD1kIjBhcJpbYEIBkQ9JlghT7WuIG/CX16cjS1pdPk9Qa
         GFhEFiZ7dxzQunwoPb5qAaFWyYMlALsHWr0/a4WUme5QY/WPS7vt8uVnsYr3WOBNcPh2
         fr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746014181; x=1746618981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9zyhrEUi6nJJ+PGWbcpcUtk00EBlhKzJBA8nF+tlnE=;
        b=pbzW3eiPJ7sNPDaX5c7gJKDpbrxH3Th3hTidzBZaEA2DsLXBLW241r2JYA4+d45B4s
         Ja/bGUMwXMtkupFbPeNFj/ts9xAfBqQ7/s56mOUrxNumSgQqOFJKNNAWhkr6VK3IASIE
         kLKiAZEPgj3jNWc45OGPnpVn/boVxDFfSoPiqBW0/os1t2h51lhran/1uskrakjpmGwv
         vf9/f1axiV2WpUSeb7xVehuS1j4rEKLopLtDdl8CihrwbmwStbUePklb43vHBwHzUzmp
         lrUGUQeb9Slv0ekdfVa+q79h1pu195N4d4rFdeJcjlJGE5LN7VjBbiL2kVt+OXElb9XK
         Bvjg==
X-Gm-Message-State: AOJu0YyVHcdwb1OQigyVxRl8VPOv4i7PDoKrX1mdfvMwAIXFPFjcM8RG
	qWiD94N4x7fzTQwJEflw1nMHXltVL0pZ4WYxw0cTgnGpX612aqT9IQWNDZ+FPOLC5JkhK5WOLcl
	w
X-Gm-Gg: ASbGncuuv1g4fi1b2/JFB1l0DKXRuMxqur/bWln4dWK+h6v1HbjQxFtEeV9nxUbLfuh
	vZNlO3FRud3uduj/Et6J3/H3UDp6foQR2iCUd7COFaA2RABSRHq9piEBD0HQA4f7vCcBUgDKNoh
	IseL4SzxuQtWmUeFxduGVCGM2q1q0lNgjU2ZVStxzKO6oEEKsXUZ0xO2A5d7QzJbYNvfHDr5gK2
	155S4fm9Pqpvc/982wcBgjqgc3/DfbMLralONYseSSoPSsNZEyT3oZKNXv5VcnYeWIvFy/aapkj
	itmBEJ9sqQW89UHE4yPanYYctB7eP7pn6PQMqjH5V5psoSIQq10vmJo02wqq+yaxIjH2p0Immlf
	Zm1MtYBQ=
X-Google-Smtp-Source: AGHT+IE1s1XezmIzMYkUPHDqKoWM6AWJrgqc4UeJ0XNV8UbwybnVCGNfE/QYiRjyiS9OH4wYytTVoQ==
X-Received: by 2002:a5d:5f92:0:b0:39e:cbe0:4f3c with SMTP id ffacd0b85a97d-3a08f799858mr2396763f8f.8.1746014180982;
        Wed, 30 Apr 2025 04:56:20 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073e5bc8bsm16507524f8f.81.2025.04.30.04.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 04:56:20 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/4] pwm: Let pwm_set_waveform_might_sleep() fail for exact but impossible requests
Date: Wed, 30 Apr 2025 13:55:58 +0200
Message-ID:  <20538a46719584dafd8a1395c886780a97dcdf79.1746010245.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
References: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2581; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=hyejLcti/TcNJx1m4d9G/GtC0oEJ7Qey4FsXMzEq1kM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoEg/TjhmrL1w5soCslBFVn+FiS6bMxvpaMz7kw bhK4duk4ZKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaBIP0wAKCRCPgPtYfRL+ TrRFB/9SDqf599BXlRzVARugVjRfSAG7ZLX+L0zzUolOI7hTKk4k+Cx/KTz57KcPAm/S7gjyMIO XA4Vq+H9hXub/FU1TutxJflnKT34X7oCAXBSz4Pz0xmZeFs/TcD7ekiSZYYl4xngz4ZoqSLQ0s3 JMvRfxnUh8QiyH3RaUixsF+p6W+Wapt7QmgfwppNyorxAZDfdi/sROV6Nw61IgCVID/9e1pA7CS HfIpXiJMCe0whRDWqwIvc+QLJWdy0KdPvvg7ETYXMm2tYgyGYmwD8sWcxVF8BH+RfHSsY+UlQ8r 0ZtR4FAlNPvZjtfZEVRdyT1NGwBosJXb5XRgnr/4Ok7P7u2b
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Up to now pwm_set_waveform_might_sleep() returned 1 for exact requests
that couldn't be served exactly. In contrast to
pwm_round_waveform_might_sleep() and pwm_set_waveform_might_sleep() with
exact = false this is an error condition. So simplify handling for
callers of pwm_set_waveform_might_sleep() by returning -EDOM instead of
1 in this case.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e0a90c4cd723..28cb6ab0f62d 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -404,15 +404,16 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
  * Typically a requested waveform cannot be implemented exactly, e.g. because
  * you requested .period_length_ns = 100 ns, but the hardware can only set
  * periods that are a multiple of 8.5 ns. With that hardware passing @exact =
- * true results in pwm_set_waveform_might_sleep() failing and returning 1. If
- * @exact = false you get a period of 93.5 ns (i.e. the biggest period not bigger
- * than the requested value).
+ * true results in pwm_set_waveform_might_sleep() failing and returning -EDOM.
+ * If @exact = false you get a period of 93.5 ns (i.e. the biggest period not
+ * bigger than the requested value).
  * Note that even with @exact = true, some rounding by less than 1 ns is
  * possible/needed. In the above example requesting .period_length_ns = 94 and
  * @exact = true, you get the hardware configured with period = 93.5 ns.
  *
- * Returns: 0 on success, 1 if was rounded up (if !@exact) or no perfect match was
- * possible (if @exact), or a negative errno
+ * Returns: 0 on success, 1 if was rounded up (if !@exact), -EDOM if setting
+ * failed due to the exact waveform not being possible (if @exact), or a
+ * different negative errno on failure.
  * Context: May sleep.
  */
 int pwm_set_waveform_might_sleep(struct pwm_device *pwm,
@@ -440,6 +441,16 @@ int pwm_set_waveform_might_sleep(struct pwm_device *pwm,
 		err = __pwm_set_waveform(pwm, wf, exact);
 	}
 
+	/*
+	 * map err == 1 to -EDOM for exact requests. Also make sure that -EDOM is
+	 * only returned in exactly that case. Note that __pwm_set_waveform()
+	 * should never return -EDOM which justifies the unlikely().
+	 */
+	if (unlikely(err == -EDOM))
+		err = -EINVAL;
+	else if (exact && err == 1)
+		err = -EDOM;
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_set_waveform_might_sleep);
-- 
2.47.2


