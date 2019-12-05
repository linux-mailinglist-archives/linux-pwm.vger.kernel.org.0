Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD41113FE3
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2019 12:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfLELEc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Dec 2019 06:04:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39550 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbfLELEc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Dec 2019 06:04:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id s14so3153917wmh.4;
        Thu, 05 Dec 2019 03:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pTH/YG3diRsUF2efRnDtD2uj5CEkI49OM65Owz3UsS4=;
        b=dySRrdpqmHuhku5TelbheYisxa07m7oWvbs4DHuwpaJ6vvOaeX6EO/fEPP0Z6yuVaM
         iK4fNJ8bvb5ATeh7Dl2CwiT1MtubNiRxav0B/cN/GI5YA6L6XzSZwvmy74K71ZE7P3Ss
         cxD457RrftpOqOUY6/tYsp0B72NTO84NOB9HOH014eqVaOmwGT20Sn2j6fiEnBqnM0Gm
         kdxuW6YI5hEOcy+D5VSfa/xrszfZKtjFRYRRtuWZ9kQmbTf0ppTldwBv0EcQPcfiVSA+
         qOGRNkdw2bEwzkX9+pH2lQo4RLnfhyhDBuqzzmQjjhCGo2QOjR/7JLIF5mUhf8yY3MqP
         TMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pTH/YG3diRsUF2efRnDtD2uj5CEkI49OM65Owz3UsS4=;
        b=az1bDNqY4A3Lqoz5pXhKqqpd0gz8lWFBJrJz3k8SJyDGlsmDv2cI2nnGXnk5iKpP74
         aLZLxi15SE13uOnbPmgzoGGE8M/dSw25Vi97EWRoNHGV7al2KW7zZqrC6Bphvzfi3vyf
         WXVQCZ0bdHicWv5q9nsM/fY4tWBr8ijskjg0Os1kzCaErgHtbhmXsYczy3ZhlUaqA+8B
         bjx7oC4U6ldmobiM8kH8Ymdj9Q7dRE1R2ZV0EfkvWtR4Mgd5xJB0Cqu7I0jbVo5pynku
         xPNWmavEVYQp0ErdNB1gMnIUH9rFe5gwYBtzFLXJ1BQbtdGy1wXC+7IJHThWeh6FeAZs
         CzYQ==
X-Gm-Message-State: APjAAAWSfrOa+MqgESWS0nY+cK/mn8NyH+ULTLLWZaOZfU8DxrkaJ2xh
        9WnTavrzb3yrfNH/kSyZQnYmz+z2kPc=
X-Google-Smtp-Source: APXvYqyxDFj8wUFZhUIzxwO7+ps9GHpLb5c8ymLEZeaCHntp1DBGZ5jtOW+mWRA69FIDE90JF4hxvw==
X-Received: by 2002:a1c:40c1:: with SMTP id n184mr4865711wma.116.1575543868688;
        Thu, 05 Dec 2019 03:04:28 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id f67sm10074849wme.16.2019.12.05.03.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 03:04:26 -0800 (PST)
Date:   Thu, 5 Dec 2019 12:04:25 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pwm: Changes for v5.5-rc1
Message-ID: <20191205110425.GA1498132@ulmo>
References: <20191205061044.1006766-1-thierry.reding@gmail.com>
 <20191205075958.jrz3xuthyh7wv6uu@pengutronix.de>
 <20191205084102.GA1401169@ulmo>
 <20191205100535.y7avzoswkxe43py7@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20191205100535.y7avzoswkxe43py7@pengutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2019 at 11:05:35AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Dec 05, 2019 at 09:41:02AM +0100, Thierry Reding wrote:
> > On Thu, Dec 05, 2019 at 08:59:58AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Dec 05, 2019 at 07:10:44AM +0100, Thierry Reding wrote:
> > > > The following changes since commit 40a6b9a00930fd6b59aa2eb6135abc2e=
fe5440c3:
> > > >=20
> > > >   Revert "pwm: Let pwm_get_state() return the last implemented stat=
e" (2019-10-21 16:48:52 +0200)
> > > >=20
> > > > are available in the Git repository at:
> > > >=20
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linu=
x-pwm.git tags/pwm/for-5.5-rc1
> > > >=20
> > > > for you to fetch changes up to f5ff2628867b9c7cb4abb6c6a5a7eea079da=
d4b6:
> > > >=20
> > > >   pwm: imx27: Unconditionally write state to hardware (2019-10-21 1=
6:58:09 +0200)
> > > >=20
> > > > Thanks,
> > > > Thierry
> > > >=20
> > > > ----------------------------------------------------------------
> > > > pwm: Changes for v5.5-rc1
> > > >=20
> > > > Various changes and minor fixes across a couple of drivers.
> > > >=20
> > > > ----------------------------------------------------------------
> > > > Colin Ian King (1):
> > > >       pwm: sun4i: Drop redundant assignment to variable pval
> > > >=20
> > > > Fabrice Gasnier (3):
> > > >       dt-bindings: pwm-stm32: Document pinctrl sleep state
> > > >       pwm: stm32: Split breakinput apply routine to ease PM support
> > > >       pwm: stm32: Add power management support
> > > >=20
> > > > Ondrej Jirman (1):
> > > >       pwm: sun4i: Fix incorrect calculation of duty_cycle/period
> > > >=20
> > > > Rasmus Villemoes (1):
> > > >       pwm: Update comment on struct pwm_ops::apply
> > > >=20
> > > > Thierry Reding (8):
> > > >       dt-bindings: pwm: mediatek: Remove gratuitous compatible stri=
ng for MT7629
> > > >       pwm: stm32: Validate breakinput data from DT
> > > >       pwm: stm32: Remove clutter from ternary operator
> > > >       pwm: stm32: Pass breakinput instead of its values
> > > >       pwm: Read initial hardware state at request time
> > > >       pwm: cros-ec: Cache duty cycle value
> > > >       pwm: imx27: Cache duty cycle register value
> > > >       pwm: imx27: Unconditionally write state to hardware
> > >=20
> > > It's a bit of a surprise for me that you included the three last patc=
hes
> > > as last minute changes. I'm not sure if I oppose them, but they were =
not
> > > in next (as of next-20191205) and I would really like to have some ti=
me
> > > for patches (that are not obvious fixes of course) there before they =
go
> > > into a pull request. And if it's only to get some transparency.
> > > (But in this case I had the impression that the discussion isn't over
> > > yet, your last mail in the thread said: "I'm not sure yet about the
> > > remainder of the series. Depending on what we decide to do about driv=
ers
> > > that can't (or don't want to) write all state through to the hardware,
> > > patches 2-4 may become moot." in October which made me expect there is
> > > still something to come, at least a statement before the fact. Still
> > > more as also several further drivers are affected (according to my
> > > research described in
> > > https://patchwork.ozlabs.org/patch/1178351/#2282269).)
> >=20
> > Yes, the last four patches weren't meant to be in this pull request.
> > That's what I get for trying to squeeze this in before coffee.
>=20
> Ah right, it's four patches, not three. (I thought I saw "pwm: Read
> initial hardware state at request time" in next.)
>=20
> > Please do ping me if I haven't reviewed or applied patches after a
> > week or so to remind me. Sometimes my inbox fills up so quickly that
> > some patches get lost.
>=20
> ok.
>=20
> > >  - The patch "pwm: implement tracing for .get_state() and
> > >    .apply_state()" that got an review by Steven Rostedt.
> > >    (https://patchwork.ozlabs.org/patch/1182679/)
> >=20
> > Review for this came in after v5.4-rc7, so I didn't consider it for
> > v5.5. I'll pick it up after v5.5-rc1.
>=20
> I got Steven's mail on Oct 24 which is the week between -rc4 and -rc5,
> but ok, I won't argue.

Both my inbox and patchwork say that the email arrived on November 13.

> >=20
> > >  - The series starting with "pwm: omap-dmtimer: remove pwmchip in
> > >    .remove before making it unfunctional" from November which IMHO is
> > >    simple and contains two fixes
> > >    (https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D142=
030)
> >=20
> > Same here.
>=20
> Does "after v5.5-rc1" mean "for v5.5" or "for v5.6-rc1". I agree that
> the tracing stuff is merge window material (very useful though in my
> eyes) while the omap-dmtimer series (at least the first 3 of 4 patches)
> is about fixes.

These all change code that's been like this for more than 4 years and
nobody's ever reported a bug. The very worst that can happen here is
that we leak a device reference, but these are platform devices, so
they aren't going to go anywhere anyway.

> > > And I'm still waiting for feedback on
> > >=20
> > >  - "Documentation: pwm: rework documentation for the framework" (since
> > >    January)
> >=20
> > Please resend this, I can't find it in my inbox.
>=20
> :-|, given that I sent this already twice, pinged several times
> (https://patchwork.ozlabs.org/patch/1021566/,
> https://patchwork.ozlabs.org/patch/1000709/) and also asked at least
> once before in a mail where I pinged several patches using a list.

I find patchwork always difficult for reviewing, but that patch is
particularly difficult to review. You're basically rewriting all of the
documentation in a way that you think is better. It'd be much easier to
review if this was done more incrementally.

It looks like your goals could be easily met by just extending the
existing documentation, or bringing it up-to-date with the API.

> > >  - "pwm: add debug knob to help driver authors" (since August)
> >=20
> > My recollection is that this flagged a bunch of issues right out of the
> > box, so I'm hesitant to apply it without wider concensus that we want
> > this, or some effort to address the issues that this flags.
>=20
> I didn't want you to apply it. That it is not ready for that is out of
> the question. I assume the patch doesn't apply anymore and needs work
> for sure. The last mail in the respective thread had a single paragraph:
>=20
> 	do you consider the idea here worthwile? If so I'd update the
> 	patch to current mainline and address the feedback I got so far.
>=20
> This is still interesting, as I don't want to spend my time working on
> an idea that is then turned down in the end for conceptual reasons.

There's nothing conceptually wrong about it. The one problem that I see
with it is that we can't force people to use it because it's noisy when
things go wrong, and they currently do go wrong. On the other hand, if
we don't enforce its use, developers are likely to just ignore its
existence.

So I think we need to get drivers into a little better shape so that we
eliminate at least all of the issues that currently exist. Then we can
merge this and maybe opportunistically enforce this during a release
cycle to see if there's any fallout.

Thierry

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3o5DYACgkQ3SOs138+
s6FczhAAvO5Q8Nkaj6jTFyynuVmYj5ysvPFgapc0avecSZTKSYBsPIj5jdp9mx0M
dWhwej8W7QkxE4Vg2wfqifOUVBDdmxgukf0WS98o8LShA8iDkZY2xSYngzmug6An
TGyN0IPLApJQpN+dD9wmFi5N++YJ8SrX3ifOVe/lRc9e8EGHh0rlDkCyRKXqAOtN
FAD/XsmuNQa1qdyS6GoY2m1RSVmDPktZI+VFisA1Ne4Q74roil6Pn2OO+Wunizyp
m8jEj9k8IbJiUqTPI4ZHxiBqN6AY7zsHEr3T8k2NxAgLQ/dCSN+m9IijJjirH8Ml
DGbRdjwhxKvDgfCiRC386vfUcjH7mhHFNGcsBSgbEZmWvSA2/mgDt5wcZ6I4Gura
KK6VSAwuFwSrAjmDHW3mtqWCF0Nfsu5IWzgeAQq0HYLJ8F+RqquHAxDxJMCgBR3f
GTOTSuUN24bJuhcgZ5cpzbDbbj1De6UlzoK6UalJ9I631Ex2wlflNfFFtNEIvfrg
WEWLejhaAgEdaJN1ej0cXUkVzqC3ZQMjGLfvrWxj+myrVomhgmwOuReMraegKnyp
RzABtKiEeMiLYG+gJAPonjfnqv5y+mtCxjnIAXqK465NTqAc72nOEYkIHl3qFdgN
NWk3OjvUES/Ya7afU7QbuC1jbQzLYNeYsM6h8jN4AoAe1LUU8xc=
=46nO
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
