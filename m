Return-Path: <linux-pwm+bounces-4784-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28A2A29819
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 18:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28A81881CBA
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A5A1FC7C2;
	Wed,  5 Feb 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gxzQnj/2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E531FC108
	for <linux-pwm@vger.kernel.org>; Wed,  5 Feb 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778068; cv=none; b=YNGJpxfNO6jZXr7G34BEVZ6oIOv/MbyapsxPfSFrOI/bAP6wmU9MA8xBGcJ8O6WOWMSmP8znKAMNMi9MDJMF5TfLXMZullIDAh2w+sjh9P6IowfP9jCZzuEmJno5X7J5aBObNAGXVlXkUmnW5G0IpFgnLMyVP6JfZsWrVpRTBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778068; c=relaxed/simple;
	bh=JDsPD6H7sq2JssXSPZq5WPbt9ev+FcdfTWuhqbRmUg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oj3ECq6ZUAIMNq0s/s1NQ1BZzWKImkW/jsV0fFR3nljZvvGPHzvq64LiLl3hgFD8BDFjeVZwuQPB9+0WBJpiRey9ZBYBy1t1yCSMC0a/Nl1I14gQuRF61S5uXJTVkMYRr48nr5Cn2bcn5DfHY+Mm2ryIvMz7vQeE+oz3BTfuntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gxzQnj/2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dcea5d8f16so149033a12.2
        for <linux-pwm@vger.kernel.org>; Wed, 05 Feb 2025 09:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738778062; x=1739382862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCMKE5gzKgu/HvyulYhfT2Ja0Yjz35cFcUjQJgI8Ync=;
        b=gxzQnj/2ZHxEFKj+xZ4O7Poncc85Oa1/8l/o/CdR4I91UF7Kf5cFbHoO4HMj+TEr2D
         xVVpTPwjSLS+v6L+mogYET938HMDSvAnOPKQC6bRLvpxRVJeoX0eBao2b/gxdAVK+iV4
         8tz3TS8rk7gb51gJZPingBmGB+qz65fj3Pn1kOUX05fuFsIEg1gHXV5CSnANL3hZhN3M
         ngKGVcWOkig06kDcwQH00iGkb1hbKluPB35RWCmff5YhUgRSkrGsu3jbzBqFYDKCwts7
         6YVY6inHNkGQf8DHKYDjxGEDpB4X/0vfJz1vxawpOgHPCOIItYCubUV0TgAAEtVFtAK2
         w4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738778062; x=1739382862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCMKE5gzKgu/HvyulYhfT2Ja0Yjz35cFcUjQJgI8Ync=;
        b=j32iE+7ATpyflJfSPHYsvnrl4De7at58C2KApczZrNeBbPOS2wJuJTQL8/pe+dvOWu
         0h+OD6vTh8vAFeqCIzxE4V9Ln1/xCILBEGNn0cVDC8Z58RvYEO998sLSyY1XxkgKm7mp
         lifUujPW91RYYxJmus1eTqrdhGMz8RvpSTjNPpAA6KJn4bGbm6e5A9PvknaeoE4XdhUw
         SRuPNOq3gKr/2eHdvjS//6dC4B46K1DZM/A5bj7ToN0mzYJIyODqw+Od8/H4V8Ei8FkR
         yU2kMUt1EGQm/2RQonrunihwNKLa286uIak0UFA7QGbzM2D37JT6GVsAeSCajeiOprV/
         ghWg==
X-Forwarded-Encrypted: i=1; AJvYcCWb8NaGJbS9SMG5LZLFuewllIc3+a7A7H26A4u1rTbvn8wcBfJBEb/RlWJrJSZqnqk+OiAzCDmcTjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHGajQPRptf3g8YSWZchtf9IpUJwHONnwdyR6d2c8C8EDB5pY
	zPCY+ctURpy/bTuIyTIALFP5rvK4Wh2S5ScfmpfJ7G2xsnFNj6FG0eHfIu9svNE=
X-Gm-Gg: ASbGncsKRM12oQAs65AjuaQsZj4edrXYimsJULgIO8mqknq4FSpiMmQzzrH9bN7ZGdg
	YU0RnCwwn8eT6C1W7DQGPmPn2lSW08lZhvU0K8dX+FGFw1dERKRnBWr9wtf2c1B1chfeGaL/bWW
	iBO5Iec634eB+aMlQAGyn83NXW7AYUj90jYv6yy25hr0GpZ++kXQUp4Wg8UULomKJdt9TaBl1Bz
	jDH4YJka2tun1RvGLDucHdjRcKS7O06p/UH5nEkfqZc7TbIfxT2hgihqzsQidotAtmFeuPOBhV5
	kQQB5aWcKIl/Y8GkLP9+W8kZlpoi7evgs+kuEAA5XeL7VO/eVjVla+HYAA==
X-Google-Smtp-Source: AGHT+IGwFChnLi3ypYCTZHAHkBmrw8K+5yHJCBID2rJDb3472Yl7NGdTkpLX4by9169XWQPNNr7i/w==
X-Received: by 2002:a05:6402:234f:b0:5dc:da2f:9cda with SMTP id 4fb4d7f45d1cf-5dcdb77a00cmr5000144a12.27.1738778061929;
        Wed, 05 Feb 2025 09:54:21 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723ea218sm11385857a12.31.2025.02.05.09.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 09:54:21 -0800 (PST)
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
Subject: [PATCH 0/3] pwm: pxa: Use #pwm-cells = <3>
Date: Wed,  5 Feb 2025 18:53:59 +0100
Message-ID: <cover.1738777221.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=JDsPD6H7sq2JssXSPZq5WPbt9ev+FcdfTWuhqbRmUg8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBno6W3nGyFzH2RWbXMNkDi7NRuJZY1Mdd/uPZtB mi/Hqxh8yKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ6OltwAKCRCPgPtYfRL+ TqFjB/4mMGV2Y07JilIJeoyM64TvtCXPufPc3lftW4t+VffV2nwQ6OLwLX+5YEccyi/f9YSA+d0 4WxXZYZCfQSn0TiqfSAwXm4uPNwjiJWWvmeEXDGjo65qwGSrKuqXLHomRbjgaO/U6p1z/F5ZWNN lnhWGvWiVP0jUiOqw8Rm5Phh22liOqmuqpgZN84al0Oab0/Sa3BUqg0hNTgc8KWGB2ZSRQzOjuD 23PAkaPxmgCnvt5H7iFAgV3fcjOfLdR8DF3qRmkoh+NQXfbAxzfua2b1tw7w6Q44rFH/1vpTiau /AF0kWibrfiJUjW5xK7cjmhO0scrEAJSxr82XPZ8ZcLJ8i5U
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series' goal is to soften the special device-tree binding of
marvel,pxa-pwm devices. This is the only binding that doesn't pass the
line index as first parameter. 

Here the #pwm-cells value is bumped from 1 to 3, keeping compatibility
with the old binding. 

The motivation for this was that Hervé sent a patch introducing pwm
nexus nodes which don't work nicely with the marvel,pxa-pwm
particularities.

For merging this series (assuming device-tree and pxa maintainers agree)
I guess keeping the patches together makes sense because with the 2nd
patch applied but without the 3rd there are a few dt-checker warnings.

So I suggest to take it via my pwm tree as I guess drivers/pwm/core.c
has more potential for a conflict than arch/arm/boot/dts/intel/pxa.
So please send Acks and tell me if you would need an immutable branch
for pulling into the PXA tree.

Best regards
Uwe

Uwe Kleine-König (3):
  pwm: Add upgrade path to #pwm-cells = <3> for users of
    of_pwm_single_xlate()
  dt-bindings: pwm: marvell,pxa-pwm: Update to use #pwm-cells = <3>
  ARM: dts: pxa: Use #pwm-cells = <3> for marvell,pxa-pwm devices

 .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml |  3 +--
 arch/arm/boot/dts/intel/pxa/pxa25x.dtsi          |  4 ++--
 arch/arm/boot/dts/intel/pxa/pxa27x.dtsi          |  8 ++++----
 .../dts/intel/pxa/pxa300-raumfeld-controller.dts |  2 +-
 arch/arm/boot/dts/intel/pxa/pxa3xx.dtsi          |  8 ++++----
 drivers/pwm/core.c                               | 16 ++++++++++++++++
 6 files changed, 28 insertions(+), 13 deletions(-)


base-commit: c98e66144b7d07ee9a3ca8241123b628a8ac0288
-- 
2.47.1


