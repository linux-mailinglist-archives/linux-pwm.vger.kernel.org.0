Return-Path: <linux-pwm+bounces-7918-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB3FD30917
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jan 2026 12:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 329EA30AB17F
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jan 2026 11:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A15E379990;
	Fri, 16 Jan 2026 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTSpyPE/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4497C379983
	for <linux-pwm@vger.kernel.org>; Fri, 16 Jan 2026 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563566; cv=none; b=oQyQtTEQ1SwSHxhpqMKI5URMaVVnWYmqcBVVl6Ik8+MDBirs37slVt7ajOODGp1ENg5ITVEdKZHmXHw0lF/82v8iDHuO7YxmI6D1vGntW0QfjN0h/KQxoysJqlyhuimz/R4k/yCqte5uyKyvANDYQxpLSPOwkNbbFxhcRt23FFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563566; c=relaxed/simple;
	bh=CXQQOwA/eEzIPCuqAzSZiZzBLITSZmnC2lVuqjTxJ44=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9mAePcIvmy6iArcuRkvLCAFDzohlRh2oISmHl0CZmNOWqy+iB+eQcR6/1SfMWX7JNjWwRcohCUKezZs5uuIFwFu2ElIF7vnUe6MTNujgDoFmy2SYARy/ukGbADFPo/TSgsAJlo0989cTWYPlrf9hfNeI+zq/l3FukmOoTwReiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTSpyPE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6B6C19421
	for <linux-pwm@vger.kernel.org>; Fri, 16 Jan 2026 11:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768563566;
	bh=CXQQOwA/eEzIPCuqAzSZiZzBLITSZmnC2lVuqjTxJ44=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=GTSpyPE/Z0vG+qpaXeXy6xpn7K7Sel0/nS09s97bvXm2kNNLtDTsH2pbf4enpXt4+
	 Ihq8tuLMT94C7OHsaobf/d4MONtHzF31/L2V5l10aElB3gvuXInX+43H2PjneqKiUH
	 iCOS09YrSMa9I+KRHId2J3/sKKSmQ3wXytxNh1BRdZyUm3qpQJIA+/1chQSY/rg504
	 h1bzqCawKa1rueYaMOrAuRVKiTd2rbqUeA635KB7VRQccL/77p1mrgoGPxkEUPPPav
	 QOnfaRaTtjdKO/bGLT++ns8/mUwf54h0aOGPsuZNQziY2RCo1C0vmsSSc93UmRp+qv
	 uLi41fqEGVSpQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59b6f04cae6so1995413e87.2
        for <linux-pwm@vger.kernel.org>; Fri, 16 Jan 2026 03:39:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAEznJL3qLo/bWE7+noNEO3IB4P3gqEVIyhUDLJDjnGvFSJUpo8fiHdSWhRxxyb5flet6ZArTPNFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvrGnyD52T6/a9uT4JWAdvwVJt3w7d2zfr0fXqEAZD/72AOxOo
	dRzX80JmP2LQ6YBMvyIuw3rSk+x6pvkF+4yUo8wiU2ZyQfeRtJLCz4QDawc1OCEX4pTTLt4tayo
	fKCNq3TDcQNFa8Lq1oKuK2eNvANyQ/+ron5q0rvfMiQ==
X-Received: by 2002:a05:6512:3192:b0:59b:6ff4:195a with SMTP id
 2adb3069b0e04-59baef0063fmr793808e87.43.1768563564596; Fri, 16 Jan 2026
 03:39:24 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Jan 2026 11:39:22 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Jan 2026 11:39:22 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260115165055.1739004-2-ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115165055.1739004-2-ukleinek@kernel.org>
Date: Fri, 16 Jan 2026 11:39:22 +0000
X-Gmail-Original-Message-ID: <CAMRc=MeZmROA5E+X0eHXnFuDqG+fiRBddJFCS3kRndJ+sZLuag@mail.gmail.com>
X-Gm-Features: AZwV_QgHn3Bgp42Zs07ODYXzLhE6d627qXzY16pFTZhBrCnGBRlTiCDDTXaHCms
Message-ID: <CAMRc=MeZmROA5E+X0eHXnFuDqG+fiRBddJFCS3kRndJ+sZLuag@mail.gmail.com>
Subject: Re: [PATCH] pwm: Update MAINTAINER entry
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jan 2026 17:50:54 +0100, "Uwe Kleine-K=C3=B6nig"
<ukleinek@kernel.org> said:
> There is little sense in having gpio-mvebu and pwm-backlight explicitly
> listed in the PWM entry. Drop these and add the keywords that actually
> identify a driver as PWM related.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> ---
>  MAINTAINERS | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..1ab3b6a2c29b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21070,16 +21070,14 @@ L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.gi=
t
> -F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
>  F:	Documentation/devicetree/bindings/pwm/
>  F:	Documentation/driver-api/pwm.rst
> -F:	drivers/gpio/gpio-mvebu.c
>  F:	drivers/pwm/
> -F:	drivers/video/backlight/pwm_bl.c
>  F:	include/dt-bindings/pwm/
>  F:	include/linux/pwm.h
> -F:	include/linux/pwm_backlight.h
>  K:	pwm_(config|apply_might_sleep|apply_atomic|ops)
> +K:	(devm_)?pwmchip_(add|alloc|remove)
> +K:	pwm_(round|get|set)_waveform
>
>  PWM SUBSYSTEM BINDINGS [RUST]
>  M:	Michal Wilczynski <m.wilczynski@samsung.com>
>
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> --
> 2.47.3
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

