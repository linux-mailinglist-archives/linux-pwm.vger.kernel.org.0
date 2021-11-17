Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B46454ABC
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 17:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhKQQRU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 11:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbhKQQRT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 11:17:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2BBC061570
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 08:14:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u1so5679075wru.13
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 08:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=srr7bO9b5LF54CBHF4QZtXrjWfFr+rvKXEFW+il5EdU=;
        b=MZ1llpWhOZFe7a4Lqyo/91PmtR2Eifouhcp8gZNgvH3aZnfy0181mXMyJA46Ezv8EK
         hFuCUteBd4d+Z/mzJALHpaL82bTLXwL07CyV3WBNZLfy3zbEiSCtQc4cL7Uf2LN6WYhI
         +1MzKVy2Q6tGnNGrMrhyFK0I6P4bS2x7MqKBWR2DMxx8bbSiGMk5W0OwJcvFZ9Cjrnt/
         DXembnPVfCNI30Sz7ikN2RMQ7VnBxbtIBkFHXUGw1VQxZv9jXNL7ieVAxPCyJyAn7kbY
         O4kdiSO5rTZNhRZVFV83lRG7eqhzAdWzqiykRwGNFSasWrGIK+Ditn52BAnZyYNcuSIo
         yd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=srr7bO9b5LF54CBHF4QZtXrjWfFr+rvKXEFW+il5EdU=;
        b=8LqlvQPK6fYVmZXBYLQ8Y6pctL43RzIUXFSxf4DGtEiquDpRYU/fMqprzuoBJHtJGm
         9AbIkV96JrrOFqN1s3hhaacOBHsWLTVia9O66GxL07lQ2kG30QuwNbwZ7YUm1YymuVtn
         gDc3mipFbh91JSm2aM5zhKhZICpku4B9mmsjR6jol5ZSGt8g2NQrBTUZm43Wzgi9RAcS
         pba3vicKNixcFGFi8lmJqYesQuDedxQtA+ucAzGTyHFwbab9rIIJFBhhcw0avcuAX8RY
         Cs7vyolkY0acs3OtZDhDECSU936bKWCrDDmVfo3Mvo+YG84w7vLnd8Cgl9HSdvHM//p2
         Endg==
X-Gm-Message-State: AOAM530qVtuty53eh+jwkGynf0hvEGVhPS/22hGA74vs7R8uF9ViAspM
        nooSVSPLMYjM+IsV0veJo6Q8lVPpn74kCQ==
X-Google-Smtp-Source: ABdhPJwpNc8/txplNwiBGFhfyUwOPH3aovQ8ATfBboFRbwfdPEFC5ur1U67ISaAe2oTGEIbFEAQFWw==
X-Received: by 2002:adf:d20e:: with SMTP id j14mr21489623wrh.220.1637165659300;
        Wed, 17 Nov 2021 08:14:19 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id u6sm125804wmc.29.2021.11.17.08.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 08:14:17 -0800 (PST)
Date:   Wed, 17 Nov 2021 17:14:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] pwm: twl: Implement .apply() callback
Message-ID: <YZUqV8/afBEDOQOX@orome.fritz.box>
References: <20211028100942.161170-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RvqDBfrSIKlWJFp2"
Content-Disposition: inline
In-Reply-To: <20211028100942.161170-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--RvqDBfrSIKlWJFp2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 28, 2021 at 12:09:42PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply(). This just pushes down a slightly
> optimized variant of how legacy drivers are handled in the core.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-twl.c | 62 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 8 deletions(-)

Applied, thanks.

Thierry

--RvqDBfrSIKlWJFp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGVKlcACgkQ3SOs138+
s6EHNA/9FZsVDoEDXMGuTwQzYi0YA14lIrEeZtd7KOpUYcG4M3xQJCIj78y4suVQ
gFed5Y8imJFDzIIS7TUZBJC63D1GgG4u2XxghF4DYcSrH+pBJPUnkdls8mkctGZe
iNPUt5vLLZNZwltYXzLHmYqrSkLO6epklc/lkokj/y2hsyKVKrA8EdQPB9vlobt3
xYWvvDZFs6rA4VbSNLkUNFpxJdvNshUISXjyM6FTch59FgqWc9oTnw4IIX/Sis6z
x45B0M2uBQuNKwyFOlsQw8JQgA6DCFCX9r074LJJJKcddDKF2PD9cPn04UNf+I3P
ybwX4PTzAbd2s8PE1WfDNtRT8V0ey/qWFEm9DMvvJ4VKAEIO/4L+NFYjqfSfOBKv
s9VHEwIFEhIlaAk+yd16BWPWDAbkOb6sz5p1jrhjHaChMA8oel4XltEG/IRw6cNM
fx9B/5GjvmxPGXfxF9mGLO/Kw95ik+FOe6A2cq88OX+tz7UhgCH6ksQI+fhnqHWi
euHfsH4tW7kRfwCorhGThm78FFb+itZpLOMOyMO62RB9lvhC00+g0cievU/VSO+q
6LavQI6r2R70T21pVQAiNdRIOUBo1H00cGjxJ/D75rbj8gTB4OMMvOQ+VamAIpP6
ybSXlYBzGycv5Y03TISXbU+uyWRcMv9bq31GlvkGG0iUb3jFTi0=
=Nilt
-----END PGP SIGNATURE-----

--RvqDBfrSIKlWJFp2--
