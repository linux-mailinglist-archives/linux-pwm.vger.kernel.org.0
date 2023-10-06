Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4D7BB4F7
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 12:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjJFKQD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 06:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjJFKQC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 06:16:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BE79F
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 03:15:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so17090785e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 03:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696587358; x=1697192158; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vvv05fLy6U70cre8Xe1Nve9HNegoO2ndAUQ5QmhBqkM=;
        b=FYG3Vv7F1qMV4Hp3KoX74Y7y6GGVnTs/kTH3amoOdCKDTSg/HomR6QLXiC6X+GU3bj
         N1MAX0HaQQ+ZEvI8EEx1seLC3Aa3uM3l3xtk7aVeeoeD39547niRauJs7CwEM/5Aar3P
         tjrn/4rSP83Dvwc1gzVJM1sbJMxErgPj87VpEeIZiGfRTY4j4bK5E9Ev4UQkdpLnY6Rv
         ZlF7cWk/S+irp73JNLjpfEZZPVSOUzmJ9ouua3dgfuF1HM/1hZaWHnPPdNvhPvSIotZ3
         fjH3E9DSSYvwyy3eMvH/HW0tnhytLb3Mab16NhBGhLhv/E5ATuTlYH0ZeOBMIFSqbEwY
         FxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696587358; x=1697192158;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vvv05fLy6U70cre8Xe1Nve9HNegoO2ndAUQ5QmhBqkM=;
        b=Y92PlJ1wQj0gKMIm97e8I9qfLoJH58Yy9o+dFhvp46tFwMnw3KFWBF+rwMJOky/xd7
         Uzy7XXTwKnt7oPkbtWXkAYIieIxx7ECTDSxsWwNfr2A37OUalr8+asqD4oZnPp6HxvNv
         KzCaiD0cRLDA+rxHlkGfkjA6nb32eXyN6X0nhUUCbwDJhh6cThxhs620pgA7+ArZF6sA
         j8Hrm6Zn+fKxC8CeelHqhOzMDT8p5Ewx5QYdoLeZRODxIHQSDC0map+FcJiEfg7ybLIQ
         HQkIPnPd4qnP7rjxGG8WFb6dUNL7bpXiLTTnMc2Zo/vPy2KI2NitB4WYSgTLxwaYb0Cb
         rzVQ==
X-Gm-Message-State: AOJu0YyDp1eFrhlBub7Kq6BRsf3kU100d8KL6SA3BT8zsLO1UfJEwbzU
        ePZxYzp2gkSZPvHZ7hUyBYY=
X-Google-Smtp-Source: AGHT+IG+l5kpIrMwh0x1g/EF6z4ob8/xRj2304K9DZwXQIKGsVRruxJ8IS9Gk+9r+MmE8JoeTJQx/w==
X-Received: by 2002:a1c:7419:0:b0:406:7d74:a2a6 with SMTP id p25-20020a1c7419000000b004067d74a2a6mr7259592wmc.24.1696587357735;
        Fri, 06 Oct 2023 03:15:57 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003feae747ff2sm5670041wmi.35.2023.10.06.03.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:15:57 -0700 (PDT)
Date:   Fri, 6 Oct 2023 12:15:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de,
        Sean Young <sean@mess.org>
Subject: Re: [PATCH v1 000/101] pwm: Fix lifetime issues for pwm_chips
Message-ID: <ZR_eW-YsYrLUxPfF@orome.fritz.box>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230926100625.vudo7qp3h5r2dz62@pengutronix.de>
 <20231001111024.a3ce3het2y3n7kvx@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YbsN5gyW+n/ixS4C"
Content-Disposition: inline
In-Reply-To: <20231001111024.a3ce3het2y3n7kvx@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--YbsN5gyW+n/ixS4C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 01:10:24PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello again,
>=20
> On Tue, Sep 26, 2023 at 12:06:25PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Aug 08, 2023 at 07:17:50PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > this series addresses the issues I reported already earlier to this
> > > list[1]. It is based on pwm/for-next and several patches I already se=
nt
> > > out, too. Maybe some of these have to be reworked (e.g. Thierry alrea=
dy
> > > signalled not to like the patches dropping runtime error messages) but
> > > in the expectation that I will have to create a v2 for this series, t=
oo
> > > and it actually fixes a race condition, I sent the patches out for
> > > review anyhow. For the same reason I didn't Cc: all the individual
> > > maintainers.
> > >=20
> > > If you want to actually test I suggest you fetch my complete history
> > > from
> > >=20
> > > 	https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking
> > >=20
> > > .=20
> > >=20
> > > In the end drivers have to allocate their pwm_chip using
> > > pwmchip_alloc(). This is important for the memory backing the pwm_chip
> > > being able to have a longer life than the driver.
> > >=20
> > > The motivation for this series is to prepare the pwm framework to add=
 a
> > > character device for each pwm_chip for easier and faster access to PW=
Ms
> > > from userspace compared to the sysfs API. For such an extension proper
> > > lifetime tracking is important, too, as such a device can still be op=
en
> > > if a PWM disappears.
> >=20
> > I wonder how this topic will continue. This series fixes a lifetime
> > issue that can result in a userspace triggered oops and it builds the
> > base for my efforts to create a /dev/pwmchipX for faster control of PWMs
> > from userspace (compared to sysfs). (Currently in the prototype stage.)
> >=20
> > I'd like to get this in during the next merge window, please tell me
> > what needs to be done to make this happen.
>=20
> One problem I noticed yesterday is that this series depends on patch
> "drm/ssd130x: Print the PWM's label instead of its number" that
> currently waits in drm-misc-next for getting in the main line. The
> series could for sure be reworked to not rely on this patch, but I'd
> prefer to wait until after the next merge window instead of reworking
> it.
>=20
> Still, getting some feedback here in the mean time would be nice. The
> questions I wonder about myself are:
>=20
>  - In patch #1, devm_pwmchip_alloc() could get another parameter for the
>    .ops member. This would save a line per driver like
>=20
>    	chip->ops =3D &pwm_clk_ops;
>=20
>    in return for an additional parameter that yields longer lines in the
>    drivers.
>=20
>  - In patch #101 instead of using &pwm_lock a per-pwmchip lock could be
>    used for pwm_apply_state(). This would allow to parallelize pwm calls
>    for different chips; I don't know how much this matters. Maybe the
>    sensible option here is to keep it simple for now (i.e. how I
>    implemented it now) until someone complains? (But see also the next
>    item.)
>=20
>  - A further complication is the requirement of pwm-ir-tx for faster
>    pwm_apply_state() calls, see
>=20
> 	https://lore.kernel.org/linux-pwm/ZRb5OWvx3GxYWf9g@gofer.mess.org
>    	https://lore.kernel.org/linux-pwm/1bd5241d584ceb4d6b731c4dc3203fb9686=
ee1d1.1696156485.git.sean@mess.org
>=20
>    . This complicates the locking scheme, I didn't try to address that
>    yet.

Frankly, I think per-chip locking is the only way to support slow
busses. If we use the subsystem-wide lock, effectively all chips become
slow and unusable for things like pwm-ir-tx.

Perhaps we can draw some inspiration from how the IRQ infrastructure
deals with this? IRQ chips have irq_bus_lock() and irq_bus_sync_unlock()
callbacks to deal with this. We could have something similar for PWM
chips. Perhaps that's even something that could be handled in the core
by checking a "might_sleep" flag for the chip.

Thierry

--YbsN5gyW+n/ixS4C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf3lsACgkQ3SOs138+
s6E4ShAAu3iXektBCTWPpAQa5sFrZWpZARqGpFOpKx5wWJxvB2wZ7R/UaydF1mpv
jSL94f0wtPoG8H8I+xXmalW1s3jVQ1l++t4pP4y3308F9Hx0ptB1As61KrqPiKIA
YIA2o88C3Rm8tzGpvjU88QDQjiqMj1tcujL1ScN/YPEC4zAUVBJAcEdlGdADhJRs
wvSwVH9dhEqfX1BXaxAM9IVqBSEa8w5KNIs1ZyjBffzFjzZEsr3tcRH4yvmTr3+z
xI6CVmnsT2DxyFGfqjkPiZDb7gkNx9B7ASJxH63oqYBKyCOfoOrRTZWh/dtNXvPy
6gVDk9sKkHVS0b1rcssMjp6Z7rH5/OF30Dg8ja1HfaJYQVjcvobnzGnDoXlSOeWg
oc4pq5ZjFRw7nKfYYpklap/i+iWLr2dKYWNFG3C2+jewzn97bqZbr89ZLIBkhPIZ
kPFDPc2mLc1H/p7VEzNMqN8keG3jjGcmp0NQBqldv9TiSijej1kBO+taS5xgdxhg
FRpXkTf/czAtKrkAnnWupOWBPvQP/pj9gthm5rpC2hLtSLszGSdjmzHkyOohmRBG
9rAWVhl5oNGbl2aJGd5bdb79a3s1ntJOh2w1ocH3aaLRAWBLpZ387LsJrgzAuFPu
vBSGl+yDaDWGYRHsBjq+z7vg4B3tXdBv51Fq42hz/fBLnak5tNI=
=6fGz
-----END PGP SIGNATURE-----

--YbsN5gyW+n/ixS4C--
