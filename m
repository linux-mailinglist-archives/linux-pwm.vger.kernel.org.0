Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8BD12DE93
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2019 15:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfE2Ni4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 May 2019 09:38:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37599 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfE2Niz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 May 2019 09:38:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id h1so1831058wro.4;
        Wed, 29 May 2019 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jSrBZNGmV6jSazZzUaL4foqcMtygn3G6S1noPTGa1cI=;
        b=PSJ2FMY7dypFMIALSJEc834zF140gzCGJ57jT8Oq47V12bnpjh+3BU5AU4MOdnBuCx
         sjccucAYpdvmk4P6Q+TLMFNZksc/4ntVYPc8X+V7AS7T7Nj+TIjZP3GJiriQ9Svc9+Y0
         UEcvZa1mfyuEz2zQwZHumN2D1sZKwarDQyknvBSNVdKNxJGarNGGdJ7E56DL0WFd9xD2
         1yUlCQrDqjMM/lOGxhvR8qBVlZVHRDQK8f4yzIKCzlqtp+o3BJI+Jb0Ai/AARS9BhhA8
         t1NqB2gsEfYaI7VxnJNdGSRH3C5/HYJj3HpWc1SD5Zknv+/WBCMpzKeYPOXWwKtZ5RUZ
         +w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jSrBZNGmV6jSazZzUaL4foqcMtygn3G6S1noPTGa1cI=;
        b=fvPNTPvJT2BzRvSMJZg6aV9P7/zvbuv9b1Xz008dOiAhn01sO5LsQBcjhUp4bQb2m3
         5DO70SA9zyuprwZ9OUChxzyILweTuU48k+jGP0bFYA5V6pXhhV0H3emcUrDNaGDT1CaS
         ZannlOZ6G13B+YrgUqU+yoUjbN8xsVJ6GmUdEjCBm595bi5iGQprDYtH2WXLlrdDBugO
         CeodMf3pgkL5PC8O4uNQcZAOCYKKCrf1Sr6FVWasgo0hPAHXKGsXsJ5JKBnoO/X0CexJ
         rkoU4SjEuZJQeLMUrvQYUU4zNdhKdw0gpI/CDVSNDRdmLWFN6vz3Ijh3Wc2KB5Deenmh
         PWWA==
X-Gm-Message-State: APjAAAXKcKSQfEPjj45WFwleb51LmohQ4LLAYE1ZsRSQhi9h/AKkdHzZ
        yGCzLPgAxcCt1OXbDfJKsMg=
X-Google-Smtp-Source: APXvYqwfq9ObIt6hIz023yWu1fAhfoP4pKt6Qa0WAFNLWuPajBBwy5Rxt9wzz9CKb3H9GK8IZmGg7w==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr9550060wro.253.1559137129084;
        Wed, 29 May 2019 06:38:49 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id r2sm6688580wma.26.2019.05.29.06.38.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 06:38:48 -0700 (PDT)
Date:   Wed, 29 May 2019 15:38:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 4/4] pwm: rcar: Remove suspend/resume support
Message-ID: <20190529133847.GC17223@ulmo>
References: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559116082-9851-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <1559116082-9851-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2019 at 04:48:02PM +0900, Yoshihiro Shimoda wrote:
> According to the Documentation/pwm.txt, all PWM consumers should
> implement power management instead of the PWM driver. So, this
> patch removes suspend/resume support.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pwm/pwm-rcar.c | 39 ---------------------------------------
>  1 file changed, 39 deletions(-)

Yes, I like that very much. =3D)

Thierry

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzui2cACgkQ3SOs138+
s6GxmA/+POUfNHliQaqlcfEfhelIVyhekxNxRXbU+EAM/lAVh2ivDi/xE5UfTRcw
vwRBet4rcu0U7kMC5k45eMBCnNqtLC8Ilv90EQp30cJpk9iMXMAmEtrvwJSD8Nmq
XcphkdPV8ZZ4cTIXorAnboVyZ5/jzFqXvkfzIW+9GjjjXyEZaPk1ZVNVzFHJdbYs
SeTW3Ikhb5HswIPjrwVwp046a/tCrSW12dH5e17jrS+9FLRmN165KGJHmVi8YsN7
PNWKd87fO69jHgFnM4J+zNcVdWr5Eugk57Ij2awj6kiYFq+PTkTEP6mr11wkbkkU
iXVkG+6M23v084NincQMX9lDhwzyE+DAo8iw1luFz/uCUprPGv8U1wReYGwbWQsK
b8DEeOaQdlZkjorEkMfWTgVvFmHsix7ksu1Y24Dp/8MYCfbdy1deP/YHV8BBEBTJ
TSaRfL3B/bIPAuzugL3gQaSeP1M9JX6DkIvgw3SGEiPTn98fpDLwINjdD2sq2K9y
XqnHjUtsVHnvhL+wJUFKWls/tBoYtIXyuJzTnVFq5MfI/srqNqnVbuh9Dtr+fgrj
lWujP0jn/ewiaVnHqGkG1J9DHSRAW2giXMlx1/oj9Y3O2xeCpYHfYHJm9xTHngex
kRsTENOz7wmIp11h2facbqiK7YACd+Nv1vylYXXpcAosCIpZfQA=
=mRY/
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
