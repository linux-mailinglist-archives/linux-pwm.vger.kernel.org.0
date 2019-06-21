Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C834E25A
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2019 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFUItf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Jun 2019 04:49:35 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:55196 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFUItf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Jun 2019 04:49:35 -0400
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 918953AB48C
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2019 07:59:42 +0000 (UTC)
X-Originating-IP: 90.88.16.156
Received: from localhost (aaubervilliers-681-1-41-156.w90-88.abo.wanadoo.fr [90.88.16.156])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7A99D1C0005;
        Fri, 21 Jun 2019 07:59:34 +0000 (UTC)
Date:   Fri, 21 Jun 2019 09:59:34 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pwm: Convert Allwinner PWM to a schema
Message-ID: <20190621075934.dytb5ruv4gefgrmc@flea>
References: <20190516120848.25007-1-maxime.ripard@bootlin.com>
 <20190607111838.xlx74cvcfhaob3wf@flea>
 <20190614091433.xac42w3n7cx7buh6@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="62wdhr4nif6wvnvt"
Content-Disposition: inline
In-Reply-To: <20190614091433.xac42w3n7cx7buh6@flea>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--62wdhr4nif6wvnvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2019 at 11:14:33AM +0200, Maxime Ripard wrote:
> On Fri, Jun 07, 2019 at 01:18:38PM +0200, Maxime Ripard wrote:
> > On Thu, May 16, 2019 at 02:08:48PM +0200, Maxime Ripard wrote:
> > > The Allwinner SoCs have a PWM controller supported in Linux, with a
> > > matching Device Tree binding.
> > >
> > > Now that we have the DT validation in place, let's convert the device tree
> > > bindings for that controller over to a YAML schemas.
> > >
> > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > Ping?
>
> Anyone? Should I just go ahead and merge it through the sunxi tree?

Applied.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--62wdhr4nif6wvnvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQyOZQAKCRDj7w1vZxhR
xaoyAQDllw8NhQOREnODoAZvZn4YVeHtSyaUFs5GhVlJ9E8P2gEApIXSQcNFUihO
w01NbKzMlqQawHGtoNJdlW/lOxaBgA0=
=8Zfy
-----END PGP SIGNATURE-----

--62wdhr4nif6wvnvt--
