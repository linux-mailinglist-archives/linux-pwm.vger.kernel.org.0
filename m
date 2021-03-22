Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAB7343C89
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 10:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCVJTb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 05:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCVJTH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 05:19:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322D1C061574;
        Mon, 22 Mar 2021 02:19:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so8809341wmi.3;
        Mon, 22 Mar 2021 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wlmBqkQrU+Ev9ordquPte6bMQUpLfxlQNzEh5S+z+4E=;
        b=vAwx7myi+A+B+Ux24DXTRG/1LSolK+gx2F4HSkx+eOKSBq3Dhuk5FbD/j11zKFPLQi
         TP/dC8vA+BSJ3Z6CUbVKROiwXSvQHrbDzUv+ogcSeOIU6/4kU4pG6G4ITLfRzATF7woP
         y2n2RLP8xt2pPjoJ3NjHtQR3rNiVQoP5q8Q/4jLiNsJVeqzYAgqWPlQp+xPu4maeGQqN
         TKi7q1D7GTuMtPw+hILoyEME9crwgnKxqMM90KIEXzhlasUYNu6LIQYx5Cvn0S+NextS
         JljMHcSfqODloUPZW/f+SF3yR2R5lDgw6/ezvvlJzyhd4AokhNBB+gY1PJosS/w0/wzq
         TVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wlmBqkQrU+Ev9ordquPte6bMQUpLfxlQNzEh5S+z+4E=;
        b=i5CJgMUOX2Rz90BxnxxRJLx8HyAHSSFxm72q/6BGDqYXuhkgLsbSeQqhQaMCchpe29
         //yQeudd7s0TIcrA86h2VR9wumluxFQIDMvijgideMsdoHPJG73qdLDptIV2sOF9mmse
         deZS1oE6mlpRRtA/dL+LeB2k6cHEFcuzYoaEwzmNOSBkGeMtebJHFDJZ7b6RcLjdMqxh
         20sAPyGDM5W38mYvaGSF0tJ2ao3OtXbXFjy8OWf6SirH8Dikv0hkOS7GT/5RyJQnf+Wh
         mQPcZxbHuTHgv8TnSr8vPvl2oETt3wVjw5EGXj67xKurDa/5YS+GPTKXG7mRA50Kia7A
         jNig==
X-Gm-Message-State: AOAM5315kZ8yG4IBiI6sMbQm6vVYYIdqFVOQwoahxvLgV00uMvV1Aj1A
        gIlPySC9hewC/8jqPDYHXg8=
X-Google-Smtp-Source: ABdhPJwPr/9uXU2IvEIDs8Blv0vwef/+fetPCliQEqFevukstb4MpusHRcsi27e+QEHXp6tJJYJ4vQ==
X-Received: by 2002:a05:600c:1550:: with SMTP id f16mr15055637wmg.97.1616404745808;
        Mon, 22 Mar 2021 02:19:05 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t14sm18804021wru.64.2021.03.22.02.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 02:19:04 -0700 (PDT)
Date:   Mon, 22 Mar 2021 10:19:22 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YFhhGpiHDELxIo9V@orome.fritz.box>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
 <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ac7ZqnGaQdNmD+CJ"
Content-Disposition: inline
In-Reply-To: <YBRyG0vv3gRzygSB@workstation.tuxnet>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Ac7ZqnGaQdNmD+CJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 29, 2021 at 09:37:47PM +0100, Clemens Gruber wrote:
> Hi Sven,
>=20
> On Fri, Jan 29, 2021 at 01:05:14PM -0500, Sven Van Asbroeck wrote:
> > Hi Clemens,
> >=20
> > On Fri, Jan 29, 2021 at 11:31 AM Clemens Gruber
> > <clemens.gruber@pqgruber.com> wrote:
> > >
> > > Ok, so you suggest we extend our get_state logic to deal with cases
> > > like the following:
> >=20
> > Kind of. We can't control how other actors (bootloaders etc) program the
> > chip. As far as I know, there are many, many different register setting=
s that
> > result in the same physical chip outputs. So if .probe() wants to prese=
rve the
> > existing chip settings, .get_state() has to be able to deal with every =
possible
> > setting. Even invalid ones.
>=20
> Is the driver really responsible for bootloaders that program the chip
> with invalid values?
> The chip comes out of PoR with sane default values. If the bootloader of
> a user messes them up, isn't that a bootloader problem instead of a
> Linux kernel driver problem?

It is ultimately a problem of the bootloader and where possible the
bootloader should be fixed. However, fixing bootloaders sometimes isn't
possible, or impractical, so the kernel has to be able to deal with
hardware that's been badly programmed by the bootloader. Within reason,
of course. Sometimes this can't be done in any other way than forcing a
hard reset of the chip, but it should always be a last resort.

> > In addition, .apply() cannot make any assumptions as to which bits are
> > already set/cleared on the chip. Including preserved, invalid settings.
> >=20
> > This might get quite complex.
> >=20
> > However if we reset the chip in .probe() to a known state (a normalized=
 state,
> > in the mathematical sense), then both .get_state() and .apply() become
> > much simpler. because they only need to deal with known, normalized sta=
tes.
>=20
> Yes, I agree. This would however make it impossible to do a flicker-free
> transition from bootloader to kernel, but that's not really a usecase I
> have so I can live without it.
>=20
> Another point in favor of resetting is that the driver already does it.
> Removing the reset of the OFF register may break some boards who rely on
> that behaviour.
> My version only extended the reset to include the ON register.
>=20
> >=20
> > In short, it's a tradeoff between code complexity, and user friendlines=
s/
> > features.
> >=20
> > Sven
>=20
> Thierry, Uwe, what's your take on this?
>=20
> Thierry: Would you accept it if we continue to reset the registers in
> .probe?

Yes, I think it's fine to continue to reset the registers since that's
basically what the driver already does. It'd be great if you could
follow up with a patch that removes the reset and leaves the hardware in
whatever state the bootloader has set up. Then we can take that patch
for a ride and see if there are any complains about it breaking. If
there are we can always try to fix them, but as a last resort we can
also revert, which then may be something we have to live with. But I
think we should at least try to make this consistent with how other
drivers do this so that people don't stumble over this particular
driver's behaviour.

Thierry

--Ac7ZqnGaQdNmD+CJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYYRoACgkQ3SOs138+
s6GNvQ/9GYrn0Z4FSaTCTsNYUop9p7uh88wwcGhGvIYnyj7MG2cotSJTo5AUFLlj
2/SZFd4Rq1IOLCPK7kf7+aMbVBGwFDKBbY6O5joEduv6JWJWiTuFId4pGYr9jlgo
DRUJe8/RjXB1PHFSykaSBJgWpZiKmGHvWOvfQdmgUOGIRkq6X60BmVYOsP2VU+O/
d64nSLDQal7s82woZJ4wAKMMcqFEYwGCZW6H98WIf0wZkL84BzbgbPmDU7zmC4GH
ZR+Fh/d7xXkqIiNNLjjSoM2x2mjoVm3lpwSLYzdSCh787TFgjbb8qbLnJ+LUOPkx
MAzKguF4NXJ3ICvY5LQIxli8IEyEw5g/QldplrNlBAUYf+d41ocwSDCRXRtIiq5k
0kSVNN2Wqzl5n3LTziot+WYDCDIr7Nmg5LckT8V3E4/2EK6DzRwkmEt85Ldj7t29
pJq2HHBviHVRtz1Gkl1rcJtGZ/l1JlT8H+99p9voSFekX+dbp3knt3u2vNKZcb4R
h0CZRDtYP8Z5ZS/AToHJtvt2fxMNVvKqOEeF1/9YyobmhtIn1nLsCqr+gCV3V9MX
RGwV+/fNPjnjHfrMkZ8Dtp47plwYZ5FLRuw/QqU1FQwrzHOwoY5kL8Q6Xwpw2TAK
jrPzV0n0IsRXqmFbzN0oRltORsvKc9RATtEkNKouguMNNtgdVmQ=
=/OGw
-----END PGP SIGNATURE-----

--Ac7ZqnGaQdNmD+CJ--
