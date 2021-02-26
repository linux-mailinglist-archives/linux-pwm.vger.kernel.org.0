Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79832326234
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Feb 2021 12:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhBZLzh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Feb 2021 06:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBZLzf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Feb 2021 06:55:35 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBACC061574
        for <linux-pwm@vger.kernel.org>; Fri, 26 Feb 2021 03:54:54 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a18so102354wrc.13
        for <linux-pwm@vger.kernel.org>; Fri, 26 Feb 2021 03:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xgJvxs+cTuwBcQ4S/EfUPEjsHJrfCxUPLyTxUA+Uog4=;
        b=NfEyVVdwTX4SIEGHWo2Gqs5RybsAMor7lnLEclNEBGp7grO0wnRdDc3vWLmTqMktHG
         GfMmGYllUEB+8oUe8JA4L8cKjrH1RPgAxxJCJIBGGA3owmzvdfD5oqUL8uqrM76/lSAt
         9J9ui/yNkhqavKvKRBPpinnaxwWU/dB2fwkV1LTCJD19eUu4JShHcUZ0zYycacxd5sv9
         ePDbiiuC8HAjLtqT3ImrIDfWjNybtWTRm5/ViH5Iz92VMZYuLdEI292ckqQvqaK75PeC
         YznekEWLpqDCJSiV0q/Cp7CUT3gjTHrnOOCJE1BP3car0PksuVQMBMxXhVsVg2jW2DS5
         LCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xgJvxs+cTuwBcQ4S/EfUPEjsHJrfCxUPLyTxUA+Uog4=;
        b=bst5IULdI+aq2WixA6rQmxvMtA8PnqB58VpggotK1metlsuoYyIscZ3biBshH3wtUX
         Zq25oUKIvTfUqmd95gxq8j3+tsUztiv415byLW5MvfYHazWwiFTBWO6rhRdRWgxwDHr0
         HM1Kz6Fr5phi9r+2QHiR3SWcgcZaKHqB5Qzgkyd80LxLPJcbYy258HWgq7Rsny7/XZ8I
         jMcpURMyGil0XkMOIvSw/KlmVrchujsi5hnk90BDYmfivxFOgug45oiSLbB54M0HQ92N
         F8bw9c+3+YDKip7p7lrd6TwJsf/A4epTM+DoKSJSlr+cZh/zxY95vhLm6oNbALf+kxCq
         TnHQ==
X-Gm-Message-State: AOAM532LpHMyZKyJSwpQDLvUlPwgKgU5uulojHBXMGK8VFMWbQXKH845
        0zyxegJHqKUw+wj4LDEGLF8=
X-Google-Smtp-Source: ABdhPJwbLER+NzwlUpYilFtE9k8xIjiLVNRHJ3uN4hWfypCkITmO8J4cM9K1DRnOUBiPy+xK3+bJpA==
X-Received: by 2002:a5d:6446:: with SMTP id d6mr2846721wrw.328.1614340493678;
        Fri, 26 Feb 2021 03:54:53 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id a21sm12768450wmb.5.2021.02.26.03.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 03:54:52 -0800 (PST)
Date:   Fri, 26 Feb 2021 12:54:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v3] pwm: bcm2835: Improve period and duty cycle
 calculation
Message-ID: <YDjhioD17ORWdo8B@ulmo.localdomain>
References: <20210114204804.143892-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mjJEOos20gd61Z8O"
Content-Disposition: inline
In-Reply-To: <20210114204804.143892-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mjJEOos20gd61Z8O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2021 at 09:48:04PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> With an input clk rate bigger than 2000000000, scaler would have been
> zero which then would have resulted in a division by zero.
>=20
> Also the originally implemented algorithm divided by the result of a
> division. This nearly always looses precision. Consider a requested period
> of 1000000 ns. With an input clock frequency of 32786885 Hz the hardware
> was configured with an actual period of 983869.007 ns (PERIOD =3D 32258)
> while the hardware can provide 1000003.508 ns (PERIOD =3D 32787).
> And note if the input clock frequency was 32786886 Hz instead, the hardwa=
re
> was configured to 1016656.477 ns (PERIOD =3D 33333) while the optimal
> setting results in 1000003.477 ns (PERIOD =3D 32787).
>=20
> This patch implements proper range checking and only divides once for
> the calculation of period (and similar for duty_cycle).
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> changes since v2 (Message-Id:
> 20201222221319.2101107-1-u.kleine-koenig@pengutronix.de):
>=20
>  - Add my calculation to the comment explaining the max_period formula
>    as discussed with Lino.
>=20
> Best regards
> Uwe
>=20
>  drivers/pwm/pwm-bcm2835.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)

Florian, Lino,

care to give a Reviewed-by and/or Tested-by on this?

Thierry

--mjJEOos20gd61Z8O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmA44YkACgkQ3SOs138+
s6GvmRAAg/MwrKFmWGNnR+J7wdmSsdIXb/yTOrDmgmPve0o72tVgjT8z2fUSH12J
WLrZ2tVedcbex2ykDhFI9D50cBBH5ZNqV/xaDxqpYSksKial8bNXn0C6slxQGz/S
txcpIi2Y/QOIbi7YyA4Fp1rkHd1e2S+322Yj6CDorG+/KQH64nRJ3R6MteR7YW/E
m9new6hYla2tD5cHI3oyZCcmv4yxvH7zKGvWt4+wqhASljRz+3dhkGfQhFhst1r7
CszOKKgl+yCnlNd0ZTIfYzQA4a7IaqH3/POmUvnbQ+d2uTqStxQOE0YosrUGh2sX
0cB5oxO/IATZRUZgeTfjwnDGocs+c4tZXgesW8hT0bw/t50iH0ckXfo6v9EF2kgQ
lUn4CZ/3zpJpTs6h5LAhlTaNLB1s0KfoouoHYP7lvxoyntgi52vmvSPcSIu8ivJ4
q/djnO1MtpAS0RvV7fAx6hUAckcyl6L4/BwQJ09JXySoBaVkzpvFn4KBrDv8a1Ci
npOlcogMoqd20/snel4r1aPWCmlAIFLbC7eBG5YOrp2zhZHCTpkuFHAIES23HKDs
GG7eA/GK3YFQB9dJmLlDikdaV0JfbfqhEBhnFXst72UPFs+3ObcOt7HKKjsnXWI/
paZL9xfoHNHId6OypuMhXo62JHlnvKRuahjW+xNRD4c2kddbEd4=
=poCz
-----END PGP SIGNATURE-----

--mjJEOos20gd61Z8O--
