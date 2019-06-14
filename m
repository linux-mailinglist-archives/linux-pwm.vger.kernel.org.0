Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 558564585B
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2019 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfFNJOg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jun 2019 05:14:36 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:57303 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfFNJOg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jun 2019 05:14:36 -0400
Received: from localhost (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D8B1F240002;
        Fri, 14 Jun 2019 09:14:33 +0000 (UTC)
Date:   Fri, 14 Jun 2019 11:14:33 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pwm: Convert Allwinner PWM to a schema
Message-ID: <20190614091433.xac42w3n7cx7buh6@flea>
References: <20190516120848.25007-1-maxime.ripard@bootlin.com>
 <20190607111838.xlx74cvcfhaob3wf@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2ulork7hxmrmxe3s"
Content-Disposition: inline
In-Reply-To: <20190607111838.xlx74cvcfhaob3wf@flea>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2ulork7hxmrmxe3s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2019 at 01:18:38PM +0200, Maxime Ripard wrote:
> On Thu, May 16, 2019 at 02:08:48PM +0200, Maxime Ripard wrote:
> > The Allwinner SoCs have a PWM controller supported in Linux, with a
> > matching Device Tree binding.
> >
> > Now that we have the DT validation in place, let's convert the device tree
> > bindings for that controller over to a YAML schemas.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Ping?

Anyone? Should I just go ahead and merge it through the sunxi tree?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2ulork7hxmrmxe3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQNleQAKCRDj7w1vZxhR
xbjNAP9u2gIWLx6Xy6i2Tdwxun/a8yx08d/HSPLSI34w6E8USAD9H4mszsZNc+Uo
kU9HDUDOJN7I1BDXvlp8F8tUft9QOAE=
=aqsN
-----END PGP SIGNATURE-----

--2ulork7hxmrmxe3s--
