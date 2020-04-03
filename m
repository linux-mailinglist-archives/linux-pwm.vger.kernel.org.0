Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C82DB19DEB5
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2020 21:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgDCTo3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Apr 2020 15:44:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35597 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgDCTo3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 15:44:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so7608103wrx.2;
        Fri, 03 Apr 2020 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dL35/KDrO9kk5GYoU2spCW4xpugUQC8ErbDAX9x0Gu8=;
        b=RFvhkqM38AZ3tO6/eGOW8EMuB+S366v2bxcxzLwsQYxD7wEd8Ms4deyxkM2EBHnDHu
         JwVbeSiTaiq1NY9DY8pPNfCJkP1ovZ4hGxPMVYuSWh2fnstb45fzjJtv3wFfbGDZRIdP
         bgQ9ctj+/5iTU/uyyPIlzpvOOb/jmsaUracBI5gQgTpQbkhjsZAJFufcVSG9fWs1TERr
         Tr/aORQOoiWvisaFOXrym7FdY8SwT0zsEH2q47IrUA5HWiHDgTSt3HsHxZUAnD0f21kH
         nT4oZJBR7izhY8SGuofAneMYBs0ziBefPPss2Z+GoLgrsVYBUYyCHeZOqXGOloVprwKQ
         nrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dL35/KDrO9kk5GYoU2spCW4xpugUQC8ErbDAX9x0Gu8=;
        b=oViFHfLTpDSgnro09+wAePwsIm3sMiflPztB7BhnyPQPwyTgvOAzHDWK4jV9r3gk59
         BK1tRD1toTQG++D48dd/nAH1J1affhBF9AYD6O3Psnl/B/xPe0y/wdTFbURPB5+JJXha
         sT4DNorBetX9sppQubOQvtVW5f7eggxphz+n5cHWK1vX3zoRxmBSk44T5iQAo8BZFNjf
         30SmJd7Vh7/ZHlsXED66uo8LfTAn4IBSQ+ujx/XSx//1GL6w1Kqxlo6dIPl9LQiqLY6G
         OYw+tUKH29pidy3v5N8Lp9uiG0PqwIkexfcX4U/MNe4Im+8YIUBbtCjiEQ3C3gVqk1R3
         EDjQ==
X-Gm-Message-State: AGi0PuYBJtkeFL6pd+BPpE2/RhI326bp8hwxTu9I/Z1MFCd28Prt8IbQ
        aroeadGSRfvzwrV/xt2C/QFR7l3P
X-Google-Smtp-Source: APiQypKfgGDNRj3izQQLQWikN/RhUd4+v/qBrrpt5JZ57QOnefvRSSPnCsnq9O4REf5pm0agQOzCew==
X-Received: by 2002:a5d:500d:: with SMTP id e13mr1566557wrt.362.1585943067756;
        Fri, 03 Apr 2020 12:44:27 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id m11sm12835978wmf.9.2020.04.03.12.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 12:44:26 -0700 (PDT)
Date:   Fri, 3 Apr 2020 21:44:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 REBASED] pwm: pca9685: fix pwm/gpio inter-operation
Message-ID: <20200403194425.GC201060@ulmo>
References: <20200401170106.134037-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20200401170106.134037-1-clemens.gruber@pqgruber.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 07:01:06PM +0200, Clemens Gruber wrote:
> From: Sven Van Asbroeck <TheSven73@gmail.com>
>=20
> This driver allows pwms to be requested as gpios via gpiolib.
> Obviously, it should not be allowed to request a gpio when its
> corresponding pwm is already requested (and vice versa).
> So it requires some exclusion code.
>=20
> Given that the pwm and gpio cores are not synchronized with
> respect to each other, this exclusion code will also require
> proper synchronization.
>=20
> Such a mechanism was in place, but was inadvertently removed
> by Uwe's clean-up patch.
>=20
> Upon revisiting the synchronization mechanism, we found that
> theoretically, it could allow two threads to successfully
> request conflicting pwms / gpios.
>=20
> Replace with a bitmap which tracks pwm in-use, plus a mutex.
> As long as pwm and gpio's respective request/free functions
> modify the in-use bitmap while holding the mutex, proper
> synchronization will be guaranteed.
>=20
> Reported-by: YueHaibing <yuehaibing@huawei.com>
> Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Link: https://lkml.org/lkml/2019/5/31/963
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> [cg: Tested on an i.MX6Q board with two NXP PCA9685 chips]
>=20
> ---
>  drivers/pwm/pwm-pca9685.c | 85 ++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 37 deletions(-)

Applied, thanks.

Thierry

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6HkhkACgkQ3SOs138+
s6EpLw/7B2wgmKpQYAy0SEAUiVfRJqbh5qpUT26I6qKNgXMtkhPjhtinfPd7MCta
YYmIWZxEPUZ2iO1pmWKItkQpCsyomanvTLZX7g/4+8zd8I6bVgREdtckx+8gAQ6W
L2IBR0QcPOyRVJYJB09IcCoX0A5EfWp3qL3s8dm66nTnk+WwsrTma6IpaMUkHS3y
ezvztdPJ6l6q6M/ZgiXrRj/+oSrzvj/x0Fa3jqT13i0+DWUldk4SuY2Bt0GmFByu
FaSKeonlma4tCIkczxge2Zg3niVYN5VylsnZoIV2K6l3x3YM4w4nX5Wu6kVDz+bd
caNzwGhJyrlrlWt7vGPph+MAP/wzY+anaO8v5HnN3a0QDq4P39swCgffGQsLGdeE
7f5ivDPUHwhzWoIyNAdWMBekPA2Y0QaFAaC2/WBd3Eoh70YOfgLS4VQRchljE49e
eLt4kZq0jkEdPXtrNTZ4oeF4uY9u2vGkR802+AJ2QCC7PqWQfJTVg7cX28pP5fj0
sPVdNXbxilZ+9lNZq4OAO2BoYFBR/rSIc36xxri/+jIAqA8X044NJqlPcR0T54nV
SFNpRx4EVTGxTi14Cq/zVPuai7OxM/nug5lFx63qYvGp2+a7M3D+lZJ6WSimuoK/
KpRAsgNGeHZCeGllgIh548dbc8VRT2XPrIqGRJBcHzO2rwWt9bY=
=miJb
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
