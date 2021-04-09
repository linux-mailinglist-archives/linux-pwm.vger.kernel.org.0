Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0645A359CB6
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 13:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhDILKM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 07:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhDILKM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 07:10:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A40C061760;
        Fri,  9 Apr 2021 04:09:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r12so8035906ejr.5;
        Fri, 09 Apr 2021 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iLAkumpobJhziT5GcspBLNu4MlEVC9VQBaW2/D0P0z0=;
        b=ZNLLSFnLdm7lexLLqXO7gA5XkQ2WaK8XIp5sLH+iNIeQ7mea+9IIi093AsguOr5DaD
         UraA7odVsYWE2blfugk43c0718zcR9A4BO3KdKkZQEScptH0YF+gvnH0fEmRK6KN3mV9
         DOfTDx4yzmx0laxMB6b+TwEZTguEsP81sZHltqaXFhh7Uydx+TOJvt4jhL6tduXD73/o
         kXy7LTuw0EZzX7aCirLomHPO+ynheZ3aSh/QASqPs0d7FE+Lr4B7KMJ2dnC43RaLS32f
         A5ku/4R6W3tKrHsHnXOuPnpsXJ+22ZsjgcNP0FngGnUk/Q2S5WmIeb/5QwaXXz/qq2Ar
         dO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iLAkumpobJhziT5GcspBLNu4MlEVC9VQBaW2/D0P0z0=;
        b=PdCNZHveyZjTiFWP4wuBdUDdtHKzI9rnTz1bDVVtcI5KIbY65jCIbBDhQa7XzfcC6D
         os6Xo5mGPnnZf5ozqFniPrM4TXtcpFJPJ7pZofLysktocbw7zkNocKEpXAI5mMoxjXK9
         J30DsOBV83Tiur09HqXaEb5EoC9LfqNJq9+s/Qet0xzbQZ1MPyXZoJQiHolioOiy3RJF
         Hi1MhHDfVxPNRjzUqYpLJbHB1UNn5HfutQkThjrbBDrMW3g5LY0ffaij/eNfHH/3NHs7
         jVr8G+3X6btEJPfZ2aN4qTAgIs7kkURA1V6expRxF+sCcFZFsjlMg6eR/DW9hlFKzqxP
         rnXg==
X-Gm-Message-State: AOAM530LB0Rrr/mvs39QlsOzpIFW8WdKuIVMJhAM9UUjVxu6vrwVWe2/
        D7Cub0h6cq6k6My3FTIbc50=
X-Google-Smtp-Source: ABdhPJxL7jFxgjPk5C1ySO1Br2FEnfurUa37p0Mqe2QjNpq2aBlnDcBjaUPMrUhcyf5gho7OzdfLtw==
X-Received: by 2002:a17:906:b2cd:: with SMTP id cf13mr6290178ejb.419.1617966597033;
        Fri, 09 Apr 2021 04:09:57 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id ka11sm1060302ejb.43.2021.04.09.04.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:09:55 -0700 (PDT)
Date:   Fri, 9 Apr 2021 13:10:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/8] pwm: core: Support new PWM_STAGGERING_ALLOWED flag
Message-ID: <YHA2J92rgib1Qs17@orome.fritz.box>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-5-clemens.gruber@pqgruber.com>
 <20210407054658.qdsjkstqwynxeuxj@pengutronix.de>
 <YG4UNoBCQJkEEfwi@workstation.tuxnet>
 <20210407213403.h6n6l2t7vqoalceu@pengutronix.de>
 <YG78IHIMGtl8Pokp@orome.fritz.box>
 <YG8miEOZXsH0NTcA@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qR1/E7TKJN8+Cew2"
Content-Disposition: inline
In-Reply-To: <YG8miEOZXsH0NTcA@workstation.tuxnet>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qR1/E7TKJN8+Cew2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 08, 2021 at 05:51:36PM +0200, Clemens Gruber wrote:
> On Thu, Apr 08, 2021 at 02:50:40PM +0200, Thierry Reding wrote:
> > On Wed, Apr 07, 2021 at 11:34:03PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Apr 07, 2021 at 10:21:10PM +0200, Clemens Gruber wrote:
> > > > On Wed, Apr 07, 2021 at 07:46:58AM +0200, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > On Tue, Apr 06, 2021 at 06:41:37PM +0200, Clemens Gruber wrote:
> > > > > > If the flag PWM_STAGGERING_ALLOWED is set on a channel, the PWM=
 driver
> > > > > > may (if supported by the HW) delay the ON time of the channel r=
elative
> > > > > > to the channel number.
> > > > > > This does not alter the duty cycle ratio and is only relevant f=
or PWM
> > > > > > chips with less prescalers than channels, which would otherwise=
 assert
> > > > > > multiple or even all enabled channels at the same time.
> > > > > >=20
> > > > > > If this feature is supported by the driver and the flag is set =
on
> > > > > > multiple channels, their ON times are spread out to improve EMI=
 and
> > > > > > reduce current spikes.
> > > > >=20
> > > > > As said in reply to patch 4/8 already: I don't like this idea and
> > > > > think this should be made explicit using a new offset member in s=
truct
> > > > > pwm_state instead. That's because I think that the wave form a PWM
> > > > > generates should be (completely) defined by the consumer and not =
by a
> > > > > mix between consumer and device tree. Also the consumer has no (s=
ane)
> > > > > way to determine if staggering is in use or not.
> > > >=20
> > > > I don't think offsets are ideal for this feature: It makes it more
> > > > cumbersome for the user, because he has to allocate the offsets
> > > > himself instead of a simple on/off switch.
> > > > The envisioned usecase is: "I want better EMI behavior and don't ca=
re
> > > > about the individual channels no longer being asserted at the exact=
 same
> > > > time".
> > >=20
> > > The formal thing is: "I want better EMI behavior and don't care if
> > > periods start with the active phase, it might be anywhere, even over a
> > > period boundary." Being asserted at the exact same time is just a det=
ail
> > > for the pca9685.
> > > =20
> > > > > One side effect (at least for the pca9685) is that when programmi=
ng a
> > > > > new duty cycle it takes a bit longer than without staggering unti=
l the
> > > > > new setting is active.=20
> > > >=20
> > > > Yes, but it can be turned off if this is a problem, now even per-PW=
M.
> > >=20
> > > Yes and that is a good thing. (BTW: I'd call it per-PWM-consumer, but
> > > details.)
> > >=20
> > > > > Another objection I have is that we already have some technical d=
ebt
> > > > > because there are already two different types of drivers (.apply =
vs
> > > > > .config+.set_polarity+.enable+.disable) and I would like to unify=
 this
> > > > > first before introducing new stuff.
> > > >=20
> > > > But there is already PWM_POLARITY_INVERTED, which can be set in the=
 DT.
> > > > I am only adding another flag.
> > >=20
> > > I understand your reasoning, and similar to "This diplay backlight ne=
eds
> > > an inverted PWM (as a low duty-cycle results in a high brightness" th=
is
> > > semantic "This consumer doesn't care if the active cycle is anywhere =
in
> > > the period". Hmm, maybe I just have to think about it a bit more to
> > > become friends with that thought.
> >=20
> > Yes, I think that's basically what this is saying. I think we're perhaps
> > getting hung up on the terminology here. PWM_STAGGERING_ALLOWED gives
> > the impression that we're dealing with some provider-specific feature,
> > whereas what we really want to express is that the PWM doesn't care
> > exactly when the active cycle starts and based on that a provider that
> > can support it may optimize the EMI behavior.
> >=20
> > Maybe we can find a better name for this? Ultimately what this means is
> > that the consumer is primarily interested in the power output of the PWM
> > rather than the exact shape of the signal. So perhaps something like
> > PWM_USAGE_POWER would be more appropriate.
>=20
> Yes, although it would then no longer be obvious that this feature leads
> to improved EMI behavior, as long as we mention that in the docs, I
> think it's a good idea
>=20
> Maybe document it as follows?
> PWM_USAGE_POWER - Allow the driver to delay the start of the cycle
> for EMI improvements, as long as the power output stays the same

That's a very narrow definition of what this does, but yeah, I think the
more we document this the better.

However, the intention for naming this PWM_USAGE_POWER is to make it
clear that from the *consumer* side of things we use the PWM for its
power output and therefore we don't care about the signal actually looks
like, except that it should provide power equivalent to what the
consumer requested.

> > Come to think of it, a flag like that might even be useful to implement
> > the common case of emulating inverted polarity with reversing the duty
> > cycle. That is, if PWM_USAGE_POWER | PWM_POLARITY_INVERSED was specified
> > and the PWM provider did not support polarity inversion, the inversion
> > could still be implemented using emulation. Currently we push that logic
> > down into consumers, but this could be a way to bring that up into
> > drivers, or perhaps even the core.
>=20
> Interesting, but that would be left for another series in the future, I
> assume?

Yes, of course. I was merely thinking about what could be done with this
if we describe it in this generic way.

Thierry

--qR1/E7TKJN8+Cew2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwNiQACgkQ3SOs138+
s6HRVhAAi5obwN1Gq1fJKT+lEE22dF5bPfAy0PIzbIDxlkkn3Wh5YRfCoUFhbbzu
1LpCUhO6wmvtJTo80XRqrTrJadYnQiGcRlSURmpH4JwYqVMyJACkAm40TGjHJAw0
DyZmk7M7JmZefHA8IominGPJEtF2mzZSRoxp2biWf3AIPobcfOTlbtGve/tP3MBf
kLFpves+E1FaPmYKTLAG2xmQyd9Skrqm8WnKvf26XWl0DFyc0q/8s1VDvM5BIY+D
HmEyjoLjAwEbSe06GgJblXh+0oLElNJRWH4ThR7NyTuv41eyrcPIw3zdKEHfj5tE
UPanMLWNxgUOcoN+pxf/8RCeR2G45tEGcgYdGK4q72FptfmTB8XTQgK79DVQPtWB
hseenPDbEfEM8MXXV27HY4noyohfIW8uZCzc5bTG3iwT2vP3lOw2Bat1jHf6TECl
Kzk+Vvv+F72F73vs9TxyMo3We4rOQF23b7v9NpfulRmDgwXxwTDvnqC7lP4g2yss
lVx8hrIIxBwPVr+MpUzOkueWm8vkDpcuQsl0kd0+bYRMbLVOo6CeD+cZxgW8olPH
88Of7qKPSiovLyTW/Iap3jv3tNegVystHelgHCwXKsb0djo+NoTP+PA1OnAgLegW
4TcaOeksNnyMd37GOOFc5Fw09a1RA+bIlzr9Yrs+ldWqx1vMF1w=
=lZai
-----END PGP SIGNATURE-----

--qR1/E7TKJN8+Cew2--
