Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1791F1429E4
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 12:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgATLyI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 06:54:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44422 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgATLyI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 06:54:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so29240374wrm.11;
        Mon, 20 Jan 2020 03:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L51LKob5w5C99mhKOnpy+Hh/B3FukYOEDBWz4jiWK9c=;
        b=P+SZK1tduoWsaphyrSVBynJmE8NMwXDpwRrid9kQURsPEn1cooUkxWrAda/PWdfKer
         vbOMP37ZVUaFxH8zvFXZdCGUMDhDZt5Qc2ytkupEQRBV/LJ2Ant1VT9YQYTtkjYcmHjF
         tZu/5Kaqwvjy8q0JSJ9ZSHjf4v2+u4aU0aiGI5lR0ZTYFT7kPdGG4KFIaCQ4uZG84J1+
         9FPVFlhe2dDWRlw2fs+/Jlpxocw2foPBJlPlQLdhsfjzWpSfwVY9k+z9LLsBFgrgx7WA
         6Ot2ESuxjyNjOXZ9zILVbRe71IwviXJaT2TcpHIwOCCsSm63sjXkvugDg6sZ0tKKjkUu
         MCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L51LKob5w5C99mhKOnpy+Hh/B3FukYOEDBWz4jiWK9c=;
        b=XWnRxtvMQLEmZ64vnihK0lA50g8M1IDJT6d860pF2RZ2WZfWx9ffKfcaEngizRSNAA
         DtCp2PAlrftoMUqZdQk4aaDhjsnXxLcinSj+aUIZScW2/BMTSRpL86YW0UaVHqyb3IvT
         RD5UiAP1RM/F3ophnHG99KHuZcUMV6uFZNx85O7kS0SWkw80r2IIZjRQbsUNnflmKvT+
         MhRhG0iLkkOFHnS2TyMEtfXXEjrn3hoWKjcrnInMOJlUeXoldF3PYpt6um4d7e3SIi5C
         Mb+5Zr7lz1mqJ+orS5+7F8Hk9enIh+qI83m8vQLKq4FGIXYQRbnCeIzqKUcp/+Jl0jxZ
         j+wg==
X-Gm-Message-State: APjAAAV8yKi2jYFqF63GaM/JgGiU9uelEOpdq2EnrMbx8JcOX9VIqTwF
        puo0dJ/37xWI/DW2AoVDau0JDTsr
X-Google-Smtp-Source: APXvYqwZMu/00hdevMMP9Kctq+L34gvOdjUxtxvt54q/jgBteyGpG1eUEbQnlTbPxDHQqm1QHwUckA==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr18722882wrp.292.1579521246452;
        Mon, 20 Jan 2020 03:54:06 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id a184sm3522408wmf.29.2020.01.20.03.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:54:05 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:54:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, CK Hu <ck.hu@mediatek.com>,
        linux-mediatek@lists.infradead.org, sj.huang@mediatek.com
Subject: Re: [PATCH v4 2/2] pwm: mtk_disp: keep the trigger register after
 pwm setting.
Message-ID: <20200120115404.GB206171@ulmo>
References: <20191217040237.28238-1-jitao.shi@mediatek.com>
 <20191217040237.28238-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <20191217040237.28238-3-jitao.shi@mediatek.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 12:02:37PM +0800, Jitao Shi wrote:
> Move the trigger after pwm setting to avoid the pwm wrong signal
> output.
>=20
> Remove the regist enable trigger setting in probe.
> Move the trigger to end of mtk_disp_pwm_config().
>=20
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)

Same as for patch 1/2, please make the commit message more useful. Don't
say what you do (because the patch already shows that), but instead say
why you do it, what the specific problems are that you're fixing, etc.

Thierry

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4llNwACgkQ3SOs138+
s6HDxQ/+IOGqWchokwjeBg42kfmwMjHb1KEpMro+54eRGoYNxpDIEVacCzzxSTsE
5buLHuzucUZj84iAYDWzzw+m2VVpVrAUf9U6GKXYfPuv+jrXDUqZGU1FYELRTWBt
NebebfYiaeLrx3/ZDF6FRuoVusubMGexn1RgqCqruOyhB9dYG4z+j52zol+EUG7K
N2nbVTzyUn4RnpK2j0KDGW/+vJt8TSwvowgwOq3SmWWqUzA1XnOI/CUijfDGjGh3
ggGS/koW3h5zkErcEAiGLJ4ELlhEbj67ytei8hh8ktRLAZjSSYY8ktE0Q7/q3V6T
0DMxKPzlVOEpfr2/KEQ4r/ibEYDAyJ/Ab23nEw/aMjFq4DXFHCXPkVrRJzjFBHKi
eGt2HbzDbEBH6rrFkVaiXwstx+81m4Yqlm58uzdS/iMzFADo1Zke4enAF3LtY8LX
Em+JJX52sGRjFzOIlveGHY4MqICdKM0MkvO3VDS3thaQRnK/wdrA136/+rmJOMi/
U6JWvcGMxPVuZGDukaRZRXDa5gys5qFSdeVS6d8rU9a8NmFcO91gn/K4Pks60mtS
mNuchXD3oZ5boHb80GoqW274g5wY9M/haw2QMEeydodtUWAz0UIp9l3v+vRqWXC6
8hV3/yVmxZiYhazGk5EZ84wGwflGHZZ4ruEYsMV95wxIvgB01GI=
=TZoJ
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
