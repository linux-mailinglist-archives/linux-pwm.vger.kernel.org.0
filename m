Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108CC27577E
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 13:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIWLwK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgIWLwG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 07:52:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F21C0613CE;
        Wed, 23 Sep 2020 04:52:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d4so6844356wmd.5;
        Wed, 23 Sep 2020 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=62leXxkn6lfQBk0pj9IGOMm88gpEkBUQrcCqhx44WHI=;
        b=ODmaWdLBKOeSP1ZafWzo21vjJrHlk3UG4jvO8+g6WMM1BFtTLmzx1IjbGjRouQUa+7
         nAMc2SENwtPelG8pH3qifpRoFvyXIyHkkSpyttxOBSllpGFUWNDTbc7RWWZwDXiubVzz
         DId3At1uwFhl8QdtjFs9TEb9pLJUGmoMWNZljWBiFG6YHY/D5eEaVWfYRHdsGOT1LmMl
         WPXOjkI7LdOyCKmm8KnbDvvqWylTGVG9rccvd2qnBAegNKT8R9zR8wUu35rVANaWTR32
         pzLd85pgC4hOTjPoqQYRZACHbmH3e+lrH/elvTuoGpBsCqkzId/E+uobn2wcVgIWij43
         kdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62leXxkn6lfQBk0pj9IGOMm88gpEkBUQrcCqhx44WHI=;
        b=aEDvazGiZZMyoy6AXGp62tjWh21f7xsDLSFNdZpCd4GNFK8Ui99xX7YzlaCjok6CxM
         mWqCq+t/2xBhrkhjME5QISNdot7YR5oj18rgsBv/ikDhFdVhxiDujUTLqETd6D6qylDj
         5ovcorP+p8Mub/S2ip0eVH5X5/fjAkZyzhYwND+xIszCLBGWqBIycGP0pK4XkT+LAHkR
         vUoHxjRnv4PWlOFJkPs3KF2tzPQDLZqyr+NqFX6DBQyw2Y4rPI1X3xSfxB4nbcmxAleK
         yRIs6VCmXnjicd1swB8bcRww2a4DnRlGR8xQOKbwGs8/W8xt8MRyHrIyXMvp4PoA2lhQ
         KErg==
X-Gm-Message-State: AOAM531H4PvE36xZxr0r95w3y5DeIAdA14Ta3yxLzxhaNttHrVTVUUrz
        QQ0fkiVGTv3Hf3zPwCRfcIY=
X-Google-Smtp-Source: ABdhPJwuky5Ub23hg9gD1yy7ZPW4fTKq0bW7//cbGIq+DmdbAGJe7JBSRBqC41QuYp6pi5kgGRRJBA==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr5266287wml.180.1600861924874;
        Wed, 23 Sep 2020 04:52:04 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id a20sm7785703wmm.40.2020.09.23.04.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 04:52:03 -0700 (PDT)
Date:   Wed, 23 Sep 2020 13:52:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 06/19] dt-bindings: pwm: imx-pwm: Add i.MX 8M
 compatibles
Message-ID: <20200923115201.GD1846003@ulmo>
References: <20200825193536.7332-1-krzk@kernel.org>
 <20200825193536.7332-7-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <20200825193536.7332-7-krzk@kernel.org>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 09:35:23PM +0200, Krzysztof Kozlowski wrote:
> DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
> to fix dtbs_check warnings like:
>=20
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
>     compatible:0: 'fsl,imx8mm-pwm' is not one of ['fsl,imx1-pwm', 'fsl,im=
x27-pwm']
>     From schema: Documentation/devicetree/bindings/pwm/imx-pwm.yaml
>=20
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
>     compatible: ['fsl,imx8mm-pwm', 'fsl,imx27-pwm'] is too long
>=20
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
>     compatible: Additional items are not allowed ('fsl,imx27-pwm' was une=
xpected)
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9rNuEACgkQ3SOs138+
s6GvDg/+Nro4jTSFhaaEb45wLg7Wg5AT70Vw7JpMwqEfIe5L3+HCzsAZX08eoriW
TwsrzDYwi1mA2E8LXgnab5e3AAgrQJO5HprXoQ0736DAqPzLovczCCUfBnS72FTM
gtWR/H60vrI/6jPUT+YqqvgtH1SQZIDSC0Sr936omELFXZ7N7kgTW1gTMR9jeMGj
eoEUbgMKztiNGZpCm/kRLffCONoKpyz/3luja+KXkB07rPVluMjwhaFBNYxr6oB2
K48rLlPN3B/3u+qD03bB4fBdycLNO0IjVepdM21pBsGyKAT4uYfl0wG86/ww99EB
1v9/vWoSmwnxVBuPDDj4ecj7iD3VExSDZ7x2vvID5NmhK3ndjisf8C979I48hvMo
maBVSISDlvaIs2KbzJt9JoqHYaBNJ4LUdTwnFfcVo0vT9EY0H9KvLbfw93I/0VjU
r9WMPCRYtEOiS5riua25jp9pSxcnQE92v5NyNEMg+sdJ9uyLPYo0NBFbhTskEjnC
7evLkq5xpYJywh6bQvhVOhnbCoVGAOdqOIJ25xSC2wF5vaCWWRhjDtsS7d/EbXql
tRX3gA2RlNUKlF1MlGp7TUtnWkl/EWtaWI26qm0/zuvyAnxGKBY5Eo4HUMGNtVWH
BgQsfOviGCcDALYVPWC6foLtzrsz8BMYVVi+7u2hD0FMOa29oas=
=09l4
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
