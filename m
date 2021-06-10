Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1F3A2C8D
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jun 2021 15:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFJNNF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Jun 2021 09:13:05 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40825 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFJNNF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Jun 2021 09:13:05 -0400
Received: by mail-wr1-f52.google.com with SMTP id y7so2252066wrh.7;
        Thu, 10 Jun 2021 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4f+fsTzlqk4Doy8mEp8ob8qzE9C2j0yN/+wDfzUy4TU=;
        b=kObKvZ3OOQKsEOBvNzSJlB/v3h+u7ip8MkbSRsvzZBWQaWU8JSwgmtp6Mdk3Zc2Hf+
         v5sBt0tDnlL5866q6w7kLQAksksmWDsCjhyXHi2FJ8OooUIeeCHYvhYeJTJwtKAUOS/V
         B08vQ3QgXdqdaMgU9ipNy35XBNmst6DEH2KW+6QTjIZOCI0X/9JGstZCow59zhGaFSjX
         mTDpmyLudCesXO1mNgakT0ziRsyATDr56kmvJeyQQpX2FXT/i6SnXsNfm64SxhK9W9lW
         pWwhjb6r28j1dldqdBSJNJyx35ENfjW+0FecWirjJowYDTVPecozOd42relqr1tCZFlo
         0Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4f+fsTzlqk4Doy8mEp8ob8qzE9C2j0yN/+wDfzUy4TU=;
        b=KVEQSdBSgiv2hfuR2MNeJASfou5sSryZ0kQa5sYg+ZY7MW1EJaTmyNHyDm1ZzvKAVU
         MEnPBIzsuTwEMW4ZU2eCKBQn8QzGAx5m25yBvUOzCoAk1bDN8MR/AMJSWHo3hxkt3CYF
         irzdEwzr9x0camdE7f5O6rKAiceb8Gon052FGTx8ZMWMreL0xfLj6crfgOWUMaEVotOm
         qEwM3zEu/35aVEfp/ap43zUqzQYEE9xK+Iw08ylKgmS/BJxSU7tpYHhHmttAlQtO2AXQ
         UH12wFpfEqIXX8CXaNpHc8TP4OTHSIlSPVTMM2Pm7nhZSaSkNslr7JdcWV1JP0luEwxe
         j16A==
X-Gm-Message-State: AOAM530vFuzWG2UV3uapVzz6MmxlO4o/GvUkABItGDmuVV7BZ0Wpd5+Z
        zOHl4bx+Uagpc+zLDXo8oMk=
X-Google-Smtp-Source: ABdhPJxsLSjK+geZQ5dJLH/Z5KJd+5rJHYswkoNu0wRa0Khq1o4Fsaj4zyeVjV6HfdVrAfZMA/5/0A==
X-Received: by 2002:a5d:47a6:: with SMTP id 6mr5301217wrb.203.1623330598144;
        Thu, 10 Jun 2021 06:09:58 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o11sm2785535wmq.1.2021.06.10.06.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 06:09:56 -0700 (PDT)
Date:   Thu, 10 Jun 2021 15:11:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sven Van Asbroeck <TheSven73@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/4] pwm: core: Support new usage_power setting in PWM
 state
Message-ID: <YMIPjGtYfby6ZXKl@orome.fritz.box>
References: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
 <20210507150317.bnluhqrqepde4xjm@pengutronix.de>
 <YJVhLrkeNXBp6M1p@workstation.tuxnet>
 <20210507231831.zmvyspcq7xhm25y4@pengutronix.de>
 <YLUK8GXHaBYyVe1R@workstation.tuxnet>
 <YLn3MZ+6HJM/UrRT@orome.fritz.box>
 <20210607060827.vxdihsfqtw3otyco@pengutronix.de>
 <YL4vzvznTzqih0pA@orome.fritz.box>
 <20210607185158.jweahkoa3cxwl2nh@pengutronix.de>
 <20210609204144.nkksqjovs2yqfiyo@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lW/sldeGnfD/1z66"
Content-Disposition: inline
In-Reply-To: <20210609204144.nkksqjovs2yqfiyo@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lW/sldeGnfD/1z66
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 10:41:44PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Mon, Jun 07, 2021 at 08:51:58PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > My problem is not that in the end a solution is picked that wasn't my
> > favourite. My problem is that I have the impression my arguments were
> > not considered but simply ignored.
>=20
> Another thing that annoys me is that there are currently ~20 open
> patches by me in patchwork, most of them are easy to understand cleanups
> and fixes, most of them are older than Clemens' series and most of them
> are uncommented by you. And in this situation you apply the only
> controversial series.

Clemens' series is actually older than those cleanups because it's been
in the works for many months now. And the reason why I'm prioritizing
Clemens' series is because it has broader impact and I want to make sure
it gets maximum soaking time in linux-next. Small fixes and cleanups are
less likely to break things, so I'm going to apply them after.

Thierry

--lW/sldeGnfD/1z66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDCD4kACgkQ3SOs138+
s6HOoA//fjFojkbazod7GhlxBC1N6vSY3Rl9yLfOdAVm/tKxLnHF5HhKZCS8GfCB
85Gxby+h2GABIZ6grkbRHpptoGF9SMVb5SZKmWT43oOlEiUzuUb8gyWIS9GN4H4O
cNiAvjM2u70q2gJKEaWJAcJpgcDdDvsq2EGVbjs/Nr8Ki1U53Ez4z6sx9/LHvyai
mwe7o1p0XH/sHDLf+iq0lohVrVgr0HGnT7ix1EunP+o+EGk1ym6JpMxiV0QaI7Z2
bxjLFaSi1jBSjT0qIIFpx1EvGB5CuES2tERbv/4EfgPmwIpGJRF2293NT12l4YLM
FZ7bgPE1R9FwyzL9JN5Whs+S0q33O+lPYNxfnWtkMqqM4XVySUXJtGfr6r3ywiOx
qM0bhIySqEHcS1CB3Ollh+yFHcF7e9keOcYtaYx0Z0XDWcaq7GfEGuGQhomtdwnj
lunNqFRQtuZzaqTrOG3sRWefrUE4KOPxalD31fGmGnyF9Q0sKWbMu5MzqW6VqXTo
2W6kuwhBkW/Xk9dBZBU4unK2L1BAaDZjeX1ckUg3o9afdjkPJESN2ceQp2qHnJoB
LnkG5awVco5LMWwHNzkcp0qfsdWmlenUlUqLI1DoeIrN5NoZwmnGPahnRXpIMz2A
uKMjJWvapD0LlDsryOkYLKQMPmx+22gBGT58yAEvpJasa3EzGBI=
=nW3a
-----END PGP SIGNATURE-----

--lW/sldeGnfD/1z66--
