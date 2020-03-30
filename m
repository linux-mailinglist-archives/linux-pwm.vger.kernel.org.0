Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1CB198006
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 17:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgC3PoE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 11:44:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36999 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgC3PoD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 11:44:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id j19so3707645wmi.2;
        Mon, 30 Mar 2020 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v8sl7YQXZ97aa3FXzORrF9cItWmGMOHAonTPdY7AfNI=;
        b=qEpXPr9E5d46arhUnkyc7Gtx5SnqxbVikfx+HG7viglrS2cvYAR+q85EwjSCyt8RoO
         RZBa0hEzjBVYSOM4i7EnLf0bFVU26IdzitvjlEG4Hzw7YZCL9OR5bRsEO8LAFyhLYnXU
         6GzW8HEk20J20kdnU53tlOnVo14im/YudhC/CcQ4gx3bNPxbqD7ot9aYUShMWoFCCYAg
         HDg6TzAtel4H50EW4USSWM/7EdtJdyUuA3LbbdoZqhBNXcqxeG9tDn1/UELU0lkgiC9i
         4XOj/vQ6d5dVrtzseUW/BGsiidugF/Ec/MMf+OJxSky3cSBW5SX6ftYTZ1sm2WbIO95v
         h9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v8sl7YQXZ97aa3FXzORrF9cItWmGMOHAonTPdY7AfNI=;
        b=fKRIGSSgUj9Eh7qcOBzN0Mp1E0qwQxrcSPNIn4QIplHwwHxe6saadSSXrbFa0kizqF
         3fMLVu/h/YrAagATTdHL8B7h2mQU2tI8oGM5ML9nn6MKv8nbHJ5htx145SvBbgQgWxE/
         Dxxf/HYOwL9rc4M3XIi0IANtSpkSsFfakY8JV4p0xL/qJu8W7n83gpw4q0Zxvs0Q0Fpa
         V92xfm9ugSBm2hn1ZyCBHDmroAVUVCt2e6amBj1TPD2MiPm+DQ+Al3Q607rahREp7reY
         a1sxgmjpRz3yzMTFLJlx6+znGL9YjjaxJiRRwjfd7Wayp+OEuqtDJPnzRB8YtGFBDRuL
         1GHA==
X-Gm-Message-State: ANhLgQ3br84ELv9ywimDoHtRkNzkli6pTZvpLvW/Lqe5M7n3EApkfSSi
        vTIYlXBfYI9vHrFHbEaP+QmN+Vo+
X-Google-Smtp-Source: ADFU+vs/OVvqzSToBwPx9bcjtGZ21kUhP16e1B/v3HvpbbtTwkUGC6aci1JNv7r7WQlcGtaPuxrv5w==
X-Received: by 2002:a1c:1d4d:: with SMTP id d74mr13608568wmd.123.1585583041672;
        Mon, 30 Mar 2020 08:44:01 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id f12sm21379034wmh.4.2020.03.30.08.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:44:00 -0700 (PDT)
Date:   Mon, 30 Mar 2020 17:43:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Message-ID: <20200330154359.GC2817345@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
 <20200330130757.GC2431644@ulmo>
 <20200330133450.GA1530@workstation.tuxnet>
 <20200330154036.GB2817345@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <20200330154036.GB2817345@ulmo>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 05:40:36PM +0200, Thierry Reding wrote:
> On Mon, Mar 30, 2020 at 03:34:50PM +0200, Clemens Gruber wrote:
> > Hi,
> >=20
> > On Mon, Mar 30, 2020 at 03:07:57PM +0200, Thierry Reding wrote:
> > > On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > > > The interaction of the ALL_LED PWM channel with the other channels =
was
> > > > not well-defined. As the ALL_LED feature does not seem very useful =
and
> > > > it was making the code significantly more complex, simply remove it.
> > > >=20
> > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > > ---
> > > >  drivers/pwm/pwm-pca9685.c | 115 ++++++----------------------------=
----
> > > >  1 file changed, 17 insertions(+), 98 deletions(-)
> > >=20
> > > Applied, thanks.
> > >=20
> > > Thierry
> >=20
> > I was not reading the mailing list in the last weeks, so I only saw the
> > patch today.
> >=20
> > We are using the ALL_LED channel in production to reduce the delay when
> > all 16 PWM outputs need to be set to the same duty cycle.
> >=20
> > I am not sure it is a good idea to remove this feature.
>=20
> Can you specify what platform this is and where the code is that does
> this. I can't really find any device tree users of this and I don't know
> if there's a good way to find out what other users there are, but this
> isn't the first time this driver has created confusion, so please help
> collect some more information about it's use so we can avoid this in the
> future.
>=20
> I'll back out this particular patch since you're using it. Can you give
> the other three patches a try to see if they work for you?

Nevermind, mixed up the series. I ended up applying only patches 1 and 2
=66rom this because Uwe had some concerns about patches 3 and 4. So no
need to test those until Matthias has fixed them up.

Matthias, I'll keep patch 1 of this applied, but as you noticed, this
ALL_LED features is indeed used, so you can drop then when you resend
the series.

Thierry

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6CE78ACgkQ3SOs138+
s6GlkRAAiNq3PY2visPdWkNSAhUbBF0q009ao0QOM1HGuNHiTxrA5lKIQ/9usaHo
5MRJWV9/Lx1Ye3G6RRad9jfSiJ09+JZbQdiLxpX/8aHMrz7KXRURoYFbNFQBaaJu
yZh2lBn8g4SBUJhfQlR0h0kXEltDHEqlP0Twu4wo++CnWvOqMxZPqQh5Nqn8Bprd
gBV7dtYHQDw5YZVvXgvgM3AqIlQicBJHhAaeCfSc5/wdDK9Iv1/1KQaviemjLpVp
xcPDBTX0Bcu81QWdfRpU6VcMOOj+PUKAYkZh3mdHE8Evc7VfgWw7wcOEjIYgPS6S
5g/346g6A9WJ2EWNvLOxMgp26z8hrIOjKCbWfW7RJGpUN6GMQxSAw3CaOPmnAeM3
SST3qTtNMCr/cZvh7BhcqmVjUC9FJwvUj1EauaNvE7g38Ai9yNV2BXWG+5zRlZeB
N/49D2SOhK7qtxUif7VHxhBonPjx7SDs/KroyRRcAewxaRbHYiK8yNruvTfezhzB
ze23DUB6HtKAEurZ/JghqgkQnoWReswOyt4nUHzqy8YkMee4Jq4lMwY05Fnn+xft
unzZKyb2oBQxQJbi/PvjiummXLtUOCQMn3PABEKh0d3WQ5/I3YFGohaBOcapV00w
KOFLqsSeXMSCSt2f9P6L5eKbWfEc8qGgNVNLh7mlXvHWE4ZvxRo=
=vDVt
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
