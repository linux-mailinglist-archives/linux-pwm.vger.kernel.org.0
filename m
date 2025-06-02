Return-Path: <linux-pwm+bounces-6208-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5044ACAC5A
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 12:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E055A189D83B
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94861EB5F8;
	Mon,  2 Jun 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="glJd32y7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16671474DA
	for <linux-pwm@vger.kernel.org>; Mon,  2 Jun 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748859605; cv=none; b=DdIzUn268INAz0wzz8wjIePo1H+i6/pTbZsrLqPQXT+iUdR7HE21sdbFrvNn1sqttRU2C/O3nV3OqP7pXEL+y6jC0fFsAXtHOE/6ZmJN9maUjmeHj9ivbFfNAYMMCPmtQPlk5589di66Z1S+LKxFRnfNuYLfrlOXHqobDG2IdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748859605; c=relaxed/simple;
	bh=NIlPs+ESOqsvDgZLDklVbzL9Y+PUvN6JpIx6y7pwPq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAeOoOiLnYnkkoL8uHDMH66/hUfvNJyF1SPGjjKbUwY32f2lC/x4ppMxHob1OSasoQ9dFfI6dWSvF5E7Pt0XAWarrfxoeZz0Ya/mSd55gxrY1lkxI+D9NbHipz3oDxZhlruRj3J1rK9pyoc1Mcr3mx36Udd7KKPnY+kdz3MG2ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=glJd32y7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55324587a53so5974382e87.0
        for <linux-pwm@vger.kernel.org>; Mon, 02 Jun 2025 03:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1748859602; x=1749464402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIlPs+ESOqsvDgZLDklVbzL9Y+PUvN6JpIx6y7pwPq4=;
        b=glJd32y7JS6LNeMiz8W2iiR+4lp8rqB4HaSkUA9fbw3QA+94EYGJpBuwrGF0CdS8HK
         C/MXBHUP8tLJVidF521G6My2nYMPEOjOhwXv7JbBAO/JCYBEM/7+0DGdCxLqDYHCAdEt
         znyJWOGrKkyNnlBk4yksb2+cgm9MeTXuOQtaw8jckEUqTchTb8G7QIPfjVGYXsACyuxu
         s2bbpXAgLNnkDiObjQu+71KYhRwTybu4qtO4aJ2Qiv3X1371JOjBrrBG+NocR+0aiTy/
         zm6YQLKx/MTcj9DgXgY4my+rHnUVCiklwHyZuO92sjW2FijdR+IC3nNutUMCrZN1Nerh
         J3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748859602; x=1749464402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIlPs+ESOqsvDgZLDklVbzL9Y+PUvN6JpIx6y7pwPq4=;
        b=wcF4eGcMUTMpX1TpreCeGtgKd1u6gyOGO8efygBI/TM8LrnhSOEqR2daD+ezHuX6bW
         4TRIB3/yz1wFv9X9qzMBjnvBd5GjGC5nmtK2KwqmaRj6W45T2/aODaVCXAjhAaKc3rIR
         yX6yOL9yHbROfDF1M8wfMYPrDZyA6Rew1iKFcBBjik9i30QaoghgqFGGEXEa8Hf98uSB
         wTGC8faaA0yNotoH741ZKMorsTSnlVPEPuHgvZHLonCMrfMJjEcsH0YMArr/Ltp29OR2
         KZMUoM1GgE8WgEA8+lHPZv6pxVmZlKHh9yeHwbq0FVWDmGiZmooYsJjEZXfShoGsvJXV
         AE3g==
X-Forwarded-Encrypted: i=1; AJvYcCXDhtjJJtl/Ph3htUn9zVfbmgT1X+psu4wOxIwD6eDpqD9on1nhxKzvNBKtrNTfKMdSi2d8gM3WJJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyC8QGEhC6iVU2nw990w+XKk31Ss1IVXGn/kholSMtTpQyyxLg
	i+hASOBKqJZsCWSyD9aVJRqROMT2ALO6VTdgV6ovV+o9h0lhaNI1W4E6C25dNFDCrshHqSYfIai
	0M+x4HJvAsQovMeRSGWAGLiNGxcyfamJYugSO/XO7iQ==
X-Gm-Gg: ASbGnctjJkVWK484yFRh70MzxOtDvINol1DgvXhz+X64/lpFfPs4GdP2Iv/dz2Obihs
	0y7SFSLwN1n2j7ygbbCRXdsMJe70SPMslpI47smIG868gvFE4WEGNgcrkiL3f3mh3wQXBUh1ERb
	gyNXZ1GLyou3UhgHkJDbcqSOmoqAVWkP6DleUAWna0/0e1SdULmeuFZcEpMgOM3136
X-Google-Smtp-Source: AGHT+IGAtxy6GkCqOPbxv+uZc6VGUawOyddEURdLOtYulQAX/H29kqSWQGJzmIVuwy/b0vz39hl6HX77etZ58j+aC2U=
X-Received: by 2002:a05:6512:15a7:b0:553:278e:e64b with SMTP id
 2adb3069b0e04-55335b0aa20mr4535065e87.6.1748859602083; Mon, 02 Jun 2025
 03:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com> <20250530-mdb-max7360-support-v10-6-ce3b9e60a588@bootlin.com>
In-Reply-To: <20250530-mdb-max7360-support-v10-6-ce3b9e60a588@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Jun 2025 12:19:51 +0200
X-Gm-Features: AX0GCFugojk72c7cm4zkMsB7ZrEhUkwTFOc5dkzcwC-isnDlIuPSAwn4kkDrnwU
Message-ID: <CAMRc=MfRZQE3dn38oS5Yteb19HbEhmfwyc+oDvDeP_fMg+ZpTQ@mail.gmail.com>
Subject: Re: [PATCH v10 06/11] gpio: regmap: Allow to allocate regmap-irq device
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:00=E2=80=AFPM Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:
>
> GPIO controller often have support for IRQ: allow to easily allocate
> both gpio-regmap and regmap-irq in one operation.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---

Looks good now, thanks for addressing the devres issue.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

