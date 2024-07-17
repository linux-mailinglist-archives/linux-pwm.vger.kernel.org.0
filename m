Return-Path: <linux-pwm+bounces-2843-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB49339AC
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 11:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672A4283CB0
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 09:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B838389;
	Wed, 17 Jul 2024 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eMx10UhJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337D210EC
	for <linux-pwm@vger.kernel.org>; Wed, 17 Jul 2024 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721207623; cv=none; b=jj0eyqCg8M4PEfBGaK37AcHQbyYtdSNNOJIHxQihpwAShCjrtb/0PGO6QVxfX4VjCCWErbjmY/3JbyFzU6dJf4VaS3lI/c8qx9kGFt/575dVCwPMhRZuLED15xV2mrrWt/Qz61HFWzoL6QrA0cLzvzOdkTGLwF+PHy/v97Qna0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721207623; c=relaxed/simple;
	bh=6AYSi+0txOPts/0zSbdXE6lcveJvoTicIZEX0auY3LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cezIq+FqbwVU85tA+2c3iF17zoXU1V+YYVJiNupJ3bQrAfm3OI4/H8tEQWKUqXheZYgNvQGPM4fYc84LqiQlIs1YPdOcc3gVcIBo1uYPB17JR/q1j6cL0swL/TbUWUFRRtsV9hrwCnqhz3RKe74JcsS+R1ixRHDoSqfFGeSvhbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eMx10UhJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so106540966b.0
        for <linux-pwm@vger.kernel.org>; Wed, 17 Jul 2024 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721207619; x=1721812419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7iWDU5uG0cOtj5H+2dTM6DmA/KW/B3bYe6OR9QM0Sg=;
        b=eMx10UhJ/d6yBHcFgNBnmLA5N6bs3KW0pzyQY9kEwWjQULQynfOKon+5h0PGrllI2W
         zGiJ/YmhQbZHOwNk4cBPgpJKIwflh/mK8/W8gITrXovFI4/AbNL8xPj9jSOWmSgM3rb7
         eTaX+Y3SWSLAp8qpUG2Y9WHCCNvt1abu2Ft9wzRUWwa1f3P4sekM8OLE66W9sy/AtD1g
         kuqhV06yJrKnASP4s/PtemtcfpqHN/ef4FAWnI/r0sObIwKZRZBWvUpHWFj4wxiwq11a
         w7R+kI75Jzn6rOyx2okINbRRLrzXA6kzpqQVtT5ivsiV0KB+3BbQSF8hxIbNBxHBz7AO
         1BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721207619; x=1721812419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7iWDU5uG0cOtj5H+2dTM6DmA/KW/B3bYe6OR9QM0Sg=;
        b=Bzw4NS5Sn6qxbz6iJnELzX85MItyJG4Fj5oEe3FIuzdZ5oLU7bBKq8wRb24EESM3P1
         D/85bZmFQQHBq5lii/naaMtULZgBhJa2osIrhpMoiYil/WqLN3p57nY2VOfyWtjlEwX8
         1nmfh8MOTdWcMOMYY4FtEuMyjBDUSoxNSvyd0vG/MClU/LSb59fyNElkRQ2ww/yU38XR
         amR37DRDJ65hw+sJEnN+BhldXUU4FJOxGsmkp1F55aC1gnIh+wLV86N2+aVbhIMl1Qjk
         6Ydbu9l64hp84z+wEvaDcbfCAahNNf/lG536qxPCN1Oyk7LKBnBXK6dONleTlSuUh6bw
         iSZQ==
X-Gm-Message-State: AOJu0YzHNWBqv7zDnzFiEasEvFiQ2ObgxwDbqUJ4wA42wgQ+mVIvf+wa
	vLSUtUt8ghOYY1XDE38/BjKJisYpn0yhQ8+uZrurdsJJb6RCdUgxWOhGz59k8hFrL5a1RDDULq1
	Y
X-Google-Smtp-Source: AGHT+IGxL3qstNsoHpcZnQSkROTrLST3M5YDRbXigJHsHxCWRaJztTAOi1xL8l7Q6j+bM8UJHmAnaw==
X-Received: by 2002:a17:906:a44:b0:a6f:e0f0:d669 with SMTP id a640c23a62f3a-a79eda93b10mr462955566b.12.1721207618760;
        Wed, 17 Jul 2024 02:13:38 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc822b36sm421133466b.223.2024.07.17.02.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 02:13:38 -0700 (PDT)
Date: Wed, 17 Jul 2024 11:13:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v2 4/8] pwm: Provide new consumer API functions for
 waveforms
Message-ID: <egsgmnaxyyhbezegpwqjrx5hfsj6mr3yvxsdowgpzrwgzftzzf@hc7676pqqaaa>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <8db2c6f239b9e101f85d556d9e203935c2da2570.1721040875.git.u.kleine-koenig@baylibre.com>
 <ff628d7e-bd87-48e7-b80c-aff2d4e61f2c@baylibre.com>
 <cwgrbvzc73hnsmkfigq2t5t43y73oyz54tugad6ayxwzrlawlw@qd3bylzfqvns>
 <23a181c4-80b1-4545-ad48-54e89e4bf690@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mgrqcouhifbqoxtx"
Content-Disposition: inline
In-Reply-To: <23a181c4-80b1-4545-ad48-54e89e4bf690@baylibre.com>


--mgrqcouhifbqoxtx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Tue, Jul 16, 2024 at 09:28:32AM -0500, David Lechner wrote:
> On 7/16/24 2:06 AM, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jul 15, 2024 at 05:23:45PM -0500, David Lechner wrote:
> >> On 7/15/24 6:16 AM, Uwe Kleine-K=F6nig wrote:
> >>> Provide API functions for consumers to work with waveforms.
> >>>
> >>> Note that one relevant difference between pwm_get_state() and
> >>> pwm_get_waveform*() is that the latter yields the actually configured
> >>> hardware state, while the former yields the last state passed to
> >>> pwm_apply*() and so doesn't account for hardware specific rounding.
> >>>
> >>
> >> ...
> >>
> >>> +
> >>> +/* PWM consumer APIs */
> >>> +int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pw=
m_waveform *wf);
> >>> +int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_=
waveform *wf);
> >>> +int pwm_set_waveform_might_sleep(struct pwm_device *pwm, const struc=
t pwm_waveform *wf, bool exact);
> >>>  int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_s=
tate *state);
> >>>  int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state =
*state);
> >>>  int pwm_adjust_config(struct pwm_device *pwm);
> >>
> >>
> >> It seems like there could be a potential race condition between roundi=
ng
> >> and setting a PWM.
> >>
> >> Consider two PWM devices that share the same clock and the driver can
> >> set the clock rate to accommodate a wider range of periods or get a
> >> more accurate duty length.
> >>
> >> Thread 1				Thread 2
> >> --------				--------
> >> PWM consumer A calls round_waveform()
> >> a few times, e.g. to round up or round
> >> closest. Clock is not exclusive so
> >> rounding assumes the rate can be
> >> changed to get the best rate.
> >> 					PWM consumer B call set_waveform().
> >> 					clk_set_rate_exclusive() is called
> >> 					on the clock so the rate can no
> >> 					longer be changed and the rate is
> >> 					not the one PWM consumer A selected
> >> 					in the rounding operation.
> >> PWM consumer A calls set_waveform().
> >> This will either fail or will
> >> not get the same results that
> >> was returned by round_waveform().
> >=20
> > The "exact" parameter has the purpose to make this fail. While
> > implementing the idea I wondered if I should drop the parameter and
> > make .set_waveform() imply exact=3Dtrue.
>=20
> Would consumers then be expected to implement a retry loop to
> handle the error when an exact=3Dtrue call failed because the same
> rounding was no longer possible?

That's the obvious consequence, yes.

> > Two more thoughts about this: First, I think the most usual use cases
> > are rounding up or maybe rounding closest (instead of rounding down as
> > done by default). It's easy to implement a helper function in the pwm
> > core that holds the chip lock and does the necessary function calls to
> > determine the rounded setting needed.
>=20
> Would these same functions also get ioctls for the cdev interface?

Not sure. They should be available to libpwm users. But if libpwm
delegates to the kernel via an ioctl or does the necessary math itself
is a detail that I didn't think about yet.
=20
> > The second thought is: Even when holding the chip lock, another clk
> > consumer can theoretically change the flexibility of a participating clk
> > while the right settings are determined for a given pwm consumer. Also
> > if I use clk_round_rate() to determine the resulting rate of a parent
> > clock, it's not sure that I can set this rate because again the
> > situation might have changed since I called clk_round_rate() or because
> > another consumer refuses my request to change the rate.
> >=20
> > So as soon as you consider changing an upstream clock to reach a certain
> > PWM setting, this all degrades to a racy best effort quest.
> >=20
> >> If it wasn't for the userspace cdev interface, I would suggest
> >> to drop pwm_round_waveform_might_sleep() and pass an optional
> >> function pointer to pwm_set_waveform_might_sleep() instead of
> >> the `bool exact` argument so that the full operation of rounding
> >> and setting could be performed with the pwmchip lock held without
> >> consumer drivers having to worry about getting it right. Consumer
> >> drivers would then just have to implement functions to suit their
> >> needs, or there could even be standard ones like round_closest().
> >>
> >> But that still might not fix it in all cases e.g. if two pwmchips
> >> share the same clock as opposed to one pwmchip with two outputs.
> >> If this is possible, then then "pwm: Add more locking" patch
> >> might already cause some problems with race conditions in the
> >> existing PWM apply() ops. Although, I suppose this kind of
> >> clock coordination between pwm chips (and potentially other
> >> devices) should be handled outside of the PWM subsystem.
> >=20
> > I would expect that the "Add more locking" patch doesn't enable more
> > races than are possible without it? I don't understand the problems you
> > think of here.
> >=20
>=20
> When we consider other non-PWM clock consumers you are right, it
> is not any different that before. I think you understood me fully.
> I agree that there aren't any serious issues here any more than
> the current state of things.

Ack.

Best regards
Uwe

--mgrqcouhifbqoxtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaXiz4ACgkQj4D7WH0S
/k5OOggAgq/rV9+bKfRYWWmUOQFuPfGiwJvWcnD0L2xkDDiS0zkSTqsg+cnmfAQc
QisoICqM+etWknTOPuQZ8mS7xmBZMovefq9unCxCKguShSNQQ3oHQGxIjkxj0v92
vzSFGi7n2VEdG+u2PGK5G5lPvzR1FKlVFI3N0VY0b/4sYzBa9MqxMxiwd1xv+Gyy
R/fUE4k4Vn6DYb1tyqc9cXRxXeCAkKJAQDkd4jScw0gXVGiBYtl9y+o7kWz9MGpZ
U/hoZTgUqK+ZRHZBCQa7ZZm5FseJOGUSaKqOz98rVciC34K1K96uumK4Zqp/LI73
6L74nrEbRaJfCpvUAQH5XPV0/f+Ulw==
=p+8G
-----END PGP SIGNATURE-----

--mgrqcouhifbqoxtx--

