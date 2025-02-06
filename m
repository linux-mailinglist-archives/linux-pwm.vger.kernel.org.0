Return-Path: <linux-pwm+bounces-4803-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8448CA2A817
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 13:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F97166E0E
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB1B2288F9;
	Thu,  6 Feb 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l6bp7fdo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA6228C99
	for <linux-pwm@vger.kernel.org>; Thu,  6 Feb 2025 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738843610; cv=none; b=VoF8ZMlutWKE4oqzS0DjLMS0raj+s8jQy8Hgb8D2bPggTaVN21WGC/hh4TavraOyIL4Tc5NnKZHz0L143ukmljaHUtA5WnDKFAZoAwPWNmG+2osCXDKsBmjKmUw6aCROKXrrDTon7zm6s9xxehr4VHG8xvRMBiRLQDJWGyfZnEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738843610; c=relaxed/simple;
	bh=hB4Y/PN8/M4xgeiRJgl1lhme90Lz9h74cogcmW6hNbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7OTIm21+CjjQzxRoUJOPhezIpBXnVkVTbjRYzr5yxQjOPlB/e0K70y/Lsjp2l7TyPmKwXqrmMfRsTPc/YPyfmJaUo3TfUDXMfXx44JJS3QBKI092qujUnk/3oJwWRigBVdTn4In+9barQCzIJOK3poGEIyrosUm6HhUQq+AKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l6bp7fdo; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7740ca85eso91085166b.3
        for <linux-pwm@vger.kernel.org>; Thu, 06 Feb 2025 04:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738843606; x=1739448406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NReF8zJPQ2mkoOGGZ8LIj6uOL+cpVio09VFK6cVJRwA=;
        b=l6bp7fdoO21V+sC5RoaVYSfCV09WpU/9ygI2QaFqMcrimL9Ilh8COjzVXSTsIjx6aQ
         Fe7rtIuNX1H1TdjOvIPrUoKZFCt8LTlwM0P78Jn2PiafgNpblUhP1aR2QEFQqvshaMY3
         VjnN1Hxlo1lT1csQE3PgJNLWOQrnQtP9OLEADLppIpk56GS7Q1uKTaKhWWWmQj5hvKs5
         P15Ym9EfalYEIPIDqXH6+3xAoqrl/7uWhwJWKkgMm+6sSX+Qyh8MaQee95dR8PR3iMXv
         BKQK4yfRFsTuSPwFCnWw5veDfVFJfbvSSFdRcbJDwt9KujTnr2tPRf7w2ExseeRFiJze
         e+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738843607; x=1739448407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NReF8zJPQ2mkoOGGZ8LIj6uOL+cpVio09VFK6cVJRwA=;
        b=f1Icy1lvRWkM8Bz3UePXJWIV+SY3jasaBDmxNWz2y4ZSJI6OU2SvZ2Si9Ez7gUDxeX
         L92NNK/zbEYcUoCuCqWFNwWktNreGQdbDk52rbxAWtslyKFuWdDWjIR375bQ9wL8y4L0
         s/bYNLkxbHdExwjaPff4XqCT2wrV1u9Ktpy/DGpjZkvGUerz1kzNkOs03U7T0PxgaLjA
         7hhAOGSn9Yo4h4Y26VRoLE5pqYNy8vuBC0zIlympA7HdxYoxoDYBn3mZS8mBUPvWp7Ji
         bHxo8sqTFGDp2LNOb2wT4p4BIGDXi/hzFqkQlTP8p0WaGHRwpKyJDUKHqDM6WG5Uk/3/
         XAmA==
X-Forwarded-Encrypted: i=1; AJvYcCWsMT0d5eebsLAhN/1TyHCgQ6taTJNvnQDGPqvYTR50nM4cmOvQ8QOdImGLYW1eMbpERUxtLE9nXFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QF3GqrxWbcu4r2d48v33GrWkT6mRC1+Mkq4C9VU1zuTkreme
	7jrFN0NF/tdn/yckQ67+saQYzaBPpAjP4Com81W0us97EWFShD1PsdNo7aElMxU=
X-Gm-Gg: ASbGncuPjWuXl2RtjsFpEkbLjXmmXBDht2NJxA9cixH5cAHU2E+gBUzak0mRcxuMO+k
	IFYPnmjZ3UD44P+nYQreVFXBjEzJ56YO9sgjqj1IEmluo8aWjCmETlVuCuJqiPMlN7cP8yTNCKC
	SF3CTboT//pyoW5n6X5ZbvYmN9Ty8HKLnRUwglU1QbOea/ZWwIcSU69P2tClNvbYOT83+mQJFws
	4CyzqKBWozM7c8WFAgzNMhmIFCFE1HDnywQ6iZBW+jo6GmutOkgsFRh1wFNECFtckpHc2EFAzLA
	p8i08JQFFRDiRz/7pYsQIIll7WKDClet/JZXC/OE/8iSGuH1NnQKUEU5vw==
X-Google-Smtp-Source: AGHT+IGQ1DA0hZwXcuSSWYUM+Nwt3fhgw1zzCRs+JlqWF6tyiwu3NKdw87WAG8YCeJ02lh0EqQN6Ug==
X-Received: by 2002:a17:907:1c29:b0:aa6:b473:8500 with SMTP id a640c23a62f3a-ab75e2f35d6mr665775566b.42.1738843606248;
        Thu, 06 Feb 2025 04:06:46 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7733399b7sm88700766b.158.2025.02.06.04.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 04:06:45 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] pwm: Add upgrade path to #pwm-cells = <3> for users of of_pwm_single_xlate()
Date: Thu,  6 Feb 2025 13:06:25 +0100
Message-ID:  <b33a84d3f073880e94fc303cd32ebe095eb5ce46.1738842938.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1738842938.git.u.kleine-koenig@baylibre.com>
References: <cover.1738842938.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2213; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=hB4Y/PN8/M4xgeiRJgl1lhme90Lz9h74cogcmW6hNbs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnpKXDTGJARL1cSvb+WvKKbPpN9O1N3KQQQTDB3 QWnCB5cXhSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ6SlwwAKCRCPgPtYfRL+ Tv9kB/4k1C64n/wjXyMEl2YAPPWhoTmdH82Ps93+wOk3K4f0TLrMY/v3IE/7doFskqR4mprAuUS 7ho/c3R44ScCD3492ffliwGypxz6Hve2qbgzjCOdIpiExgUY7CbTNNbns6kPQEXKQcruOYMSJeW 2ktRsj66bLtA8UIEuNqVC5sBXQ+hS1oSZXyB9v6bc8Q13RTFvMK8f1eVuyPT5/3oLVnySTMEy+8 0IdEKIGXZk5gPm/kmEaPuYgE9cYlDTAZpg+gn3fTA3u3LY3Kskedyfwe6rW5iD9kwwVW5Fgb1SC aFz3p+GzT/LuUpu2kMYs1J2mETTHLnBRQ5J+T8F+F38FwIfG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The PWM chip on PXA only has a single output. Back when the device tree
binding was defined it was considered a good idea to not pass the PWM
line index as is done for all other PWM types as it would be always zero
anyhow and so doesn't add any value.

However for consistency reasons it is nice when all PWMs use the same
binding. For that reason let of_pwm_single_xlate() (i.e. the function
that implements the PXA behaviour) behave in the same way as
of_pwm_xlate_with_flags() for 3 (or more) parameters. With that in
place, the pxa-pwm binding can be updated to #pwm-cells = <3> without
breaking old device trees that stick to #pwm-cells = <1>.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Tested-by: Duje Mihanović <duje.mihanovic@skole.hr>
Reviewed-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ccd54c089bab..bc05818fa370 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1000,11 +1000,27 @@ of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *arg
 }
 EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
 
+/*
+ * This callback is used for PXA PWM chips that only have a single PWM line.
+ * For such chips you could argue that passing the line number (i.e. the first
+ * parameter in the common case) is useless as it's always zero. So compared to
+ * the default xlate function of_pwm_xlate_with_flags() the first parameter is
+ * the default period and the second are flags.
+ *
+ * Note that if #pwm-cells = <3>, the semantic is the same as for
+ * of_pwm_xlate_with_flags() to allow converting the affected driver to
+ * #pwm-cells = <3> without breaking the legacy binding.
+ *
+ * Don't use for new drivers.
+ */
 struct pwm_device *
 of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
+	if (args->args_count >= 3)
+		return of_pwm_xlate_with_flags(chip, args);
+
 	pwm = pwm_request_from_chip(chip, 0, NULL);
 	if (IS_ERR(pwm))
 		return pwm;
-- 
2.47.1


