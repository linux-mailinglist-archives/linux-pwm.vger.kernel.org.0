Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1342A3C2
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Oct 2021 14:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbhJLMEU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Oct 2021 08:04:20 -0400
Received: from www.zeus03.de ([194.117.254.33]:42948 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236282AbhJLMET (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 12 Oct 2021 08:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=swnIN0Vy8h2ui1QuoJpRo/wj4mII
        f+e6qODbS8r12RE=; b=FcTVqPXpG6KFMsO2wAfMeRmaA4VtOUrgd+qE2I7XXqxM
        MT/TLxQ1JGhbTlFHCOcBaogxjTIHFylbmqvr7Usk9La34tay0sF46FPzrX1EnpxT
        OePROVFC9x7ClEJT1Y1eejGQQoz++EOZ64XS67VU0UuzS70lDijluqne3JUdXPg=
Received: (qmail 203684 invoked from network); 12 Oct 2021 14:02:15 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Oct 2021 14:02:15 +0200
X-UD-Smtp-Session: l3s3148p1@JQjRnSbOoLQgAwDPXw9GANTxpJbLr/qt
Date:   Tue, 12 Oct 2021 14:02:15 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car M3-W+ device tree
 bindings
Message-ID: <YWV5R1dqpvnPFim5@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20210906094536.45223-1-wsa+renesas@sang-engineering.com>
 <YTjAGLlLvUOF4eO9@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HfJVpUODR/arx7iB"
Content-Disposition: inline
In-Reply-To: <YTjAGLlLvUOF4eO9@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--HfJVpUODR/arx7iB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

> > Add device tree bindings for TPU found on R-Car M3-W+ SoCs.
> >=20
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
>=20
> Acked-by: Rob Herring <robh@kernel.org>

could you apply it, please? Looking at git history, the YAML changes
for PWM went through your tree.

Thanks and have a nice week,

   Wolfram


--HfJVpUODR/arx7iB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFleUIACgkQFA3kzBSg
KbaCvg/7B5EVyT/cL0NPbxFqhcqFGAssDR1SPUXb7bLLJc88KLM34/2Wqf/xg/Nb
xPNNJDkR7JZrghN79TWIDmfqdoLlEcHYD9zUQvSqksXB7ZJcvxk9qB58pSbVwd40
TjjwBZiVDO6qiTlrODLx/KYik24QCGxPiySi2dY/6E4klDb/IJKrZEbhxrq9sV94
msf59Qi/lXKN7guBZS3GXoX4CfoyEPMyXY1IdviB9BSYmddqvNbTWjbky7BWV66F
J+FCkL016cEBn8CZg/rcdxnrTmC//iJHQR37fAvU48JYkCa6JO5Z/awUNy1nZOID
tdS3k8cjahjwWKpiMVo837ydpHv3wDwnz1lIzZeqWWGvNmOtXIyxh7SROJufVC7A
KQ1sIGciHHgJGk3VU5nWdDhazbulWKK4ZMUyVoqZ28ehgJ3avd9esjlRW4+Y8zXQ
SxOz8os/pmyujJnyDc4UdytMYlv/PY6ZOnT6iuW/CtXQCdCEa+t4X6ALrhWTq9Ch
LL5hcz4q6bbQAccPafcneje7ZI9+b3C3fn3xQ/j+TxWy/EwN9qkx4UivJ4mUGsr6
qFnrcwi0vNu92axo91owjbaI9vPwH8sy2gH+jWroM0ZrnxA2q6Qc/F8ZDnaMpusI
mYP/LhIHQda0BGVv4L2cSWT2qVWK4Csgp8xb6iAilmLi0wE0FT8=
=kb+4
-----END PGP SIGNATURE-----

--HfJVpUODR/arx7iB--
