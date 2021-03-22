Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C65343FE1
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCVLcq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCVLcl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:32:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382E9C061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:32:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y124-20020a1c32820000b029010c93864955so11202455wmy.5
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQlXEU4ypD0QbO7KXWhJl2OHiJi7Ox4B8DZLV3RKC8w=;
        b=L4EN/3eozxc6+xLJQd3XrBIEVNnBuJyNRJEr00Y/E6ACaZAtGrNMlSHc/gAsHbwYZ/
         QLe1stexmp5wrzJabWO9U9XjUgIpMlLlp/q7tQsu7OVtgkk6+13OHhgWWZlgQqHZopEs
         K1qab2t3dK9+m1uwe0RVIDKP9uEm0wmpHnGZbik/Fd2EUUd7YKlyDkjgSpvH6o+ebKp7
         JiCDoE6nJ/cC8ji46CzYtz+BWol/tuFMLgyLrJXKAA3lalFcvUm1UoMC5etYNNmI1ERI
         +TXX/8uyje5KpJO1XwB/jqwpHUTyt/aBfsOIgpxtSsZwtWY4Pv+wfDdyalYSJWWKjJP8
         6kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQlXEU4ypD0QbO7KXWhJl2OHiJi7Ox4B8DZLV3RKC8w=;
        b=ZkOI40DE6/LfFu62RudN4zYqmbD+SQcVRAs+c9VgHh6rPg5ewUjLitYNv1jy0/rJfa
         wyVkqiEXiQBrVmUcWWBaypRu3P/dp0JE/+ivMGHpnMQijmcYoDbvOYMwUPYhc+C39K1x
         pqXavQpoq1ddLw4Hg1lpbcKwycaQZjyf7fXfiNCv+9dAfoNpajec4XnwOxoP0tpZXX8k
         lyTlgj1bucSLJBPGodxO/eJ7Q+x7GjqrWA5yr1VuvwbujaSYbUP4f6vxGkpuGVsNlfpK
         hgJSQVO2c6xfsRR6FYJpdtHmFEk6EMMK1u3mCUXRqB+XNNP+MaaX+dhgWzS/Bfrj71EI
         +w5w==
X-Gm-Message-State: AOAM5314zRxJUo/wzraVCdWSXvRqETbQikPxqVFyd+aXYFdcRspEAlGY
        pq0gdr51oRwkPTdWb5/QZINJqxN2eUE=
X-Google-Smtp-Source: ABdhPJx2V4Ef3sFs+UnOF+Ys0jvO6M+cP7dZ8Yl9iELYBncDS80NkALj4Bw7arGihVKomsX1o4F6AQ==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr15706752wmc.187.1616412760032;
        Mon, 22 Mar 2021 04:32:40 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id q9sm19452295wrp.79.2021.03.22.04.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:32:38 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:32:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pwm: Drop function pwmchip_add_with_polarity()
Message-ID: <YFiAaIIaOo6kBG0q@orome.fritz.box>
References: <20201207134556.25217-1-uwe@kleine-koenig.org>
 <20201207134556.25217-4-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Gj7ZdhwlRfpxN73J"
Content-Disposition: inline
In-Reply-To: <20201207134556.25217-4-uwe@kleine-koenig.org>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Gj7ZdhwlRfpxN73J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2020 at 02:45:56PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> pwmchip_add() only calls pwmchip_add_with_polarity() and nothing else. All
> other users of pwmchip_add_with_polarity() are gone. So drop
> pwmchip_add_with_polarity() and move the code instead to pwmchip_add().
>=20
> The initial assignment to pwm->state.polarity is dropped. In every correct
> usage of the PWM API this value is overwritten later anyhow.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> ---
>  drivers/pwm/core.c  | 25 +++----------------------
>  include/linux/pwm.h |  2 --
>  2 files changed, 3 insertions(+), 24 deletions(-)

There was a conflict between this and patch "pwm: Always allocate PWM
chip base ID dynamically", but it was fairly trivial to resolve. Let me
know if you think I didn't resolve it correctly.

Thierry

--Gj7ZdhwlRfpxN73J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYgGgACgkQ3SOs138+
s6ETKRAAi/zuT2cTtV4gEj2tEKdrd57u/BX/1v9/aFyFPlGXPUtJmFSe3ItU9Xyu
ddphAj6bZJPRNeOCeVTdeWtQJM647QpnNeOmqsXUXInvhQIjGUyhSM2KjNu4dYdY
+GvyHZLV0JZGeAqrRUPp5E0z8m8RVRLN+pX76GX/N2MMf3J6Gs8YZo8zwp5ppEdz
m9ToNg/36hIKEcApMLJYdi0TCOaMnli1HcmqLhQcChaZeZ4FdL6qXPFTOEaS/5Eh
Id2dO+EjROXYHOtoiLLCyD7RuhTBfX9hTn5vcU1H2V2DSks/B5aieHEHEbg8Onz5
5EDRrigHrnOBMjdSRiO2Wrfg/OSHggrow38MMHS5cQrYF6unAykc2CR9fV3ixVxg
2UdA9bVI+nQWwQM5I4uNH9L0GnesG8AjQFe85pXtRABdp1b4Ej8FcoZiJQNjkdWR
YBeUHhj65AL7SsHTInUSD9vAxnu1UfxvwCGB34q0eTDX1CXJ8I/h7xbqWG+PJDoq
bBylj8qkH+/tl+X8LopOkl71aeoTzCZG4Z2HItZ98gK70OjJFUCqi/BlO1pbL2iQ
Yskva6+Bl3jsmFmg/6YZj9wvs114xqgDkdf0r77esPlZGWq9U3mstOLpL+tbDpjN
S3lDPX5s2/fIux+4sH0vxG5lkjA9jzrJUBrpCYhne6S/SABftSs=
=JLZo
-----END PGP SIGNATURE-----

--Gj7ZdhwlRfpxN73J--
