Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4802757C2
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIWMO5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 08:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgIWMO4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 08:14:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CA8C0613CE;
        Wed, 23 Sep 2020 05:14:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so20786333wrr.4;
        Wed, 23 Sep 2020 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xH/OJNOXpFoUO1DQr8ioFXfkNwPG54GEfbB6/p814zo=;
        b=otqa5hJX0+4DxOPqsg9wxGESc/L6ngEhkS0LRhx6I1WnfWdYhsqVCslQllHDzfz9U+
         +Bd3MQ91qJNGYe84xuMHs/AyVyL4hd3Rmk9nAkCnZQleltS4h6cUh4sphaVysSKFjW6O
         q6tC6NFwBU3EmjjkciQQWTgMc2MxlW53WhnREF0rZrDxOFYoJ+MPDoGSSJAeH9ruTFYG
         mgIeHOPenFuBMOiFsATGN8JOjBfcpRSyhfP1L0oKKY16SUPNBGN4haYVctgrG0Ub0DQR
         dxl3aki29Yd/bIDh5iTRsKgyABAPMjiQX+rXYs3PhAiqEX4bYuoaNvfShnyQE5oQkMBO
         KZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xH/OJNOXpFoUO1DQr8ioFXfkNwPG54GEfbB6/p814zo=;
        b=NZSwc3ZOYK0FI2JBjOMenLMWiwiqkg4CY1mExttF95dnvq8HWSHdtJ5QRh8wzvbZnq
         HB2DzRnd5h+Oa+qh0MSwL5GUil6hz45bcrItVBRk/vFoJlnENE7gflDn1lVOqeVN52ox
         28Hxm2JOXCDhQSkzzOMi4Xwtfwsu3035esAIIOYtPuS77d6N3F1x/W1/oVz9D+MwzVXy
         0tL16gHhHmd38+MdQaFQlqzQv/CqcN3q46Y1zlpK9yBQl5scMm7NLdhOiRWSF2UhgWJ7
         9327zEQDQ6hLDoJtO3GlbkAp5lIgoQQNuWBM7nKj9nG1VWzsqmoGH1OEwq6O3Z9+RW3c
         rVQA==
X-Gm-Message-State: AOAM531P7N9VtZMlvsBcNf+N8UcCksIxff/k8V4536UALmcwC1bb1/oT
        PJdOQ2+gFutrxsX5vL/Ajkw=
X-Google-Smtp-Source: ABdhPJwtgDgmZEfiq2/zyLvu9i2tC//svTGYQeAz6M/bWhTQFEXGXQwyDV9fSLyOs/qWz11uSy3uPg==
X-Received: by 2002:a5d:414b:: with SMTP id c11mr484211wrq.181.1600863295328;
        Wed, 23 Sep 2020 05:14:55 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id t202sm8584077wmt.14.2020.09.23.05.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 05:14:53 -0700 (PDT)
Date:   Wed, 23 Sep 2020 14:14:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r8a774e1: Add PWM device nodes
Message-ID: <20200923121452.GD1848911@ulmo>
References: <20200825104455.18000-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200825104455.18000-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdWmvcA8x-t=FgNOuMnAtw6j3OAgo8irmD5e2wrB+LfhHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWmvcA8x-t=FgNOuMnAtw6j3OAgo8irmD5e2wrB+LfhHg@mail.gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 03:32:08PM +0200, Geert Uytterhoeven wrote:
> On Tue, Aug 25, 2020 at 12:45 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.co=
m>
> >
> > This patch adds PWM[0123456] device nodes to the RZ/G2H (a.k.a R8A774E1)
> > device tree.
> >
> > Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.r=
enesas.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v5.10.

Hi Geert,

did you also pick up patch 1/2 in this series?

Thierry

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9rPDwACgkQ3SOs138+
s6GEEA/+OS2RvDAz9EakePA6Chnz0XpAeBSsxGTqHTrAx87FYKl4cj5AOOOYba49
l207hajjcTqMnWEsNYxQpVkRaASzdBlq3Hy7zLV1HC/yvgsUCusUZfwwvlH5dQzN
kW0+Ak2iUcwOfqW5Zieu6mCmOna6RjgMEuL4EQM1nmlfgokgSNjKLQwiQORtD8ki
DV/3IdB8VuuMMvtiv5YsWHefLVoP5DuifHHSN873knbb8dqH4cWGdqNhWPA9SzAJ
KR9gkxXNJbPWoEZhQO8uyoYImFytsQNsTF5WWSSXPKA3R5/F+UN7QU7uHn2JOHKx
WdB+1nQ7n/o2yXWX9A8a5gtvCkVcyKM27n9Rtm/vME2hzosyyIxZ/cDcl0pk0jaG
cKHyZnI555O/2TCkHDO++CrPPs1+y3b9+pHfVy8mftKDIr5JbA7OT7PGH9/9Q2QO
Zu3qpPaLD+TzgCY+47h7b6hV21MBg6iD2WwI6T/WKUYxzK2i+L7Hz55IpqJsLDUu
al278xEIgVjecuYhMzcw0bzlP2ZTPk1jvXdLn3w5ygx7D7IfOHsAMQKN2KckPbVk
AEeCtmjWCtrq750tpyZs52CXwYlmODLg5kfiRe7EDJn+j3o9ZOHllAfztmKYjXIG
kG0s2XdEYkLsQJE1V4qyk6HM356vwIT7MdWfCvyBnvEMv4ZtLXg=
=JMkN
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
