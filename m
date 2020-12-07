Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BD92D14B9
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 16:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgLGPaV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 10:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGPaU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 10:30:20 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D64C061793;
        Mon,  7 Dec 2020 07:29:40 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id jx16so20018714ejb.10;
        Mon, 07 Dec 2020 07:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=czieh0SMLeCnWTqxAlKEr+JxJKJgLdYp49r0pLF9I84=;
        b=exZdHbMuTVxUx0l4mqHiicOz1w8B0EnlED5S4nkg0zZCOdEchmV1whh1v85k93rpfL
         RGVHuXlfvosq/pvg7D7gAnJyLiqcUsxnrnOoptdrPQQKuca5WqNmiwmjwaSelz9hKqpY
         kFbvX+RLIMUNcDKgXoOR/vJAUp1526HO03y8GZkHjND0yiDQTwDha0xWdDh7Nezl2w+7
         55KELOFdiy9rBAxzoLJYX1/6sQT/4EDNF31ZU8VRAP9JEJbJ7gbWesiHdb8qe2xUwfK3
         YzGo4f4Akb4Ks+CzgHjXCGwu9y98M2XSIiCiKHxCP8StrwniFXq7Xltzu5m3n3K15bQz
         u6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=czieh0SMLeCnWTqxAlKEr+JxJKJgLdYp49r0pLF9I84=;
        b=m5sa83gExKUqw0CRjJt6s8+UjryMvcMHveJOQ/3YTgEaeMOGN6GNOiXzIv3WTRyXTN
         vhgL0b7gCw1LoUkIiOJHQLCOZTljnf1unDyjTPki0a5zjhb7pzRMA4XtHnC23/vOYhIi
         GBUR4euXcxKP8uv2xTUyv8t2b02xAsXVpfnq7CbmebrF/T0L1uEWDvOaT6if9MbzxbFm
         pSDXRq4spMBeu7I9vM93K371nAFCQy+Kw7T0Ctzw9WGCaRDpqLO3LF7WsAzplOvN0ds3
         6/U1sHulRXbh8zPedkzox+Z8kepUJkwspHOx2cWLsD1z8YR0WkdwIfZMwBSWPVIPc24e
         kxBA==
X-Gm-Message-State: AOAM531Pnp1hpd0ottKQKFTjud2iV39CDzBnyO6j98Mmbw3gNaKc3mus
        FJfGARGxV8Y4w8ttVDFoIPE=
X-Google-Smtp-Source: ABdhPJxy15rnADfl5o/5RYP4BifXScV3Maf+Q6Mcc//8MHh20OVX/3ZszuOCO0i+gvlfAoqNPukW7w==
X-Received: by 2002:a17:906:3b56:: with SMTP id h22mr18815714ejf.491.1607354979213;
        Mon, 07 Dec 2020 07:29:39 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id u17sm12676796eje.11.2020.12.07.07.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 07:29:37 -0800 (PST)
Date:   Mon, 7 Dec 2020 16:29:36 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sean Young <sean@mess.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <X85KYHVSwIKcBoRe@ulmo>
References: <20201204084417.GA2154@gofer.mess.org>
 <20201204111326.qjux6k2472dmukot@pengutronix.de>
 <20201204113846.GA6547@gofer.mess.org>
 <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
 <20201205173444.GA1265@gofer.mess.org>
 <20201205192510.o76pjs3yc524nwvm@pengutronix.de>
 <20201206141941.GA24807@gofer.mess.org>
 <20201207081628.tm3yg7az5k5sbivu@pengutronix.de>
 <20201207094320.GA10460@gofer.mess.org>
 <20201207135209.htp7plyotjxp37q2@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sadRVDrrxYS6pVuJ"
Content-Disposition: inline
In-Reply-To: <20201207135209.htp7plyotjxp37q2@pengutronix.de>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sadRVDrrxYS6pVuJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2020 at 02:52:09PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Sean,
>=20
> On Mon, Dec 07, 2020 at 09:43:20AM +0000, Sean Young wrote:
> > Thank you for taking the time to explain your thinking.
>=20
> I'm happy you have an open ear for it. With this I really enjoy spending
> the time to find the right arguments and examples.
>=20
> > On Mon, Dec 07, 2020 at 09:16:28AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Sun, Dec 06, 2020 at 02:19:41PM +0000, Sean Young wrote:
> > > > On Sat, Dec 05, 2020 at 08:25:10PM +0100, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > On Sat, Dec 05, 2020 at 05:34:44PM +0000, Sean Young wrote:
> > > > > > What real life uses-cases are there for round down? If you want=
 to round
> > > > > > down, is there any need for round up?
> > > > >=20
> > > > > The scenario I have in mind is for driving a motor. I have to adm=
it
> > > > > however that usually the period doesn't matter much and it's the
> > > > > duty_cycle that defines the motor's speed. So for this case the
> > > > > conservative behaviour is round-down to not make the motor run fa=
ster
> > > > > than expected.
> > > >=20
> > > > I am reading here that for driving motors, only the duty cycle matt=
ers,
> > > > not the period.
> > >=20
> > > There is an upper limit (usually around 1 ms) for the period, but if =
you
> > > choose 0.1 ms or 0.001 ms doesn't matter much AFAICT.
> > >=20
> > > @Thierry: Do you have further use cases in mind?
>=20
> I asked in the hardware department of the company I work for and they
> had another usecase: Motors where for example a 1 ms pulse means "move
> forwards" and 2 ms means "move backwards". They had the same idea as I
> had: You want to know beforehand the result of a given
> pwm_apply_state().

I've occasionally considered the idea of adding a pwm_check_state() API
that would allow you to pass in a struct pwm_state and get a result as
to whether it can be applied or not. It's never really made much sense
because pwm_apply_state() can already return failure if it can't apply
the state.

However, if we need some way for consumers to be more clever about state
changes, then something like pwm_check_state() might be more useful if,
in addition to just checking the validity/applicability of the state we
can also return the state that would be applied after all the hardware-
specific rounding.

That way the consumer can use it to perform some checks on the resulting
state and submit it if satisfied with the outcome. Alternatively, if it
determines that the state is not viable, it can retry with different
values.

I'm not sure how useful that really is because it makes the usage really
difficult on the consumer side. Perhaps there's no need for this anymore
if the consumer is able to specify the rounding, so perhaps we should
concentrate on that API first.

> > > > > For other usecases (fan, backlight, LED) exactness typically does=
n't
> > > > > matter that much.
> > > >=20
> > > > So, the use-cases you have are driving motor, fan, backlight, and l=
ed.
> > > > And in all these cases the exact Hz does not matter.
> > > >=20
> > > > The only uses case where the exact Hz does matter is pwm-ir-tx.=20
> > > >=20
> > > > So, I gather there are no use-cases for round-down. Yes, should rou=
nd-down
> > > > be needed, then this is more difficult to implement if the driver a=
lways
> > > > does a round-closest. But, since there is no reason to have round-d=
own,
> > > > this is all academic.
> > > >=20
> > > > Your policy of forcing new pwm drivers to use round-down is breaking
> > > > pwm-ir-tx.
> > >=20
> > > So you're indeed suggesting that the "right" rounding strategy for
> > > lowlevel drivers should be:
> > >=20
> > >  - Use the period length closest to the requested period (in doubt ro=
und
> > >    down?)
> > >  - With the chosen period length use the biggest duty_cycle not bigger
> > >    than the requested duty_cycle.
> > >=20
> > > While this seems technically fine I think for maintenance this is a
> > > nightmare.
> > >=20
> > > My preference would be to stick to the rounding strategy we used so f=
ar
> > > (i.e.:
> > >=20
> > >  - Use the biggest period length not bigger than the requested period
> > >  - With the chosen period length use the biggest duty_cycle not bigger
> > >    than the requested duty_cycle.
> > >=20
> > > ) and for pwm-ir-tx add support to the PWM API to still make it possi=
ble
> > > (and easy) to select the best setting.
> > >=20
> > > The reasons why I think that this rounding-down strategy is the best
> > > are (in order of importance):
> > >=20
> > >  - It is easier to implement correctly [1]
> >=20
> > Yes, you are right. You have given a great example where a simple
> > DIV_ROUND_CLOSEST() does not give the result you want.
> >=20
> > >  - Same rounding method for period and duty cycle
> > >  - most drivers already do this (I think)
> > >=20
> > > The (IMHO nice) result would then mean:
> > >=20
> > >  - All consumers can get the setting they want; and
> >=20
> > Once there is a nice pwm api for selecting round-nearest, then yes.
> >=20
> > For the uses cases you've given, fan, backlight, and led a round-nearest
> > is the rounding they would want, I would expect.
>=20
> maybe, yes. Maybe it is also not important enough to spend the extra
> cycles getting round nearest and so sticking to round-down is good
> enough.

Yeah, I think in most cases currently the consumer just doesn't care
enough and things happen to just work. Maybe they're not perfect, but
good enough.

One of the reasons I was reluctant to introduce a "default" rounding
behaviour is precisely because it's not clear cut, so in some cases the
default may not be what we really want, such as in the pwm-ir-tx case
here.

> > >  - Code in lowlevel drivers is simple and the complexity is in common
> > >    code and so a single place.
> > >=20
> > > And it would also allow the pwm-ir-tx driver to notice if the PWM to =
be
> > > used can for example only support frequencies under 400 kHz.
> >=20
> > I doubt pwm-ir-tx cares about this, however it is a nice-to-have. It wo=
uld
> > also be nice if the rounding could be used with atomic configuration
> > as well.
>=20
> I cannot follow, you created 11fc4edc483bea8bf0efa0cc726886d2342f6fa6
> because 476.2 Mhz was too bad. So you seem to be interested in
> deviations and part of the problem is that you don't get feedback about
> how your request is fulfilled.
>=20
> > Please let me know when/if this new API exists for pwm so that pwm-ir-tx
> > can select the right rounding.
>=20
> Given that the bcm2835 driver is quite trivial I would be happy to
> create a series that "fixes" the driver to round down and provide a
> prototype for pwm_round_nearest for you to test on pwm-ir-tx. A willing
> tester and a real use-case were the single two things that stopped me
> investing time here.

I'd like to avoid adding a new function for this functionality and
instead add a rounding type field to the PWM state. Also, in doing so we
should be able to keep the status quo for everyone by making the default
rounding behaviour "don't care", which is what basically everyone right
now uses. In specific cases like pwm-ir-tx we can adjust the rounding to
become "nearest".

That said, the rounding behaviour is not something that the API can
guarantee, because if we start rejecting "nearest" requests, we might
end up breaking a bunch of setups that want "nearest" but where the
controller doesn't support it. At the same time I don't want to make it
a prerequisite that all drivers implement all possible rounding
behaviours because it puts a very high burden on the driver writer that
may not need (or have a way of testing) anything other than "nearest",
or "round down", or whatever.

So I think from an API perspective the rounding behaviour would always
have to be a sort of "hint" to the driver to specify what the consumer
wants to use, but it should never fail to apply a state purely on this
rounding behaviour, so returning some state that's the best the driver
can do is better than failing if it doesn't know some mode.

This also ensures that existing drivers will be able to continue to work
the same way they always have, and the new mechanism is merely something
to improve the use-cases where we need more precise control.

Thierry

--sadRVDrrxYS6pVuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/OSl0ACgkQ3SOs138+
s6Fp6g/9EGoRDw/oiLD0Rf2wTPLILTQuDgAqBJCnzfQ/lVteQy1PHo5Lvo/IE7c8
xBY2I7e3N3V39NmprqIBQdyXD9hEkVGMtWCcyO+gh7uvZyjKN4R7E0h1xzqV4JQv
35XZSVZiBSxjhyc2uMNrjtx3kbZqiNcRNyGjPCF/CrDNfHsxJqzt75n3MLTXz8py
p+bPW+YvDzS/miKYlqxjeOVtxa7lid60kwfV4k89nBD+yPV7FqqAMkIawmqL31q3
tPxzFN8mcuqbJOb+k3uZlP8O16HDFxrUz0hSGxJ0Uzgyb0Z95rOquLwL0fmoRBEH
3a6Qi6jyEiwtJfMMIX77zLkrCFIRfrsFL7oqKvYjMTYHmUfJePBxtcDjFkskE7PU
F1kt8ArcvV1taE2MrUxKfydNNdnC3eGfhdGgXfDYoVSpXTCD3Iwwyxn+4Bwso9W6
ni2duZ9PUdAZE0TzpQ2ngc3Vs5bvy828wjEpF+KaZ4KwcN+JwGuTpW1TympBZV57
7wI3L1y3jTpARP2BiRmduM168H1WbPVG8IhbtdjnSmfeHGY0vBGeId7HvASM1YA2
BzwYl3mLUEekRcZaMfhEPLg1JRaF2xYbTVHAamPmSM44G0dKHMYuvtWLQ6SF2MSI
MOwIeomKCgob37BViH8IX1ZqZNTVjfJYxvXr14aYXqIXIFmeT6Q=
=+2zM
-----END PGP SIGNATURE-----

--sadRVDrrxYS6pVuJ--
