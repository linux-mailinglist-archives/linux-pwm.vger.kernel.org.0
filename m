Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A66288836
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Oct 2020 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388308AbgJIMCo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Oct 2020 08:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388304AbgJIMCo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Oct 2020 08:02:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE2AC0613D2;
        Fri,  9 Oct 2020 05:02:44 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t25so12629755ejd.13;
        Fri, 09 Oct 2020 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zolN42psdma9cgyAkYUk4jF1xLz7WxwwG5U5VW/benQ=;
        b=YfbEAEboe0LlibywYsM/2e1qf+oxGBVKypANBwYng7mBjrhtYCtROcCmXsFbvhD4gR
         GKSRsQGFfBnhdQcST9MR2IygYyPwQmfEJPdhFh9WOaz7RT2lZhNoaTm/ocoAc4C9yVy3
         MEHk/ZrTaSq97VnaPY5Z4IowxWg4LXANXmEf6M8Id8fUj6FjoicFuiREIbssZNX41t2o
         NPWZHzsEu0rgPIPTJG4c9tIDWuHDaQ9pCb67B6eAosqlACPc1pfm1U+Vxmz0EKg+0BN0
         3uWcqgS4vGs+XxhH9I4GNgGg1l0tIDzZELsqg23s/Q2sJcZoIO1+FrCs9rzlylh2xxAO
         Ym4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zolN42psdma9cgyAkYUk4jF1xLz7WxwwG5U5VW/benQ=;
        b=kI0OYAo6j0ECDkOC+i348vrywenrMMFDJRjp2VLmhTaD19az+V6GcF6vUltv9CFcpD
         K4nH1I00ol7Mdyz+6vVRnZe2d70AD7JcLAFApsIbpguyt86opbhv+zJWLQ3i5Met0QQc
         h0fiknnRVlqNOvEK5cRzqr0yXp8Ms3lR65BQifUN3eswIubm5fy5ads2V6MDuIrO1oo1
         4grY+5Y4YEuLoFBx5kY3Ikn1OVtnqs43ArlElnFCzb96ooAVejRzhzNGeYURGll5NQ83
         DaFPHL/kspEcCno/AUVLneLcC/rviT8FH7SNubww/fE6ISBDHQbtrUpFLo5J9OQ07irK
         SOFQ==
X-Gm-Message-State: AOAM532jZw6v0zsiVsYiwYah5OMRYuaWZc//pF9CeyhTe9HBQPQ/G42F
        j3Fj6zLRocBaVKZu+VJm93w=
X-Google-Smtp-Source: ABdhPJyOOtJoZI+kdY3U7L8qipzhH3999ed2szrahFoKOii/NYr+woIDNUnOd1bDjNRyeni9sZXXWA==
X-Received: by 2002:a17:906:f11:: with SMTP id z17mr14335685eji.88.1602244962713;
        Fri, 09 Oct 2020 05:02:42 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id h26sm20991edr.71.2020.10.09.05.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 05:02:41 -0700 (PDT)
Date:   Fri, 9 Oct 2020 14:02:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: imx: document i.MX compatibles
Message-ID: <20201009120239.GA450876@ulmo>
References: <20200925212609.23093-1-krzk@kernel.org>
 <20200926132217.xr3rhv7o2o2yc2l7@pengutronix.de>
 <20200926134157.GA4730@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20200926134157.GA4730@kozik-lap>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2020 at 03:41:57PM +0200, Krzysztof Kozlowski wrote:
> On Sat, Sep 26, 2020 at 03:22:17PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Fri, Sep 25, 2020 at 11:26:09PM +0200, Krzysztof Kozlowski wrote:
> > > Document all ARMv5, ARMv6 and ARMv7 i.MX compatibles to fix dtbs_check
> > > warnings like:
> > >=20
> > >   arch/arm/boot/dts/imx6dl-colibri-eval-v3.dt.yaml: pwm@2080000: comp=
atible:0:
> > >     'fsl,imx6q-pwm' is not one of ['fsl,imx8mm-pwm', 'fsl,imx8mn-pwm'=
, 'fsl,imx8mp-pwm', 'fsl,imx8mq-pwm']
> > >=20
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Doc=
umentation/devicetree/bindings/pwm/imx-pwm.yaml
> > > index 473863eb67e5..379d693889f6 100644
> > > --- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > > +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > > @@ -25,6 +25,17 @@ properties:
> > >            - fsl,imx27-pwm
> > >        - items:
> > >            - enum:
> > > +              - fsl,imx25-pwm
> >=20
> > The driver actually used fsl,imx27-pwm to bind ...
>=20
> Yes, most of i.MX drivers use only few compatibles but DTSes and
> bindings use multiple of them.  I was convinced during various talks
> that the specific compatibles (so "fsl,imx6q-pwm, fsl,imx27-pwm") are
> preferred than generic ones (so only "fsl,imx27-pwm"). NXP took it
> to the another level creating compatibles for absolutely every flavor of
> their CPU. And they mainlined it in DTSes...
>=20
> The PWM is this crazy examples where, as you say, only two compatibles
> are actually used for binding but DTSes uses more.

Yeah, these new compatible strings all seem to be used in the kernel, so
we might as well document them.

That said, I did want to apply this patch, but that fails. Am I missing
some other patch that you have sent out that touches this file? Actually
it looks like this is because you've based this patch on linux-next, or
perhaps the devicetree tree, because that contains commit d058717bdff4
("dt-bindings: pwm: imx-pwm: Add i.MX 8M compatibles") from you that
adds a couple more compatible strings. Probably best for Rob to pick
this up, then:

Acked-by: Thierry Reding <treding@nvidia.com>

Rob, here's a patchwork link for you if you need one:

	https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20200925212=
609.23093-1-krzk@kernel.org/

Although, looking at the devicetree-bindings instance version of that
patch, I see that it's got a failing check attached (which looks like
it can be ignored) and it's marked "Changes Requested", but no comments
saying so.

Not sure if you want anything done here?

Thierry

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+AUV0ACgkQ3SOs138+
s6GruA//Q7r7bNJZL47x1vSaTR4zkcAYsKCuqYy6PqiK0Q6pBhnqexL/uIoWYnBY
5DIdnKQ5pvqothENJqYdE2shjDPiryZRUGxWK/49r5GijYFHYaVaohcRG2uPOYeA
yETDTXkXAnU0iJntJ6Vpn8FI38GOHThVPJLZ+MCsEVz4FLWtUpKWjHA8EIPhuLpB
6S/N1q1HZYiSUYwp6lAusxQ3Vjt+miVapKPib9U70sBfUi8ay3aaZPoYQlCp4/PW
o05A3xZ5805jWfESWnQPFaQdeV742LttOI5RKxhAabj0SC9vOKycSp6xC12K9pH5
O60NFmbJLSm8jush3Wcy/6CrqHyXwEtbArxHf39sb2bGwVqWNrgjZ6o/O96Qv0dy
EF0yZ+1XgPaVujtRGS/wa4moO7T6MaqxnJE6/CsTGnwBtLRg0qXTenzvP00TSptT
lS/qNG2+qsCIkOpcJmiHjJVNHVWfPvHfIbapXYs9nixF5YBuPnB1nJiqRIUQW5kA
51X4WlrXfcxyX6HQt8/OucDqfUpIgP1tXW6rzmtGYZnx+QQWdsFwFHuX0OAXWNlO
f38ix6JcF7YX1iV9tCs+OlrQq0Dc9JQrOwrEd1Q0SBX8T2NcWw269DOVwQOYoEO7
gpbc6UNU5cd6Br6PSbY2ccD7X1vu3VZ6G7EQOcMXh5Eyzzp1LdU=
=AcBK
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
