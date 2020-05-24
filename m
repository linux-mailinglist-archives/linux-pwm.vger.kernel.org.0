Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9393E1E0078
	for <lists+linux-pwm@lfdr.de>; Sun, 24 May 2020 18:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgEXQQ5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 May 2020 12:16:57 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45894 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgEXQQ4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 May 2020 12:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1590337014; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emIfzJZcNlvletQ+S8SsbsemNtmnNe6LxmjxeswycGc=;
        b=RcBKGvOCYyL/YKWkBbJ40CA3Pm8hVojb5eak7HU2IRErkloU7Yh0aHBVdUHn1dHOAbqXat
        QL/B43wLlMt6SvAglXvMxAOK1e5zjT2wewsZnUOK83jni8AD5FStrK9XlS8vDVCJaPLiCd
        a4L6xhvU92/w/NZWo4DCXOVr8x3Qxuo=
Date:   Sun, 24 May 2020 18:16:44 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] pwm: jz4740: Drop dependency on MACH_INGENIC
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <WVFUAQ.BITRQ3YW6GKI@crapouillou.net>
In-Reply-To: <20200413121445.72996-1-paul@crapouillou.net>
References: <20200413121445.72996-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Any feedback on this patchset?

Cheers,
-Paul


Le lun. 13 avril 2020 =E0 14:14, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> Depending on MACH_INGENIC prevent us from creating a generic kernel=20
> that
> works on more than one MIPS board. Instead, we just depend on MIPS=20
> being
> set.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index eebbc917ac97..7814e5b2cad7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -234,7 +234,7 @@ config PWM_IMX_TPM
>=20
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
> -	depends on MACH_INGENIC
> +	depends on MIPS
>  	depends on COMMON_CLK
>  	select MFD_SYSCON
>  	help
> --
> 2.25.1
>=20


