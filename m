Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEDA35E28D
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 17:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346552AbhDMPVc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhDMPVb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Apr 2021 11:21:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A13C061574;
        Tue, 13 Apr 2021 08:21:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 18so19884040edx.3;
        Tue, 13 Apr 2021 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9J3TXndvIULj3WAZLGbE3ugc9ArzX8JjLTHybcxDjc4=;
        b=CuNah4ZK4moASJGCrTJPzX6e3r7OxjfMdSrxWLCMvfTSCP0T11NHw3dALbKCGYUS3K
         DZn/wteiPjKltZQU/Vt/wySi5bTNY2k81UMkfO2Yo38vyYB8fzmVUjvGWOaqrO2pNrFT
         Rflqbz93aJ69i/77xbLNVJgzm5TKvOPhX8dMyi1gecobZVSEPhmAR+chn++VCswPvqDh
         /zRzXXyC6CGtDdgkB7X98vDCZQMVqSIyC+asOYW0XtpGAZbJyx12onGZjnZba1AoqK2k
         nb46qAp3GcHxvtsToNvt12g741XjkfkfLyGwS4mC71G7EGIXDihfYuoXaJmg1ugVXjDU
         fjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9J3TXndvIULj3WAZLGbE3ugc9ArzX8JjLTHybcxDjc4=;
        b=WCZhgbnubevfMXb7STNgKLIiXkSAGFXLEK4GRXFmSZreLueaXkrCW1tlea2bxamaN7
         t18i9UkUJojndITdCDSWLa6fxRKV/Of7OSCtahpNoCtFjPiU6zZD382GbIpiWXZ57WCp
         zNNR+jWKCmGGhBGvbEsSdP9WYAAwVvzvxhSBjzTjLX6D1gZKDjUeOxYvMeeVRHm/tn0G
         6nYBG1XqFEqTBcAZL84vv5MGP4ROARzZC7r6WWTD8F2gVKaSyU5o3qTPXsWOrXSRM6Ub
         3QIyp6YzLA4+o41J1A2WG8ClKW9q7mTc1fqH1vVuKka6HaoeKZOJAzBGZOqSAZuH/V3c
         quiQ==
X-Gm-Message-State: AOAM530YlmdjoOE+wKBZDOxJNl/4G+j6OgSHb/QITLtHZa1FfCViwOgT
        Y1FS9FcpzmG4eXkKKu2cAd8pJq3C840=
X-Google-Smtp-Source: ABdhPJxt5Xg16qvMSSfmRrT3ax/lsuy7w1rKcX9+TTamA1Z0wsuc7X1qXwvelnXFMYbmGWfchNaPog==
X-Received: by 2002:a50:f40a:: with SMTP id r10mr35884651edm.200.1618327270259;
        Tue, 13 Apr 2021 08:21:10 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id h24sm8172014ejl.9.2021.04.13.08.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:21:08 -0700 (PDT)
Date:   Tue, 13 Apr 2021 17:21:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Johan Jonker <jbx6244@gmail.com>, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: pwm: convert pwm-rockchip.txt to YAML
Message-ID: <YHW3DYjr2ifBltVk@orome.fritz.box>
References: <20210412200155.5316-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5lcH8ISxRT1ADI6c"
Content-Disposition: inline
In-Reply-To: <20210412200155.5316-1-jbx6244@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5lcH8ISxRT1ADI6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 10:01:52PM +0200, Johan Jonker wrote:
> Current dts files with 'pwm' nodes are manually verified.
> In order to automate this process pwm-rockchip.txt
> has to be converted to yaml.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
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
>  .../devicetree/bindings/pwm/pwm-rockchip.txt       | 27 -------
>  .../devicetree/bindings/pwm/pwm-rockchip.yaml      | 88 ++++++++++++++++=
++++++
>  2 files changed, 88 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.ya=
ml

Heiko, do you want to pick up patches 1 & 2 into your tree along with 3 & 4=
? If so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--5lcH8ISxRT1ADI6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmB1twoACgkQ3SOs138+
s6EInA//Qhd5kjNrJ7CIBfxAtCNmeqCKe/InIgxFdKwoUuUj5DaXIRLkaTquMCOP
HLUUaHvlrD7bVWWh9RJncCgxbcBBx9q8xtBYC+mXpeSZIZL1rEURUDt0ZOAoPffS
fKtneDEROOcmFz5kvmfcKXvl978cc0UYRFdmjfULzIWUpf+uFaFR0UNfbfoKSORC
l7fdAlDlLvIKirzsqFULwTUPGww6ronyF9iy0Xd8gSPEx/z0TGdAZgIscoFzEkvg
rrkWQZutZlVetD0+GNNn9cyZk7aeG+uAsQnusQRqgDreLwte0sJXWud47uElwHO0
3ITmY4wZ7GxwmmpgqDVZAB8HxOezXolwemasxV3nzO5gMPFoAXNXoBVina4SLcnp
FdDsUgJcsHXC30Bynd3+B2DUVlTWEZvMso7CnQRg+ljXARS8eyk6QaiHHTZ42Gb0
0YZqM+uI82AyabHreSVROiuk4ENMZtqjMKLYbF6o0Dy2VXM8CI5hPqnXitEqpqtZ
/fxJ++aVGpOMdLUpDN9F6X6K6z104C0atlZjj7/Egk1zFxUwA8vLozSEe+KDgvaH
+8TC0c2/RR5rHjTBgYFaMHReXI5O2e/94SH3x7luIaO17nGfAwcn9kJD7jKWgeyt
EEO7abYq4hiwEu5/bO4FroIxDXEprb+7HlDrt7OdAtPyZ6QXsBA=
=rjAb
-----END PGP SIGNATURE-----

--5lcH8ISxRT1ADI6c--
