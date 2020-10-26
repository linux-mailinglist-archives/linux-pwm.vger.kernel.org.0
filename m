Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED34298F5B
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Oct 2020 15:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781535AbgJZOcY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Oct 2020 10:32:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:51442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1781420AbgJZObw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 26 Oct 2020 10:31:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3D1FAAD07;
        Mon, 26 Oct 2020 14:31:50 +0000 (UTC)
Message-ID: <2ca7430db77ca2924cb6f4b99e858f155d261a18.camel@suse.de>
Subject: Re: [PATCH v2 05/10] soc: bcm: raspberrypi-power: Release firmware
 handle on unbind
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org
Date:   Mon, 26 Oct 2020 15:31:47 +0100
In-Reply-To: <20201022155858.20867-6-nsaenzjulienne@suse.de>
References: <20201022155858.20867-1-nsaenzjulienne@suse.de>
         <20201022155858.20867-6-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-iro0+jQoAZrbRkqhy4O6"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-iro0+jQoAZrbRkqhy4O6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-22 at 17:58 +0200, Nicolas Saenz Julienne wrote:
> Upon unbinding the device make sure we release RPi's firmware interface.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/soc/bcm/raspberrypi-power.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/soc/bcm/raspberrypi-power.c b/drivers/soc/bcm/raspbe=
rrypi-power.c
> index 5d1aacdd84ef..a0b38db5886c 100644
> --- a/drivers/soc/bcm/raspberrypi-power.c
> +++ b/drivers/soc/bcm/raspberrypi-power.c
> @@ -225,6 +225,20 @@ static int rpi_power_probe(struct platform_device *p=
dev)
>  	return 0;
>  }
> =20
> +static int rpi_power_remove(struct platform_device *pdev)
> +{
> +	struct rpi_power_domains *rpi_domains =3D platform_get_drvdata(pdev);
> +
> +	of_genpd_del_provider(dev->of_node);
> +
> +	for (i =3D 0; i < RPI_POWER_DOMAIN_COUNT; i++)
> +		pm_genpd_remove(&rpi_domains->domains[i].base);
> +
> +	rpi_firmware_put(rpi_domaina->fw);

I Just realised I failed to squash a fix for this patch, so this will not
build. Sorry for that.

Regards,
Nicolas

> +
> +	return 0;
> +}
> +
>  static const struct of_device_id rpi_power_of_match[] =3D {
>  	{ .compatible =3D "raspberrypi,bcm2835-power", },
>  	{},
> @@ -237,6 +251,7 @@ static struct platform_driver rpi_power_driver =3D {
>  		.of_match_table =3D rpi_power_of_match,
>  	},
>  	.probe		=3D rpi_power_probe,
> +	.remove		=3D rpi_power_remove,
>  };
>  builtin_platform_driver(rpi_power_driver);
> =20


--=-iro0+jQoAZrbRkqhy4O6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+W3dMACgkQlfZmHno8
x/7DPAf/W6V8Brdbgq2QtE27YW5fEMV34Zg8X73FdarZ4ek3YR4/DxGnBXwz6/o3
Uf4CVOLfSOnlwf+nO26rHfvMl8WBwo14AR37nVAiHBFUOSiTvExBO+aHFDvHfHRP
LMcZeVRWNrH1XiVuYsXMlQ5BgeTba6ii+awS2itDOeR61xraPONJHgc0sVSbnjh+
AqDo4TxRZHP7CifFfwTZFC/yYt5RXYGyVYvvi4rWu9FZbwjy06rlmMcGZyguGpgj
grC4TlIs1actEIgrFa8cSS+zLNpcYCBgFe5HzVjqkyrhGu5lJZbFqmgbACV27+Jr
nBhLMJ/JZSnUSDFMhDuAJtC0/132LA==
=AyH+
-----END PGP SIGNATURE-----

--=-iro0+jQoAZrbRkqhy4O6--

