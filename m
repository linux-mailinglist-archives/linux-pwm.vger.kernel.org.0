Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739AB35E290
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 17:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346572AbhDMPWB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhDMPWB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Apr 2021 11:22:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C42C061574;
        Tue, 13 Apr 2021 08:21:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id x12so5775071ejc.1;
        Tue, 13 Apr 2021 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wvbsjDeEfoTWhufFQPq2eN6uA9+l1g6dk9+RKZ4L6GQ=;
        b=UqxNfWhTNKnA82WzHIc5GDXXEfEB8N6TyZSzfiG6HymVxX7aqr9WdTyFqNC8A+Speq
         KXkOU3W34B6Dp4yQaCE60bmpRDlvAxyertWxs8dVBOI+Jf1iWmG8yHzqWZVoN2Cj2Hc6
         N+eCCuR3833yiTUbTExQpC6XElN9Y41mG+PK6odJFOKY22ofaCKlO5d4zyiRRJyE8Mhr
         /1crW6vxfkRYSZP431EEDJkyPyb9Fagy+VBuS2rIxXNCbi7sdOLFug0dUHf+/WGDfc9T
         UN8aE4Gqllci+f4+tnyYuA7lISwjvYSSO9bWli8PjoWuX/nE0M1iCKzuLRbkLSGSYMRN
         JJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wvbsjDeEfoTWhufFQPq2eN6uA9+l1g6dk9+RKZ4L6GQ=;
        b=DmIzufPbdpFV/WZ28ludwS74+I3awlur3GyWLl5MmzEh4LwdzqAu0Xyj4Hw3R39jFd
         pJs/gTkKClU7uzkirwlWTflKjNqLBI2H36tgRJhfGDzFxh65ohlnpBY1moYwJBILfpIJ
         ogEgm/nb8QxzPKBRXzFq/GbfjwQi04Z71cmS/GuoKOCSMD9EvWs/tdri42GNbjfOq4Z6
         mkUiQJArpE/wALl0gLwEa6gM1lKyWBUIX0M96ysTvj9oDkLlCRxGiz2mG+IixXfF+Jhf
         GQIv7JxEB/UeGlVtkChMAb7pzNp7dTKHGuKTYOP4e1NDZB/fwXsppwKGPhiy2Ge0xEkz
         ELNA==
X-Gm-Message-State: AOAM530nfcMjxlL5Ozeek4uJIs+IvUKYxUF6U6Dr/1aBjIWgiW5EGAwu
        GP5zZMYaE+yX/8YEocqSMIU=
X-Google-Smtp-Source: ABdhPJzESd66N75pQj5J9ADwovRTRCyUJiyF4dmRuIV7i5fV7fbM2KXMBtILXKdcsbsyZh6UZmI2jg==
X-Received: by 2002:a17:907:e8a:: with SMTP id ho10mr13119638ejc.110.1618327298123;
        Tue, 13 Apr 2021 08:21:38 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id q12sm8365263ejy.91.2021.04.13.08.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:21:35 -0700 (PDT)
Date:   Tue, 13 Apr 2021 17:22:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: pwm: add more compatible strings to
 pwm-rockchip.yaml
Message-ID: <YHW3KFN8zCZBAhS3@orome.fritz.box>
References: <20210412200155.5316-1-jbx6244@gmail.com>
 <20210412200155.5316-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Br5dDdxMYaQS0SvZ"
Content-Disposition: inline
In-Reply-To: <20210412200155.5316-2-jbx6244@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Br5dDdxMYaQS0SvZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 10:01:53PM +0200, Johan Jonker wrote:
> The compatible strings below are already in use in the Rockchip
> dtsi files, but were somehow never added to a document, so add
>=20
> "rockchip,rk3328-pwm"
>=20
> "rockchip,rk3036-pwm", "rockchip,rk2928-pwm"
>=20
> "rockchip,rk3368-pwm", "rockchip,rk3288-pwm"
> "rockchip,rk3399-pwm", "rockchip,rk3288-pwm"
>=20
> "rockchip,px30-pwm", "rockchip,rk3328-pwm"
> "rockchip,rk3308-pwm", "rockchip,rk3328-pwm"
>=20
> for pwm nodes to pwm-rockchip.yaml.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Note for rob+dt:
> A tag was not added on purpose, because by the change of schema
> for clocks and clock-names I add "rockchip,rk3328-pwm" to
> the "if:", so strictly speaking V1 and (V2) V3 will not be the same.
> Please have a look at it again.
>=20
> For some SoC nodes this patch serie generates notifications
> for undocumented "interrupts" properties shared between
> PWM channels till there is consensus of what to do with it or
> someone makes a solution for the whole PWM block.
>=20
> Changed V3:
>   fix mistake with compatibles introduced in V2
> Changed V2:
>   changed schema for clocks and clock-names
> ---
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--Br5dDdxMYaQS0SvZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmB1tygACgkQ3SOs138+
s6Exkw//W7Ns3sxaY7TE0CKgghe3adkn7JPz+/mZQq0UGlGSbEGz4URJi8vu7B9o
imzT131spMO5DgpQ1GOdy34fNXDzPPIr/wnCug4XoylyGrrPyvNEGNafmL5mBV8P
Yhsz2Hygfd9g/JzudisGaoNr5+tDHdj4HIOnO/MfqehzjLoHCojGCdSJ1cK4TnFn
cf5mD0wVpWotutxUmEXM4RghqbWK2spHqQS/+Zvgcme+YUyy+0VcWrXMexVuDyj9
i5RTCi4cIlYTSf3glVRNA7FKaBzuOiE8BCEwXUu3MBK6/WBgdGF+bRnNQX/MfRGh
56q/dI0QvuAc7+cugjUzvSN9pvWTlaxrGJPtRbvrrPUW29n1XAT9tmFHV2arTonE
3zcizATvTBZJq3P1jl1r3icWaWZVHCNQ+MFpxcFbOzPHlO1DK9KWXfUEXqmF9y9b
XwKy2tr3QdjKR22j67DAi8VZuX64iMt8Y1pYFXr7L3Arzawbd+pZxW+X91bjkKgO
eLuwXOjadWBFX48A1WHDeU8XNZTE5Zc1hAzdW01/e7fSIWNXRIsehJI5BbRb/5IK
OcwdSRbJYcq6HySeM4gXjF8HfZt1SZBo8CRQKTrp/Tvl8vWGSAhMPtoGfIVjMSCN
jJ9Hzk0+/AgGz16GVBqmzl0rM2ZNGnRrU0WDiyl2nY5CIBZEeaU=
=hFd8
-----END PGP SIGNATURE-----

--Br5dDdxMYaQS0SvZ--
