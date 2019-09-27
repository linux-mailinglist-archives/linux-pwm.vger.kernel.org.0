Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08059C0463
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Sep 2019 13:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfI0L26 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Sep 2019 07:28:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33000 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbfI0L2m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Sep 2019 07:28:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so8758432wme.0;
        Fri, 27 Sep 2019 04:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iC7YibXeilwC0gLOPJ3BMTQ4w4cpiz8fv4f+n17nhsM=;
        b=phEeBMCPVhoi3oKKGWLWfjqkE/RffCqzX3mbEVAvdNajlR5ixI9FW4oPwzE3xFHAq5
         105bM4HvxG5xjgrMjU/mnbdw/UgJ9LLU1zw8oreU1hG4drEtN7mtBinkXH63JYA5hRUR
         BxmWlvyhXL/CYsluPSIdMIXow6dH8sMZeGMoxnSJ1MteTvq0LbH3XKhEtecFCn9iNMnP
         UJxMm0n6Uq+SskylQn65ly1b5XdqCVeCNMizrPqIoKzG8il7KhzxAg70innewiBg9c2b
         nQcPHAUydFHNhhYqJ1lvfAGxDm1xTBy1ylgFelO/V4B9Atv5PRTyDZRSSgKvZvRk10hE
         J6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iC7YibXeilwC0gLOPJ3BMTQ4w4cpiz8fv4f+n17nhsM=;
        b=U+I2XjaVX6SqNZD+zXAQl5UAddClOfBkiR/aJfhR+cDzkkbdyHnOJss+8f7t6YkI7A
         Jg+hkyo0Puwrax+H0sciwr/X6JhkXC48g5GRKtvSxMNBXQktdMR0YZlrDXkzDpJYjZH0
         taBM3Xwpv+j+/bqBUd6fhOFwOEitbXWlDVlPi274fdknSM/xoPRdwR4qRKs4WQqLn9Ic
         bz+cUL3Pj+cArskHofVg1m+HxadzHpvup7wXR2E3oR4z+fh9/Wa2wbOL/WWAkKz97gsH
         gCP/zhUM8riEtRXPk3eQv7ZlFb5sejfWktLY30KBpS1r5C3pUEOJAfnSu3veuR1RPUDa
         kcMQ==
X-Gm-Message-State: APjAAAXE1YbVTg1Hwb7efxFrB0xPFNgm2GCX+k/YjaaFpBuNPYqmGGK0
        93Z+29GiNHki31K/M4wouao=
X-Google-Smtp-Source: APXvYqxe3jLdGyoh5bEEJk3RfqsyTk/E933I6cEi801ksIiy8GDTIH8nq5KTX2XRXpvzC7jjWF8bZA==
X-Received: by 2002:a1c:454:: with SMTP id 81mr6593016wme.119.1569583719861;
        Fri, 27 Sep 2019 04:28:39 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id p85sm10863831wme.23.2019.09.27.04.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 04:28:38 -0700 (PDT)
Date:   Fri, 27 Sep 2019 13:28:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v10 08/12] pwm: mediatek: Add MT7629 compatible string
Message-ID: <20190927112831.GA1171568@ulmo>
References: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
 <1569421957-20765-9-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <1569421957-20765-9-git-send-email-sam.shih@mediatek.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2019 at 10:32:33PM +0800, Sam Shih wrote:
> This adds pwm support for MT7629, and separate mt7629 compatible string
> from mt7622
>=20
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 6 ++++++
>  1 file changed, 6 insertions(+)

I picked this patch up and made some minor adjustments to make it build
without the num_pwms patches. With that I don't think there's anything
left from this series that you need.

Let me know if that's not true.

Thierry

>=20
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index ce7525d8d71b..7035abfbdc6a 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -307,11 +307,17 @@ static const struct pwm_mediatek_of_data mt7628_pwm=
_data =3D {
>  	.pwm45_fixup =3D true,
>  };
> =20
> +static const struct pwm_mediatek_of_data mt7629_pwm_data =3D {
> +	.fallback_npwms =3D 1,
> +	.pwm45_fixup =3D false,
> +};
> +
>  static const struct of_device_id pwm_mediatek_of_match[] =3D {
>  	{ .compatible =3D "mediatek,mt2712-pwm", .data =3D &mt2712_pwm_data },
>  	{ .compatible =3D "mediatek,mt7622-pwm", .data =3D &mt7622_pwm_data },
>  	{ .compatible =3D "mediatek,mt7623-pwm", .data =3D &mt7623_pwm_data },
>  	{ .compatible =3D "mediatek,mt7628-pwm", .data =3D &mt7628_pwm_data },
> +	{ .compatible =3D "mediatek,mt7629-pwm", .data =3D &mt7629_pwm_data },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, pwm_mediatek_of_match);
> --=20
> 2.17.1
>=20

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2N8l0ACgkQ3SOs138+
s6HrZw//YXizi7+n/nUsGnoQj0Nd4kpxgNnWEke0I4l6zm4ms4+hqUoPCWiFuZQO
PVvg+lUFZHGpTs72sB45wW81NFgwQbgdqMejJOl5F4oU8qErIMuwIsPJWsT5Pnxo
pezDZZVU545OzICGnWft3wFwh7nFKqQNB3085EApr5YU7jUmVdOTud+K13SfWZEf
0/LgRL2h4bVVkUR4b5ny6tpc8GnTsS/zDgZHXBeLBe95l9yLwPKqkzKLP/e+v4Wu
EH18RZb3Iw9G+q5nsmr7EZBSVnf685DGAW1+VK/w4nGCcjPTFUL0sBXpCFUhbzI7
SXU6YK4oWrXu0gmzqNjjAuTPRC48IU03nTUq8rLUa9EONioZiEOMmtQAq8u7l5hr
DLAo90ZHOMeeBoTNqBNfLkKOqtzBacsZPZycThPEbGBbyafo8cTvf/TWHidhbXvv
B9EL4Amo9AROzun9xmd7FLHa1p1i3df+/lvt7oW+Hs2E09g7gqWiMgYn6aBEnAhs
z9gN8Ys6MhUTpfagvjeA4yNTV02mNxSTobCYui0oQCvBmv13ztlZGLHZ7pTDgOjj
ks6J8EYPxvWBN4YZM+NYaqsOALBssEfB3qTtOsH9dyTELORrtFVKQyFDIUY9gaf9
DSq4SsUFGiOw4l+tXlLojB9JdORs+BasCKXB8ncmz/Vdj6Rn0O4=
=gb7b
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
