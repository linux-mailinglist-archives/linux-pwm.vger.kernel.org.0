Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CED1EBC05
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2020 14:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgFBMsC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 08:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMsC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 08:48:02 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E68C061A0E;
        Tue,  2 Jun 2020 05:48:01 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w7so6294595edt.1;
        Tue, 02 Jun 2020 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yf4GXAhEWn+sWFUgRmxvX5UkbgRsnK6CDYcGHL39uUU=;
        b=tHuHJ+gtmpVUv5nKezqAI3B3fgx2P1v6opMTGb6Z6CQHHePqzNFdea0SIogb6aPN3Y
         ZWqRLmLKpsbGDCXY/SIxVtcU0BZjdOMGT8u5VLnQBkoO04uCozfZGlJLrVkqWyxUW5W3
         xKdKeOQQxJtiL033ZG8U0xrq2d7QE4gdvTB6vBo89nJ8U3yMjTJnMPFvKBFjlXvRqny6
         8b3TiYI7PLAsPUPayF4Qe/4gGbFMu36q5YPnl7EvEX9J3SSS9Mau7HqWZBk7fZ9VWjxy
         KM7anBc/SXUEc28F1/I/eF1YKEBrvqIZsE/AzEBFn4En6922ts9t4WM+VGjAIVwLfLGl
         425g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yf4GXAhEWn+sWFUgRmxvX5UkbgRsnK6CDYcGHL39uUU=;
        b=RJP3H2hiKzmqjOt/5qdCYi+INISmvq2tt7SVPQsvtJKuhXdJONIa4PsBZlJcGYqejj
         fix0s5IynL3Ea5B7vGA5KLQu7WAG+F5bHDq8iQ/FplIcKp3v/hB1pKOTtWDZL1vfpG5N
         P/NIZHrVTg2WmQqmC2+KuXV1zP7b7PSFuPR4AHhRmhcse2YvDMyhnX/okMkfQEOkuz87
         ESDiNEZ5T+yKcdk0sZymWzg802psNEttuVCoxBxBklLlBfff3Q14ioxRmF2d7GM0dFQH
         TvbX8/223J/TZ2ehXc5IwAqynB74lN1oEnkYzdMXN0Oxy5dmB/eMwTulrOt15XblT93y
         24ww==
X-Gm-Message-State: AOAM533lXjFM4A7OMUhYxrbyYN4t6JI/Io7TTOLan4HeJP9/QOgjogQX
        qQdq0Suh4MXpo6CbKKYUs3k=
X-Google-Smtp-Source: ABdhPJzLNH6sjpsVM2MZNCAKxy0ZLIgGrIFfO3a5ZPLwC/X1e/HaDzhllSyC6liBrnFy340xlskkuQ==
X-Received: by 2002:a50:af85:: with SMTP id h5mr18954583edd.86.1591102080350;
        Tue, 02 Jun 2020 05:48:00 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id u23sm1498694eds.73.2020.06.02.05.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 05:47:58 -0700 (PDT)
Date:   Tue, 2 Jun 2020 14:47:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com,
        u.kleine-koenig@pengutronix.de, bbasu@nvidia.com,
        ldewangan@nvidia.com, kyarlagadda@nvidia.com,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] pwm: tegra: dynamic clk freq configuration by PWM
 driver
Message-ID: <20200602124758.GE3360525@ulmo>
References: <1590988836-11308-1-git-send-email-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline
In-Reply-To: <1590988836-11308-1-git-send-email-spatra@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2020 at 10:50:36AM +0530, Sandipan Patra wrote:
> Added support for dynamic clock freq configuration in pwm kernel driver.
> Earlier the pwm driver used to cache boot time clock rate by pwm clock
> parent during probe. Hence dynamically changing pwm frequency was not
> possible for all the possible ranges. With this change, dynamic calculati=
on
> is enabled and it is able to set the requested period from sysfs knob
> provided the value is supported by clock source.
>=20
> Changes mainly have 2 parts:
>   - T186 and later chips [1]
>   - T210 and prior chips [2]
>=20
> For [1] - Changes implemented to set pwm period dynamically and
>           also checks added to allow only if requested period(ns) is
>           below or equals to higher range.
>=20
> For [2] - Only checks if the requested period(ns) is below or equals
>           to higher range defined by max clock limit. The limitation
>           in T210 or prior chips are due to the reason of having only
>           one pwm-controller supporting multiple channels. But later
>           chips have multiple pwm controller instances each having
> 	  single channel support.
>=20
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
> PATCH V4:
> 1. Code comments fixes
>=20
> PATCH V3:
> 1. Return -EINVAL if requested period does not fall inside limit.
> 2. Store the new clock rate for further references.
> 3. Variable name change reverted.
> 4. Comments corrected and new comments are added.
>=20
> PATCH V2:
> 1. Maximum frequency calculation is moved to probe.
> 2. Added descriptions for PWM register bits and functional behavior
>    of the controller when new configuration is applied.
> 3. Setting period with possible value when supplied period is below limit.
> 4. Corrected the earlier code comment:
>    plus 1 instead of minus 1 during pwm calculation
>=20
>  drivers/pwm/pwm-tegra.c | 80 +++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 76 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7WSn0ACgkQ3SOs138+
s6Gs2hAAuKnY8XRGX2cCIMv6LUK/mMn655EzVcw8MBN6IjTjqWgPbkQf590CXT0E
/YdjXLEMaijZhzvsffpkUZpRfQJkbmUqQ1fTLM1ag+6Y6NKWZrrz2XRE8HAmwjef
2Vz7qxFXPofe6KblDH6hdpMt0GiYgGKNr2SMPd/Mr8nGIcTFHjSz1J2jdXjHKi7d
3yrKgXH1/3YjjiYLuVqoritQlnwFVWELGargD4o7pDgu/9untwWLrCAVs7QH1ST2
6vZwChEsC9lHvg0GbA9Lz0QLXuFG89FDlpYGOnik96R3/8Lpq8hvXDlmn0ttJn6H
9SBzAWQpyMdz4GW0/a09o79YmzOLB4hH20du8s0nzB0i6QphMkZGjOeXNPkxHGU2
e2ga6dbvDFLHvN61xii91hMEwH1DvhL0uWgwwXmNq4Bsz205fjhubE6SptVQ6c6q
lNPh5JJuhKYyuWjRTWZyW8hx0VImqE89IAFkmLrEzeiasAPc/frvo3uCqrn46s+B
YouYpYk2STWRs9NiFTh5FRso86BSOovFqWS35DagLFcTHw7gGcbuzQMl3ZTfJKdQ
+29iq/Dx1U43IEA4YQj0zoGfnTglk+c/W91D69AicdbLVT5yScRpefmu9on654Lh
cjvAU1Yx5zgM5dXhdLw1dN5IVbcNIoR/rs4SmGORb4XpS0XKqyw=
=ZV5c
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
