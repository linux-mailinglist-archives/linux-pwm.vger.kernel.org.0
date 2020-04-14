Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F6D1A7F02
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 15:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbgDNN7E (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388513AbgDNN7B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 09:59:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A97C061A0C;
        Tue, 14 Apr 2020 06:59:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a201so13685796wme.1;
        Tue, 14 Apr 2020 06:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Fwja0jTZZxHULJJjIpfSBVIH0kL/ZYNsx3rY4WniWg=;
        b=S8NeGjG7yF7hADzFixrkOxE5I3ohu1+J8/XRQeH5MakFJHk3gcePLmSDT6RRpKjFSx
         0ojnbxpZPkQl5KScZQl8XgJm0lcavf3MJEgcKy7zBW0P3U/aX3E4CRAXm2cvB2mRhqic
         nLJ4mpUXoGY6AsfI2xDN0j5Lubo1BFS8phuaF5dUUiqBuDBzy0sZe7gZ7Pa/agV9axQB
         6ACFXjJ1QAl1QPFyrqIlKXdla5US194fOE5JoH2VyjaZrIp5VvOZQax4xS/nAtCMzf3H
         1yVVaTk7gAuqVmvPx7BBGX325oC/vazj35M/XSYQQtRt7agX9k22ts8rhnzRx4IOcDJ3
         9L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Fwja0jTZZxHULJJjIpfSBVIH0kL/ZYNsx3rY4WniWg=;
        b=c4lvl80n1uv1SXaEtarkRXvb6rmlLjUZ+f4/hqloxAiWaMHMJIzfcxw6+9O065i11R
         KpitVVpzD6aOTMwNZS06Nh8K0I6C/XaEkEJFE7zs7CBZekx/bEZI0x3f4dPBj8pwxlIo
         ujUnfV1rmF/LCQlbtiXGSeTiP7ZevSqd9iHEb9F2HJFcZE9kWOkHjvkvKIfgTIqMx3v2
         ZJDxL6hfMluada5JTNDVWzIbfo0KE9JgYNoLTiU73GB5sMqlQNX5QNqj8+0JtUsUFL2b
         g+HZmbZcdZAWur9mdWZorzbuaTqHCiUI7utmxzuQsFiv+JK990n3+EotBf5SvUhBHm5C
         +i3w==
X-Gm-Message-State: AGi0PubuG5+9f6u4xNSsdjJpefjq+ZxQs/6wsya26c0Z5WSS53Q9txme
        9kNyNNepKzgtY4ujr49nAuA=
X-Google-Smtp-Source: APiQypJ9SYhb1oBz7bLLqc6vCchiGFM/jv4+fVqvUnelj4QZ+8LMbgEgAIwIEz5Ua7vmqqW2ldpPiQ==
X-Received: by 2002:a1c:7d90:: with SMTP id y138mr25373864wmc.121.1586872740016;
        Tue, 14 Apr 2020 06:59:00 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id c83sm16329703wmd.23.2020.04.14.06.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 06:58:58 -0700 (PDT)
Date:   Tue, 14 Apr 2020 15:58:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: rcar: add r8a77961 support
Message-ID: <20200414135857.GC3593749@ulmo>
References: <1586510057-31562-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <1586510057-31562-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2020 at 06:14:17PM +0900, Yoshihiro Shimoda wrote:
> Add support for r8a77961 (R-Car M3-W+).
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6VwaEACgkQ3SOs138+
s6Fe9Q//fr0nAlK4lEV73Mu5TBQST85GbYfF00kdpEgT6q9qy1T9yinF3arvJwjV
WH5+983n/26B2bNLkhF+ATUpxVIeoSetfPATFJmNtEUguBTlrpnSOJa4yFHmBzyN
cfGXRFdprtXSHV4L4qctvaWJgOcyEYQYCK6E+Z2x+seNo77C20wM9M/mPKiu8mBe
aEo48oqEvmhvEBEA4oUQydBos9yUlPEtanI7Dizwjj8ER6GY+poAR3HzRryMbCo9
mQkLkk4S5uttWAdyAnlumXzRwiNN2cOxPJBKlDTcrOXY88GvFl1ZeYRwI8YznY8J
I3Ba3drdvweftAK8Zw34OBPCXGUBmhd1ClPSKPFB0+AMud1DY4q13yv7zSJTUB5I
ScKiWFdiB9uZbPjot0Q0CNIGSylh7JYFSH+D+nklou0NkJk2/iEUiT1vr11PrOgh
B2ey8UvJI2o+Dzw1eV328EfXo+I4p1etFT4r5fgV2MDVF1rZybJ9UFEL6xSzbRVK
ArqtKyYkFogm8/sAufcAfO47QAAFTP1jM96AnCHb7eZbPOSgJFD/7+abB9qpP02L
6IgUih+xDg8ei+iilFLzMvrXcBnEeYKO1oSXXpLcuTwQVAAdSqMVhPbq2cyl+ryq
s/0zV+gfYJIL8NofnnfuwFsVBZb1eDD+3qLgcRuaqxg3owU/ccw=
=n1RL
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
