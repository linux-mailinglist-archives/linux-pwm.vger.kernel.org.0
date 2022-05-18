Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146A252B30B
	for <lists+linux-pwm@lfdr.de>; Wed, 18 May 2022 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiERHI6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 May 2022 03:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiERHI5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 May 2022 03:08:57 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5EC9EE0
        for <linux-pwm@vger.kernel.org>; Wed, 18 May 2022 00:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652857735; x=1684393735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XxodEPq4apJNQRcmWLej10wuPRNSFfakN2r+8qKkHvA=;
  b=hQgaqRj0f4coW3se//nF3xtTPQ5RFo9/fdTGnlQg8YBR3MxhJzDzik/X
   vCIO4nd3sBcIs2CrLh21Ti2dfgkzDRdxmnpi9daKJGbC2LmLsmNEv9ZlQ
   9rU8v6Te8QYI5OjlbUOcdS3G3yPaSN5b9LHWV4o/F11qy5NUn/KN41iYL
   Sol6vLXrcboJzVxSEX99Q0G0w+/LN80+JBDAevLe2P0wDFlryGCpMHAmv
   RbR6IzIIwvFbFtjKsG1GfVD/ZaIFwd1xTPRWZg5RFi5gqXM4PwI2Q/Xeb
   JXTLbnz64/ByHF8i5a5v2+3ZgKfQDer/1jLBEPvIkXIm6/zRsgMF3GdUT
   A==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647298800"; 
   d="scan'208";a="23938113"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 May 2022 09:08:53 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 18 May 2022 09:08:53 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 18 May 2022 09:08:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652857733; x=1684393733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XxodEPq4apJNQRcmWLej10wuPRNSFfakN2r+8qKkHvA=;
  b=UdGPJjnygerLBSKvZyH2rNmbNOtl7FhlbOfIKW1OWJWOeflG1UioYFEb
   rXwBNMwBkIbl8klsyUlh4oJ/Rb+peTuNfywiQheCJ9XdDZpNP1DjdeYAe
   Zki5ZrASKiZjghZ1QtQZcWGhcQ77kbJC8JkUDfDLU7gMYwcgaa7RMVwYF
   j8v9V/knoMA8HaquM4XxR3R2yzkG8DZjFcODoAYgvUtp//DzCw1PNPRGG
   VlmM7bUFy/NYEvZmCEZdQzEJEKlkx0qnP4iR26z2IaJHE/eNsko0Rwb27
   0eXjbD/iOfnVlkrFO9rtxi4IwPfTFAzkP1oHjK0Z5wQUHA5kxDPzyo8Fi
   w==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647298800"; 
   d="scan'208";a="23938111"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 May 2022 09:08:53 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 43515280070;
        Wed, 18 May 2022 09:08:53 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: (EXT) [PATCH] pwm: Document that the pinstate of a disabled PWM isn't reliable
Date:   Wed, 18 May 2022 09:08:50 +0200
Message-ID: <5725729.MhkbZ0Pkbq@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220517150555.404363-1-u.kleine-koenig@pengutronix.de>
References: <20220517150555.404363-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am Dienstag, 17. Mai 2022, 17:05:55 CEST schrieb Uwe Kleine-K=F6nig:
> Some (most?) drivers emit the inactive state when the PWM is disabled.
> However there are exceptions, so document that a consumer better doesn't
> depend on this behaviour.
>=20
> Some known exceptions:
>=20
>   - imx27 emits 0 independent of the configured polarity
>   - mxs just drives the output to the last emitted state.
>   - iqs620a makes the output tristated on disable, so an external
>     pull-down would be required.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/driver-api/pwm.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/driver-api/pwm.rst
> b/Documentation/driver-api/pwm.rst index ccb06e485756..fd26c3d895b6 100644
> --- a/Documentation/driver-api/pwm.rst
> +++ b/Documentation/driver-api/pwm.rst
> @@ -49,6 +49,12 @@ After being requested, a PWM has to be configured usin=
g::
>=20
>  This API controls both the PWM period/duty_cycle config and the
>  enable/disable state.
> +
> +As a consumer, don't rely on the output's state for a disabled PWM. If i=
t's
> +easily possible, drivers are supposed to emit the inactive state, but so=
me
> +drivers cannot. If you rely on getting the inactive state, use
> .duty_cycle=3D0, +.enabled=3Dtrue.
> +
>  There is also a usage_power setting: If set, the PWM driver is only
> required to maintain the power output but has more freedom regarding sign=
al
> form. If supported by the driver, the signal can be optimized, for example
> to improve

Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>



