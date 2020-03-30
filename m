Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0127F197FD0
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgC3Piq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 11:38:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55247 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgC3Piq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 11:38:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id c81so20424022wmd.4;
        Mon, 30 Mar 2020 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ThNT7IHhp+pCopvLLrahm7n3sIF14irK3wGMpiEHrXI=;
        b=LG142GVIFW5FWP913j1ZKD+IsVm/JtBkU4c+t36mYkKeOQQsOywadum+poXch3xfSR
         JG0wDunx7ymtS5/sUL8yaqiAQ38RATvMF8dSXikAOad67IpZ9S79EsyTuOUABAWilxu2
         5ossnleJs4FyGSP38pWEGS88Vsomsq56k8qPpYpjERXle4P0sZZe2TawNdd2W7bo6L7I
         5lIZhQc1PqodlxeHxiQyEPstjzjn5jaMBIc/VwX2a/56uzoc7seOrLgVoO3bNXWroHMN
         4riuDVgu+jD782kQQ4Ho9YqefxvVvCnUT9FYWAPYqxpRGq7x4H3xUpYbQEAfjw/rQysR
         Q95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ThNT7IHhp+pCopvLLrahm7n3sIF14irK3wGMpiEHrXI=;
        b=FoNlZnFuFxPXbDrXJEyud0JMur1YW5my9w6juvkkG0qXLMx/Ev++l99xAZIOrmrM9p
         jF6j9EHtin7LtXiT/euPebYIFRaAkAo8IVsIWCFePwzeerdl19ZY3FK0Ls1EKDN1AMnD
         +/K4Bi6teS174uVnlCRtcKlGKI4Y298NqQ4fBr0zNMMjiwJ9uhxpyP+NU61/9VYv5dMd
         cNwoWpwUE5ozI/e1fJN4kJP5tU5zwTFAiEIcsnNocLEg6tIwemb50Qqs+ab0FMnCc9j9
         laNF9AqqpE2Yhbbv/PcSdvoHk5LB11XKpc8ck87L1RLWVhjI6Q5jG4PApjweQ2AJNHPF
         hj2w==
X-Gm-Message-State: ANhLgQ3f90cG3S0BLMVANWfG8f4NZc6aNOPJvkY1fVYVUEEMf/68TDo/
        fXsS5O1DlHiq+ubBkcU2Dic=
X-Google-Smtp-Source: ADFU+vt5NwV/jX5Pu6ff53Ee7mR0nw7o48wuNFnB56PozW1Bcz4w24PY/HAVtve6tp5EA0V6PXK8Sw==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr5195649wmj.87.1585582693742;
        Mon, 30 Mar 2020 08:38:13 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id d6sm22322671wrw.10.2020.03.30.08.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:38:12 -0700 (PDT)
Date:   Mon, 30 Mar 2020 17:38:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Message-ID: <20200330153810.GA2817345@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
 <20200330130757.GC2431644@ulmo>
 <CAHp75VeY9ZGUD_=N=R2vsJFY-4P5-L1+ZzjKHU2cygcbML0zOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <CAHp75VeY9ZGUD_=N=R2vsJFY-4P5-L1+ZzjKHU2cygcbML0zOw@mail.gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 04:19:55PM +0300, Andy Shevchenko wrote:
> On Mon, Mar 30, 2020 at 4:10 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > > The interaction of the ALL_LED PWM channel with the other channels was
> > > not well-defined. As the ALL_LED feature does not seem very useful and
> > > it was making the code significantly more complex, simply remove it.
> > >
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > ---
> > >  drivers/pwm/pwm-pca9685.c | 115 ++++++------------------------------=
--
> > >  1 file changed, 17 insertions(+), 98 deletions(-)
> >
> > Applied, thanks.
>=20
> This seems to be ABI breakage.

Nothing seemed to be using that feature. As a matter of fact, I don't
really see anyone using this chip in an upstream kernel, so it's
difficult to understand what the dependencies are.

> Thierry, do you have hardware to test?

No, I don't. Do you?

Does anybody have a good understanding of where the users of this are
and where the code is? There seems to be a lot of confusion around this
driver/chip and how it's being used and it keeps causing a lot of this
back and forth, so can we please gather some basic information and then
I'll add that to the driver along with perhaps a list of contacts that
want to be involved.

As it is, it seems like applying patches as I see fit is the only way to
get people to object, which is a suboptimal way to do things. =3D)

Thierry

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6CEmAACgkQ3SOs138+
s6GhMA//QXptmnJALfUYiX+M0Q8w8ZlqrU3s3Zth8HvqhMnhoYTCsuwQ6Keqpb7s
ZlMGD21yL8fcL8spiI/cGA3SqrNKdVV9/Ejy4sUteXB5JPDi4n/fU1Ed1+bLMuJF
7yTY8FL58Z3C/Z0FIWfxjJ+wBGbsO9cSNYuswdKBhzSeVxGR3sDDEmFZSXQ2EKr5
MgFq/Icb4tR5JykUlojHenbYd6ocfZqfUKKpRG4VUd4hHR5oG5zH8VjNBgkhNYRl
62ojPYdJ3/WhW6YOcYObFJrH4eQ0fC99FovDc0JfqsSuF4kaM/EAqdqOXs01v5xM
K5ELLsS0oXlUz/N+u7JCfGgFKg7eiSnT6DJm8SKzoOq+H/Qzc/C31oAG3e1C9yHt
hjZw8rhTz4EuqhBtctFAQG5ZrLyNV4w8dMBhRclOFVCfLBWYrzc2U5Faqsp2HsNX
9TVPu9PBvBTi0teUOtmXTCWCB9SbwRemoEwQRSh1UbEUXQeTThUjCnz76j/wR6D3
4mz2A0RRvtGFiS4DtAF9v108AcfAiGkFyoKEFKNj4xchttpaII9blX47OPaH79C5
zk7/X5ULp3dUKMnavSSkSW6A7y4Oa641UZoc6LdFhIc1a+KFhwVUsgVG6VBbTwsP
RJ/0I7RWzfHHnpLmEgBW/NnfGUM+7FvbGI4FjEnmsVMrsK+7PMs=
=m4iH
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
