Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A7F2AF993
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 21:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgKKUMc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 15:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKUMc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 15:12:32 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F53C0613D1;
        Wed, 11 Nov 2020 12:12:32 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so3765279wrx.5;
        Wed, 11 Nov 2020 12:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F7AKQnS/USiMmoeHPSK9/AG/hMH5sRwDB1LYC95VaV0=;
        b=WBFn3M3gsXz+myqgSRvR+Xh0vzo3h+nm+pSDbvSyBTEm5KUh9soCZVmhtsy9LOhq3x
         1yPTlBFTSGT4tTIDWL94SV2WarUIsU8k8OccKfKLvYAkjTH6b5Ucqd26nSMNG8RbCNh3
         FDIqmKUVYa0MdIs0/s9wtPSuOSkZn0riu9dzr4hUI4lY5sgqajHazh8uO40Cd3g60QCQ
         ZipweSOUKgaIge1PBdSPKM7Yfhbz6Fjg7NfyzFmUcrjcs0Pd5Xe/scVM4OyMdnT6+rnU
         9cOK+4M8PORSgsbBjlvexbYur66shtARcESIANsjqMZdX/9dIC/ugUfwt2R2qPAVdrOQ
         wAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F7AKQnS/USiMmoeHPSK9/AG/hMH5sRwDB1LYC95VaV0=;
        b=I0qK+mwr6yI/eOYIO42xeG250pJ1nIsvOSKKcQVgO4Ekeu3VhulLCbg1IyiBC+FnRz
         /9QLO5h+JttsOHM7mdNXVYPjo3BixXldcabHUQ9D4LVu3Dnqq3atdbVRQp4ZigI+s7iB
         DLqkgGzLis43CtD5k7mi8JVtt9Jr4s+eHflRJDNyISddQN3Em/dKbGYMlYKIPZhy8kEm
         Sa+KevKFzxTjmoXSKwf4z5wycfdBLYeKTxEx2O9zpoaRv1nOCuuA2f3AxodOlYnu53Kb
         syHnRLzSZ8QLC9RL6YohLuO/URDDrknqMB23gOuQyGuffFOyFk2t4QdBzj8diZ76xGf1
         06gw==
X-Gm-Message-State: AOAM531wymKFqHIxyW905e+dpwCQtp3U5WP86VPrYDxLjc2R9XXSgIVd
        NIJKoxsEINAoodX9OT32ImgH219aZ3Q=
X-Google-Smtp-Source: ABdhPJw6cMu90IqqINQAf+KGfdYbYf/pQsdQVqpwJdz+NlcNKrlwYeMEGTf+ULXm7bJDFg1OHoONKQ==
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr31457501wrt.244.1605125550909;
        Wed, 11 Nov 2020 12:12:30 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id y16sm3364397wrt.25.2020.11.11.12.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:12:29 -0800 (PST)
Date:   Wed, 11 Nov 2020 21:12:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] pwm: lp3943: Dynamically allocate pwm chip base
Message-ID: <20201111201227.GJ6125@ulmo>
References: <20201030134135.28730-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5cSRzy0VGBWAML+b"
Content-Disposition: inline
In-Reply-To: <20201030134135.28730-1-lokeshvutla@ti.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5cSRzy0VGBWAML+b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 07:11:35PM +0530, Lokesh Vutla wrote:
> When there are other pwm controllers enabled along with pwm-lp3943,
> pwm-lp3942 is failing to probe with -EEXIST error. This is because
> other pwm controller is probed first and assigned pwmchip 0 and
> pwm-lp3943 is requesting for 0 again. In order to avoid this, assign the
> chip base with -1, so that id is dynamically allocated.
>=20
> Fixes: af66b3c0934e ("pwm: Add LP3943 PWM driver")
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  drivers/pwm/pwm-lp3943.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--5cSRzy0VGBWAML+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sRasACgkQ3SOs138+
s6EA0A//aBd9sU58jvIjRrNEWYcibPTj/Szyp+xrYw1XjmCm3vwWVTH1nwcAT3+6
5ac228oAshC3zsALkDg0brhgZqQLTk22BSEd+Z6b8P14vKAzT+N+z+fsiu0xYbzU
Wr2JKyoB74vt3utb2YGSwCmECKP9tB8dWcntUN/LDHKT/VPfFqngcoLNL8lr9BX4
9Xq/uvcR/QL8+J/YcuWK6LQxAW+zhCJhpj/XS70oBlLPgEPm7ZPFkydr17qgWhMo
P5xfNfnWyUSSmmW+Ephl1BHXMUHR+nIOFApET/w0SxtWXi7mHv+ECOHUNQb10iTi
/Aoy2n0ajlZQ1dE5QaeAHX+47+RnIyS8OoGw2ZnEB1Sl2bH6Mr1tFJotU0JAUOK5
3EQgHY1Id22EsffQNNFGTC0Mm7fVFmoHEe1vJ6AzXv7RI3e8W/7SY/IUYQ5RdwzU
4ENutUmLkC0WNXOIhjv7NtBfNFbCRCUXEBBXAPNLZLyQIHpIvPVuR9B3Z8nAxR2n
9edST3QHUC1sWhDVp+cJGRrNGZ6YrP8QAja2BEr6b9gXOzz168LRefrToUZEDd9k
/bFzrWB/YxlUgD1ZXPgJ7z3jHNTH5ed1oAWioe1rAuMHC60gcthKeRHJMeIW/w3l
pLF7tmAFXaH9U/b7mSh1FSDtKcq/e+qP5UMq6C6bYtnA51RJrTI=
=yWn6
-----END PGP SIGNATURE-----

--5cSRzy0VGBWAML+b--
