Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6317343BD7
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 09:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCVIeK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 04:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCVIeH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 04:34:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88ACC061574;
        Mon, 22 Mar 2021 01:34:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b9so15685925wrt.8;
        Mon, 22 Mar 2021 01:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tLp+sq/FazE29Dpyy74umHg5WohG4Hq6x2ANHAGmND4=;
        b=gj4L7vZQwiSTsGb/CJ9/XDAIm6ImT8dSKSK0iY6K4ME4JvwRr0ZmFNJ3gsyzfOyomA
         Y592x5HiP1kzZQAHDuNEyKk2ZHzDMTUSGyFPhM788hwpgiRn1LQnKFrfxgpO0QjOUVgn
         MEO41whyzDpY7488ikxH5vK6HF2hiUnQ2kv+/uK8MIhDsOJdLbwVPQvM0dYd1XoJ6xow
         MNaYEgL0/m/Z+IPCp0KsbcfgsfOF6v59LdVxFriPhAyy3oiFuq7PXy6/+JNFSrAGgUbK
         fWu4mKO39YIB8Kx7izVDTVX+SoSafLNRXpA1A+TxcYMlZCDuKIk5pinb2PCgu/pgGV3d
         1qEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tLp+sq/FazE29Dpyy74umHg5WohG4Hq6x2ANHAGmND4=;
        b=dj1/NpUnY7AYKzWTtqGD9+5c62kB1lLmgOmeMLcxrbeTrRTfe8agFxlA6IeNNAXQB0
         H+CRI/Ofv2loMc+WaRNB/6EHEsLIkZDZ4uDnl+wCPbRX8aZ1xxPj6/PbxRKKDRYLf9Z4
         /98fgZhOJT2mrlH3xtXbuBH1oA5ZjbS3gkdb6D5PkAULqIdH0iphJHzBaB0fRelqE+Gz
         Arx0zuVKTHNjdS5gPHSBZDB5ED3l+1Rfc/aKDwaXzvybk3xSP0U/OmPuCbizWNj3+RMV
         orlFtzZwoWw2H50FkjuG4dZZ1ulaEWGZoE8wE2PGNpig0MKGtEES3Em3QEUQvWWhNNj9
         y8jQ==
X-Gm-Message-State: AOAM530XGt/QsfKAL/IMNEx406yyfwNEpFvfF75NBXfHdc/dcJpb2Sqo
        cJXs3Io5SGka8wtVOf/1D9E=
X-Google-Smtp-Source: ABdhPJwo/b2ymmixn8OQZGq1QFOPDPhlgF/wr8XI/lRJn7zHQYAA4/7FIhApjH8VgVU9yj9f7NjNeg==
X-Received: by 2002:a5d:61c9:: with SMTP id q9mr16672352wrv.219.1616402044464;
        Mon, 22 Mar 2021 01:34:04 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id 64sm15931087wmz.7.2021.03.22.01.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 01:34:03 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:34:21 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YFhWjXAF/D6oBpGE@orome.fritz.box>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <CAGngYiUYOL6EF3VTGwcwTuN4EmE26ML3ye7689FTEpowjEcU2w@mail.gmail.com>
 <X/H5CqcRHelg5M4p@workstation.tuxnet>
 <20210111204350.k2bhpdj7xnnqkfi3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k14jXRtCCuJyXIwP"
Content-Disposition: inline
In-Reply-To: <20210111204350.k2bhpdj7xnnqkfi3@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--k14jXRtCCuJyXIwP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 09:43:50PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Sun, Jan 03, 2021 at 06:04:10PM +0100, Clemens Gruber wrote:
> > Another point is the period: Sven suggested we do not read out the
> > period at all, as the PWM is disabled anyway (see above).
> > Is this acceptable?
>=20
> In my eyes consumers should consider the period value as "don't care" if
> the PWM is off. But this doesn't match reality (and maybe also it
> doesn't match Thierry's opinion). See for example the
> drivers/video/backlight/pwm_bl.c driver which uses the idiom:
>=20
> 	pwm_get_state(mypwm, &state);
> 	state.enabled =3D true;
> 	pwm_apply_state(pb->pwm, &state);
>=20
> which breaks if .period is invalid. (OK, this isn't totally accurate
> because currently the .get_state callback has only little to do with
> pwm_get_state(), but you get the point.)

The idea behind atomic states in the PWM API is to provide accurate
snapshots of a PWM channel's settings. It's not a representation of
the PWM channel's physical output, although in some cases they may
be the same.

However, there's no 1:1 correspondence between those two. For example,
when looking purely at the physical output of a PWM it is in most cases
not possible to make the distinction between these two states:

    - duty: 0
      period: 100

    - duty: 0
      period: 200

Because the output will be a constant 0 (or 1, depending on polarity).

However, given that we want a snapshot of the currently configured
settings, we can't simply assume that there's a 1:1 correspondence and
then use shortcuts to simplify the hardware state representation because
it isn't going to be accurate.

It is entirely expected that consumers will be able to use an existing
atomic state, update it and then apply it without necessarily having to
recompute the whole state. So what pwm-backlight is doing is expressly
allowed (and in fact was one specific feature that we wanted to have in
the atomic API).

Similarly it's a valid use-case to do something like this:

	/* set duty cycle to 50% */
	pwm_get_state(pwm, &state);
	state.duty_cycle =3D state.period / 2;
	pwm_apply_state(pwm, &state);

which allows a consumer to do simple modifications without actually
knowing what period has been configured. Some consumers just don't care
about the period or don't even have a clue about what a good value would
be (again, pwm-backlight would be one example). For some PWMs it may
also not be possible to modify the period and if there's no explicit
reason to do so, why should consumers be forced to even bother?

All of that's out the window if we start taking shortcuts. If the PWM
provider reads out the hardware state's PWM as "don't care", how is the
consumer going to know what value to use? Yes, they can use things like
pwm_get_args() to get the configuration from DT, but then what's the
purpose of using states in the first place if consumers have to do all
the tracking manually anyway?

Thierry

--k14jXRtCCuJyXIwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYVooACgkQ3SOs138+
s6Gs+w//ciOB3LxDCVL7APKaaIXQe20PV1ogRvsjSfw9oxFltO2YLpdtRg6ywwon
g3G7ZpmeQRFgQhuc309HUyLkjG+WI78orkxNkA942VtQhlrjPIWjyZnm0qbqrD95
XWjAacokDREgmSUToxK+d/o4ATR+R8slXHKQE+q8+STcWnFjj6o8vaHRncGN21qE
MdWvwhij3gdtqtn3KMH9L78zBBbDOsvGcbl7Kae5R6ZMm5xvOMFHT7qDftaCZygo
UMo/s0a9c1BTxqb6Hoda7ThSUoMURIzZd0oVomk0kIcXxa6MM0zZ9mLtGeETn82k
bnyteRHdbVzfKLKxQYdfbJEaWxve3Z/S1gQBiQ+2onbe6YxZbU0liAOIukY6+sN4
UIAgmKcckGU7Ivs6OjIlPgHvOPeT5wpOwjL1gukYBo1maPW59mhsfBKpfFOShpd2
Wsit96860zAWTvxLDiH4nr/iKki65QPl6YfS5UxNnjpAZEBw9oalIziwaPtZpBgC
8065+01wRYYV1pL90HrBGkTg0CDfb15Y0Llfgs8enswEGKYpp63nwbQ5kQDJ2eq4
8saB/hRnm/a5Bks7i8aQ0k4k4osJ1G/xzAmN41yBuyZ1HlRfz0dHJNSFLBV7raTz
+qpkGbiKe/ssSIRaUDzXTfvHDiPP6FHyV74PLos1YRGMHKgAtr4=
=tx4K
-----END PGP SIGNATURE-----

--k14jXRtCCuJyXIwP--
