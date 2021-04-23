Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3D369754
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 18:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhDWQqo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 12:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWQqn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 12:46:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993C7C061574;
        Fri, 23 Apr 2021 09:46:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n2so74785193ejy.7;
        Fri, 23 Apr 2021 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AHxWAHKzzgsPEUP1uAuRKRHQkYrg/cUynVsUhlyd7mo=;
        b=rYRjQ5F+ty+oKYZiIPFM5p9jzk+YE2WFTAxXJ8LeWxmyUVBMRRZObdZvpfSqlRmZaM
         I+Qo5FFcZ3PNLCfAkPH6HAjRY2xKvuU2N8MNZ2j+l6vicf08vxXkK37kaqsUGKQdHHnN
         WpUT7wFnBHPMgJemzeP1w5y/gIpDdv/qe11BBTKH6iicU8g1L4px6j/H0wrTim+YCdkl
         PD2+3bNY8qKP3XUmxWUm/PAyl3hW+DVewZutOiM297aafP5KbabqTpy+8vD1QH2d2tFw
         7L+mjrmGifZKfP+6MAMi6WC64DmbkAPv71JhWQubC3czDXRKTbzRctvFQFRnAyfKn/Jd
         wQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AHxWAHKzzgsPEUP1uAuRKRHQkYrg/cUynVsUhlyd7mo=;
        b=T8kcjoRwSeztQXO1EobvxRHPR2TchFBlTnbKNpgW1HJpt/6dMBNfe3xkuPQR6dTKLT
         VIUOKDZEcAwlpoED76MmHBLnXsd0bnbtAeYehR28emrG951C2vaG6k170Ak5gz1rQqpN
         0N60+jxMsQY75ltcxXbAzZ3YAsryL7+FpFGCRi1vzshaM58uOFion514B6xzrlvsaZra
         650nlinp9WKKvhJJ+XwSqZuYNRsboG3/bLk07QDkfkXU6BMdiYS8u4W2wIP4ILNl8bde
         6ZF7Q3dz2WcdQTtj4I+kbkAgWQxJyaAc3Ift9yQEBcdWZJebOx56BChznwehkCojv0Ob
         TTlQ==
X-Gm-Message-State: AOAM530fQwRQdzjBctcTAeT6Alv51lInTFmQvauNa8DZvmZQPnY/oQaG
        Jzn3yTwvI1BxDiYyhbF2l6A=
X-Google-Smtp-Source: ABdhPJxq4mSEkj1z4E9JIJao50cbzCfwxiM8izC46qiCMjo6xjReLNrKV6yb7xsQzj3DjeF1Aa5foQ==
X-Received: by 2002:a17:906:3c45:: with SMTP id i5mr5137885ejg.368.1619196363336;
        Fri, 23 Apr 2021 09:46:03 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f7sm4504353ejz.95.2021.04.23.09.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 09:46:01 -0700 (PDT)
Date:   Fri, 23 Apr 2021 18:46:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <YIL5+xq+LP5/YGvO@orome.fritz.box>
References: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
 <20210417195150.5fdcpxfbasp4y264@pengutronix.de>
 <YIFgVZL4PBcIKvMp@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ag9QP45o/HG8VKU1"
Content-Disposition: inline
In-Reply-To: <YIFgVZL4PBcIKvMp@workstation.tuxnet>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ag9QP45o/HG8VKU1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2021 at 01:39:01PM +0200, Clemens Gruber wrote:
> On Sat, Apr 17, 2021 at 09:51:50PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Thu, Apr 15, 2021 at 02:14:48PM +0200, Clemens Gruber wrote:
> > > The switch to the atomic API goes hand in hand with a few fixes to
> > > previously experienced issues:
> > > - The duty cycle is no longer lost after disable/enable (previously t=
he
> > >   OFF registers were cleared in disable and the user was required to
> > >   call config to restore the duty cycle settings)
> > > - If one sets a period resulting in the same prescale register value,
> > >   the sleep and write to the register is now skipped
> > > - Previously, only the full ON bit was toggled in GPIO mode (and full
> > >   OFF cleared if set to high), which could result in both full OFF and
> > >   full ON not being set and on=3D0, off=3D0, which is not allowed acc=
ording
> > >   to the datasheet
> > > - The OFF registers were reset to 0 in probe, which could lead to the
> > >   forbidden on=3D0, off=3D0. Fixed by resetting to POR default (full =
OFF)
> > >=20
> > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> >=20
> > (I sent my ack to v8 before, but indeed this was the version I intended
> > to ack)
> >=20
> > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Thierry: Do you think we can get patches 1 to 3 into 5.13-rc1?

Applied patches 1-3, thanks.

Thierry

--ag9QP45o/HG8VKU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCC+fkACgkQ3SOs138+
s6Fieg//SNVP0ULVNLQOC9hJfKuwl/mEmbgGi2iVUyBEFtfwWeNrUptE9CZJQsz9
G0ryShgxyEMi17pRNLH62D1p4DDtg0i2diEMrl3Cd+EQfPABMr6l2z67BwNxHfZZ
MclaFxV/r4pzpOckuWyfPF/bwJXSIZlXvwRUsT3p3D6GFGCeu/PdMzm7/AUznrqJ
4OqJ9PT2rnAABGpN8/NHLDeGi41j8AR7JbzruVh08TRU8bWu/o1TdxnL/WAlZB/k
KsSdcCdWk0lNvflUJFiFYx5vpZoqrC85vhS/4ngYzaXiEN702/HY7zhxHd/QNLqZ
XVsrUTLiIQRT/ypRaQuoUHrcjC/V9J3itiDMAyliev8lUB6CA83KOFMIkwdAh/lM
JvEKMBon6/AFSvxfmQsFho9ktnKb5ecAw2QXBBI4hOYQiSwVkxS0uOsVSNRGO04s
FuIBmcxdYpcfajjBzRtSB5TY7oJtMKcgJAPlUYLjEvS4xfr+zTlBVstJr6g5WVs7
XRmfuyBl9gw6iLd3xnffij+9fru7qqQISB76K6V1df5uOFD90UsYCYJTgcjfBjmo
hFyPvC5JTWAYrKwN/QkUNuRBKImCVjRlA541K4Xy4ry+A8rGx1V+3lFqZtJHPshT
FONfZ6X/Qh98UiAMb9h7aw0+6HxCVVHPtdQ0xfiwDllcchMvggM=
=1JEV
-----END PGP SIGNATURE-----

--ag9QP45o/HG8VKU1--
