Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDAF3583A2
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Apr 2021 14:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhDHMuX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Apr 2021 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhDHMuW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Apr 2021 08:50:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3D2C061760;
        Thu,  8 Apr 2021 05:50:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ba6so2279601edb.1;
        Thu, 08 Apr 2021 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kQmlpRFaiSkwnFQaxaMk+lPCrWi61/xF3HJ6ui8mPN8=;
        b=WNO6Ik/Gi6lqZvM8C6+SH93+MazSGEQtNnRt3eRaCvjK7dYgR0vXGtrn+y4J5Z+k5E
         WyjXrrexdyhFy8mJTNIG2uOBdAECD5NhwX1mnu6+DZFjvWXgo71l9nRb8XPhgFCBhIvZ
         FmoANsamHwqfXp/EgW/o1FOyysWzJ6giUrbBFceQRE/DzOVBugnYmuItQvvTGKpZTU8n
         Q+WWg63AUcrrtLDhi/Rvic7OtLigfh2uJF4ARLvNV/DSk9QEslcBinkZsoy3PBcnXW7m
         rM1IFwF9s/tG7YBQbEEszsIXklIi1xF+Q113F1arFMJxv+W2dLxpRwLYKtu9NJM9Bumu
         PKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kQmlpRFaiSkwnFQaxaMk+lPCrWi61/xF3HJ6ui8mPN8=;
        b=ONOErOFBYrwQHF9mY+flKhDTTewo5P/zOF5fJ8wetFeICqo35436RbJOfm5m5LtrPg
         KwGx2gcPKx87EesxjyjNbGnsBvULkF4l4EVooHLU5oncvfsXhaGYfVjWdHsH7AepnTn9
         7VAgRXPiQ92AULaJqyaiNUsWP0AeRNTgJu4woyVdHaLKf/ZyiX10pSSaZ3rwMc2VbOS9
         DeDrMApDtUnATOT28baisclaJIEgVT4I8ZIHu+pl/Smy8gn/1g9NZJ0DlLp4OA5Wuu/T
         m+nkOEThy8zWAXxiWQ7I7qD3Y2Yna1qjnzU+2DsuhbxTsswvTG2OLoR3+8xK3h1rOSF7
         nz7g==
X-Gm-Message-State: AOAM532+sg0aL5VoGrUWG3HzvKJc0DWc8Dr4smqN6c/vbOBArbDMHWTB
        KYveei69XXxeM1WAL4Y4MXKZP2LFbRY=
X-Google-Smtp-Source: ABdhPJzHNZdaucsymaMOMfu6moTyAwrGwuYAOtRmEEpQVPwQ0wDXxvlgTzu2ZlZaztGet24eJ6aBPA==
X-Received: by 2002:a05:6402:22a6:: with SMTP id cx6mr11248191edb.55.1617886209099;
        Thu, 08 Apr 2021 05:50:09 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id cw11sm10790686ejc.67.2021.04.08.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 05:50:06 -0700 (PDT)
Date:   Thu, 8 Apr 2021 14:50:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/8] pwm: core: Support new PWM_STAGGERING_ALLOWED flag
Message-ID: <YG78IHIMGtl8Pokp@orome.fritz.box>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-5-clemens.gruber@pqgruber.com>
 <20210407054658.qdsjkstqwynxeuxj@pengutronix.de>
 <YG4UNoBCQJkEEfwi@workstation.tuxnet>
 <20210407213403.h6n6l2t7vqoalceu@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k14EUnVSaKYMlQNH"
Content-Disposition: inline
In-Reply-To: <20210407213403.h6n6l2t7vqoalceu@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--k14EUnVSaKYMlQNH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 11:34:03PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Apr 07, 2021 at 10:21:10PM +0200, Clemens Gruber wrote:
> > On Wed, Apr 07, 2021 at 07:46:58AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Apr 06, 2021 at 06:41:37PM +0200, Clemens Gruber wrote:
> > > > If the flag PWM_STAGGERING_ALLOWED is set on a channel, the PWM dri=
ver
> > > > may (if supported by the HW) delay the ON time of the channel relat=
ive
> > > > to the channel number.
> > > > This does not alter the duty cycle ratio and is only relevant for P=
WM
> > > > chips with less prescalers than channels, which would otherwise ass=
ert
> > > > multiple or even all enabled channels at the same time.
> > > >=20
> > > > If this feature is supported by the driver and the flag is set on
> > > > multiple channels, their ON times are spread out to improve EMI and
> > > > reduce current spikes.
> > >=20
> > > As said in reply to patch 4/8 already: I don't like this idea and
> > > think this should be made explicit using a new offset member in struct
> > > pwm_state instead. That's because I think that the wave form a PWM
> > > generates should be (completely) defined by the consumer and not by a
> > > mix between consumer and device tree. Also the consumer has no (sane)
> > > way to determine if staggering is in use or not.
> >=20
> > I don't think offsets are ideal for this feature: It makes it more
> > cumbersome for the user, because he has to allocate the offsets
> > himself instead of a simple on/off switch.
> > The envisioned usecase is: "I want better EMI behavior and don't care
> > about the individual channels no longer being asserted at the exact same
> > time".
>=20
> The formal thing is: "I want better EMI behavior and don't care if
> periods start with the active phase, it might be anywhere, even over a
> period boundary." Being asserted at the exact same time is just a detail
> for the pca9685.
> =20
> > > One side effect (at least for the pca9685) is that when programming a
> > > new duty cycle it takes a bit longer than without staggering until the
> > > new setting is active.=20
> >=20
> > Yes, but it can be turned off if this is a problem, now even per-PWM.
>=20
> Yes and that is a good thing. (BTW: I'd call it per-PWM-consumer, but
> details.)
>=20
> > > Another objection I have is that we already have some technical debt
> > > because there are already two different types of drivers (.apply vs
> > > .config+.set_polarity+.enable+.disable) and I would like to unify this
> > > first before introducing new stuff.
> >=20
> > But there is already PWM_POLARITY_INVERTED, which can be set in the DT.
> > I am only adding another flag.
>=20
> I understand your reasoning, and similar to "This diplay backlight needs
> an inverted PWM (as a low duty-cycle results in a high brightness" this
> semantic "This consumer doesn't care if the active cycle is anywhere in
> the period". Hmm, maybe I just have to think about it a bit more to
> become friends with that thought.

Yes, I think that's basically what this is saying. I think we're perhaps
getting hung up on the terminology here. PWM_STAGGERING_ALLOWED gives
the impression that we're dealing with some provider-specific feature,
whereas what we really want to express is that the PWM doesn't care
exactly when the active cycle starts and based on that a provider that
can support it may optimize the EMI behavior.

Maybe we can find a better name for this? Ultimately what this means is
that the consumer is primarily interested in the power output of the PWM
rather than the exact shape of the signal. So perhaps something like
PWM_USAGE_POWER would be more appropriate.

Come to think of it, a flag like that might even be useful to implement
the common case of emulating inverted polarity with reversing the duty
cycle. That is, if PWM_USAGE_POWER | PWM_POLARITY_INVERSED was specified
and the PWM provider did not support polarity inversion, the inversion
could still be implemented using emulation. Currently we push that logic
down into consumers, but this could be a way to bring that up into
drivers, or perhaps even the core.

Thierry

--k14EUnVSaKYMlQNH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBu/B4ACgkQ3SOs138+
s6FmJg/yA4TrAaHPwIuun6r/Yxik3SKjheuXOxWliSMflet1bg1Up+rqjfPSVKcE
m+utA8sx77PeemMmDMO2iKvJl61XTLCsU1RmP0KgxkEvirducSU/uIQa44I0L9Om
B99frn5bAKdHR5Rnz9gwWyFxfSrgxgW6RY6W+tZ1I+n045eEvo9cQkAngsZ1Er9L
bL4m/w7Gd0Dh/AAJ3zaMZEV7j+3ad9HaYQr2taUEjZ+bS8H2q7R9VPjDN10IsEDd
RjpKWeNj6u6A3KiOO0Dcsq/d61EIdqaxhPd32ryYAdH0sR7mZzkwvl6Z6oL13bAO
5Z1nYqRqNzJ/Brjn1Dw79rVufydnmwjD2FmxpVGXGrcOKW5S2BPlxG8x8M7/lxH8
QVzPIfRT23bv9HbERWtEKmQroF6DgafMBmDzEAvVqYS1r9983MXbkn+xCaaifxRk
clmGqi60CL0QbkoykiFmTgm6Rwv/soycj0xSw7NWMS6QKB6gtbxxadFtAQCz1Kc/
oW8nSx9PqvBigPE+K9sBOxACLZrnRE6bwL22W3W/t4RAgN4efo9SUu1elOeua4gG
7UgwiW0Ju9hLvNyrPZcUzMIKqUdMXwb4o1Q2gA2a8KJWW08sK/7gL/0sOc3o4X/C
sqK5KcFu7g12lkJlbs+NwhI8z9gX2zxDJ/ycZCLIk/CyQDG9lw==
=Wknz
-----END PGP SIGNATURE-----

--k14EUnVSaKYMlQNH--
