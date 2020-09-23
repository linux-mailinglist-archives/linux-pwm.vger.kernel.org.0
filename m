Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CB627597E
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIWOLL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 10:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWOLL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 10:11:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0D8C0613CE;
        Wed, 23 Sep 2020 07:11:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e2so217065wme.1;
        Wed, 23 Sep 2020 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CB7M2CncGBhcmVkSvCt5EFITtUb6+/BFsKZEQtsBJMg=;
        b=cOtF3sobqgtq7LM7CStBaTQlOZ+D7RbYLoKwOBl8kX/XW5oh6/Gr7IWPZLgNKjWP8+
         HmSMpriooSQY0kKOSK5hRak4neuBed+GeSX64ceMR1HrJBpqyv3YZirL2Bi+LdtEYeRt
         9qA2+0OcI6gXxFUrAvH648lpPZRWtqW2mXwWyDweWcn/0kAzwks0e+StEz+13WiZPDCu
         KiRvipYX0Lnf+3gZmQ7yvQdzPew/uFd/saCe97Ja1QcXWn6fmp1WiLtxuBHysDvuBx0l
         KxS17MwRhpJ01fndCrEN7oDOHmitJ1a5SsWEzjRQBS1736ik5Tbbeh2Benmy1D21QMAL
         zJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CB7M2CncGBhcmVkSvCt5EFITtUb6+/BFsKZEQtsBJMg=;
        b=LAlNToFqXFw8zcqSe9KTldr3w5SqnPFahuI5gqvtCSoTcJ9xmr0fTTVD1mhnU4hF9e
         woQFui9p0FjiYoZ8Z7TYSpgVNQWA2C5DizDzer9g7dTYoOEVxLSrMBqkc6nOpPsDq1j1
         cIGxLjZoMgkbAY1gRu6qWa7UATRAl8hjMaRoKe9c69QYOTtyPZJjBx/Qll0O3cqjYslV
         +9GXCyNoesIioexcr6gm/oDuuHt6hObIgPQu2yy+DnXDPR686rzfYJoeVhfSIepiRTDs
         MMTyWdNGFVbMa41aK2ZW0+9bhIYba3/wz2zKa1UcSfAQ7jl21KQyxgEvIgJKsy+qtnEr
         91hg==
X-Gm-Message-State: AOAM533eX+NsJEGFaGp0pHfPLCQBM1ATdvqzQ6jYVGN4j3BxFsNvXYkR
        O3p0TWQx9fP7TTgETKbqceg=
X-Google-Smtp-Source: ABdhPJy/UJ89k9fr37DHSUXYWMBOQR/yTdxzStrXrsmFEeGP9aknqAboLtRYO2klcaoaBQjzchcinQ==
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr6927433wmg.72.1600870269609;
        Wed, 23 Sep 2020 07:11:09 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id e18sm30520166wrx.50.2020.09.23.07.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 07:11:07 -0700 (PDT)
Date:   Wed, 23 Sep 2020 16:11:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r8a774e1: Add PWM device nodes
Message-ID: <20200923141104.GE1848911@ulmo>
References: <20200825104455.18000-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200825104455.18000-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdWmvcA8x-t=FgNOuMnAtw6j3OAgo8irmD5e2wrB+LfhHg@mail.gmail.com>
 <20200923121452.GD1848911@ulmo>
 <CAMuHMdX=G0n4MWNUM46OcUzeKUc=i1Sv4J8tnU0=_Nkt=Pf6xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX=G0n4MWNUM46OcUzeKUc=i1Sv4J8tnU0=_Nkt=Pf6xA@mail.gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 03:29:25PM +0200, Geert Uytterhoeven wrote:
> Hi Thierry,
>=20
> On Wed, Sep 23, 2020 at 2:14 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> > On Tue, Aug 25, 2020 at 03:32:08PM +0200, Geert Uytterhoeven wrote:
> > > On Tue, Aug 25, 2020 at 12:45 PM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesa=
s.com>
> > > >
> > > > This patch adds PWM[0123456] device nodes to the RZ/G2H (a.k.a R8A7=
74E1)
> > > > device tree.
> > > >
> > > > Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@=
bp.renesas.com>
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > i.e. will queue in renesas-devel for v5.10.
> >
> > Hi Geert,
> >
> > did you also pick up patch 1/2 in this series?
>=20
> No, I typically don't take DT binding updates for non-core devices.
> Can you please pick it up?

Will do.

Thierry

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9rV3UACgkQ3SOs138+
s6GLaw//YmYjPUn58Pd8QXyL0Xw/EjWxRGOry7cXnuprz5l0VHOyaNTcHrkB0Ge8
75Z2iFIBBMDoHGMz8m5nuWpbMLfIaasOr97I4tIKz9urfcC/ECxQhfT4M30X4U/8
XZ/sGyBU3T2KjSyB4chNdNw7+gu7x3bQHPywo77c1ATptWMTTsfgsyjB9aB2eKLw
/Qdx1kbd9AH0jcv/RgRgj0O1wyCuIo8BEqSpGzpDkGffKCONeml9aHnyCZ4euhIb
SUEjrc5TmwQjL5g1/u2AkzB6OavJ/Rn2Htt15bCB2IRPZvCzSm8whkak10Uaq/Zk
eKbxQeRkvGp+dqLZ9gYX3szQIIuP4pjY8ABmhrD9Ml1zuDoz0lFfPPSUmxfZFPIe
exuJXPRpq+yLMKMAhftSqBFdmSNm++vPJMxFx/dJUO3E2fZQTElVbTYYOFkCn6Tx
mrPPT6kIhYL65zp514IOOrKnJg1Pb+mLeCA8X3qN115W1V9ysoq9NBkApszyUbm+
MULAtxOST/KQoWWoF3jaNdN4bPZZ1I4BIt9gQLPX76gP0sIE6PiIa2q2aFQlm4jU
0PaDk9bOGLw0LBnAQFPuAujpaUgxvMhgCEXwnMNkCMCpCNaiDEdDDYA18Low1Fne
GB82fzpgZvoVT0AI2GBX0pNG/vt6TDQv6IgfRsZwPXolvRzFSu4=
=z3R2
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
