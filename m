Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57516027BD
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Oct 2022 11:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJRJAY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Oct 2022 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiJRJAA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Oct 2022 05:00:00 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5C5F5
        for <linux-pwm@vger.kernel.org>; Tue, 18 Oct 2022 01:59:58 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 74D523F133
        for <linux-pwm@vger.kernel.org>; Tue, 18 Oct 2022 08:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666083596;
        bh=rsJY6FOVKsSZqaiC4n0rKD5tmA7MRY+EAjtb8qwOqtw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CFT5D1tpM72SRqO01Ib+VGP+Ct+afYPXhi9eW847BMfN/Bby0SGTJHb9qvp0BrALj
         aBQ/luZSs5YfATGJpyywMNbtTZ90rUzIsgFRMm2wZDvVLfHXXO1oSJaevtTZZMAw8Q
         TFv81serHH+Vc715r0e8CkgSH3/VWWA7boijvSrdAZLv8ZR9tg2rmRVaZN1sa5PqM7
         O9ChOMp2zCdEj10cfDTbt2/q2V54UgU8VD0iQGbdCYoYMj50SYZFN+8IjkfRvj4u9D
         82yuw/W4AELZ5fzqrpjqTfuWSUZLb0WUYWtoKvw9zRDgz8sqre/LtF6FUNusfkVcbH
         nU/y3PnkZv6tg==
Received: by mail-ed1-f69.google.com with SMTP id y14-20020a056402270e00b0045d1baf4951so9078154edd.11
        for <linux-pwm@vger.kernel.org>; Tue, 18 Oct 2022 01:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsJY6FOVKsSZqaiC4n0rKD5tmA7MRY+EAjtb8qwOqtw=;
        b=EUWFcPwBA2LumB8j3ool8dZeR14LRDvqmw4IM5sYX92tSw/8oCWueAr2xWGC3hWPl/
         58dY2Ze27vy6KIh+nJGXXpvd8bgQ184RMyEL79n1u2CxQ3qhI11kp8bbThppfMTSfaO1
         N/qmOA2ZW5AeMnH0U7wruo/S3nmKEShUKri2wZHXGaK3ZartQGRO0xZ9K981HIkE086p
         4Wfhe8BeIBomWTtXglURqV1N7/hQWNZt8aVynvupIcmqhtkntX7F8XIJAt99w2BWo4Pk
         Eh+AxQ/hO0M4rkj2ArZjhy0wvC6I3PSqlMbKWYcoMUFeY0uza84y0r28dFp077Vz1yuo
         rDHQ==
X-Gm-Message-State: ACrzQf2WXHdEx0xBohcZkTub6RcoWFbXZTDPOMJq92v0wnI9EmoK+w+H
        3S22DzclWG4ToC031oL4Zr4kOcFdE90OuJZ68V+84BoP1L/Opzq2g6t+oSKGdE95Yl2Y2KKszdA
        P93ZJJI7sujfeybIFhGGGT7c3kmP6RhPK6o8Tdw==
X-Received: by 2002:a17:906:5dce:b0:78d:e71a:6e0 with SMTP id p14-20020a1709065dce00b0078de71a06e0mr1547547ejv.360.1666083594752;
        Tue, 18 Oct 2022 01:59:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5K4MaqQNlIDzfCG5+7V36kXaIPiEcFutHEtHExpdX4evBO0X1ZQHZCnCeIFP7LhslGKZ6dtQ==
X-Received: by 2002:a17:906:5dce:b0:78d:e71a:6e0 with SMTP id p14-20020a1709065dce00b0078de71a06e0mr1547537ejv.360.1666083594531;
        Tue, 18 Oct 2022 01:59:54 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b007877ad05b32sm7115765ejf.208.2022.10.18.01.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 01:59:54 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: sifive: Call pwm_sifive_update_clock() while mutex is held
Date:   Tue, 18 Oct 2022 10:59:52 +0200
Message-Id: <20221018085953.414433-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221018061656.1428111-1-u.kleine-koenig@pengutronix.de>
References: <20221018061656.1428111-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> As was documented in commit 0f02f491b786 ("pwm: sifive: Reduce time the=0D
> controller lock is held") a caller of pwm_sifive_update_clock() must=0D
> hold the mutex. So fix pwm_sifive_clock_notifier() to grab the lock.=0D
> =0D
> While this necessity was only documented later, the race exists since=0D
> the driver was introduced.=0D
> =0D
> Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")=0D
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=0D
=0D
Thanks, as discussed on IRC:=0D
Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>=0D
=0D
..and you can also add my=0D
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>=0D
=0D
/Emil=0D
=0D
> ---=0D
>  drivers/pwm/pwm-sifive.c | 5 ++++-=0D
>  1 file changed, 4 insertions(+), 1 deletion(-)=0D
> =0D
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c=0D
> index 2d4fa5e5fdd4..bb7239313401 100644=0D
> --- a/drivers/pwm/pwm-sifive.c=0D
> +++ b/drivers/pwm/pwm-sifive.c=0D
> @@ -204,8 +204,11 @@ static int pwm_sifive_clock_notifier(struct notifier=
_block *nb,=0D
>  	struct pwm_sifive_ddata *ddata =3D=0D
>  		container_of(nb, struct pwm_sifive_ddata, notifier);=0D
>  =0D
> -	if (event =3D=3D POST_RATE_CHANGE)=0D
> +	if (event =3D=3D POST_RATE_CHANGE) {=0D
> +		mutex_lock(&ddata->lock);=0D
>  		pwm_sifive_update_clock(ddata, ndata->new_rate);=0D
> +		mutex_unlock(&ddata->lock);=0D
> +	}=0D
>  =0D
>  	return NOTIFY_OK;=0D
>  }=0D
> =0D
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780=0D
> =0D
> -- =0D
> 2.37.2=0D
