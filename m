Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169AD88525
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 23:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfHIVlH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 17:41:07 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38168 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHIVlH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 17:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565386864; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MqvMWi6bGElHL7UoyZd9oBNxDJqpMVxG2HIbZaBBGmc=;
        b=mmukrfnP68b29AvzmDRP/RS81Heh9NQAcjG4CJVqNKHWaPZ+Hkuk3RPMGQ+x6oZWLuUs6p
        0RaIFBl7h8gh+1buPrmnYnhOicfwFrzeLal3OSB79Xw8tlywFmWAgt34eR0LMnYuTt5QgN
        BIhGHW4IhW4g2P6nYNz4c4N6cclWG0w=
Date:   Fri, 09 Aug 2019 23:40:59 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/7] pwm: jz4740: Drop dependency on MACH_INGENIC
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1565386860.2091.5@crapouillou.net>
In-Reply-To: <20190809164143.2p573g7wlx43hero@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
        <20190809123031.24219-4-paul@crapouillou.net>
        <20190809164143.2p573g7wlx43hero@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Le ven. 9 ao=FBt 2019 =E0 18:41, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> On Fri, Aug 09, 2019 at 02:30:27PM +0200, Paul Cercueil wrote:
>>  Depending on MACH_INGENIC prevent us from creating a generic kernel=20
>> that
>>  works on more than one MIPS board. Instead, we just depend on MIPS=20
>> being
>>  set.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/pwm/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>>  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>  index d2557c6fcf65..82a75e0b72e5 100644
>>  --- a/drivers/pwm/Kconfig
>>  +++ b/drivers/pwm/Kconfig
>>  @@ -224,7 +224,7 @@ config PWM_IMX_TPM
>>=20
>>   config PWM_JZ4740
>>   	tristate "Ingenic JZ47xx PWM support"
>>  -	depends on MACH_INGENIC
>>  +	depends on MIPS
>=20
> If this isn't actually useful on MIPS without MACH_INGENIC this is
> better expressed using:
>=20
> 	depends on MIPS
> 	depends on MACH_INGENIC || COMPILE_TEST
>=20
> This way some configuring a mips kernel without INGENIC isn't bothered
> by this question.

As said in the commit message, it is useful on MIPS without=20
MACH_INGENIC,
if you want to create a generic kernel that works on more than one MIPS
board.


> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |

=

