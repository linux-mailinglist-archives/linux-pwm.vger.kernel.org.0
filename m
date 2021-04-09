Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082B1359FB3
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 15:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhDINVT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 09:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDINVT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 09:21:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1A7C061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 06:21:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g17so5859390ejp.8
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WAfveGKV6yULMvKEE8nqmA8Vmt8gfTz4NRDWjj1HDqA=;
        b=etZ3AAHP77EqFWWCUUZ2SQO41ADLquHvAde8PoQwa6Mrx2bEHhm+8XU2kpju8nUm60
         bZaYEiFBETAGiC5gs2o5fNfawL1CUN66Y5ljQ9GWBsiO6x1pYxLu546wWlt6bS6Mxaxj
         hS7Sk10BqoI8FcPeBewYuzKJCcM6tfbbRFdHS/HrwvOjLqw1d16r5Ceib9wz+PsDqHGT
         4s13BwPE5ZGeCKP0Ha2pHmBDHIpyRZhQ1pMFdiich0yEid8/Yvpg2FG5dwQqK05ek+qA
         tfYavyHrYaD9lTJFhWJ4XdhwR8cDNhABw7riU3+7WuUIJ/4bPkUU59+S1TxVa6cuqijA
         pdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WAfveGKV6yULMvKEE8nqmA8Vmt8gfTz4NRDWjj1HDqA=;
        b=YeocfarR7jFBDEgdIwJDTpPKrLcisV1cx0/zXVNqkxAstbt6AdpSkjkNj7ZEuWPCUf
         7XPGEetXFi5nkbNS3o5VaVIGswGKstkNiJe0AlAIwCH/T328zdOb+LxdpCds3ujdPvRn
         sZqahiLYIvP5R9JjHL3HFIRzk7ZbUxHk6bosdHKMsZWGpB2POC5aJe1quG9iZ5lUudWD
         B9j2vt+dNndxCVr5Ep6wndQRsaDZat6auMoPMSixTM6igdWSAoz0wWeX+BDCSj2ko+Eh
         7yyI7Q2VH3nPVEv2uAXMJkyHYYWHsCfofYaQ6uFFKMR056SxJT3nLIqo9BZ/YgWBalYb
         2PMA==
X-Gm-Message-State: AOAM532PyZ8mBumr/6O/y/rK7pTZCtqPnTGhRulCiC7ESPDIQgBLOgg0
        hcF8CehGBWFMgL8JA7tzzaE=
X-Google-Smtp-Source: ABdhPJzmGDitI8zqs6/1gD9/MHv3uV+lacXtfyaFHJubgSSu8QmKHsCpcw0Vxe77catO40jiNYOb3g==
X-Received: by 2002:a17:906:1284:: with SMTP id k4mr15543974ejb.409.1617974465143;
        Fri, 09 Apr 2021 06:21:05 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id bq18sm1228477ejb.27.2021.04.09.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 06:21:03 -0700 (PDT)
Date:   Fri, 9 Apr 2021 15:21:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/3] pwm: lpss: Don't modify HW state in .remove callback
Message-ID: <YHBU5MqK+vjTGwio@orome.fritz.box>
References: <20210407080155.55004-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Aj+db4ssYyl4mKJr"
Content-Disposition: inline
In-Reply-To: <20210407080155.55004-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Aj+db4ssYyl4mKJr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 10:01:53AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> A consumer is expected to disable a PWM before calling pwm_put(). And if
> they didn't there is hopefully a good reason (or the consumer needs
> fixing). Also if disabling an enabled PWM was the right thing to do,
> this should better be done in the framework instead of in each low level
> driver.
>=20
> So drop the hardware modification from the .remove() callback.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-lpss.c | 6 ------
>  1 file changed, 6 deletions(-)

Applied, thanks.

Thierry

--Aj+db4ssYyl4mKJr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwVOQACgkQ3SOs138+
s6F9bhAAp/Ydf9TuejXtfnCiYIuFbQuiAC0Z5K93PRDNORuuCo56I0LZQcCgQuPM
rpLj+3PSIBLgLFNU/2rJtowrD0Rp4WLVzTw3XXaIHC168SV/tdWttdElcnI2Kmr8
eZFblU7ZdYfVlGuKUT95GuIkGtWb9VXjR175y2XsF/S+AXPOoZBvIGDkg3YV3fbH
NiSZZK+oIhUPc8M2KloZWIYE/cu9wi3/vf6JfhWe5hiLf+j9FPMzJcGImSAUrlev
6JG9rNcdwBSWfG4XCU0CZ7kSa+1xou3Ieesh9X05RNGm3GxcoSJ5wgvFfzExRLnp
NPn7gBpgVTVKBwuURZ//8a1c/enROlwCioC1szC0HjUrjxmka1Te5OJX4+N1WQBc
VGyku61SlIxtgAAHjl/6oWgKZwJM2vm7ic/Wk4vp/pAW3edySUYu2FI9WSRUauku
/MCT2SPQGHj+FAliALnDVg75boF/P4eDdQ+S0mcN+UmTtEDD2UujxQsj4zJRWEFP
N17s2LfKtyH7s9ZdfR6MuX1MWmtPwfVwAdipPJqzm1cxUWR1E/hIcHGdcXS5++PI
u4XNS44/BOhbHdJe8j/kdr1m9BOwb+zGbrTdl7h9x/oSGE0wFYrvDPuvvvG99VCn
2i2+UvfjYI/yFsLRiqQOgqvJ6lcxL/NQujKnbUyi4Zfy387xwyk=
=TmqK
-----END PGP SIGNATURE-----

--Aj+db4ssYyl4mKJr--
