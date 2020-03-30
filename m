Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3EB197C73
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 15:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgC3NIC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 09:08:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36768 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbgC3NIB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 09:08:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so21857969wme.1;
        Mon, 30 Mar 2020 06:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tBVIMuSfc5egYj/SCDO/JgH8pd8vZxVRpuXlFf6en/8=;
        b=ontBQyASopwG7x/PUTQLgqBAQOIfmuMj8B52BVs11uNh3EkCSDZJx4VmZ9cZUiMNBm
         VSRMnSFNI2IicviwU+POBdCxaVaxIiC/ER28E+N9u6LUZEozlyhZ4Etl8xBAEuELClcQ
         Cc40qWYjTFk1jfy/COfVOvQ+LVVGz5sYSJ4ssYRQVm5s8R83IybknrPfK8YZjOJpFpCF
         hrYSeZsokAtDqwHpmhL132ydhbSPGm/VodbO/DsrQdcl7Ygd7TCzrBgBoSFdjFMjY+dL
         USSaiEC8AEEBSL3pAPwUIeGZ4zAxNCIz4wSBV213G8ve7K7Us5cOqbJ+nJVf/MGg/5Xo
         TqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tBVIMuSfc5egYj/SCDO/JgH8pd8vZxVRpuXlFf6en/8=;
        b=KJ1mmLW5Bm6xj7HqoFpJ5xgkWEVmNs5tx00c3UNyYqA7LiKP00amvPKRsM0f/fV8l9
         S1p4hfOMi8h8gPUTI16JOGAExx5qMC1Gn3udgNauuQi1bkBRAGD+qJVCtKhjirI1JXN6
         QXQ11N7xs/dmVTbyJBnBk1oFfmgG3WOY4Qklxi0bFhN18seeXvY9XphqBCekMT6jhIXw
         EAjWJMKeP8bubXWBHuY8Nm5KpYEFGi9Q0L+ezH8vzqUZoWRFJ4JdivnE5CjDhunpEzZo
         cW+yrtQhKXZzxGV0qReyn5zyOEOG2ffNqJpoHrfQxiXqwpge/nmVzVEA3QkMmbOpjf/N
         DSqg==
X-Gm-Message-State: ANhLgQ31jm7M093cVIq8slilIfFWzTiGeHVNZSum79eJFLFZRyhdvY4e
        Gq0D0PLYb/RHvP7gJ34LqxA=
X-Google-Smtp-Source: ADFU+vstSw0jiT4tefUg6KLBPalfjeXvsusSvREs/w6j0P0fk1Kk/nIcZiwu5jaWBxQQmBKaWpOv8g==
X-Received: by 2002:a1c:2b43:: with SMTP id r64mr13321885wmr.77.1585573679649;
        Mon, 30 Mar 2020 06:07:59 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id f14sm21111618wmb.3.2020.03.30.06.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 06:07:58 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:07:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Message-ID: <20200330130757.GC2431644@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> The interaction of the ALL_LED PWM channel with the other channels was
> not well-defined. As the ALL_LED feature does not seem very useful and
> it was making the code significantly more complex, simply remove it.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------------------
>  1 file changed, 17 insertions(+), 98 deletions(-)

Applied, thanks.

Thierry

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B7y0ACgkQ3SOs138+
s6GRNQ/9FrIF8ORfn41vZHxjUSMe//QEu+IgYILRVQ6heWO41DJjaplwzIO8cnNa
oxBZOFZw7bXmFE3v38PdrvDGnFP6CwSwRp4FeWLUs1Xk6tvQ36br66uUD+k+iX7/
w0WR4OtcaBPAdGYFyWLq4ecyHwYuw9lM5OUYFVebg5XyvoIIrlXIrjQflE17yLsc
xtlLKKYTBESB0SHR/6Iva0xyRHgwy8SGNuMf7Ps3dBZO97iUqCdjEq6NdA5jlLoh
F6roXyxtkO4TWuBE+lflngPByDpzZOBkaL2LFEQzC14gonCbbVq21PZRKtgwUoFi
zAy3gITJDMQT44ICaKrFJ1U4rdbz1ELf/ep33gz63uBPd0hDd1zMrkeYftrFqpaY
2nZN/Vt+dxfy9GZNBdPHK7r0aoc0h4KWE7d5jNbBklkhl4CK3gG1PLcVaAFtD3ym
VBRi291N+XukN9EY68Ot/1zt2AI+4tJTFxNWxrcWTNcnGcG3vPZxOhfjGSKbLQLg
VahPbbaJUQiFXVsd6huqGDh43daN6HnAuJgd739pndVz0nliHUv+4RJgMG2IZYUy
wVK/l2BQFrX4pAq4rjG+RXwXOlo8Ya0/0HF59dKIXkA8fkBbBKGGoPrwgsiIeqVi
0skMjPmbJ+bayCoouWcBiV0Mvl44GJpVhIBtdB6h81seRP+dxrM=
=Cw/t
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
