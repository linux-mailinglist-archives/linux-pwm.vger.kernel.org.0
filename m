Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3FA350465
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Mar 2021 18:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhCaQVb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 31 Mar 2021 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbhCaQVJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 31 Mar 2021 12:21:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0BAC061574;
        Wed, 31 Mar 2021 09:21:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l18so23021614edc.9;
        Wed, 31 Mar 2021 09:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JH3F4hZGJ88a9tZb14Ppj7z+xRolCJfuyuYJEO3h+zI=;
        b=ONCkZOU7seBR0NbuPIWE20qBDI3PgC5YuUUuNoSb3yhNGnmS7wjBU4VUTLEj3+mMvx
         ZN51zqDSc/ouqdpdbHVX8yT+HKgDQLzx89NYJ+CqOYgZcR0P2+tCeE8kK7qJ5/LKmkv7
         Ky4A80FbsA1l8segUJYcBgvthXhdrBTS5/P8wK7OGf8oxfeduPvfr3zXgkV5yDksyslE
         nimVVgAnjKPQgT6+7B1ZIJ9R/GJuaPwLEQiUThp5zYRIVYuSa1AHCQkJ8TJIgLO2Z0x+
         7uhTkEQQFjThXazti3v40LLK5uRGPRGQItKvSPmSrgLGjEPOTfyP/kILKBhKsRarkFgb
         TkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JH3F4hZGJ88a9tZb14Ppj7z+xRolCJfuyuYJEO3h+zI=;
        b=kf6kdQ31T+BhxiqZ8UvmP1onAYb1JIMCYaHX+winS60CAQkYENtsHRp9VFTNHt+XZT
         eMnP/V+Dv4oVvKKg1KJg6dGF3oIy6I6HZ7tZ3uoj0yvJRvKTCnAGOXJVv9n+D9gH29DQ
         xjjwu8CWD7XqNP+jnz3xZigflwMpK0Idd08pLinPCQXzqgJ/qSjQquXUr0aS788p7GXI
         L20eSgDK7Alolw9tZO0GTqPM+Uf7Eb0WYu6OIzRFoCCJunlLevSjl1pLCY0ci1xFhjsV
         FFHCRcjBv9T6+rxi/irbUdiM7P5tDxcbuh5sD/gTMtxsnC+fnWh9fDVoxz6AnNhE+5oP
         H6zQ==
X-Gm-Message-State: AOAM5312gs64CI9feDZOv77isCyySS+lXnkjmskxKkW/vRGa7cH7SGsl
        fmsER7uIqXK89kZK4qMrbm8=
X-Google-Smtp-Source: ABdhPJwG0kMrk04pxeDLd1QqF41b/SEI3JdAWfESlybmsvQP+bTjK3pt+4Lt215+LRu/ba9TsEsVlg==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr4687120edj.178.1617207667785;
        Wed, 31 Mar 2021 09:21:07 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id fi11sm1446593ejb.73.2021.03.31.09.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 09:21:06 -0700 (PDT)
Date:   Wed, 31 Mar 2021 18:21:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <YGShjDE8R31LwAbi@orome.fritz.box>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
 <20210329170357.par7c3izvtmtovlj@pengutronix.de>
 <YGILdjZBCc2vVlRd@workstation.tuxnet>
 <20210329180206.rejl32uajslpvbgi@pengutronix.de>
 <YGRqZsi4WApZcwIT@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dSpbF0PGwPp74yjx"
Content-Disposition: inline
In-Reply-To: <YGRqZsi4WApZcwIT@workstation.tuxnet>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dSpbF0PGwPp74yjx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 31, 2021 at 02:26:14PM +0200, Clemens Gruber wrote:
> On Mon, Mar 29, 2021 at 08:02:06PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Mon, Mar 29, 2021 at 07:16:38PM +0200, Clemens Gruber wrote:
> > > On Mon, Mar 29, 2021 at 07:03:57PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Mon, Mar 29, 2021 at 02:57:04PM +0200, Clemens Gruber wrote:
> > > > > The PCA9685 supports staggered LED output ON times to minimize cu=
rrent
> > > > > surges and reduce EMI.
> > > > > When this new option is enabled, the ON times of each channel are
> > > > > delayed by channel number x counter range / 16, which avoids asse=
rting
> > > > > all enabled outputs at the same counter value while still maintai=
ning
> > > > > the configured duty cycle of each output.
> > > > >=20
> > > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > >=20
> > > > Is there a reason to not want this staggered output? If it never hu=
rts I
> > > > suggest to always stagger and drop the dt property.
> > >=20
> > > There might be applications where you want multiple outputs to assert=
 at
> > > the same time / to be synchronized.
> > > With staggered outputs mode always enabled, this would no longer be
> > > possible as they are spread out according to their channel number.
> > >=20
> > > Not sure how often that usecase is required, but just enforcing the
> > > staggered mode by default sounds risky to me.
> >=20
> > There is no such guarantee in the PWM framework, so I don't think we
> > need to fear breaking setups. Thierry?
>=20
> Still, someone might rely on it? But let's wait for Thierry's opinion.

There's currently no way to synchronize two PWM channels in the PWM
framework. And given that each PWM channel is handled separately the
programming for two channels will never happen atomically or even
concurrently, so I don't see how you could run two PWMs completely
synchronized to one another.

That said, it might be possible to implement something like this by
coupling two or more PWMs. However, I think we will only ever be able to
do this on a per-chip basis, because that's the only way we could
guarantee that multiple PWMs can be programmed at the same time, or that
they get enabled with the same write. Of course this all requires that
the chip even supports that. Even if you enable two PWM channels within
the same driver but with two consecutive register writes they will not
be guaranteed to run synchronously. There'd have to be some special chip
support to allow this to work.

However, I'm a bit hesitant about this staggering output mode. From what
I understand what's going to happen for these is basically that overall
each PWM will be running at the requested duty cycle, but the on/off
times will be evenly spread out over the whole period. In other words,
the output *power* of the PWM signal will be the same as if the signal
was a single on/off cycle. That's not technically a PWM signal as the
PWM framework defines it. See the kerneldoc for enum pwm_polarity for
what signals are expected to look like.

So I agree that this is not something that should be enabled by default
because if you've got a consumer that expects exactly one rising edge
and one falling edge per period, they will get confused if you toggle
multiple times during one period.

If that's the case,you probably want to configure this on a per-PWM
basis rather than for the entire chip because otherwise you could end up
in a scenario where one PWM does *not* work with staggered output and
the others do. I guess you could always make that decision up front, but
do you always know what people may end up using these PWMs for? What if
you have a board that breaks out one PWM on some general purpose pin
header and people end up using it via sysfs. They would need have to
recompile the DTB for the device if they wanted to enable or disable
this staggered mode.

Or did I misunderstand and it's only the start time of the rising edge
that's shifted, but the signal will remain high for a full duty cycle
after that and then go down and remain low for period - duty - offset?

That's slightly better than the above in that it likely won't trip up
any consumers. But it might still be worth to make this configurable per
PWM (perhaps by specifying a third specifier cell, in addition to the
period and flags, that defines the offset/phase of the signal).

In both cases, doing this on a per-PWM basis will allow the consumer to
specify that they're okay with staggered mode and you won't actually
force it onto anyone. This effectively makes this opt-in and there will
be no change for existing consumers.

> > One reason we might not want staggering is if we have a consumer who
> > cares about config transitions. (This however is moot it the hardware
> > doesn't provide sane transitions even without staggering.)
> >=20
> > Did I already ask about races in this driver? I assume there is a
> > free running counter and the ON and OFF registers just define where in
> > the period the transitions happen, right? Given that changing ON and OFF
> > needs two register writes probably all kind of strange things can
> > happen, right? (Example thought: for simplicity's sake I assume ON is
> > always 0. Then if you want to change from OFF =3D 0xaaa to OFF =3D 0xcc=
c we
> > might see a period with 0xacc. Depending on how the hardware works we
> > might even see 4 edges in a single period then.)
>=20
> Yes, there is a free running counter from 0 to 4095.
> And it is probably true, that there can be short intermediate states
> with our two register writes.
>=20
> There is a separate mode "Update on ACK" (MODE2 register, bit 3 "OCH"),
> which is 0 by default (Outputs change on STOP command) but could be set
> to 1 (Outputs change on ACK):
> "Update on ACK requires all 4 PWM channel registers to be loaded before
> outputs will change on the last ACK."

This sounds like it would allow atomic updates of the PWM settings.
That's probably something that you want to implement to avoid any
glitches.

> The chip datasheet also states:
> "Because the loading of the LEDn_ON and LEDn_OFF registers is via the
> I2C-bus, and asynchronous to the internal oscillator, we want to ensure
> that we do not see any visual artifacts of changing the ON and OFF
> values. This is achieved by updating the changes at the end of the LOW
> cycle."
>=20
> We could look into this in a future patch series, however I would like
> to keep the register updating as-is for this series (otherwise I would
> have to do all the tests with the oscilloscope again and the transitions
> were like this since the driver was first implemented).

Yeah, it sounds fine to implement this at a later point in time. No need
to conflate it with the current series.

Thierry

--dSpbF0PGwPp74yjx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBkoYoACgkQ3SOs138+
s6Gqig//QcX0EV2UzYt3lmnze4KY32Aw1XZE3fbF7SrhsEMZdp2RyKHCKC4RNmz8
9CMPycDsi1SdjlwHBxhdK/ThPC7O/u8t4QEMPv9ArDMnCn9AdfcYEnY6d5eTdciG
TgAZ1q3Kyxy2YEesKiqy2hqdtR0OSyj8ICEyDSeoPiFEXc+GY87lKeCP7zbbuS/O
bBCr5AEOJhWCBkyy01xCy3h3Zw0kTdotQYsaH5lbR1zPoL/8HS0ULQCuzw3IYqvi
tQ0PGvKejBN1irqGcR6Eh5Zqr1uN57X42O8m7bAhPUb5dCoKIf9tUtiFJn0F4tHk
TEcJf1Co17KwsO+l0fCe9+Dg4QgXXXLzRSeu5LnEsJqITRNnOlEalT6aTP7lBMA7
LtZwyC6Nf9NdK5zf6VtQj5i58Rr3urVmRUwRRNuRsu+1kTn052Yf42ukdJeLHkyK
TX+LU6Uww430tL40nvP+xTM6GL4p8o+vHufomdqOgNGxVJwQnlrSMaSo4lHsOqU6
tlTJvsPwzKIQg/U1Fi04USn00zZhwmRm/DThvRhjZPto8deMfwWZQ2i/3zJVFzdS
QN8QNIeLsOkPoD2v/nEiA58DLbX2ENJu2VorKmhhy5BABW1PdbSh2VStg1iijoQK
nozM4wdwmdtPZQEjtf7urVMdTCaWKECo2KDGgbSG84Hdwn9bWec=
=mpMv
-----END PGP SIGNATURE-----

--dSpbF0PGwPp74yjx--
