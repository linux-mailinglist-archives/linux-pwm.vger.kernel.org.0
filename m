Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4CD0197DCC
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 16:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgC3OEa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 10:04:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54499 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgC3OEa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 10:04:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id c81so20057273wmd.4;
        Mon, 30 Mar 2020 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fl3BVLXonVpFeS4JDgqJNcZPAm6d1lEewyk/bRtn/ro=;
        b=X6M7GKC0r6xJjIIPTJtZGZZwnL4HRFY9BfElz+7JA/YbNyIZV9yzVvrbK/AP9pebSY
         K6ZmUXSZgpobxY6zNynlax144JyDDP7S4LYDiWLk4HWUUQNmNH21jYRQY6iB42UJylP7
         uTVCt+Q6DDP+yztYjfbvQa1hZLUKdqXP+Lfm052Ca0vIXokx6eVxOKEY0PgH6eNRt9HY
         D2unMEQuPeqcaVQrApL8NPRcGsipiVAeQm2fzekQ6limDGgz7hfr6fw+IjYduhaM/+tZ
         OchlRWManrPej0p9PS6HGW2Duv3Ttq+c3l23vdyVfHxjJYuvKk/Ocmy1UPJuD1xEx9t2
         4hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fl3BVLXonVpFeS4JDgqJNcZPAm6d1lEewyk/bRtn/ro=;
        b=gwBTSCy8+g2rqaPCEiZs/wGx48zOMUz+4oNQIgLgIaLAXo04hUVSJanSDPFE9mh6hW
         TJBUahf1PaIBOlyqPpkLtoMV1m3/hZLyGh/XIadICJhr1BYnIlcQEFwxq0LmeO4/42PK
         BB2MqRFYqvYeEdM/YrWBasaedSCKLR0yvbMlASpXUcFS8yLZsjOcc19E4hBkErdPVPJE
         TCsK+iRyrVup2UbOQaXWTs6qe2QlLpdWd+wr8IKS7cddnv7uBk+BVPYmZ4Tf3yGaXLcw
         jii/cW5iK6uqys3cKDngauN1UZuNSqYVytlwOuOCFuv8sPxybT50ABdd2OBW+I8WRyio
         mt9Q==
X-Gm-Message-State: ANhLgQ2TFB/mJnNOWjGTIz25yGxlKZTnK2tvPvaHtJvVsaOQnGAHA2Pp
        gCNgre4f+Ne3NliuyQhrwzlEDzGh
X-Google-Smtp-Source: ADFU+vufah8pOE4mseBF8yvDSwUNcaMkNyP7lIZ3hqnBHQ+jQNBn8gzECWnxILxmALfuYBIc9KzgQw==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr13223344wmf.35.1585577067399;
        Mon, 30 Mar 2020 07:04:27 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id w66sm21519140wma.38.2020.03.30.07.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 07:04:25 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:04:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 0/5] pwm: omap-dmtimer: Allow for dynamic pwm period
 updates
Message-ID: <20200330140423.GF2431644@ulmo>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <09dac13d-44b0-80c6-fdbb-54bfc6f48e36@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <09dac13d-44b0-80c6-fdbb-54bfc6f48e36@ti.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2020 at 05:00:13PM +0530, Lokesh Vutla wrote:
> Hi All,
>=20
> On 12/03/20 9:52 AM, Lokesh Vutla wrote:
> > This series fixes minor issues in config callback and allows for on the
> > fly updates for pwm period and duty cycle. This is mainly intended to
> > allow pwm omap dmtimer to be used for generating a 1PPS signal that can=
 be
> > syncronized to PTP clock in CPTS module available in AM335x and AM57xx =
SoCs.
> >=20
> > Series depends on the following series:
> > - https://patchwork.kernel.org/patch/11379875/
> > - https://patchwork.kernel.org/project/linux-omap/list/?series=3D251691
>=20
> Gentle ping on this series :) The above dependencies are merged into time=
r tree
> and below is the immutable branch:
>=20
> https://git.linaro.org/people/dlezcano/linux.git/log/?h=3Dtimers/drivers/=
timer-ti-dm

I've pulled in the above branch into the PWM tree and applied your
series on top.

Thanks,
Thierry

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B/GUACgkQ3SOs138+
s6FvOA/9Gr3hcoCrG6rJzKPDh9OZhNjoRSw02ZKI8wgR62o5OYcs8bUR+7RuFMie
4IPrbHIuN+3AlJnNW3692BLEWc63qXa6dKV9a/C+GkAZcRDwSmHid6qgtGgoYrVY
zzDi5AI4FxWn5o8THICTf1tGZcNWYl6/yA1Pww8Cwzp9DNt4Fr/5+1seICFVRNFR
D/U209f361OwuppU5Q0dOccSsYfNs1t6Ej3gXlk82qdKwpAyjR1h1rkwjUMFxAUs
bUXMgOezWwlc5AT5zZlNAL38Xhm16zzBf5SdILIndj1znVvM8SFGwVJmBNFm6DjB
mjiY3ySqQOzRVZJX4d+tMJi5uQx3LrqJQsXOKNRxO1d9azRJHGWBhap00jCsw/Nb
WSAek8uE4vMcWMnk9EfqWSQvD+8aw0Xd/Z0eaegflK9BPivdIEafqVNTVJ5cf+BK
Nbqj4Pr+uqVzPZQDfL/sKx5BdgyG3wPoCr1VZNpAeZrzNg1YnLeQgIlxTi5hE4Ay
2Z/IudEMftbK1d/8JGhBtw1y6VZ4/yONbnWyQGNsxShdR0VUCKe+33VQxxYFTNy+
mccl5NI51zODEuS8DBv3HH16KUri+RE7vFych0L7Ouwv8/kvdchjx6iBRWKey3Oa
LG5De04F6662oEXnkaD+L9gNMW5ilDLUnW+pOpqrKkUuIcZ/aTE=
=1Yxb
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
