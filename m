Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC59B35832C
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Apr 2021 14:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhDHMWM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Apr 2021 08:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhDHMWM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Apr 2021 08:22:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B27C061760;
        Thu,  8 Apr 2021 05:22:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s15so2165705edd.4;
        Thu, 08 Apr 2021 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ewXZDbO+lofZshX2mvAG5TBsNDxJClGoP7Khy+TeWyk=;
        b=cr96ODvH5Ek/TPl7mYRA2q0JdJHFD573E4u+E20U1oQdzkj00omj7PF87M8QpONalM
         v7tI3wxUfFYfK3REbPfjc7gUm5A96SB5gvQjAkw+exnYYE/G8ovuFJmWxgsRaHvCGmOf
         0cMFJ9nQpA67Ky21my7Yw4ozmcmt/o6Zv9Rbzl4GES4ylhc5bfyfj5kRgUe6XkAXLf+P
         BU96S8lIsSoxxBoUTbzIT6yiaX7pY80iiHrM9RoRLixkkreuCsnFlDDn/7VbTOkrCz+t
         xNT157LF1ZVWStOVenCEQudzLSv+AG76oJrHD3jcoJjw63BQBUnLXi989QLujCakfn+b
         VgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ewXZDbO+lofZshX2mvAG5TBsNDxJClGoP7Khy+TeWyk=;
        b=aW8BkseKdBLf3Foc0qmvO+Dlg3KIIODdeqDCnqUavSL/jO/C54juXDcWSkAmcKD9NC
         Shq+hxgw/xyH3Xz7f8Bot+tu+gzJf3RNWpLwSJhkM+Iwv4fpjN6s6dUnmjk6wq542Jzv
         iqm6hhcXYEt/r49foFvErYMXL4Yk9tSiAZ6YxFB38xtf5tViB1JX9siUP40IXVMbkNmm
         73hjeQklCqPfljAnFiWzGgFjDKPxUxJIxslykCl3NRxCGy9CEQENdRjmmoHelT/9/FUE
         QOoeD23htSGzPXD/BwgAkZOSnSpLclMSl8rpzQDeSslYaCvYU07FVZgHbiylHMutxuDr
         FwGA==
X-Gm-Message-State: AOAM532On/R93JA/2K13XFRmePD6oVz+bTjQoVL9eprM9zrxl9ras7K4
        NKOj+z/hnHuZEalVqjh6pac=
X-Google-Smtp-Source: ABdhPJwAvLZIiD5nV0GNtHRV3kFQIvPC2jt67gNiS5hkZ1OLAfCNNF+wUGtUJ5rcEVBSBRzlnVWP2g==
X-Received: by 2002:a05:6402:2786:: with SMTP id b6mr11040047ede.310.1617884520129;
        Thu, 08 Apr 2021 05:22:00 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id jo12sm6237584ejb.52.2021.04.08.05.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 05:21:57 -0700 (PDT)
Date:   Thu, 8 Apr 2021 14:22:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        devicetree@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <YG71iGoLHDxNgke4@orome.fritz.box>
References: <20210212131910.557581-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210212131910.557581-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210212164144.wcvy7jkxmrysqxux@pengutronix.de>
 <20210407231548.4paov2fb33cpxxui@toshiba.co.jp>
 <20210408075920.rfrcqxec2yvepj3y@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rsLTBQx3T/K0yoyF"
Content-Disposition: inline
In-Reply-To: <20210408075920.rfrcqxec2yvepj3y@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rsLTBQx3T/K0yoyF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 08, 2021 at 09:59:20AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Nobuhiro,
>=20
> On Thu, Apr 08, 2021 at 08:15:48AM +0900, Nobuhiro Iwamatsu wrote:
> > > > +	/*
> > > > +	 * pwmc is a 2-bit divider for the input clock running at 1 MHz.
> > > > +	 * When the settings of the PWM are modified, the new values are =
shadowed in hardware until
> > > > +	 * the period register (PCSR) is written and the currently runnin=
g period is completed. This
> > > > +	 * way the hardware switches atomically from the old setting to t=
he new.
> > > > +	 * Also, disabling the hardware completes the currently running p=
eriod and keeps the output
> > > > +	 * at low level at all times.
> > >=20
> > > Did you just copy my optimal description or is your hardware really t=
hat
> > > nice?
> >=20
> > Yes, this hardware works as you wrote.
> > And I added about the state if the sinnal when this hardware disabled.
> >=20
> > >=20
> > > Do you know scripts/checkpatch.pl? I bet it will tell you to limit yo=
ur
> > > lines to approx. 80 chars where sensible.
> >=20
> > Yes, I know. I ran scripts/checkpatch.pl before send patch.
> > I understand that the number of characters per line has been changed to
> > 100 characters. Does the pwm driver recommend 80 characters?
>=20
> For free-text comments I'd still recommend 80, yes. For code lines I'd
> be indeed more lax, as a line break in function calls reduces readability.

Let's not start making any special rules. It becomes impossible for
anyone to keep track of those. If checkpatch doesn't complain for
comments that exceed 80 characters, I will not reject based on that.

Thierry

--rsLTBQx3T/K0yoyF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBu9YUACgkQ3SOs138+
s6F3gw/+IiJCGh0xj4FlXY2ZbCmanxbp4xUiktkuEcB/PuD2pWjgD9JZ9kexACAI
37AQR8DeJk0T6tsWSBixumda/QjaDPDuzEmsAA/Y1aRK3WrLRM2LZZ63tnsnPE4o
/Rt3gqceqZphYndTY8LC/plK0BZNDwkFKkAOYpdK3fgWgdh6nOsdB7IgC4ua/LKY
Hsfrnd3TPvlKj7ty8cA7E8ujaFh8kvySLLC0XMAJ/Yv0SPDYjI5Tr1SBwTfiaiUB
T5vI6TWHqflQ9JsXSfWLWuhKj0g10KDcyK0nwjbgtxIk7CkjCs/RGpOKhmNAiakK
v1dYr6zLnY4GpFAY9IRN8IQ36s0ffu/l47Ouj0xa6qkoDMvURDmcy4UZU3/QnRLa
M9rMcwyMDsaQV5uQxeV5gXrycLWDIvujFNRcOZFQgLXZZdIp1aLuo/mRGD0fRvQE
qHSo9S+njIlEBkXWhSiqxz4X6JhWh0375kmewF2W+leiPBPpQJWo6uGtWwyEmApV
pcxlaAHGSiftyvfZTZpkuVUP0l2MmVX8yKmeOIgqaPHB2sMwpPRXZ+8is1JMXgiE
oMnh7AMqzbALVZmphrV/NRlDZYAaBSdB2M+zrFMwxSfheQzSkB7ljGBaPUgZ6veR
OmSMD+UKFhUKCW51Y0aHWpCUyWTYsR5b3FqMDweBiOEu43JA7Bk=
=iqAX
-----END PGP SIGNATURE-----

--rsLTBQx3T/K0yoyF--
