Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5370F18CA2
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEIPDB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 11:03:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45657 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfEIPDB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 May 2019 11:03:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so3486805wra.12;
        Thu, 09 May 2019 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Sog/2qIfcLY1kwGbgsfnaLx1YInIBe0tmQKmP6und8=;
        b=agNGjFRiqp7mKOA0sQBpnVLz6Is49Ht1R++OlJR51N5ZhOmXmn9B9bjKoaCplyoGZX
         o0D4RPxiOoechErWKKdqUMf5YIG4QHxLWCBeVtmO5ML9eLa7vM2yXQQzSFBl102vPvB2
         dN/VOVjGj4fu/GMzdxa+FuHn0nPsF9VBMoEygXoJN7Pjiuo7rNUpIWcs/jtyHrGhdmnv
         NdQabe0Ddzt8U5wppFH1vxjGHqtKwrg3voWdW9wLdKu7UPE03HZ127Q7xZtAztFkZWdp
         XBqFvUSs9+4jS4XOzZ+VnwNMCn4KcUUBUloB4TsVDNBSFaO3tDml4w05QNirotWIgYtW
         ZFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Sog/2qIfcLY1kwGbgsfnaLx1YInIBe0tmQKmP6und8=;
        b=SkP6bU9Ynu83HNxSdTAEHmfLl3tfb8XcjdxRLuCtgHn8kShvXt68V/KhADzm1m6G3/
         f4F816efexWT3nAjZTIB3kkxUJ7j0sWfIe3UCOV/X+oqXHY3T6GMIXApncCqDkeA1S96
         +TXWHVA7LOxN5GiTc71iCY7+S1adDweSpLSPW0lffH2dEHU4eAwYSBIyCUX32jObcaui
         K06IDgknJRXDDkZyOE7Pw08PH+yaOZH7Gl381IGCCUEVpNNLWp/KY14wXWm1DFNCuIuP
         rrry04XNgqacbhXdZpfmOgTu14zKr8VNVqRgy8NuKN3n+v3dKGUJKowcIcsOHCvflXBt
         RZ1Q==
X-Gm-Message-State: APjAAAXNx/ACOzgewzIaAVz6MOlpF3lSOUG7+sKThgz68rJUxj7IBTgn
        LrXERqJse1Gatu3dzw2uuNs=
X-Google-Smtp-Source: APXvYqx2U4Ma/5CCY1tcHElwBTn4qwsSkBBXTVWp/3t0oForQwbgZRUKZ2bl+MvX4wDPq89Ij4naKg==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr3701903wro.206.1557414178884;
        Thu, 09 May 2019 08:02:58 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id x17sm3298766wru.27.2019.05.09.08.02.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 08:02:58 -0700 (PDT)
Date:   Thu, 9 May 2019 17:02:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V12 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190509150257.GD8907@ulmo>
References: <1557408252-21281-1-git-send-email-Anson.Huang@nxp.com>
 <1557408252-21281-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h13GW2gLSV2TxsNR"
Content-Disposition: inline
In-Reply-To: <1557408252-21281-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--h13GW2gLSV2TxsNR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 01:29:29PM +0000, Anson Huang wrote:
> i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
> inside, it can support multiple PWM channels, all the channels
> share same counter and period setting, but each channel can
> configure its duty and polarity independently.
>=20
> There are several TPM modules in i.MX7ULP, the number of channels
> in TPM modules are different, it can be read from each TPM module's
> PARAM register.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since V11:
> 	- ONLY add function comment to pwm_imx_tpm_round_state(), no code change.
> ---
>  drivers/pwm/Kconfig       |  11 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-imx-tpm.c | 448 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 460 insertions(+)
>  create mode 100644 drivers/pwm/pwm-imx-tpm.c

Applied, thanks.

Thierry

--h13GW2gLSV2TxsNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUQSEACgkQ3SOs138+
s6F/KA//UWmIXrWZOEJNfWpMu2ymqohHv39qDATl8P2EsfvZ2lFAEj+Q7KxyUghE
VEbkXJksm+A8u8HBj1MKNzbxrc1xodUIWaOVo3/Nj8BY3gt1+yIaiVaEhRvUPaod
18uhIWkFg2eZAw+3vHRumyHdL/DeYu1ejmvCD3qmeCbW7TPudKPy4DFzpD2zQmYG
qVKChU8J6SA+jUNsUrAVaKBdSoorWWeImvgZeXWUN6ltRZnua5goJvWU6NSDhe5B
PPvaJAOBJADlWJ3VmGieueuY4ds2k+XbFzXezgPQZNzFYrCgdMG+A6KCzbt5ZKS+
3Hh4iSlVKwpvbK6bxOqSqqAi1AkqbGSX3FRLy1/vpm9t+SXrZWpuk/YczuaXkmNi
PhKmIQGpeuBscTs9geeNY3bstqKouYoJr5KiPrk8AxeBdxxxv6QWJtoAOXr26OqM
uGkZqYemfYjsfb8fS6Yix4NsXNfDDGU5NpHuzaoBZgbzKHZsCXYB4YYWOzX2vOE/
7TzVOLSBy/sbjDxjclVrwMvbxz9JU+j//9wn4qU49fqI3IVOq8yOa+D2jZTHOrJN
v0X6H5YQzDGtOwsPSPQIeCAxXeqvwBCmUsN65AlfVd6NHld4x/yuiXvezOqrobjn
eVxK3nv9C88dJUO40pmTUBCe5P/rXFQk5NcSffby6hGUbz3UuCA=
=SEhD
-----END PGP SIGNATURE-----

--h13GW2gLSV2TxsNR--
