Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783E044533E
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Nov 2021 13:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhKDMrt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Nov 2021 08:47:49 -0400
Received: from www.zeus03.de ([194.117.254.33]:47406 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKDMrq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 4 Nov 2021 08:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=+kTKuWi1KBJCz7hjSDpP2i1Qo+Q+
        ZWQgJdDBSE4IGf4=; b=Ib9IJhAxcjX5AwnXZqEGcWEJd7yKE7PxCVonshEjvWt8
        uigEBGE6rC5lyyZE0wte/wqCCup9nM91W9ELGXHut7XaBdufpIoewFW8eSeY3TJ5
        lIXvWMdK8wmWU5/O4q7xrN4YLvIT3VGyX9u7XhAUao1e2OzoFbY4aUVdSExQuw8=
Received: (qmail 81302 invoked from network); 4 Nov 2021 13:45:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Nov 2021 13:45:06 +0100
X-UD-Smtp-Session: l3s3148p1@Qm1j5fXP+owgAwDPXxEYAC+KuIjTJuUc
Date:   Thu, 4 Nov 2021 13:45:04 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car V3U device tree bindings
Message-ID: <YYPV0PVC9dwnxG1I@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Rob Herring <robh@kernel.org>
References: <8ec1e2aadfc894a3cc8c412e266b87220fa0404e.1635337616.git.geert+renesas@glider.be>
 <20211029160303.lv6je33mjr6zk7xh@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eeNA7lFuO6FAma0L"
Content-Disposition: inline
In-Reply-To: <20211029160303.lv6je33mjr6zk7xh@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--eeNA7lFuO6FAma0L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 29, 2021 at 06:03:03PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Oct 27, 2021 at 02:28:09PM +0200, Geert Uytterhoeven wrote:
> > From: Duc Nguyen <duc.nguyen.ub@renesas.com>
> >=20
> > Add device tree bindings for TPU with the PWM controller found
> > on R-Car V3U SoCs.
> >=20
> > Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> From PWM POV:
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Uwe, thanks for the ack. Do such changes go via the PWM tree usually?


--eeNA7lFuO6FAma0L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmGD1dAACgkQFA3kzBSg
KbaSmw//Yw6nDwRIQX2Uz7fKhBz2/BwvGHMm0fBCHBag29vYaNHE+QW1U3DrSThy
5UUcFdiiGX+YsV4kJx5CXEoY4y1dH0Jo/GefsRw/1Tte9wZpkK1cjSW1tmA8mXPp
tse1BebtCbrTttyaoiL+dZ628/LXSg2F7KzxDTTak3J17IYlIkUZCSsWKdoz23Ez
/k995yHySr8SHJxP+Ifk0jdzBhU2TzDsKR2Z8rNpseCCxZzaNs/LJBj9sORqAzf4
e7g3SzXRy+8upYgEcoErfe4SweAcXw3ep5foRY/mJQ5q73TqSLby91JVRjc6h8oW
cb6T+nVp0QHU+QC3k6aOnZHXITIzPEz3OibZhjijz5QONGP8Wr9gmpYcS7udsWfp
2lqhgEN1Rwm5xf8OWEiOGyDHPuVi100L0CflYAdLOUeEL2LJpXLcRM4FK8thrca2
U12OU3WAn6Ao+HK3QTUtgogn26ZyutYMG59JsQPZOF+7oVw2Ja2jipjF+qIZrydU
mg715Q5uPQ2SFbYwQtPT25nyTy9SsfLSna+l97jB82l1g1lbMkOrwMOPTaDXmXF5
gJ1jIFLQdrfw1zKfUd9qYnhE1tuqHawtx1bOcQshFMyN/7pCVKTyEbzZ6pC4MXJS
PTxTtAatCTeCzBrR3sFqzMajpDOgtPR6XGwwedJ+7N8uc1kh1Ak=
=eDH1
-----END PGP SIGNATURE-----

--eeNA7lFuO6FAma0L--
