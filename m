Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095E21E0964
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2020 10:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbgEYIyL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 May 2020 04:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbgEYIyH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 04:54:07 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970CBC061A0E
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 01:54:05 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id se13so19681560ejb.9
        for <linux-pwm@vger.kernel.org>; Mon, 25 May 2020 01:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RfGnFqSjvmscV5nrD3s60lmqq66FoDSTtftkIHhfR+g=;
        b=P5Z1xGTUcPHL/6cmbUXi91K90aw28lh8/uzHAUoMOjOUcAB5yfmmwAQ1T2vvPArw1U
         qFJO0LUAyG48kcNiHacdK0VUjNvf16SIxqnjX01I9whvzzQwrZBdyzVVThvrsI7+a4jp
         uV24i5zHyqXKBqsWrAZ/hhyYcz7tIkgUujk+j0X7ObZY0ZMary+JXPVFcHIxLecWOanp
         tJnViRsr5bly5SuBJz2bBNcEowRAPRIWx2Du7QKGxmLWt7KFjvEOp5R1z4FLvRmMJHZQ
         ibWNyCY87tY9jlwW9MN0rArfhf/sSEeDK/vwSXBAZYaxMiG4ppb6hXYLSrVZfJVqf8qC
         mhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RfGnFqSjvmscV5nrD3s60lmqq66FoDSTtftkIHhfR+g=;
        b=bCGPETWATKic0zNtdt3Z7eC3dH8zPMb53+qSAdYNefWHpPU+6b9o53PvxXEBm29nRd
         KK4m2wlkOZqr3tmHzjXY8R28vMgdV+kt5VursMAcF31GEg/ExsTEqkfkw0mGnkelX2Ac
         2McQk6H8JgI7a4xMkjZ+JNSEIUkaa4d/Sfb8z543xbgSE/uJv6/IHg1xJjNua/DAgFUM
         nmwwMc7Lzyyz2GKJQ6U+lluHZQA3ldzsmbJ64wmg/JnfwX/SMXFQ46wQoOKa6XggxgZO
         H8VEjbGwZSKTtmOpIxRmsz8DM/8voVl8R0ROlW8IpTZJh8URDEYG5LG4nqdUZQGMYwzU
         ytOg==
X-Gm-Message-State: AOAM530UzOMNnkzFje4scYsorPntBzZH4CFOW+w5vOh2vpc1v4POKxaP
        vSrDSTf3lpYo5qB0fi4kNdR741KU
X-Google-Smtp-Source: ABdhPJwvjS6kZ6v6MSAAiEbyve8hgdNQSg5GFBq7NlAoiLfI83N0T8+4XEh1Q7Klb0b0e9nmvqkWRg==
X-Received: by 2002:a17:906:144e:: with SMTP id q14mr18320309ejc.450.1590396844311;
        Mon, 25 May 2020 01:54:04 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id a13sm14798340eds.6.2020.05.25.01.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 01:54:03 -0700 (PDT)
Date:   Mon, 25 May 2020 10:54:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     helpdesk@kernel.org, linux-pwm@vger.kernel.org
Subject: Re: adding linux-pwm archives to lore.kernel.org?
Message-ID: <20200525085402.GD2382769@ulmo>
References: <20200213102618.x5j6kfvqmdbx2pr2@pengutronix.de>
 <20200523170558.h2brqlf2jx4kee6y@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <20200523170558.h2brqlf2jx4kee6y@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2020 at 07:05:58PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Konstantin,
>=20
> On Thu, Feb 13, 2020 at 11:26:18AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > I consider the archives on lore.kernel.org very useful and would like to
> > see the linux-pwm list archived there, too.
> >=20
> > Assuming you agree (or at least don't disagree) we'd need to follow
> > https://korg.wiki.kernel.org/userdoc/lore. Therefor we need an archive
> > of the already sent mails. My personal archive only goes back to Oct
> > 2018, so I guess I'm not in the best position to provide it. But I can
> > nevertheless care for the buerocratics and start with my archive given
> > that I get some support from someone with a more complete archive.
> >=20
> > What do you think?
>=20
> I didn't get feedback from Thierry (=3D linux-pwm maintainer) but I still
> think adding linux-pwm to kernel.org's public-inbox instance is
> valuable. (And if it's only to experiment with b4.)

Sorry, I recall reading this and thinking it was a good idea, but then
must've gotten side-tracked.

> Given that there is an archive on spinics.net, do you know who to
> contact there to ask for a copy to fill lore with it?

My Gmail has archives going back as far as 2013, which is around the
time that I started maintaining PWM. I'll follow the steps in the
documentation to prepare an archive.

Thierry

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7Lh6oACgkQ3SOs138+
s6EtUw/+IezJJq4YQNuukdBGt2EOr+o3b7UHxx7ajEcMkD4Nbih/KGEHL4G0deHW
kvLP3sVsq61m0rggJ7LsARwHsE3s6q72gH+yat0UJKK3e/C9fxkcCwfKhLcnaiNW
ktMT9M4GIbDeWIe9fYRgh0kiTzBmWhGEfRHYufLpxczsx3z9zFyEF2Wqd0KoBQrm
k/ods3UdTACqUeNSCm8FOrqGWtaonUkU4QzmTxPam8BsgkgUu5VFnkH41u6OgIkT
7BDWQH/Oz1HQhp3mIupvBwKegJhq3khIgR5eRGKA8UCfWimEef1zdU2Nt4w5lPYq
5TV6zOCMoPEhu3PxQ61YEmxz2/Es2WxsTr8n0L8asdksG8tWHGAgebbNELnC2VLf
q4+C42x1FFLhWAzxtTUeOx1fEf2oDnK/H9cC/5l5xKy+TVu4DmDCKjifzfcbEAGW
PdU5VHUrQERxsugYKzIdbuehCjvW/OH3/FWTmCsXZQiDISrJNxYBmquHH4BCww4v
XmBDAq9qIJXwKq0aF9WTTwOf+qzS6cJXzhNZCX9xPRoiKrNv9Wmsoag392mhl7WW
7vrfYLlODVAs7MtwgoVIrfAsy2cjsb7rSfjnAyfkeYNNpGbP1R6Y/ndHWw9MRxWC
SraUEIxY0ux+MlGDrro1IVyvTdByHjHPzZCp3kMZXefPHIwCn/o=
=XE6x
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
