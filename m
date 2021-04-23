Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C5836976B
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 18:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhDWQxT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDWQxT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 12:53:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4550BC061574;
        Fri, 23 Apr 2021 09:52:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j7so21297477eds.8;
        Fri, 23 Apr 2021 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jFCniOtGAUvh5tDuIWS7uZa9/8xrAA1r1T8fT2Kl1d8=;
        b=FjQGgLqAoRAhJDP8bvbuAIWX1fRLtXTbDahJh8lyg9ZwyYqTYQ1JrARnNmgGE1G2fF
         NddJewqq3uVP6kIqIhAVFRXj1BLLalyAk3qquiW/5rFAl7uuyy/UrdEOdKRK/uP/Fov7
         Can6OluAi2QOdBAXmgyWKMDze3WaAF20Y7wlUdt4v8a/kFPqjpfneJQpQEca1vvzXQQ1
         e7D99+zVtTmacVRvTWzKb/tyWzekicGmRNvV/wzHXKSUv4/ASkhoVpvQ25OGiXpblfO3
         LH0NLRkGWpHDLY/8P069PE3KUJLRo+/6SNsQs6Ymw0TZ0kHFX6U7IW5/lEoBLz7D3Ejw
         aD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jFCniOtGAUvh5tDuIWS7uZa9/8xrAA1r1T8fT2Kl1d8=;
        b=Yudr37XL/J4rtpp/1lwEai0W79AzHprUzOFeE5RviugCZgvxr0EW8FQzVxMcHv+7MF
         mQ/2/Wl7Q5yg52WypsD7Ez9BqEZf+mhHexMlw3Kl/q2Pyle8h41r5RiftRwc1ayVFHmI
         3+uLjZj2U+PW9IPEbrdGsVkyFRvaXG9LAxBS9UTg1Vis+s0gIOKlcBaABPvGkwIurIxf
         uRb6pmuoVFPDiwjYEeVQtEhfGVpCeblVfe1eezJzV+E8hC5939pGoSxGgYb/EtnBxjlE
         rvVKxnGAiyof18pOq65STuQzSITWbfzFQhGIVoTfqRhtPQTlpjLDFxvc6mp9I7o0UMcg
         +Z0A==
X-Gm-Message-State: AOAM530/beQPzhgui5AQo2+UBPx+ltm3scKslJwL3uECYjsP6q/DODpu
        ByYwH+MYlPgWUFQAagKLJmM=
X-Google-Smtp-Source: ABdhPJwztJLM5Bl1NlErdY2qO/fU4NaGrY72Dw41ahvzAZi/41DyvMd8wADZX8VGCRAySbgqCt/D9A==
X-Received: by 2002:aa7:c511:: with SMTP id o17mr5452004edq.335.1619196761013;
        Fri, 23 Apr 2021 09:52:41 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id q16sm5446999edv.61.2021.04.23.09.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 09:52:40 -0700 (PDT)
Date:   Fri, 23 Apr 2021 18:53:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: pwm: convert pwm-rockchip.txt to YAML
Message-ID: <YIL7ibC/Pojfw3OT@orome.fritz.box>
References: <20210412200155.5316-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zQJ8OWk5MsO8Q17F"
Content-Disposition: inline
In-Reply-To: <20210412200155.5316-1-jbx6244@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zQJ8OWk5MsO8Q17F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 10:01:52PM +0200, Johan Jonker wrote:
> Current dts files with 'pwm' nodes are manually verified.
> In order to automate this process pwm-rockchip.txt
> has to be converted to yaml.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> For some SoC nodes this patch serie generates notifications
> for undocumented "interrupts" properties shared between
> PWM channels till there is consensus of what to do with it or
> someone makes a solution for the whole PWM block.
>=20
> Changed V3:
>   fix mistake with compatibles introduced in V2
> Changed V2:
>   changed schema for clocks and clock-names
> ---
>  .../devicetree/bindings/pwm/pwm-rockchip.txt       | 27 -------
>  .../devicetree/bindings/pwm/pwm-rockchip.yaml      | 88 ++++++++++++++++=
++++++
>  2 files changed, 88 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.ya=
ml

All 4 patches applied, thanks.

Thierry

--zQJ8OWk5MsO8Q17F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCC+4kACgkQ3SOs138+
s6HqWw//ZMveK8MeXwu6wrXBFllrTVKghpCj/TcBnvjT39S+lh/KNUVhkDbki0+A
VliqplxKSCk2ZPcu9FCnEDN0l8NI7TQLRtJ6QGPnAWuEkAIhn9qaS9VBN1yo6Sob
0mSvzRy5iGUN90xYyjYujns3oXe0vIxNZwRO/KBztsg6uis2sN3E6zqvbyPl6Pdt
ll8pY5N+GimqEG5vACKWOpHkVZUp5j/ojfEWfQL/R9S7iVJo1yzoqVLzTyBc2oYx
CiVFo54KNR/WnacrrC+GIpmgnrLbKEh/bswNugXaZ/Umdd2dhxtgGI8hUMgRUqx1
rIpWFHboxGLlqeFQORoxxV3a4ybFcZB1wdTbHyb5XsMyfYxFRqabED9K84JxMxpB
DaxOOBW2jDBiwmJjhWuy2ICE65rtSx6rrGkr4gply7O14A8bllHKrHG6W0DrT2hY
k1l6J5J+RZc+Ivf3NRpfO1a74/80xXKeXi4KSgfIxl/mM9AGKN6yDVEf0e085rau
9kGHvOdjuItr7XeneUz0FuSqdKK/6UwyMU+QohELgJ313zKeX0/gOQME7+AKa/36
4sbGuTXjTXbIjOK5sAk1kR5VLFUcohMVbRfm4c3lI3wjEkrRfPCKnrD0WRy30leq
7vz7Y0Zn3IciHw0ZL77RMip0doXR8wlX+Qazl5TXqLpY/d4BRW8=
=RnDA
-----END PGP SIGNATURE-----

--zQJ8OWk5MsO8Q17F--
