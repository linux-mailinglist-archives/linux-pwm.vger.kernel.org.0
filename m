Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68BD1146B
	for <lists+linux-pwm@lfdr.de>; Thu,  2 May 2019 09:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEBHn0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 May 2019 03:43:26 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39641 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfEBHnZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 May 2019 03:43:25 -0400
X-Originating-IP: 90.88.149.145
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A683E1C0016;
        Thu,  2 May 2019 07:43:21 +0000 (UTC)
Date:   Thu, 2 May 2019 09:43:21 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, thierry.reding@gmail.com,
        lee.jones@linaro.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [RESEND][PATCH v3 6/6] drm/atmel-hclcdc: revert shift by 8
Message-ID: <20190502074321.6g26negwuqdjswrx@flea>
References: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
 <1556195748-11106-7-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6uagg5yh6vlrxpcb"
Content-Disposition: inline
In-Reply-To: <1556195748-11106-7-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6uagg5yh6vlrxpcb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 25, 2019 at 12:36:39PM +0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>
> Revert shift by 8 of state->base.alpha. This introduced regresion
> on planes.
>
> Fixes: 7f73c10b256b ("drm/atmel-hclcdc: Convert to the new generic alpha property")
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6uagg5yh6vlrxpcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMqfmQAKCRDj7w1vZxhR
xcseAP4vdJgH1hul/wM47RFdoRnyzZFVdLXER2Iuq1hWJ+PK0gEAtTag2QpyiY56
rGojbjlWkUYDM93h+BP6r0Fj5J5+4Q0=
=yTPE
-----END PGP SIGNATURE-----

--6uagg5yh6vlrxpcb--
