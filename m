Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B39918C70
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 16:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEIOzQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 10:55:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32803 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIOzQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 May 2019 10:55:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id e11so3516039wrs.0;
        Thu, 09 May 2019 07:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pgroLrXjulKnOxz4J39w9NLvm6dxB7hV2FJbK952mx8=;
        b=mta2wZVs1zifxA4N+ZLr345+hkPVQeWpcLzJp2Q9hEiN6JaKkzUMqJ3O2twKW7WrOv
         qGx8heXrJNdupUhq6pASZZ4ylBuAZCJnfOv+4TgW8tLRYVwQEZ+9zOwWS/4iNDOLTtDY
         FrK+UgVgh6g/EWufrLFJ0BHrtl6g/oMwO/Tt8aij/78YV3mfNwfISRJy0Jea39KAZgGP
         fEPBerQbT5g6bvQlgRBVRu4MIY50MjWOPLCJ2ciaBy4uuBpptdMqi9i7V/zp6i2cPW8k
         TxKRkeyds8jkhCt3qyhAepGdTYhIKbRWs765VJtjyKXqTyky4V87BDo7FFMMqEkLq9pX
         mPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pgroLrXjulKnOxz4J39w9NLvm6dxB7hV2FJbK952mx8=;
        b=Q/tbCYtkPE9hqFfkJg82aD8z4NOE0k2zGDu+ZfhNxuTsBW4fzEsbbICONgNSzIvcur
         IiCZNi6prWNrMV8O0SgHkNMNoc5dtVEAuHthX46kvnus3JxDB8nfqUjIq3J6f4qaDcdz
         G7gNSNiM2N07NCEWtTMfKqnOi8OBGMKCVqylH2hUbp/Vp3q4h2nWvtt3+veVm0dLRWpJ
         v29SS82mGCeD2SlldTVR3reRWl4+L12ZDtE8m+MmZA6BCYcv51PWaVojKPnXU3JmBaeu
         A12cF6cTgMKdu7/7s3GgCv3nC2z3+QIyr444zl2Lt380QlFEFnHXuS4LdmBweJBCPU+D
         zrug==
X-Gm-Message-State: APjAAAXPrZSqBf7fJL4jPAE/hGb2bm+R2k5fYT7aMlD1RUjnVFR7jjxw
        4XB/zbi9IyHmsaMmoNLvvqQ=
X-Google-Smtp-Source: APXvYqx8AvOreAFuIDbkVT/vqoQoGyW4PTRNLbrFcPikFoENIJsGVkf8thsUBovN8jMkq6YDAiPolg==
X-Received: by 2002:a5d:4b92:: with SMTP id b18mr3471767wrt.11.1557413714464;
        Thu, 09 May 2019 07:55:14 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id t18sm4549657wrg.19.2019.05.09.07.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:55:13 -0700 (PDT)
Date:   Thu, 9 May 2019 16:55:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] pwm: imx27: use devm_platform_ioremap_resource() to
 simplify code
Message-ID: <20190509145512.GB8907@ulmo>
References: <1554095960-15638-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RacQGezy2Y99S6cT"
Content-Disposition: inline
In-Reply-To: <1554095960-15638-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--RacQGezy2Y99S6cT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 05:24:02AM +0000, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-imx27.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry

--RacQGezy2Y99S6cT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUP1AACgkQ3SOs138+
s6G0tw//agEcPC0fIAFdWa9AvRrl3E+d0tfQxSd+oiQ9H775nxrULNP4gVV2dBiy
qyW5SsswVKV6Rl+S0Q6JvhEjo/j9ttZrwNe/f9jOTWvX/mQzqVufbAIhBikAP3r+
6yiFICJ/idWQClOG6bkuaFBDNy/gPIIO82U+womvNEMB4fIkUEKl3wn0ZeEfJ8lN
cxnNdFpTG8f098WBVeQSsoxJ97jzbQQNOkmIbEhBL75o5/gh5rqky8B6O2vD2Ncv
rI04e1aQ7svRv2bVJIPpeHkAcNg0McMmjKvJQmnjCMD2FomkFbWDpcheIgCwIXJb
yg77VXfdIbwUlIeMy9JOS6kOj/m3dbQbUoyMDr8H6J9RZ43+Xv1Neyv15+rX/cJX
fHP1ZIIJUJy8QD0aal2ybA6jxFknAmE3loPYfCkiVwj+tj/m9Eb2Vjfi3ca1eFj+
lXZoiZG1rYaplFjCOedZcY0DwgnOcBmbLhITnc8IOBd1QPPScNmYj8ceZr5qn9SL
XNLpCj7cBULCJqIOKvWR2g9EY3/vEg208Sy/B8O7kbjT67uwDCEKYpuof7SzXe+/
VvS7MHaw4uJzxuBn5ES7thUf0R7EYS/HkaMsdlPqCjnHeSHNQTxMwLOSF+cSE+G7
QNazMfE0RaE0HX9rW9CrG3PSfv1GKq35/K7tZ1r90Q1OKVeddSg=
=TiNT
-----END PGP SIGNATURE-----

--RacQGezy2Y99S6cT--
