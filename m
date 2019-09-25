Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E721BE879
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2019 00:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfIYWuK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Sep 2019 18:50:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35458 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbfIYWuK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Sep 2019 18:50:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id v8so498139wrt.2;
        Wed, 25 Sep 2019 15:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fs2mUK+2SrnaDGqHEbHBhhO8ASliMTqMkt3FxwYhzMM=;
        b=E/wqCKzMUINn3pXJ68SvL15btqfissC4d4pkTe0Q8lTcEjR1cETLNEXy1QYbFRyjuO
         PFzZ8aL7Ab30A6d0IFYcguJB8xSyyKw7lw9y9sd6tqrsZM2iy7SqvRNgvX2gPjrVUPVt
         COIaZumF6HWCV55vuCqyfDMRQejB9VTm0/5VdxpydAN0185DFvIqf3Z3azqun/GS0Lr+
         LJcBrxZVsh+1dc4pE+7yv1G6sKunkhl57eRC7cyWi2vQ7iR8cyQC/aOHt8CPD/xsk4+q
         YP8HAa75SIxoQHO+1UJLl8OtIFLj9L80WSxEYpVrArvv7m1Op67pY0fjROoE8EpDMsM/
         /LmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fs2mUK+2SrnaDGqHEbHBhhO8ASliMTqMkt3FxwYhzMM=;
        b=ZnyzEB2BuKwnWaTFZZyEoUZFhn58nfBbTQJ1HvoysLz8hgHSwSDITyurLP2vFqhqBZ
         W0UkiytYbxaUkO8dNJ8BwnacN8IunlmcuMEM5nA322/mReoQhX5cuC3NMEsQbEaGgSxA
         4qFbpA4yNC8lIqK0DSU++3+iCBi1vzLaoqfABgbAF89I7Y+QSQQyMedKMNnLPKSxW4Ne
         jPPr78FSrTu84D8d3wXe+I2pdzYuZoFNGHHEjOrkKf1bQaA8NKtPZ6jVZw6fyqZ/1XI0
         ezTW03pKQnq/Y0OwQAk3r7U6fzF6P/QyzfHd00NloALT3hBsc36pdUd+h+cNIivGqzB/
         4E8A==
X-Gm-Message-State: APjAAAUsn1EssGXBNMGIdVQ/rigi9pFVb6LOqEAjddMWwAbP0vXNbLfT
        6KCXjglrgmNT5JkMatlXmy8=
X-Google-Smtp-Source: APXvYqwforAtGJdFg61VD7jXa2EmiEueft4/tswPr0fsD/8XC2L+O0qahphA4KCActPT7LHQ1JsYIw==
X-Received: by 2002:adf:db47:: with SMTP id f7mr442320wrj.1.1569451807649;
        Wed, 25 Sep 2019 15:50:07 -0700 (PDT)
Received: from localhost (p200300E41F0FEE00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f0f:ee00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id g13sm1041612wrm.42.2019.09.25.15.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 15:50:05 -0700 (PDT)
Date:   Thu, 26 Sep 2019 00:50:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v10 07/12] dt-bindings: pwm: pwm-mediatek: add a property
 "num-pwms"
Message-ID: <20190925225005.GB8115@mithrandir>
References: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
 <1569421957-20765-8-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <1569421957-20765-8-git-send-email-sam.shih@mediatek.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2019 at 10:32:32PM +0800, Sam Shih wrote:
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
> Changes since v10:
> 1. Follow reviewers's comments:
> - derive the number of PWMs from the specific compatible string
[...]
> + - num-pwms: the number of PWM channels.
[...]

Why is num-pwms still there if you derive it from the compatible string?
I guess I must not have made myself clear. Please drop this.

Also, as I mentioned earlier, I've already applied the patches from v9
that were suitable. Please take a look.

Thierry

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2L7xwACgkQ3SOs138+
s6EKQBAAkjKF3mGlNiF2VtYjBYbi8012ySVpqf2IVmJEdG1xulyW6cUqSPW50ZRu
biZJTXPgRLuLLIt9/vt5h/XKjvXevhTlhgv3FCWTl+tgqpgo9xhDpFANSZksadH9
EsVp5NE1/jgTvdPa/0iYJiDHzF6pg/+zNRweveinqkVcM5mfICWwK42vZVOHx23b
O+Nzhgr/D1ExmA4W6BUQ8BdCnCyVr8OAL7eYiRWRDwC9esDg34fuq9/irwcMo+mc
MZE5ieoQmMvs4GOYjOdNy4G5OrBlfadzfpU95xtshQTUyv+w+TX5bj9mWpkZWlgX
ah5DydkbX7fgR0BMnD8K0UqFr8GOgiJOmQ3VU1Q/orjaw/k0byjAQ3DoEjzGUoS+
hAy+zt5H+IwVmMO+U9giO66xOWZLKBLa1loJJpSJ0ly0mYCO5KsJx1digyBAc1l5
DELrYLXnLaXvxQfibweSxiKbCpOeJrsY5REaU5cmbasIFGSYRtvvI6/emTe+YUgW
IPQ6s3CgvLVw/F+IvZle7CAfuhvltywTksUsYLsJYDjszGhuhYQiM26yjSzE62eM
ykgQxzfDn/SN1H/cqEQgoTgMmUSxBJNa6SKYrRSlTuyWkj/74pWQdzP9hzUwi7c7
moqU0o8poSC29OA665w+DJ4AMeQ8QSGNm+ZOO9SpmGBY8752amg=
=QjmR
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
