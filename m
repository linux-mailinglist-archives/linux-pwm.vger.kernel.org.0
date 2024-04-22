Return-Path: <linux-pwm+bounces-2046-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 503A18AD47E
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Apr 2024 21:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC69B23933
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Apr 2024 19:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23271552E3;
	Mon, 22 Apr 2024 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Rjkre8mY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79E154C19
	for <linux-pwm@vger.kernel.org>; Mon, 22 Apr 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812407; cv=none; b=exo6gSLf/i4T8f8QWCEGKtTlxeBtHfc7j2PAQwsEFGhCpM3aowGOM58uTRtScHW7wh12Cy1C/vW293YR4307tv4TWHVz3MJQBZhwMOiofBzXkoEVvz5G0My4wwLPzi426fX1geZmJby2ZyplJNTTbRIgxp1uM3XeftqvO5rIoSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812407; c=relaxed/simple;
	bh=R/k9GeuVsqRfJQNhvmY+sjzEjnrvbvRFyBayzV/tSS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbTKDgm6MQRHb4M6NiPFRdJ7SqNJzA99TnW6EjasE8tsDapxuRbcgQEwZ4ljEa+pzGuOLZOXL3ZMCNVElfkhTBFhUJlHnS/szbUrNp+06ayYf8Az1fZwud7D9FVm2sPo2gMQHSD0x1tAblNESwDiTfKUZTY2+1MfDOR6I+dKPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Rjkre8mY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d9fe2b37acso65611381fa.2
        for <linux-pwm@vger.kernel.org>; Mon, 22 Apr 2024 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713812403; x=1714417203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9SemwtON7A98la+Ke9Xhy0bzXzNwzzzRJNIbd9rrBw=;
        b=Rjkre8mYpErGOpPgmXEiR9wH/4O8NPYxcnMCnFiNjjvAxzjAkfUCtSbQMghutMvevn
         bdj4oMh6szwqlQoUfnQvCC2FfVPtAtdrmAayGvqPIH/nHeOlk41pob9q00syVbJ1xm9j
         RYmqaO/qcvNl0Gj/bnotVD1VGTTzetJVsXp0b+yitbPu03ZLP/VYhh4lDzArcFofOKCk
         qBz2YYdpxWcrCldtY8+PrZK30ZNnkaQJLFFIo6aGJPm54iPYZVyiNQfdU7+4et8B3mt5
         H4dNyMSFl4Y05oFdhPs9hCl8HTVo+iJ9B/yjZ2VZtMrnWfBq7QfrimZmCt3+hswYik/M
         ofEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713812403; x=1714417203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9SemwtON7A98la+Ke9Xhy0bzXzNwzzzRJNIbd9rrBw=;
        b=S07VTmGLV8u/ZmyGQwZurkf3jNky6zqp01qUZl7/mWUCU9Sq53TtREaJShPOO/Fx08
         g+m31+mtmQAgSotf0hYFJBuVDa8T8pUA86L8mGxfB/u5goGHK0F9MeNxkBSXmPLV/2t6
         9HiODcO7ZA/aEBhrHdGDIZRJ/bom7pVhnf7vboSYSenpi92II5zRn6jt4hw7MrtkKeYY
         HL73d1epcSWCyPrQ1IafQs6NZaI8N+/N8FR/gQpLTG36wPRNFBWPtcdtj7xkWNxA4yHz
         4zswiaVPImpUhPDzolXXGHDd5hIdx0KO1crD5IT7zuL6COsu7Rm1G2kiQ/ZPQdMw1aXF
         dY3Q==
X-Gm-Message-State: AOJu0Yw12Dc5zv62hdeF95JcdzlLP5ycgwDU2O9wYQcwyhmydqqPwBFM
	Yo6x8l2hpYKp8w7OcOyvekpgdFLzIsWGxn0pjEvAjKbO+BL61jB4Lc6puGiXZ80gM3iSJj3hT4x
	Z4+fKg7CGibDs+57xpY3BBTog2q0Inr99jvlelg==
X-Google-Smtp-Source: AGHT+IEnCuHxcQSRNOWbQ2Dz0Mc1O47603xiH5CBs7TFK19Jt5ZVAeGit7g/5ax+OSHEdGypKtc79+37uJN1rw3iklA=
X-Received: by 2002:a2e:b712:0:b0:2d7:7c0:b077 with SMTP id
 j18-20020a2eb712000000b002d707c0b077mr6756289ljo.43.1713812403192; Mon, 22
 Apr 2024 12:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710670958.git.u.kleine-koenig@pengutronix.de> <ywvi3wqcte5wfwq7twg26smtu7rgjv5z2tbdu6mz5cehjlxf72@2h77sey4xsv2>
In-Reply-To: <ywvi3wqcte5wfwq7twg26smtu7rgjv5z2tbdu6mz5cehjlxf72@2h77sey4xsv2>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 22 Apr 2024 13:59:51 -0500
Message-ID: <CAMknhBHdmvyw8zeYRUrqBj7jchgtGBPw5FEmNwXbjTmoHWUdYA@mail.gmail.com>
Subject: Re: [PATCH 0/8] pwm: Add support for character devices
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, kernel@pengutronix.de, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, John Ernberg <john.ernberg@actia.se>, 
	Thorsten Scherer <T.Scherer@eckelmann.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 4:22=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Sun, Mar 17, 2024 at 11:40:31AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > After the necessary changes to the lowlevel drivers got in for v6.9-rc1
> > here come some changes to the core to implement /dev/pwmchipX character
> > devices.
> >
> > In my tests on an ARM STM32MP1 programming a PWM using the character
> > device is ~4 times faster than just changing duty_cycle via the sysfs
> > API. It also has the advantage that (similar to pwm_apply_*) the target
> > state is provided to the kernel with a single call, instead of having t=
o
> > program the individual settings one after another via sysfs (in the
> > right order to not cross states not supported by the driver).
> >
> > Note the representation of a PWM waveform is different here compared to
> > the in-kernel representation. A PWM waveform is represented using:
> >
> >       period
> >       duty_cycle
> >       duty_offset
> >
> > A disabled PWM is represented by period =3D 0. For an inversed wave use=
:
> >
> >       duty_offset =3D duty_cycle
> >       duty_cycle =3D period - duty_cycle;
> >
> > . However there are some difficulties yet that make it hard to provide =
a
> > consistent API to userspace and so for now duty_offset isn't (fully)
> > supported yet. That needs some more consideration and can be added
> > later.
> >
> > A userspace lib together with some simple test programs making use of
> > this new API can be found at
> >
> >       https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.g=
it
> >
> > .
> >
> > The start of the series is some cleanup and preparation. The lifetime
> > and locking patches are needed to not crash the kernel when a character
> > device is open while a lowlevel driver goes away.
>
> This series is already in next for some time, but I'm not sure that I
> want to really send it to Linus in the next merge window as there are a
> few issues with it:
>
>  - A (false positive) lockdep warning reported by Marek Szyprowski.
>    See https://lore.kernel.org/all/5a49cadd-21b7-4384-9e7d-9105ccc288b3@s=
amsung.com
>
>  - A speculation warning flagged by smatch that I don't understand
>    completely yet (and failed to attract attention by people that know
>    more about about it)
>    See https://lore.kernel.org/all/1e3dc81d-dcd4-4b04-85b1-23937e2f0acd@m=
oroto.mountain
>
>  - I'm a bit unhappy about the rounding behaviour. Actually I'd like to
>    only provide userspace access via the character device to drivers
>    that adhere to the rounding rules for new drivers (that is: First
>    pick the maximal period that isn't bigger than the requested period.
>    Then for the chosen period pick the maximal duty_cycle that isn't
>    bigger than the requested one) to give a consistent behaviour. This
>    is further complicated by the fact that the character device exposes
>    a more flexible API (involving a duty_offset instead of polarity) and
>    the natural extension for the rounding rules with duty_offset is
>    different than for inverted polarity configurations.
>
> I currently consider introducing a new callback that in the long run
> should replace .apply() and that properly implements the duty_offset
> stuff. Then the character device could only be provided for the drivers
> implementing .apply2().
>
> I'm open for feedback, e.g. suggestions for a better name for .apply2().
>

Waiting to merge this and giving this some more thought first does
seem like a wise idea.

