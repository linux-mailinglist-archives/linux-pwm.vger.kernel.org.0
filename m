Return-Path: <linux-pwm+bounces-3595-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB0099A0DC
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 12:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5571C22053
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 10:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A92101B3;
	Fri, 11 Oct 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3atZsNZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D921018F;
	Fri, 11 Oct 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641416; cv=none; b=LmQBdaFBSMAPQDUSx3WJf38XLpscVUOnudIxwjDkjxE+W0YKs5GbVWs+Bg46wj7g/Jog6ES1s8qFxJP7PvHurHKw8/KwkuVXG84oC6DAvP32a5Lx1nWO2iHg3CgYFxOuuBT0ekBjJlnXGutyuZ9CIQ7KKIQHhDEiQKE9CDlUg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641416; c=relaxed/simple;
	bh=OlZmQTN6YihzaPwp1RATvGMI8FLQb+lEMghfU4vDDjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJ02hooEoDRE/IcXUK6UIOOuGZxRCsDdGuphBOm0v3/8DpE1Ub1oTp1pAwRfaoUjLPMo7n99dDPmcoAYhkpcz4pIzGnBb3NyT4HLv8KtPp2icOCjALR/qlHNaP9eiaJhWCnRbJ2cx1qXjtd89se9nG2TpV/MnPLtgScqQoAxlFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3atZsNZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43115b31366so16085585e9.3;
        Fri, 11 Oct 2024 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728641413; x=1729246213; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OlZmQTN6YihzaPwp1RATvGMI8FLQb+lEMghfU4vDDjI=;
        b=G3atZsNZfNZ8Rx9q/y6nYmwvaPsK5cDvZgTxFvg4zRkDvVMtRQA3ifCIk+djlZ3gON
         iv+Kz7KKjiUpawhuGiyADEeMSw3SxeyPbUUeqY/w6yuezhlilFRIo0CRUi2L54Ib9/Ik
         cAlwd7yxrBTqM51I6HIno2GlscXGmGFJWErFkBNF4yq54X9M7+8nPd4JSZvfyoUE7iPo
         uv7k7mZPoqaOVdMaJqqVbkrCFL1n/voWoUzfmPF4Pw3weSsgpQHESzVu2WHibLAwAxCt
         1gUdLi6gj+UFpWAVNkM2RIfiruOl5Kjjdn+Hf3Bev1WYWJh86+u1mZIZOnxYLpve39+V
         ucZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641413; x=1729246213;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OlZmQTN6YihzaPwp1RATvGMI8FLQb+lEMghfU4vDDjI=;
        b=KVu6HlBadH/C3iBslY02FfUAvYd+10eIzgWdZsYqkAu/9jfpn20jg5W9exKYhR6v0d
         052T1N7W2plcy3+lGwq8sl7z9ABLA+DeR3ObHxS3DBJrL5CzREc8WiGmA763HlmZeanz
         h/Z0kaJA2JSMAinbh3OGh0b3bIL4PE4k2E2enMkAVz6Fb3FjzzZigWTHGXY6oNuqarEI
         /wFIIWNQkYVQ0qWaWffD4hyZpQ71PPRbNasVsPnXO8SyML0fZ/SgzZqnm00Gt98Bt8Nf
         jS1yLkOyIquaEefFKDgcohHfdWvYV13IWCQom8SRMu23pphnE+IKa7hSD9uv/cNPH3BD
         YJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwAA/f1uq7EMky9NjkBu9XZ2qGIuTuHGdH6wf3kAN9Q5pJajdltXJT6U/OL2bbMGUrkUPuzEYow9KUlWk=@vger.kernel.org, AJvYcCWFmAYYE0Ooz8GngkOtwPR2FH1R5xCX6bMAP6Qd5crWSqdBVFK+X6EnlzUUkIsso1jHpDJvT1y2afIh@vger.kernel.org
X-Gm-Message-State: AOJu0YycEwVzg/BS3AHp8O0vEW/4DLmOELtoDdy/MlZTwU7l0C8AYPl3
	c5K2IYFYMjlOVzOAZUpjHwIRQnEO70UEPGRhPCyvj6RC2ljG9jzz
X-Google-Smtp-Source: AGHT+IGFG7OuA6O5uwOZx939VQCxoAloO+PcUUo8Wvjo0r0eiKRHgJj9A5DVLRS+cyxVnmGe8ipm8Q==
X-Received: by 2002:a5d:4591:0:b0:37d:4fb1:4faa with SMTP id ffacd0b85a97d-37d55313054mr1442767f8f.50.1728641412942;
        Fri, 11 Oct 2024 03:10:12 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7a0588sm3560228f8f.69.2024.10.11.03.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:10:12 -0700 (PDT)
Message-ID: <9e10ec246ec03eab2833c27aae4d64e2ab2231b9.camel@gmail.com>
Subject: Re: [PATCH 0/2] pwm: axi-pwmgen: always enable FORCE_ALIGN
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Trevor Gamblin <tgamblin@baylibre.com>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Oct 2024 12:14:28 +0200
In-Reply-To: <zm6uc43aidfouc5wj4outd2cqribbzqnbp76my7ntcflbn6drb@sc7nwgho6x2c>
References: 
	<20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
	 <57169283416bf7902523891ba03d1f878772ffe5.camel@gmail.com>
	 <zm6uc43aidfouc5wj4outd2cqribbzqnbp76my7ntcflbn6drb@sc7nwgho6x2c>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-11 at 11:51 +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Oct 10, 2024 at 10:33:20AM +0200, Nuno S=C3=A1 wrote:
> > On Wed, 2024-10-09 at 16:11 -0500, David Lechner wrote:
> > > When using the axi-pwmgen as a trigger for ADCs, we've found that the
> > > default behavior of the PWMGEN IP block is not ideal. The default
> > > behavior is to wait for the period of all PWM outputs to run out befo=
re
> > > applying any new settings. But there isn't a way to block until this
> > > happens (and even if there was, it could take a long time). So the
> > > pwm apply function returns before the new settings are actually appli=
ed.
> > >=20
> > > This makes certain use cases impossible. For example, to use the PWM
> > > like a GPIO to create a single pulse on and off to trigger a single A=
DC
> > > conversion.
> > >=20
> > > The AXI PWMGEN has a FORCE_ALIGN configuration option that changes th=
e
> > > behavior so that any new output settings (period, duty cycle, etc.) a=
re
> > > applied immediately. This can cause glitches in the output, but makes
> > > the PWM actually useable for most applications.
> > >=20
> > > Also, there was a naming conflict with register names, so there is a
> > > preliminary cleanup patch to sort that out.
> > >=20
> > > ---
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
> b4 diagnoses for that:
> NOTE: some trailers ignored due to from/email mismatches:
> =C2=A0=C2=A0=C2=A0 ! Trailer: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> =C2=A0=C2=A0=C2=A0=C2=A0 Msg From: Nuno S=C3=A1 <noname.nuno@gmail.com>
>=20
> I fixed that manually now, but would be nice if you'd care for matching
> addresses in the future.
>=20
>=20

Arghh,

Completely forgot... As i said in the first time, I'm doing this all the ti=
me
and never got a complain about it. I'll try to remember for pwm to reply fr=
om my
work email client (which I want to avoid for mailing lists as you might gue=
ss
the client I'm speaking about).

- Nuno S=C3=A1




