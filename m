Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C55F16A988
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2020 16:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgBXPM6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Feb 2020 10:12:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36285 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBXPM6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Feb 2020 10:12:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so9796941wma.1;
        Mon, 24 Feb 2020 07:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gnZbIHP1FiG4btjTXRKiUHIKc8RUvypNGZo2FLgFV/4=;
        b=e/go7qa32ZdX4cc+CxDab7Bm7aY4iwstUWnVY48pNXeX5189cQAoMKsAwlJ7LQxyt3
         qfKF2LBp5JkxBvarSJmK8cqRuJJHmSp0Mi3PhpMVWwrOokDZCpRaHUIdu67w7bvqGp35
         Jrkal7Qj+lXOqtsA6WWB+AH3U+119IG9qEW07/jb0jKr+abkFfH4biAxCTKV/fiMqPBp
         YdX09+8/TLyy29nfZJov0gzXWF8Syv3hTSTjJBhUpbL6sfHinQPo9gd15Ks9B9KF96xo
         GuAy7+DV6KLhmKSJTmALk8wH5M5UNHf32zxbww2NjJXGg/GfJxT1mMJ2Gq4WS57+eQW2
         0+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gnZbIHP1FiG4btjTXRKiUHIKc8RUvypNGZo2FLgFV/4=;
        b=Fnc5yRFchbAeCfXRRCdB/xAvscLWweoRGyGtWxRbZuXIv7k6Cgd+OwCEWqo8/oUGD+
         4k92HllBk88wxB0AYc6xBiznRZbnjsmDmXubK4AssNuPAOB0OM127h9/IgpShH+HAOit
         DwQwx06+pPUvIwtgzfZXRTMTuNC3GPInXjR7qZntP5QsY4Ekge2gi8ncp7Z9obwicpxa
         mva8ft+ONvtDxf/gYBIr/LXPKxlZVKv515grbckqEHjxC0+MessXfrTnmA2FrPgB0soo
         PvlAoeYqjbslcC9GQCpglGBB0ahuaQxJW54mYE6ikGsCLayVHIuk+DmH7alH3x46upJ+
         wLXA==
X-Gm-Message-State: APjAAAUxn4xfDHKO5nKZ/BkdLU8nvy4UeEl/gguI+LQkTB0oidvZG+up
        Ya4MbCTmlPsC+MUnOeKN1os=
X-Google-Smtp-Source: APXvYqwfFWI+BQvS6TR7EcjPyz80WZgjScVqfiQjb3eIsHUvDGvzae5fd0WZcynsnvs/JAP6sI5Fwg==
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr22994395wmi.61.1582557176474;
        Mon, 24 Feb 2020 07:12:56 -0800 (PST)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id k16sm19433486wru.0.2020.02.24.07.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:12:55 -0800 (PST)
Date:   Mon, 24 Feb 2020 16:12:54 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] regulator: pwm: Don't warn on probe deferral
Message-ID: <20200224151254.GB2570205@ulmo>
References: <20200224144048.6587-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20200224144048.6587-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 02:40:48PM +0000, Jon Hunter wrote:
> Deferred probe is an expected return value for devm_pwm_get(). Given
> that the driver deals with it properly, there's no need to output a
> warning that may potentially confuse users.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/regulator/pwm-regulator.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5T5/YACgkQ3SOs138+
s6F1tA//XZ0O/MXj5NzYNLezzQBOO9AP+EWE7TGAMZi9h9OgaOiydAtBEKusD2ds
Wnkcuo+5xB/9HDTlLSLgsLbAtCfaxbKXJOnMiXkghKaBH1K6BSbKAGZWncgDKz8s
c6mFgFAhUyVDxY7UHz06cqrtJ3sM2HZbsTVXA4RMC5GZDx79TR17NWAchdMOMwKt
OAWjCFP44ycFN2yq7qwjYn3tEs9fvKMPR0Yrj233ExjadK6f8VltEGG0kWWtxRIy
clbiI1qBTiDs5Z6NdSGD/ma0XmVUy258KlQ3pljJhaE8S8SxOWgTCd+UpgXZtlWD
mW9kqwMrWPpbw5Wtn2P89RL+pinUWGz05HFQPNqBbakRELqcvIRKxfyZfR+gdIjl
u+DaYU9dtk83VJZc3fwt7gMcCLpm56LhgxYmIkWRe50DHuq0s7aQklmDVZmaHv6x
rw8kv+rca3NFQPgbivAHASGOsqqHzTB7QgHZ0T+51PJPMOaQ7SjWBZMn4s/Dgco1
CUtFUPyI8N+MEE0FcLe1k7N2oqbrOr5e9ASpOYccbmkIBVNApNJrydhVWFI3ZE8W
tUj6tyfqDn3PnpTw2JtjZYNLJUyccpn/RXqXi5+rHPgSVD7b611D7SBSOSR5YyvC
k5TWAbjhI230BT9eBRYkO/vCNA2JPwd4HGZZY9Qc6tfPFvx5778=
=mAqf
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
