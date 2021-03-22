Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6867343C73
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 10:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhCVJOg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhCVJOE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 05:14:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52BAC061574;
        Mon, 22 Mar 2021 02:14:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v11so15798787wro.7;
        Mon, 22 Mar 2021 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BRjaBu4YPexHXWZ5zkfVnDdMvqs/EIBJCNeqCSsYZrI=;
        b=Ygoimmrj0kFpPABkpPLFBhk86CDZ/2+gluciX6ke6hrSrPbgXOFB9PTO3c0qxDDNyW
         rJNsCCF959PmBJ9EQwXK0hEMXWvoH+tdPEsw/Nn7nrvNBaUnrpXsh7+Dt0yKzLOZ7qX6
         ixV+dSBcHYsxEESs65WbbJ4dFXTM4yWGkYz7r3Am12QT7E9+YuTkAJJGRZTZ2Am0R1LN
         WPhZZHDarTrS7V6KXpt2m7GkoC9w7aDuaGIkmAvOGEDUJJb9dI5v03QMYKs01QXBq0Ng
         s6KlN/GEOlm9v3r3etF4uzzseSSV3FNheBRY4x2PypT1GDcIeASZzNWDRW4kaCxM7EjI
         Y6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BRjaBu4YPexHXWZ5zkfVnDdMvqs/EIBJCNeqCSsYZrI=;
        b=Kj9LYLBoxd9hsN4EG94V616QO465vfpuMzNSlFcuddjRs9oXk6S8G89bs+mCSJvt79
         qEPGY3go4RFkFGAOrAGqALHyMudIOWnamP+LjcdIBg9A6LAjtmVNpW0el34Jr0gIMGhd
         yp34cs8kgdrJjv9bt3uPcvmzevjBi89gth4ZOzIT0bzhrJtbx92KXy3jAWOcKOx8rtgh
         bkV+LXRHAPLXNCphYAhkBquHgrjMr7HBurs8RW4Rx5BFkyrlfqMKeLi/8pfO8XuS5PlF
         3Q8FkzAU4MiLTRLqVf/3aTCn0oAaKsvtqqOxPmAEFDsTe8N0pJCHjkU0Bjfm0cBxfn4e
         9mhA==
X-Gm-Message-State: AOAM532d8E9esQ2HSwRAz3oZrgwBU6kfWbOrBX+VeJS0r5VFjhXNBObE
        nQgOYmDOBaU2Jt+qsOXpA0s=
X-Google-Smtp-Source: ABdhPJxz+gL6ZSsY+OiKnJPX3/iFZmJ291s0nGVJWzVmX9OWifqYYzasnsP4ZrD728nSSCaYnjKScw==
X-Received: by 2002:a5d:5411:: with SMTP id g17mr17232486wrv.194.1616404442519;
        Mon, 22 Mar 2021 02:14:02 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id x23sm15874872wmi.33.2021.03.22.02.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 02:14:01 -0700 (PDT)
Date:   Mon, 22 Mar 2021 10:14:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YFhf6nhdQ+PgdpsN@orome.fritz.box>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
 <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QCrUqsTeVqvlpF16"
Content-Disposition: inline
In-Reply-To: <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--QCrUqsTeVqvlpF16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 29, 2021 at 01:05:14PM -0500, Sven Van Asbroeck wrote:
> Hi Clemens,
>=20
> On Fri, Jan 29, 2021 at 11:31 AM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > Ok, so you suggest we extend our get_state logic to deal with cases
> > like the following:
>=20
> Kind of. We can't control how other actors (bootloaders etc) program the
> chip. As far as I know, there are many, many different register settings =
that
> result in the same physical chip outputs. So if .probe() wants to preserv=
e the
> existing chip settings, .get_state() has to be able to deal with every po=
ssible
> setting. Even invalid ones.

I said earlier that the PWM state is a snapshot of the current hardware
settings and that's not entirely accurate because it isn't actually a
complete representation of the hardware state. It's merely a
representation of the PWM software state that's currently applied to the
hardware.

This is simpler from an API point of view than completely representing
the actual hardware state, but it's also sufficient for most use-cases
because we don't care about the exact programming as long as it yields
the result represented by the atomic state. Although it's still vitally
important that the amount of state that we have is accurately
represented (i.e. duty-cycle/period values must not be collapsed to 0
when the PWM is off), otherwise the API isn't usable.

One good thing that comes from this simplification is that it gives us
a bit more flexibility in hardware readout because you can collapse a
large amount of variation into the couple of values that we have. So if
your bootloaders program weird values, you can canonicalize them as long
as they still yield the same result.

So roughly what should be guaranteed from an atomic API point of view is
that doing the following is glitch-free and doesn't cause a change in
the physical PWM signal:

    chip->ops->get_state(chip, pwm, &state);
    pwm_apply_state(pwm, &state);

Ideally we'd even be able to, though we don't do it at present, to
optimize that out as a no-op by comparing the new state with the current
state and just not doing anything if they are equal.

And just to clarify: glitch-free above means: to the extent possible. In
some cases it might not be possible to set PWM hardware state in a
completely glitch-free way. If so, there's not a lot we can do and it's
better to do something even if it's not ideal. The rationale behind this
is that nobody will select a chip that doesn't meet requirements to
perform a given task, so it's highly unlikely that a chip that glitches
during transitions will ever be used in a setup where it's required not
to glitch. We should obviously always do our best to keep glitches to a
minimum, but software can't change hardware...

> In addition, .apply() cannot make any assumptions as to which bits are
> already set/cleared on the chip. Including preserved, invalid settings.
>=20
> This might get quite complex.
>=20
> However if we reset the chip in .probe() to a known state (a normalized s=
tate,
> in the mathematical sense), then both .get_state() and .apply() become
> much simpler. because they only need to deal with known, normalized state=
s.

As was mentioned before, this does restrict the usability of the driver.
In some cases you really want to avoid resetting the chip. But I'm also
okay with leaving this as-is because it's the status quo.

So what I'd propose is to take this forward and keep the reset during
probe for now and then follow up with a separate, simple patch that
removes the reset. That way we can easily back it out, or revert it, if
it causes any breakage, but it won't hold up this series.

Thierry

--QCrUqsTeVqvlpF16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYX+gACgkQ3SOs138+
s6EedA//RjyuSgLLpBZSSQrtJxcaAJDULyJfJx1oiXC5EYFPTkE5IYZmx1zRhvvA
emVj5+UxG/L0BobMfYpU4Z6BCtFRE4GAZD6aw2Pu72LdMIN1iIMqR7MU9OHswHUG
S2OwMLU7ykIToz/eyqpUBKUjDh3YmjaSSi8QRL3X7MQPrDv1Vry1W/gC78SepAyN
kMSHs1dgP++PHB77bQzFzHEnMuNLaPxkvMTTiTzXmfFZad7gAaFoX5hUQ9LhNJwQ
sPXtrpPs1eBDsYYhEaO7xLY8Q7Vn1TlASHXthvOQc1pFCncUME0KfaQNYhP0AU/I
N0DNoYMRMPC60aFyh259Oaqg6ySKlrR1qH6oKNImZaaHLY+5uMgswn5YSWlioOCS
EmhhGR5assh1iKVTFX9b0q/O4SlMCZ/vSy6rF1CpSqMu43kYjbdu18RLMNBzeptT
2kYhV+J4s0h8xHok02QXsWQFBGzIwwXTtxWzhj39dboGoIWnX1iuhRkUfLwSmk7K
3/LeyAJSxUTexfkPs5B2RP3NNnl6oQDhgBQmebt2A9cM++bjw8NJxqJzu+HNCYTr
IUQu56yUwsiyQNL4Pi2rXEK7A9bdKbJADL/ITe1vH0r2fw9Txj2eKy5Vjtx4/kc4
LwZptE+2nQ7H9j2P6ASjbzffGpebOsf7RdTPxuRDWy7aNBDtN+Y=
=wLec
-----END PGP SIGNATURE-----

--QCrUqsTeVqvlpF16--
