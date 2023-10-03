Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8237B6D41
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Oct 2023 17:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjJCPfv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Oct 2023 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjJCPfu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Oct 2023 11:35:50 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2270DCC
        for <linux-pwm@vger.kernel.org>; Tue,  3 Oct 2023 08:35:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BE9CB381;
        Tue,  3 Oct 2023 15:35:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BE9CB381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696347346; bh=O8OXFEzOWi8Ea+8P4dtfyOUhqZkhpx9cd9kQL8AUTwA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=a1NAlf1nkwIESo2vNDbkswP/LStDIO8uR+JbcmeauzMpJxHXWMgn213Y2++3Hu2JR
         Yd+gv2C1Fv6lsfGXNKtustLDr9tQuyS8i0bV76s8RNRRtCaqUOpWM+6SwswRAuloqr
         XJFpzXGtU8GfY3A9HDOFY7k8uiGSahjpWOyZcpnypgXjO/M6zkzd35Uoy445VfTszs
         AC5Gx9jzJV1oH1qyFop28n16UwbNIGs3Vvwmk+uELZC7q/tJz1d6jFnvXlqKun2UEa
         tEUIE97VtE4eC05AYSYcnMmOJwx1oJMulN58Ob3jwn/fmHN5drF56a3c2TR5Fi0jQk
         ucCh4Ip/Yf9eA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Jens Gehrlein <J.Gehrlein@eckelmann.de>,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Adapt sysfs API documentation to reality
In-Reply-To: <20230911154454.675057-1-u.kleine-koenig@pengutronix.de>
References: <20230911154454.675057-1-u.kleine-koenig@pengutronix.de>
Date:   Tue, 03 Oct 2023 09:35:46 -0600
Message-ID: <87ttr7en1p.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> Most low-level PWM drivers support duty_cycle =3D=3D period, and so does =
the
> sysfs API. Also polarity can be changed for enabled PWMs since commit
> 39100ceea79f ("pwm: Switch to the atomic API").
>
> Reported-by: Jens Gehrlein <J.Gehrlein@eckelmann.de>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/driver-api/pwm.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/=
pwm.rst
> index 3fdc95f7a1d1..bb264490a87a 100644
> --- a/Documentation/driver-api/pwm.rst
> +++ b/Documentation/driver-api/pwm.rst
> @@ -111,13 +111,13 @@ channel that was exported. The following properties=
 will then be available:
>=20=20
>    duty_cycle
>      The active time of the PWM signal (read/write).
> -    Value is in nanoseconds and must be less than the period.
> +    Value is in nanoseconds and must be less than or equal to the period.
>=20=20
>    polarity
>      Changes the polarity of the PWM signal (read/write).
>      Writes to this property only work if the PWM chip supports changing
> -    the polarity. The polarity can only be changed if the PWM is not
> -    enabled. Value is the string "normal" or "inversed".
> +    the polarity.
> +    Value is the string "normal" or "inversed".

I don't see this in linux-next yet, so I've gone ahead and applied it.

Thanks,

jon
