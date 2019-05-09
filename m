Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF9818C9B
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEIPCq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 11:02:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37422 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfEIPCq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 May 2019 11:02:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so3544028wrn.4;
        Thu, 09 May 2019 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4dsx/q7HbMfsJZPbIMqDoMkdbIHaHboqniF/scq0b4s=;
        b=op6o+sDbTlaAqh7mLZq6GcfYJtBYwK/t5Ez5FeZjMGVM+R4nw64WCOnJHAIu6anCbL
         BujfdZAeZMWJ/Dlaq2wod6cDWiBHkdyHNul9SUIeV0O98paTiQKNL4R0x324PuVX8Gjz
         bFACvMoqM5o6BVotZK0jvKrZEwYCgTSHBdXcgXrwlzeEFePHDECxcqMvzZf2FN2552Hf
         aQMw1DaX8t6ZcdCmAzG+Xt199k66+RES/9LNoSEjHu0kyuIlH4oCRpGLdAuWtfp2zxyu
         cS2KNl3aGbr2CHQP0pDZPHAm33chi1iuIaAE9w8ax2fPTZ1Zi0bycLTZCT55uCViWszk
         DqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4dsx/q7HbMfsJZPbIMqDoMkdbIHaHboqniF/scq0b4s=;
        b=prDAztzHNhYnvSRv9ukHuJnK1lsdGndY2o5UOq3XSfirVDP7VHyOrTS9nkyx6rw6uy
         4KtO97QZDMRVIYVeRCv5nprV9UrSu0puy5KoLQoDaxAGRD79NqB4GzIwr9kYO4V/HcOJ
         10h0ChBc2/cqrCmnBd+8Nf96SKxsDuBEXL0CJkH54zaGjqZ9Ek2170nHj418cjQtKqjE
         dn480c+aZx3nZMjZWt5W8sssrQbUzgaGRvtdluoj/LkgYhXUDFWkjvjerrXNibuK9la7
         3DX0Yyi8ACPSZNRmBI+vlUAZNhhcdcP01TJqzu5urvjmjyW+W8E9OD55t9QKCdZQJ6zo
         ArUA==
X-Gm-Message-State: APjAAAV4JG7HxuPx//L8WkTelGbKE55ImZsNKcBYGlbf2HgABFIv2dnZ
        lXGNUqc4O6aB9N14WmexE0I=
X-Google-Smtp-Source: APXvYqz1DHOTlq78BMwbYXJC2Qau6WsX7Qi1e9jzkdUqySLmmY1bFf1hVZGmkhfBKtlDD7VBl5mzVw==
X-Received: by 2002:a5d:4ec9:: with SMTP id s9mr3667227wrv.223.1557414164337;
        Thu, 09 May 2019 08:02:44 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id p18sm1628761wrp.38.2019.05.09.08.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 08:02:43 -0700 (PDT)
Date:   Thu, 9 May 2019 17:02:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V12 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Message-ID: <20190509150242.GC8907@ulmo>
References: <1557408252-21281-1-git-send-email-Anson.Huang@nxp.com>
 <1557408252-21281-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gLcqQrOcczDba7nC"
Content-Disposition: inline
In-Reply-To: <1557408252-21281-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gLcqQrOcczDba7nC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 01:29:19PM +0000, Anson Huang wrote:
> Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> No change.
> ---
>  .../devicetree/bindings/pwm/imx-tpm-pwm.txt        | 22 ++++++++++++++++=
++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt

Applied, thanks.

Thierry

--gLcqQrOcczDba7nC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUQRIACgkQ3SOs138+
s6GPVw/9Gdzsk9uaLau6Rkdgpm7E27qHxLaoGWnFIO4dSmbBB54pZ4RyBEndDzAM
+oKL64WpYLt3z8VCoEQTQ0kUyN3s1fcPfU8IQIAJ6D7cI8iIiaT7vyCWS3MCYT9q
+yx97WQdOo5AFnyy9VT6P4o9D3OE95QLrER7Wf3MXmAxWamrrS9cnly+DjB+Jien
2mJfWK/nUfxYMSBOTZrKGNh85gPsrIb2AiMLGJn92KMyyd8/nRcHJMUlFZk+0bXn
4VSRc2MFnUmlNcjYmqyDT/CcnkFVzLI6+Dlthcaiq3icjVw1Z61fyrG3IN+kW1KE
Nhq7y2EywnEiFcNmhIYxjyqSDsblmJiPpAGD6EA2pLk/dxjvnoeu9KsiBiWZQnsA
yWiaQKdUBAKJgP33vqiwv+mMQK8pYZrEThr8FKZ995qj37zlhP3ewtM9vrqMHUBN
81hGXOH48ZBCkFT0vHPrm2c6+FMkqk+Y/sZmyxor5Pje8nR0MVh9X/w/u1U+wOlR
RCzKA4pAvhWDzainC3x5uijo+HKomQ54wLq694KK97cUUp5CJxi0zD3PFMlye0Uc
JQ7RGOWwunI3u/wkS+YUmA18kqvYzzCg7BLDA3+o7oVb1nYPIA0sSPyFqq7SXhh6
YHy8kd3yzeuZ9ylMyUqeiei8prfyYiC1q2HyFi5w0ZImpq9bujY=
=Jfgf
-----END PGP SIGNATURE-----

--gLcqQrOcczDba7nC--
