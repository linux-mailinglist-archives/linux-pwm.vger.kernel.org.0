Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3623113D33
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2019 09:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfLEIlI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Dec 2019 03:41:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46570 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfLEIlI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Dec 2019 03:41:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so2355036wrl.13;
        Thu, 05 Dec 2019 00:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2aYObqapVwiSgTbOEHlMEQK+DUf2NrxUfBKyEeh96/k=;
        b=KWP9g8TCfkVoslZ/61JCxFu7taS75PMllzm/yw3V9D1ZuZf8hXkxxQco/pjGAdn6/+
         ouuy30NSIu34kJVCsZQiQmdbXocf8ogHkK4eWZKMWEh+QseU3yzi5s5+aOq+koTkSr5N
         KUOiKWLMdLNjdSsA+qxoC4aywFYqDrv87sv29+UcfLCDoW2k3ysKS74peGer3JVytKK1
         CX1XNR6jcEbFIrRTCaguoCbx3J1JHkamvGS+TW2hAJEbY874yDP3tJcCc1By4B+gdZqX
         wmbuQ/5gQFR41BNCtZG5/gQSKS2v4bJaxBA02J5Ct1aPksGshtjQCmbs4Zzg2DlzNgsg
         a+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2aYObqapVwiSgTbOEHlMEQK+DUf2NrxUfBKyEeh96/k=;
        b=QJGO39bpPEqkuPnM2iuqL1K9oR0gsmed8fl6VOZJW5NvK3/lGuXNShWab7vQSKrDrE
         0Mf1bLQjAgTW+5R+FNfT0WDZUtKOUqeTKOFT7MSlmJMFEbZKhRCdatoQrvxNa1o0ruja
         h3EHyY20i9clSvR4uLcXlx0yBD0A/JFnalhNTw/g+9yaPVllqCEcOho6xXhJ7BwluDF5
         wbOHrRNruot03M4mZIZ4haUWqWkt4Vusx0vj1Lj+cLdYtJhRRfeYHECyL/J0WQJGm5SV
         iEVlbVbjk3iiFFfdrFAPeujp9HtITJMzq4UmPhmyDw0Neu5uYctnG2FF0u7cHPeV2liJ
         DwFQ==
X-Gm-Message-State: APjAAAVgFs5j/hBBWgpOeMD0b3iK6M0FWkd6YgHAhz2fXJBVllLcwAv4
        BYFFRrtJuRZgRyNSBv7TZjg=
X-Google-Smtp-Source: APXvYqxD3GnQegffvgV2RVDcS+dz3uYlsHQvR0ISWs1up2/BIbZTXSe2aEAryyTHTIKRYJhGOpW19g==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr9187850wrt.100.1575535265043;
        Thu, 05 Dec 2019 00:41:05 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id x10sm11426262wrv.60.2019.12.05.00.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 00:41:04 -0800 (PST)
Date:   Thu, 5 Dec 2019 09:41:02 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pwm: Changes for v5.5-rc1
Message-ID: <20191205084102.GA1401169@ulmo>
References: <20191205061044.1006766-1-thierry.reding@gmail.com>
 <20191205075958.jrz3xuthyh7wv6uu@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20191205075958.jrz3xuthyh7wv6uu@pengutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2019 at 08:59:58AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Dec 05, 2019 at 07:10:44AM +0100, Thierry Reding wrote:
> > The following changes since commit 40a6b9a00930fd6b59aa2eb6135abc2efe54=
40c3:
> >=20
> >   Revert "pwm: Let pwm_get_state() return the last implemented state" (=
2019-10-21 16:48:52 +0200)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pw=
m.git tags/pwm/for-5.5-rc1
> >=20
> > for you to fetch changes up to f5ff2628867b9c7cb4abb6c6a5a7eea079dad4b6:
> >=20
> >   pwm: imx27: Unconditionally write state to hardware (2019-10-21 16:58=
:09 +0200)
> >=20
> > Thanks,
> > Thierry
> >=20
> > ----------------------------------------------------------------
> > pwm: Changes for v5.5-rc1
> >=20
> > Various changes and minor fixes across a couple of drivers.
> >=20
> > ----------------------------------------------------------------
> > Colin Ian King (1):
> >       pwm: sun4i: Drop redundant assignment to variable pval
> >=20
> > Fabrice Gasnier (3):
> >       dt-bindings: pwm-stm32: Document pinctrl sleep state
> >       pwm: stm32: Split breakinput apply routine to ease PM support
> >       pwm: stm32: Add power management support
> >=20
> > Ondrej Jirman (1):
> >       pwm: sun4i: Fix incorrect calculation of duty_cycle/period
> >=20
> > Rasmus Villemoes (1):
> >       pwm: Update comment on struct pwm_ops::apply
> >=20
> > Thierry Reding (8):
> >       dt-bindings: pwm: mediatek: Remove gratuitous compatible string f=
or MT7629
> >       pwm: stm32: Validate breakinput data from DT
> >       pwm: stm32: Remove clutter from ternary operator
> >       pwm: stm32: Pass breakinput instead of its values
> >       pwm: Read initial hardware state at request time
> >       pwm: cros-ec: Cache duty cycle value
> >       pwm: imx27: Cache duty cycle register value
> >       pwm: imx27: Unconditionally write state to hardware
>=20
> It's a bit of a surprise for me that you included the three last patches
> as last minute changes. I'm not sure if I oppose them, but they were not
> in next (as of next-20191205) and I would really like to have some time
> for patches (that are not obvious fixes of course) there before they go
> into a pull request. And if it's only to get some transparency.
> (But in this case I had the impression that the discussion isn't over
> yet, your last mail in the thread said: "I'm not sure yet about the
> remainder of the series. Depending on what we decide to do about drivers
> that can't (or don't want to) write all state through to the hardware,
> patches 2-4 may become moot." in October which made me expect there is
> still something to come, at least a statement before the fact. Still
> more as also several further drivers are affected (according to my
> research described in
> https://patchwork.ozlabs.org/patch/1178351/#2282269).)

Yes, the last four patches weren't meant to be in this pull request.
That's what I get for trying to squeeze this in before coffee.

Linus, please ignore this one, I'll send out a new pull request shortly.

> In return there are a few patches I would really have liked to be seen
> here:
>=20
>  - The series "Updates for the atmel PWM driver" that didn't get any
>    response from you since August although it got some acks from the
>    atmel guys.
>    (https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D127096&=
state=3D*,
>    This is marked Superseeded for reasons unknown to me that I asked
>    about in October.)

I usually mark patches as superseeded when there are new revisions. It
looks like I might have marked these accidentally since I can't see any
new versions of that series. I'll pick those up after v5.5-rc1.

>  - The series starting with "pwm: rcar: Drop useless call to
>    pwm_get_state" from October which got reviews by a renesas guy.
>    (https://patchwork.ozlabs.org/patch/1182649/,
>    https://patchwork.ozlabs.org/patch/1182648/,
>    Patchwork didn't identify this as a series, so listing the patches
>    individually.)

I missed those. Please do ping me if I haven't reviewed or applied
patches after a week or so to remind me. Sometimes my inbox fills up so
quickly that some patches get lost.

>  - The patch "pwm: implement tracing for .get_state() and
>    .apply_state()" that got an review by Steven Rostedt.
>    (https://patchwork.ozlabs.org/patch/1182679/)

Review for this came in after v5.4-rc7, so I didn't consider it for
v5.5. I'll pick it up after v5.5-rc1.

>  - The series starting with "pwm: omap-dmtimer: remove pwmchip in
>    .remove before making it unfunctional" from November which IMHO is
>    simple and contains two fixes
>    (https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D142030)

Same here.

> And I'm still waiting for feedback on
>=20
>  - "Documentation: pwm: rework documentation for the framework" (since
>    January)

Please resend this, I can't find it in my inbox.

>  - "pwm: add debug knob to help driver authors" (since August)

My recollection is that this flagged a bunch of issues right out of the
box, so I'm hesitant to apply it without wider concensus that we want
this, or some effort to address the issues that this flags.

Thierry

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3owpwACgkQ3SOs138+
s6GHeBAAsAz/gYJgOXhz46xFjLokhH3BUTmnAU9b4d2N9hEfKzls+oDfM4VkrVHh
CnT1Yq+XlRFlDF3YisgjVeWAT6mG1D5JuX0kHFHheFqJwiZKkJAJ4hvmbuQ3xfBt
1JbBWZIeccZaVpjVA8miXYbrkg+gRPiSTXr/wEJVSohQ/2badkWxqnscBxRLxG+F
ANi8Z4mxlSziamQXKp+iOmupD86kNVWTJw/0Qj4lqnqXX6g/YS/gQ3cR18PtLNWl
shznDtCcINHpID7dfTzTSwPgQKcBsbU+hwCJuowBUBeSOPPgnQaKa1/AO0i/aWvJ
YkI5iJS5Vcv06hf71PTWnfKJxrv2kALCKWEWrNBiaPR8vTZIeHQcHwCThnlY3egc
7ullgghT0j6Ezb3I9mEt27ZDxlwYNkxNaEuWdKK8Y6p/UyF2+S6EAkeBOnJltJGl
0BisLy5ogquAgKzwUfHZAJAE7zKLcWPqby1denDoHC/UtnzdRD7tmkPsSzPADppR
0BaDnFaJCK/BQEMMMuTrFHW4IfZRWdgcHrW/cd1z68DE/jFhAdDJkCszUs+rFKz8
cTFVzzal92pNHhnirkmSZl4A/gGtapdeL58XxaRse5gUrdGpiCRxmE+b+m+qVFDG
NNtSP0aVTK0n9ohLj6ni7ZB+qHj+F26Pb910xT648S2Bn6/6Ta8=
=w9TY
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
