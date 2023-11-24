Return-Path: <linux-pwm+bounces-197-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A26177F856A
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 22:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8ABB21BD8
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 21:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3122EAFB;
	Fri, 24 Nov 2023 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qnBC/031"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B61C19A6
	for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 13:21:22 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b84402923fso1236487b6e.0
        for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 13:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700860881; x=1701465681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnKHeU25e3GbyNJri6YXYszp+5TU6nTPAt9UQPE5y8A=;
        b=qnBC/031fY/LzYHmOVguRsSYpZ0w8X98YZy066LXudbHct9hJSo8eX8lFBL8kzLQ33
         JRKq9dZDiehezIIcOSuRi6/j/r7eMLXj/fD/BCFjcEJT7W8GaDhQA8C4LCsk2D/WnXIY
         RQGwVnXeIHu11uWi2JUsj1vLNcZoGjSzlxixlGadNePsMgpu+3E1XyhP9D/Fb/KHF3jC
         BHESqrWpSStIA5ecnWkjrEGtqA4tJaxRWINmwQJvhXcgLM0sUj206jpFAin3nRhXAbOJ
         dpInHLUMy+SIBCq76cWjjN7DgDyfdoYvci5aw1fQprmYTtiVp2cxqph+9cf0aftEkOED
         P/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700860881; x=1701465681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnKHeU25e3GbyNJri6YXYszp+5TU6nTPAt9UQPE5y8A=;
        b=Fnns2oOJ3+T939rM/4J4jJxFwEIsb8zwbDoe50qhzkri/usBaDCfVecYwVaaIrwmPd
         EewymUgAVQF7eM2wXfsa7IcggZzZtw8ni9ZG/LJEZRe1nn5AgTNmGyRMeKAYwPI8WRXw
         s2MAAjkyciPThgkV0WSFjTeBDvCKJCgkJBWOLD8W7NldGzuhT7Aa+V6pyvFzaoc+IdG2
         56wtI3EZ4gi7YoIb2p9+ppjlsRWZPyTAxKT4H0lWomAalNrLSBrnLS9Ja9Va89+bkTps
         TxpyJd6MMMaQm3iEWkxz1qs59No4OBMJvHkfH24Kymx2B4yb67rGyeAvEvFfYe/+rN3w
         GNnA==
X-Gm-Message-State: AOJu0YwNOfumYwVZ8xXh48pI9a4f2c3gdN36JTZrp4WsSKOj9aT4PSBT
	Xt4aREHblsfFph5D2g9MtkJiC4DkuoRV45sRzQcSTA==
X-Google-Smtp-Source: AGHT+IGKKBbw94VykJk9hcfCpD0tqOqjcIPyxhffqa24so6+G+3kcZKo+3FBtWc4bXyIfOk1pLb9VDXMsNjAME0otLY=
X-Received: by 2002:a05:6358:6f87:b0:169:9859:ccc3 with SMTP id
 s7-20020a0563586f8700b001699859ccc3mr3049189rwn.12.1700860881296; Fri, 24 Nov
 2023 13:21:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>
 <20231122115621.GK173820@google.com> <ZV43NHr1QN79lsaJ@orome.fritz.box>
 <20231123104458.2pfaowqylmpnynhx@pengutronix.de> <ZWCWqcxbAtmNPY85@orome.fritz.box>
 <20231124182252.r7br2vgr5ralwoua@pengutronix.de>
In-Reply-To: <20231124182252.r7br2vgr5ralwoua@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 24 Nov 2023 22:21:10 +0100
Message-ID: <CAMRc=Mf_xndugSqoY+uLHxsE+c2ztDfZ=eSh4xCGVCAbA4hjSg@mail.gmail.com>
Subject: Re: [PATCH v3 102/108] leds: qcom-lpg: Make use of
 devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Kees Cook <keescook@chromium.org>, 
	linux-pwm@vger.kernel.org, Lee Jones <lee@kernel.org>, Luca Weiss <luca@z3ntu.xyz>, 
	Conor Dooley <conor.dooley@microchip.com>, Anjelique Melendez <quic_amelende@quicinc.com>, 
	Pavel Machek <pavel@ucw.cz>, kernel@pengutronix.de, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 7:22=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>

[snip]

>   - gpio: See how both gpio_chip and gpio_device have base, ngpio, a
>     parent pointer (gpio_device has it in .dev), an owner and a label.
>     Do they all have the same semantic? Yes? -> that's bad. No? ->
>     that's IMHO even worse.

For the record: I am very well aware there are a lot of things wrong
with GPIO at the moment. It's years of technical debt biting back.
I've racked up ~100 patches last release cycle alone fixing various
cases of abuse of GPIOLIB in the wildest places (OMAP1?!). I'm slowly
doing cleanups all around the place but since GPIO is so ubiquitous
across the kernel tree, it's going quite slow. I'm going to get to the
duplication between gpio_chip and gpio_device but we still have users
in the kernel who shamelessly access gpio_chip directly without being
GPIO providers.

This is not an argument against the general approach I presented -
it's an argument against stacking up years' worth of cruft.

Bart

