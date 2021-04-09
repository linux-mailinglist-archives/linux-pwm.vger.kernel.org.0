Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A730C359F0B
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhDIMrR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhDIMrR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:47:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E937DC061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 05:47:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id f8so6403386edd.11
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 05:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pPzoXsXlHCGPD49maRNgKNXo5LR7wlZs1+pEwhPBlLI=;
        b=TlTyZlzub/bRiOVoz0th5UKEkmVPF7Dy9W6L5HUpxPwG/nHV3GSNzIqmcNVrE5gePD
         S8LRLn14sA2PVUTYXwDMusQLd+T7mGOmQVo5xuZCjLvoBZNsEWkzs7X5R9mfUDLAFgSy
         HPRpqmQZuKqBkxB9y4gzKsWTWzUuLRBzU1cXYqZG712rWOaMIjOkgr/TggRYmWrVk88w
         IxKOqo5+KuhEEjzFMYPX5eB2a6XaIEU7UPR5Tue+cYUAZE/0GRx2bRRbGfWvSgTZWidw
         wlKWOAiWyuwLUnJoEWfni5xZs3VpuSD7Nggo5BEVLqTZAhBB4v8oMxPzl4aV8qMAO6Lh
         Wo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pPzoXsXlHCGPD49maRNgKNXo5LR7wlZs1+pEwhPBlLI=;
        b=ellLW//wnbpX05fmoNJ6FpQ/CY34Lb1lACDwOceK6thtNwfcnOCjgJNU7gD0aMgtW3
         IpcI8q5jR8eQIduurN08QlCEBPXsCIS5jorHCypwdRqFIlX3OHVnm5VFM+GcIW67ZMY6
         fqAiH2pFv+ejfS1ey74iAWOjaMcUlu8+dfdFZ5LmGJPduo8FO7oBmcsdRzg1QjsRUaSl
         kDnw2m1qvk28B3V03HtGwOoP86cwTP7aUPIVJSqM/iwhzB/ZTaVkmSf3G+z/5aJ7vLXE
         EtNv7TeHlP6toZZJ2DPXsXyqND4fXSFuyjABc1ynTtCAzRkox1p2c4KxB5KZZOveD6DU
         mDCw==
X-Gm-Message-State: AOAM532XFrYby0db4rTeJpCGn8DdbXNMOXQ5QZUPnPbzOOd1iYDmg78K
        kME+1BkXKv25KhKVgmSzgrY=
X-Google-Smtp-Source: ABdhPJy+LQy1wUCc8O7/Z4OinaXLemyfNuOADTKyuGtccEEsuYp/Oz/ZVYay1e3eSzVONliWIhB64Q==
X-Received: by 2002:a05:6402:27ce:: with SMTP id c14mr17354209ede.263.1617972421748;
        Fri, 09 Apr 2021 05:47:01 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id fs21sm1160748ejc.111.2021.04.09.05.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:47:00 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:47:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/2] pwm: sti: Free resources only after pwmchip_remove()
Message-ID: <YHBM6HYJyQ+tOQFn@orome.fritz.box>
References: <20210330123742.190540-1-u.kleine-koenig@pengutronix.de>
 <20210330123742.190540-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RBOIR8jEysdGtIaa"
Content-Disposition: inline
In-Reply-To: <20210330123742.190540-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--RBOIR8jEysdGtIaa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2021 at 02:37:42PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Before pwmchip_remove() returns the PWM is expected to be functional. So
> remove the pwmchip before disabling the clocks.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-sti.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--RBOIR8jEysdGtIaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwTOgACgkQ3SOs138+
s6EsWxAAjHjTVZdVXzATPbpN62e7ZifbtdSv+R7Z9HI90mRL81hXeh10i64ENJI5
tN5nljGIcrZIKT2JMiN1sMVbKOU+DZMekVn5k4EAvIQTaAIwm9AWwnypGE814QWv
rZgCKIGF+K6VAH6q6mkGN19sekl6ZIvmaPeb8L7jGwICoLhfmeN4CF7/Qnjxxj4q
WgSCtceuePXOONbE8qed3ryW9Hv5CIOq5qYbc5fF2fuOHdarhbnzJDrYemU3GIIG
7aBDhiuKP7W7CU13rFlv0kODbocK99OaCJwtTBI0RFE47cPwicOd6+136Ztw8Zzq
7Jj64/UGLdsFTy4HMztBHwcO5nlgYrC/uhw0Pd5ju1hPVxU4UCaiedI6npS72tz3
z3G37aMlpCZnIW2GBsccScczrRXhwxKdLOqdtJwNPJjYP4EAW6IuLcHKzJST/lHr
sRBvOpe0Df4xSo/tUqcTfWHwrLFvRqLUmbhdCHUPXoGfGbK/aBY1U9Ni1q87GufK
XLkmWGrS5PHnujZpavIKH6/PFZVdKVVVS9Mu2XehkCDuWGSqBmkfgv7ADhjP/yT8
V+lWPqedeYHMQD8gOrmWH/+qbkRWL98jiyN0RRizYqnauWVi2jzbA0wBewN78yb2
I4sEzL4lOBnDLzlQBgPGAEkNbx0RrMotKREB0/SRuZjnUXrxkfE=
=xU/h
-----END PGP SIGNATURE-----

--RBOIR8jEysdGtIaa--
