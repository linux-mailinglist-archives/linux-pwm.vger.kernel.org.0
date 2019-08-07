Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E51284DC5
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2019 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbfHGNmj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Aug 2019 09:42:39 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39790 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388240AbfHGNmj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Aug 2019 09:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565185356; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CvI8uuzE+21wxEtHyLQrI51AvG7nuR1f7KgsKc2uCrg=;
        b=lM28tysqbPWGQ2QJkKwHHeFuU/i3GMpG7PmPu+Ed62V/KJMjdA+g8VW+OThUkd35WGqY/W
        egYs4Z4GlF7ycEK5P/Ky2HFqZTO+lWIlhsEbEyhWae/v4A+Fc/Rwc6Ln5IWUSnPiZvchzw
        oHLlH9AIrY0MFzTnUwil6fRJEWcgeNU=
Date:   Wed, 07 Aug 2019 15:42:31 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] pwm: jz4740: document known limitations
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Message-Id: <1565185351.1834.0@crapouillou.net>
In-Reply-To: <20190730123229.31839-1-u.kleine-koenig@pengutronix.de>
References: <1564435163.6633.4@crapouillou.net>
        <20190730123229.31839-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le mar. 30 juil. 2019 =E0 14:32, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> The jz4740 PMW implementation doesn't fulfill the (up to now
> insufficiently documented) requirements of the PWM API. At least
> document them in the driver.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> I intended to also add a Link to the reference manual, Paul suggested=20
> to
> use https://zcrc.me/~paul/jz_docs/ in December last year, but this
> stopped to work.
>=20
> The second item is something I noticed when reading through the=20
> manual,
> but it's not confirmed in practise. A test that this is indeed the=20
> case
> could be done by configuring a long period (say 5s) and a (in
> comparison) small duty-cycle (say 1s). If the pwm output isn't active
> when the call returns I'd consider this proven.
>=20
> @Paul: would you mind doing this test?

You're correct. I configured it for 4s period and 2s duty. After=20
enabling the
PWM, it stays LOW for two seconds then switches HIGH for two seconds.

That can be corrected, though, by inverting the configured polarity=20
when the
PWM is running and set "period - duty" as the duty value. I can make a=20
patch
for that.

Cheers,
-Paul


> Best regards
> Uwe
>=20
>  drivers/pwm/pwm-jz4740.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index f901e8a0d33d..9d444d012f92 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -2,6 +2,11 @@
>  /*
>   *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
>   *  JZ4740 platform PWM support
> + *
> + * Limitations:
> + * - The .apply callback doesn't complete the currently running=20
> period before
> + *   reconfiguring the hardware.
> + * - Each period starts with the inactive part.
>   */
>=20
>  #include <linux/clk.h>
> --
> 2.20.1
>=20

=

