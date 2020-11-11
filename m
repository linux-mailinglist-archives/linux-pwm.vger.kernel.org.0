Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C2B2AF9BC
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 21:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKKU1j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 15:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgKKU1i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 15:27:38 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD94C0613D1;
        Wed, 11 Nov 2020 12:27:38 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id w24so3550169wmi.0;
        Wed, 11 Nov 2020 12:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3SSKXZnWdwq0DOqj159XH5NCn8HYxBH6TPSbcPh2Y1Q=;
        b=D8+RxB+ee3V7rv4D9DbN3BymYsiV4i6V7xi+ZM2FKjD7wr3uriBDJ1aWDaLRuXKfuo
         pz4zUWwhOAe3AZ4PAq70bFaNObbjiNqv9MHgkBnPNiDOzbWx8e8WXj4f4nEiEgbN3R/t
         ezV6DWXhyT5houkGSgpws1XgpEm9yuLVglRUFx/JA/j2f37BN2ABU9CP+H8C/zRgwU96
         oKRymmI0jovLiUT0CTYEkPM6L4fllNn7Hi/waf6HD7JSdX8sv2cSiRpegYvQAOiKaoY4
         tOmQ47ikhmOWNS96lHlEUl4kC2Fvh7Z7SdnUveo5zfWqokJeYkHqp0B2nx1MapD+xE7O
         GUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3SSKXZnWdwq0DOqj159XH5NCn8HYxBH6TPSbcPh2Y1Q=;
        b=Y3Ksb5oluh0MmzbkyAtTdCZLX8Az6l2nLcT8GwEI6JCR7tiE7Q5aXYZDE6+od6NwBn
         rphbWqRXqkwQFPpReYFEtMEnWmEHGAfzkf86zIc1HqpzKWoDk5m5n5itzxshugaSWU88
         NTFZERWb3uPN1jDniPNicpMEaP9V65W5mp9k3+qPyOlBEA7lTDTYzr7YhUATUHyQaAg5
         ubPeXbA+OiojjZnAP9RL1q+jrY85YpxDNXADl7mS1UMR2GGQ0jaBbmn32cuLwWLOVaGU
         fShIbF6DSGUlgH6AXWIPcptEiThb846aJqpjjKDQgMs8KyFj5G+mIsv+OZ/q6g1H670w
         vS5g==
X-Gm-Message-State: AOAM532q1zr3kkWd4B5gTxxtnTNnCeYTaP2otTm1mxZQey1nPyoWPiWe
        +4Q03+vV4v0XymC9dUDa/pw=
X-Google-Smtp-Source: ABdhPJyB+uwh0qX7g9Q8P68FrQC1zOZSo+JKQ/sfk5Q6Q3JRAfHsdr79q/u2RA6gPbHDLQLg0VjcOQ==
X-Received: by 2002:a1c:df04:: with SMTP id w4mr5906338wmg.3.1605126457267;
        Wed, 11 Nov 2020 12:27:37 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id f5sm3964460wrg.32.2020.11.11.12.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:27:36 -0800 (PST)
Date:   Wed, 11 Nov 2020 21:27:34 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH 0/5] Add PWM support for MT8183 EVB
Message-ID: <20201111202734.GL6125@ulmo>
References: <20201019140705.1518822-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1X+6QtwRodzgDPAC"
Content-Disposition: inline
In-Reply-To: <20201019140705.1518822-1-fparent@baylibre.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--1X+6QtwRodzgDPAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 04:07:00PM +0200, Fabien Parent wrote:
> This patch series adds PWM to MT8183 EVB. MT8183 has 4 PWM channels.
>=20
> Fabien Parent (5):
>   dt-bindings: pwm: pwm-mediatek: Add documentation for MT8183 SoC
>   pwm: pwm-mediatek: always use bus clock
>   pwm: pwm-mediatek: Add MT8183 SoC support

Applied these three patches, thanks.

Thierry

--1X+6QtwRodzgDPAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sSTYACgkQ3SOs138+
s6GuAw//TXgbWEb85bt+2X/j8kLwdVl7gGV7DCzKg+8qvuaJCjOYYKwsQWv4Q3KI
ey+W8EYrE/hAm7y8o1JYX5aMeO+FWoyt16jWjZnqGdmP6vyOguxU8HIgPoctQUE9
4BTMWOZNCRyi55/HGUZKgpzn0nPrvEr8zx1gyCqtfeH4YRsQ7Vsgnze88bbmkp5j
RHzm9p/77+/zHPro00KeOvUuWApXNwR9Xw8BHOK9MZvgIAXZboXP4V7Sjs3eXGLh
5gfe5j6izeKvmGNAGb9Rm2J1sNhSKVYh0dNCzxJyvXmN5IWJhBjbnl1GobWl81ef
LjqncsNIMp8g+p95jt5zxJ7TCpE59RzlS+FW31fgTLe4tw3CD5EcM1ibMHYdAR4x
s2aLEN2USunPS0FnDIHY6d+s/6ngv5alyukouLoGnQXZhmm2Xkbe5BZzj22/mGq7
ei93TERbuy5NOAJsPol7+BAbKFL9pYELQXVYBlgCY9sOat3JixGiEo9mhoKvvQPP
aKVllQa+K6YlW1LVtX8QetjCdNnKvwj3iuKNT4aNbZg9Crk97hXFcOKbHPWp++GS
WYsVnvo67BZy4C8CkApI25GfuP7kh+sXgv9G2F06pgZKCSMOQl+xd+tGO1tQbh2e
a6e07/DtAnnXylT2zhXOgqM1zIpOYwZ+EusOpKU3mB8QsQ6d/PU=
=GlhE
-----END PGP SIGNATURE-----

--1X+6QtwRodzgDPAC--
