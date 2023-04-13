Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A536E0A49
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 11:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDMJbF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjDMJbE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 05:31:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F1E974C
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:30:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dm2so35933453ejc.8
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681378251; x=1683970251;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlR6NW5IPBzcMgReKzwvOtDlZExqaWBBvnEqQ+ThfZM=;
        b=Q8rklRGj2ndKzVsFbkNqBc4nFZrdWi75eiFarJ5QAf90EZVhxmRzGrmhUc5zPNuR3R
         5qXQfxZdC0yeDyzl5xot9uzTWE2q3HQtW8mAzh7XAcpa+pRglH7Upmi3qqLRFk7aOl16
         6xXjMoGNd+pBQGq7vqbwNJ6odf9WJLBp4gw7kGIrtJacv+BE/dukCRAtXHFFBLe/9wzc
         zK3k4sS7MbVMZDkYFpDgPhykbze4pMqPNU6vbMPCsF81VTHiJLg9gvUaVv0+pGpgO5+o
         JUT1WbF6Gwt3rsL+m8e4sLIo001LVcazkTI5cWONbQdFa6oljOmpaico4JFsI6vM7dIE
         vDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681378251; x=1683970251;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlR6NW5IPBzcMgReKzwvOtDlZExqaWBBvnEqQ+ThfZM=;
        b=Mor27BXyHJwJp2s0JIPdw9eMwz4z2lXtJgLg3P3g3YdjNG/tORkna/eX1hGbbbol/z
         eUhBFxIrAb5AAiLkTfQ9zm/Wak6X5Gw7+6eU57bWizzniL63sPKj6mS4j2Sd3JJXS0sR
         i9/3WsihkKpZGySWnrqYZrpQu6D1OWvE5gkTRd3u3zX+cvoD5HOcvJ3qng2flZFPYn5f
         NUoGodGwa+7Gv0eg8fdfrbvjxoAJoovg2aapm1tbO5HGeeFR4PpOedllKa5i7qMI32y0
         wr+HONAwa3yZPhtGk9jYxLpvzST7FZtYd0AeZc5zZ2OjyH8oQWBygmAuxBcyWEulfE8f
         crNw==
X-Gm-Message-State: AAQBX9fqxXvemi/UVB7u9KJia5Fxl8UbUrE726v7XVltxUtwCgJ6xybd
        pOh1JjYItI2Qf2HKdkSznKZq5wh865E=
X-Google-Smtp-Source: AKy350YT3jTFe5I/+roGVV0ZlP066VWB64duVX/+fhvxdUKcURNAFlDA45EPrhA0n4sIwMjZcZKNqw==
X-Received: by 2002:a17:907:a78a:b0:94a:44ee:68d7 with SMTP id vx10-20020a170907a78a00b0094a44ee68d7mr2141727ejc.72.1681378250752;
        Thu, 13 Apr 2023 02:30:50 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090603c100b00882f9130eafsm701769eja.26.2023.04.13.02.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 02:30:50 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:30:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Delete deprecated functions pwm_request() and
 pwm_free()
Message-ID: <ZDfLyP5bP0PdBS1J@orome>
References: <20230412115636.3533366-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5NXKMnslX8by0fOS"
Content-Disposition: inline
In-Reply-To: <20230412115636.3533366-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5NXKMnslX8by0fOS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 01:56:36PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Since commit 5a7fbe452ad9 ("backlight: pwm_bl: Drop support for legacy PWM
> probing") the last user of pwm_request() and pwm_free() is gone. So remove
> these functions that were deprecated over 10 years ago in commit
> 8138d2ddbcca ("pwm: Add table-based lookup for static mappings").
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/driver-api/pwm.rst | 13 ++++-----
>  drivers/pwm/core.c               | 49 --------------------------------
>  include/linux/pwm.h              | 13 ---------
>  3 files changed, 5 insertions(+), 70 deletions(-)

There seem to be two more occurrences of pwm_free() in
drivers/pwm/core.c, but I think they can trivially be replaced by
pwm_put(). I can do that while applying, but let me know if you don't
agree.

Thierry

--5NXKMnslX8by0fOS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQ3y8gACgkQ3SOs138+
s6ElgQ/+JVAgst/I8A4zyaZpWQMFt0uvscli7IoO6zGCRWaSBDRSZtfaHbD3DLRX
MqbuKd3+YzMzXpkhnHMJll99d56MVLcjy2ifWb7DRD0eH85YKtQ4WHH2mpCWyZWj
dKF17y7Mam4O8QLU9pLl5PvoOJIPlY51unmcliRtbyqcZaMSzvP6b73Rm6/O+gQT
K66ti+1gFs9RXnyrPifx8xzuRbRg75lXXpJbU1se4VIOtSPtqdMXkgguFUCzJHke
hHS/i9wirt6bknNkMqezUnH3d2s0VKDR+Ml3LKAI2WRjGDi1MgxztQIqju18vAUZ
l3qtoS5TBbCAsavIP+uInFDIwkDVQN7FyJnJrcs8xREFORPEyPgggfjz2Ry8H33I
HrCjF2aJ3h1oT0JHFOfkGwRMwIRR+ZuiMOG8YEbIlHyZS6Duf8WcixIv9ps/1m11
kvgeyVNhQlerszH8qFNUD81X6byYghlk6Z9NnGIrwgAIURth0CCQ3548FCpg81sF
aFpbMxfoq1oiarmjVXQsDns1cRsWRwati/cWX2L+rEnvt/FGJE/3BUWdlqVxoyKh
9glhpFftFGMRnxXvHelFCshvDz4yK/7m0sFezK2ma9BGzQi/azQIimM7onhGuj44
wcVMd/kBdep2HOPFE4ukXUz7HitBBL47bxVbxnJmYgOM6FbavpQ=
=VtB5
-----END PGP SIGNATURE-----

--5NXKMnslX8by0fOS--
