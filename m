Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D77351C28
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Apr 2021 20:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhDASNo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Apr 2021 14:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbhDASHj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Apr 2021 14:07:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF287C08EC69;
        Thu,  1 Apr 2021 06:47:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ap14so3039447ejc.0;
        Thu, 01 Apr 2021 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3WPXZ6bW7Bs1p7bDkovKQl43bZaz87E8jPpqS1X/MJI=;
        b=F+OxziOWjavOhpAc988WR3NNo+E5uyB3UQDS2bEc2oWenqWTNFBu0zROyMnjrMBz2Q
         rMZPWE2AQcYJQ2I4vE0QGanzr48vWkUbAOSAh4kXF6eiNDY8QaWK4xj5HS3WqUYNZJhS
         WoSJR8C+CSj3DDeuSbhWDpcOCtCgurBxsok9B66B5f6+k2Vo7eSHS+7+t62+tjQM/jtI
         Sbe2eLoO4O8ZpIn7S1tPvH/o3sMxy1/tt8h6NMNckHG3Pi8ATGSykn/FC3bdk8QNMMrJ
         7HxfjdgmUSgnOKidbvuEFWS/fk+/zYBAytHCK4V5cm1ZxAXdDwltH3ObeYFuYOu8mSuH
         FpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3WPXZ6bW7Bs1p7bDkovKQl43bZaz87E8jPpqS1X/MJI=;
        b=LJrWJPue/O9MF5Yn0gZIXLdVLEDY5zGGcosELxkuLN+o5JkfIPs8WbTRSOFsusdc+i
         WYDtuU26/22eKQaEs6InlEQFJatxbNxw9L2XmnXmIxEaGQr8Du2TZUxvvZkGMjo86HRo
         MsaT5YxW/t6/PsoKwGRtiLa5Z5okh+If7O/0dZ4zhYNAdh0ZrhnR1qf/Km/9JL8/60u7
         Rezb8Q10S7utuQBBEW9OPMnzAcswEOnTcvdtc97AbCcx3/owiVY6Y/jG7SBuX+QPvgap
         yyfsRcO9Qw7+i0JGJd1fR0tKGQVBAm7Zrt0ZsI2KRo3GVwbepBInXf4da7a9ssKJ1XHQ
         CNLA==
X-Gm-Message-State: AOAM532E9IpsYOpbG+zOf1cAjuA0IsbR0sQsSI4nWGTM2sCvo62UFyJA
        oCCCrqkT+lFq510HkZymve2r7DcQbmU=
X-Google-Smtp-Source: ABdhPJy5KiR8yy7W4DRkIWo1/AoTaKfrfOOMF+GC1Mu8X3J4hzgXoVfKsqowrqrNqbeVCag84XYpkA==
X-Received: by 2002:a17:906:3388:: with SMTP id v8mr9298092eja.278.1617284820361;
        Thu, 01 Apr 2021 06:47:00 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id l12sm3441740edb.39.2021.04.01.06.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:46:58 -0700 (PDT)
Date:   Thu, 1 Apr 2021 15:47:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <YGXO7oKWPjYYrVFy@orome.fritz.box>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
 <20210329170357.par7c3izvtmtovlj@pengutronix.de>
 <YGILdjZBCc2vVlRd@workstation.tuxnet>
 <20210329180206.rejl32uajslpvbgi@pengutronix.de>
 <YGRqZsi4WApZcwIT@workstation.tuxnet>
 <YGShjDE8R31LwAbi@orome.fritz.box>
 <YGV7VJ72nWDIjNbu@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yAS+JO9jOlPONqYz"
Content-Disposition: inline
In-Reply-To: <YGV7VJ72nWDIjNbu@workstation.tuxnet>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yAS+JO9jOlPONqYz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 01, 2021 at 09:50:44AM +0200, Clemens Gruber wrote:
> Hi Thierry,
>=20
> On Wed, Mar 31, 2021 at 06:21:32PM +0200, Thierry Reding wrote:
> > On Wed, Mar 31, 2021 at 02:26:14PM +0200, Clemens Gruber wrote:
> > > On Mon, Mar 29, 2021 at 08:02:06PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Mon, Mar 29, 2021 at 07:16:38PM +0200, Clemens Gruber wrote:
> > > > > On Mon, Mar 29, 2021 at 07:03:57PM +0200, Uwe Kleine-K=C3=B6nig w=
rote:
> > > > > > On Mon, Mar 29, 2021 at 02:57:04PM +0200, Clemens Gruber wrote:
> > > > > > > The PCA9685 supports staggered LED output ON times to minimiz=
e current
> > > > > > > surges and reduce EMI.
> > > > > > > When this new option is enabled, the ON times of each channel=
 are
> > > > > > > delayed by channel number x counter range / 16, which avoids =
asserting
> > > > > > > all enabled outputs at the same counter value while still mai=
ntaining
> > > > > > > the configured duty cycle of each output.
> > > > > > >=20
> > > > > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > > >=20
> > > > > > Is there a reason to not want this staggered output? If it neve=
r hurts I
> > > > > > suggest to always stagger and drop the dt property.
> > > > >=20
> > > > > There might be applications where you want multiple outputs to as=
sert at
> > > > > the same time / to be synchronized.
> > > > > With staggered outputs mode always enabled, this would no longer =
be
> > > > > possible as they are spread out according to their channel number.
> > > > >=20
> > > > > Not sure how often that usecase is required, but just enforcing t=
he
> > > > > staggered mode by default sounds risky to me.
> > > >=20
> > > > There is no such guarantee in the PWM framework, so I don't think we
> > > > need to fear breaking setups. Thierry?
> > >=20
> > > Still, someone might rely on it? But let's wait for Thierry's opinion.
> >=20
> > There's currently no way to synchronize two PWM channels in the PWM
> > framework. And given that each PWM channel is handled separately the
> > programming for two channels will never happen atomically or even
> > concurrently, so I don't see how you could run two PWMs completely
> > synchronized to one another.
>=20
> As the PCA9685 has only one prescaler and one counter per chip, by
> default, all PWMs enabled will go high at the same time. If they also
> have the same duty cycle configured, they also go low at the same time.

What happens if you enable one of them, it then goes high and then you
enable the next one? Is the second one going to get enabled on the next
period? Or will it start in the middle of the period?

To truly enable them atomically, you'd have to ensure they all get
enabled in basically the same write, right? Because otherwise you can
still end up with just a subset enabled and the rest getting enabled
only after the first period.

> > Or did I misunderstand and it's only the start time of the rising edge
> > that's shifted, but the signal will remain high for a full duty cycle
> > after that and then go down and remain low for period - duty - offset?
>=20
> Yes, that's how it works.

That's less problematic because the signal will remain a standard PWM,
it's just shifted by some amount. Technically pwm_apply_state() must
only return when the signal has been enabled, so very strictly speaking
you'd have to wait for a given amount of time to ensure that's correct.
But again, I doubt that any use-case would require you to be that
deterministic.

> > That's slightly better than the above in that it likely won't trip up
> > any consumers. But it might still be worth to make this configurable per
> > PWM (perhaps by specifying a third specifier cell, in addition to the
> > period and flags, that defines the offset/phase of the signal).
> >=20
> > In both cases, doing this on a per-PWM basis will allow the consumer to
> > specify that they're okay with staggered mode and you won't actually
> > force it onto anyone. This effectively makes this opt-in and there will
> > be no change for existing consumers.
>=20
> I agree that it should be opt-in, but I am not sure about doing it
> per-pwm:
> The reason why you'd want staggered mode is to reduce EMI or current
> spikes and it is most effective if it is enabled for all PWMs.
>=20
> If it is specified in the DT anyway and you have a consumer that does
> not support staggered mode (probably rare but can happen), then I'd
> suggest just disabling it globally by not specifying nxp,staggered-mode;
>=20
> Also it would make the configuration more complicated: You have to do
> the "staggering" yourself and assign offsets per channel.
> It's certainly easier to just enable or disable it.
>=20
> What do you think?

Yeah, if you use an offset in the PWM specifier, users would have to
manually specify the offset. An interesting "feature" of that would be
that they could configure a subset of PWM channels to run synchronized
(module the atomicity problems discussed above). Not sure if that's
something anyone would ever want to do.

Another option would be to add some new flag that specifies that a given
PWM channel may use this mode. In that case users wouldn't have to care
about specifying the exact offset and instead just use the flag and rely
on the driver to pick some offset. Within the driver you could then just
keep the same computation that offsets by channel index, or you could
have any other mechanism that you want.

Thierry

--yAS+JO9jOlPONqYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBlzusACgkQ3SOs138+
s6HnzxAAowV8Q0Bn53+ge8GqpzgTc05Pq3rR1LhUSsg71TSJ0ZOXBJF/maGysOmQ
35sBKNzo5hp1PoGEPLdp4Qy+8VE/QGkG5nvjJuiBueoi5PLSJrWA3uz3dW2FXGVb
SmGpCpnGPQvdo7KM9laEHSNZaZeFTgbVZXoBRuOu6IdwDTKlkgPnzWGMN9oXw1j8
z5xVAu6MxbQKJnzFUaR3kRckCEhoBfg4a8BdBAMxDtw7JSWYhk3Yp6+HyAhbfx33
c5jlqGlzd9u9MbIyeBfv3qlZYMx4s2hUnBt0iYakSzJqU2/Dzqhbd6nV45vxKd24
BTRtEbGrDlk9cxuy7Z2LfF4ZQeO9i1XDn3jAKbNmK7pgTJhfuq5LgJ6mEG8SgYuC
VPioEU8e53iPK9mvaumCKBDbPppSTjT0kOP61ZcbXw5cpQq7rvvL8KNy+cF1p9AV
STkOVqJhZg+TNEXmrdsriHywybAJZGf3uOK7TqFRl0Fw2IIoO0+kMXEPmhEOBn3p
9/rDkzfqF89r3rxUnIVo3/KLuXGlggSkqQ14sH7Tqa/pPIJAAO/VsmhF3UgXF5m7
DQrQM5NC9ZC0QMDxbclPXHre0tn2Zs/qDG1vYRllCszd+kVpVqYfX9O5dINXK9jc
sdk6yyIYYoSoZDdjBvbDj6NyDe37GhvUJdC6tO8oSQ4+9i05mGk=
=agkx
-----END PGP SIGNATURE-----

--yAS+JO9jOlPONqYz--
