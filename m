Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64EB9BAA
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Sep 2019 02:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405158AbfIUAV4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Sep 2019 20:21:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38091 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404801AbfIUAV4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Sep 2019 20:21:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so3739040wmi.3;
        Fri, 20 Sep 2019 17:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XHJ9lYvrLBjSA+5OXjXI5pOAx2G8npxwl7Z/2aD5dU8=;
        b=NpDCwV+UW6oee+XRpK2UVCLWIUwO0Md7+DetDUVgS0jvJOYbdf9r6S8Vzeh4X/ABeQ
         00qRmzToJRkwAtsLqVfIepuDnET0dWcmpukSMeV80zMMRh2uwiidYlDkedYknQhPUNkK
         QAqUTzatjeJFR/xDw0oBWHCqVwrSKUCStA2s2mhWylSw1gyaFHqAb7yLhOHa/fSWpYF2
         bhytNBYw8WElHOG/DbAcHK6WR8BABa+diF+xLwpTMPGbnE0W20ou83Hi37+IrfljJN5r
         l9QAE2Aw/y8tO0PEa16BKvV4qk3Ykq75/dwx/959lCVpghQz3HLf6Jq9nsNK10eB3xcz
         kYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XHJ9lYvrLBjSA+5OXjXI5pOAx2G8npxwl7Z/2aD5dU8=;
        b=mLZzpIo9ttieVDn2JfdKOwpOBNbPa9tF1yLtBirHTOdUnMW+BnRYZ2UIWRLD4Z87gN
         VQLvcMPJKaXgRjVDsQnmt23I4CUho5pBbTdxBAmeHPAVkiqDTUJeN0hg3vED1t7X9gp9
         uZvUO34IaWz8yFqrtbkP+BI/bNlPfG6j974mwz5DMwSuOQjkMBOV53VxrYs+3EiQm3Xh
         4kpzlEtCcUSeO3v1u9Ae6NFZjQHRUw4Z5KLGA7HiQ9r6TjG8MOBKkucINiDPzN68VGHr
         zf0THxeq1VkAZDMFTiHtyBVDiIxWEKBFvKCciJkm1p0oiPqd5FmMdD8wpU/sNZhX8wDz
         iO9w==
X-Gm-Message-State: APjAAAX01ZHK+8ak/86ibQfa3fpjtR8qPZVlgwCdRL9LW2kvVnS8wgF1
        zP7xSlV+4tiNKdoTGvvjTTs=
X-Google-Smtp-Source: APXvYqwMxYtoqKooBGyy0pH7gq5YdtL2O70ocG4lE/5916002wFSan/ESxh7Vbq8DsLpyTLO9bWXow==
X-Received: by 2002:a1c:66c2:: with SMTP id a185mr5163969wmc.2.1569025312507;
        Fri, 20 Sep 2019 17:21:52 -0700 (PDT)
Received: from localhost (p200300E41F0FEE00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f0f:ee00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id t13sm6667421wra.70.2019.09.20.17.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 17:21:50 -0700 (PDT)
Date:   Sat, 21 Sep 2019 02:21:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v9 07/11] dt-bindings: pwm: pwm-mediatek: add a property
 "num-pwms"
Message-ID: <20190921002149.GB86019@mithrandir>
References: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
 <1568933351-8584-8-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <1568933351-8584-8-git-send-email-sam.shih@mediatek.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2019 at 06:49:07AM +0800, Sam Shih wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
>=20
> This adds a property "num-pwms" in example so that we could
> specify the number of PWM channels via device tree.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since v6:
> Follow reviewers's comments:
> - The subject should indicate this is for Mediatek
>=20
> Changes since v5:
> - Add an Acked-by tag
> - This file is original v4 patch 5/10
> (https://patchwork.kernel.org/patch/11102577/)
>=20
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

You failed to address Rob's questions repeatedly and I agree with him
that you can just as easily derive the number of PWMs from the specific
compatible string. I won't be applying this and none of the patches that
depend on it.

Thierry

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2FbRoACgkQ3SOs138+
s6Gohw/+NufS4BYOFKibVi7zlUVi/rDMwlkt6F4pkhnyohrqgpTCBy9F9h2ogtxO
QywrdiuhNuV49zxKHNgpXVQFmYpaUVuCsNaGHGZegyF182jcYtTraRfGm50PJf/F
x/ppM52eCnkM8gMIq+/ZQ3WYmpjhoFw5746ToZyy4m8mhXmQZqAwVFBOfce70jI6
Q8g6TNP93ayNLFVf4Hd2UNTN6d17l7sa8LKwWJqRulbH/PwnD/8seCkdBmEwcbdy
0qPYAkxAkGLfdN9mn+vf3sk+1N+qaLS0ich28ev/y/Ece8ey+RIHy894iZUko0is
j68nY8DRsf9S5YeZ6RfMQQbAiEaA+LWOLckX44XgQTQRrgAGBOsmfLgZVGQVrKCq
oQVl9Fg7FX30ZsIkNTAkpEX8bERLjj7XkpUvJLo+SYKA0xzrA34RM+RGTXGxA82O
7mb8nuqyPXdiVtWkcrne+IiggZoix3DBBsv9ujKNo2rYsSP3yEJiZpki/4GNsdhR
kKv17KdvVoP51ls+wUvxzI6Kr/DZeYIkrcWWNjNdig/XTzlyUeXdUsq9jYWz4UA3
MS9/0ZQSYdkuhIpcQPDduLx562SN6sykZi9cgcclULK7RqUv+rtlAg2zZty2WXtZ
TpxE5tnTnXlMHiaC7YnKbleL6K4l9qmoALx/oUvq9CZTJxEEHJY=
=P6kM
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
