Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071492887DD
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Oct 2020 13:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgJILai (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Oct 2020 07:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbgJILai (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Oct 2020 07:30:38 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D2AC0613D2;
        Fri,  9 Oct 2020 04:30:37 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l16so8989801eds.3;
        Fri, 09 Oct 2020 04:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cmzLh7799a8AwMknnddM1AHF6UxknT8ZEXggO3stiRM=;
        b=HYYqpSAoSy4H1yNP56Um2CGJOZ14fsizdBwfpG5Kw+5vk46CFyLzekDdN74eaQEtat
         xohHGmPtXgMjHCZD5nLd3viri39PfVUOnFn21Y/6wOUATYtJ5grJDUevR2e1SnzcPZOf
         2w4nRL0+vlWDy6SdFdA3ZZzUewuewU8s/iRdgkkPUP49M1RvCebkjUCDfdlboarqSOKs
         IzkZDRutIuwjTbom4Ty2NyXvdMephIFIXwfu7YZOrnrtFN/UN5FgRVvOsxcyuV280LE4
         GWkzD1+Y6qp67mFwTDOZu/cCE8UesSyGH/6ECp3BMu7T8oKWgZtErBOXTXNMqvjTmEd9
         aPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cmzLh7799a8AwMknnddM1AHF6UxknT8ZEXggO3stiRM=;
        b=YjaH4tNOjQOnlDRMsS+RDK8US3g2eFwwZGRagjGeSdtUJbWLH8vOy77lVYNF1StjaB
         eOm8ISxdZ8LWC5b1LpA6AufAtegCfouKbJ7qdVV0LQ58SceSeRYpWz1bcRI6bmNfcIor
         POCLhqdJmoJSiM9e7Tep60lRzvB4rPGtY2tDzJQaHZtpPPU24Okk+XLh5MEDe6/R5Sqf
         w2NUfXxPuHKANsjsZeazYivdU3VkbdbfresoJMhb/IhnMIF9qwg3rwr9L1O4cMRlv2Hv
         Fxqtc+hmF7COccheiQbtqzCrgJCIrXNwPbbNwntj8KAOcc3cphjQq57pTtEJ6UMvGXD+
         67iw==
X-Gm-Message-State: AOAM533QO1KYD95GatTob/xtuDUNn1yQRnvSMcV4iAM2WSiDTYnT35S8
        nlID37mPqHQDpvBRygbHoKc=
X-Google-Smtp-Source: ABdhPJzpeqGvsfbEYNdmYNuLrq27oT7l7P8raftX0Mao/IlG/V/3jYwz8CDa4jcuxdFB0UsKNv5m/g==
X-Received: by 2002:aa7:cb05:: with SMTP id s5mr13966105edt.363.1602243036219;
        Fri, 09 Oct 2020 04:30:36 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id h12sm5994544eds.22.2020.10.09.04.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 04:30:33 -0700 (PDT)
Date:   Fri, 9 Oct 2020 13:30:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: Document tpu, pwm support for R8A7742
Message-ID: <20201009113032.GA447979@ulmo>
References: <20201006081910.1238-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20201006081910.1238-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2020 at 09:19:08AM +0100, Lad Prabhakar wrote:
> Hi All,
>=20
> This patches are part of series [1], where patch 1/2 was missed to be app=
lied
> before YAML conversation and patch 2/2 was never applied.
>=20
> I have restored the Acks for patch 1/2 and patch 2/2 is unchanged.
>=20
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=
=3D329853
>=20
> Cheers,
> Prabhakar
>=20
> Lad Prabhakar (2):
>   dt-bindings: pwm: renesas,tpu-pwm: Document r8a7742 support
>   dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742 support
>=20
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml  | 1 +
>  2 files changed, 2 insertions(+)

Applied, thanks.

Thierry

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+ASdQACgkQ3SOs138+
s6E2rQ//YrShguVFFG7u4sQvUa08ItxuFHT7b2pTJHkeLuSIdPAyCtQ5tpS6LAyJ
pESS9NnrAdmFmLXEgXCZjx4G1XyeSCx6l9hRbBjxVgST1QjssS4R//LcgCe5CHiT
A1iHikOlevX3YXRXLopsgVyZCcQtPIkpPu6BhRjAi/I4ePISMHnGHSVOsDZG1SMd
PinfjCk+cmsGi2uHugcSz5A0wIx5ISuoNQ0hlBhqCChxeZggLRwbxmZXfi2A/Cv8
AtCLlfwleIV7POILIlUHMuoOFKXxpe2IJqBEZOIFnn2spRvD6HCZCJ5rYD6OuI8P
xLmzfPZi1KBkRiqIKWI79ipFihCA/99QUho9JrQEnxuD9lKjlgjH4BGxX8wVcc7l
qk4VFmWFVtDzlIRWB82GpCphUYdTmw5WNthPZMyvoLQ/G92pKjKn11dO27LKkWMp
NmVqdsmdOw0L9bz6uYzBNU4YsTZ7yR06np7UzlHpketfPxX2Kw3OFGuR1fF1uPUQ
q2PnZ4nNnRTLBOweMkfszknbVnszQWPa3eQy8OUgBKEfuveHkoYl1AJDFbx4uc5f
MRDNZ+DlZjQDtNdxQy19gtoo0dlDGph3cYQJGkUvpNf7663xgXkukMqCGF8jFsZO
vnOP1xDwJF25Vbos84kQ/uT8Q5yPU2s7hczDzcmVN14UAynGuxk=
=nKum
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
