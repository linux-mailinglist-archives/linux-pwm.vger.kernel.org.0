Return-Path: <linux-pwm+bounces-4785-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9137DA2981E
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 18:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3331D161AB5
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF4E1FC7EA;
	Wed,  5 Feb 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JiRGlg33"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F31FC117
	for <linux-pwm@vger.kernel.org>; Wed,  5 Feb 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778068; cv=none; b=FSnpkSeS16eZWWb123MTiTV2un98YbSVxuWZ2B94DDSa7B8mZyWg2hWFtwIrSYLRmrYzUBya+d7mZYOKvtQdFdR35YHPz1Vlzn/fMF79cX9MiGNupDqT6uJmxyvMdNcHNkq3em+sA4jKHocAltw+aw07ErpwObxza0KdAYctqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778068; c=relaxed/simple;
	bh=TpqSOnoMvrWXemfbgCJPH3YeRF/bonSoXcUzvWn+vu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apP1/z2Amw0JBwXTSBplO2a9+iHZFmlkaR/HP+/fo1B5SiFR+C7kVQwXLn2BAtjuJSGIzr1cKGe3x+X2Tj5wJEyZIjh6J0hI0ZgsRiBlvSG6T3EP4Rf+s68nbnoE4gxrZFQbS/Q2fuOidzwZjPHR7IGIG+Hm3a0hkbUQ9h1Qfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JiRGlg33; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaeef97ff02so15167466b.1
        for <linux-pwm@vger.kernel.org>; Wed, 05 Feb 2025 09:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738778065; x=1739382865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFbHN5oAc7SgW4VT2zuwkkX5wnrVvIlDHxKFH7OFwgo=;
        b=JiRGlg33KRIUxTzImfeT7Sr0qJdWhJ+X+17nphg2Y/udJR0gW9Ng30p3jAp6uq5vP3
         6/SDT/UiIOra7MoDln2B2RxM1xGD4wUFqA8TObWhKlw0UPExzaHmkzfVF9hhEHl+e00+
         tkhNkLGoUl2uWUPMAS2Leag8bnTzhm51diJZb88P6GKLk1NdQyWfpKIRynDLJJlgVl6v
         jVdN4KZIsGkGMzVcTAFx94JthJjUPXKVbw2ZQgiyRmmsGUCxMtNTw18gAJt6w58dR5tv
         R46NIBTc2/ktfWDnloSf/YvgYZE66Rdayqq2M3Y7u0uWRfVlW5xII3J0r768NbdQ/JPs
         aUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738778065; x=1739382865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFbHN5oAc7SgW4VT2zuwkkX5wnrVvIlDHxKFH7OFwgo=;
        b=LACdDq/rcRvpIQGy2xWKiZyEwIkPQtrOfCfOlpBpSV1MFntUGTwA7okUnfg1XT6Hmk
         9xbp3+gmHZVufDqJCQ1InN5bYF/kynjevdSARooBDjIUp5E7GKgrMl++YPENtxTrjO5X
         jP2DWDSHsiVCM6O1+NygJYtzGM+pU6jj3+rr0/BCkUnLycTRPwS52uk4tlT1r1EjPBkq
         EhUJYnWGkZTWw/RlRnqBaqdrkJ84uqSVHPFZ4zCqHBSUI6Fg/82UAnHBljbhosyOZme/
         hXFEiHSGknAdnhr4m7UkC0iwTNsIyejX5B3X3YKaaevtl4BuWC3PInaosepBdR6o+m/8
         2FYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwf+i9ZmuyAQSwyv9be5OOtBobRDn+OOAdSHhlUSEyyMxu93Et7qKB32y0Mm2c3d0TyEJLCMJ6PjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9eMYRO7WVRAyvYmQ+eHoyFnUP1N1JGStGp/qjoF60J4hTjPo7
	TcqkguyRniK/3cflrgNpmGVUraMOXM9qa60JY6k46LVJXZPyHltk4sJolGy0FgQ=
X-Gm-Gg: ASbGnctLO8G80jeonNfYQkztBN+2zFsjkPazH2Fm+FhUTlM2VOIvVtCRgp1fIxPUVga
	0+SoYM7lVSFekuzmfGgNcgU+IT74/hsRhYDlLE3dANX9+59jLkrUGh95pe7SAc1y2ClVsrHAMTX
	75e+vFVb6hadXrySBpeyZr90+lG7EXD9N6MUkhbfNH53YoTNVtgv8kNUexffsxoD6rPjrxqiWwW
	fiYupGQmkt+y0HxcBAVvDu/nDACOHV23wlrkudeSMZ5araaMjCYZXqNDOX4Uexe6eozcFhl4Iu+
	lfMtIFQQbdx8Px7OSis25Z/ybYo5QWZrSFxid8Oqq6lVXWrL8mOiDtcvWA==
X-Google-Smtp-Source: AGHT+IFghfD4xU69d9XitN+9G/D9V5XoV5J6reB++FH/B/My9SQ8BVRJedHW6F+AYAfpPxe7ux9Rcw==
X-Received: by 2002:a17:906:3985:b0:ab7:6606:a8ba with SMTP id a640c23a62f3a-ab76606b5a8mr232774466b.11.1738778065181;
        Wed, 05 Feb 2025 09:54:25 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab71166a8e0sm773920366b.158.2025.02.05.09.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 09:54:24 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: =?UTF-8?q?Herv=C3=A9=20Codina?= <herve.codina@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: pwm: marvell,pxa-pwm: Update to use #pwm-cells = <3>
Date: Wed,  5 Feb 2025 18:54:01 +0100
Message-ID:  <266765abb8251bd60796a3c4270e3809bfff952e.1738777221.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1738777221.git.u.kleine-koenig@baylibre.com>
References: <cover.1738777221.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=TpqSOnoMvrWXemfbgCJPH3YeRF/bonSoXcUzvWn+vu4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBno6W8dWtaj4cUMGIwF5w5gV/ZCp2eGvCr2v81c xn87SbAtPiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ6OlvAAKCRCPgPtYfRL+ TvDUB/907bHQIbHV5ok48M2kKVOeEpYDp08cDbKuaYia/Fx2N0v/7FH8AAWICZRZLE/vEcZnGNM qg+R3mYZYFjgLW28Lh7bp5FOej7vUkYnVp09JCxUxSWUjPXTxn2H5My3eg87CRLyq5yOAePQ1uh emNu6O+cTTCjRZSSrgokGalcnxjLoWtUnsesv+Yj1O6vWAXmdSStfvqMdieyXy98weBV8dlDX3Q 9vgdy3nPQXzfL7iUWnSEgOrq6A1Vo9Bc28UtwB+lrPjrfIMcHQR9cH5+/3jOJKmdNS/BI60IIBF sjioh4W2VjZEKROmBBBuuWUG5RS/ISyXtAxWI60A+FLWV/en
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The PXA PWM binding is the only one that doesn't pass the PWM line index
as first parameter of the parameter cells. However this can be upgraded
to the mandatory binding for all new PWM drivers without breaking
compatibility for old device trees using #pwm-cells = <1>.

So bump #pwm-cells to 3 with the (undocumented) promise to keep the old
behaviour for #pwm-cells = <1>.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
index 9ee1946dc2e1..ba7fba67e19e 100644
--- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
@@ -25,8 +25,7 @@ properties:
     maxItems: 1
 
   "#pwm-cells":
-    # Used for specifying the period length in nanoseconds
-    const: 1
+    const: 3
 
   clocks:
     maxItems: 1
-- 
2.47.1


