Return-Path: <linux-pwm+bounces-6499-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47360AE5D25
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 08:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4FC1B67429
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 06:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2C624A06F;
	Tue, 24 Jun 2025 06:50:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB924BBEC;
	Tue, 24 Jun 2025 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747850; cv=none; b=kfhW4X2guCm9xP3nbhIC3KWbWHfjxvyi8L88ktKas383EcQJzyI7WerhMZ2STbFm4/W7muJ5lrsfPp4rl3Ujw6S3lGDXavRE7smH8VDEAeNPyYISh5+dkWu2X1tTPO5QNBWPZKKiC3vqgRwFl41lcN6aDvJxO6+gej/puYXSOxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747850; c=relaxed/simple;
	bh=94OLxcoN/V+1uMAi0Yf0uaUni2K65tJnVOlQBUpp6Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJxgo2A/EFE7kkKUhS4LOAlSCIZnLDOX1lOuU0wpPLlfD1IYYwvjdNUVF3kfs/CAXYZ5whOFQOviaNRIUUuLg/OBYq/qSO3jsZIZtZHbmrlXB3F/LKl0k9Xxb4A8BsNW/z3hafk0fwFvxo5mzOGQVfScphNK+uWR0/MIzC4n5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87edd8f4e9fso28478241.0;
        Mon, 23 Jun 2025 23:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750747847; x=1751352647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAB8c2lzwHiV1cefx4j1HLZ5SO2BK5h0p7k6kwYAaug=;
        b=NkxdQrLwSpo618S6jr4p+MX/VAWeq36jf9KzPnfvINEovqKRNwVWKLSwVFqlrodfl2
         m0Bz6o4Hgvp+oQSTaCZhsyYLFD8cuDFCwbBEO8PGYlXvL20aKWOioum1aOAwt31/J+oM
         nZ+6tJoUgH3+l5gaxUq6jHEOwt1y8gornsTQRDjRhqg5WH3Pbse/dAC/HG46phOFzqHX
         o4ABcCU4tspj1GML72T3GUe4ItPNEx+SrmjwkEkLcivydBDQBnNBwEl3X3MJUcccRdMk
         9zgUUyKOga2Ou3pnmjPSTv0y73F5kl1z9QmsDA2QU/WJ0X1O0N31g2satWIFLn5FT7hG
         NlHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA4O5X4p5m2hU+nXjezb4yXbEZDPuBrZxn4VmNwng+zTMjSbl0gbLx+1jQ9aTtyM9AQuvrWkw4D3o5gj8+Fi/aUts=@vger.kernel.org, AJvYcCUCfiVRxjSaS8VR7fUINn6d7cIhEEPI5fbnaXf5oTD4gHfPPT96MiMMD/Acs3MaczHS9Z3GmrOeoe3s@vger.kernel.org, AJvYcCV+lFtkTgOpLZiaX6SHzJye34T37B2hjjzKvaKvuq51y2y6e8HdsQ8s6Y92fCpvSYo/C+z9OJeNN59d@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5se9moZhoQdcAjh+0dp8D/uLaJAMRpDDEiXy6Z/lrTqjDXs6
	4Jie2oG2vdprzXJpfSxsERfoaUkwvrB4KMeZUwDhBFNmHRCF2LblMrRUiajmus8Y
X-Gm-Gg: ASbGncupH6uF9PFWzW3niAZFBtxx3h62geyG6WgMUZa7oEtZlMw+6x2Ahzrr/ehaXo+
	CSRMpLlbt78Bi6IJBwMuL+VJCVv5AWnCQ3L6QZbQ9vIKYO9DESH2gasIIk3gw+v0FFBHDMR5RNc
	pRgYXWc0jXOApN1mxLB7s2HkUvGtwdUaCue8WF2FFEgMnNfelHPqouuFBALZDM5Yrm0ukU/1/Q/
	zoV2WPuoCo7U/+Al+b1A6L/egJyv29YTjyH3Ir4lspnEI7T+sHhxzaOZRJ2IUTUt36ujyGiGJ9F
	I6TJQ1QIL29V+CHbX39miqSkAZ8wtFhS7+4IuUAN5tx+iMrej/DA9Lquh/aNRsZvA1wtXmVP2Xr
	NYUD8LZXVI4hQib5z24+hP7MA
X-Google-Smtp-Source: AGHT+IFQeVs1LHo+L5Rg4eMWN/3O28dMzmgvn5N2nwsCawNfsSkdyf//uA36dyJVWxPOuDJ4XfA2BQ==
X-Received: by 2002:a05:6102:1483:b0:4e9:b3b9:720e with SMTP id ada2fe7eead31-4e9c2799f18mr9268914137.5.1750747846421;
        Mon, 23 Jun 2025 23:50:46 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8811acf9869sm1566939241.3.2025.06.23.23.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 23:50:46 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e7fc3309f2so17765137.2;
        Mon, 23 Jun 2025 23:50:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAr6YH8wdE2U0ucRpffmdqSkssBV6GNDBJeHK5ISTDVZ6FW71zCLlOL+gkkXbRHc1KWtQrfx54eNb3@vger.kernel.org, AJvYcCUMn5/pwXAnwVepBUlmgaaZAtwvxgJuSknMw9Il7wzFbvgxjGGnZ9DxX83olqfG9Ug0TybNWqnmgY4u796t05+R+mA=@vger.kernel.org, AJvYcCW7YvQS0h6Q5ibcsaX0fwOdbbJi4/4zY8r9lUtghXwXG2VbosJFtr75W/9vyTdDEKRBIL3WLYVe68IN@vger.kernel.org
X-Received: by 2002:a05:6102:3051:b0:4e2:c6e4:ab1e with SMTP id
 ada2fe7eead31-4e9c281661amr8855058137.7.1750747845652; Mon, 23 Jun 2025
 23:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621172056.160855-1-marek.vasut+renesas@mailbox.org>
 <20250621172056.160855-3-marek.vasut+renesas@mailbox.org> <purpjdp72jw2rok5ihyua635izyih54ufom2knsbaiwdd3jzgk@6wjf364fao2g>
 <dbec18f0-5df4-4eb8-93ab-da6ccfedf8ab@mailbox.org> <apbocxuzcptlpghphh7nchnwyxpfhmiwosgxrt4y5awsb67ar3@fbskfbulwsma>
 <033bbb7d-ab00-467e-ab21-877f76d027a2@mailbox.org>
In-Reply-To: <033bbb7d-ab00-467e-ab21-877f76d027a2@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Jun 2025 08:50:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXU=dWZYnnvmJMFdJYGRB_VWPTGgn=rLT4xX6BEdgDrNg@mail.gmail.com>
X-Gm-Features: Ac12FXyvAL7oGYPDEwzEolSUTkN2WV6Bn2A6LFh9dBHlJQ90gV5YB70gnY5u-wQ
Message-ID: <CAMuHMdXU=dWZYnnvmJMFdJYGRB_VWPTGgn=rLT4xX6BEdgDrNg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Mon, 23 Jun 2025 at 22:44, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 6/23/25 9:53 PM, Uwe Kleine-K=C3=B6nig wrote:
> > On Mon, Jun 23, 2025 at 07:30:33PM +0200, Marek Vasut wrote:
> >> On 6/23/25 11:11 AM, Uwe Kleine-K=C3=B6nig wrote:
> >>> when I replied to v3 this v4 was already on the list which I missed. =
My
> >>> concern applies here, too, though.
> >>>
> >>> On Sat, Jun 21, 2025 at 07:19:56PM +0200, Marek Vasut wrote:
> >>>> +static void argon_fan_hat_i2c_shutdown(struct i2c_client *i2c)
> >>>> +{
> >>>> +  argon_fan_hat_write(i2c, 100);
> >>>> +}
> >>>
> >>> If you drop this, I'm willing to apply.
> >>
> >> Dropping this would make the hardware which uses this device more
> >> susceptible to thermal damage, e.g. in case it gets stuck during reboo=
t and
> >> does not boot Linux afterward. I don't want to risk such thermal damag=
e.
> >
> > We agree here. But the right place to address this is the pwm-fan
> > driver. A PWM is supposed to do exactly and only what its consumer want=
s
> > it to do (in the limits set by hardware). Officially a PWM driver
> > doesn't know the polarity of a fan, so `argon_fan_hat_write(i2c, 100)`
> > might fully enable or complete disable the fan. The fan-driver knows th=
e
> > polarity. The PWM driver doesn't even know that it controls a fan. And
> > the next guy takes the argon device and controls a motor with it --- an=
d
> > wonders that the vehicle gives full-speed at shutdown.
>
> I suspect this cannot happen without non-standard hardware change of
> this device, see the link which shows what this device is, it is an
> integrated PWM+fan device:
>
> Argon Fan HAT https://argon40.com/products/argon-fan-hat
>
> > So I hope we also agree that the pwm-fan driver (or an even more generi=
c
> > place if possible that applies to all fan drivers) is the right layer t=
o
> > fix this. And note that the pwm-fan driver already has such a decision
> > implemented, it's just the wrong one from your POV as it disables the
> > fan at shutdown. For me this is another confirmation that having a
> > shutdown callback in the PWM driver is wrong. The two affected drivers
> > shouldn't fight about what is the right policy.
>
> I would fully agree with this argument for a generic PWM controller, but
> this isn't one, this is a combined PWM+fan device.
>
> The PWM driver is the last one that is being shut down, it is being shut
> down after the pwm-fan driver. If the pwm-fan driver fails for whatever
> reason, the PWM driver -- in this case driver for a combined PWM+fan
> device -- should make sure that the hardware does not melt. So I would
> argue that, for this specific device, the shutdown hook here is correct.
>
> I would propose to keep the shutdown hook here, and extend the pwm-fan
> driver to be aligned with the behavior of the shutdown hook here. Does
> that work for you ?

Perhaps modelling it as a pwm-driver was not the right thing to do?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

