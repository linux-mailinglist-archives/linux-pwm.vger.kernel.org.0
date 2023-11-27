Return-Path: <linux-pwm+bounces-208-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1AF7FAB45
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Nov 2023 21:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3153FB210A6
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Nov 2023 20:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153BA45C0E;
	Mon, 27 Nov 2023 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nNls0p4r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9860D4B
	for <linux-pwm@vger.kernel.org>; Mon, 27 Nov 2023 12:22:59 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso2909876a34.0
        for <linux-pwm@vger.kernel.org>; Mon, 27 Nov 2023 12:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701116579; x=1701721379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/bS8JZsR5Xkozsgek0v9/rIv0VnVWFwFU1wB1jEnR0=;
        b=nNls0p4ricOE/XIFSn9rDaNm69JJRiFGIxMmIYmdmJDAFCPWMZSNqvk+tm08MtG7xC
         0AqGVZl2/IcK6WH5NP9o3V7HN3Rqiexi5ZUblrN8+F/N4YL4ii03FYp6fB4sZiCRURox
         p3F1mRRHX2xyciG9gMQJTb7lQTjA1hbBXExm75Wve/mLMMRnjQcy3hvFHNVicBHoVhut
         mqFkPxcAkDZlXEqE/F4zp8h9p+6CTe55O4422fovqvh0q7pdOVdLozXQIOw6CJfH7EqC
         nqsw84hy4/tWwOtIhlbIGOShC/6EtICSOOsPcdYj1pjI2AaLTZG7JzciR6KoUM/WRvsm
         izdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701116579; x=1701721379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/bS8JZsR5Xkozsgek0v9/rIv0VnVWFwFU1wB1jEnR0=;
        b=AihEq29HYwf+6UiHtIhAaoT+4+kQsZMxBbx+sa2J9RD2RFnXxlHdSvz7pYFXf43Bhx
         EnkY7/Bek39E8Cyb9MkvCso+oEX2KYrLexZarvqlk/+17Ep3NXJpxoJtIp9Jyt1rUgjk
         TNGeLSorrcUB7Aes4rmGcXy0aHRKXUF7Ez4n1zo4IIBpE5SWsRiGaZOCX7ef15FX7I+v
         Gc+lEYDrH7VyHnnVAXXEF/487P8uB16JjpunckFhFLBhMPAas+3C0ofQ9aITyOEmcIg2
         o9m8VNNhI79VbjSI+vbGGAVRjwCUUV2GKZS1ZZLTdcPZklEPZ8lXb2W/57rEqW3hF71V
         NI6g==
X-Gm-Message-State: AOJu0YwD62l2chIz42Y33XcaQbb2XTpzd5QmpYthniR6ct1g60uCG6N5
	feYFodlmD2122ZKK83Bszce1WZKNlLe+c1th/9x7lA==
X-Google-Smtp-Source: AGHT+IEDdGlIDucDtERFKH32v7M8YyPDwiBS2TPxGnrP9rxx3ZGOL3f5lj36/cxhZUdtjOrU3Od+i+y05Nq1DqsLQAI=
X-Received: by 2002:a05:6358:5291:b0:16b:858c:1ee4 with SMTP id
 g17-20020a056358529100b0016b858c1ee4mr13192394rwa.1.1701116579131; Mon, 27
 Nov 2023 12:22:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-101-u.kleine-koenig@pengutronix.de>
 <CAMRc=MdSc3emU+AJpCni6is0qsmR9HcqysSL33gpAmb8JTnjVA@mail.gmail.com>
 <20231121161111.zphi7pn77ns7sgu2@pengutronix.de> <20231122090502.tcscaaaf7vuk6g7w@pengutronix.de>
 <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com>
 <ZWCTtPVkTUQNLVoa@orome.fritz.box> <CAMRc=MeuJKJWOXJQZXQr5mc-NB4mh_jF0JW1LuTNEO9EhTYncQ@mail.gmail.com>
 <20231127105844.kpu5ori6o6umfynh@pengutronix.de>
In-Reply-To: <20231127105844.kpu5ori6o6umfynh@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 27 Nov 2023 21:22:48 +0100
Message-ID: <CAMRc=Me=J0f4epqmeLasqMYfMjMz46jpfmBpxV2bHGcp5Ev47Q@mail.gmail.com>
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 11:58=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Bartosz,
>
> On Fri, Nov 24, 2023 at 10:16:40PM +0100, Bartosz Golaszewski wrote:
> > I admit I've been quite busy but I do plan on going through Uwe's
> > series next week and maybe running tests similar to what I have for
> > GPIO on it.
>
> That's great. If you want to do that on my tree that already saw a few
> improvements compared to what I sent out, get it at
>
>         https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking
>
> . The improvements are only on the driver level, so unless you're using
> one of the improved drivers, the difference wouldn't be that big I
> guess. For (maybe) quicker feedback loops, you can find me on irc (e.g.
> on libera's #linux-pwm) if that's a communication channel you like.
>
> I look forward to your findings,
> Uwe

I don't see anything obviously wrong with the approach. I see the
chip->operational field that is set to false on release. In my
version, we just use a NULL-pointer to carry the same information.
Interestingly you DO have a pwm_device and pwm_chip structures. I'd
say it would be more logical to have the pwm_device embed struct
device.

My approach is more about maintaining the logical scope and not
changing the ownership of objects allocated in the driver. I also
don't see a reason to expose the internals of the subsystem (struct
device) to the provider drivers other than in callbacks where it is
relevant. Subsystems should handle as much as possible and any data
structures not relevant to what the driver does should be hidden from
it.

Bart

