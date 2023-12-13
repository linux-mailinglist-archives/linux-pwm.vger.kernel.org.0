Return-Path: <linux-pwm+bounces-556-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B51812003
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Dec 2023 21:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67A61F218AC
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Dec 2023 20:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB4238FA3;
	Wed, 13 Dec 2023 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3+W+0Yf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB3EEA
	for <linux-pwm@vger.kernel.org>; Wed, 13 Dec 2023 12:31:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c236624edso73150455e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 13 Dec 2023 12:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702499479; x=1703104279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICD2CiUy2kPTcekej3mUTOtcpIsi95RwDi3MnmW2MN4=;
        b=T3+W+0YfkQmf1M6D8zNbCwXPjlfiKoZEg+ZFzW196ESGNmXEViwh2kGIyxUuG14e2y
         0U6OgVTC21GA6WuW5kPoyz1+/CVawGUGVw+Ep22/T26u9U1ig60P5QvNSWw5qoVPG8Xr
         yjzBa/dEtMaKUbt1yH8rP0X9wWzeLX+wuQC/FCjhMMncilFDkBNbrDbI+viGiJyBxJ9M
         +tBZPCB7A/yqcUwAnorQNV9cDpDaN264neJQMNopNBZxrkF1329xmicmRmbayIsLCthp
         6BjbKlgWpfcwErNRne0bJ+JGwzDnjqUVTAWtMVpkN0GKfLq58hJZm16thRU50GgoQ3Eb
         1OKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702499479; x=1703104279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICD2CiUy2kPTcekej3mUTOtcpIsi95RwDi3MnmW2MN4=;
        b=aegg9CAeUfbJFZfPLd8lTWzleOZlNprhKdsWFcoxZ54UiB/9MghOya/ySn9f5tU1i4
         4Qa+lfK2J4Ju7ZCzGJLQDaNY4rzbwMv5X9TQDbYou/PRN2loZC0jW1yQXvzUzcn5bdnE
         Z4XBciycXhcnQU/CRqdJgqkTlgx+PSUdiZbh1HtlwBm2Z3P8YnR+NRwxyBQklmTitQel
         krDtbIndiDy3HjMFJriRXhrZSZFZBubmrW/ulXCh6/LToM7azCkFdXkwkS1JX09Nyqp5
         Hpib/VRCH+zDCW0BeLIQasKuF5jCfK/k0wINKc8BwUnBbz/z7Nadz2OjceOEz4hCNAMN
         QZEA==
X-Gm-Message-State: AOJu0YxZyXbTF+0tBKzKZngKFafu0rKZiW3uq37FgQ4bqNoAuNr0S4GP
	a9lUah5dT0DsVarAWW16Pl4bExDXH6E=
X-Google-Smtp-Source: AGHT+IH1E3dO9IYZc40hIHwrwd7KNGrYkdbH3kDyHBRsm4jzyoaYicZGuhxvorwUigigeqIpbl3/Sw==
X-Received: by 2002:a05:600c:2307:b0:40c:3915:be63 with SMTP id 7-20020a05600c230700b0040c3915be63mr4188911wmo.150.1702499478628;
        Wed, 13 Dec 2023 12:31:18 -0800 (PST)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b0040c11fbe581sm21565084wmq.27.2023.12.13.12.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 12:31:18 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject:
 Re: [PATCH v4 097/115] pwm: sun4i: Make use of devm_pwmchip_alloc() function
Date: Wed, 13 Dec 2023 21:31:17 +0100
Message-ID: <9208689.CDJkKcVGEf@archlinux>
In-Reply-To:
 <c79e120b120df9eedddaaf70364d28e15df23d91.1701860672.git.u.kleine-koenig@pengutronix.de>
References:
 <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
 <c79e120b120df9eedddaaf70364d28e15df23d91.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, December 6, 2023 12:44:51 PM CET Uwe Kleine-K=F6nig wrote:
> This prepares the pwm-sun4i driver to further changes of the pwm core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



