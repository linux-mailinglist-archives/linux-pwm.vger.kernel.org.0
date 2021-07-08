Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F653C14D6
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jul 2021 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhGHOH0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Jul 2021 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhGHOH0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Jul 2021 10:07:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073A9C061574
        for <linux-pwm@vger.kernel.org>; Thu,  8 Jul 2021 07:04:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d2so7750037wrn.0
        for <linux-pwm@vger.kernel.org>; Thu, 08 Jul 2021 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a01QX8Ra7l6Lk+bStrWox6dG6ZTplnvrMyWoELNw3gk=;
        b=XgOWIr6Qo3l28bNf3cqsIgQ/YCFTj5l5uuXrWLo0r7gSja1fRsHHZFrmG5wmH7qmhC
         os9tB2BAWjIGUm2YiVwbiuhBVYeNJR0Z4VjGHoZAre1sy4avtYSAgLzA+6RBHfS8ckce
         MN62vhk8HW8uQDSmfhRZ1GZp/XamG/HzSkeLjNxmDN4iTyNwd8R92FPIVo9mdat+2a7f
         MdAwosxM2f577aqDXWyHwRGzTvdwCtpu74A8CP9acAwjJ4uLvBRgvPeWHQH2GEo2FMQn
         aJ2wo3+0mNd1J8/uo/nRYoEIBThPIp5PkrQRqNARc8W9Z1KFgBP1iigaAH/NNm7EUkI2
         eFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a01QX8Ra7l6Lk+bStrWox6dG6ZTplnvrMyWoELNw3gk=;
        b=qX0G10+Aq/Kwoz6J8nNlzWLv6Ldl2GAn6gvmXAH/zxz12fl/Zpn9oi2Itir8M6k+aF
         RAX6xkuKp4ZUU8Be77t/FM6p/4frdZrMjfR3mT4nLoHNdtddooZjahx3n6q7sGYLrVv7
         fgYRs46LxG6HVPqO+VzQe9Bw18ee73TQYex2P+/9bV2Tgh6JwuxVX9f0Jw6RySCZh/K5
         PDCFNTPAHpG68ouGULkifMBu2IKcmHyOQLPbVoBARm74BjgYeB+Vc7szw17ZPLyMrti2
         irQMwnj9w1pZvPFUXwP/vuze/wSiZVStz7hRFM6T3GS7JqMDLg6s16ZRbq1R4oYBM9g1
         a0gw==
X-Gm-Message-State: AOAM5302HhvlNV+c5gtScJTcilWY/amcm5jbnU2APJMXppJexKC0GrNb
        L1sL/04E3pM7RWDw29jxzMQ=
X-Google-Smtp-Source: ABdhPJxMNxi/oTAV3tNClOEfBMRTVqlWqFt3pdaXtbcMdLEG0yHyJiN1WJ9HRixAvLeq2icFn2VIhw==
X-Received: by 2002:a5d:44c1:: with SMTP id z1mr2287042wrr.205.1625753082420;
        Thu, 08 Jul 2021 07:04:42 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c9sm2295436wrx.22.2021.07.08.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 07:04:41 -0700 (PDT)
Date:   Thu, 8 Jul 2021 16:07:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Baolin Wang <baolin.wang@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>, kernel@pengutronix.de,
        Orson Zhai <orsonzhai@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH 0/5] pwm: Ensure configuring period and duty_cycle isn't
 wrongly skipped
Message-ID: <YOcGkoQ4jb0G92Iz@orome.fritz.box>
References: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
 <20210708123639.vrck33kc534yrnsq@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xn818NBth8lR75UR"
Content-Disposition: inline
In-Reply-To: <20210708123639.vrck33kc534yrnsq@pengutronix.de>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Xn818NBth8lR75UR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 08, 2021 at 02:36:39PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Jul 01, 2021 at 10:27:50AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Geert Uytterhoeven found a regression in one of my patches. The same
> > problem exists in several further commits. The respective drivers are
> > fixed in this series.
> >=20
> > The affected commits for the first patch is already in v5.4, so this
> > patch should maybe backported to stable.
> > The others are in Thierry's for-next branch only.
>=20
> These four broken patches were now included in your pull request to
> Linus for v5.14-rc1 but these fixes were not. I wonder that the
> regression Geert reported made you back out the offending commit but you
> didn't care for the four identical problems in pwm-spear, pwm-tiecap,
> pwm-berlin and pwm-ep93xx. Did you miss this series?

Ugh... this is a nice big mess now. In retrospect I should've just
backed out all those patches. Or rather not have applied them in the
first place until they got a Tested-by.

I'll pull in this series and will send this as a follow-up pull request.

Thierry

--Xn818NBth8lR75UR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDnBo8ACgkQ3SOs138+
s6G31g/9Fa5nkB5hqk1D/WSDGHHWX+ZshZdfDJJhHOxDzTO4VrcoRkFZLJPdr/wB
Gfd2nU2KSBJQ7tmVAfpSXHRfvxmmb5yWXxFOCxgelg4ZVzL+FDsriQFoBrpwxnS7
mZvr4WP78dqQuUnHSz7ywe1r7vYJ4wGOgqqNe+snYVnck9B/Zwbgwfrm5W/S3lgk
+ayu1awzcr+pWJ1pEXW7dl4uff4tax9onG6MlK53lJIYhFDJcv1BcXQ+Ptt9YU4Q
a1skiSrfKcG7LAj7IXy2IVKUop7DsnvYcpjSbx16n0R8qOOJSeX/zSYDMwhQao7E
Mi52UsNmHvd8nDa1yeMp6HdbKCvqqwTzvtm94784aEZAnwpApD/v0Fx220zTbmro
Jnb1G7RVBwOaobM35o/M7whLMfoIdwXmxVJmR/iBor6CMwkceyxeXC67EDzjdWWZ
cwrU62hOUeba7iykwtuyAKnwRw9cWH5lV8UXIBDbcbtjDGMQkG7UiQYa/ilFiUzS
4O+Jdo3Okre6v09G+eoWBRsTkWvarhPIjbaW+ZCDidwrRmt4oPGFSOW5ACSRgfdV
vkePIAZmiVFwuh7iyHXXRMeeG8wT8S+38kljjBHe2rzcpahwhFkviPDn7DtPRLj+
yhj9387+2mb0BROL3ZsHU51QE6ullpgeZyGrLaqvEW4R1Lqbp5s=
=q1HM
-----END PGP SIGNATURE-----

--Xn818NBth8lR75UR--
